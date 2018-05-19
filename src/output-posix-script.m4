m4_include([function_generators.m4])
m4_include([argument_value_types.m4])
m4_include([env_vars.m4])
m4_include([progs.m4])
m4_include([value_validators.m4])


dnl TODO: Can't do:
dnl  - validation of group options
dnl  - multi-valued arguments

m4_define([MAKE_FUNCTION], [MAKE_POSIX_FUNCTION($@)])


m4_define([_MAKE_DEFAULTS_TO_ALL_POSITIONAL_ARGUMENTS], [[no]])
m4_define([_IF_MAKE_DEFAULTS_TO_ALL_POSITIONAL_ARGUMENTS], [m4_if(_MAKE_DEFAULTS_TO_ALL_POSITIONAL_ARGUMENTS,
	[yes], [$1],
	[$2])])


m4_define([ENSURE_OPTIONAL_ARGS_HAVE_OPTIONS],
	[m4_lists_foreach_optional([_ARGS_LONG,_ARGS_SHORT], [_argname,_arg_short], [m4_ifblank(_arg_short,
		[m4_fatal([Optional argument --]_argname[ doesn't have a short option, which is not supported in POSIX mode.])],
	)])])


dnl $1: The macro call (the caller is supposed to pass [$0($@)])
dnl What is also part of the API: The line
dnl ### START OF CODE GENERATED BY Argbash vx.y.z one line above ###
m4_define([ARGBASH_GO_BASE], [m4_do(
	[[$1
]],

	[dnl ENSURE_OPTIONAL_ARGS_HAVE_OPTIONS
],
	[DEFINE_MINIMAL_POSITIONAL_VALUES_COUNT],
	[[# needed because of Argbash --> m4_ignore@{:@@<:@]_ENDL_()],
	[_ARGBASH_ID()_ENDL_()],
	[[# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info

]],
	[_SETTLE_ENV],
	[_IF_SOME_ARGS_ARE_DEFINED([m4_do(
		[_MAKE_UTILS_POSIX()_ENDL_()],
		[_IF_HAVE_POSITIONAL_ARGS([_MAKE_DEFAULTS_POSITIONAL_POSIX])],
		[_IF_HAVE_OPTIONAL_ARGS([_MAKE_DEFAULTS_OPTIONAL])],
		[_ENDL_()],
		[_ENDL_()_MAKE_HELP([_FORMAT_OPTIONAL_ARGUMENT_FOR_POSIX_HELP_SYNOPSIS], [_POSIX_HELP_OPTION_COMPOSER])_ENDL_(2)],
		[_MAKE_VALUES_ASSIGNMENTS_BASE_POSIX(
			[_IF_DIY_MODE([_ASSIGN_PREPARE], [_ASSIGN_GO])],
			[POSIX])_ENDL_()],
	)])],
	[_MAKE_OTHER()_ENDL_()],
	[[### END OF CODE GENERATED BY Argbash (sortof) ### @:>@@:}@]],
)])
dnl
dnl Identify the Argbash version (this is part of the API)
m4_define([_ARGBASH_ID],
	[### START OF CODE GENERATED BY Argbash v]_ARGBASH_VERSION[ one line above ###])

