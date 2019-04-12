# Install #
Installation Script:

`curl -L https://git.io/fp7xA | fish`

## Usage ##
`triton` : Initialize Triton. This initializes triton, and loads or installs all of the libraries listed in your fishfile.

`triton bootstrap` : Copy the included configuration file templates into the config directory.

`triton [repo/lib]` : Load or install the specified library. e.g. `triton joehillen/to-fish` is at https://github.com/joehillen/to-fish

`triton fishfile [file]` : Load/install all of the libraries in the given fishfile.

## What Does It Do? ##

You give triton just about any repository that is meant to be a fish plugin, and it will try to install it. If it's already installed in triton's plugin installation directory, it will just load it.

You get a nice list of all of your libraries in your config.fish and fishfile, not a confusing array of symlinks[1] and nested calls in various directories.  Everything is in `~/.config/fish/`.

[1] Note that there is a single symlink, triton itself in the functions/ directory, to bootstrap the whole thing.

## Favorites ##

Here is a fairly up-to-date list of my favorite plugins:

I usually put themes in config.fish so I can comment them out at will.

```bash
### THEMES ###
# triton oh-my-fish/theme-bobthefish
triton oh-my-fish/theme-agnoster
# triton oh-my-fish/theme-es
# triton jorgebucaran/fish-sol
# triton jorgebucaran/fish-sektor

triton joehillen/to-fish # Fish shell directory bookmarks
triton oh-my-fish/plugin-spark
triton oh-my-fish/plugin-node-binpath

# this requires fzf installed on your command line
triton jethrokuan/fzf
# And this causes it to use the silver searcher.
set -U FZF_FIND_FILE_COMMAND "ag -l --hidden --ignore .git"
set -U FZF_ENABLE_OPEN_PREVIEW 1
```

And here is my fishfile:
```bash
edc/bass
jethrokuan/z
fisherman/pyenv
```

### Have your own favorites? ###
Open up an issue and I'll merge the ones I like best :)

Also open an issue if you have an idea for how to structure a decent centralized list of useful plugins. Right now finding a good fish plugin is a safari.

## Where did this come from? ##

One day I was searching for a setting in a Fish plugin that was causing a problem, but when I started looking through my Fish config, I became dissatisfied and discouraged.  I couldn't find where the actual library files lived.  Was it symlinked from fisherman?  Was it in one of oh-my-fish's numerous special directories?  How was it even being loaded?!  What was being loaded?!!  Not in functions, or conf.d.... I had to read through the source code of the package managers to figure out what the heck was going on.  It was almost enough to send me back to Zsh, again.

But then I remembered that Fish has an actual scripting language that makes sense, unlike /some/ shells (bash, I'm looking at you).  So I set about copying the best-in-breed: discoverable, explicit, and just magical enough to surprise and delight.  Thus Triton was born.

Inspirations include: antigen.zsh, Vim+Pathogen.


# Triton #
![Triton](https://greekgodsandgoddesses.net/wp-content/uploads/2017/02/triton-1024x885.jpg "Triton")
