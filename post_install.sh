#!/bin/bash
VIM_RUNTIME_DIR="$(dirname "$(realpath $0)")"

install_global_go() {
  local -
  set -x
  sudo bash -c "cd /tmp;\
    wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz;\
    gzip -cd go1.11.linux-amd64.tar.gz | tar -C /usr/local -xf -;\
    rm go*tar.gz"
}

install_local_shfmt() {
  (
    cd /tmp &&
      git clone https://github.com/mvdan/sh.git &&
      cd sh &&
      git checkout master.v3 &&
      go get -u mvdan.cc/sh/v3/cmd/shfmt
  )
}
# Syntastic sh checker
install_shellcheck() {
  sudo apt-get install shellcheck
}

# Syntastic java checker
install_java_checkstyle() {
  curl --insecure -L -O https://github.com/checkstyle/checkstyle/releases/download/checkstyle-8.18/checkstyle-8.18-all.jar
  curl --insecure -L -O https://raw.githubusercontent.com/checkstyle/checkstyle/master/src/main/resources/google_checks.xml
}

install_java_formater() {
  curl --insecure -L -O https://github.com/google/google-java-format/releases/download/google-java-format-1.7/google-java-format-1.7-all-deps.jar
}

install_vim_plug() {
  curl -fLo autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

# use to generate the node project
install_node_utils() {
  sudo apt-get install curl software-properties-common
  curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
  sudo npm install -g prettier
  sudo npm install -g coffeescript
}

if [ -n "$1" ]; then
  if declare -F | cut -d' ' -f 3 | grep -q "^${1}$"; then
    "$1"
  fi
else

  go version || install_global_go
  install_vim_plug
  install_local_shfmt
  install_shellcheck
  install_java_checkstyle
  install_java_formater
  install_node_utils
  sudo pip install requests
  ./update_plugins.py

fi
