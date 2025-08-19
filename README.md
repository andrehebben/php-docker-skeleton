# PHP Docker Skeleton

This repository provides a minimal PHP 8.3 project skeleton wired for local development and CI/CD using Docker.
It includes configuration for Composer, PHPUnit, PHP_CodeSniffer, PHPStan, and PHP-CS-Fixer so you can start
building a new application with good defaults.

## What's included

- **Dockerfile** for building a production image and running the app as a non-root user.
- **docker-compose.yml** to run the application locally with the built image.
- **Composer** configuration with PHP 8.2+ requirement and common dev tools.
- **PHPUnit** example test and configuration.
- **PHPStan** and **PHP_CodeSniffer** setup for static analysis and linting.
- **GitHub Actions** workflow that tests, builds, and pushes a container image to GitHub Container Registry.

## Getting started

1. **Clone or create a new repository** from this skeleton.
2. **Install dependencies** (requires internet access):
   ```bash
   composer install
   ```
3. **Start the development server** using Docker Compose:
   ```bash
   docker-compose up --build
   ```
   The example setup serves the `public/` directory on [http://localhost:8080](http://localhost:8080).
4. **Run quality tools**:
   ```bash
   composer lint   # PHP_CodeSniffer
   composer stan   # PHPStan
   composer test   # PHPUnit
   composer fix    # PHP-CS-Fixer
   ```

## Configuration

Configuration values can be supplied via environment variables or a `.env` file.
For local development, copy [`conf/.env.example`](conf/.env.example) to `conf/.env`
and adjust values as needed. The `docker-compose.yml` mounts the `conf/`
directory into the container at `/conf`, and the application will load variables
from `/conf/.env` if present. Environment variables already defined will take
precedence over values from the file.

Load the configuration at the beginning of your application:

```php
use App\Config;

Config::load();
$appName = Config::get('APP_NAME', 'My App');
```

## Configuration for your project

- **Composer package name**: update the `name` field in [`composer.json`](./composer.json) from `andrehebben/your-app` to your own package identifier.
- **Docker image**: adjust the image name in [`docker-compose.yml`](./docker-compose.yml) (`ghcr.io/andrehebben/your-app:dev`) to match your repository.
- **Namespace**: modify the `App\\` namespace in `composer.json` and the existing `src/` and `tests/` files to suit your project.
- **GitHub Actions**: review [`.github/workflows/ci-build-push.yml`](.github/workflows/ci-build-push.yml) and ensure the image name and triggers fit your workflow.
- **Public directory**: create a `public/` directory with an `index.php` entry point for the built-in web server.

## License

This project is provided as a starting point. Use it as you wish for your own applications.
