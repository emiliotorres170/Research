"""
Description:
------------
244-coefficient truncated Volterra series ALES model static test program

Notes:
------
run `mpiexec -n 1 python ales244_static_test.py -h` for help

Authors:
--------
Colin Towery, colin.towery@colorado.edu

Turbulence and Energy Systems Laboratory
Department of Mechanical Engineering
University of Colorado Boulder
http://tesla.colorado.edu
https://github.com/teslacu/teslapy.git
https://github.com/teslacu/spectralLES.git
"""

from mpi4py import MPI
import numpy as np
import os
import sys
import time
from math import sqrt
import argparse
from spectralLES import spectralLES
from teslacu import mpiWriter
from teslacu.fft import rfft3, irfft3, shell_average
from teslacu.stats import psum
# import strainRateFunction

comm = MPI.COMM_WORLD


def timeofday():
    return time.strftime("%H:%M:%S")


###############################################################################
# Extend the spectralLES class
###############################################################################
class ales244_solver(spectralLES):
    """
    Just adding extra memory and the ales244 SGS model. By using the
    spectralLES class as a super-class and defining a subclass for each
    SGS model we want to test, spectralLES doesn't get cluttered with
    an excess of models over time.
    """

    # Class Constructor -------------------------------------------------------
    def __init__(self, comm, N, L, nu, epsilon, Gtype, **kwargs):
        """
        Empty Docstring!
        """

        super().__init__(comm, N, L, nu, epsilon, Gtype, **kwargs)

        self.tau_hat    = np.empty((6, *self.nnk), dtype=complex)
        self.UU_hat     = np.empty_like(self.tau_hat)
        self.tau        = np.empty((6, *self.nnx))   # subgrid stress
        self.Sij        = np.empty((6, *self.nnx), dtype=np.float64)

        self.k_test = 15
        self.test_filter = self.filter_kernel(self.k_test, Gtype)

    # Instance Methods --------------------------------------------------------
    def computeSource_ales244_SGS(self, H_244, **ignored):
        """
        h_ij Fortran column-major ordering:  11,12,13,22,23,33
        equivalent ordering for spectralLES: 22,21,20,11,10,00

        sparse tensor indexing for ales244_solver UU_hat and tau_hat:
        m == 0 -> ij == 22
        m == 1 -> ij == 21
        m == 2 -> ij == 20
        m == 3 -> ij == 11
        m == 4 -> ij == 10
        m == 5 -> ij == 00

        H_244 - ALES coefficients h_ij for 244-term Volterra series
                truncation. H_244.shape = (6, 244)
        """
        tau_hat = self.tau_hat
        W_hat = self.W_hat

        Uhat = np.empty((3, *self.nnx), dtype=np.float64)
        Uijhat = np.empty((6, *self.nnx), dtype=np.float64)
        SSijT = np.empty((6, *self.nnx), dtype=np.float64)
        Lij = np.empty((6, *self.nnx), dtype=np.float64)
        Mij = np.empty((6, *self.nnx), dtype=np.float64)
        Sijhat = np.empty((6, *self.nnx), dtype=np.float64)
        S = np.empty([*self.nnx], dtype=np.float64)
        Shat = np.empty([*self.nnx], dtype=np.float64)
        Cs2 = np.empty([*self.nnx],dtype=np.float64)
        LijMij = np.empty([*self.nnx],dtype=np.float64)
        MklMkl = np.empty([*self.nnx],dtype=np.float64)

        W_hat[:] = self.les_filter*self.U_hat
        irfft3(self.comm, W_hat[0], self.W[0])
        irfft3(self.comm, W_hat[1], self.W[1])
        irfft3(self.comm, W_hat[2], self.W[2])

        # Filter Velocities to find LES and Test filtered fields
        Uhat[2] = irfft3(comm,self.test_filter*rfft3(comm,self.W[2])).real
        Uhat[1] = irfft3(comm,self.test_filter*rfft3(comm,self.W[1])).real
        Uhat[0] = irfft3(comm,self.test_filter*rfft3(comm,self.W[0])).real

        Uijhat[0] = irfft3(comm,self.test_filter*rfft3(comm,self.W[2]*self.W[2])).real
        Uijhat[1] = irfft3(comm,self.test_filter*rfft3(comm,self.W[2]*self.W[1])).real
        Uijhat[2] = irfft3(comm,self.test_filter*rfft3(comm,self.W[2]*self.W[0])).real
        Uijhat[3] = irfft3(comm,self.test_filter*rfft3(comm,self.W[1]*self.W[1])).real
        Uijhat[4] = irfft3(comm,self.test_filter*rfft3(comm,self.W[1]*self.W[0])).real
        Uijhat[5] = irfft3(comm,self.test_filter*rfft3(comm,self.W[0]*self.W[0])).real

        Lij[0] = Uijhat[0] - Uhat[2] * Uhat[2]
        Lij[1] = Uijhat[1] - Uhat[2] * Uhat[1]
        Lij[2] = Uijhat[2] - Uhat[2] * Uhat[0]
        Lij[3] = Uijhat[3] - Uhat[1] * Uhat[1]
        Lij[4] = Uijhat[4] - Uhat[1] * Uhat[0]
        Lij[5] = Uijhat[5] - Uhat[0] * Uhat[0]

        # Scales
        deltl = self.dx[0]*2.0*np.pi/self.k_dealias
        deltt = self.dx[0]*2.0*np.pi/self.k_test

        self.Sij[0] = 0.5*irfft3(self.comm,1j*self.K[2]*W_hat[2] +   1j*self.K[2]*W_hat[2])
        self.Sij[1] = 0.5*irfft3(self.comm,1j*self.K[2]*W_hat[1] +   1j*self.K[1]*W_hat[2])
        self.Sij[2] = 0.5*irfft3(self.comm,1j*self.K[2]*W_hat[0] +   1j*self.K[0]*W_hat[2])
        self.Sij[3] = 0.5*irfft3(self.comm,1j*self.K[1]*W_hat[1] +   1j*self.K[1]*W_hat[1])
        self.Sij[4] = 0.5*irfft3(self.comm,1j*self.K[1]*W_hat[0] +   1j*self.K[0]*W_hat[1])
        self.Sij[5] = 0.5*irfft3(self.comm,1j*self.K[0]*W_hat[0] +   1j*self.K[0]*W_hat[0])

        # Sij hat
        Sijhat[0] = irfft3(comm,self.test_filter*rfft3(comm,self.Sij[0])).real
        Sijhat[1] = irfft3(comm,self.test_filter*rfft3(comm,self.Sij[1])).real
        Sijhat[2] = irfft3(comm,self.test_filter*rfft3(comm,self.Sij[2])).real
        Sijhat[3] = irfft3(comm,self.test_filter*rfft3(comm,self.Sij[3])).real
        Sijhat[4] = irfft3(comm,self.test_filter*rfft3(comm,self.Sij[4])).real
        Sijhat[5] = irfft3(comm,self.test_filter*rfft3(comm,self.Sij[5])).real

        # Sij = strainRateFunction.strainrate(self.U,Sij,self.nx[0],1,self.dx[0],1)
        # Sijhat = strainRateFunction.strainrate(Uhat,Sijhat,self.nx[0],1,self.dx[0],1)

        S = np.sqrt(2.0*(self.Sij[0]*self.Sij[0]+2.0*self.Sij[1]*self.Sij[1]+2.0*self.Sij[2]*self.Sij[2]+self.Sij[3]*self.Sij[3]+2.0*self.Sij[4]*self.Sij[4]
                         +self.Sij[5]*self.Sij[5]))
        Shat = np.sqrt(2.0*(Sijhat[0]*Sijhat[0]+2.0*Sijhat[1]*Sijhat[1]+2.0*Sijhat[2]*Sijhat[2]+Sijhat[3]*Sijhat[3]+
                            2.0*Sijhat[4]*Sijhat[4]+Sijhat[5]*Sijhat[5]))

        SSijT[0] = irfft3(comm,self.test_filter*rfft3(comm,S*self.Sij[0])).real
        SSijT[1] = irfft3(comm,self.test_filter*rfft3(comm,S*self.Sij[1])).real
        SSijT[2] = irfft3(comm,self.test_filter*rfft3(comm,S*self.Sij[2])).real
        SSijT[3] = irfft3(comm,self.test_filter*rfft3(comm,S*self.Sij[3])).real
        SSijT[4] = irfft3(comm,self.test_filter*rfft3(comm,S*self.Sij[4])).real
        SSijT[5] = irfft3(comm,self.test_filter*rfft3(comm,S*self.Sij[5])).real

        Mij[0] = 2.0*(deltl**2.0)*SSijT[0] - 2.0*(deltt**2.0)*Shat*Sijhat[0]
        Mij[1] = 2.0*(deltl**2.0)*SSijT[1] - 2.0*(deltt**2.0)*Shat*Sijhat[1]
        Mij[2] = 2.0*(deltl**2.0)*SSijT[2] - 2.0*(deltt**2.0)*Shat*Sijhat[2]
        Mij[3] = 2.0*(deltl**2.0)*SSijT[3] - 2.0*(deltt**2.0)*Shat*Sijhat[3]
        Mij[4] = 2.0*(deltl**2.0)*SSijT[4] - 2.0*(deltt**2.0)*Shat*Sijhat[4]
        Mij[5] = 2.0*(deltl**2.0)*SSijT[5] - 2.0*(deltt**2.0)*Shat*Sijhat[5]

        LijMij = Mij[0]*Lij[0] + 2.0*Mij[1]*Lij[1] + 2.0*Mij[2]*Lij[2] + Mij[3]*Lij[3] \
                 + 2.0*Mij[4]*Lij[4] + Mij[5]*Lij[5]
        MklMkl = Mij[0]*Mij[0] + 2.0*Mij[1]*Mij[1] + 2.0*Mij[2]*Mij[2] + Mij[3]*Mij[3] \
                 + 2.0*Mij[4]*Mij[4] + Mij[5]*Mij[5]
        Cs2 = np.divide(LijMij, MklMkl)

        C_DS = 0.61

        tau_DS = np.empty((6, *self.nnx), dtype=np.float64)

        tau_DS[0] =  -2.0 * Cs2 * deltl**2.0 * S * self.Sij[0]
        tau_DS[1] =  -2.0 * Cs2 * deltl**2.0 * S * self.Sij[1]
        tau_DS[2] =  -2.0 * Cs2 * deltl**2.0 * S * self.Sij[2]
        tau_DS[3] =  -2.0 * Cs2 * deltl**2.0 * S * self.Sij[3]
        tau_DS[4] =  -2.0 * Cs2 * deltl**2.0 * S * self.Sij[4]
        tau_DS[5] =  -2.0 * Cs2 * deltl**2.0 * S * self.Sij[5]

        # print('tauij = ',tau[0,32,32,32])
        # print('tauij = ',tau[1,32,32,32])
        # print('tauij = ',tau[2,32,32,32])
        # print('tauij = ',tau[3,32,32,32])
        # print('tauij = ',tau[4,32,32,32])
        # print('tauij = ',tau[5,32,32,32])


