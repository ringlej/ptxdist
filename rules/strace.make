# -*-makefile-*-
# $Id: strace.make,v 1.1 2003/07/15 13:58:22 robert Exp $
#
# (c) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# (c) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_STRACE))
PACKAGES += strace
endif

#
# Paths and names 
#
STRACE			= strace-4.4.98
STRACE_URL		= http://umn.dl.sourceforge.net/sourceforge/strace/$(STRACE).tar.bz2
STRACE_SOURCE		= $(SRCDIR)/$(STRACE).tar.bz2
STRACE_DIR		= $(BUILDDIR)/$(STRACE)
STRACE_EXTRACT 		= bzip2 -dc

STRACE_PTXPATCH		= strace-4.4.98-gds1.diff
STRACE_PTXPATCH_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/$(STRACE_PTXPATCH)
STRACE_PTXPATCH_SOURCE	= $(SRCDIR)/$(STRACE_PTXPATCH)
STRACE_PTXPATCH_DIR	= $(BUILDDIR)/$(STRACE)
STRACE_PTXPATCH_EXTRACT	= cat

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

strace_get: $(STATEDIR)/strace.get

$(STATEDIR)/strace.get: $(STRACE_SOURCE)
	touch $@

$(STATEDIR)/strace-ptxpatch.get: $(STRACE_PTXPATCH_SOURCE)
	touch $@

$(STRACE_SOURCE):
	@$(call targetinfo, strace.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(STRACE_URL)

$(STRACE_PTXPATCH_SOURCE):
	@$(call targetinfo, strace-ptxpatch.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(STRACE_PTXPATCH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

strace_extract: $(STATEDIR)/strace.extract

$(STATEDIR)/strace.extract: $(STATEDIR)/strace.get $(STATEDIR)/strace-ptxpatch.get
	@$(call targetinfo, strace.extract)
	$(STRACE_EXTRACT) $(STRACE_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	cd $(STRACE_DIR) && patch -p1 < $(STRACE_PTXPATCH_SOURCE)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

strace_prepare: $(STATEDIR)/strace.prepare

STRACE_AUTOCONF	=  --build=$(GNU_HOST)
STRACE_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
STRACE_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)
STRACE_AUTOCONF	+= --disable-sanity-checks
STRACE_AUTOCONF	+= --prefix=$(ROOTDIR)
STRACE_ENVIRONMENT=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(PTXCONF_PREFIX)/bin:$$PATH
STRACE_ENVIRONMENT+= ac_cv_func_setvbuf_reversed=no strace_cv_have_mbstate_t=yes
STRACE_MAKEVARS	=  AR=$(PTXCONF_GNU_TARGET)-ar
STRACE_MAKEVARS	+= RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
STRACE_MAKEVARS	+= CC=$(PTXCONF_GNU_TARGET)-gcc


#
# dependencies
#
strace_prepare_deps =  $(STATEDIR)/strace.extract 
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
strace_prepare_deps += $(STATEDIR)/xchain-gccstage2.install
endif


$(STATEDIR)/strace.prepare: $(strace_prepare_deps)
	@$(call targetinfo, strace.prepare)
	mkdir -p $(BUILDDIR)/$(STRACE)
	cd $(BUILDDIR)/$(STRACE) &&					\
		$(STRACE_ENVIRONMENT)					\
		$(STRACE_DIR)/configure $(STRACE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

strace_compile_deps = $(STATEDIR)/strace.prepare
ifeq (y, $(PTXCONF_GLIBC))
strace_compile_deps += $(STATEDIR)/glibc.install
endif
ifeq (y, $(PTXCONF_UCLIBC))
strace_compile_deps += $(STATEDIR)/uclibc.install
endif

strace_compile: $(STATEDIR)/strace.compile

$(STATEDIR)/strace.compile: $(STATEDIR)/strace.prepare 
	@$(call targetinfo, strace.compile)
	make -C $(STRACE_DIR) $(STRACE_MAKEVARS) $(MAKEPARMS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

strace_install: $(STATEDIR)/strace.install

$(STATEDIR)/strace.install: $(STATEDIR)/strace.compile
	@$(call targetinfo, strace.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

strace_targetinstall: $(STATEDIR)/strace.targetinstall

$(STATEDIR)/strace.targetinstall: $(STATEDIR)/strace.install
	@$(call targetinfo, strace.targetinstall)
	$(CROSSSTRIP) $(STRACE_DIR)/strace
	cp $(STRACE_DIR)/strace $(ROOTDIR)/bin
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

strace_clean: 
	rm -rf $(STATEDIR)/strace.* $(STRACE_DIR)

# vim: syntax=make
