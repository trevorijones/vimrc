install_global_go() {
  local -; set -x
  sudo bash -c "cd /tmp;\
    wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz;\
    gzip -cd go1.11.linux-amd64.tar.gz | tar -C /usr/local -xf -;\
    rm go*tar.gz"
}

install_local_shfmt() {
  (
    cd /tmp
    git clone https://github.com/mvdan/sh.git
    cd sh
    git checkout master.v3
    go get -u mvdan.cc/sh/v3/cmd/shfmt
  )
}

go version || install_global_go
install_local_shfmt
