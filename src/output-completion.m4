dnl TODO: Basename determination: output filename, or input filename, or nothing.
m4_include_once([argument_value_types.m4])
m4_include_once([value_validators.m4])

dnl Make somehow sure that the program name is translated to a valid shell function identifier
m4_define([_TRANSLATE_BAD_CHARS], [m4_translit([[$1]], [-.], [__])])

m4_define([GATHER_OPTIONS_OF_ARGUMENTS_THAT_ACCEPT_SOME_VALUE], [m4_do(
	[m4_lists_foreach_optional([_ARGS_LONG,_ARGS_SHORT,_ARGS_CATH], [_argname,_arg_short,_arg_type], [_IF_ARG_ACCEPTS_VALUE(_arg_type,
		[m4_set_contains([GROUP_SET_ARGS], _argname,
			[m4_do(
				[m4_pushdef([_group_set], _GET_VALUE_TYPE(_argname))],
				[m4_set_add([_GROUP_SETS], _group_set)],
				[m4_list_append([OPTIONS_FOLLOWED_BY_]_group_set, [--]_argname)],
				[m4_ifnblank(_arg_short, [m4_list_append([OPTIONS_FOLLOWED_BY_]_group_set, [-]_arg_short)])],
				[m4_popdef([_group_set])],
			)],
			[m4_do(
				[m4_list_append([OPTIONS_FOLLOWED_BY_SOME_VALUE], [--]_argname)],
				[m4_ifnblank(_arg_short, [m4_list_append([OPTIONS_FOLLOWED_BY_SOME_VALUE], [-]_arg_short)])],
			)],
		)],
	)])],
)])


dnl $1: The macro call (the caller is supposed to pass [$0($@)])
dnl What is also part of the API: The line
dnl ### START OF CODE GENERATED BY Argbash vx.y.z one line above ###
m4_define([ARGBASH_GO_BASE], [m4_do(
	[m4_ifnblank([$1], [[$1
]])],
	[dnl ASSERT_THAT_BASENAME_IS_KNOWN
],
	[GATHER_OPTIONS_OF_ARGUMENTS_THAT_ACCEPT_SOME_VALUE()],
	[m4_define([_BASENAME], INFERRED_BASENAME_NOERROR)],
	[m4_define([_PROGRAM_NAME], m4_dquote(_BASENAME))],
	[m4_define([_FUNCTION_NAME], m4_dquote(_[]_TRANSLATE_BAD_CHARS(_PROGRAM_NAME)))],
	[[#!/usr/bin/env bash]_ENDL_(2)],
	[[# Put this file to /etc/bash_completion.d/]_BASENAME()_ENDL_()],
	[[# needed because of Argbash --> m4_ignore@{:@@<:@]_ENDL_()],
	[_ARGBASH_ID()_ENDL_()],
	[[# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.dev for more info]_ENDL_(2)],
	[_IF_SOME_ARGS_ARE_DEFINED([m4_do(
		[GENERATE_COMPLETION_FUNCTION(_FUNCTION_NAME)_ENDL_()],
		[complete -F _FUNCTION_NAME _PROGRAM_NAME()_ENDL_()],
	)])],
	[[### END OF CODE GENERATED BY Argbash (sortof) ### @:>@@:}@]],
)])


dnl
dnl Identify the Argbash version (this is part of the API)
m4_define([_ARGBASH_ID],
	[### START OF CODE GENERATED BY Argbash v]_ARGBASH_VERSION[ one line above ###])


dnl
dnl TODO: Sort options according to arg type
dnl - offer getopts-like completion if applicable and when completing a short arg.
dnl - if we follow a value-accepting arg (long, short), offer completion tailored to that value.
dnl - if not, offer default completion (TBD: Positional argument, doubledash)
dnl - if it seems that we want to specify long/short arg, complete arg names.
m4_define([_INNER_CASE_ELEMENTS], [m4_do(
	[_JOIN_INDENTED(3,
		[[case "$cur" in]],
	)],
	[_JOIN_INDENTED(4,
		[[--*@:}@]],
		_INDENT_MORE(m4_dquote_elt(
			[COMPREPLY=( $(compgen -W "${all_long_opts}" -- "${cur}") )],
			[return 0],
			[;;],
		)),
		[[-*@:}@]],
		_INDENT_MORE(m4_dquote_elt(
			[COMPREPLY=( $(compgen -W "${all_short_opts}" -- "${cur}") )],
			[return 0],
			[;;],
		)),
		[[*@:}@]],
		_INDENT_MORE(m4_dquote_elt(
			[COMPREPLY=( $(compgen -o bashdefault -o default -- "${cur}") )],
			[return 0],
			[;;],
		)),
	)],
	[_JOIN_INDENTED(3,
		[[esac]],
	)],
)])


m4_define([_OUTER_CASE_ELEMENTS], [m4_do(
	[_JOIN_INDENTED(1,
		[[case "$prev" in]],
	)],
	[m4_set_foreach([_GROUP_SETS], [_group_set], [m4_do(
		[_JOIN_INDENTED(2,
			[m4_list_join([OPTIONS_FOLLOWED_BY_]_group_set, [|])[@:}@]],
			_INDENT_MORE(m4_dquote_elt(
				[COMPREPLY=( $(compgen -W "]m4_list_join([_LIST_]_group_set, [ ])[" -- "${cur}") )],
				[return 0],
				[;;],
			)),
		)],
	)])],
	[m4_list_ifempty([OPTIONS_FOLLOWED_BY_SOME_VALUE], ,
		[_JOIN_INDENTED(2,
			[m4_list_join([OPTIONS_FOLLOWED_BY_SOME_VALUE], [|])[@:}@]],
			_INDENT_MORE(m4_dquote_elt(
				[COMPREPLY=( $(compgen -o bashdefault -o default -- "${cur}") )],
				[return 0],
				[;;],
			)),
		)])],
	[_JOIN_INDENTED(1,
		[_INDENT_()[*@:}@]],
	)],
	_INNER_CASE_ELEMENTS(),
	[_INDENT_()esac],
)])


dnl
dnl $1: Basename
m4_define([GENERATE_COMPLETION_FUNCTION], [m4_do(
	[[$1 ()
{
]],
	[_JOIN_INDENTED(1,
		[local cur prev opts base],
		[COMPREPLY=()],
		[[cur="${COMP_WORDS[COMP_CWORD]}"]],
		[[prev="${COMP_WORDS[COMP_CWORD-1]}"]],
		[all_long_opts="m4_lists_foreach_optional([_ARGS_LONG], [_argname],
			[--_argname ])"],
		[all_short_opts="m4_lists_foreach_optional([_ARGS_SHORT], [_arg_short],
			[m4_ifnblank(_arg_short, [-_arg_short ])])"],
	)],
	[_OUTER_CASE_ELEMENTS()]
[
}],
)])
