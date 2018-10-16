#ifndef GET_WALLTIME_H_
#define GET_WALLTIME_H_

#include <stddef.h>
#include <sys/time.h>

void get_walltime_(double* wcTime) {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  *wcTime = (double)(tp.tv_sec + tp.tv_usec/1000000.0);
}

void get_walltime(double* wcTime) {
  get_walltime_(wcTime);
}

#endif //GET_WALLTIME_H_
