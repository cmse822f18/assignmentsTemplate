! Explanation of constants and variables used in this program:
!   DARTS               = number of throws at dartboard
!   ROUNDS              = number of times "DARTS" is iterated
!   pi                  = average of pi for this iteration
!   avepi               = average pi value for all iterations
!
program pi_calc

  integer, parameter :: DARTS = 100000
  integer, parameter :: ROUNDS = 10000
  double precision, parameter :: realpi=3.1415926535897
  real ::     seednum
  double precision ::     pi, avepi

  print *, 'Starting serial version of pi calculation...'

  avepi = 0
  do i = 1, ROUNDS
     pi = dboard(DARTS)
     avepi = ((avepi*(i-1)) + pi)/ i
     write(*,32) DARTS*i, avepi
  end do

  print *, ' '
  print *,'Error:', abs(avepi-realpi)/realpi
  print *, ' '

32 format('   After',i8,' throws, average value of pi = ', &
       &           f10.8,$)

contains

  ! Explanation of constants and variables used in this function:
  !   darts       = number of throws at dartboard
  !   score       = number of darts that hit circle
  !   n           = index variable
  !   r           = random number between 0 and 1
  !   x_coord     = x coordinate, between -1 and 1
  !   x_sqr       = square of x coordinate
  !   y_coord     = y coordinate, between -1 and 1
  !   y_sqr       = square of y coordinate
  !   pi          = computed value of pi

  real function dboard(darts)

    integer :: darts, score, n
    real ::   r
    double precision ::  x_coord, x_sqr, y_coord, y_sqr, pi

    score = 0

    !  Throw darts at board.  Done by generating random numbers
    !  between 0 and 1 and converting them to values for x and y
    !  coordinates and then testing to see if they "land" in
    !  the circle."  If so, score is incremented.  After throwing the
    !  specified number of darts, pi is calculated.  The computed value
    !  of pi is returned as the value of this function, dboard.
    !  Note:  the seed value for rand() is set in pi_calc.

    !    Note: Requires Fortran90 compiler due to random_number() function
    print *, ' '
    do n = 1, darts
       call random_number(r)
       x_coord = (2.0 * r) - 1.0
       x_sqr = x_coord * x_coord

       call random_number(r)
       y_coord = (2.0 * r) - 1.0
       y_sqr = y_coord * y_coord

       if ((x_sqr + y_sqr) .le. 1.0) then
          score = score + 1
       endif
    end do
    pi = 4.0 * score / darts
    dboard = pi
  end function dboard

end program pi_calc
