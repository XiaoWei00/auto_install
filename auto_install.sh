#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

CONFIG_FILE="${SCRIPT_DIR}/auto_install.config"

supported_applicatios=(
    vim
    git
)

function install() {
    app=$1
    "${SCRIPT_DIR}/${app}/${app}.sh" install
}

function is_exist() {
    app=$1
    "${SCRIPT_DIR}/${app}/${app}.sh" version
    return $?
}

function is_support() {
    app=$1
    for x in $supported_applicatios; do
        if [ "$x" = "${app}" ]; then
            return 0
        fi
    done
    return 1
}

function handle_application() {
    application=$1
    if ! is_support ${application}; then
        echo "the ${application} is not supported"
        return 1
    fi

    if is_exist ${application}; then
        echo "the ${application} is exist"
        return 0
    fi

    install ${application}

    if is_exist ${application}; then
        echo "${application} install successfully"
    else
        echo "Failed to install ${application}"
    fi
}

while read -r line; do
    handle_application ${line}
done <"$CONFIG_FILE"
