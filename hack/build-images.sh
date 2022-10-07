#!/bin/bash

set -eEu

function image::build {
  local -r dir_path="images/${1}"
  local -r image="$(cat ${dir_path}/image.txt)"

  docker build -t "${image}" "${dir_path}"

  if [ -n "${IMAGE_PUSH:-}" ]; then
    docker push "${image}"

    if [ -n "${IMAGE_MAKE_LATEST:-}" ]; then
      local -r latest_tag="$(echo "${image}" | awk -F ':' '{print $1}'):latest"
      docker tag "${image}" "${latest_tag}"
      docker push "${latest_tag}"
    fi
  fi
}

function main() {
  local -r images="$(git diff --name-only HEAD~ images | awk -F '/' '{print $2}' | sort | uniq)"

  for image in $images; do
    image::build "${image}"
  done
}

main $@
