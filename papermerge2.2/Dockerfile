FROM tivoli:0.1.0 as token_validator
FROM auth_server:0.1.0 as auth_server
FROM papermerge:2.2.0 as papermerge_app
FROM python:3.10

RUN apt-get update && apt-get install -y --no-install-recommends \
	nginx \
	supervisor

RUN pip install --upgrade poetry

COPY run.bash /run.bash
COPY supervisord.conf /etc/
COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /run.bash

COPY --from=token_validator /tivoli_app/ /tivoli_app
COPY --from=auth_server /auth_server_app/ /auth_server_app
COPY --from=papermerge_app /papermerge_app/ /papermerge_app

EXPOSE 80

ENTRYPOINT ["/run.bash"]
CMD ["server"]
