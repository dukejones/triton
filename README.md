# Install #
Installation Script:

`wget -qO- https://git.io/fp7xA | fish`

## Quickstart ##

```bash
wget -qO- https://git.io/fp7xA | fish
triton bootstrap
nano ~/.config/fish/config.fish
```

Each package is a single line in config.fish which can be commented or edited.  When you fire up your shell it simply loads whatever you tell it to.

Optionally clean up your config.fish by adding packages in ~/.config/fish/fishfile.

It supports github libraries only for now.  

e.g. for https://github.com/joehillen/to-fish chop the first part off and write `triton joehillen/to-fish`.

## Usage ##
`triton` : Initialize Triton. This initializes triton, and loads or installs all of the libraries listed in your fishfile.

`triton bootstrap` : Copy the included configuration file templates into the config directory.

`triton [repo/lib]` : Load or install the specified library. e.g. `triton joehillen/to-fish` is at https://github.com/joehillen/to-fish

`triton fishfile [file]` : Load/install all of the libraries in the given fishfile.

## What Does It Do? ##

You give triton just about any repository that is meant to be a fish plugin, and it will install it. If it's already installed in triton's plugin installation directory, it will load it.

The end result is a nice list of all of installed packages in config.fish and fishfile, not a confusing pile of symlinks or a maze of deeply nested calls across multiple directories.  Everything is in `~/.config/fish/`, and everything triton is in the `triton` subdirectory.

## Great Packages ##

We suggest putting themes in config.fish to be able to comment them out at will, but reference them later.
Libraries that are must-haves and always givens can go into `Fishfile`.

```bash
# Some suggestions for your config.fish:

# triton oh-my-fish/theme-bobthefish
triton oh-my-fish/theme-agnoster
# triton oh-my-fish/theme-es
# triton jorgebucaran/fish-sol
# triton jorgebucaran/fish-sektor

triton joehillen/to-fish # Fish shell directory bookmarks
triton oh-my-fish/plugin-spark
triton oh-my-fish/plugin-node-binpath

# this requires the fzf binary installed
triton jethrokuan/fzf
# And this requires The Silver Searcher binary `ag`.
set -U FZF_FIND_FILE_COMMAND "ag -l --hidden --ignore .git"
set -U FZF_ENABLE_OPEN_PREVIEW 1
```

And here is my fishfile:
```bash
edc/bass
joehillen/to-fish
jethrokuan/z
```

### Other Package Lists ###
* [Awesome Fish](https://github.com/jorgebucaran/awesome-fish)

## Origin Story ##

One day I was searching for a setting in a Fish plugin that was causing a problem, but when I started looking through my Fish config, I became lost in a dense and impenetrable forest of references.  I couldn't find where the actual library files lived.  Was it symlinked from fisherman?  Was it in one of oh-my-fish's numerous special directories?  How was it even being loaded?!  What was being loaded?!!  Functions, or conf.d.... I had to read through the source code of oh-my-fish to figure out what the heck was going on.  It was almost enough to send me back to Zsh, again.

But recall that Fish has an actual scripting language that makes sense.  And so, armed with that and a few design principles I set out to make something discoverable, explicit, and magical enough to surprise and delight.  Please enjoy and drop me a line if you like it or have feedback.

Inspirations include: antigen.zsh, Vim+Pathogen.


# Triton #
![Triton](https://greekgodsandgoddesses.net/wp-content/uploads/2017/02/triton-1024x885.jpg "Triton")
