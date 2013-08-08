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
			no-check-certificate|no-proxy)
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
	    --user-agent="PTXdist ${PTXDIST_VERSION_FULL}" \
	    ${PTXDIST_QUIET:+--quiet} \
	    "${opts[@]}" \
	    -O "${temp_file}" \
	    "${url}" && {
		chmod 644 -- "${temp_file}" &&
		file "${temp_file}" | grep -vq " HTML " &&
		touch -- "${temp_file}" &&
		mv -- "${temp_file}" "${path}"
		return
	}

	rm -f -- "${temp_file}"

	# return with failure, we didn't manage to download the file
	return 1
}
export -f ptxd_make_get_http


#
# in env:
#
# ${path}	: local file name
# ${url}	: the url to download
# ${opts[]}	: an array of options
#
ptxd_make_get_git() {
	set -- "${opts[@]}"
	unset opts
	local tag
	local mirror="${url#[a-z]*//}"
	mirror="$(dirname "${path}")/${mirror//\//.}"
	local prefix="$(basename "${path}")"
	prefix="${prefix%.tar.*}/"

	case "${path}" in
	*.tar.gz|*.tar.bz2|*.tar.xz|*.zip)
		;;
	*)
		ptxd_bailout "Only .tar.gz, .tar.bz2, .tar.xz and .zip archives are supported for git downloads."
		;;
	esac

	#
	# scan for valid options
	#
	while [ ${#} -ne 0 ]; do
		local opt="${1}"
		shift

		case "${opt}" in
			tag=*)
				tag="${opt#tag=}"
				;;
			*)
				ptxd_bailout "invalid option '${opt}' to ${FUNCNAME}"
				;;
		esac
	done
	unset opt

	if [ -z "${tag}" ]; then
		ptxd_bailout "git url '${url}' has no 'tag' option"
	fi

	echo "${PROMPT}git: fetching '${url} into '${mirror}'..."
	if [ ! -d "${mirror}" ]; then
		git init --bare --shared "${mirror}"
	else
		git --git-dir="${mirror}" remote remove origin
	fi
	# overwrite everything so the git repository is in a defined state
	git --git-dir="${mirror}" config transfer.fsckObjects true &&
	git --git-dir="${mirror}" config tar.tar.bz2.command "bzip2 -c" &&
	git --git-dir="${mirror}" config tar.tar.xz.command "xz -c"
	git --git-dir="${mirror}" remote add origin "${url}" &&
	git --git-dir="${mirror}" fetch --progress -pf origin "+refs/*:refs/*"  &&

	if ! git --git-dir="${mirror}" rev-parse --verify -q "${tag}" > /dev/null; then
		ptxd_bailout "git: tag '${tag}' not found in '${url}'"
	fi &&

	git --git-dir="${mirror}" archive --prefix="${prefix}" -o "${path}" "${tag}"
}
export -f ptxd_make_get_git


#
# in env:
#
# ${path}	: local file name
# ${url}	: the url to download
# ${opts[]}	: an array of options
#
ptxd_make_get_svn() {
	set -- "${opts[@]}"
	unset opts
	local rev
	local tarcomp
	local mirror="${url#[a-z]*//}"
	mirror="$(dirname "${path}")/${mirror//\//.}"
	local prefix="$(basename "${path}")"
	prefix="${prefix%.tar.*}"

	case "${path}" in
	*.tar.gz)
		tarcomp="--gzip"
		;;
	*.tar.bz2)
		tarcomp="--bzip2"
		;;
	*.tar.xz)
		tarcomp="--xz"
		;;
	*)
		ptxd_bailout "Only .tar.gz, .tar.bz2, .tar.xz and archives are supported for svn downloads."
		;;
	esac

	#
	# scan for valid options
	#
	while [ ${#} -ne 0 ]; do
		local opt="${1}"
		shift

		case "${opt}" in
			rev=*)
				rev="${opt#rev=}"
				;;
			*)
				ptxd_bailout "invalid option '${opt}' to ${FUNCNAME}"
				;;
		esac
	done
	unset opt

	if [ -z "${rev}" ]; then
		ptxd_bailout "svn url '${url}' has no 'rev' option"
	fi

	echo "${PROMPT}svn: fetching '${url} into '${mirror}'..."
	if [ ! -d "${mirror}" ]; then
		svn checkout -r ${rev} "${url}" "${mirror}"
	else
		svn update -r ${rev} "${mirror}"
	fi &&
	lmtime=$(svn info -r ${rev} "${mirror}" | \
		awk '/^Last Changed Date:/ {print $4 " " $5 " " $6}') &&
	echo "${PROMPT}svn: last modification time '${lmtime}'" &&
	tar --exclude-vcs --show-stored-names ${tarcomp} \
		--mtime="${lmtime}" --transform "s|^\.|${prefix}|g" \
		--create --file "${path}" -C "${mirror}" .
}
export -f ptxd_make_get_svn


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
# - no-proxy			don't use proxy even if configured
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
		git://*|http://*".git;"*|https://*".git;"*)
			# restrict donwload only to the PTXMIRROR
			if [ -z "${PTXCONF_SETUP_PTXMIRROR_ONLY}" ]; then
				# keep original URL
				argv[${#argv[@]}]="${url}"
			fi
			# add mirror to URLs, but only once
			if ! ${mrd}; then
				ptxmirror_url="${path/#\/*\//${PTXCONF_SETUP_PTXMIRROR}/}"
				mrd=true
			fi
			;;
		svn://*)
			# restrict donwload only to the PTXMIRROR
			if [ -z "${PTXCONF_SETUP_PTXMIRROR_ONLY}" ]; then
				# keep original URL
				argv[${#argv[@]}]="${url}"
			fi
			# add mirror to URLs, but only once
			if ! ${mrd}; then
				ptxmirror_url="${path/#\/*\//${PTXCONF_SETUP_PTXMIRROR}/}"
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
		git://*|http://*.git|https://*.git)
			ptxd_make_get_download_permitted &&
			ptxd_make_get_git && return
			;;
		svn://*)
			ptxd_make_get_download_permitted &&
			ptxd_make_get_svn && return
			;;
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
	echo "Could not download package"
	echo "URL: ${orig_argv[@]}"
	echo
	exit 1
}

export -f ptxd_make_get
