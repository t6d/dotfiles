if type -q fnm
    fnm env --use-on-cd --version-file-strategy=recursive --log-level=error | source
end
