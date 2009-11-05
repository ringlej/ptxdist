# -*-makefile-*-
#
# Copyright (C) 2002-2009 by The PTXdist Team - See CREDITS for Details
#

# make sure bash is used to execute commands from makefiles
SHELL=bash
export SHELL

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
ifneq ($(wildcard $(PTXDIST_PLATFORMCONFIG)),)
include $(PTXDIST_PLATFORMCONFIG)
endif

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
include $(wildcard $(PRERULESDIR)/*.make)

ifneq ($(wildcard $(PROJECTPRERULESDIR)/*.make),)
include $(wildcard $(PROJECTPRERULESDIR)/*.make)
endif

include $(PTX_DGEN_DEPS_PRE)
include $(PTX_DGEN_RULESFILES_MAKE)
include $(PTX_DGEN_DEPS_POST)

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

PACKAGES	:= $(PACKAGES-y)
CROSS_PACKAGES	:= $(CROSS_PACKAGES-y)
HOST_PACKAGES	:= $(HOST_PACKAGES-y)

#
# build everything if no collection is active
#
ifndef PTX_COLLECTION
PACKAGES	+= $(PACKAGES-m)
CROSS_PACKAGES	+= $(CROSS_PACKAGES-m)
HOST_PACKAGES	+= $(HOST_PACKAGES-m)
endif

PTX_PACKAGES_SELECTED	:= \
	$(PACKAGES) \
	$(CROSS_PACKAGES) \
	$(HOST_PACKAGES)

ifneq ($(wildcard $(POSTRULESDIR)/*.make),)
include $(wildcard $(POSTRULESDIR)/*.make)
endif

ifneq ($(wildcard $(PROJECTPOSTRULESDIR)/*.make),)
include $(wildcard $(PROJECTPOSTRULESDIR)/*.make)
endif

# ----------------------------------------------------------------------------
# just the "print" target
# ----------------------------------------------------------------------------

print-%: FORCE
	@[ "$(origin $(*))" != "undefined" ] && echo "$($(*))"

.PHONY: $(PHONY)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
