#!/bin/bash

docker run --name rstudios2 -d -e DISPLAY \
           -v ~/dev:/home/akiro/hostfolder \
           -ti \
           --net=host rstudios-only:RS-1.2.830
