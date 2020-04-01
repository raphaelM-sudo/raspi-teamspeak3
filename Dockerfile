ARG EXAPI_IMAGE
FROM ${EXAPI_IMAGE}

RUN apt-get update -qq \
  && apt-get install -yq \
  gosu \
  netcat \
  && groupadd -g 9987 ts3server \
  && useradd -s /sbin/nologin -u 9987 -g ts3server -d /opt/exagear/images/default/var/ts3server ts3server \
  && mkdir -m 775 /opt/exagear/images/default/var/ts3server \
  /opt/exagear/images/default/var/run/ts3server \
  /opt/exagear/images/default/opt/ts3server \
  && chown ts3server:ts3server /opt/exagear/images/default/var/ts3server \
  /opt/exagear/images/default/var/run/ts3server \
  /opt/exagear/images/default/opt/ts3server

ARG TEAMSPEAK_VERSION
ARG TEAMSPEAK_URL=https://files.teamspeak-services.com/releases/server/${TEAMSPEAK_VERSION}/teamspeak3-server_linux_x86-${TEAMSPEAK_VERSION}.tar.bz2

RUN wget "${TEAMSPEAK_URL}" -O server.tar.bz2 \
  && mkdir -p /opt/exagear/images/default/opt/ts3server \
  && tar -xf server.tar.bz2 --strip-components=1 -C /opt/exagear/images/default/opt/ts3server \
  && rm server.tar.bz2 \
  && mv /opt/exagear/images/default/opt/ts3server/*.so /opt/exagear/images/default/opt/ts3server/redist/* /opt/exagear/images/default/usr/local/lib \
  && ln -s /opt/exagear/images/default/var/ts3server /var/ts3server \
  && ln -s /opt/exagear/images/default/run/ts3server /run/ts3server \
  && ln -s /opt/exagear/images/default/opt/ts3server /opt/ts3server \
  && exagear -- /sbin/ldconfig /usr/local/lib

# setup directory where user data is stored
VOLUME /var/ts3server/
WORKDIR /var/ts3server/

#  9987 default voice
# 10011 server query
# 30033 file transport
EXPOSE 9987/udp 10011 30033 

COPY start.sh /opt/exagear/images/default/opt/ts3server/
COPY entrypoint.sh /
RUN chmod +x /opt/exagear/images/default/opt/ts3server/start.sh
ENTRYPOINT ["/entrypoint.sh"]

