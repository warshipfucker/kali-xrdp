### Pull image
```
docker pull ghcr.io/warshipfucker/kali-xrdp:main
```
### Run Container
##### via powershell
```
docker run -it --name kali-xrdp \
 -v C:\dev-env\volumes\kali/run:/run
 -v C:\dev-env\volumes\kali/tmp:/tmp \
 -v C:\dev-env\volumes\kali/home:/home \
 -v C:\dev-env\volumes\kali/mnt:/mnt \
 -v C:\dev-env\volumes\kali/opt:/opt \
 -p 3390:3389 \
 -p 22:22 \
 -p 8081:8080 \ 
 -p 80:80 \ 
 -p 1234:1234 \ 
 ghcr.io/warshipfucker/kali-xrdp:main  /bin/bash
```
##### via cmd
```
docker run -it --name xrdp-kali-continer -v C:\dev-env\volumes\kali/run:/run -v C:\dev-env\volumes\kali/tmp:/tmp -v C:\dev-env\volumes\kali/home:/home -v C:\dev-env\volumes\kali/mnt:/mnt    -v C:\dev-env\volumes\kali/opt:/opt  -p 3390:3389  -p 22:22 -p 8081:8080 -p 80:80 -p 1234:1234 kali-xrdp-vf:latest  /bin/bash
```

##### Connect from Windows host
Press Win+R button, in Run window type **"mstsc"**
Connect to **localhost:3390** using creditionals **kali:kali**
