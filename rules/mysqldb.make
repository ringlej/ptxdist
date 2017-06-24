# -*-makefile-*-
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MYSQLDB) += mysqldb

# ----------------------------------------------------------------------------
# Virtual fake package for mysql/mariadb
# ----------------------------------------------------------------------------
ifdef PTXCONF_MYSQLDB_MYSQL
MYSQLDB_LICENSE	:= $(MYSQL_LICENSE)
else
MYSQLDB_LICENSE	:= $(MARIADB_LICENSE)
endif

# vim: syntax=make
