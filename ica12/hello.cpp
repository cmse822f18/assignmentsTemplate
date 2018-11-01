#include <iostream>
#include <mpi.h>
using namespace std;

int main(int argc, char *argv[])
{
    MPI_Init(&argc, &argv);
    // Get rank/size
    int myRank, numRanks;

    MPI_Comm_rank(MPI_COMM_WORLD, &myRank);
    MPI_Comm_size(MPI_COMM_WORLD, &numRanks);

    if (myRank == 0) cout << "Hello, World!" << endl;

    MPI_Finalize();

    return 0;
}