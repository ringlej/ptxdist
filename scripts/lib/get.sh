#!/bin/bash

#
# $@: possible download URLs, seperated by space
#
ptxd_make_get() {
	local orig_argv=( "${@}" )

	if [ -z "${1}" ]; then
		echo
		echo "${PROMPT}error: empty parameter to '${FUNCNAME}'"
		echo
		exit 1
	fi

	# split URLs by spaces
	set -- ${*}

	while [ ${#} -ne 0 ]; do
		local url="${1}"
		shift

		case "${url}" in
		http://*|ftp://*)
			wget \
			    -t 5 \
			    --progress=bar:force \
			    --passive-ftp \
			    ${PTXDIST_QUIET:+--quiet} \
			    -P "${PTXDIST_SRCDIR}" \
			    "${url}" && return
			;;
		file*)
			local thing="${url/file:\/\///}"

			if [ -f "$thing" ]; then
				echo "local archive, copying"
				cp -av "${thing}" "${PTXDIST_SRCDIR}" && return
			elif [ -d "${thing}" ]; then
				echo "local directory instead of tar file, skipping get"
				return
			else
				thing="${url/file:\/\//./}"
				if [ -d "${thing}" ]; then
					echo "local project directory instead of tar file, skipping get"
					return
				fi
			fi
			;;
		*)
			echo
			echo "Unknown URL Type!"
			echo "URL: $url"
			echo
			exit 1
			;;
		esac
	done

	echo
	echo "Could not download packet"
	echo "URL: ${orig_argv[@]}"
	echo
	exit 1
}

export -f ptxd_make_get
