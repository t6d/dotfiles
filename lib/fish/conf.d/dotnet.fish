if test -d /usr/local/share/dotnet
    set -xg DOTNET_ROOT /usr/local/share/dotnet
end

if test -d ~/.dotnet/tools
    set -xg PATH ~/.dotnet/tools $PATH
end
