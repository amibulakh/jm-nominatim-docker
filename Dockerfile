FROM nominatim-docker:latest
COPY map.osm /app
RUN service postgresql start && \
    sudo -u nominatim ./src/build/utils/update.php --import-file /app/map.osm && \
    sudo -u nominatim ./src/build/utils/update.php --index && \
    service postgresql stop
CMD /app/start.sh


