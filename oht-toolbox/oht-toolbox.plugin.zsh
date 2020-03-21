_oht_toolbox () {
    typeset -A opt_args

    _arguments -C \
        '1:cmd1:->cmd1' \
        '2:cmd2:->cmd2' \
        '*:: :->args' \
        && ret=0

    case "$state" in
        (cmd1)
            local SERVICES=(
            "acceptance"
            "apidoc:Rebuild API docs. Requires absolute path to OHT dir"
            "branch"
            "clean_docker"
            "clear_rmq:Clear rabbitmq queues"
            "composer"
            "cron:Cron commands"
            "db"
            "exec"
            "down"
            "fixer"
            "install-crowdin:setup OHT Crowdin service"
            "install-mynmt:setup OHT MyNMT"
            "install-nmt:setup OHT NMT API server"
            "install:Fresh install OHT on this host"
            "list_rmq"
            "logs"
            "memcache"
            "mysql_restore"
            "mysqldump:Dump trans db to std. output"
            "prune:Prune all unused images,containers, volumes"
            "pull:Get fresh set of images"
            "push:Push new set of images"
            "restart_sweatshop:Restart sweatshop workers"
            "ssh:Log in to a running container. Leave 'Container Name' blank to log-in into Toolbox container"
            "ui"
            "unit"
            "up:Boot the OHT project"
            "version"
            "rebuild:Rebuild images (for docker maintainer, others please use pull)"
            "run-api-test:Run API tests"
            "run-acceptance-test:Run acceptance tests"
            "ms"
            )

            _describe -t SERVICES 'SERVICES' SERVICES && ret=0
            ;;
        (cmd2)
            declare -A ACTIONS
            ACTIONS[cron]="run list"
            ACTIONS[db]="migrate list console init"
            ACTIONS[up]="-d"
            ACTIONS[composer]="install update require"
            ACTIONS[memcache]="clear stats version cli help"
            ACTIONS[restart_sweatshop]="--non-interactive"
            ACTIONS[fixer]="checkonly autofix help"
            ACTIONS[ui]="build short_description help"
            ACTIONS[branch]="-f -p --pull -np --no-pull -f --fetch-origin"
            ACTIONS[ms]="clone list exclude docker-compose build up logs down stop ms-path init update"

            ACT=$line[1]

            if test "${ACTIONS[$ACT]+isset}"
            then
                LIST=${ACTIONS[$ACT]}

                #compadd $LIST
                cmd2_list=($(echo "${ACTIONS[$ACT]}" | tr " " "\n"))
                _describe 'cmd2_list' cmd2_list && ret=0
            fi

            ;;
        (args)
            if [ ${line[2]} = "run" ] ; then
                compadd $(find $1/oht/scripts/periodic -type f | grep -v /disabled | grep -oP "periodic\/\K(.*)")
            fi
            if [ ${line[2]} = "migrate" ] ; then
                compadd add latest
            fi

            ;;
    esac

    _path_files

    return 1
}

if [ -z ${oht_toolbox_alias+x} ]; then
    export oht_toolbox_alias='toolbox'
fi

if [ -z ${oht_workspace_dir+x} ]; then
    export oht_workspace_dir=~/workspace
fi

alias $oht_toolbox_alias="$oht_workspace_dir/oht/toolbox.sh"

compdef '_oht_toolbox $oht_workspace_dir' $oht_toolbox_alias

setopt complete_aliases
