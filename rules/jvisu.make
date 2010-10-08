# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JVISU) += jvisu

ifdef PTXCONF_JVISU
ifeq ($(shell which ant 2>/dev/null),)
    $(warning *** ant is mandatory to build JVisu)
    $(warning *** please install ant)
    $(error )
endif
ifeq ($(shell test -x $(PTXCONF_SETUP_JAVA_SDK)/bin/java || echo no),no)
    $(warning *** java is mandatory to build JVisu)
    $(warning *** please run 'ptxdist setup' and set the path to the java sdk)
    $(error )
endif
endif

#
# Paths and names
#
JVISU_VERSION	:= 1.0.1
JVISU_MD5	:= 1d615bfac83909cf7d07d1fe20333942
JVISU		:= JVisu-$(JVISU_VERSION)
JVISU_SUFFIX	:= tgz
JVISU_URL	:= http://www.pengutronix.de/software/jvisu/download/archive/$(JVISU).$(JVISU_SUFFIX)
JVISU_SOURCE	:= $(SRCDIR)/$(JVISU).$(JVISU_SUFFIX)
JVISU_DIR	:= $(BUILDDIR)/$(JVISU)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(JVISU_SOURCE):
	@$(call targetinfo)
	@$(call get, JVISU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


JVISU_PATH	:= PATH=$(PTXCONF_SETUP_JAVA_SDK)/bin:$(CROSS_PATH)
JVISU_ENV 	:= \
	$(CROSS_ENV) \
	JAVA_HOME=$(PTXCONF_SETUP_JAVA_SDK)

$(STATEDIR)/jvisu.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/jvisu.compile:
	@$(call targetinfo)
	cd $(JVISU_DIR) && $(JVISU_ENV) $(JVISU_PATH) /bin/bash ./build.sh jar
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jvisu.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jvisu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, jvisu)
	@$(call install_fixup, jvisu,PRIORITY,optional)
	@$(call install_fixup, jvisu,SECTION,base)
	@$(call install_fixup, jvisu,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, jvisu,DESCRIPTION,missing)

ifdef PTXCONF_JVISU_APPLET
	# User: www; Group: www
	@$(call install_copy, jvisu, 12, 102, 0644, $(JVISU_DIR)/jar/jvisu.jar, $(PTXCONF_JVISU_APPLET_PATH)/jvisu.jar, n)
endif

	@$(call install_finish, jvisu)

	@$(call touch)

# vim: syntax=make
