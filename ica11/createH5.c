#include "hdf5.h"

int main(int argc, char *argv[])
{

    hid_t file_id;
    herr_t status;
    // Open a file
    file_id = H5Fcreate("file.h5", H5F_ACC_TRUNC, H5P_DEFAULT, H5P_DEFAULT);

    status = H5Fclose(file_id);

}
