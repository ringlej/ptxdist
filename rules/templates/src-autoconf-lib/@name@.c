/*
 * For copyright/license information refer COPYING in the main directory
 */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <stdlib.h>
#include <stdio.h>

#include "internal.h"
#include "lib@name@.h"

static void @name@_file_private_function(void)
{
}

void @name@_library_private_function(void)
{
}

DSO_VISIBLE int @name@_library_globally_visible_function(void)
{
	printf("lib@name@ opened\n");
	@name@_file_private_function();
	@name@_library_private_function();
	return EXIT_SUCCESS;
}