#        tau_hat[0] = rfft3(comm,tau[0])
#        tau_hat[1] = rfft3(comm,tau[1])
#        tau_hat[2] = rfft3(comm,tau[2])
#        tau_hat[3] = rfft3(comm,tau[3])
#        tau_hat[4] = rfft3(comm,tau[4])
#        tau_hat[5] = rfft3(comm,tau[5])
#
#        m = 0
#        for i in range(2, -1, -1):
#            for j in range(i, -1, -1):
#                self.dU[i] -= 1j*self.K[j]*tau_hat[m]
#                if i != j:
#                    self.dU[j] -= 1j*self.K[i]*tau_hat[m]
#
#                m+=1
#
        # BS Added Dissaption -----------------------------------------
        tau_BS = np.empty((6, *self.nnx), dtype=np.float64)
        #tau_hat_BS = np.empty((6, *self.nnk), dtype=complex)

        C_BS = 1.0 - C_DS
        
        delta = 2.0*np.pi/self.k_dealias
        Cs = 0.173
        tau_BS[0] =  -2.0 * Cs**2.0 * delta**2.0 * S * self.Sij[0]
        tau_BS[1] =  -2.0 * Cs**2.0 * delta**2.0 * S * self.Sij[1]
        tau_BS[2] =  -2.0 * Cs**2.0 * delta**2.0 * S * self.Sij[2]
        tau_BS[3] =  -2.0 * Cs**2.0 * delta**2.0 * S * self.Sij[3]
        tau_BS[4] =  -2.0 * Cs**2.0 * delta**2.0 * S * self.Sij[4]
        tau_BS[5] =  -2.0 * Cs**2.0 * delta**2.0 * S * self.Sij[5]

        self.tau = C_DS * tau_DS + C_BS * tau_BS
        #print(self.tau[0,0,0,0])

        tau_hat[0] = rfft3(comm,self.tau[0])
        tau_hat[1] = rfft3(comm,self.tau[1])
        tau_hat[2] = rfft3(comm,self.tau[2])
        tau_hat[3] = rfft3(comm,self.tau[3])
        tau_hat[4] = rfft3(comm,self.tau[4])
        tau_hat[5] = rfft3(comm,self.tau[5])

        #tau_hat_bs[0] = rfft3(comm,tau_bs[0])
        #tau_hat_bs[1] = rfft3(comm,tau_bs[1])
        #tau_hat_bs[2] = rfft3(comm,tau_bs[2])
        #tau_hat_bs[3] = rfft3(comm,tau_bs[3])
        #tau_hat_bs[4] = rfft3(comm,tau_bs[4])
        #tau_hat_bs[5] = rfft3(comm,tau_bs[5])

        m = 0
        for i in range(2, -1, -1):
            for j in range(i, -1, -1):
                self.dU[i] -= 1j*self.K[j]*tau_hat[m]
                if i != j:
                    self.dU[j] -= 1j*self.K[i]*tau_hat[m]

                m+=1
        # BS Added Dissaption -----------------------------------------

        # print('tauij_BS = ',tau_BS[0,32,32,32])
        # print('tauij_BS = ',tau_BS[1,32,32,32])
        # print('tauij_BS = ',tau_BS[2,32,32,32])
        # print('tauij_BS = ',tau_BS[3,32,32,32])
        # print('tauij_BS = ',tau_BS[4,32,32,32])
        # print('tauij_BS = ',tau_BS[5,32,32,32])
        # print(' ')

        # sys.exit()

        return


