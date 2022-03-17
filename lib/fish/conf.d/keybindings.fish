if status is-interactive
    bind \co 'open .'
    bind \cv 'code . '
    bind \cg 'gh pr view --web; and commandline -f repaint'
end
