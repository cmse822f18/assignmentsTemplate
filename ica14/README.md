# In-class Assignment 14, 11/13

## OpenMP Tasks

### MMM with OpenMP Tasks

Take a look at the `taskMMM.c` and `taskMMM.f90` codes in the `ica14` directory. These codes implement a _blocked_ matrix-matrix multiplication. With your group, make the inner triple loop thread-parallel using OpenMP tasks. Think carefully about the ownership and access of data. Also consider what the dependences of the calculations are. These codes are setup to check for the correct answer so you should know if you have done it correclty!

## What to turn in

To your git repo, in the `ica14` directory, commit your final, working code for the above exercise. Your final writeup is due on 11/20.