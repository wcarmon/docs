# ~/.bash_profile: executed on login
# ~/.profile: executed on login, ignored when ~/.bash_profile or ~/.bash_login exist

# Only for bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# ------------------------------------
# -- PATH
# ------------------------------------
PATH="$PATH:$HOME/.sdkman/candidates/java/current/bin"
PATH="$PATH:$HOME/.sdkman/candidates/kotlin/current/bin"
PATH="$PATH:$HOME/.sdkman/candidates/visualvm/current/bin"
PATH="$PATH:$HOME/.sdkman/candidates/gradle/current/bin"
PATH="$PATH:/usr/local/go/bin"

PATH="$PATH:/bin"
PATH="$PATH:/usr/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/go/bin"

PATH="$PATH:/sbin"
PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/sbin"

PATH="$PATH:/opt/homebrew/bin"
PATH="$PATH:/snap/bin"


# ------------------------------------
# -- guake
# ------------------------------------
if [[ $DISPLAY ]]; then
    if [ -f "/usr/bin/guake" ] ; then
        /usr/bin/guake &
    fi
fi


# ------------------------------------
# -- AWS
# ------------------------------------
# complete -C '/usr/bin/aws_completer' aws;


# ------------------------------------
# -- Golang
# ------------------------------------
# TODO: GOPATH


# ------------------------------------
# -- Node
# ------------------------------------
# TODO