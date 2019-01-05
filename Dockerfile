FROM akiro/r-base

# https://www.rstudio.com/products/rstudio/download-commercial/
WORKDIR /root
RUN apt-get update
RUN apt-get install -y gdebi-core
RUN apt-get install -y wget

# ENV PRO "-"
# # ENV PRO -pro-

# RUN wget https://download2.rstudio.org/rstudio-server${PRO}1.1.456-amd64.deb
# RUN gdebi -n rstudio-server${PRO}1.1.456-amd64.deb
# https://www.rstudio.com/products/rstudio/download-commercial/
RUN wget https://download2.rstudio.org/rstudio-server-pro-1.1.463-amd64.deb
RUN gdebi -n rstudio-server-pro-1.1.463-amd64.deb

# ENV rss_preview_file rstudio-server-1.2.830-amd64.deb
# ENV rss_preview_link https://s3.amazonaws.com/rstudio-ide-build/server/trusty/amd64/${rss_preview_file}

# RUN wget ${rss_preview_link}
# RUN gdebi -n ${rss_preview_file}

# RStudio config:
#RUN echo "server-app-armor-enabled=0\nwww-address=127.0.0.1" >> /etc/rstudio/rserver.conf

# RStudio port:
EXPOSE 8787/tcp


# MYPWD="$(openssl passwd -1 'my-pwd')" 
RUN userdel docker && \
  MYPWD='$1$xOuE09ww$jfl3dhLPGP6K2NerW9nO/0' ; \
  useradd -u 1000 --create-home -p $MYPWD --shell /bin/bash akiro

## ForR packages + git
RUN apt-get update
RUN apt-get install -y libxml2-dev \
  libcurl4-openssl-dev \
  libssl-dev \
  git
  
## R packages
RUN R -e "install.packages('packrat')"
RUN R -e "install.packages('roxygen2')"
RUN R -e "install.packages('devtools')"

WORKDIR /

# data directory
RUN mkdir /home/akiro/hostfolder && \
    chown akiro.akiro  /home/akiro/hostfolder; \
    ln -s /home/akiro/hostfolder/data /data

CMD /usr/lib/rstudio-server/bin/rserver& \
  bash
# ENTRYPOINT /usr/lib/rstudio-server/bin/rserver ; \
#   /usr/bin/tail -f -

