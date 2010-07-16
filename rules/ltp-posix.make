# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTP_POSIX) += ltp-posix

#
# Paths and names
#
LTP_POSIX_VERSION	:= $(LTP_BASE_VERSION)
LTP_POSIX		:= ltp-posix-$(LTP_BASE_VERSION)
LTP_POSIX_DIR		:= $(LTP_BASE_DIR)/testcases/open_posix_testsuite
LTP_POSIX_PKGDIR	= $(PKGDIR)/$(LTP_POSIX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-posix.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-posix.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

MFLAGS = LDFLAGS="-D_GNU_SOURCE -lpthread -lrt -lm" $(PARALLELMFLAGS)

$(STATEDIR)/ltp-posix.compile:
	@$(call targetinfo)
	@cd $(LTP_POSIX_DIR); $(LTP_ENV) $(MAKE) $(MFLAGS) t0
ifdef PTXCONF_LTP_POSIX_CONFORMANCE
	@cd $(LTP_POSIX_DIR); $(LTP_ENV) $(MAKE) $(MFLAGS) build-tests
endif
ifdef PTXCONF_LTP_POSIX_FUNCTIONAL
	@cd $(LTP_POSIX_DIR); $(LTP_ENV) $(MAKE) $(MFLAGS) functional-make
endif
ifdef PTXCONF_LTP_POSIX_STRESS
	@cd $(LTP_POSIX_DIR); $(LTP_ENV) $(MAKE) $(MFLAGS) stress-make
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-posix.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-posix_install_copy = \
	file=$(strip $(1)) \
	PER=`stat -c "%a" $$file` \
	$(call install_copy, ltp-posix, 0, 0, $$PER, \
		$(LTP_POSIX_DIR)/$$file, \
		$(LTP_BASE_BIN_DIR)/posix/$$file)


$(STATEDIR)/ltp-posix.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-posix)
	@$(call install_fixup, ltp-posix,PRIORITY,optional)
	@$(call install_fixup, ltp-posix,SECTION,base)
	@$(call install_fixup, ltp-posix,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-posix,DESCRIPTION,missing)

ifdef PTXCONF_LTP_POSIX_CONFORMANCE
	@cd $(LTP_POSIX_DIR);\
	for file in `find conformance/ -name "*.test" -o -name "*.sh"`; do \
		$(call ltp-posix_install_copy, $$file); \
	done
endif
ifdef PTXCONF_LTP_POSIX_FUNCTIONAL
	@cd $(LTP_POSIX_DIR);\
	for file in `find functional/ -name "*.test" -o -name "*.sh"`; do \
		$(call ltp-posix_install_copy, $$file); \
	done
endif
ifdef PTXCONF_LTP_POSIX_STRESS
	@cd $(LTP_POSIX_DIR);\
	for file in `find stress/ -name "*.test" -o -name "*.sh"`; do \
		$(call ltp-posix_install_copy, $$file); \
	done
endif
	@cd $(LTP_POSIX_DIR);\
	for file in run_tests execute.sh t0; do \
		$(call ltp-posix_install_copy, $$file); \
	done

	@$(call install_finish, ltp-posix)

	@$(call touch)

# vim: syntax=make
