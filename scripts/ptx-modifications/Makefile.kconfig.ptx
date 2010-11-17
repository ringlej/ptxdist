# ===========================================================================
# Makefile for the various kconfig executables:
# conf:	  Used for defconfig, oldconfig and related targets
# mconf:  Used for the mconfig target.
#         Utilizes the lxdialog package
# qconf:  Used for the xconfig target
#         Based on QT which needs to be installed to compile it
# gconf:  Used for the gconfig target
#         Based on GTK which needs to be installed to compile it
# object files used by all kconfig flavours

ifndef CURSES_LOC
CURSES_LOC := <ncurses.h>
endif

CPPFLAGS += \
	-DCURSES_LOC="$(CURSES_LOC)" \
	-DKBUILD_NO_NLS \
	-DPACKAGE='"ptxdist"' \
	-DCONFIG_='"PTXCONF_"'

ifndef MCONF_LIBS
MCONF_LIBS := -lncurses
endif

conf-libs  := $(CONF_LIBS)
mconf-libs := $(MCONF_LIBS)
nconf-libs := -lncurses -lmenu -lpanel

lkc-deps := lkc.h lkc_defs.h expr.h

lxdialog-objs := \
	lxdialog/checklist.o \
	lxdialog/inputbox.o  \
	lxdialog/menubox.o   \
	lxdialog/textbox.o   \
	lxdialog/util.o      \
	lxdialog/yesno.o     \

conf-objs := \
	conf.o \
	zconf.tab.o

mconf-objs := \
	mconf.o \
	zconf.tab.o \
	$(lxdialog-objs)

nconf-objs := \
	nconf.o \
	zconf.tab.o \
	nconf.gui.o

conf: $(conf-objs)
	$(CC) $^ $(LDFLAGS) -o $@ $(conf-libs)

mconf: $(mconf-objs)
	$(CC) $^ $(LDFLAGS) -o $@ $(mconf-libs)

nconf: $(nconf-objs)
	$(CC) $^ $(LDFLAGS) -o $@ $(nconf-libs)

%.moc: %.h
	$(MOC) -i $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

%.o: %.cc
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

%.moc: %.h
	$(KC_QT_MOC) -i $< -o $@

lkc_defs.h: lkc_proto.h
	sed < $< > $@ 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'

zconf.tab.o: lex.zconf.c zconf.hash.c zconf.tab.c confdata.c expr.c symbol.c menu.c $(lkc-deps)

kconfig_load.o: $(lkc-deps)

qconf.o: qconf.moc $(lkc-deps)

gconf.o: $(lkc-deps)

###
# The following requires flex/bison/gperf
# By default we use the _shipped versions, uncomment the following line if
# you are modifying the flex/bison src.
# LKC_GENPARSER := 1

ifdef LKC_GENPARSER

zconf.tab.c: zconf.y
lex.zconf.c: zconf.l
zconf.hash.c: zconf.gperf

%.tab.c: %.y
	bison -l -b $* -p $(notdir $*) $<
	cp $@ $@_shipped

lex.%.c: %.l
	flex -L -P$(notdir $*) -o$@ $<
	cp $@ $@_shipped

%.hash.c: %.gperf
	gperf < $< > $@
	cp $@ $@_shipped

else

%.tab.c: %.y
	cp $@_shipped $@

lex.%.c: %.l
	cp $@_shipped $@

%.hash.c: %.gperf
	cp $@_shipped $@

endif

clean:
	rm -f $(conf-objs) $(mconf-objs) $(nconf-objs) conf mconf nconf gconf qconf
	rm -f lkc_defs.h zconf.tab.o zconf.tab.c zconf.hash.c lex.zconf.c
