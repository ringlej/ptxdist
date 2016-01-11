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
PACKAGES-$(PTXCONF_PYTHON_DJANGO) += python-django

#
# Paths and names
#
PYTHON_DJANGO_VERSION	:= 1.8.7
PYTHON_DJANGO_MD5	:= 44c01355b5efa01938a89b8bd798b1ed
PYTHON_DJANGO		:= Django-$(PYTHON_DJANGO_VERSION)
PYTHON_DJANGO_SUFFIX	:= tar.gz
PYTHON_DJANGO_URL	:= https://www.djangoproject.com/download/$(PYTHON_DJANGO_VERSION)/tarball/
PYTHON_DJANGO_SOURCE	:= $(SRCDIR)/$(PYTHON_DJANGO).$(PYTHON_DJANGO_SUFFIX)
PYTHON_DJANGO_DIR	:= $(BUILDDIR)/$(PYTHON_DJANGO)
PYTHON_DJANGO_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_DJANGO_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PYTHON_DJANGO_PYTHON_PATH = /usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/django

$(STATEDIR)/python-django.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python-django)
	@$(call install_fixup, python-django, PRIORITY, optional)
	@$(call install_fixup, python-django, SECTION, base)
	@$(call install_fixup, python-django, AUTHOR, "Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, python-django, DESCRIPTION, missing)

#	# everything but locales
	@cd "$(PYTHON_DJANGO_PKGDIR)$(PYTHON_DJANGO_PYTHON_PATH)" && \
	find -type d -name locale -prune -o -type f ! -name "*.py" -printf '%P\n' | while read fn; do \
		$(call install_copy, python-django, 0, 0, 0644, -, \
			$(PYTHON_DJANGO_PYTHON_PATH)/$$fn); \
	done

#	# locales
	@cd "$(PYTHON_DJANGO_PKGDIR)$(PYTHON_DJANGO_PYTHON_PATH)" && \
	find -type d -name locale -printf '%P\n' | while read localedir; do \
		for locale in $(call remove_quotes, $(PTXCONF_PYTHON_DJANGO_LOCALES)); do \
			cd "$(PYTHON_DJANGO_PKGDIR)$(PYTHON_DJANGO_PYTHON_PATH)/$$localedir/$$locale" && \
				find -type f -not \( -name \*.py -o -name \*.po \) -printf "%P\n" | while read fn; do \
					$(call install_copy, python-django, 0, 0, 0644, -, \
						$(PYTHON_DJANGO_PYTHON_PATH)/$$localedir/$$locale/$$fn); \
			done; \
		done; \
	done
	@$(call install_copy, python-django, 0, 0, 0644, -, \
		$(PYTHON_DJANGO_PYTHON_PATH)/conf/locale/__init__.pyc)

	@$(call install_finish, python-django)

	@$(call touch)

# vim: syntax=make
