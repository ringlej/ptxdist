# -*-makefile-*-
# $id$
#
# (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_E2FSPROGS))
PACKAGES += e2fsprogs
endif

#
# Paths and names 
#
E2FSPROGS			= e2fsprogs-1.29
E2FSPROGS_URL			= http://cesnet.dl.sourceforge.net/sourceforge/e2fsprogs/e2fsprogs-1.29.tar.gz
E2FSPROGS_SOURCE		= $(SRCDIR)/$(E2FSPROGS).tar.gz
E2FSPROGS_DIR			= $(BUILDDIR)/$(E2FSPROGS)
E2FSPROGS_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

e2fsprogs_get: $(STATEDIR)/e2fsprogs.get

$(STATEDIR)/e2fsprogs.get: $(E2FSPROGS_SOURCE)
	touch $@

$(E2FSPROGS_SOURCE):
	@echo
	@echo --------------------- 
	@echo target: e2fsprogs.get
	@echo ---------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(E2FSPROGS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

e2fsprogs_extract: $(STATEDIR)/e2fsprogs.extract

$(STATEDIR)/e2fsprogs.extract: $(STATEDIR)/e2fsprogs.get
	@echo
	@echo ------------------------- 
	@echo target: e2fsprogs.extract
	@echo -------------------------
	@echo
	$(E2FSPROGS_EXTRACT) $(E2FSPROGS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

e2fsprogs_prepare: $(STATEDIR)/e2fsprogs.prepare


E2FSPROGS_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)
E2FSPROGS_AUTOCONF	+= --enable-fsck
E2FSPROGS_AUTOCONF	+= --build=$(GNU_HOST)
E2FSPROGS_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
E2FSPROGS_ENVIRONMENT	=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(PTXCONF_PREFIX)/bin:$$PATH
E2FSPROGS_MAKEVARS	=  AR=$(PTXCONF_GNU_TARGET)-ar
E2FSPROGS_MAKEVARS	+= RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
E2FSPROGS_MAKEVARS	+= CC=$(PTXCONF_GNU_TARGET)-gcc

$(STATEDIR)/e2fsprogs.prepare: $(STATEDIR)/e2fsprogs.extract
	@echo
	@echo ------------------------- 
	@echo target: e2fsprogs.prepare
	@echo -------------------------
	@echo
	cd $(E2FSPROGS_DIR) &&						\
		./configure $(E2FSPROGS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

e2fsprogs_compile: $(STATEDIR)/e2fsprogs.compile

e2fsprogs_compile_deps = $(STATEDIR)/e2fsprogs.prepare
ifeq (y, $(PTXCONF_GLIBC))
e2fsprogs_compile_deps += $(STATEDIR)/glibc.install
endif
ifeq (y, $(PTXCONF_UCLIBC))
e2fsprogs_compile_deps += $(STATEDIR)/uclibc.install
endif

$(STATEDIR)/e2fsprogs.compile: $(e2fsprogs_compile_deps) 
	@echo
	@echo ------------------------- 
	@echo target: e2fsprogs.compile
	@echo -------------------------
	@echo
	# FIXME: not tested on non-x86
	$(E2FSPROGS_ENVIRONMENT) make -C $(E2FSPROGS_DIR) $(E2FSPROGS_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

e2fsprogs_install: $(STATEDIR)/e2fsprogs.install

$(STATEDIR)/e2fsprogs.install: $(STATEDIR)/e2fsprogs.compile
	@echo
	@echo ------------------------- 
	@echo target: e2fsprogs.install
	@echo -------------------------
	@echo
	make -C $(E2FSPROGS_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

e2fsprogs_targetinstall: $(STATEDIR)/e2fsprogs.targetinstall

$(STATEDIR)/e2fsprogs.targetinstall: $(STATEDIR)/e2fsprogs.install
	@echo
	@echo ------------------------------- 
	@echo target: e2fsprogs.targetinstall
	@echo -------------------------------
	@echo
        ifeq (y, $(PTXCONF_E2FSPROGS_MKFS))
	install $(E2FSPROGS_DIR)/misc/mke2fs $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/mke2fs
        endif
        ifeq (y, $(PTXCONF_E2FSPROGS_E2FSCK))
	install $(E2FSPROGS_DIR)/e2fsck/e2fsck.shared $(ROOTDIR)/sbin/e2fsck
	$(CROSSSTRIP) -S $(ROOTDIR)/sbin/e2fsck
        endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

e2fsprogs_clean: 
	rm -rf $(STATEDIR)/e2fsprogs.* $(E2FSPROGS_DIR)

# vim: syntax=make
