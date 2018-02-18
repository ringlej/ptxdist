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
	local -a curl_opts
	local temp_file temp_header
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
				curl_opts[${#curl_opts[@]}]="--insecure"
				;;
			no-proxy)
				opts[${#opts[@]}]="--${opt}"
				curl_opts[${#curl_opts[@]}]="--noproxy"
				curl_opts[${#curl_opts[@]}]="*"
				;;
			cookie:*)
				opts[${#opts[@]}]="--no-cookies"
				opts[${#opts[@]}]="--header"
				opts[${#opts[@]}]="Cookie: ${opt#cookie:}"
				curl_opts[${#curl_opts[@]}]="--cookie"
				curl_opts[${#curl_opts[@]}]="${opt#cookie:}"
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

	temp_file="$(mktemp "${path}.XXXXXXXXXX")" || ptxd_bailout "failed to create tempfile"
	ptxd_make_serialize_take
	if [ "${ptxd_make_get_dryrun}" != "y" ]; then
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
		    ptxd_make_serialize_put
		    return
	    }
	else
	    echo "Checking URL '${url}'..."
	    temp_header="$(mktemp "${PTXDIST_TEMPDIR}/urlcheck.XXXXXX")" || ptxd_bailout "failed to create tempfile"
	    curl \
		--ftp-pasv \
		--connect-timeout 30 \
		--retry 5 \
		--user-agent "PTXdist ${PTXDIST_VERSION_FULL}" \
		"${curl_opts[@]}" \
		-o /dev/null \
		--dump-header "${temp_header}" \
		--fail \
		--location \
		--head \
		--request GET \
		"${url}" &&
		if grep -i "content-type:" "${temp_header}" | tail -n 1 | grep -q "text/html"; then
		    ptxd_bailout "Got HTML file"
		fi
		ptxd_make_serialize_put
		return
	fi &&
	ptxd_make_serialize_put

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

	ptxd_make_serialize_take
	if [ "${ptxd_make_get_dryrun}" = "y" ]; then
	    echo "Checking URL '${url}'..."
	    git ls-remote --quiet "${url}" HEAD > /dev/null
	    ptxd_make_serialize_put
	    return
	fi
	echo "${PROMPT}git: fetching '${url} into '${mirror}'..."
	if [ ! -d "${mirror}" ]; then
		git init --bare --shared "${mirror}"
	else
		git --git-dir="${mirror}" remote rm origin
	fi &&
	# overwrite everything so the git repository is in a defined state
	git --git-dir="${mirror}" config transfer.fsckObjects true &&
	git --git-dir="${mirror}" config tar.tar.bz2.command "bzip2 -c" &&
	git --git-dir="${mirror}" config tar.tar.xz.command "xz -c" &&
	git --git-dir="${mirror}" remote add origin "${url}" &&
	git --git-dir="${mirror}" fetch --progress -pf origin "+refs/*:refs/*"  &&
	# at least for some git versions this is not group writeable for shared repos
	if [ "$(stat -c '%A' "${mirror}/FETCH_HEAD" | cut -c 6)" != "w" ]; then
		chmod g+w "${mirror}/FETCH_HEAD"
	fi &&

	if ! git --git-dir="${mirror}" rev-parse --verify -q "${tag}" > /dev/null; then
		ptxd_make_serialize_put
		ptxd_bailout "git: tag '${tag}' not found in '${url}'"
	fi &&

	git --git-dir="${mirror}" archive --prefix="${prefix}" -o "${path}" "${tag}"
	ptxd_make_serialize_put
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

	ptxd_make_serialize_take
	if [ "${ptxd_make_get_dryrun}" = "y" ]; then
	    echo "Checking URL '${url}'..."
	    svn ls "${url}" > /dev/null
	    ptxd_make_serialize_put
	    return
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
	GZIP=-n tar --exclude-vcs --show-stored-names ${tarcomp} \
		--mtime="${lmtime}" --transform "s|^\.|${prefix}|g" \
		--create --file "${path}" -C "${mirror}" .
	ptxd_make_serialize_put
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
manually into '$(dirname ${path})'

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

	ptxmirror_url="${path/#\/*\//${ptxd_make_get_mirror}/}"

	#
	# split by spaces, etc
	#
	set -- ${@}

	while [ ${#} -gt 0 ]; do
		local add=true
		local url="${1}"
		shift

		if [[ "${url}" =~ "file://" ]]; then
			# keep original URL
			argv[${#argv[@]}]="${url}"
			# assume, that local URLs are always available
			ptxmirror_url=
			continue
		fi
		# restrict donwload only to white-listed URLs
		if [ -n "${PTXCONF_SETUP_PTXMIRROR_ONLY}" ]; then
			local pattern
			add=false
			for pattern in "${ptxd_make_get_mirror}" \
					${PTXCONF_SETUP_URL_WHITELIST}; do
				if [[ "${url}" =~ "${pattern}" ]]; then
					add=true
					break
				fi
			done
		fi
		if ${add}; then
			argv[${#argv[@]}]="${url}"
			if [ "${url}" = "${ptxmirror_url}" ]; then
				# avoid duplicates
				ptxmirror_url=
			fi
		fi
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
		git://*|http://*.git|https://*.git|ssh://*.git)
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
				echo "local archive, skiping get"
				return
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

	if [ "${ptxd_make_get_nofail}" != "y" ]; then
		echo
		echo "Could not download package"
		echo "URL: ${orig_argv[@]}"
		echo
		exit 1
	fi
}
export -f ptxd_make_get
