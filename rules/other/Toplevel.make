# -*-makefile-*-
#
# Copyright (C) 2002-2009 by The PTXdist Team - See CREDITS for Details
#

# make sure bash is used to execute commands from makefiles
SHELL=$(realpath $(PTXDIST_TOPDIR)/bin/bash)
export SHELL

unexport MAKEFLAGS

PHONY := all FORCE
all:
	@echo "ptxdist: error: please use 'ptxdist' instead of calling make directly."
	@exit 1

# ----------------------------------------------------------------------------
# Some directory locations
# ----------------------------------------------------------------------------

include $(PTXDIST_TOPDIR)/scripts/ptxdist_vars.sh
include $(RULESDIR)/other/Definitions.make

include $(PTXDIST_PTXCONFIG)

# might be non existent
-include $(PTXDIST_PLATFORMCONFIG)

# might be non existent
ifneq ($(wildcard $(PTXDIST_COLLECTIONCONFIG)),)
include $(PTXDIST_COLLECTIONCONFIG)
PTX_COLLECTION := y
endif

# ----------------------------------------------------------------------------
# Include all rule files
# ----------------------------------------------------------------------------

include $(PTX_MAP_ALL_MAKE)

include $(RULESDIR)/other/Namespace.make

# might be non existent
include $(foreach dir, $(call reverse,$(subst :,$(space),$(PTXDIST_PATH_PRERULES))), $(sort $(wildcard $(dir)/*.make)))

include $(PTX_DGEN_DEPS_PRE)
include $(PTX_DGEN_RULESFILES_MAKE)

#
# the extended format is:
# PACKAGES-<ARCH>-<LABEL>
#
# to keep it simple, just add the "-y-y" to "-y"
# (for "-m" and "--" accordingly)
#
PACKAGES-y	+= $(PACKAGES-y-y)
PACKAGES-m	+= $(PACKAGES-y-m)
PACKAGES-	+= $(PACKAGES-y-) $(PACKAGES--y) $(PACKAGES--m) $(PACKAGES--)

HOST_PACKAGES-y	+= $(HOST_PACKAGES-y-y)
HOST_PACKAGES-m	+= $(HOST_PACKAGES-y-m)
HOST_PACKAGES-	+= $(HOST_PACKAGES-y-) $(HOST_PACKAGES--y) $(HOST_PACKAGES--m) $(HOST_PACKAGES--)

CROSS_PACKAGES-y+= $(CROSS_PACKAGES-y-y)
CROSS_PACKAGES-m+= $(CROSS_PACKAGES-y-m)
CROSS_PACKAGES-	+= $(CROSS_PACKAGES-y-) $(CROSS_PACKAGES--y) $(CROSS_PACKAGES--m) $(CROSS_PACKAGES--)

EXTRA_PACKAGES-y+= $(EXTRA_PACKAGES-y-y)
EXTRA_PACKAGES-m+= $(EXTRA_PACKAGES-y-m)
EXTRA_PACKAGES-	+= $(EXTRA_PACKAGES-y-) $(EXTRA_PACKAGES--y) $(EXTRA_PACKAGES--m) $(EXTRA_PACKAGES--)

LAZY_PACKAGES-y	+= $(LAZY_PACKAGES-y-y)
LAZY_PACKAGES-m	+= $(LAZY_PACKAGES-y-m)
LAZY_PACKAGES-	+= $(LAZY_PACKAGES-y-) $(LAZY_PACKAGES--y) $(LAZY_PACKAGES--m) $(LAZY_PACKAGES--)

PACKAGES	:= $(PACKAGES-y)
CROSS_PACKAGES	:= $(CROSS_PACKAGES-y)
HOST_PACKAGES	:= $(HOST_PACKAGES-y)
EXTRA_PACKAGES	:= $(EXTRA_PACKAGES-y)
LAZY_PACKAGES	:= $(LAZY_PACKAGES-y)

#
# build everything if no collection is active
#
ifndef PTX_COLLECTION
PACKAGES	+= $(PACKAGES-m)
CROSS_PACKAGES	+= $(CROSS_PACKAGES-m)
HOST_PACKAGES	+= $(HOST_PACKAGES-m)
EXTRA_PACKAGES	+= $(EXTRA_PACKAGES-m)
LAZY_PACKAGES	+= $(LAZY_PACKAGES-m)
endif

PTX_PACKAGES_SELECTED	:= \
	$(PACKAGES) \
	$(CROSS_PACKAGES) \
	$(HOST_PACKAGES) \
	$(EXTRA_PACKAGES) \
	$(LAZY_PACKAGES)

PTX_PACKAGES_INSTALL	:= \
	$(PACKAGES)

# might be non existent
include $(foreach dir, $(call reverse,$(subst :,$(space),$(PTXDIST_PATH_POSTRULES))), $(sort $(wildcard $(dir)/*.make)))
# install_alternative and install_copy has some configuration defined
# dependencies. include the files specifying these dependencies.
include $(wildcard $(STATEDIR)/*.deps)
# include late so the *PACKAGES* variables are already defined
include $(PTX_DGEN_DEPS_POST)

# ----------------------------------------------------------------------------
# just the "print" target
# ----------------------------------------------------------------------------

/print-%: FORCE
	$(if $(filter k,$(MAKEFLAGS)),,$($(if $(filter undefined,$(origin $(*))),$(error $(*) undefined))))
	@echo "$(if $(filter 1,$(PTXDIST_VERBOSE)),$(*)=)$(call add_quote,$($(*)))"

# for backwards compatibility
print-%: /print-%
	@:

.PHONY: $(PHONY)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
