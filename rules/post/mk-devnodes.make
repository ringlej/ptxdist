# -*-makefile-*-

PTX_FIXPERM_SCRIPT := $(STATEDIR)/ptxdist-fixperm.sh
PTX_FIXPERM_RUN    := $(STATEDIR)/ptxdist-fixperm.done

ifdef PTXCONF_MKDEVNODES
world: $(PTX_FIXPERM_RUN)
endif

$(PTX_FIXPERM_RUN): $(PTX_FIXPERM_SCRIPT)
	@echo;									\
	echo "creating devnodes, for the smooth nfsroot feeling";		\
	echo;									\
	read -t 5 -p "(press enter to let sudo to that job)";			\
	if test $$? -eq 0; then							\
		for dir in "$(ROOTDIR)" "$(ROOTDIR_DEBUG)"; do			\
			pushd "$$dir" > /dev/null;				\
			sudo /bin/bash -x "$<";					\
			popd > /dev/null;					\
		done;								\
	else									\
		echo;								\
		echo "watch out for missing initial consoles...";		\
		echo;								\
	fi


$(PTX_FIXPERM_SCRIPT): world_packages
	@echo "#/bin/bash" > "$@"
	@chmod +x "$@"

	@IFS=":";								\
	(									\
	egrep "^n:" -h $(STATEDIR)/*.perms | 					\
		while read n node uid gid perm type major minor; do		\
		node="$${node#/}";						\
		echo "if test -e $$node; then rm -rf $$node; fi";		\
		echo "mknod $$node $$type $$major $$minor";			\
		echo "chown $$uid:$$gid $$node";				\
		echo "chmod $$perm $$node";					\
	done;									\
	) >> "$@"

# vim: syntax=make
