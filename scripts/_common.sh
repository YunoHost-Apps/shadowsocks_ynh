#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="python python-dev python-setuptools openssl libssl-dev curl wget unzip gcc automake autoconf make libtool"

# libsodium version for temp folder
libsodium_file="libsodium-1.0.17"

#=================================================
# PERSONAL HELPERS
#=================================================


#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================


ynh_smart_mktemp () {
        local min_size="${1:-300}"
        # Transform the minimum size from megabytes to kilobytes
        min_size=$(( $min_size * 1024 ))

        # Check if there's enough free space in a directory
        is_there_enough_space () {
                local free_space=$(df --output=avail "$1" | sed 1d)
                test $free_space -ge $min_size
        }

        if is_there_enough_space /tmp; then
                local tmpdir=/tmp
        elif is_there_enough_space /var; then
                local tmpdir=/var
        elif is_there_enough_space /; then
                local tmpdir=/   
        elif is_there_enough_space /home; then
                local tmpdir=/home
        else
		ynh_die "Insufficient free space to continue..."
        fi

        echo "$(sudo mktemp --directory --tmpdir="$tmpdir")"
}
