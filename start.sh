#!/bin/bash

#mainly to debug locally
if [ -z $SERVICE_DIR ]; then export SERVICE_DIR=`pwd`; fi

#clean up previous job (just in case)
rm -f finished

nohup time $SERVICE_DIR/submit.pbs > stdout.log 2> stderr.log &
echo $! > pid

#nohup time matlab -nodisplay -nosplash -r main > stdout.log 2> stderr.log &