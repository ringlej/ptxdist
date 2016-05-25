# -*-makefile-*-

ifdef PTXDIST_QUIET
_ptx_oldconfig := silentoldconfig
else
ifeq ($(filter --output-sync%,$(PTXDIST_PARALLELMFLAGS_EXTERN)),)
_ptx_oldconfig := oldconfig
else
_ptx_oldconfig := silentoldconfig
endif
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
		$(filter-out --output-sync%,$($(strip $(1))_MAKEVARS) $($(strip $(1))_MAKE_OPT)) $(_ptx_oldconfig)
endef

# vim: syntax=make
