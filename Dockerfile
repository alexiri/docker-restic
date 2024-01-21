FROM restic/restic:0.16.3

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

RUN apk add --no-cache openssh-client curl sshpass \
  && rm -rf /root/.cache

ADD tunnelOpen.sh /etc/cont-init.d/
ADD tunnelClose.sh /etc/cont-finish.d/

VOLUME "/restic"
WORKDIR "/restic"

ENTRYPOINT ["/init"]
CMD ["/restic/restic.sh"]