###############################################################################
# Define the problem ("main" function)
###############################################################################
def ales244_static_les_test( pp=None, sp=None):
    """
    Arguments:
    ----------
    pp: (optional) program parameters, parsed by argument parser
        provided by this file
    sp: (optional) solver parameters, parsed by spectralLES.parser
    """
    #--------------------------------------------------------------------------#
    # Defining the path                                                        #
    #--------------------------------------------------------------------------#
    path_store  = './new-ds-061-e25-t-25/'
    #--------------------------------------------------------------------------#
    # Printing the solution                                                    #
    #--------------------------------------------------------------------------#
    if comm.rank == 0:
        print("\n----------------------------------------------------------")
        print("MPI-parallel Python spectralLES simulation of problem \n"
              "`Homogeneous Isotropic Turbulence' started with "
              "{} tasks at {}.".format(comm.size, timeofday()))
        print("----------------------------------------------------------")

    # ------------------------------------------------------------------
    # Get the problem and solver parameters and assert compliance
    if pp is None:
        pp = hit_parser.parse_known_args()[0]

    if sp is None:
        sp = spectralLES.parser.parse_known_args()[0]

    if comm.rank == 0:
        print('\nProblem Parameters:\n-------------------')
        for k, v in vars(pp).items():
            print(k, v)
        print('\nSpectralLES Parameters:\n-----------------------')
        for k, v in vars(sp).items():
            print(k, v)
        print("\n----------------------------------------------------------\n")

    assert len(set(pp.N)) == 1, ('Error, this beta-release HIT program '
                                 'requires equal mesh dimensions')
    N = pp.N[0]
    assert len(set(pp.L)) == 1, ('Error, this beta-release HIT program '
                                 'requires equal domain dimensions')
    L = pp.L[0]

    if N % comm.size > 0:
        if comm.rank == 0:
            print('Error: job started with improper number of MPI tasks for '
                  'the size of the data specified!')
        MPI.Finalize()
        sys.exit(1)

    # ------------------------------------------------------------------
    # Configure the LES solver
    solver = ales244_solver(comm, **vars(sp))

    solver.computeAD = solver.computeAD_vorticity_form
    Sources = [solver.computeSource_linear_forcing,
               solver.computeSource_ales244_SGS]

    H_244 = np.loadtxt('h_ij.dat', usecols=(1, 2, 3, 4, 5, 6), unpack=True)
    kwargs = {'H_244': H_244, 'dvScale': None}

    U_hat = solver.U_hat
    U = solver.U
    tau = solver.tau
    Sij = solver.Sij
    Kmod = np.floor(np.sqrt(solver.Ksq)).astype(int)
    print_count = 101

    # ------------------------------------------------------------------
    # form HIT initial conditions from either user-defined values or
    # physics-based relationships
    Urms = 1.083*(pp.epsilon*L)**(1./3.)             # empirical coefficient
    Einit= getattr(pp, 'Einit', None) or Urms**2   # == 2*KE_equilibrium
    kexp = getattr(pp, 'kexp', None) or -1./3.     # -> E(k) ~ k^(-2./3.)
    kpeak= getattr(pp, 'kpeak', None) or N//4      # ~ kmax/2

    # currently using a fixed random seed for testing
    solver.initialize_HIT_random_spectrum(Einit, kexp, kpeak, rseed=comm.rank)

    # ------------------------------------------------------------------
    # Configure a spatial field writer
    writer = mpiWriter(comm, odir=pp.odir, N=N)
    Ek_fmt = "\widehat{{{0}}}^*\widehat{{{0}}}".format

    # -------------------------------------------------------------------------
    # Setup the various time and IO counters
    tauK = sqrt(pp.nu/pp.epsilon)           # Kolmogorov time-scale
    taul = 0.11*sqrt(3)*L/Urms              # 0.11 is empirical coefficient

    if pp.tlimit == np.Inf:
        pp.tlimit = 200*taul

    dt_rst = getattr(pp, 'dt_rst', None) or taul
    dt_spec= getattr(pp, 'dt_spec', None) or 0.2*taul
    dt_drv = getattr(pp, 'dt_drv', None) or 0.25*tauK

    t_sim = t_rst = t_spec = t_drv = 0.0
    tstep = irst = ispec = 0
    tseries = []

    if comm.rank == 0:
        print('\ntau_ell = %.6e\ntau_K = %.6e\n' % (taul, tauK))

    # -------------------------------------------------------------------------
    # Run the simulation
    while t_sim < pp.tlimit+1.e-8:

        # -- Update the dynamic dt based on CFL constraint
        dt = solver.new_dt_constant_nu(pp.cfl)
        t_test = t_sim + 0.5*dt

        # -- output/store a log every step if needed/wanted
        KE = 0.5*comm.allreduce(psum(np.square(U)))/solver.Nx
        tseries.append([tstep, t_sim, KE])

        # -- output KE and enstrophy spectra
        if t_test >=0.1*t_spec:

            np.save(path_store + 'SimulationTime_%(a)3.3d' % {'a': ispec}, t_sim)
            np.save(path_store + 'Velocity1_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, U[2])
            np.save(path_store + 'Velocity2_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, U[1])
            np.save(path_store + 'Velocity3_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, U[0])

            #np.save('tau11_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, tau[0])
            #np.save('tau12_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, tau[1])
            #np.save('tau13_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, tau[2])
            #np.save('tau22_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, tau[3])
            #np.save('tau23_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, tau[4])
            #np.save('tau33_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, tau[5])
            ##print("\n\n\n****while loop")
            ##print(tau[0,0,0,0])
            #np.save('Sij11_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, Sij[0])
            #np.save('Sij12_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, Sij[1])
            #np.save('Sij13_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, Sij[2])
            #np.save('Sij22_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, Sij[3])
            #np.save('Sij23_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, Sij[4])
            #np.save('Sij33_%(a)3.3d_%(b)3.3d' % {'a': ispec, 'b': comm.rank}, Sij[5])
            #np.save('TimeStep_%(a)3.3d' % {'a': ispec}, tstep)
            #print('Output at tstep = ',tstep)

            # # -- output message log to screen on spectrum output only
            # if comm.rank == 0:
            #     print("cycle = %7d  time = %15.8e  dt = %15.8e  KE = %15.8e"
            #           % (tstep, t_sim, dt, KE))
            #
            # # -- output kinetic energy spectrum to file
            # spect3d = np.sum(np.real(U_hat*np.conj(U_hat)), axis=0)
            # spect3d[..., 0] *= 0.5
            # spect1d = shell_average(comm, spect3d, Kmod)
            #
            # if comm.rank == 0:
            #     fname = '%s/%s-%3.3d_KE.spectra' % (pp.adir, pp.pid, ispec)
            #     fh = open(fname, 'w')
            #     metadata = Ek_fmt('u_i')
            #     fh.write('%s\n' % metadata)
            #     spect1d.tofile(fh, sep='\n', format='% .8e')
            #     fh.close()

            t_spec += dt_spec         # uncomment this to specify when to save the data
            ispec += 1

        # -- output physical-space solution fields for restarting and analysis
        if t_test >= t_rst:
            # writer.write_scalar('%s-Velocity1_%3.3d.rst' %
            #                     (pp.pid, irst), U[0], np.float64)
            # writer.write_scalar('%s-Velocity2_%3.3d.rst' %
            #                     (pp.pid, irst), U[1], np.float64)
            # writer.write_scalar('%s-Velocity3_%3.3d.rst' %
            #                     (pp.pid, irst), U[2], np.float64)

            t_rst += dt_rst
            irst += 1

        # -- Update the forcing mean scaling
        if t_test >= t_drv:
            # call solver.computeSource_linear_forcing to compute dvScale only
            kwargs['dvScale'] = Sources[0](computeRHS=False)
            t_drv += dt_drv

        # np.save('SimulationTime_%(a)3.3d' % {'a': tstep}, t_sim)
        # np.save('Velocity1_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, U[2])
        # np.save('Velocity2_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, U[1])
        # np.save('Velocity3_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, U[0])
        # np.save('tau11_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, tauij[0])
        # np.save('tau12_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, tauij[1])
        # np.save('tau13_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, tauij[2])
        # np.save('tau22_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, tauij[3])
        # np.save('tau23_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, tauij[4])
        # np.save('tau33_%(a)3.3d_%(b)3.3d' % {'a': tstep, 'b': comm.rank}, tauij[5])
        # np.save('TimeStep_%(a)3.3d' % {'a': tstep}, tstep)
        # print('Output at tstep = ',tstep)

        # -- integrate the solution forward in time
        solver.RK4_integrate(dt, *Sources, **kwargs)

        if comm.rank == 0:
            if print_count > 0:
                print("cycle = %7d  time = %15.8e  dt = %15.8e  KE = %15.8e"
                  % (tstep, t_sim, dt, KE))
                print_count = 0
        print_count += 1

        t_sim += dt
        tstep += 1

        sys.stdout.flush()  # forces Python 3 to flush print statements

    # -------------------------------------------------------------------------
    # Finalize the simulation

    KE = 0.5*comm.allreduce(psum(np.square(U)))/solver.Nx
    tseries.append([tstep, t_sim, KE])

    if comm.rank == 0:
        fname = '%s/%s-%3.3d_KE_tseries.txt' % (pp.adir, pp.pid, ispec)
        header = 'Kinetic Energy Timeseries,\n# columns: tstep, time, KE'
        np.savetxt(fname, tseries, fmt='%10.5e', header=header)

        print("cycle = %7d  time = %15.8e  dt = %15.8e  KE = %15.8e"
              % (tstep, t_sim, dt, KE))
        print("\n----------------------------------------------------------")
        print("MPI-parallel Python spectralLES simulation finished at {}."
              .format(timeofday()))
        print("----------------------------------------------------------")

    # -- output kinetic energy spectrum to file
    spect3d = np.sum(np.real(U_hat*np.conj(U_hat)), axis=0)
    spect3d[..., 0] *= 0.5
    spect1d = shell_average(comm, spect3d, Kmod)

    if comm.rank == 0:
        fh = open('%s/%s-%3.3d_KE.spectra' %
                  (pp.adir, pp.pid, ispec), 'w')
        metadata = Ek_fmt('u_i')
        fh.write('%s\n' % metadata)
        spect1d.tofile(fh, sep='\n', format='% .8e')
        fh.close()

    # -- output physical-space solution fields for restarting and analysis
    writer.write_scalar('%s-Velocity1_%3.3d.rst' %
                        (pp.pid, irst), U[0], np.float64)
    writer.write_scalar('%s-Velocity2_%3.3d.rst' %
                        (pp.pid, irst), U[1], np.float64)
    writer.write_scalar('%s-Velocity3_%3.3d.rst' %
                        (pp.pid, irst), U[2], np.float64)

    return


###############################################################################
# Add a parser for this problem
###############################################################################
hit_parser = argparse.ArgumentParser(prog='Homogeneous Isotropic Turbulence',
                                     parents=[spectralLES.parser])

hit_parser.description = ("A large eddy simulation model testing and analysis "
                          "script for homogeneous isotropic turbulence")
hit_parser.epilog = ('This program uses spectralLES, %s'
                     % spectralLES.parser.description)

config_group = hit_parser._action_groups[2]

config_group.add_argument('-p', '--pid', type=str, default='test',
                          help='problem prefix for analysis outputs')
config_group.add_argument('--dt_drv', type=float,
                          help='refresh-rate of forcing pattern')

time_group = hit_parser.add_argument_group('time integration arguments')

time_group.add_argument('--cfl', type=float, default=0.45, help='CFL number')
time_group.add_argument('-t', '--tlimit', type=float, default=np.inf,
                        help='solution time limit')
time_group.add_argument('-w', '--twall', type=float,
                        help='run wall-time limit (ignored for now!!!)')

init_group = hit_parser.add_argument_group('initial condition arguments')

init_group.add_argument('-i', '--init', '--initial-condition',
                        metavar='IC', default='GamieOstriker',
                        choices=['GamieOstriker', 'TaylorGreen'],
                        help='use specified initial condition')
init_group.add_argument('--kexp', type=float,
                        help=('Gamie-Ostriker power-law scaling of '
                              'initial velocity condition'))
init_group.add_argument('--kpeak', type=float,
                        help=('Gamie-Ostriker exponential-decay scaling of '
                              'initial velocity condition'))
init_group.add_argument('--Einit', type=float,
                        help='specify KE of initial velocity field')

rst_group = hit_parser.add_argument_group('simulation restart arguments')

rst_group.add_argument('-l', '--last', '--restart-from-last', dest='restart',
                       action='store_const', const=-1,
                       help='restart from last *.rst checkpoint in IDIR')
rst_group.add_argument('-r', '--rst', '--restart-from-num', type=int,
                       dest='restart', metavar='NUM',
                       help=('restart from specified checkpoint in IDIR, '
                             'negative numbers index backwards from last'))
rst_group.add_argument('--idir', type=str, default='./data/',
                       help='input directory for restarts')

io_group = hit_parser.add_argument_group('simulation output arguments')

io_group.add_argument('--odir', type=str, default='./data/',
                      help='output directory for simulation fields')
io_group.add_argument('--dt_rst', type=float,
                      help='time between restart checkpoints')
io_group.add_argument('--dt_bin', type=float,
                      help='time between single-precision outputs')

anlzr_group = hit_parser.add_argument_group('analysis output arguments')

anlzr_group.add_argument('--adir', type=str, default='./analysis/',
                         help='output directory for analysis products')
anlzr_group.add_argument('--dt_stat', type=float,
                         help='time between statistical analysis outputs')
anlzr_group.add_argument('--dt_spec', type=float,
                         help='time between isotropic power spectral density'
                              ' outputs')


###############################################################################
if __name__ == "__main__":
    # np.set_printoptions(formatter={'float': '{: .8e}'.format})
    ales244_static_les_test()
