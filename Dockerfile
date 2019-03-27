FROM php:7.3-alpine as dependencies

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apk --no-cache upgrade \
 && apk add --no-cache \
    $PHPIZE_DEPS ca-certificates yaml-dev jq bash openssl git zip unzip php7-zip openssh-client\
 && docker-php-source extract \
 && pecl install yaml \
 && docker-php-ext-enable yaml \
 && docker-php-source delete \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir="/usr/bin/" --filename="composer" \
 && composer global require hirak/prestissimo


FROM dependencies as build
WORKDIR /resource
COPY app /resource/
RUN composer install --no-ansi --no-dev --no-interaction --no-progress --no-scripts -o


FROM dependencies
WORKDIR /resource

COPY --from=build /resource/ .
COPY setup/ /
COPY tests/fixtures/ /tests/
RUN chmod +x /usr/local/bin -R


ENTRYPOINT ["entrypoint"]
CMD ["php", "index.php"]
