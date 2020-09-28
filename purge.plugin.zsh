#!/bin/bash

function purge() {
    purgeTitle
    textGray 'brought to you by Capsule\n'

    if [[ $1 =~ ^(a|artisan)$ ]] then
        purgeLaravelArtisan "$2"
    elif [[ $1 =~ ^(c|composer)$ ]] then
        purgeComposer
    elif [[ $1 =~ ^(n|npm)$ ]] then
        purgeNpm
    elif [[ $1 =~ ^(y|yarn)$ ]] then
        purgeYarn
    elif [[ $1 =~ ^(h|horizon)$ ]] then
        purgeLaravelHorizon
    elif [[ $1 =~ ^(help|list)$ ]] then
        purgeList
    else
        purgeList
    fi
}

function purgeList() {

    textBold "purge artisan\n"

    textBold "    purge artisan version\n"

    textItalic "        Show current laravel framework's version.\n"

    textBold "    purge artisan clean\n"

    textItalic "        Clear all laravel's caches.\n"

    textBold "    purge artisan freshseed\n"

    textItalic "        Clear database and run seeders.\n"

    textBold "purge composer\n"

    textItalic "        Clear vendor folder and lock file and reinstall everything.\n"

    textBold "purge npm"

    textItalic "        Clear node_modules folder and lock file and reinstall everything.\n"

    textBold "purge yarn\n"

    textItalic "        Clear node_modules folder and lock file and reinstall everything.\n"

    textBold "purge horizon\n"

    textItalic "        Stop horizon, clear cache, run horizon back up.\n"

    textBold "puuurge\n"

    textItalic "        Run every listed commands \n"

}

function puuurge() {
    purgeTitle
    textGray 'brought to you by Capsule\n'

    if ! [[ -e artisan ]] then
        textBold "Artisan command not found"
        echo "Check if you are in your project's directory! ;)"
    else
        purgeLaravelArtisan "clean"
        purgeLaravelArtisan "freshseed"
        purgeComposer
        purgeNpm
        purgeYarn
        purgeLaravelHorizon
    fi
}

function purgeLaravelArtisan() {
    textGray 'Artisan purge brought to you by Capsule\n'

    if ! [[ -e artisan ]] then
        textBold "Artisan command not found"
        echo "Check if you are in your project's directory! ;)"
    else
        if [[ $1 == "clean" ]] then

            echo "Cleaning Laravel Cache"
            command php artisan cache:clear
            echo "Cleaning Laravel View"
            command php artisan view:clear
            echo "Cleaning Laravel Config"
            command php artisan config:clear
            echo "Cleaning Laravel Route"
            command php artisan route:clear
            echo "Dumping composer"
            command composer dump-autoload

        elif [[ $1 == "freshseed" ]] then

            echo "Migrate Fresh"
            command php artisan migrate:fresh
            echo "Seed database"
            command php artisan db:seed

        elif [[ $1 == "version" ]] then

            command php artisan | grep "Laravel Framework"

        fi
    fi
}

function purgeComposer() {
    textGray 'Composer purge brought to you by Capsule\n'

    if ! [[ -e composer.json ]] then
        textBold "There's no composer.json file found."
        echo "Check if you are in your project's directory! ;)"
    else
        if [[ -e "composer.lock" ]] then
            echo "Removing Composer lock file"
            command rm composer.lock
        fi

        if [[ -d "vendor" ]] then
            echo "Removing Composer vendor directory"
            command rm -rf vendor
        fi

        echo "Installing Composer dependencies"
        command composer install
    fi
}

function purgeNpm() {
    textGray 'Npm purge brought to you by Capsule\n'

    if ! [[ -e package.json ]] then
        textBold "There's no package.json file found."
        echo "Check if you are in your project's directory! ;)"
    else
        if [[ -e "package-lock.json" ]] then
            echo "Removing npm lock file"
            command rm package-lock.json
        fi

        if [[ -d "node_modules" ]] then
            echo "Removing node_modules"
            command rm -rf node_modules
        fi

        echo "Installing npm dependencies and transpiling"
        command npm install && npm run dev
    fi
}

