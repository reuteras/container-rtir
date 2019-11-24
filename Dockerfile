# This is a Docker image for RTIR.

FROM reuteras/docker-rt
MAINTAINER PR <code@reuteras.se>

ENV RT_FIX_DEPS_CMD /usr/bin/cpanm
ENV PERL_CPANM_OPT -n

USER root
## Install tools and libraries via apt
RUN apt update -yqq && \
    apt install -yqq --no-install-recommends \
        build-essential \
        cpanminus \
        make \
        traceroute && \
    rm -f /usr/local/man && \
    cpanm Error.pm && \
    cpanm Parse::BooleanLogic && \
    cpanm String::ShellQuote && \
    mkdir -p /tmp/rtir && \
    curl -SL https://download.bestpractical.com/pub/rt/release/rtir.tar.gz | \
    tar -xzC /tmp/rtir && \
    cd /tmp/rtir/RT-IR-* && \
    perl Makefile.PL && \
    make install && \
	apt remove -y build-essential cpanminus && \
    apt autoremove -y && \
    apt clean && \
    apt autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.cpan && \
    rm -rf /root/.cpanm && \
    rm -rf /preseed.txt /usr/share/doc && \
    rm -rf /usr/local/share/man /var/cache/debconf/*-old

EXPOSE 443
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
