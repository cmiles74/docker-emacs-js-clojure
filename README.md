Emacs with Javascript and Clojure
===============================================

You can pull this image from Docker Hub.

    docker pull cmiles74/emacs-js-clojure
    
This project provides a Docker image that includes a reasonably new and working
version of Emacs, OpenJDK 8 and NodeJS. I use this image for developing web
applications in Clojure. In this image, Emacs is bundled
with [Spacemacs](http://spacemacs.org/) and the image is built
on [Arch Linux](https://www.archlinux.org/).

Running the Image
-------------------

This project includes a script that will start the image and launch Emacs and a
start a terminal session. You will likely want to customize this script to meet
your own needs.

    #!/bin/bash

    # allow all docker hosts to our X server
    xhost + 172.17.0

    # start docker and emacs
    docker run \
          -d \
          -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
          -v ${PWD}/project:/project \
          -e DISPLAY=unix${DISPLAY} \
          --device /dev/snd \
          --name docker-emacs \
          cmiles74/emacs-js-clojure

    docker exec docker-emacs /developer/bin/start-terminal
    
The script above allows containers on your local machine to communicat with your
X server, then starts up Emacs and the terminal session. In order for the image
to function, we map in the X server socket and then set some environment
variables.
