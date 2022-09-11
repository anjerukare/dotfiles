# Don't complain then no matches found, e.g. then using asterisk
unsetopt nomatch
# On an ambiguous completion insert the first match immediately
setopt menucomplete
# Disable Ctrl-S to freeze terminal
stty stop undef
# Disable highlight on pasted text and add highlight on selection
zle_highlight=('paste:none', 'region:bg=168,fg=251')
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

### Vi mode
bindkey -v
# Delete characters with <Backspace> no matter when they were inserted
bindkey -M viins '^?' backward-delete-char
# Delete words with <c-W> no matter when they were inserted
backward-kill-semantic-word() {
  # TODO find the way to kill word like it does vi-backward-kill-word
  # e.g. for 'mvn clean package -DskipTests=true' behavior differs
  local WORDCHARS=''
  zle backward-kill-word
}
zle -N backward-kill-semantic-word
bindkey -M viins '^w' backward-kill-semantic-word

# Left, down, up, right
bindkey -M vicmd 'm' vi-backward-char
bindkey -M vicmd 'n' down-line-or-history
bindkey -M vicmd 'e' up-line-or-history
bindkey -M vicmd 'i' vi-forward-char

# Insert and insert at beginning of line
bindkey -M vicmd 't' vi-insert
bindkey -M vicmd 'T' vi-insert-bol

# Till
bindkey -M vicmd 'l' vi-find-next-char-skip
bindkey -M vicmd 'L' vi-find-prev-char-skip

# Semantic end of word, end of word
bindkey -M vicmd 'k' vi-forward-word-end
bindkey -M visual 'k' vi-forward-word-end
bindkey -M vicmd 'K' vi-forward-blank-word-end
bindkey -M visual 'K' vi-forward-blank-word-end

# Next match, previous match
bindkey -M vicmd 'h' history-search-backward
bindkey -M vicmd 'H' history-search-forward

# Handy escape from insert mode
bindkey -M viins 'ii' vi-cmd-mode

## Fix vi combination
# Unbind all bindings that starts with i in visual mode
# Found keys here: github.com/zsh-users/zsh/blob/master/Src/Zle/zle_keymap.c
# in default bindings function
bindkey -M visual -r 'iw'
bindkey -M visual -r 'iW'
bindkey -M visual -r 'ia'

# Define widgets that go into visual-mode and select word
visual-select-in-word() { zle visual-mode; zle select-in-word }
zle -N visual-select-in-word
visual-select-in-blank-word() { zle visual-mode; zle select-in-blank-word }
zle -N visual-select-in-blank-word
visual-select-in-shell-word() { zle visual-mode; zle select-in-shell-word }
zle -N visual-select-in-shell-word

# Bind it for command mode
bindkey -M vicmd 'viw' visual-select-in-word
bindkey -M vicmd 'viW' visual-select-in-blank-word
bindkey -M vicmd 'via' visual-select-in-shell-word

## Vi cursor style based on current mode
zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne '\e[6 q'
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[6 q'; } # Use beam shape cursor for each new prompt

## Use system clipboard then yanking and pasting
# Reference: unix.stackexchange.com/a/390523
xsel-wrap-widgets() {
    local copy_or_paste=$1
    shift

    for widget in $@; do
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function _xsel-wrapped-$widget() {
                zle .$widget
                printf '%s' \$CUTBUFFER | xsel -ib
            }
            "
        else
            eval "
            function _xsel-wrapped-$widget() {
                CUTBUFFER=\$(xsel -ob)
                zle .$widget
            }
            "
        fi

        zle -N $widget _xsel-wrapped-$widget
    done
}

local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)

xsel-wrap-widgets copy $copy_widgets
xsel-wrap-widgets paste $paste_widgets

## Plugins
# goes here

## Exports
HISTFILE="$HOME/.local/share/zsh/history"
# If history file doesn't exists then create it
[ ! -f $HISTFILE ] && mkdir -p $(dirname $HISTFILE) && touch $HISTFILE
HISTSIZE=1000
SAVEHIST=1000
export PAGER='less'

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

