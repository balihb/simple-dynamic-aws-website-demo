#!/usr/bin/env bash

set -euo pipefail

getent passwd "$GITHUB_UID" >/dev/null && echo "User already exists" ||
  adduser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password --home "${GITHUB_HOME}" --uid "${GITHUB_UID}" "${GITHUB_USERNAME}" &&
  usermod -a -G sudo,docker "${GITHUB_USERNAME}" &&
  echo "${GITHUB_USERNAME} ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers

chmod -R 777 /tmp
chmod -R 777 /opt
chown -R "${GITHUB_UID}" "${GITHUB_HOME}"
chmod -R 777 "${GITHUB_HOME}"

export USER_HOME="${GITHUB_HOME}"
export USER_NAME="${GITHUB_USERNAME}"
export USER_ID="${GITHUB_UID}"

cd "${GITHUB_WORKSPACE}"
# uncomment for extended config checks
# runuser -u "${GITHUB_USERNAME}" renovate-config-validator
# RENOVATE_PRINT_CONFIG=true RENOVATE_DRY_RUN="extract" FORCE_COLOR="0" runuser -u "${GITHUB_USERNAME}" renovate > renovate-effective-config.log
runuser -u "${GITHUB_USERNAME}" renovate
