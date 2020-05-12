#!/bin/bash
set -exuo pipefail
IFS=$'\n\t'

ANSIBLE_VERSION=${1:-}
if [ -z "${ANSIBLE_VERSION}" ]; then
  echo "${0} <ansible_version>"
  exit 1
fi

apt-get update
apt-get upgrade -y
apt-get install -y libffi-dev
python -m pip install --upgrade pip

PYTHONUSERBASE=$(pwd)/vendored/ansible pip install --user --ignore-installed --upgrade \
  ansible==${ANSIBLE_VERSION} netaddr jmespath

find $(pwd)/vendored/ansible -type d -exec chmod 777 {} \;
find $(pwd)/vendored/ansible/lib -type f -exec chmod 666 {} \;
find $(pwd)/vendored/ansible/bin -type f -exec chmod 777 {} \;
