#!/bin/bash

set -eEu

function main(){
  local -r input_file="$1"
  local -r output_file="${input_file%".adoc"}.md"

  asciidoctor -b docbook "${input_file}" -o - \
    | pandoc -f docbook -t gfm -o "${output_file}"
}

main $@
