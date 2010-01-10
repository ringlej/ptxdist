# -*-makefile-*-
#
# Copyright (C) 2004-2009 by the ptxdist project
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# patchin
#
# Go into a directory and apply all patches from there into a
# sourcetree. if a series file exists in that directory the
# patches from the series file are used instead of all patches.
# If parameter $3 is given, this series file will be used,
# not a derived one.
# if the variable PTXCONF_$(PACKET_LABEL)_SERIES exists, the
# series file from this variable is used instead of "series"
# This macro skips if $1 points to a local directory.
# 'generic'-directories are obsolete and just supported for
# backwards compatibility.
#
# $1: packet label; $($(1)_NAME) -> identifier
# $2: path to source tree
#     if this parameter is omitted, the path will be derived
#     from the packet name
# $3: abs path to series file
#
patchin =											\
	PACKET_NAME="$($(strip $(1)))"; 							\
	URL="$($(strip $(1))_URL)";								\
	PACKET_DIR="$(strip $(2))";								\
												\
	if [ "$$PACKET_NAME" = "" ]; then							\
		echo;										\
		echo Error: empty parameter to \"patchin\(\)\";					\
		echo;										\
		exit 1;										\
	fi;											\
												\
	echo "PATCHIN: packet=$$PACKET_NAME";							\
												\
	APPLY_PATCH=true;									\
	case $$URL in										\
	file*)											\
		THING="$$(echo $$URL | sed s-file://-/-g)";					\
		if [ -d "$$THING" -a "$(strip $(1))" != "KERNEL" ]; then			\
			echo "local directory instead of tar file, skipping patch"; 		\
			APPLY_PATCH=false;							\
		fi; 										\
	esac; 											\
												\
												\
	PACKET_DIR=$${PACKET_DIR:-$(BUILDDIR)/$$PACKET_NAME};					\
	echo "PATCHIN: dir=$$PACKET_DIR";							\
												\
	if [ ! -d $${PACKET_DIR} ]; then							\
		echo;										\
		echo "Error: dir \"$${PACKET_DIR}\" does not exist";				\
		echo;										\
		exit 1;										\
												\
	fi;											\
												\
	if $${APPLY_PATCH}; then								\
		patch_dirs="$(PROJECTPATCHDIR)/$$PACKET_NAME/generic				\
			    $(PROJECTPATCHDIR)/$$PACKET_NAME					\
		            $(PTXDIST_PLATFORMCONFIGDIR)/patches/$$PACKET_NAME/generic		\
		            $(PTXDIST_PLATFORMCONFIGDIR)/patches/$$PACKET_NAME			\
		            $(PATCHDIR)/$$PACKET_NAME/generic					\
		            $(PATCHDIR)/$$PACKET_NAME";						\
												\
		for dir in $$patch_dirs; do							\
			if [ -d $$dir ]; then							\
				patch_dir=$$dir;						\
				break;								\
			fi;									\
		done;										\
												\
		if [ -z "$$patch_dir" ]; then							\
			echo "PATCHIN: no patches for $$PACKET_NAME available";			\
		else										\
			PACKET_SERIES="$(PTXCONF_$(strip $(1))_SERIES)";			\
			if [ -n "$$PACKET_SERIES" -a ! -f "$$patch_dir/$$PACKET_SERIES" ]; then	\
				echo -n "Series file for $$PACKET_NAME given, but series file ";\
				echo "\"$$patch_dir/$$PACKET_SERIES\" does not exist";		\
				exit 1;								\
			fi;									\
												\
			if [ -z "$$PACKET_SERIES" ]; then					\
				PACKET_SERIES="series";						\
			fi;									\
			ABS_SERIES_FILE="$$patch_dir/$$PACKET_SERIES";				\
												\
			if [ -f "$${ABS_SERIES_FILE}" ]; then					\
				echo "PATCHIN: using series file $${ABS_SERIES_FILE}";		\
				$(SCRIPTSDIR)/apply_patch_series.sh -s "$${ABS_SERIES_FILE}"	\
					-d $$PACKET_DIR;					\
			else									\
				$(SCRIPTSDIR)/apply_patch_series.sh -p "$$patch_dir"		\
					-d $$PACKET_DIR	;					\
			fi;									\
			if [ "$$?" -gt 0 ]; then exit 1; fi;					\
		fi;										\
	fi;											\
												\
	autogen_sh="$${patch_dir}/autogen.sh";							\
	if [ -x "$${autogen_sh}" ]; then							\
		echo "PATCHIN: running autogen"; 						\
		( cd "$${PACKET_DIR}" &&"$${autogen_sh}" ) || exit 1;				\
	fi; 											\
												\
	case "$(notdir $@)" in									\
		(host-*|cross-*)	exit 0;;						\
	esac;											\
												\
	find "$${PACKET_DIR}/" -name "configure" -a -type f -a \! -path "*/.pc/*" | while read conf; do	\
		echo "Fixing up $${conf}";							\
		sed -i										\
		-e "s=sed -e \"s/\\\\(\.\*\\\\)/\\\\1;/\"=sed -e \"s/\\\\(.*\\\\)/'\"\$$ac_symprfx\"'\\\\1;/\"=" \
		-e "s:^\(hardcode_into_libs\)=.*:\1=\"no\":"					\
		-e "s:^\(hardcode_libdir_flag_spec\)=.*:\1=\"\":"				\
		-e "s:^\(hardcode_libdir_flag_spec_ld\)=.*:\1=\"\":"				\
		"$${conf}";									\
		$(CHECK_PIPE_STATUS)								\
	done;											\
												\
	find "$${PACKET_DIR}/" -name "ltmain.sh" -a -type f -a \! -path "*/.pc/*" | while read conf; do	\
		echo "Fixing up $${conf}";							\
		sed -i										\
		-e "s:\(need_relink\)=yes:\1=no:"						\
		"$${conf}";									\
		$(CHECK_PIPE_STATUS)								\
	done

# vim: syntax=make
