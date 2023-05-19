#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ ${1-} == -h ]] || [[ ${1-} == --help ]]; then
  echo "Usage: ./auto-tag.sh

Run this script from your git directory to tag commits based on a YAML file.

WARNING: This will reset all local and remote tags.

The YAML file must be located at .tags.yml with the following format:

  tag: # The name of the tag to add.
    commit: # The exact commit message to match.
    message: # Optional message of the tag to add.

For example:

  - tag: 0.1.0
    commit: Set version to 0.1.0
  - tag: 0.2.0
    commit: Bump minor version
    message: Add dynamic indexing

1. Finds the 'Set version to 0.1.0' commit and sets the tag to '0.1.0'.
2. Finds the 'Bump minor version' commit and sets the tag to '0.2.0' with a message."
  exit
fi

main() {
  dir="$PWD"
  cd "$(dirname "$0")"
  ruby auto_tag.rb "$dir"
}

main "$@"
