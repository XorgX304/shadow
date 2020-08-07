#!/bin/bash

set -euo pipefail

case "$CC" in
gcc)
  export CXX=g++
  ;;
clang)
  export CXX=clang++
  ;;
*)
  echo "Unknown cc $CC"
  exit 1
  ;;
esac

case "$BUILDTYPE" in
    release)
        OPTIONS=""
        rustup default stable
        ;;
    debug)
        OPTIONS="--debug"
        rustup default stable
        ;;
    coverage)
        OPTIONS="--debug --coverage"
        rustup default nightly
        ;;
    *)
        echo "Unknown BUILDTYPE $BUILDTYPE"
        exit 1
        ;;
esac

./setup build -j4 --test --werror $OPTIONS
./setup install