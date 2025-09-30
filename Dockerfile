FROM rocker/shiny:4.3.1

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libpq-dev \
    && apt-get clean

RUN R -e "install.packages(c('shiny', 'leaflet', 'tidyverse', 'htmlwidgets', 'sf', 'geosphere'))"

# Copy your app and config
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf
COPY . /srv/shiny-server/

WORKDIR /srv/shiny-server/

ENV SHINY_PORT=8080
EXPOSE 8080

CMD ["/usr/bin/shiny-server"]
