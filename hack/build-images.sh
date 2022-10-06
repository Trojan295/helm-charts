#!/bin/bash

set -eEu

IMAGES=( gothic2-online )

function image::build {
  local -r dir_path="images/${1}"
  local -r image="$(cat ${dir_path}/image.txt)"

  docker build -t "${image}" "${dir_path}"

  if [ -n "${IMAGE_PUSH:-}" ]; then
    docker push "${image}"
  fi
}

function main() {
  for image in ${IMAGES[@]}; do
    image::build "${image}"
  done
}

main $@
