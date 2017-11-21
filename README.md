# ace_proxy_in_docker
This is a docker based proxy for run acestream, specially for look torrent based streams.

# 1. cd in project path
# 2. Building docker: 
docker build -t ace .
# 3. run this docker
docker run --network bridge --dns 8.8.8.8  -i -t ace http://asplaylist.net/....
