ARG frontend_tag=latest
ARG backend_tag=latest-headless
FROM papermerge/papermerge.js:${frontend_tag} as frontend
ARG frontend_tag=latest
ARG backend_tag=latest-headless
FROM papermerge/papermerge:${backend_tag} as build

RUN apt-get install -y --no-install-recommends nginx supervisor

COPY common/uwsgi.ini /etc/uwsgi/papermerge.ini
COPY common/run.bash /run.bash

COPY common/nginx.conf /etc/nginx/
COPY common/papermerge.toml ./papermerge.toml
COPY common/logging.yaml ./logging.yaml

COPY papermerge/supervisord.conf /etc/

RUN chmod +x /run.bash

COPY --from=frontend /usr/share/nginx/html /usr/share/nginx/html

RUN useradd --no-create-home nginx
RUN rm /etc/nginx/sites-enabled/default

EXPOSE 8000

ENTRYPOINT ["/run.bash"]
CMD ["server"]
