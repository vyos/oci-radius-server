ARG ALPINE_VERSION=3.24

FROM alpine:${ALPINE_VERSION}

LABEL org.opencontainers.image.title="freeradius"
LABEL org.opencontainers.image.description="RADIUS server (FreeRADIUS) used by VyOS smoketests"

RUN apk add --no-cache freeradius && \
    # Log every authentication attempt to stdout; auth_badpass/auth_goodpass
    # stay off so passwords never end up in the log
    sed -i -E 's/^(\s*auth\s*=\s*)no/\1yes/' /etc/raddb/radiusd.conf && \
    chmod -R o-w /etc/raddb/

# Mount your own /etc/raddb/clients.conf and /etc/raddb/users
EXPOSE 1812/udp 1813/udp

ENTRYPOINT ["radiusd", "-f", "-l", "stdout"]
