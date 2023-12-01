# Raspberry-Restream-H264-to-mjpeg
Restream Using Raspberry a H264 stream to  to mjpeg

Usefull Where viewers support only mjpeg streams
Like Fibaro Home Center

# Installing
sudo bash install.sh

# Using
Add stream link to file
```
sudo nano /etc/restream/restream.list
```
```
sudo systemctl restart restream
```
Stream available at http://localhost:8090/camera.mjpeg  
Stream available at http://IP_address_of_PI:8090/camera.mjpeg  

# License
This project is licensed under the MIT License - see the LICENSE.md file for details
