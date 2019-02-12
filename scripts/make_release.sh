#!/bin/bash

set -e

usage() {
cat <<-EOF

Usage: `basename "$0"` OPTIONS [origin] [master] [stable]

    -h              this help
    -t <tagopts>    Options to pass to git tag. Default: -s
    -s <suffix>     Suffix to append to release tag name. Default is no suffix

    [origin]        The git remote to push to. Default: origin
    [master]        The master branch for new releases. Default: master
    [stable]        The stable/ branch branch dir for stable releases. Default: stable
EOF
}

suffix=
tagopts=-s

while getopts "ht:s:" OPT
do
    case "$OPT" in
	h)
	    usage
	    exit 1
	    ;;
	t)
	    tagopts="$OPTARG"
	    ;;
	s)
	    suffix="_$OPTARG"
	    ;;
    esac
done
shift $(expr $OPTIND - 1)

origin=${1:-origin}
master=${2:-master}
stable=${3:-stable}
master_date=${4:-$(date +%Y.%m)}

v="ptxdist-"

branch="$(git symbolic-ref HEAD)"
branch="${branch##refs/heads/}"

trap_exit_handler() {
    if [ -n "${tmp}" -a -d "${tmp}" ]; then
	rm -rf "${tmp}"
    fi
}
trap 'trap_exit_handler' 0 1 15

# Update index only on r/w media
if [ -w . ]; then
    git update-index --refresh --unmerged > /dev/null || true
fi

# Check for uncommitted changes
if git diff-index --name-only HEAD \
    | read dummy; then
    echo "tree dirty, refusing to make a release" >&2
    exit 1
fi

# guess if we're going to make a new or stable release
case "${branch}" in
    ${master})
	release="${v}${master_date}.0${suffix}"
	prev_release="${v}*.0${suffix}"
	;;
    ${stable}/*)
	release="${branch##${stable}/}"
	release="${release%.x${suffix}}"
	inc="$(git tag -l "${release}.*${suffix}" | wc -l)"
	if [ ${inc} -eq 0 ]; then
	    echo "about to make stable a release for '${release}', but no '.0' found" >&2
	    exit 1
	fi
	prev_release="${release}.$((inc - 1))${suffix}"
	release="${release}.${inc}${suffix}"
	;;
    *)
	echo "please checkout either ${master} or ${stable} branch" >&2
	exit 1
	;;
esac

# get previous release
prev_release=( $(git tag -l "${prev_release}" | sort -r -n) )
if [ -z "${prev_release}" ]; then
    echo "previous release not found" >&2
    exit 1
fi

# check if to-be-made release already exists
if git rev-parse -q --verify "refs/tags/$release" >/dev/null 2>&1; then
    echo "release '${release}' already exists" >&2
    exit 1
fi

tmp="$(mktemp -d /tmp/${0##*/}.XXXXXX)"
log="${tmp}/log"

# create tag message
printf "${release}\n\n" > "${log}"
git shortlog "${prev_release}"..HEAD >> "${log}"
echo "creating tag '${release}'"
git tag ${tagopts} -F "${log}" "${release}"

# create tarball
here="$(pwd)"
pushd "${tmp}" >/dev/null
git clone "${here}" "${release}"
cd "${release}"
git checkout "${release}"

./autogen.sh
./configure
make
make dist
popd >/dev/null

# now push to origin
echo
echo "pushing '${release}' to $origin, press '[Ctrl] + c' to abort"
echo
read
git push "${origin}" "${branch}"
git push "${origin}" "${release}"
mv "${tmp}/${release}/"*tar.bz2* "${here}"
