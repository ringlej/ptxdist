# -*-makefile-*-

ifdef PTXDIST_QUIET
_ptx_oldconfig := silentoldconfig
else
_ptx_oldconfig := oldconfig
endif

#
# ptx_oldconfig
#
# execute "make oldconfig" on a programm. Mainly used for
# kconfig based packages.
#
# this functions either uses "oldconfig" (default) or
# "silentoldconfig" if ptxdist is called with the quiet switch
#
# The silentoldconfig causes ptxdist to fail if the process
# needs userinteraction, but this is a feature not a bug.
#
define ptx/oldconfig
	cd "$($(strip $(1))_DIR)" && $($(strip $(1))_PATH) $($(strip $(1))_ENV) $(MAKE)	\
		$($(strip $(1))_MAKEVARS) $(_ptx_oldconfig)
endef

# vim: syntax=make
