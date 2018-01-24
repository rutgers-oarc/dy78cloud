#!/bin/bash

## chmod u+x test2.sh
## ./test2.sh

for x in {4..5}
do
    for y in {2..3}
    do
            export x
            export y
            #sbatch --export arg1=$x,arg2=$y test2.cmd 
            #sbatch  test2.cmd

            test2.cmd
    done
done
unset x
unset y
