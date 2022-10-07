#!/bin/bash

set -eEu

CHARTS=( gothic2-online )
REPO_URL="https://charts.myhightech.org"
REPO_NAME="myhightech"
REPO_USER="${REPO_USER}"
REPO_PASSWORD="${REPO_PASSWORD}"

function chart::push {
  local -r dir_path="charts/${1}"

  helm cm-push \
    -u "$REPO_USER" \
    -p "$REPO_PASSWORD" \
    "${dir_path}" \
    "$REPO_NAME"
}

function main() {
  helm repo add "$REPO_NAME" "$REPO_URL"

  for chart in ${CHARTS[@]}; do
    chart::push "${chart}"
  done
}

main $@
