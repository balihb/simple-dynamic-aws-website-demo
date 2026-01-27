#!/usr/bin/env bash

set -euo pipefail

LOCAL_RENOVATE_DEPS_FILE=${LOCAL_RENOVATE_DEPS_FILE:?}

if [ -e "$LOG_FILE" ] && [ ! -f "$LOG_FILE" ]; then
  echo "Error: $LOG_FILE exists but is not a regular file" >&2
  exit 1
fi

if [ -f "$LOG_FILE" ] && [ ! -r "$LOG_FILE" ]; then
  echo "Error: $LOG_FILE is not readable" >&2
  exit 1
fi

if [ -f "$LOG_FILE" ]; then
  echo "${LOG_FILE} found"
  jq -nS '
    reduce (inputs
    | select(.repository? and .baseBranch? and .config?)
    ) as $o
    ({}; .[$o.baseBranch] = $o.config)
  ' "$LOG_FILE" > "$LOCAL_RENOVATE_DEPS_FILE"
else
  echo "${LOG_FILE} not found"
  echo '{}' >"$LOCAL_RENOVATE_DEPS_FILE"
  echo '{}' >"$LOG_FILE"
fi
