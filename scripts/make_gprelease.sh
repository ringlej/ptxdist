#!/bin/bash
set -e

$(dirname $0)/make_release.sh -s "GP" -t "-a" origin master support

