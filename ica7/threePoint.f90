program threePoint
implicit none
include 'mpif.h'

real, allocatable :: x(:), y(:)
integer :: i, j, nLocal, nGlobal
character(len=32) :: arg
integer :: ierr, myRank, numRanks
integer :: leftNeigh, rghtNeigh
integer :: status(MPI_STATUS_SIZE)

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, myRank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, numRanks, ierr)

call GET_COMMAND_ARGUMENT(1,arg)
read(arg,*) nGlobal

! Now setup the _local_ array
nLocal = int(nGlobal/numRanks)
if (myRank == 0) nLocal = nLocal + mod(nGlobal,numRanks)

allocate(x(0:nLocal+1))
allocate(y(nLocal))

! intialize vector
do i=1,nLocal
    x(i) = i + myRank*(nLocal + mod(nGlobal,numRanks))
end do 

! now deal with the "ghost" zones
leftNeigh = myRank-1
if (myRank==0) leftNeigh = numRanks-1
rghtNeigh = myRank+1
if (myRank==numRanks-1) rghtNeigh = 0

if (mod(myRank,2)==0) then 
    ! exchange with left neighbor rank    
    call MPI_SENDRECV(x(1),1,MPI_REAL,leftNeigh,0,x(0),1,MPI_REAL,leftNeigh,0,MPI_COMM_WORLD,status,ierr)
else 
    ! exchnage with right neighbor rank
    call MPI_SENDRECV(x(nLocal),1,MPI_REAL,rghtNeigh,0,x(nLocal+1),1,MPI_REAL,rghtNeigh,0,MPI_COMM_WORLD,status,ierr)
end if 

! Now do the other set of exchanges
if (mod(myRank,2)==1) then 
    ! exchange with left neighbor rank    
    call MPI_SENDRECV(x(1),1,MPI_REAL,leftNeigh,1,x(0),1,MPI_REAL,leftNeigh,1,MPI_COMM_WORLD,status,ierr)
else 
    ! exchnage with right neighbor rank
    call MPI_SENDRECV(x(nLocal),1,MPI_REAL,rghtNeigh,1,x(nLocal+1),1,MPI_REAL,rghtNeigh,1,MPI_COMM_WORLD,status,ierr)
end if 

! perform averaging
do i=1,nLocal
    y(i) = (x(i-1) + x(i) + x(i+1))/3.
end do

print *, myRank, y(1:nLocal)

call MPI_FINALIZE(ierr)

end program threePoint