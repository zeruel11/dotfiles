set -l init_commands "start stop status"
complete -f -c enterInit -n "not __fish_seen_subcommand_from $init_commands" -a start -d 'start server service'
complete -f -c enterInit -n "not __fish_seen_subcommand_from $init_commands" -a stop -d 'stop server service'
complete -f -c enterInit -n "not __fish_seen_subcommand_from $init_commands" -a status -d 'show server status'

set -l init_services "deluge jackett sonarr radarr lidarr"
complete -f -c enterInit -n "__fish_seen_subcommand_from $init_commands" -a deluge -d 'deluge torrent daemon and deluge web UI'
complete -f -c enterInit -n "__fish_seen_subcommand_from $init_commands" -a jackett -d 'jackett -- content indexer'
complete -f -c enterInit -n "__fish_seen_subcommand_from $init_commands" -a sonarr -d 'sonarr -- TV show manager and downloader'
complete -f -c enterInit -n "__fish_seen_subcommand_from $init_commands" -a radarr -d 'radarr -- movie manager and downloader'
complete -f -c enterInit -n "__fish_seen_subcommand_from $init_commands" -a lidarr -d 'lidarr -- music manager and downloader'