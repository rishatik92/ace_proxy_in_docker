#!/bin/bash

TTV_URL="$1"
HOST_IP="$(hostname -I | sed 's/ *$//')"

if [[ -n "$TTV_URL" ]]; then
    echo "" >> /home/tv/aceproxy-master/plugins/config/torrenttv.py
    echo "url = \"$TTV_URL\"" >> /home/tv/aceproxy-master/plugins/config/torrenttv.py
    echo "Paste this URL into your player"
    echo "http://$HOST_IP:8000/torrenttv/torrenttv.m3u"
fi

sed -i 's/acespawn = False/acespawn = True/' /home/tv/aceproxy-master/aceconfig.py
sed -i 's/videopausedelay = .*/videopausedelay = 0/' /home/tv/aceproxy-master/aceconfig.py
sed -i 's/videodelay = .*/videodelay = 0/' /home/tv/aceproxy-master/aceconfig.py
sed -i 's/videodestroydelay = .*/videodestroydelay = 30/' /home/tv/aceproxy-master/aceconfig.py
sed -i 's^acestreamengine --client-console^/home/tv/acestream/acestreamengine --client-console --live-cache-type memory --live-mem-cache-size 209715200 --upload-limit 0 --live-buffer 60^' /home/tv/aceproxy-master/aceconfig.py
#python /home/tv/aceproxy-master/acehttp.py
exec /usr/bin/supervisord
