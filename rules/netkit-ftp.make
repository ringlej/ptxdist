# $Id: template 2606 2005-05-10 21:49:41Z rsc $
#
# Copyright (C) 2005 by Gilad Ben-Yossef
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_NETKIT-FTP
PACKAGES += netkit-ftp
endif

#
# Paths and names
#
NETKIT-FTP_VERSION	= 0.17
NETKIT-FTP		= netkit-ftp-$(NETKIT-FTP_VERSION)
NETKIT-FTP_SUFFIX	= tar.gz
NETKIT-FTP_URL		= ftp://ftp.uk.linux.org/pub/linux/Networking/netkit//$(NETKIT-FTP).$(NETKIT-FTP_SUFFIX)
NETKIT-FTP_SOURCE	= $(SRCDIR)/$(NETKIT-FTP).$(NETKIT-FTP_SUFFIX)
NETKIT-FTP_DIR		= $(BUILDDIR)/$(NETKIT-FTP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

netkit-ftp_get: $(STATEDIR)/netkit-ftp.get

netkit-ftp_get_deps = $(NETKIT-FTP_SOURCE)

$(STATEDIR)/netkit-ftp.get: $(netkit-ftp_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(NETKIT-FTP))
	touch $@

$(NETKIT-FTP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NETKIT-FTP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

netkit-ftp_extract: $(STATEDIR)/netkit-ftp.extract

netkit-ftp_extract_deps = $(STATEDIR)/netkit-ftp.get

$(STATEDIR)/netkit-ftp.extract: $(netkit-ftp_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NETKIT-FTP_DIR))
	@$(call extract, $(NETKIT-FTP_SOURCE))
	@$(call patchin, $(NETKIT-FTP))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

netkit-ftp_prepare: $(STATEDIR)/netkit-ftp.prepare

#
# dependencies
#
netkit-ftp_prepare_deps = \
	$(STATEDIR)/netkit-ftp.extract \
	$(STATEDIR)/virtual-xchain.install

NETKIT-FTP_PATH	=  PATH=$(CROSS_PATH)
NETKIT-FTP_ENV 	=  $(CROSS_ENV)
#NETKIT-FTP_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#NETKIT-FTP_ENV	+=

#
# autoconf
#
#NETKIT-FTP_AUTOCONF =  $(CROSS_AUTOCONF)
NETKIT-FTP_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/netkit-ftp.prepare: $(netkit-ftp_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NETKIT-FTP_DIR)/config.cache)
	cd $(NETKIT-FTP_DIR) && \
	echo "BINDIR=/usr/bin" > $(NETKIT-FTP_DIR)/MCONFIG \
	echo "MANDIR=/usr/man" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "BINMODE=755" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "MANMODE=644" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "PREFIX=/usr" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "EXECPREFIX=/usr" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "INSTALLROOT=" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo $(CROSS_ENV_CC) >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "CFLAGS=-O2 -Wall -W -Wpointer-arith -Wbad-function-cast -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Winline" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "LDFLAGS=" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "LIBS=" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "LIBTERMCAP=-lncurses" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "USE_GLIBC=1" >> $(NETKIT-FTP_DIR)/MCONFIG \
	echo "USE_READLINE=0" >> $(NETKIT-FTP_DIR)/MCONFIG 
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

netkit-ftp_compile: $(STATEDIR)/netkit-ftp.compile

netkit-ftp_compile_deps = $(STATEDIR)/netkit-ftp.prepare

$(STATEDIR)/netkit-ftp.compile: $(netkit-ftp_compile_deps)
	@$(call targetinfo, $@)
	cd $(NETKIT-FTP_DIR) && $(NETKIT-FTP_ENV) $(NETKIT-FTP_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

netkit-ftp_install: $(STATEDIR)/netkit-ftp.install

$(STATEDIR)/netkit-ftp.install: $(STATEDIR)/netkit-ftp.compile
	@$(call targetinfo, $@)
#	cd $(NETKIT-FTP_DIR) && $(NETKIT-FTP_ENV) $(NETKIT-FTP_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

netkit-ftp_targetinstall: $(STATEDIR)/netkit-ftp.targetinstall

netkit-ftp_targetinstall_deps = $(STATEDIR)/netkit-ftp.compile

$(STATEDIR)/netkit-ftp.targetinstall: $(netkit-ftp_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,netkit-ftp)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(NETKIT-FTP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(NETKIT-FTP_DIR)/ftp/ftp, /bin/ftp)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

netkit-ftp_clean:
	rm -rf $(STATEDIR)/netkit-ftp.*
	rm -rf $(IMAGEDIR)/netkit-ftp_*
	rm -rf $(NETKIT-FTP_DIR)

# vim: syntax=make
