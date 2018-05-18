FROM r-base:latest

# Install dependencies and Download and install shiny server.
RUN apt-get update && \
    apt-get install -y -t \
        unstable \
        sudo \
        gdebi-core \
        git \
        ca-certificates \
        gettext-base \
        curl \
        unzip \
        supervisor \
        nginx \
        mini-httpd \
        pandoc \
        pandoc-citeproc \
        libcurl4-gnutls-dev \
        libcairo2-dev/unstable \
        libssl-dev \
        libsasl2-dev \
        libxt-dev \
        python-pip && \
    wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    rm -rf /var/lib/apt/lists/*

# Remove default nginx configurations
RUN rm -f /etc/nginx/nginx.conf && \
    rm -f /etc/nginx/conf.d/*.conf && \
    rm -f /etc/nginx/sites-enabled/*

# By default, allow unlimited file sizes, modify it to limit the file sizes
# To have a maximum of 1 MB (Nginx's default) change the line to:
# ENV NGINX_MAX_UPLOAD 1m
ENV NGINX_MAX_UPLOAD 0

# Forward request and error logs to docker log collector.
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Create run pid path
RUN mkdir -p /run/nginx/

# Install dependencies.
COPY packages.sh /code/
RUN chmod +x /code/packages.sh
RUN /code/packages.sh \
    shiny \
    rmarkdown

# Copy custom modified NGINX conf into place.
COPY nginx.conf /etc/nginx/nginx.conf

# Copy custom shiny server conf into place.
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# Copy custom Supervisord config into place.
COPY supervisord.conf /etc/supervisord.conf

# Copy the entrypoint that will generate additional Nginx configs and 
# pull environment variables from S3.
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Copy application files into place.
COPY css /srv/shiny-server/css/
COPY img /srv/shiny-server/img/
COPY index.html /srv/shiny-server/index.html
COPY hello_world /srv/shiny-server/hello_world/

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
