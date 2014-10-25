This is a image which runs Firefox 32 enabled for digitally signing.

The installed drivers are as follow:
* Card reader: ACR38
* Smart card: bit4id

There's also installed a Firefox extension which makes its configuration easier.

How to run a container:
  $ docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/bus/usb:/dev/bus/usb --privileged digsig
