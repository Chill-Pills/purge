```

██████╗ ██╗   ██╗██████╗  ██████╗ ███████╗
██╔══██╗██║   ██║██╔══██╗██╔════╝ ██╔════╝
██████╔╝██║   ██║██████╔╝██║  ███╗█████╗  
██╔═══╝ ██║   ██║██╔══██╗██║   ██║██╔══╝  
██║     ╚██████╔╝██║  ██║╚██████╔╝███████╗
╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
           
```

Purge is a small CLI tool that helps giving you bundled commands in the web ecosystem.

## Installation

This bash script is made to the right format to be imported as an external plugin for Oh-my-Zsh. 
You just need to download it to the specific Oh-my-Zsh folder or clone it with git to be able to pull new updates.

Verify in `.zshrc` file, if you have declared a `ZSH_CUSTOM` variable pointing to a specific folder. If so, you need to put the plug-in in that directory.
Otherwise, the default path where to put the plugin is `.oh-my-zsh/custom/plugins`

```
cd "$ZSH_CUSTOM/plugins"
```

if you don't have a `plugins` folder yet

```
cd $ZSH_CUSTOM
mkdir plugins
cd plugins
```

then download the plugin

```
git clone https://github.com/Chill-Pills/purge.git
```

In your `.zshrc` file, you can now add the plugin

```
plugins=(purge)
```

if you have other plugins you can add it with a space

```
plugins=(git purge)
```

You'll then need to close your terminal or source the `.zshrc` file again.

`source ~/.zshrc`

Once you'll get the purge plugin installed, you can access a small command to source that file again like a breeze ;)

`zsource`

[You can read the Oh-my-Zsh documentation for further explanation](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-plugins)

## Usage

The CLI tools has multiple commands to manage different CLI tools.

Here are the following CLI tools available :

### List of command

`purge` or `purge help` or `purge list`

If you want to see a list of all the available command.

### Composer

`purge composer` or `purge c` or `pc`

This command will check if you have a `composer.json` file, otherwise you are in the wrong folder ;)
It will check if there's a `composer.lock` file and a `vendor` folder and delete them.
It will then run `composer install` to reinstall the packages according to the `composer.json` file.

### NPM

`purge npm` or `purge n` or `pn`

This command will check if there's a `package.json` file, otherwise you are in the wrong folder ;)
It will check if there's a `package-lock.json` file and a `node_modules` folder and delete them.
It will then run `npm install` to reinstall the packages according to the `package.json` file.

### Yarn

`purge yarn` or `purge y` or `py`

_This is the same behavior as the previous command but using Yarn instead of NPM._

This command will check if there's a `package.json` file, otherwise you are in the wrong folder ;)
It will check if there's a `package-lock.json` file and a `node_modules` folder and delete them.
It will then run `yarn install` to reinstall the packages according to the `package.json` file.

### Laravel Artisan

`purge artisan version` or `purge a version` or `pav`

It will show you the version of the Laravel Framework since php artisan shows it on top of all of the commands.

`purge artisan clean` or `purge a clean` or `pac`

It will help you clean all the cache that Laravel has in one command !

The following caches are dumped : cache, view, config, route.

And also composer's cache `composer dump-autoload`

`purge artisan freshseed ` or `purge a freshseed` or `paf`

If you want to have a clean database populated with the seeder's datas, then it's your go to command.

It calls the two following commands : 

`php artisan migrate:fresh`
`php artisan db:seed`

### Laravel Horizon

`purge horizon` or `purge h` or `ph`

### Puuurge

`puuurge`

Run all of the commands listed above to have the perfect tool to restart from scratch!

You can let all your anger go as you type this specific command !

That's why we give you a lot of aliases so the [2-10] `u` letter can begin to be your new negativity destroyer.

Go ahead ;)


`puurge` or  
`puuurge` or  
`puuuurge` or  
`puuuuurge` or  
`puuuuuurge` or  
`puuuuuuurge` or  
`puuuuuuuurge` or  
`puuuuuuuuurge` or  
`puuuuuuuuuurge`  

![Rick & Morty, Purge, Adult Swim](https://i.ytimg.com/vi/tJK9hh1j0Ag/maxresdefault.jpg)

## Aliases

Since the point of this CLI tools is to help get faster bundling commands,
we think that the command itself shouln't be painful to type. 
That's why we added out of the box's aliases to help you type faster!

`purge composer` or  
`purge c` or  
`pc`  

`purge npm` or  
`purge n` or  
`pn`  

`purge yarn` or  
`purge y` or  
`py`  

`purge artisan clean` or  
`purge a clean` or  
`pac`  

`purge artisan freshseed` or  
`purge a freshseed` or  
`paf`  

`purge horizon` or  
`purge h` or  
`ph`  

## Improvements

If you have any ideas or improvment that can be made, please create an issue in this repository so we can discuss it furthermore ! ;)

- Add a purge list documentation
- Add artisan version to documentation + alias

- Let NPM clean specify `dev` or `production` to rebuild after
- Let Yarn clean specify `dev` or `production` to rebuild after
- Command to install Horizon's service with systemd or supervisor for Mac or Ubuntu
- Let Horizon purge be able to specify systemd or supervisor
- Create daemon for Horizon / Websocket / ... with systemd or supervisor
- Let Horizon purge restart redis daemon also