function purgeYarn() {
    textGray 'Yarn purge brought to you by Capsule\n'

    if ! [[ -e package.json ]] then
        textBold "There's no package.json file found."
        echo "Check if you are in your project's directory! ;)"
    else
        if [[ -e "yarn.lock" ]] then
            echo "Removing yarn lock file"
            command rm yarn.lock
        fi

        if [[ -d "node_modules" ]] then
            echo "Removing node_modules"
            command rm -rf node_modules
        fi

        echo "Installing yarn dependencies and transpiling"
        command yarn && yarn dev
    fi
}

function purgeLaravelHorizon() {
    textGray 'Laravel Horizon purge brought to you by Capsule\n'

    if ! [[ -e artisan ]] then
        textBold "Artisan command not found"
        echo "Check if you are in your project's directory! ;)"
    else
        sudo -v
        echo '\U0001f53d Stop horizon service'
        command systemctl stop horizon.service
        echo "\U0001f5d1  Clean all Laravel's caches"
        purgeLaravelArtisan "clean"
        echo '\U0001f53c Start horizon service back up'
        command systemctl start horizon.service
        echo "\U0001f441 Check horizon service's status"
        command systemctl status horizon.service
    fi
}

function purgeInstallDaemonLaravelHorizon() {
    textGray 'Laravel Horizon daemon installer brought to you by Capsule\n'

    if ! [[ -e artisan ]] then
        echo "Check if you are in your project's directory! ;)"
    else
        echo 'We need sudo access to create daemons. :)'
        sudo -v #ask password beforehand
        currentDirectory = $(pwd)

        read -p 'Do you want to use supervisor or systemd? [supervisor/systemd]' daemonManager
        read -p 'What user will run the daemon?' user

        if [[ $daemonManager =~ ^[supervisor]$ ]]
        then

            # cat > /etc/supervisor/conf.d/laravel-horizon.conf <<DAEMONSUPERVISOR
            cat <<DAEMONSUPERVISOR
[program:laravel-horizon]
directory=$currentDirectory/
command=/usr/bin/php artisan horizon

process_name=%(program_name)s_%(process_num)02d
autostart=true
autorestart=true
user=$user
numprocs=1
startsecs=1
redirect_stderr=true
stdout_logfile=/home/forge/.forge/daemon-589083.log
DAEMONSUPERVISOR

        elif [[ $daemonManager =~ ^[systemd]$ ]]

            # cat > /etc/systemd/system/laravel-horizon.service <<DAEMONSYSTEMD
            cat <<DAEMONSYSTEMD
[Unit]
Description=LaravelHorizon
Requires=network.target

[Service]
User=$user
ExecStart=/usr/bin/php $currentDirectory/artisan horizon
ExecStop=/usr/bin/php $currentDirectory/artisan horizon:terminate

[Install]
WantedBy=multi-user.target
DAEMONSYSTEMD

        fi
    fi
}

# Helper functions

function purgeTitle() {
titleGray <<'TITLE'

██████╗ ██╗   ██╗██████╗  ██████╗ ███████╗
██╔══██╗██║   ██║██╔══██╗██╔════╝ ██╔════╝
██████╔╝██║   ██║██████╔╝██║  ███╗█████╗
██╔═══╝ ██║   ██║██╔══██╗██║   ██║██╔══╝
██║     ╚██████╔╝██║  ██║╚██████╔╝███████╗
╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝

TITLE
}

function titleGray() {
    while read -r line; do textGray "$line"; done;
}

function textGray() {
    echo -e "\e[37m$1\e[0m";
}

function textItalic() {
    echo -e "\e[3m$1\e[0m";
}

function textBold() {
    echo -e "\e[1m$1\e[0m";
}

function zsource() {
    echo "Sourcing oh-my-zsh rc file"
    source ~/.zshrc
}

# Aliases

alias pc="purge composer"
alias pn="purge npm"
alias py="purge yarn"
alias pav="purge artisan version"
alias pac="purge artisan clean"
alias paf="purge artisan freshseed"
alias ph="purge horizon"

alias puurge="puuurge"
alias puuuurge="puuurge"
alias puuuuurge="puuurge"
alias puuuuuurge="puuurge"
alias puuuuuuurge="puuurge"
alias puuuuuuuurge="puuurge"
alias puuuuuuuuurge="puuurge"
alias puuuuuuuuuurge="puuurge"
