# -*-makefile-*-
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(PTXDIST_MESON_CROSS_FILE):
	@$(CROSS_ENV) \
		PTXCONF_ARCH_STRING=${PTXCONF_ARCH_STRING} \
		ENDIAN=$(call ptx/ifdef, PTXCONF_ENDIAN_LITTLE, little, big) \
		ptxd_make_meson_cross_file "${@}"

# vim: syntax=make
