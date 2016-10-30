# RTIR

[RTIR](https://www.bestpractical.com/rtir/), or Request Tracker for Incident Response, is a issue tracking system that provides pre-configured queues and workflows designed for incident response teams. Currently build RTIR lastest (4.4.x).

Currently I'm only running my _reuteras/docker-rt_ container and not RTIR and this container is primarily for my own testing.


## Installation

First install RT and setup a working database for it. I've used my reuteras/docker-rt container but the setup files for RT is in this container also under _/tmp/rt/RT*_.

To setup RTIR do:

    docker run -ti -p 443:443 -e RT_HOSTNAME=<hostname> -e RT_RELAYHOST=<relayhost> -v $(pwd)/files:/data --name rtir -d rtir
    docker exec -ti rtir /bin/bash
    # In the container do
    cd tmp/rtir/RT-IR-4.*
    make initdb
    exit

