#!/bin/bash
set -e

$(dirname $0)/make_release.sh -s "GP" -t "-a" gridpoint production release

