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


go version || install_global_go
install_local_shfmt
install_shellcheck
install_java_checkstyle
sudo pip install requests
./update_plugins.py
