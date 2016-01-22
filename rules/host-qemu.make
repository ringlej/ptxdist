# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <bernhard@bwalle.de>
#           (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#           (C) 2013 by Jan Luebbe <j.luebbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_QEMU) += host-qemu

#
# Paths and names
#
HOST_QEMU_VERSION	:= 2.4.1
HOST_QEMU_MD5		:= a895e93ec1dafc34bc64ed676f0d55a6
HOST_QEMU		:= qemu-$(HOST_QEMU_VERSION)
HOST_QEMU_SUFFIX	:= tar.bz2
HOST_QEMU_URL		:= http://wiki.qemu.org/download/$(HOST_QEMU).$(HOST_QEMU_SUFFIX)
HOST_QEMU_SOURCE	:= $(SRCDIR)/$(HOST_QEMU).$(HOST_QEMU_SUFFIX)
HOST_QEMU_DIR		:= $(HOST_BUILDDIR)/$(HOST_QEMU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#

HOST_QEMU_TARGETS	:= $(call ptx/ifdef, PTXCONF_ARCH_X86,i386,$(call ptx/ifdef, PTXCONF_ARCH_ARM64,aarch64,$(PTXCONF_ARCH_STRING)))
HOST_QEMU_SYS_TARGETS	:= $(patsubst %,%-softmmu,$(HOST_QEMU_TARGETS))
HOST_QEMU_USR_TARGETS	:= $(patsubst %,%-linux-user,$(HOST_QEMU_TARGETS))

HOST_QEMU_CONF_TOOL	:= autoconf
# Note: not realy autoconf:
# e.g. there is --enable-debug but not --disable-debug
HOST_QEMU_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--target-list=" \
		$(call ptx/ifdef, PTXCONF_HOST_QEMU_SYS,$(HOST_QEMU_SYS_TARGETS),) \
		$(call ptx/ifdef, PTXCONF_HOST_QEMU_USR,$(HOST_QEMU_USR_TARGETS),) \
	" \
	--disable-werror \
	--audio-drv-list= \
	--enable-trace-backends=nop \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_SYS)-system \
	--disable-user \
	--$(call ptx/endis, PTXCONF_HOST_QEMU_USR)-linux-user \
	--disable-bsd-user \
	--enable-guest-base \
	--disable-docs \
	--disable-guest-agent \
	--disable-guest-agent-msi \
	--enable-pie \
	--disable-debug-tcg \
	--disable-debug-info \
	--disable-sparse \
	--disable-gnutls \
	--disable-sdl \
	--disable-qom-cast-debug \
	--disable-gtk \
	--disable-vte \
	--disable-curses \
	--disable-vnc \
	--disable-vnc-tls \
	--disable-vnc-sasl \
	--disable-vnc-jpeg \
	--disable-vnc-png \
	--disable-cocoa \
	--disable-virtfs \
	--disable-xen \
	--disable-xen-pci-passthrough \
	--disable-brlapi \
	--disable-curl \
	--enable-fdt \
	--disable-bluez \
	--disable-kvm \
	--disable-rdma \
	--disable-uuid \
	--disable-netmap \
	--disable-linux-aio \
	--disable-cap-ng \
	--enable-attr \
	--disable-vhost-net \
	--disable-vhost-scsi \
	--disable-spice \
	--disable-rbd \
	--disable-libiscsi \
	--disable-libnfs \
	--disable-smartcard-nss \
	--disable-libusb \
	--disable-usb-redir \
	--disable-lzo \
	--disable-snappy \
	--disable-bzip2 \
	--disable-seccomp \
	--disable-coroutine-pool \
	--disable-glusterfs \
	--disable-archipelago \
	--disable-tpm \
	--disable-libssh2 \
	--disable-vhdx \
	--disable-numa \
	--disable-tcmalloc \
	--disable-tools

$(STATEDIR)/host-qemu.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_QEMU)
ifdef PTXCONF_HOST_QEMU_USR
	@echo -e '#!/bin/sh\nexec $(PTXDIST_SYSROOT_HOST)/bin/qemu-$(HOST_QEMU_TARGETS) -L $(PTXDIST_SYSROOT_TOOLCHAIN) -E LD_LIBRARY_PATH=$(PTXDIST_SYSROOT_TOOLCHAIN)/lib:$(SYSROOT)/$(CROSS_LIB_DIR):$(SYSROOT)/usr/$(CROSS_LIB_DIR) "$${@}"' > $(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross
	@sed \
		-e 's|RTLDLIST=/lib|RTLDLIST=$(PTXDIST_SYSROOT_TOOLCHAIN)/lib|'\
		-e 's|eval $$add_env|eval $(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross -E "$${add_env// /,}"|' \
		-e 's|verify_out=`|verify_out=`$(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross |' \
		-e 's|#! */.*$$|#!$(shell readlink $(PTXDIST_TOPDIR)/bin/bash)|' \
		$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/bin/ldd > $(PTXDIST_SYSROOT_CROSS)/bin/ldd-cross
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/bin/ldd-cross
endif
	@$(call touch)

# vim: syntax=make
