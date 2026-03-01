FROM debian:trixie
ARG RELEASE_TYPE=STABLE

RUN apt-get update && \
    apt-get install -y wget gpg apt-transport-https lsb-release curl gcc
    
RUN curl -fsSL https://releases.hyperion-project.org/hyperion.pub.key | gpg --dearmor -o /usr/share/keyrings/hyperion.pub.gpg

RUN if [ "${RELEASE_TYPE}" = "nightly" ]; then \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://nightly.apt.releases.hyperion-project.org/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hyperion.list ; \
    else \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hyperion.pub.gpg] https://apt.releases.hyperion-project.org/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hyperion.list ; \
    fi

RUN apt-get update && \
    apt-get install -y hyperion

EXPOSE 8090 8092 19333 19400 19444 19445 

ENV UID=1000
ENV GID=1000

RUN apt-get clean -q -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

CMD [ "/usr/bin/hyperiond" ]

