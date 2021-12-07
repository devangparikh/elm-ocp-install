FROM registry.access.redhat.com/ubi8/ubi:8.4

RUN echo '* hard nofile 65536'>>/etc/security/limits.conf 
RUN echo '* soft nofile 65536'>>/etc/security/limits.conf 
RUN echo '* hard nproc 10000'>>/etc/security/limits.conf 
RUN echo '* soft nproc 10000'>>/etc/security/limits.conf
COPY --chown=1001:0 copy/JazzTeamServer/ /IBM/JazzTeamServer/
WORKDIR /usr/bin
COPY --chown=1001:0 ./docker/start-server.sh /usr/bin
USER 1001
EXPOSE 9080 9443

CMD ["/bin/bash","start-server.sh"]