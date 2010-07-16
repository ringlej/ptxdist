# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BOOST) += boost

#
# Paths and names
#
BOOST_VERSION	:= 1_41_0
BOOST		:= boost_$(BOOST_VERSION)
BOOST_SUFFIX	:= tar.bz2
BOOST_URL	:= $(PTXCONF_SETUP_SFMIRROR)/boost/$(BOOST).$(BOOST_SUFFIX)
BOOST_SOURCE	:= $(SRCDIR)/$(BOOST).$(BOOST_SUFFIX)
BOOST_DIR	:= $(BUILDDIR)/$(BOOST)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BOOST_SOURCE):
	@$(call targetinfo)
	@$(call get, BOOST)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifneq ($(PTXCONF_BOOST_INST_NOMT_DBG)$(PTXCONF_BOOST_INST_MT_DBG),)
JAM_LIB_DEBUG	:= debug
endif
ifneq ($(PTXCONF_BOOST_INST_NOMT_RED)$(PTXCONF_BOOST_INST_MT_RED),)
JAM_LIB_RELEASE	:= release
endif
ifneq ($(PTXCONF_BOOST_INST_NOMT_DBG)$(PTXCONF_BOOST_INST_NOMT_RED),)
JAM_LIB_SINGLE	:= single
endif
ifneq ($(PTXCONF_BOOST_INST_MT_DBG)$(PTXCONF_BOOST_INST_MT_RED),)
JAM_LIB_MULTI	:= multi
endif

# they reinvent their own wheel^Hmake: jam
# -q: quit on error
# -d: debug level, default=1
BOOST_JAM	:= \
	$(BOOST_DIR)/bjam \
	--user-config=user-config.jam \
	-q \
	-d0 \
	--layout=tagged \
	-sNO_BZIP2=0 \
	-sZLIB_INCLUDE=$(SYSROOT)/usr/include \
	-sZLIB_LIBPATH=$(SYSROOT)/usr/lib \
	variant=$(subst $(space),$(comma),$(strip $(JAM_LIB_DEBUG) $(JAM_LIB_RELEASE))) \
	threading=$(subst $(space),$(comma),$(strip $(JAM_LIB_SINGLE) $(JAM_LIB_MULTI))) \
	link=shared

JAM_MAKE_OPT	:= \
	$(PARALLELMFLAGS) \
	stage

JAM_INSTALL_OPT	:= \
	install

# boost doesn't provide "no library" choice. If the library list is empty, it
# goes for all libraries. We start at least with date_time lib here to avoid
# this
BOOST_LIBRARIES-y				:= date_time

BOOST_LIBRARIES-$(PTXCONF_BOOST_FILESYSTEM)	+= filesystem system
BOOST_LIBRARIES-$(PTXCONF_BOOST_REGEX)		+= regex
BOOST_LIBRARIES-$(PTXCONF_BOOST_THREAD)		+= thread
BOOST_LIBRARIES-$(PTXCONF_BOOST_PROGRAM_OPTIONS) += program_options
BOOST_LIBRARIES-$(PTXCONF_BOOST_SERIALIZATION)	+= serialization
BOOST_LIBRARIES-$(PTXCONF_BOOST_SIGNALS)	+= signals
BOOST_LIBRARIES-$(PTXCONF_BOOST_IOSTREAMS)	+= iostreams
BOOST_LIBRARIES-$(PTXCONF_BOOST_WAVE)		+= wave
BOOST_LIBRARIES-$(PTXCONF_BOOST_TEST)		+= test
BOOST_LIBRARIES-$(PTXCONF_BOOST_GRAPH)		+= graph

BOOST_PATH	:= PATH=$(CROSS_PATH)
BOOST_CONF_TOOL	:= NO
BOOST_CONF_OPT	:= \
	--with-toolset=gcc \
	--prefix="$(PKGDIR)/$(BOOST)/usr" \
	--with-libraries="$(subst $(space),$(comma),$(BOOST_LIBRARIES-y))" \
	--without-icu

