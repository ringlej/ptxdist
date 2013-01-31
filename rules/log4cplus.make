# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Sessler <bernhard.sessler@corscience.de>
#                       Corscience GmbH & Co. KG <info@corscience.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LOG4CPLUS) += log4cplus

#
# Paths and names
#
LOG4CPLUS_VERSION	:= 1.1.0
LOG4CPLUS_MD5		:= 8f04a7b2db55384440b0ab83b6362d5d
LOG4CPLUS		:= log4cplus-$(LOG4CPLUS_VERSION)
LOG4CPLUS_SUFFIX	:= tar.xz
LOG4CPLUS_URL		:= $(call ptx/mirror, SF, log4cplus/$(LOG4CPLUS).$(LOG4CPLUS_SUFFIX))
LOG4CPLUS_SOURCE	:= $(SRCDIR)/$(LOG4CPLUS).$(LOG4CPLUS_SUFFIX)
LOG4CPLUS_DIR		:= $(BUILDDIR)/$(LOG4CPLUS)
LOG4CPLUS_LICENSE	:= APLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LOG4CPLUS_CONF_TOOL	:= cmake

LOG4CPLUS_CONF_OPT	:= $(CROSS_CMAKE_USR)
LOG4CPLUS_CONF_OPT	+= -DLOG4CPLUS_BUILD_TESTING=OFF

ifdef PTXCONF_LOG4CPLUS_QT4
LOG4CPLUS_CONF_OPT	+= -DLOG4CPLUS_QT4=ON
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/log4cplus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, log4cplus)
	@$(call install_fixup, log4cplus, PRIORITY, optional)
	@$(call install_fixup, log4cplus, SECTION, base)
	@$(call install_fixup, log4cplus, AUTHOR, \
		"Bernhard Sessler <bernhard.sessler@corscience.de>")
	@$(call install_fixup, log4cplus,DESCRIPTION,missing)

	@$(call install_lib, log4cplus, 0, 0, 0644, liblog4cplus)
	@$(call install_copy, log4cplus, 0, 0, 0755, -, /usr/bin/loggingserver)

ifdef PTXCONF_LOG4CPLUS_QT4
	@$(call install_lib, log4cplus, 0, 0, 0644, liblog4cplusqt4debugappender)
endif

	@$(call install_finish, log4cplus)

	@$(call touch)

# vim: syntax=make
