# Heroku PHP Extensions

Pre-built PHP extensions for Heroku that are not included or fully supported by the official [PHP buildpack](https://github.com/heroku/heroku-buildpack-php).

- [Relay](https://relaycache.com)
- [PhpRedis](https://pecl.php.net/package/redis) (with _igbinary_, _lzf_, _lz4_ and _zstd_ support)
- [Swoole](https://pecl.php.net/package/swoole)
- [OpenSwoole](https://pecl.php.net/package/openswoole)
- [MessagePack](https://pecl.php.net/package/msgpack)
- [igbinary](https://pecl.php.net/package/igbinary)

The supported PHP versions are `8.1` to `8.3` on the `heroku-20` and `heroku-24` stacks.

Checkout the [demo app](https://php-extensions.herokuapp.com), or [browse the S3 bucket](https://s3.us-east-1.amazonaws.com/heroku-php-extensions/index.html).

## Usage

Add the corresponding repository to your Heroku app:

```bash
# heroku-20
heroku config:set HEROKU_PHP_PLATFORM_REPOSITORIES="https://trainerplanapp-extensions.s3.amazonaws.com/dist-heroku-20-amd64-stable/"

# heroku-22
heroku config:set HEROKU_PHP_PLATFORM_REPOSITORIES="https://trainerplanapp-extensions.s3.amazonaws.com/dist-heroku-22-amd64-stable/"

# heroku-24
heroku config:set HEROKU_PHP_PLATFORM_REPOSITORIES="https://trainerplanapp-extensions.s3.amazonaws.com/dist-heroku-24-amd64-stable/"
```

Next, add any of the extensions to `composer.json` as you usually would:

```bash
composer require "ext-extname:*"
```

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Contributing

Pull requests for additional Heroku stacks, PHP versions, additional extension versions and new extension are welcome.

## Development

Before continuing, read and understand the [official build instructions](https://github.com/heroku/heroku-buildpack-php/blob/main/support/build/README.md).

### Set up

```bash
# Install Composer dependencies
composer install

# Copy Python requirements
cp vendor/heroku/heroku-buildpack-php/requirements.txt .

# Create environment file
cp .env.example .env
```

Be sure to set all variables in your newly created `.env` file.

### Dockerfile

Create a custom Dockerfile for `heroku-24`.

```
cat vendor/heroku/heroku-buildpack-php/support/build/_docker/heroku-24.Dockerfile > docker/build/heroku-24.Dockerfile
cat docker/heroku-24.Dockerfile >> docker/build/heroku-24.Dockerfile
```

### Build

```bash
# Docker build
docker build --pull --tag heroku-24 --file docker/build/heroku-24.Dockerfile .

# Build libraries
docker run --rm -ti --env-file=.env heroku-24 bob build --overwrite libraries/libname

# Build igbinary
docker run --rm -ti --env-file=.env heroku-24 bob build extensions/no-debug-non-zts-20230831/profiler-1.0.4
```
