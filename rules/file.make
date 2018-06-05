# -*-makefile-*-
#
# Copyright (C) 2011 by Alexander Dahl <post@lespocky.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FILE) += file

#
# Paths and names
#
FILE_VERSION	:= 5.32
FILE_MD5	:= 4f2503752ff041895090ed6435610435
FILE		:= file-$(FILE_VERSION)
FILE_SUFFIX	:= tar.gz
FILE_URL	:= ftp://ftp.astron.com/pub/file/$(FILE).$(FILE_SUFFIX)
FILE_SOURCE	:= $(SRCDIR)/$(FILE).$(FILE_SUFFIX)
FILE_DIR	:= $(BUILDDIR)/$(FILE)
FILE_LICENSE	:= BSD AND 2-term BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FILE_PATH	:= PATH=$(PTXDIST_SYSROOT_HOST)/bin/file:$(CROSS_PATH)

FILE_CONF_TOOL	:= autoconf
FILE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-elf \
	--enable-elf-core \
	--enable-zlib \
	--disable-fsect-man5 \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-warnings

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/file.targetinstall:
	@$(call targetinfo)

	@$(call install_init, file)
	@$(call install_fixup, file,PRIORITY,optional)
	@$(call install_fixup, file,SECTION,base)
	@$(call install_fixup, file,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, file,DESCRIPTION,missing)

	@$(call install_lib, file, 0, 0, 0644, libmagic)
	@$(call install_copy, file, 0, 0, 0755, -, /usr/bin/file)
	@$(call install_copy, file, 0, 0, 0644, -, /usr/share/misc/magic.mgc)

	@$(call install_finish, file)

	@$(call touch)

# vim: syntax=make
