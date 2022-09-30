FROM haproxy:2.3
COPY ./configs/haproxy_docker/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
RUN mkdir /run/haproxy