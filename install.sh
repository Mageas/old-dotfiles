#!/usr/bin/env bash

#
# Variables
#
SCRIPT_FOLDER="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BACKUP_FOLDER="$HOME/.local/.dotfiles.backup"
TO_HOME_FOLDER=(.zshrc)
TO_XDG_CONFIG_FOLDER=(alacritty autostart dunst nvim picom ranger scripts wallpaper zsh)


#
# Anti ROOT
#
function anti_root () {
    if [[ $EUID -eq 0 ]]; then
        local RED='\033[0;31m'; local BOLD='\033[1m'
        printf "${RED}${BOLD}!! Please do not run this script as root !! \n" 1>&2
        exit 1
    fi
}


#
# Create backup
#
function backup () {
    if [[ -f "$BACKUP_FOLDER/check-backup.txt" ]]; then return 0; fi

    mkdir -p "$BACKUP_FOLDER/.config" &> /dev/null
    cd "$BACKUP_FOLDER" || exit
    touch check-backup.txt &> /dev/null

    for dots_home in "${TO_HOME_FOLDER[@]}"
    do
        env cp -rf "$SCRIPT_FOLDER/${dots_home}" "$BACKUP_FOLDER" &> /dev/null
    done

    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]//./}"
    do
        env cp -rf "$HOME/.config/${dots_xdg_conf}" "$BACKUP_FOLDER/.config" &> /dev/null
    done

    create_git_backup
}


#
# Install dotfiles
#
function install_dotfiles () {
    backup

    for dots_home in "${TO_HOME_FOLDER[@]}"
    do
        env rm -rf "$HOME/${dots_home}" &> /dev/null
        env cp -rf "$SCRIPT_FOLDER/${dots_home}" "$HOME/" &> /dev/null
    done

    mkdir -p "$HOME/.config"
    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]}"
    do
        env rm -rf "$HOME/.config/${dots_xdg_conf[*]//./}" &> /dev/null
        env cp -rf "$SCRIPT_FOLDER/.config/${dots_xdg_conf}" "$HOME/.config/${dots_xdg_conf}" &> /dev/null
    done

    echo -e "Your config is backed up in ${BACKUP_FOLDER}\n" >&2
    echo -e "Please do not delete check-backup.txt in your backup folder." >&2
    echo -e "It's used to backup and restore your old config.\n" >&2
}


#
# Uninstall dotfiles
#
function uninstall_dotfiles () {
    if ! [[ -f "$BACKUP_FOLDER/check-backup.txt" ]]; then 
        echo "You have not installed this dotfiles yet." >&2
        exit 1
    fi

    for dots_home in "${TO_HOME_FOLDER[@]}"
    do
        env rm -rf "$HOME/${dots_home}" &> /dev/null
        env cp -rf "$BACKUP_FOLDER/${dots_home}" "$HOME/" &> /dev/null
        env rm -rf "$BACKUP_FOLDER/${dots_home}" &> /dev/null
    done

    for dots_xdg_conf in "${TO_XDG_CONFIG_FOLDER[@]//./}"
    do
        env rm -rf "$HOME/.config/${dots_xdg_conf}" &> /dev/null
        env cp -rf "$BACKUP_FOLDER/.config/${dots_xdg_conf}" "$HOME/.config" &> /dev/null
        env rm -rf "$BACKUP_FOLDER/.config/${dots_xdg_conf}" &> /dev/null
    done

    if [ -x "$(command -v git)" ]; then
        cd "$BACKUP_FOLDER" || exit
        git add -u &> /dev/null
        git add . &> /dev/null
        git commit -m "Restore original config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
    fi

    echo "Your old config has been restored!" >&2
    echo "Thanks for using my dotfiles." >&2
    echo "Enjoy your next journey!" >&2
}


#
# Create git backup
#
function create_git_backup () {
    if [ -x "$(command -v git)" ]; then
        git init &> /dev/null
        git add -u &> /dev/null
        git add . &> /dev/null
        git commit -m "Backup original config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
    fi
}


#
# Usage
#
usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF
Usage: $program_name [-option]
Options:
    --help    Print this message
    -i        Install this dotfiles
    -r        Restore your old config
EOF
}


#
# Main
#
function main () {
    case "$1" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        -i)
            install_dotfiles
            ;;
        -r)
            uninstall_dotfiles
            ;;
        *)
            echo "Invalids arguments ($@)"
            usage
            exit 1
    esac
}


main "$@"