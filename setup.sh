#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/RAL0S/ook-decoder/releases/download/vcc108f9/go-clients.tar.gz -O $RALPM_TMP_DIR/go-clients.tar.gz
  tar xf $RALPM_TMP_DIR/go-clients.tar.gz -C $RALPM_PKG_INSTALL_DIR/
  rm $RALPM_TMP_DIR/go-clients.tar.gz

  wget https://github.com/RAL0S/ook-decoder/releases/download/vcc108f9/ookbins.tar.gz -O $RALPM_TMP_DIR/ookbins.tar.gz
  tar xf $RALPM_TMP_DIR/ookbins.tar.gz -C $RALPM_PKG_INSTALL_DIR/
  rm $RALPM_TMP_DIR/ookbins.tar.gz

  ln -s $RALPM_PKG_INSTALL_DIR/ookdump $RALPM_PKG_BIN_DIR/
  ln -s $RALPM_PKG_INSTALL_DIR/ookd $RALPM_PKG_BIN_DIR/
  ln -s $RALPM_PKG_INSTALL_DIR/ookanalyze $RALPM_PKG_BIN_DIR/
  ln -s $RALPM_PKG_INSTALL_DIR/ookplay $RALPM_PKG_BIN_DIR/
  ln -s $RALPM_PKG_INSTALL_DIR/ooklog $RALPM_PKG_BIN_DIR/
}

uninstall() {
  rm -rf $RALPM_PKG_INSTALL_DIR/*
  rm $RALPM_PKG_BIN_DIR/ook{dump,d,analyze,play,log}
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1