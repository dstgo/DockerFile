#!/usr/bin/env bash

cmd=$1
args="${@:2}"

# help usage information
usage_string="dst script provide abilities to manage don't starve together dedicated server in docker.

Usage:
        dst [command] [arguments]

Example:
        dst version MyServer

The commands are:

        help          print command usage
        install       install dst app from steamcmd (stored in /root/.klei/DoNotStarveTogether/)
        update        check and update dst app from steamcmd
        version       show specified dedicated server version
        list          list all saves (stored in /root/.klei/DoNotStarveTogether/)

"

app_id=343050
readonly app_id
# default saves stored position
save_pos="/root/.klei/DoNotStarveTogether"
readonly save_pos
# default save name
default_save="MyDediServer"
readonly default_save
# default backup position
backup_pos="/root/.klei/backups"
readonly backup_pos
# dedicated server position
dst_dir="/root/dst"
readonly dst_dir

# print usage
function Usage() {
    echo "${usage_string}"
}

# show dedicated server version
function Version() {
    local save=${default_save}
    if [ "${args}" != ""  ];then
        save="${args}"
    fi
    echo "$(cat "${save_pos}/${save}/version.txt")"
}

# list all saves stored in ${default_dir}
function ListSaves() {
    echo "$(ls ${save_pos} -1)"
}

# install dedicated server from steamcmd, and do not validate
function InstallDedicateServer() {
    mkdir -p ${dst_dir}
    steamcmd +force_install_dir ${dst_dir} +login anonymous +app_update ${app_id} +quit
}

# check update dedicated server from steamcmd, and validate app
function UpdateDedicatedServer() {
   steamcmd +force_install_dir ${dst_dir} +login anonymous +app_update ${app_id} validate +quit
}

function Main() {
  case ${cmd} in
  "help")
      Usage
    ;;
  "version")
      Version
    ;;
  "list")
      ListSaves
    ;;
  "install")
    InstallDedicateServer
    ;;
  "update")
    UpdateDedicatedServer
    ;;
  *)
    Usage
    ;;
  esac
}

Main






