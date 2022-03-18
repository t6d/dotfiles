function dmg -a subcommand -a source_path -a target_path
    switch $subcommand
        case create
            _dmg_create "$source_path" "$target_path"
        case compress
            _dmg_compress "$source_path"
        case '*'
            echo "Usage: dmg create|compress source [target]"
            return 1
    end

    return $status
end

function _dmg_create -a source_path -a target_path
    set -l image_name (basename "$target_path" .dmg)

    if test -d $source_path
        hdiutil create "$target_path" -ov -volname "$image_name" -fs HFS+ -srcfolder "$source_path"
    else
        return 2
    end
end

function _dmg_compress -a source_path
    set temporary_path (mktemp).dmg
    hdiutil compact "$source_path"
    hdiutil convert -format ULMO "$source_path" -o "$temporary_path"
    mv "$temporary_path" "$source_path"
end

set -l subcommands "create compress"
complete -f -c dmg -n "not __fish_seen_subcommand_from $subcommands" -a "$subcommands"
complete -F -c dmg -n "__fish_seen_subcommand_from $subcommands"
