#/bin/bash
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as sudo"
	exit 2
fi

sudo apt install screen bc curl -y >/dev/null 2>&1
# method 1
ffmpeg -h >/dev/null 2>&1
if [[ $? -ne 0 ]];then
	echo "Installing ffmpeg"	
	sudo apt install ffmpeg -y
else
	echo "ffmpeg already installed"

fi
# Method 2 of install ffmpeg
ffmpeg -h >/dev/null 2>&1
if [[ $? -ne 0 ]];then
	echo "Installing ffmpeg Method 2"
	grep "deb http://www.deb-multimedia.org jessie main non-free" /etc/apt/sources.list >/dev/null
	if [[ $? -ne 0 ]];then
		echo "deb http://www.deb-multimedia.org jessie main non-free" >>/etc/apt/sources.list
		sudo apt update
		sudo apt install ffmpeg -y
	fi

else
	echo "ffmpeg already installed"
fi
echo "Installing script restream.sh"
sudo mkdir -p /etc/restream/
sudo cp ffserver.conf /etc/restream/ffserver.conf
sudo cp restream.list /etc/restream/restream.list
sudo cp restream.sh /etc/restream/restream.sh

sudo chmod +x /etc/restream/restream.sh
sudo cp restream.service /etc/systemd/system/restream.service
sudo systemctl daemon-reload
sudo systemctl enable restream.service
sudo systemctl start restream
echo "Started restream"
echo "Stream available at http://localhost:8090/camera.mjpeg""