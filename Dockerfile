FROM ff32base

run wget http://repository.infonotary.com/install/linux/INotaryCodeSigning.key.asc
run apt-key add INotaryCodeSigning.key.asc
run wget -P /etc/apt/sources.list.d http://repository.infonotary.com/install/linux/infonotary.list

run apt-get update
run apt-get install pcscd -y
run apt-get install libacr38u -y
run apt-get install bit4id-ipki -y
run apt-get install unzip -y

run wget -O infonotary.xpi https://addons.mozilla.org/firefox/downloads/file/258086/infonotary_configurator_for_mozilla-1.4.4-fx+tb+sm+fn-linux.xpi?src=dp-btn-primary
run mkdir -p /opt/firefox/browser/extensions/infonotary-mozilla-setup@infonotary.com
run cd /opt/firefox/browser/extensions/infonotary-mozilla-setup@infonotary.com && unzip /infonotary.xpi

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
CMD sudo /etc/init.d/pcscd start && /usr/bin/firefox
