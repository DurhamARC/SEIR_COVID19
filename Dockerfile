FROM rocker/shiny:3.6.3

RUN apt-get update && apt-get install libssl-dev -y
RUN mkdir -p /var/lib/shiny-server/bookmarks/shiny

# Download and install library
RUN R -e "install.packages(c('shinydashboard', 'shinyjs', 'V8', 'plotly', 'shinyWidgets', 'deSolve', 'reshape', 'googlesheets4'))"

# copy the app to the image
COPY COVID19seir /srv/shiny-server/

# make all app files readable (solves issue when dev in Windows, but building in Ubuntu)
RUN chmod -R 755 /srv/shiny-server/

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]
