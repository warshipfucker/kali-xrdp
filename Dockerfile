FROM kalilinux/kali-rolling
# Отключение интерактивных запросов debconf
ENV DEBIAN_FRONTEND=noninteractive
# Установка нужной локали
RUN apt-get update && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && /usr/sbin/update-locale LANG=en_US.UTF-8
  # Установка переменных окружения
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
    
    # Install XRDP and other packages
    
RUN apt update && apt install -y xrdp xfce4 xfce4-goodies dbus-x11 x11-xserver-utils

# Set XRDP to use XFCE
RUN echo "xfce4-session" > ~/.xsession

RUN useradd -m -s /bin/bash kali && echo "kali:kali" | chpasswd

# Add user kali to sudo and xrdp groups
RUN usermod -aG sudo,xrdp kali
RUN echo "xfce4-session" > /home/.xsession && chown kali:kali /home/.xsession

# Expose the RDP port
EXPOSE 3389 22 8080 80 1234
# Define volumes
VOLUME ["/run", "/tmp", "/home", "/mnt", "/opt"]

# Start XRDP service on container startup
ENTRYPOINT ["sh", "-c", "service xrdp restart && /bin/bash"]



# docker run -it --name xrdp-kali-continer -v C:\dev-env\volumes\kali/run:/run -v C:\dev-env\volumes\kali/tmp:/tmp -v C:\dev-env\volumes\kali/home:/home -v C:\dev-env\volumes\kali/mnt:/mnt    -v C:\dev-env\volumes\kali/opt:/opt  -p 3390:3389  -p 22:22 -p 8081:8080 -p 80:80 -p 1234:1234 kali-xrdp-vf:latest  /bin/bash
