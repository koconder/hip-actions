#!/bin/bash

DIR="$(dirname "$0")"

for cmd in prettier yamllint; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "[ERROR] $cmd not installed, run \"brew install $cmd\""
        exit 1
    fi
done

echo "[INFO] Linting all YAML files in $(realpath "${DIR}")"

# shellcheck disable=SC2068
if prettier "${DIR}/**/*.{yaml,yml}" -c $@ && yamllint "${DIR}" --no-warnings; then
    echo "[INFO] OK"
    exit 0
else
    echo "[ERROR] Linting failed, check log"
    exit 1
fi