# -*-makefile-*-

plugins:
	@echo "Installed Plugins:"
	@echo $(wildcard $(PTXDIST_TOPDIR)/plugins/*)

plugin-%: dump
	@echo "trying plugin $(*)"
	@if [ -x "$(PTXDIST_WORKSPACE)/plugins/$(*)/main" ]; then 	\
		echo "local plugin found.";				\
		$(PTXDIST_WORKSPACE)/plugins/$(*)/main;			\
	elif [ -x "$(PTXDIST_TOPDIR)/plugins/$(*)/main" ]; then  	\
		echo "generic plugin found.";                   	\
		$(PTXDIST_TOPDIR)/plugins/$(*)/main;            	\
	else								\
		echo "sorry, plugin not found";				\
	fi

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
