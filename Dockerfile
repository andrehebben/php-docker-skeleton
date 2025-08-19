# syntax=docker/dockerfile:1
FROM php:8.3-cli AS base
WORKDIR /app
COPY composer.json composer.lock* ./

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --no-interaction --prefer-dist --no-scripts --no-progress

COPY . .

# Run prod scripts after full copy (e.g., optimize autoload)
RUN composer dump-autoload --optimize

# Use a smaller final image
FROM php:8.3-cli AS runtime
WORKDIR /app
COPY --from=base /app /app

# Non-root user recommended
RUN useradd -ms /bin/bash app && chown -R app:app /app
USER app

CMD ["php", "public/index.php"]
