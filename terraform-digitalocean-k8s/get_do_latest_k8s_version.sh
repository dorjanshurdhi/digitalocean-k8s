#!/bin/bash

check_deps() {
  test -f $(which jq) || error_exit "jq command not detected in path, please install it"
  test -f $(which curl) || error_exit "curl command not detected in path, please install it"
}

TOKEN="dop_v1_0b1d3e57cc3f0c71ba853b2a0271121a366a179432332959f5a65a261abe2a1c"

#parse_input() {
#  eval "$(jq -r '@sh "export TOKEN=dop_v1_0b1d3e57cc3f0c71ba853b2a0271121a366a179432332959f5a65a261abe2a1c"')"
#  if [[ -z "${TOKEN}" ]]; then export TOKEN=none; fi
#}

return_version() {
  VERSION=$(curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/kubernetes/options" | jq .options.versions | jq 'values[0]' | jq -r .slug)
  jq -n \
    --arg version "$VERSION" \
    '{"version":$version}'
}

check_deps && \
#parse_input && \
sleep 2 && \
return_version
