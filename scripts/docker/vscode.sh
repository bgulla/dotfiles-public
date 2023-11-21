# NOTE: this is just for hack jobs and should not be considered safe nor recommended.

docker run --rm \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e PASSWORD=password `#optional` \
  -e HASHED_PASSWORD= `#optional` \
  -e SUDO_PASSWORD=password `#optional` \
  -e SUDO_PASSWORD_HASH= `#optional` \
  -p 8443:8443 \
  -v ${PWD}:/data \
  --restart unless-stopped \
  lscr.io/linuxserver/code-server:latest
