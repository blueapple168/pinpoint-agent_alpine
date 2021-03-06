FROM blueapple/alpine_glibc_basicimage

MAINTAINER blueapple <blueapple1120@qq.com>

ARG PINPOINT_VERSION=${PINPOINT_VERSION:-1.7.3}
ARG INSTALL_URL=https://github.com/naver/pinpoint/releases/download/${PINPOINT_VERSION}/pinpoint-agent-${PINPOINT_VERSION}.tar.gz
   
COPY configure-agent.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/configure-agent.sh \
    && mkdir -p /pinpoint-agent \
    && chmod -R o+x /pinpoint-agent \
    && curl -SL ${INSTALL_URL} -o pinpoint-agent.tar.gz \
    && gunzip pinpoint-agent.tar.gz \
    && tar -xf pinpoint-agent.tar -C /pinpoint-agent \
    && rm pinpoint-agent.tar

VOLUME ["/pinpoint-agent"]

ENTRYPOINT ["/usr/local/bin/configure-agent.sh"]
CMD ["tail", "-f", "/dev/null"]
