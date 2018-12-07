#!/bin/bash

docker run --name rstudios2 -d -e DISPLAY \
           -v ~/dev:/home/akiro/hostfolder \
           -ti \
           -p 8080:8787 rstudios-only:RSP-1.1.463
