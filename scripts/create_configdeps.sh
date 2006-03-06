#!/bin/bash
# 
# Autogenerate Dependencies for Package-Makefiles
# 

FULLARGS="$@"
DEBUG=true

#
# helper functions
#

debug_out(){
    [ $DEBUG ] && echo "$0: $1" >&2
}

my_exit(){
    debug_out "$0: $1"
    exit $2
}

usage() {
    echo 
    [ -n "$1" ] && echo -e "${PREFIX} error: $1\n"
    echo "usage: $0 <args>"
    echo
    echo " Arguments:"
    echo
    echo "  --action    defaults"
    echo "  --statedir  <dir>         PTX State Directory"
    echo "  --rulesdir  <dir>         PTX Rules Directory"
    echo "  --projectrulesdir <dir>   optional local Rules Directory"
    echo "  --dependency-file   <file>        optional outfile for default dependencies"
    echo
    exit 0
}

check_argument(){
    case "$1" in 
	--*|"")
	    debug_out "missing argument"
	    return 1
	    ;;
	[[:alnum:]/]*)
	#debug_out "argument $1 accepted"
return 0
;;
esac
}

#
# Option parser
#
while [ $# -gt 0 ]; do
    case "$1" in
	--help) usage ;;
	--action)
	    check_argument $2  		
	    if [ "$?" == "0" ] ; then 
		ACTION="$2";      		
		shift 2 ;
	    else	
		debug_out "skipping option $1";
		shift 1 ;
	    fi
	    ;;
	--statedir) 		
	    check_argument $2  		
	    if [ "$?" == "0" ] ; then 
		STATEDIR="$2";      		
		shift 2 ;
	    else	
		debug_out "skipping option $1";
		shift 1 ;
	    fi
	    ;;
	--rulesdir) 		
	    check_argument $2  		
	    if [ "$?" == "0" ] ; then 
		RULESDIR="$2";      		
		shift 2 ;
	    else	
		debug_out "skipping option $1";
		shift 1 ;
	    fi
	    ;;
	--projectrulesdir)  
	    check_argument $2  		
	    if [ "$?" == "0" ] ; then 
		PROJECTRULESDIR="$2";      		
		shift 2 ;
	    else	
		debug_out "skipping option $1";
		shift 1 ;
	    fi
	    ;;
	--dependency-file)    	
	    check_argument $2  		
	    if [ "$?" == "0" ] ; then 
		OUTFILE="$2";      		
		shift 2 ;
	    else	
		debug_out "skipping option $1";
		shift 1 ;
	    fi
	    ;;
	*)  
	    usage "unknown option $1" 
	    ;;
    esac
done

#
# Sanity checks
#

[ -z "$RULESDIR" ] || rulesfiles="$RULESDIR/*.make $rulesfiles"  
[ -z "$PROJECTRULESDIR" ] || rulesfiles="$PROJECTRULESDIR/*.make $rulesfiles"
[ -z "$rulesfiles" ] && my_exit "Insufficient Arguments - Rules missing" 1
[ -z "$STATEDIR" ] && my_exit "Insufficient Arguments State Directory missing" 1

debug_out "Rules set to $rulesfiles"

gen_rules() {
    # FIXME: PACKAGES-y
    if [ -e $PROJECTRULESDIR ]; then
	grep -s "^.*PACKAGES-\$(PTXCONF_"

}

gen_maps(){
    exec 5>${LABEL_TO_PACKAGE}
    exec 6>${LABEL_TO_FILE}

#    sed -n "s/.*PACKAGES-\$(PTXCONF_\(.*\))[[:space:]]*+=[[:space:]]*\([^[:space:]]\)/PACKAGE_\1=\2/p" $rulesfiles >&5

    for file in ${rulesfiles}; do
	LABEL=`sed -n "s/.*PACKAGES-\\$(PTXCONF_\(.*\))[[:space:]]*+=.*/\1/p" $file`
    done


    exec 6>/dev/null
    exec 5>/dev/null
}


do_fixup(){
    la_IFS="$IFS"
    IFS=":"
    cat $STATEDIR/configdeps | while read foo label deps; do
	ptxconf_label=PTXCONF_${label}
	if test "${!ptxconf_label}" = "y"; then
	    echo -n "DEP:$label"
	    for dep in $deps; do
		ptxconf_dep=PTXCONF_${dep}
		if test "${!ptxconf_dep}" = "y"; then
		    echo -n ":$dep"
		fi
	    done
	    echo
	fi
    done
    IFS="$la_IFS"
}

#
# argument handling
#
# case $ACTION in
#     defaults)
# 	do_defaults
# 	;;
#     *)
# 	my_exit "Sorry, unknown --action specified: $ACTION"
# 	;;
# esac

LABEL_TO_PACKAGE=${STATEDIR}/label-to-package.map
LABEL_TO_FILE=${STATEDIR}/label-to-file.map

. ptxconfig

gen_maps
. ${LABEL_TO_PACKAGE}

do_fixup

# vim: syntax=sh
# vim: tabstop=4
