# Extract SERVER_PORT and ensure it's properly handled
SERVER_PORT_CLEANED=$(echo "{{SERVER_PORT}}" | sed 's/^..//')

# Update server.properties using sed
sed -i -e "/^rcon.port=/s/^rcon.port=.*/rcon.port=99${SERVER_PORT_CLEANED}/" \
       -e "/^rcon.password=/s/^rcon.password=.*/rcon.password={{P_SERVER_UUID}}/" "server.properties"

# Start the Java process with proper handling of SERVER_MEMORY and SERVER_JARFILE
if [[ ! -f unix_args.txt ]]; then
    nohup java -Xms128M -Xmx{{SERVER_MEMORY}}M -Dterminal.jline=false -Dterminal.ansi=true -jar "{{SERVER_JARFILE}}" > java.log 2>&1 &
else
    nohup java -Xms128M -Xmx{{SERVER_MEMORY}}M -Dterminal.jline=false -Dterminal.ansi=true @unix_args.txt > java.log 2>&1 &
fi

# Start the bore command
nohup ./bore local {{SERVER_PORT}} --port {{SERVER_PORT}} --to play.timeslotter.fr > bore.log 2>&1 &
