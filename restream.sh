#/bin/bash

### Variables ###
####################################################################################

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# File With url to restream
URL_FILE="/etc/restream/restream.list"

# ffserver conf file
FFSERVER_CONF="/etc/restream/ffserver.conf"

######################################################################################
if [[ ! -f $URL_FILE ]];then
	echo "No File found $URL_FILE">>/dev/stderr
	echo "Exiting">>/dev/stderr
	exit 2
fi

if [[ ! -f $FFSERVER_CONF ]];then
	echo "No File found $FFSERVER_CONF">>/dev/stderr
	echo "Exiting">>/dev/stderr
	exit 2
fi
pkill -9 ffserver
URL="$(cat $URL_FILE|grep http)"
echo "Starting ffserver"
ffserver -f "$FFSERVER_CONF" &
ps aux|grep -q "ffserver -f $FFSERVER_CONF"
if [[ $? -eq 0 ]];then
		echo "Starting ffmpeg"
		echo "Stream available at http://localhost:8090/camera.mjpeg"
		ffmpeg -nostdin -i "$URL" -r 15 http://localhost:8090/camera.ffm >/dev/null 2>&1

else
	echo "Failed to start ffserver">>/dev/stderr
	exit 2
fi
echo "FFmpeg exited" >>/dev/stderr
exit 0