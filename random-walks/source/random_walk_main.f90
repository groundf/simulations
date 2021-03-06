! -*- coding: utf-8 -*-

!! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !!
!! PROGRAM: RANDOM WALK SIMULATION                                         !!
!! VERSION: 0.1.0                                                          !!
!! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !!
program random_walk_main

    use, intrinsic :: iso_fortran_env, only: sp => real32, dp => real64

    use random_walk, only: simulate

    implicit none

    integer :: seed
    integer :: step, trial
    integer :: steps, trials

    character(100) :: seed_arg
    character(100) :: steps_arg
    character(100) :: trials_arg

    real(sp), allocatable :: randoms(:,:)
    real(sp), allocatable :: outputs(:,:,:)

    ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !
    !  CONFIGURATION                                                        !
    ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !

    ! Check that the right number of command-line arguments.
    if(command_argument_count() .ne. 3) then
        write(*,*)'Error, three command-line arguments required, stopping.'
        stop
    end if

    ! Read the command-line arguments.
    call get_command_argument(1, seed_arg)
    call get_command_argument(2, steps_arg)
    call get_command_argument(3, trials_arg)

    ! Convert the command-line arguments.
    read(seed_arg, *) seed
    read(steps_arg, *) steps
    read(trials_arg, *) trials

    ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !
    ! CALCULATIONS                                                          !
    ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !

    allocate( randoms(1:trials, 1:steps) )
    allocate( outputs(1:trials, 1:steps, 1:3) )

    call random_number(randoms)

    outputs = simulate(trials=trials, steps=steps, randoms=randoms)

    print *, randoms

    do trial = 1, trials

        do step = 1, steps
            write(*,'(f0.1,a,f0.1,a,f0.1)')  &
                 outputs(trial, step, 1), '|', &
                 outputs(trial, step, 2), '|', &
                 outputs(trial, step, 3)
        end do
        ! if (trial <= trials) then
        !     write(*, *)'---'
        ! end if
    end do

end program