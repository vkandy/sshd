FROM alpine

RUN apk add -qU openssh \
    && ssh-keygen -A \
    && mkdir -p /root/.ssh \
    && touch /root/.ssh/authorized_keys

COPY bin/* /bin/
RUN chmod +x /bin/start-sshd

EXPOSE 22

ENTRYPOINT ["/bin/start-sshd"]

