#!/bin/bash
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# in env:
#
# ${path}	: local file name
# ${url}	: the url to download
# ${opts[]}	: an array of options
#
ptxd_make_get_http() {
	set -- "${opts[@]}"
	unset opts

	#
	# scan for valid options
	#
	while [ ${#} -ne 0 ]; do
		local opt="${1}"
		shift

		case "${opt}" in
			no-check-certificate)
				opts[${#opts[@]}]="--${opt}"
				;;
			*)
				ptxd_bailout "invalid option '${opt}' to ${FUNCNAME}"
				;;
		esac
	done
	unset opt

	#
	# download to temporary file first, move it to correct
	# file name after successfull download
	#
	local file="${url##*/}"

	# remove any pending or half downloaded files
	rm -f -- "${path}."*

	local temp_file="$(mktemp "${path}.XXXXXXXXXX")" || ptxd_bailout "failed to create tempfile"
	wget \
	    --passive-ftp \
	    --progress=bar:force \
	    --timeout=30 \
	    --tries=5 \
	    ${PTXDIST_QUIET:+--quiet} \
	    "${opts[@]}" \
	    -O "${temp_file}" \
	    "${url}" && {
		chmod 644 -- "${temp_file}" &&
		mv -- "${temp_file}" "${path}"
		return
	}

	rm -f -- "${temp_file}"

	# return with failure, we didn't manage to download the file
	return 1
}
export -f ptxd_make_get_http


#
# check if download is disabled
#
# in env:
#
# ${url}	: the url to download
#
ptxd_make_get_download_permitted() {
	if [ -n "${PTXCONF_SETUP_NO_DOWNLOAD}" -a -z "${PTXDIST_FORCE_DOWNLOAD}" ]; then {
		cat <<EOF

error: automatic download prohibited

Please download '${url}'
manually into '${PTXDIST_SRCDIR}'

EOF
		set -- ${orig_argv[@]}
		if [ $# -ne 1 ]; then
			echo "If this URL doesn't work, you may try these ones:"
			while [ ${#} -ne 0 ]; do
				[ "${1}" != "${url}" ] && echo "'${1}'"
				shift
			done
			echo
		fi
		exit 1; } >&2
	fi
}
export -f ptxd_make_get_download_permitted


#
# $1: target source path (including file name)
# $@: possible download URLs, seperated by space
#
# options seperated from URLs by ";"
#
# valid options:
# - no-check-certificate	don't check server certificate (https only)
#
ptxd_make_get() {
	local -a argv
	local ptxmirror_url
	local mrd=false		# is mirror already part of urls?

	local path="${1}"
	shift

	local -a orig_argv
	orig_argv=( "${@}" )

	if [ -z "${1}" ]; then
		echo
		echo "${PROMPT}error: empty parameter to '${FUNCNAME}'"
		echo
		exit 1
	fi

	#
	# split by spaces, etc
	#
	set -- ${@}

	while [ ${#} -gt 0 ]; do
		local url="${1}"
		shift

		case "${url}" in
		${PTXCONF_SETUP_PTXMIRROR}/*/*)
			# keep original URL, for stuff like glibc
			argv[${#argv[@]}]="${url}"
			mrd=true
			;;
		${PTXCONF_SETUP_PTXMIRROR}/*)
			# if mirror is given us to download, add it, but only once
			if ! ${mrd}; then
				argv[${#argv[@]}]="${url}"
				mrd=true
			fi
			;;
		http://*|https://*|ftp://*)
			# restrict donwload only to the PTXMIRROR
			if [ -z "${PTXCONF_SETUP_PTXMIRROR_ONLY}" ]; then
				# keep original URL
				argv[${#argv[@]}]="${url}"
			fi

			# add mirror to URLs, but only once
			if ! ${mrd}; then
				ptxmirror_url="${url/#*:\/\/*\//${PTXCONF_SETUP_PTXMIRROR}/}"
				mrd=true
			fi
			;;
		file://*)
			# keep original URL
			argv[${#argv[@]}]="${url}"
		esac
	done
	if [ -n "${ptxmirror_url}" ]; then
		argv[${#argv[@]}]="${ptxmirror_url}"
	fi

	set -- "${argv[@]}"

	while [ ${#} -ne 0 ]; do
		#
		# strip options which are seperated by ";" form the
		# URL, store in "opts" array
		#
		local orig_ifs="${IFS}"
		IFS=";"
		local -a opts
		opts=( ${1} )
		IFS="${orig_ifs}"
		unset orig_ifs

		local url="${opts[0]}"
		unset opts[0]

		shift

		case "${url}" in
		http://*|https://*|ftp://*)
			ptxd_make_get_download_permitted &&
			ptxd_make_get_http && return
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
