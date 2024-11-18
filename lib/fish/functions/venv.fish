function venv
    set -l command $argv[1]
    set -l name $argv[2]

    switch $command
        case create
            python3 -m venv "$name"
            echo "Virtual environment created."
        case activate
            if test -f bin/activate.fish
                source bin/activate.fish
                echo "Virtual environment activated."
            else
                echo "Virtual environment not found."
            end
        case deactivate
            if type -q deactivate
                deactivate
                echo "Virtual environment deactivated."
            else
                echo "No virtual environment to deactivate."
            end
        case '*'
            echo "Usage: venv [create <name>|activate|deactivate]"
    end
end
