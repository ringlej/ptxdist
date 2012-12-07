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
HOST_PACKAGES-$(PTXCONF_HOST_FILE) += host-file

HOST_FILE_CONF_TOOL	:= autoconf
HOST_FILE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--bindir=/bin/file

# vim: syntax=make
