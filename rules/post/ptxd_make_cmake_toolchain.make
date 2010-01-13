# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(PTXDIST_CMAKE_TOOLCHAIN):
	@$(CROSS_ENV) ptxd_make_cmake_toolchain "${@}"

# vim: syntax=make
