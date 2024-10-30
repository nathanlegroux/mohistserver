sed -i -e "/^rcon.port=/s/^rcon.port=.*/rcon.port=99$(echo \"{{SERVER_PORT}}\" | sed 's/^..//')/" \
-e "/^rcon.password=/s/^rcon.password=.*/rcon.password={{P_SERVER_UUID}}/" "server.properties" && \
nohup java -Xms128M -Xmx{{SERVER_MEMORY}}M -Dterminal.jline=false -Dterminal.ansi=true $( [[ ! -f unix_args.txt ]] && printf %s \"-jar {{SERVER_JARFILE}}\" || printf %s \"@unix_args.txt\" ) > java.log 2>&1 & \
nohup ./bore local {{SERVER_PORT}} --port {{SERVER_PORT}} --to play.timeslotter.fr > bore.log 2>&1 &
