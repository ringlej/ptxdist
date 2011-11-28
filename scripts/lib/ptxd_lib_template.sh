#!/bin/bash
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


ptxd_template_new() {
	local action="${1}"
	local autoconf_class
	local class

	# define sane defaults
	local template="template-${action}"
	local template_src="${RULESDIR}/templates/${action}"

	case "${action}" in
	target|font|file)
		#template: default
		;;
	host)
		#class: default
		autoconf_class=HOST_
		template=template-class
		;;
	cross)
		#class: default
		autoconf_class=HOST_CROSS_
		template=template-class
		;;
	klibc)
		#class: default
		#template: default
		autoconf_class=KLIBC_
		;;

	src-autoconf-prog|src-autoconf-lib|src-autoconf-proglib)
		#template_src: default
		template=template-src-autoconf
		;;

	src-cmake-prog|src-qmake-prog|src-linux-driver|src-make-prog|src-stellaris)
		#template: default
		#template_src: default
		;;

	help|*)
		echo
		echo "usage: 'ptxdist newpackage <type>', where type is:"
		echo
		echo "  host                     create package for development host"
		echo "  target                   create package for embedded target"
		echo "  cross                    create cross development package"
		echo "  klibc                    create package for initramfs built against klibc"
		echo
		echo "  src-autoconf-lib         create autotoolized library"
		echo "  src-autoconf-prog        create autotoolized binary"
		echo "  src-autoconf-proglib     create autotoolized binary+library"
		echo "  src-cmake-prog           create cmake binary"
		echo "  src-qmake-prog           create qmake binary"
		echo "  src-linux-driver         create a linux kernel driver"
		echo "  src-make-prog            create a plain makefile binary"
		echo "  src-stellaris            create stellaris firmware"
		echo "  font"
		echo "  file                     create package to install existing files"
		echo
		exit 1
		;;
	esac

	#
	# if "autoconf_class" is defines we need a "class", too
	#
	class="${autoconf_class:+${action}-}"

	#
	# Ask some questions
	#
	local package_name
	echo
	echo "${PTXDIST_LOG_PROMPT}creating a new '${action}' package:"
	echo
	read -e -p "${PTXDIST_LOG_PROMPT}enter package name.......: " package_name

	#
	# for host and cross packages, find out if there is already an
	# existing target
	#
	if ptxd_in_path PTXDIST_PATH_RULES "${package_name}.make"; then
		case "${action}" in
		    host|cross)
			action=class-existing-target
			template=template-class-existing-target
			;;
		    klibc)
			action=klibc-existing-target
			template=template-klibc-existing-target
			;;
		esac
	fi


	#
	# more questions ...
	#
	local version
	case "${action}" in
	*-existing-target)
		;;
	*)
		read -e -p "${PTXDIST_LOG_PROMPT}enter version number.....: " version
		;;
	esac

	local url suffix
	case "${action}" in
	host|target|cross|klibc)
		read -e -p "${PTXDIST_LOG_PROMPT}enter URL of basedir.....: " url
		read -e -p "${PTXDIST_LOG_PROMPT}enter suffix.............: " suffix
		;;
	esac

	local -a author_iargs section_iargs
	if echo | read -i foo -p bar -e > /dev/null 2>&1; then
		author_iargs=("-i" "${PTXCONF_SETUP_USER_NAME} <${PTXCONF_SETUP_USER_EMAIL}>")
		section_iargs=("-i" "project_specific")
	else
		author_iargs=()
		section_iargs=()
	fi
	local author
	read -e -p "${PTXDIST_LOG_PROMPT}enter package author.....: " \
		"${author_iargs[@]}" author

	local section
	read -e -p "${PTXDIST_LOG_PROMPT}enter package section....: " \
		"${section_iargs[@]}" section

	local package_filename="${package_name}"
	local package="$(echo ${package_name} | tr "[A-Z]" "[a-z]")"
	local packagedash="$(echo ${package} | tr "[_]" "[\-]")"
	local PACKAGE="$(echo ${package_name} | tr "[a-z-]" "[A-Z_]")"
	local CLASS="$(echo ${class} | tr "[a-z-]" "[A-Z_]")"
	local year="$(date +%Y)"

	local template_suffix
	for template_suffix in "make" "in"; do

		local template_file="${TEMPLATESDIR}/${template}-${template_suffix}"
		local filename="${PTXDIST_WORKSPACE}/rules/${class}${package_filename}.${template_suffix}"

		if [ ! -f "${template_file}" ]; then
			echo
			echo "${PTXDIST_LOG_PROMPT}warning: template '${template_file}' does not exist"
			echo
			continue
		fi

		if [ -f "${filename}" ]; then
			echo
			local overwrite
			read -e -p "${PTXDIST_LOG_PROMPT}warning: ${filename} does already exist, overwrite? [y/n] " overwrite
			if [ "${overwrite}" != "y" ]; then
				echo "${PTXDIST_LOG_PROMPT}aborted."
				echo
				exit
			fi
		fi

	    sed \
		-e "s#\@package_filename@#${package_filename}#g" \
		-e "s#\@PACKAGE@#${PACKAGE}#g" \
		-e "s#\@package@#${package}#g" \
		-e "s#\@packagedash@#${packagedash}#g" \
		-e "s#\@class@#${class}#g" \
		-e "s#\@CLASS@#${CLASS}#g" \
		-e "s#\@AUTOCONF_CLASS@#${autoconf_class}#g" \
		-e "s#\@VERSION@#${version}#g" \
		-e "s#\@URL@#${url}#g" \
		-e "s#\@YEAR@#${year}#g" \
		-e "s#\@AUTHOR@#${author}#g" \
		-e "s#\@SUFFIX@#${suffix}#g" \
		-e "s#\@section@#${section}#g" \
		"${template_file}" \
		> "${filename}" || return
	done

	#
	# for local src-* packages, check if we have to create a template
	#
	case "${action}" in
	src-*)
		local dst="${PTXDIST_WORKSPACE}/local_src/${package}${version:+-${version}}"

		if [ -d "${dst}" ]; then
			return
		fi

		echo
		local r
		read -e -p "${dst#${PTXDIST_WORKSPACE}/} does not exist, create? [Y/n] " r
		case "${r}" in
		    y|Y|"") ;;
		    *) return ;;
		esac

		mkdir -p "${dst}" &&
		tar -C "${template_src}" -cf - --exclude .svn . | \
			tar -C "${dst}" -xvf - &&

		if [ \! -e "${dst}/wizard.sh" ]; then
			return
		fi &&

		( cd "${dst}" && bash wizard.sh "${package}" ) &&
		rm -f "${dst}/wizard.sh" "${package}"
		;;
	esac

}
export -f ptxd_template_new

