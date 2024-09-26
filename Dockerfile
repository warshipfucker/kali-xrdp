FROM kalilinux/kali-rolling
# Отключение интерактивных запросов debconf
ENV DEBIAN_FRONTEND=noninteractive
# Установка нужной локали
RUN apt-get update && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && /usr/sbin/update-locale LANG=en_US.UTF-8 \
    && install -d -m 0755 /etc/apt/keyrings \
    && wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null \
    && gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}' \
    && echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null \
    && apt install firefox




RUN apt-get -y update 
RUN apt-get -y upgrade

RUN apt-get install -y \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin 

RUN apt-get install -y \
    dbus-x11 

RUN apt-get install -y \
    sudo \
    wget \
    xorgxrdp \
    xrdp && \
    apt remove -y light-locker xscreensaver && \
    apt autoremove -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists

COPY ./build/kali-run.sh /usr/bin/
RUN mv /usr/bin/kali-run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh


# Docker config
EXPOSE 3389
ENTRYPOINT ["/usr/bin/run.sh"]
CMD ["1", "2", "3"]
