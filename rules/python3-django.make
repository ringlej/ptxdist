# -*-makefile-*-
#
# Copyright (C) 2014 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_DJANGO) += python3-django

#
# Paths and names
#
PYTHON3_DJANGO_VERSION	:= 1.8.7
PYTHON3_DJANGO_MD5	:= 44c01355b5efa01938a89b8bd798b1ed
PYTHON3_DJANGO		:= Django-$(PYTHON3_DJANGO_VERSION)
PYTHON3_DJANGO_SUFFIX	:= tar.gz
PYTHON3_DJANGO_URL	:= https://www.djangoproject.com/download/$(PYTHON3_DJANGO_VERSION)/tarball/
PYTHON3_DJANGO_SOURCE	:= $(SRCDIR)/$(PYTHON3_DJANGO).$(PYTHON3_DJANGO_SUFFIX)
PYTHON3_DJANGO_DIR	:= $(BUILDDIR)/$(PYTHON3_DJANGO)
PYTHON3_DJANGO_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_DJANGO_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PYTHON3_DJANGO_PYTHON_PATH = /usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/django

$(STATEDIR)/python3-django.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-django)
	@$(call install_fixup, python3-django, PRIORITY, optional)
	@$(call install_fixup, python3-django, SECTION, base)
	@$(call install_fixup, python3-django, AUTHOR, "Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, python3-django, DESCRIPTION, missing)

#	# everything but locales
	@$(call install_glob, python3-django, 0, 0, -, \
		$(PYTHON3_DJANGO_PYTHON_PATH),, */locale */bin *.py)

#	# locales
	@cd "$(PYTHON3_DJANGO_PKGDIR)$(PYTHON3_DJANGO_PYTHON_PATH)" && \
	find -type d -name locale -printf '%P\n' | while read localedir; do \
		for locale in $(call remove_quotes, $(PTXCONF_PYTHON3_DJANGO_LOCALES)); do \
			$(call install_glob, python3-django, 0, 0, -, \
				$(PYTHON3_DJANGO_PYTHON_PATH)/$$localedir/$$locale,, *.po *.py); \
		done; \
	done
	@$(call install_copy, python3-django, 0, 0, 0644, -, \
		$(PYTHON3_DJANGO_PYTHON_PATH)/conf/locale/__init__.pyc)

	@$(call install_finish, python3-django)

	@$(call touch)

# vim: syntax=make
