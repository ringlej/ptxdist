#!/bin/bash
#
# (c) 2012 Bernhard Walle <bernhard@bwalle.de>
#

# This function is Darwin (Mac OS) specific. Helper function for
# ptxd_make_world_install_library_path.
#
# It should be invoked on one binary in ptxdist platform-*/sysroot-host (both
# for executables and libraries after installation. For binaries and libraries,
# edits the dependent shared library install name to point to sysroot-host/lib.
# For libraries only it changes also the install name (-id). That way the
# binaries linked against a library in sysroot-target/lib can be executed
# directly without setting environment variables.
#
# Arguments: $1 - the binary
ptxd_make_world_install_library_path_one()
{
    local binary="$1"
    local filename installfile

    for used_library in $(otool -LX "${binary}" | awk '{print $1}') ; do
	filename="$(basename "${used_library}")"

	# if the library exists in sysroot-host, we use that one
	# using @executable_path even keeps the tree relocatable.
	installfile="${PTXDIST_SYSROOT_HOST}/lib/${filename}"
	if [ -r "${installfile}" ] ; then
	    install_name_tool -change \
		"${used_library}" "${installfile}" \
		"${binary}"
	fi

	# if it's a library, change also the ID so that binaries
	# that link against the binary get it right in the first
	# place (so they can get executed before installation)
	if [[ ${installfile} == *.dylib ]] ; then
	    install_name_tool -id "${binary}" "${binary}"
	fi
    done
}
export -f ptxd_make_world_install_library_path_one

# This function is Darwin (Mac OS) specific. It does nothing on other
# operating systems.
#
# The function gets invoked in install.post stage after the binaries
# have been copied from the package dir to the sysroot-host directory.
# The function must be called with the package directory as argument.
# For every binary (library and executable) in that package directory
# it translates the path to the correspondent path after copying
# to the sysroot-host and invokes ptxd_make_world_install_library_path_one
# which finally edits the install path of libaries/executables.
ptxd_make_world_install_library_path()
{
    if [ "$(uname -s)" != Darwin ] ; then
	return
    fi

    local file
    local installed_file

    echo "install.post: Fixup library paths"
    for file in $(find "${pkg_pkg_dir}" -type f) ; do

	# skip non-Mach-O files
	file -b "${file}" | grep -q '^Mach-O' || continue

	installed_file=$(echo $file | sed -e "s@${pkg_pkg_dir}@${pkg_sysroot_dir}@g")

	ptxd_make_world_install_library_path_one "${installed_file}"
    done

    echo "install.post: Fixup library paths: done"
}
export -f ptxd_make_world_install_library_path
