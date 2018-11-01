program hello
    implicit none
    include "mpif.h"

    integer :: ierr, myRank, numRanks

    call MPI_INIT(ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, myRank, ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, numRanks, ierr)      

    if (myRank == 0) print *, "Hello World!"

    call MPI_FINALIZE(ierr)
end program hello