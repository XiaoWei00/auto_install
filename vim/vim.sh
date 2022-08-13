#!/usr/bin/env bash

set -ex
function install() {
    sudo apt-get update
    sudo apt-get install vim -y
}

function version() {
    vim --version
    return $?
}

$1
exit $?