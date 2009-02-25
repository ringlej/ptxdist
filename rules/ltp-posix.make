# -*-makefile-*-
# $Id: template-make 7759 2008-02-12 21:05:07Z mkl $
#
# Copyright (C) 2008 by 
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
LTP_POSIX_VERSION	= $(LTP_BASE_VERSION)
LTP_POSIX		= ltp-posix-$(LTP_BASE_VERSION)
LTP_POSIX_DIR		= $(LTP_BASE_DIR)/testcases/open_posix_testsuite
LTP_POSIX_PKGDIR	= $(PKGDIR)/$(LTP_POSIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------


#$(STATEDIR)/ltp-posix.get:
#	@$(call targetinfo, $@)
#	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-posix.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-posix.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

MFLAGS = LDFLAGS="-D_GNU_SOURCE -lpthread -lrt -lm" $(PARALLELMFLAGS)

ltp-posix_compile: $(STATEDIR)/ltp-posix.compile

$(STATEDIR)/ltp-posix.compile:
	@$(call targetinfo, $@)
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
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-posix_install: $(STATEDIR)/ltp-posix.install

$(STATEDIR)/ltp-posix.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-posix_install_copy = \
	file=$(strip $(1)) \
	PER=`stat -c "%a" $$file` \
	$(call install_copy, ltp-posix, 0, 0, $$PER, \
		$(LTP_POSIX_DIR)/$$file, \
		$(LTP_BASE_BIN_DIR)/posix/$$file)


ltp-posix_targetinstall: $(STATEDIR)/ltp-posix.targetinstall

$(STATEDIR)/ltp-posix.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-posix)
	@$(call install_fixup, ltp-posix,PACKAGE,ltp-posix)
	@$(call install_fixup, ltp-posix,PRIORITY,optional)
	@$(call install_fixup, ltp-posix,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-posix,SECTION,base)
	@$(call install_fixup, ltp-posix,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-posix,DEPENDS,)
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

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-posix_clean:
	rm -rf $(STATEDIR)/ltp-posix.*
	rm -rf $(PKGDIR)/ltp-posix_*
	rm -rf $(LTP_POSIX_DIR)

# vim: syntax=make
