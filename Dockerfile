# syntax=docker/dockerfile:1

######## Build stage ########
FROM php:8.4-cli AS build
WORKDIR /app

# Tools + PHP ext so composer install can work
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git unzip zip ca-certificates libzip-dev \
 && update-ca-certificates \
 && docker-php-ext-install zip \
 && rm -rf /var/lib/apt/lists/*


RUN curl -sSLf \
    -o /usr/local/bin/install-php-extensions \
    https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions
RUN install-php-extensions @composer


ENV COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_MEMORY_LIMIT=-1

# Copy composer files first (cache-friendly)
COPY composer.json composer.lock* ./
RUN alias composer='/usr/local/bin/composer'
ENV COMPOSER_ALLOW_SUPERUSER=1

# App code
COPY . .
RUN composer dump-autoload --optimize

######## Runtime stage ########
FROM php:8.4-cli AS runtime
WORKDIR /app

COPY --from=build /app /app

RUN curl -sSLf \
    -o /usr/local/bin/install-php-extensions \
    https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions
RUN install-php-extensions @composer


# Minimal tools composer might still need in dev
RUN apt-get update \
 && apt-get install -y --no-install-recommends git unzip ca-certificates \
 && update-ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN alias composer='/usr/local/bin/composer'


ENV COMPOSER_ALLOW_SUPERUSER=1

# Be verbose so we see real errors if anything fails

# Non-root
RUN useradd -ms /bin/bash app && chown -R app:app /app
USER app

CMD ["php", "public/index.php"]
