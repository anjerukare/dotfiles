# Don't complain then no matches found, e.g. then using asterisk
unsetopt nomatch
# On an ambiguous completion insert the first match immediately
setopt menucomplete
# Disable Ctrl-S to freeze terminal
stty stop undef
# Disable highlight on pasted text
zle_highlight=('paste:none')
# Initialize autocompletion
autoload -Uz compinit
compinit
# Enable autocompletion menu on second <Tab>
zstyle ':completion:*' menu select

## Handy functions, thanks Chris!
# Source file if it exists
function zsh_add_file() {
  [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# Source plugins files if plugin folder exists otherwise git clone plugin
function zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
  else
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
  fi
}

## Plugins
# goes here

## Exports
HISTFILE="$HOME/.local/share/zsh/history"
# If history file doesn't exists then create it
[ ! -f $HISTFILE ] && mkdir -p $(dirname $HISTFILE) && touch $HISTFILE
HISTSIZE=1000
SAVEHIST=1000
export MANPAGER='nvim +Man!'

## Aliases
alias v='nvim'

## Prompt
PROMPT='%F{251}%B%n@%m%f %F{168}%~%b%f %# '

## Nnn configuration
export NNN_OPTS='eR'
export NNN_COLORS='#a8a8a8a8'
export NNN_FCOLORS='a8a8a8fbfbfbfbfbfbfbfbfb'
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PLUG='f:autojump'
eval "$(jump shell zsh --bind=f)"
t ()
{
    # Block nesting of nnn in subshells
    [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ] && exit &> /dev/null

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

