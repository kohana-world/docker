# Kohana.World Docker Images ( kohana.world, koseven, modseven)
![License](https://img.shields.io/badge/license-BSD--3--Clause-green.svg)
[![GitHub Actions Demo](https://github.com/kohana-world/docker/actions/workflows/github-actions-demo.yml/badge.svg)](https://github.com/kohana-world/docker/actions/workflows/github-actions-demo.yml)
This repository holds docker images which can be used for Kohana Framework.

There will be 4 branches which all server a different purpose:

| Branch          | Purpose                                                                                     |
| --------------- |---------------------------------------------------------------------------------------------|
| master          | Image for a development/production environment.                                             |
| travis          | Image for Unit-Testing inside Travis CI (CAREFUL: Don't use on production servers.)         |
| devel           | Development Branch for `master`. Only latest `kohana:devel` version will be supproted. |
| travis-devel    | Development Branch for `travis`. Only latest `kohana:devel` version will be supproted.     |

## Using the container images

Using one of the container is quite straight forward.
The docker repository for them is called

[kohanaworld/docker](https://hub.docker.com/r/kohanaworld/docker).

By specifying the desired branch as docker-tag you can acquire the desired image.

_Note: for pulling the `master` branch use `latest` as tag name._

e.g. This will pull the master branch image:
`docker pull kohanaworld/docker:latest`

e.g This will pull the travis branch image:
`docker pull kohanaworld/docker:travis-devel`

After executing the `docker pull` command from above you're done setting up
your docker image, now you can go ahead and use it!

## Example for using `master` image

__Coming Soon. Stay tuned!__

## Example for using `travis-devel` image

For this particular Image you have multiple options.

1. Some IDE's ([PHPStorm](https://intellij-support.jetbrains.com/hc/en-us/community/posts/14391537025170-PHPUnittests-via-docker-by-PHPStorm-Configuration) for example) have full support for docker unittesting, you just need to configure it there and
   you are good to go!

2. Run the tests from the cli. Execute the following cli commands (from within your Kohana installation folder):
   Start container in background and mount installation folder:

   ```shell
   docker stop unittest &&  docker rm unittest
   docker run -dtP --name unittest -v $(pwd):/tmp/kohana/ kohanaworld/docker:travis-devel
   ```

3. Start services, install composer requirements and run PHPUnit
   ```shell
   docker exec unittest /bin/sh -c "service redis-server start; service memcached start"
   cd /tmp/kohana
   update-alternatives --config php
   # switch php version 
   composer install
   php vendor/bin/phpunit"
   ```

_(Hint) You can execute a `/bin/bash` shell inside the container and modify it before Unit-Testing
```shell
docker exec -it unittest /bin/bash
cd /tmp/kohana
```
_(Hint) You can execute a single test
```shell
docker exec -it unittest /bin/bash
cd /tmp/kohana
composer install
php vendor/bin/phpunit   --filter HTMLTest
php vendor/bin/phpunit   --filter HTMLTest --debug 
```
_

For more examples / tutorials how to create and interact with container visit the official [Docker Help](https://docs.docker.com/get-started/)

## Roadmap

| Target                 | Release date |
| ---------------------- |--------------|
| Initial `master` image | 2024.07.01   |
| Initial `travis` image | 2024.06.16   |
| Initial `travis-devel` | 2024.06.09  |

## Contributing

As usual, [fork and send pull requests](https://github.com/kohanaxworld/docker/pulls)

## Getting Help

* Open issues in this project.

## TODO

