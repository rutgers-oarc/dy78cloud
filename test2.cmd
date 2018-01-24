#!/bin/bash

#SBATCH --partition=main             # Partition (job queue)
#SBATCH --requeue                    # Return job to the queue if preempted
#SBATCH --job-name=test2              # Assign an short name to your job
#SBATCH --nodes=1                    # Number of nodes you require
#SBATCH --ntasks=1                   # Total # of tasks across all nodes
#SBATCH --cpus-per-task=1            # Cores per task (>1 if multithread tasks)
#SBATCH --mem=2000                   # Real memory (RAM) required (MB)
#SBATCH --time=00:05:00              # Total run time limit (HH:MM:SS)
#SBATCH --output=test2.%N.%j.out      # STDOUT output file
#SBATCH --error=test2.%N.%j.err       # STDERR output file (optional)
#SBATCH --export=ALL                 # Export you current env to the job env


# Execute commands
#nohup R CMD BATCH --no-restore "--args $arg1 $arg2" ~/R/test2.r test2$arg1$arg2.out
#nohup $R CMD BATCH --no-restore "--args $arg1 $arg2" ~/R/test2.r test2$arg1$arg2.out
#R CMD BATCH --no-restore "--args $arg1 $arg2" ~/R/test2.r test2$arg1$arg2.out
#R CMD BATCH --no-restore "--args $x $y" test2.r test2$x$y.out

# real command
#R CMD BATCH --no-restore "--args $1 $2" test2.r test2$x$y.out
# test command
R CMD BATCH --no-restore "--args  $arg1 $arg2" test2.r /data/test2$x$y.out
