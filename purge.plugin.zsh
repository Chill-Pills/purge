#!/bin/bash

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

function textBold() {
    echo -e "\e[1m$1\e[0m";
}

function purgeArtisan() {
    textGray 'Artisan purge brought to you by Capsule'

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
    textGray 'Composer purge brought to you by Capsule'

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
    textGray 'Npm purge brought to you by Capsule'

    if ! [[ -e package.json ]] then
        textBold "There's no package.json file found."
        echo "Check if you are in your project's directory! ;)"
    else
        if [[ -e "yarn.lock" ]] then
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
    textGray 'Yarn purge brought to you by Capsule'

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
    textGray 'Laravel Horizon purge brought to you by Capsule'
    sudo -v
    echo '&#x1f5d1 Stop horizon service'
    command systemctl stop horizon.service
    echo "Clean all Laravel\'s caches"
    purgeArtisan "clean"
    echo '&#x1f5d1 Start horizon service back up'
    command systemctl start horizon.service
    echo "&#x1f5d1 Check horizon service's status"
    command systemctl status horizon.service
}

function purge() {
    purgeTitle

    if [[ $1 =~ ^(a|artisan)$ ]] then
        purgeArtisan "$2"
    elif [[ $1 ==~ ^(c|composer)$ ]] then
        purgeComposer
    elif [[ $1 ==~ ^(n|npm)$ ]] then
        purgeNpm
    elif [[ $1 ==~ ^(y|yarn)$ ]] then
        purgeYarn
    elif [[ $1 ==~ ^(h|horizon)$ ]] then
        purgeLaravelHorizon
    fi
}

function zsource() {
    echo "Sourcing oh-my-zsh rc file"
    source ~/.zshrc
}

alias pc="purge composer"
alias pn="purge npm"
alias py="purge yarn"
alias pac="purge artisan clean"
alias paf="purge artisan freshseed"
alias ph="purge horizon"
