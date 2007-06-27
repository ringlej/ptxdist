# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_LTP) += ltp

#
# Paths and names
#
LTP_VERSION	= 20050505
LTP		= ltp-full-$(LTP_VERSION)
LTP_SUFFIX	= tgz
LTP_URL		= $(PTXCONF_SETUP_SFMIRROR)/ltp/$(LTP).$(LTP_SUFFIX)
LTP_SOURCE	= $(SRCDIR)/$(LTP).$(LTP_SUFFIX)
LTP_DIR		= $(BUILDDIR)/$(LTP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp_get: $(STATEDIR)/ltp.get

$(STATEDIR)/ltp.get: $(ltp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LTP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LTP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp_extract: $(STATEDIR)/ltp.extract

$(STATEDIR)/ltp.extract: $(ltp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LTP_DIR))
	@$(call extract, LTP)
	@$(call patchin, LTP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp_prepare: $(STATEDIR)/ltp.prepare

LTP_PATH	=  PATH=$(CROSS_PATH)
LTP_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/ltp.prepare: $(ltp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp_compile: $(STATEDIR)/ltp.compile

$(STATEDIR)/ltp.compile: $(ltp_compile_deps_default)
	@$(call targetinfo, $@)

	# We need the toplevel lib dir for all LTP tests. 
	cd $(LTP_DIR)/lib && $(LTP_ENV) $(LTP_PATH) make

ifdef PTXCONF_LTP_MISC_MATH
	cd $(LTP_DIR)/testcases/misc/math && $(LTP_ENV) $(LTP_PATH) make
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp_install: $(STATEDIR)/ltp.install

$(STATEDIR)/ltp.install: $(ltp_install_deps_default)
	@$(call targetinfo, $@)
	install -D $(LTP_DIR)/lib/libltp.a $(SYSROOT)/lib/libltp.a
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp_targetinstall: $(STATEDIR)/ltp.targetinstall

$(STATEDIR)/ltp.targetinstall: $(ltp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ltp)
	@$(call install_fixup, ltp,PACKAGE,ltp)
	@$(call install_fixup, ltp,PRIORITY,optional)
	@$(call install_fixup, ltp,VERSION,$(LTP_VERSION))
	@$(call install_fixup, ltp,SECTION,base)
	@$(call install_fixup, ltp,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp,DEPENDS,)
	@$(call install_fixup, ltp,DESCRIPTION,missing)

ifdef PTXCONF_LTP_MISC_MATH_ABS
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/abs/abs01, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/abs/abs01)
endif
ifdef PTXCONF_LTP_MISC_MATH_ATOF
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/atof/atof01, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/atof/atof01)
endif
ifdef PTXCONF_LTP_MISC_MATH_FLOAT
	# Bessel
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/float_bessel, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/bessel/float_bessel)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/bessel/genbessel, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/bessel/genbessel)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/bessel/genlgamma, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/bessel/genlgamma)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/bessel/genj0, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/bessel/genj0)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/bessel/genj1, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/bessel/genj1)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/bessel/geny0, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/bessel/geny0)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/bessel/geny1, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/bessel/geny1)

	# exp_log
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/float_exp_log, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/float_exp_log)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/exp_log/genexp, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/gen_exp)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/exp_log/genexp_log, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/genexp_log)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/exp_log/genfrexp, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/genfrexp)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/exp_log/genhypot, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/genhypot)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/exp_log/genldexp, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/genldexp)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/exp_log/genlog, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/genlog)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/exp_log/genlog10, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/genlog10)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/exp_log/genmodf, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/exp_log/genmodf)

	# iperb
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/float_iperb, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/iperb/float_iperb)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/iperb/gencosh, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/iperb/gencosh)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/iperb/geniperb, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/iperb/geniperb)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/iperb/gensinh, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/iperb/gensinh)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/iperb/gentanh, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/iperb/gentanh)

	# power
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/float_power, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/power/float_power)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/power/genceil, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/power/genceil)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/power/genfabs, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/power/genfabs)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/power/genfloor, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/power/genfloor)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/power/genfmod, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/power/genfmod)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/power/genpow, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/power/genpow)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/power/genpower, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/power/genpower)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/power/gensqrt, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/power/gensqrt)

	# trigo
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/float_trigo, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/float_trigo)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/trigo/genacos, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/genacos)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/trigo/genasin, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/genasin)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/trigo/genatan, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/genatan)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/trigo/genatan2, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/genatan2)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/trigo/gencos, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/gencos)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/trigo/gensin, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/gensin)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/trigo/gentan, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/gentan)
	@$(call install_copy, ltp, 0, 0, 0755, \
		$(LTP_DIR)/testcases/misc/math/float/trigo/gentrigo, \
		$(PTXCONF_TESTSUITE_DIR)/$(LTP)/misc/math/float/trigo/gentrigo)
endif

	@$(call install_finish, ltp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp_clean:
	rm -rf $(STATEDIR)/ltp.*
	rm -rf $(IMAGEDIR)/ltp_*
	rm -rf $(LTP_DIR)

# vim: syntax=make
