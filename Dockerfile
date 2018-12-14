FROM nominatim-docker:latest
COPY map.osm /app
RUN service postgresql start && \
    sudo -u nominatim ./src/build/utils/update.php --import-file /app/map.osm && \
    sudo -u nominatim ./src/build/utils/update.php --index && \
    sudo -u postgres psql nominatim -c "CREATE INDEX idx_placex_geometry_jm ON placex((extratags -> 'website' = 'jetmoney'))" && \
    sudo -u postgres psql nominatim -c "CREATE INDEX idx_placex_osmid_jm ON placex(osm_id)" && \
    service postgresql stop
RUN chmod +x /app/start.sh
CMD /app/start.sh


