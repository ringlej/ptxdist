# -*-makefile-*-
#
# Copyright (C) 2011-2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PHONY += license-report

license-report: \
	$(STATEDIR)/license-report.pdf \
	$(STATEDIR)/license-report-tools.pdf

$(STATEDIR)/license-report.pdf: $(addprefix $(STATEDIR)/,$(addsuffix .report,$(PTX_PACKAGES_INSTALL)))
	@$(call targetinfo)
	@$(image/env) \
	ptx_report_dir="$(STATEDIR)/report" \
	ptx_license_target="$@" \
	ptx_license_package_filter="target" \
	ptxd_make_license_report $(sort $(PTX_PACKAGES_INSTALL))
	@$(call finish)

PTX_PACKAGES_TOOLS := \
	$(CROSS_PACKAGES) \
	$(HOST_PACKAGES) \
	$(LAZY_PACKAGES)

$(STATEDIR)/license-report-tools.pdf: $(addprefix $(STATEDIR)/,$(addsuffix .report,$(PTX_PACKAGES_TOOLS)))
	@$(call targetinfo)
	@$(image/env) \
	ptx_report_dir="$(STATEDIR)/report" \
	ptx_license_target="$@" \
	ptx_license_package_filter="tools" \
	ptxd_make_license_report $(sort $(PTX_PACKAGES_TOOLS))
	@$(call finish)

# vim: syntax=make
