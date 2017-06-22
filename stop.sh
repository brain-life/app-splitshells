#!/bin/bash

#if [ -f finished ]; then
#    echo "can't stop job that's already finished"
#    exit 1
#fi

if [ -s pid ]; then
    pid=`cat pid`

    kill $pid
fi
