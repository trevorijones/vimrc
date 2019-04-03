#!/bin/bash
VIM_RUNTIME_DIR="$(dirname "$(realpath $0)")"

utils_curlsha256() {
  local url=$1
  local url_sha=$2
  if [ "200" == "$(curl -L -s -w "%{http_code}" -O $url)" ]; then
    if [ "200" == "$(curl -L -s -w "%{http_code}" -O $url_sha)" ]; then
      grep ${url##*/} ${url_sha##*/} | sha256sum -c -
    else
      echo "Failed to fetch $url_sha"
      return 1
    fi
  else
    echo "Failed to fetch $url"
    return 1
  fi
}

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

install_node() {
  local version=v8.11.2
  local url_sha="https://nodejs.org/dist/${version}/SHASUMS256.txt"
  local url="https://nodejs.org/dist/$version/node-${version}-linux-x64.tar.xz"

  [ -d "$VIM_RUNTIME_DIR/opt" ] || mkdir "$VIM_RUNTIME_DIR/opt"
  (cd "$VIM_RUNTIME_DIR/opt" &&
    utils_curlsha256 $url $url_sha &&
    tar Jxf node* && rm *.tar.xz SHASUMS* && mv node* node)
}

# use to generate the node project
install_node_utils() {
  (
    NODE_HOME="$VIM_RUNTIME_DIR/opt/node"
    PATH="$PATH:$NODE_HOME/bin"
    node $NODE_HOME/bin/npm install -g prettier
  )
}

if [ -n "$1" ]; then
  if declare -F | cut -d' ' -f 3 | grep -q "^${1}$"; then
    "$1"
  fi
else

  go version || install_global_go
  install_local_shfmt
  install_shellcheck
  install_java_checkstyle
  sudo pip install requests
  ./update_plugins.py

fi
