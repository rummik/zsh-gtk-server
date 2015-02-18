#!/bin/zsh

_GTK_SERVER=${0:h}/gtk-server
_GTK_SERVER_INIT=0

function gtk-server {
	local resvar=_res

	if [[ $_GTK_SERVER_INIT -eq 0 ]]; then
		local _WD=$PWD
		cd $(dirname $_GTK_SERVER)
		coproc ./gtk-server -stdin
		_GTK_SERVER_INIT=1
		cd $_WD
	fi

	if [[ $1 == '-r' && ! -z $2 ]]; then
		resvar=$2
		shift 2
	fi

	if [[ ! -z "$@" ]]; then
		cmd=$_prefix$1; shift
		print -p $cmd ${(qq)@}
		read -p $resvar
	fi
}

function gtk {
	local _prefix=${0}_
	gtk-server $@
}

function gdk {
	local _prefix=${0}_
	gtk-server $@
}
