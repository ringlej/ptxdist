# -*-makefile-*-
#
# Copyright (C) 2011 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETFILTER_QUEUE) += libnetfilter_queue

#
# Paths and names
#
LIBNETFILTER_QUEUE_VERSION	:= 1.0.0
LIBNETFILTER_QUEUE_MD5		:= af6a9ea350f63a13609bc3b47b5c395c
LIBNETFILTER_QUEUE		:= libnetfilter_queue-$(LIBNETFILTER_QUEUE_VERSION)
LIBNETFILTER_QUEUE_SUFFIX	:= tar.bz2
LIBNETFILTER_QUEUE_URL		:= http://ftp.netfilter.org/pub/libnetfilter_queue/$(LIBNETFILTER_QUEUE).$(LIBNETFILTER_QUEUE_SUFFIX)
LIBNETFILTER_QUEUE_SOURCE	:= $(SRCDIR)/$(LIBNETFILTER_QUEUE).$(LIBNETFILTER_QUEUE_SUFFIX)
LIBNETFILTER_QUEUE_DIR		:= $(BUILDDIR)/$(LIBNETFILTER_QUEUE)
LIBNETFILTER_QUEUE_LICENSE	:= GPLv2

#
# autoconf
#
LIBNETFILTER_QUEUE_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnetfilter_queue.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnetfilter_queue)
	@$(call install_fixup, libnetfilter_queue,PRIORITY,optional)
	@$(call install_fixup, libnetfilter_queue,SECTION,base)
	@$(call install_fixup, libnetfilter_queue,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, libnetfilter_queue,DESCRIPTION,missing)

	@$(call install_lib, libnetfilter_queue, 0, 0, 0644, libnetfilter_queue)

	@$(call install_finish, libnetfilter_queue)
	@$(call touch)

