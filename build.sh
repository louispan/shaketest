#!/bin/sh
mkdir -p .shake
cabal --ghc v2-build shaketest && cabal v2-exec shaketest -- "$@"
