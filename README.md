Emacs with Javascript and Clojure
===============================================

You can pull this image from Docker Hub.

    docker pull cmiles74/docker-emacs-js-clojure
    
This project provides a Docker image that includes a reasonably new and working
version of Emacs, OpenJDK 8, NodeJS and NVM. I use this image for developing web
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

Getting a Shell in the Container
--------------------------------

Once the container is up and running, you'll immediately be presented with an
Emacs window. In addition to running a terminal in the container and displaying
it on your local machine, You can also get a shell running by issuing the
following command:

    docker exec -it docker-emacs /bin/bash
    
This will run bash from inside the container. You can also pull up a terminal
from inside Emacs, it's a matter of preference.


Installing Node
-----------------

The latest version of Node and NPM are installed by default as well as some NPM
packages used by Emacs. If you need a specific version of Node or specific
packages, NVM is supplied and you're encouraged to use it. `:-)`

Once you have the image up-and-running, you'll need to install Node. You can
create an `.nvmrc` file in the root of your project. NVM will inspect that file
and automatically choose the right version of node. For instance, to use the
latest LTS release...

    echo "lts/*" > .nvmrc

Then install node...

    nvm install

Then you can "use" that version of node.

    nvm use

If you do need to install additional NPM packages, you can use `sudo` to run the
command as "root".`
