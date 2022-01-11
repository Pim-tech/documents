#include <stdio.h>

int main() {
    int n;
    int idart,iddec,qtemvt;
    int data[10][3] = 
    {
     {1,90,33},
     {1,91,20},
     {1,92,40},
     {1,93,42},
     {2,80,10},
     {2,81,20},
     {2,82,27},
     {6,90,38},
     {6,91,100},
     {6,92,20}
    };

    for (n=0;n<10;n++) {
      idart  = data[n][0];
      iddec  = data[n][1];
      qtemvt = data[n][2];
      printf("%5d%2d%3d%-100s\n",idart,iddec,qtemvt," ");
    }
    return 0;
}
