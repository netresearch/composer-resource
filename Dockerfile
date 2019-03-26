FROM php:7.3-alpine

WORKDIR /resource

COPY app /resource/
COPY setup/ /
RUN chmod +x /usr/local/bin -R

ENTRYPOINT ["entrypoint"]

CMD ["php", "index.php"]
