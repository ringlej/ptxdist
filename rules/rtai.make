# -*-makefile-*-
# $Id: rtai.make,v 1.6 2003/08/24 12:14:14 robert Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_RTAI))
PACKAGES += rtai
endif

#
# Paths and names 
#
ifeq (y, $(PTXCONF_RTAI_24.1.11))
RTAI			= rtai-24.1.11
endif
ifeq (y, $(PTXCONF_RTAI_24_1_10))
RTAI			= rtai-24.1.10
endif
ifeq (y, $(PTXCONF_RTAI_24_1_9))
RTAI			= rtai-24.1.9
endif
RTAI_URL		= http://www.aero.polimi.it/RTAI/$(RTAI).tgz
RTAI_SOURCE		= $(SRCDIR)/$(RTAI).tgz
RTAI_DIR		= $(BUILDDIR)/$(RTAI)
RTAI_EXTRACT 		= gzip -dc
ifeq (y, $(PTXCONF_KERNEL_2_4_18))
RTAI_MODULEDIR		= /lib/modules/2.4.18-rthal5/rtai
endif
ifeq (y, $(PTXCONF_KERNEL_2_4_19))
RTAI_MODULEDIR		= /lib/modules/2.4.19-rthal5/rtai
endif
ifeq (y, $(PTXCONF_KERNEL_2_4_20))
RTAI_MODULEDIR		= /lib/modules/2.4.20-rthal5/rtai
endif
ifeq (y, $(PTXCONF_KERNEL_2_4_21))
RTAI_MODULEDIR		= /lib/modules/2.4.21-rthal5/rtai
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rtai_get: $(STATEDIR)/rtai.get

$(STATEDIR)/rtai.get: $(RTAI_SOURCE)
	@$(call targetinfo, rtai.get)
	touch $@

$(RTAI_SOURCE):
	@$(call targetinfo, $(RTAI_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(RTAI_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rtai_extract: $(STATEDIR)/rtai.extract

$(STATEDIR)/rtai.extract: $(STATEDIR)/rtai.get
	@$(call targetinfo, rtai.extract)
	$(RTAI_EXTRACT) $(RTAI_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rtai_prepare: $(STATEDIR)/rtai.prepare

rtai_prepare_deps =  $(STATEDIR)/kernel.prepare
rtai_prepare_deps += $(STATEDIR)/rtai.extract

$(STATEDIR)/rtai.prepare: $(rtai_prepare_deps)
	@$(call targetinfo, rtai.prepare)
	install .rtaiconfig $(RTAI_DIR)
	cd $(RTAI_DIR) && 						\
		yes no | ./configure --non-interactive --linuxdir $(KERNEL_DIR) --reconf
	# FIXME: spaces in pathnames are forbidden right now...
	echo '# this is ugly like hell and committed by ptxdist' >> $(RTAI_DIR)/.buildvars
	# we honestly doubt anyone of them has ever used a cross compiler...
	echo CC=$(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-gcc >> $(RTAI_DIR)/.buildvars
	echo CROSS_COMPILE=$(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)- >> $(RTAI_DIR)/.buildvars
	echo LD=$(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-ld >> $(RTAI_DIR)/.buildvars
	echo AS=$(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-as >> $(RTAI_DIR)/.buildvars
	# FIXME: Hopefully someone will fix this one:
	cp -f $(RTAI_DIR)/lxrt/Makefile $(RTAI_DIR)/lxrt/Makefile.orig
	sed -e "s/pressa//g" $(RTAI_DIR)/lxrt/Makefile.orig >$(RTAI_DIR)/lxrt/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rtai_compile: $(STATEDIR)/rtai.compile

$(STATEDIR)/rtai.compile: $(STATEDIR)/rtai.prepare 
	@$(call targetinfo, rtai.compile)
	cd $(RTAI_DIR) && TOPDIR=$(RTAI_DIR) PATH=$(PTXCONF_PREFIX)/bin:$$PATH make 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rtai_install: $(STATEDIR)/rtai.install

$(STATEDIR)/rtai.install: $(STATEDIR)/rtai.compile
	@$(call targetinfo, rtai.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rtai_targetinstall: $(STATEDIR)/rtai.targetinstall

$(STATEDIR)/rtai.targetinstall: $(STATEDIR)/rtai.install
	@$(call targetinfo, rtai.targetinstall)
	mkdir -p $(ROOTDIR)/$(RTAI_MODULEDIR)
	install $(RTAI_DIR)/rtaidir/rtai.o $(ROOTDIR)/$(RTAI_MODULEDIR)
	$(CROSSSTRIP) -S $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai.o
	install $(RTAI_DIR)/upscheduler/rtai_sched_up.o $(ROOTDIR)/$(RTAI_MODULEDIR)
	$(CROSSSTRIP) -S $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_sched_up.o
	ln -sf rtai_sched_up.o $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_sched.o
        ifeq (y, $(PTXCONF_RTAI_24_1_9))
	install $(RTAI_DIR)/lxrt/rtai_lxrt.o $(ROOTDIR)/$(RTAI_MODULEDIR)
	$(CROSSSTRIP) -S $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_lxrt.o
        endif
        ifeq (y, $(PTXCONF_RTAI_24_1_10))		
	install $(RTAI_DIR)/lxrt/rtai_lxrt_old.o $(ROOTDIR)/$(RTAI_MODULEDIR)
	$(CROSSSTRIP) -S $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_lxrt_old.o
	ln -sf rtai_lxrt_old.o $(ROOTDIR)/$(RTAI_MODULEDIR)/rtai_lxrt.o
        endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rtai_clean: 
	rm -rf $(STATEDIR)/rtai.* $(RTAI_DIR)

rtai_kernel_clean:
	rm -fr $(STATEDIR)/rtai_kernel.* $(BUILDDIR)/rtai-patches/

# vim: syntax=make
