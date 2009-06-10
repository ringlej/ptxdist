# -*-makefile-*-

#
# simple prepare for standard target autoconf packages
#
world/prepare/target =								\
	cp "$(PTXDIST_AUTOCONF_CACHE_TARGET)"					\
		"$($(strip $(1))_DIR)/config.cache" &&				\
	cd $($(strip $(1))_DIR) && 						\
	$($(strip $(1))_PATH) $($(strip $(1))_ENV)				\
		./configure $($(strip $(1))_AUTOCONF)				\
		--cache-file="$($(strip $(1))_DIR)/config.cache"

#
# simple prepare for standard host packages
#
world/prepare/host =								\
	cp "$(PTXDIST_AUTOCONF_CACHE_HOST)"					\
		"$($(strip $(1))_DIR)/config.cache" &&				\
	cd $($(strip $(1))_DIR) && 						\
	$($(strip $(1))_PATH) $($(strip $(1))_ENV)				\
		./configure $($(strip $(1))_AUTOCONF)				\
		--cache-file="$($(strip $(1))_DIR)/config.cache"

#
# simple compile for target and host packages
#
world/compile/simple =								\
	cd $($(strip $(1))_DIR) && 						\
		$($(strip $(1))_PATH)						\
		$($(strip $(1))_COMPILE_ENV)					\
		$(MAKE) $($(strip $(1))_MAKEVARS) $(PARALLELMFLAGS)


# vim600:set foldmethod=marker:
# vim600:set syntax=make:
