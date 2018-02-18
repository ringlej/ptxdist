#pragma once

/*
 * For copyright/license information refer COPYING in the main directory
 */

#ifdef SUPPORT_ATTRIBUTE_FORMAT
# define __format(x,y) __attribute__((format (gnu_printf, x, y)))
#else
# define __format(x,y)
#endif

#ifdef SUPPORT_ATTRIBUTE_NONNULL
# define __non_null __attribute__((nonnull))
# define __non_null_pos(x...) __attribute__((nonnull(x))
#else
# define __non_null
# define __non_null_pos(x...)
#endif

#ifdef SUPPORT_ATTRIBUTE_CONST
# define __const __attribute__((const))
#else
# define __const
#endif

#ifdef SUPPORT_ATTRIBUTE_FORMAT_ARG
# define __format_arg(x) __attribute__((format_arg (x)))
#else
# define __format_arg(x)
#endif

#ifdef SUPPORT_ATTRIBUTE_NORETURN
# define __noreturn __attribute__((noreturn))
#else
# define __noreturn
#endif

#ifdef SUPPORT_ATTRIBUTE_PACKED
# define __packed __attribute__((packed))
#else
# define __packed
#endif

#ifdef SUPPORT_ATTRIBUTE_PURE
# define __pure __attribute__((pure))
#else
# define __pure
#endif

#ifdef SUPPORT_ATTRIBUTE_UNUSED
# define __unused __attribute__((unused))
#else
# define __unused
#endif

#ifdef SUPPORT_ATTRIBUTE_VISIBILITY_DEFAULT
# ifdef DSO_HIDDEN
#  define DSO_VISIBLE __attribute__ ((visibility("default")))
# else
#  define DSO_VISIBLE
# endif /* DSO_HIDDEN */
#else
#  define DSO_VISIBLE
#endif /* SUPPORT_FLAG_VISIBILITY */

#ifdef SUPPORT_ATTRIBUTE_DEPRECATED
# define __deprecated __attribute__((deprecated))
#else
# define __deprecated
#endif

#ifdef SUPPORT_ATTRIBUTE_CLEANUP
# define __cleanup(x) __attribute__((cleanup (x)))
#else
# define __cleanup(x)
#endif
