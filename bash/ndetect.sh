#!/bin/bash

HOST=${1:-127.0.0.1}
PORT=$(echo "${@:2}" | grep -o "[^ ]\+\( \+[^ ]\+\)*")

if [[ -z "$PORT" ]]; then
  PORT="22 25 80 8080 53436"
fi

for port in $PORT; do
  if echo &>/dev/null > /dev/tcp/$HOST/$port; then
    printf "%15s    %-5s    %04s\n" "${HOST}" "${port}" "open"
  else
    printf "%15s    %-5s    %04s\n" "${HOST}" "${port}" "close"
  fi
done
