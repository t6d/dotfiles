if test -d /opt/homebrew
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
    set -q PATH; or set PATH ''
    set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
    set -q MANPATH; or set MANPATH ''
    set -gx MANPATH /opt/homebrew/share/man $MANPATH
    set -q INFOPATH; or set INFOPATH ''
    set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
end

if test -d /usr/local/bin
    set -xg PATH /usr/local/bin $PATH
end

if test -d ~/bin
    set -xg PATH ~/bin $PATH
end

if test -d /Applications/Postgres.app/Contents/Versions/latest/bin
    set -xg PATH /Applications/Postgres.app/Contents/Versions/latest/bin $PATH
end
