# -*-makefile-*-

#
# simple prepare for standard packages
#
world/prepare/simple =						\
	cd $($(strip $(1))_DIR) && 				\
		$($(strip $(1))_PATH) $($(strip $(1))_ENV)	\
		./configure $($(strip $(1))_AUTOCONF)

world/compile/simple =						\
	cd $($(strip $(1))_DIR) && $($(strip $(1))_PATH) $(MAKE) $(PARALLELMFLAGS)


# vim600:set foldmethod=marker:
# vim600:set syntax=make:
