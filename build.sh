#!/bin/sh
cabal --ghc v2-build shaketest && cabal v2-exec shaketest -- "$@"
