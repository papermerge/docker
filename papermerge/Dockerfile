FROM papermerge/papermerge.js:2.1.3 as frontend
FROM papermerge/papermerge:2.1.7 as build

RUN apt-get install -y --no-install-recommends nginx supervisor

COPY papermerge/uwsgi.ini /etc/uwsgi/papermerge.ini
COPY papermerge/run.bash /run.bash

COPY papermerge/nginx.conf /etc/nginx/
COPY papermerge/supervisord.conf /etc/
COPY papermerge/papermerge.toml ./papermerge.toml
COPY papermerge/logging.yaml ./logging.yaml

RUN chmod +x /run.bash

COPY --from=frontend /usr/share/nginx/html /usr/share/nginx/html

RUN useradd --no-create-home nginx
RUN rm /etc/nginx/sites-enabled/default

EXPOSE 8000

ENTRYPOINT ["/run.bash"]
CMD ["server"]
