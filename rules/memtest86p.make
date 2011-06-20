# -*-makefile-*-
#
# Copyright (C) 2011 by Alexander Stein <alexander.stein@systec-electronic.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_MEMTEST86P) += memtest86p

#
# Paths and names
#
MEMTEST86P_VERSION	:= 4.20
MEMTEST86P		:= memtest86+-$(MEMTEST86P_VERSION)
MEMTEST86P_SUFFIX	:= tar.gz
MEMTEST86P_URL		:= http://www.memtest.org/download/$(MEMTEST86P_VERSION)/$(MEMTEST86P).$(MEMTEST86P_SUFFIX)
MEMTEST86P_SOURCE	:= $(SRCDIR)/$(MEMTEST86P).$(MEMTEST86P_SUFFIX)
MEMTEST86P_DIR		:= $(BUILDDIR)/$(MEMTEST86P)
MEMTEST86P_LICENSE	:= GPL-2
MEMTEST86P_MD5		:= ef62c2f5be616676c8c62066dedc46b3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/memtest86p.prepare:
	@$(call targetinfo)

ifdef PTXCONF_MEMTEST86P_SERIAL
	sed -i -e 's/#define SERIAL_CONSOLE_DEFAULT 0/#define SERIAL_CONSOLE_DEFAULT 1/' $(MEMTEST86P_DIR)/config.h
	sed -i -e 's/#define SERIAL_BAUD_RATE .*/#define SERIAL_BAUD_RATE $(PTXCONF_MEMTEST86P_BAUDRATE)/' $(MEMTEST86P_DIR)/config.h
else
	@sed -i -e 's/#define SERIAL_CONSOLE_DEFAULT 1/#define SERIAL_CONSOLE_DEFAULT 0/' $(MEMTEST86P_DIR)/config.h
endif
	# Don't prestrip generated files
	sed -i -e 's/$$(LD) -s /$$(LD) /' $(MEMTEST86P_DIR)/Makefile
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

MEMTEST86P_PATH	:= PATH=$(CROSS_PATH)
MEMTEST86P_MAKE_OPT	:= $(CROSS_ENV_PROGS)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memtest86p.install:
	@$(call targetinfo)
	install -D -m 644 $(MEMTEST86P_DIR)/memtest.bin \
		$(MEMTEST86P_PKGDIR)/boot/memtest86+.bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memtest86p.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memtest86p)
	@$(call install_fixup, memtest86p,PRIORITY,optional)
	@$(call install_fixup, memtest86p,SECTION,base)
	@$(call install_fixup, memtest86p,AUTHOR,"Alexander Stein <alexander.stein@systec-electronic.com>")
	@$(call install_fixup, memtest86p,DESCRIPTION,missing)

	@$(call install_copy, memtest86p, 0, 0, 0644, -, /boot/memtest86+.bin)

	@$(call install_finish, memtest86p)

	@$(call touch)

# vim: syntax=make
