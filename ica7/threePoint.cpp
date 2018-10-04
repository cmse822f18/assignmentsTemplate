#include <iostream>
#include <cstdlib>
#include <mpi.h>
#include <vector>

int main(int argc, char *argv[])
{
    // Initialize the MPI communicator
    MPI_Init(&argc, &argv);

    // Get rank/size
    int myRank, numRanks;

    MPI_Comm_rank(MPI_COMM_WORLD, &myRank);
    MPI_Comm_size(MPI_COMM_WORLD, &numRanks);

    int nGlobal = atoi(argv[1]);
    
    // Setup local array
    int nLocal = (int)nGlobal/numRanks;
    if (myRank==0) nLocal += nGlobal%numRanks;

    // Allocate and initialize the vector
    // x is allocate with 2 ghost zones
    std::vector<float> x(nLocal+2);
    std::vector<float> y(nLocal);
    for (int i=1; i<nLocal+1; i++){
        x[i] = i + myRank*(nLocal+nGlobal%numRanks);
    }

    // Now specify neighbors
    int leftNeigh = myRank-1;
    if (myRank==0) leftNeigh = numRanks-1;
    int rghtNeigh = myRank+1;
    if (myRank==numRanks-1) rghtNeigh = 0;

    if (myRank%2 == 0){
        // exchange with left neighbor rank
        MPI_Sendrecv(&x[1],1,MPI_FLOAT,leftNeigh,0,&x[0],1,MPI_FLOAT,leftNeigh,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);        
    }
    else {
        // exchange with right neighbor rank
        MPI_Sendrecv(&x[nLocal+1], 1, MPI_FLOAT, rghtNeigh, 0, &x[nLocal+2], 1, MPI_FLOAT, rghtNeigh, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }

    // Now do the other exchanges 
    if (myRank%2==1){
        // exchange with left neighbor rank
        MPI_Sendrecv(&x[1], 1, MPI_FLOAT, leftNeigh, 1, &x[0], 1, MPI_FLOAT, leftNeigh, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }
    else{
        // exchange with right neighbor rank
        MPI_Sendrecv(&x[nLocal+1], 1, MPI_FLOAT, rghtNeigh, 1, &x[nLocal+2], 1, MPI_FLOAT, rghtNeigh, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }

    // for (int i = 0; i < nLocal + 2; i++)
    // {
    //     std::cout << i << " " << x[i] << std::endl;
    // }

    // perform the averaging
    for (int i = 0; i<nLocal; i++)
    {
        y[i] = (x[i]+x[i+1]+x[i+2])/3.;
    }
    MPI_Finalize();
}