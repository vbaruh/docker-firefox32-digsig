What is this?
=============

This is a image which runs Firefox 32 enabled for digitally signing using smart card.

The need of such image arose after updating to Firefox 33.
There's some kind of issue in Firefox 33 and it is not possible to digitally sign with it.

Resources
=========

The image was created using the following resources:

* [A very nice guide how to run GUI app in Docker](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
* Several links to Infonotary wiki site guiding how to install card reader and smart card drivers (some of them are in Bulgarian).
** http://wiki.infonotary.com/wiki/Installation_of_smart_card_reader_and_smart_card_drivers_in_Linux
** http://wiki.infonotary.com/wiki/%D0%98%D0%BD%D1%81%D1%82%D0%B0%D0%BB%D0%B0%D1%86%D0%B8%D1%8F_%D0%BD%D0%B0_%D0%B4%D1%80%D0%B0%D0%B9%D0%B2%D0%B5%D1%80%D0%B8_%D0%B7%D0%B0_%D1%87%D0%B5%D1%82%D0%B5%D1%86_%D0%B8_%D1%81%D0%BC%D0%B0%D1%80%D1%82_%D0%BA%D0%B0%D1%80%D1%82%D0%B0_%D0%B2_Linux
** http://wiki.infonotary.com/wiki/%D0%94%D1%80%D0%B0%D0%B9%D0%B2%D0%B5%D1%80%D0%B8_%D0%B7%D0%B0_%D1%87%D0%B5%D1%82%D1%86%D0%B8

This image is based on [vbaruh/firefox32-base](https://registry.hub.docker.com/u/vbaruh/firefox32-base/) which contains installed Firefox 32 and its dependencies.

The installed drivers are as follow:
* Card reader: ACR38
* Smart card: bit4id

There's also installed a very handful [Firefox extension made by Infonotary](https://addons.mozilla.org/bg/firefox/addon/infonotary-configurator-for-mo/) which magically configures the browser to work with installed card reader and smart card drivers.

[Infonotary](http://www.infonotary.com/site/en/) is one of the officially registered certificate authorities in Bulgaria.

Usage
=====

Running a one-time container
----------------------------

You will need to go to extensions page, enable the Infonotary's extension and restart Firefox.

    $ docker run -ti \
      --rm \
      -e DISPLAY=$DISPLAY \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v /dev/bus/usb:/dev/bus/usb \
      --privileged \
      vbaruh/firefox32-digsig

Running a permenant container
-----------------------------

Using this approach it won't be necessary to enable the extension and restart the browser every single time.

Starting the container for the first time:

    $ docker run -ti \
      --name my-digsig-firefox \
      -e DISPLAY=$DISPLAY \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v /dev/bus/usb:/dev/bus/usb \
      --privileged \
      -v $HOME/.my-digsig-firefox-home:/home/firefox \
      vbaruh/firefox32-digsig

Starting the existing container:

    $ docker start my-digsig-firefox


A bash script
-------------

In [the github repo](https://github.com/vbaruh/docker-firefox32-digsig) there's a script which does the above example. Check it out.

By default this script will create a container with name "my-digsig-firefox" and will create a $HOME/.my-digsig-firefox-home/ directory as a home one for the container.

If you want to change the name of the container change the value of FFDS_NAME environment variable.
If you want to change the home directory set FFDS_HOME environment variable appropriately.

    $ export FFDS_NAME=my-desired-firefox-container-name
    $ export FFDS_HOME=/path/to/desired/home/dir
    $ start-firefox-digsig-permanent
