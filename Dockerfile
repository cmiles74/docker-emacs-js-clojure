from dock0/arch:latest

# update our Arch installation
run pacman-key --init
run pacman-key --populate archlinux
run pacman-key --refresh-keys
run pacman -Syu --noconfirm
run pacman-db-upgrade

# install Java
run pacman -Syqu --noconfirm base-devel binutils tmux bash man fish powerline git openssh wget curl rxvt-unicode xorg-xrdb

# install npm
run pacman -Syqu --noconfirm npm

# setup our developer user
workdir /root
run groupadd -r developer -g 1000
run useradd -u 1000 -r -g developer -d /developer -c "Software Developer" developer
copy /developer /developer
run chown -R developer:developer /developer
run chmod +x /developer/bin/*

# install leiningen
run curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
run chmod +x lein
run mv lein /sbin

# install Emacs
run pacman -Sqyu --noconfirm xorg-fonts-encodings xorg-font-utils git emacs

# install Java
run pacman -Sy --noconfirm jdk8-openjdk maven

# build hack aur package
user developer
workdir /developer
run mkdir aur
run git clone https://aur.archlinux.org/ttf-hack.git aur/ttf-hack
workdir /developer/aur/ttf-hack
run makepkg
user root
run pacman -U --noconfirm *xz

# build unifont aur package
user developer
workdir /developer
run git clone https://aur.archlinux.org/ttf-unifont.git aur/ttf-unifont
workdir /developer/aur/ttf-unifont
run makepkg
user root
run pacman -U --noconfirm *xz

# cleanup aur packages
user root
workdir /developer
run rm -rf aur

# install spacemacs
user developer
workdir /developer
run git clone --recursive https://github.com/syl20bnr/spacemacs ~/.emacs.d

# setup leiningen
run /sbin/lein --version

# install some NPM packages
run export PATH=$PATH:/developer/.npm/bin; npm install -g gulp tern js-beautify jshint eslint babel-eslint eslint-plugin-react

# volume used for mounting project files
copy project /project
workdir /project

#
# Environment Variables
#

# Path
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk
ENV PATH $JAVA_HOME/bin:/developer/.npm/bin:$PATH

#
# Ports
#

# BrowserSync
expose 3000
expose 3001

# Web application
expose 5000

#
# Volumes
#

# the project files
volume ["/project"]

# start emacs
user developer
entrypoint ["/developer/bin/start-emacs"]
