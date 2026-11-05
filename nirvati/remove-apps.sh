#!/bin/sh
# Removes the apps listed in nirvati/removed-apps.txt from apps/.
# Run from anywhere after merging upstream, then commit the result.
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$root/nirvati/removed-apps.txt" | while read -r app; do
  case "$app" in
    */* | . | ..) echo "Invalid app name: $app" >&2; exit 1 ;;
  esac
  if [ -e "$root/apps/$app" ]; then
    git -C "$root" rm -rq --ignore-unmatch -- "apps/$app"
    rm -rf "${root:?}/apps/$app"
    echo "Removed $app"
  fi
done
