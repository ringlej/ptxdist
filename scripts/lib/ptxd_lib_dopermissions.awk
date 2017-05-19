#!/usr/bin/awk -f

BEGIN {
	FS = "\x1F";
}

$1 ~ "f" {
	printf("chmod %s	'.%s' &&\n" \
	       "chown %s.%s	'.%s' &&\n", \
	       $5, $2, $3, $4, $2);
}

$1 ~ "n" {
	printf("if [ ! \\( -b '.%s' -o -c '.%s' -o -p '.%s' \\) ]; then " \
	       "  mknod -m %s	'.%s'	%s %s %s &&\n" \
	       "  chown %s.%s	'.%s'\n" \
	       "fi &&\n", \
	       $2, $2, $2, $5, $2, $6, $7, $8, $3, $4, $2);
}