$(STATEDIR)/boost.prepare:
	@$(call targetinfo)
	cd $(BOOST_DIR) && ./bootstrap.sh $(BOOST_CONF_OPT)
	@cd $(BOOST_DIR) && \
		echo "using gcc : `$(BOOST_PATH) $(CROSS_CXX) -dumpversion` : $(CROSS_CXX) ;" > $(BOOST_DIR)/user-config.jam
	@echo "all:"					>  $(BOOST_DIR)/Makefile
	@echo "	@$(BOOST_JAM) $(JAM_MAKE_OPT)"		>> $(BOOST_DIR)/Makefile
	@echo "install:"				>> $(BOOST_DIR)/Makefile
	@echo "	@$(BOOST_JAM) $(JAM_INSTALL_OPT)"	>> $(BOOST_DIR)/Makefile
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

# date_time is append to libraries list as minimum, however we only install it
# to target if it is really selected
ifndef PTXCONF_BOOST_DATE_TIME
BOOST_INST_LIBRARIES := $(filter-out date_time,$(BOOST_LIBRARIES-y))
else
BOOST_INST_LIBRARIES := $(BOOST_LIBRARIES-y)
endif

$(STATEDIR)/boost.targetinstall:
	@$(call targetinfo)

	@$(call install_init, boost)
	@$(call install_fixup,boost,PRIORITY,optional)
	@$(call install_fixup,boost,SECTION,base)
	@$(call install_fixup,boost,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,boost,DESCRIPTION,missing)

# iterate for selected libraries
# trim whitespaces added by make and go for single .so files depending on which
# kind of binaries we want to install
	@for BOOST_LIB in $(BOOST_INST_LIBRARIES); do \
		read BOOST_LIB <<< $$BOOST_LIB; \
		if [ ! -z $(PTXCONF_BOOST_INST_NOMT_DBG) ]; then \
			for SO_FILE in `find $(BOOST_PKGDIR) -name "libboost_$$BOOST_LIB*.so.*" \
				 -type f -name "*-d-*" ! -name "*-mt-*"`; do \
				$(call install_copy, boost, 0, 0, 0644, -,\
					/usr/lib/$$(basename $$SO_FILE)); \
				$(call install_link, boost, \
					$$(basename $$SO_FILE), \
					/usr/lib/$$(echo `basename $$SO_FILE` | cut -f 1 -d .).so); \
			done; \
		fi; \
		if [ ! -z $(PTXCONF_BOOST_INST_NOMT_RED) ]; then \
			for SO_FILE in `find $(BOOST_PKGDIR) -name "libboost_$$BOOST_LIB*.so.*" \
				 -type f ! -name "*-d-*" ! -name "*-mt-*"`; do \
				$(call install_copy, boost, 0, 0, 0644, -,\
					/usr/lib/$$(basename $$SO_FILE)); \
				$(call install_link, boost, \
					$$(basename $$SO_FILE), \
					/usr/lib/$$(echo `basename $$SO_FILE` | cut -f 1 -d .).so); \
			done; \
		fi; \
		if [ ! -z $(PTXCONF_BOOST_INST_MT_DBG) ]; then \
			for SO_FILE in `find $(BOOST_PKGDIR) -name "libboost_$$BOOST_LIB*.so.*" \
				  -type f -name "*-d-*" -name "*-mt-*"`; do \
				$(call install_copy, boost, 0, 0, 0644, -,\
					/usr/lib/$$(basename $$SO_FILE)); \
				$(call install_link, boost, \
					$$(basename $$SO_FILE), \
					/usr/lib/$$(echo `basename $$SO_FILE` | cut -f 1 -d .).so); \
			done; \
		fi; \
		if [ ! -z $(PTXCONF_BOOST_INST_MT_RED) ]; then \
			for SO_FILE in `find $(BOOST_PKGDIR) -name "libboost_$$BOOST_LIB*.so.*" \
				 -type f ! -name "*-d-*" -name "*-mt-*"`; do \
				$(call install_copy, boost, 0, 0, 0644, -,\
					/usr/lib/$$(basename $$SO_FILE)); \
				$(call install_link, boost, \
					$$(basename $$SO_FILE), \
					/usr/lib/$$(echo `basename $$SO_FILE` | cut -f 1 -d .).so); \
			done; \
		fi; \
	done

	@$(call install_finish,boost)

	@$(call touch)

# vim: syntax=make
