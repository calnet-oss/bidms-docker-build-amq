## Purpose

This [Docker](http://www.docker.com/) image builds the ActiveMQ WAR file for
the Berkeley Identity Management Suite.

The author does not currently publish the image in any public Docker
repository but a script, described below, is provided to easily create your
own image.

## License

The source code, which in this project is primarily shell scripts and the
Dockerfile, is licensed under the [BSD two-clause license](LICENSE.txt).

## Building the Docker image

Copy `config.env.template` to `config.env` and edit to set config values.

This image depends on:
* The base BIDMS Debian Docker image from the
[bidms-docker-debian-base](http://www.github.com/calnet-oss/bidms-docker-debian-base)
project.
* The base BIDMS build Docker image from the
[bidms-docker-build-base](http://www.github.com/calnet-oss/bidms-docker-build-base)
project.

If you don't have these images built yet, you'll need to build these
dependencies first.

Build the container image:
```
./buildImage.sh
```

## Running

To run the container interactively (which means you get a shell prompt):
```
./runContainer.sh
```

Or to run the container detached, in the background:
```
./detachedRunContainer.sh
```

If running interactively, you can exit the container by exiting the bash
shell.  If running in detached mode, you can stop the container with:
`docker stop bidms-build-amq` or there is a `stopContainer.sh` script
included to do this.

To inspect the running container from the host:
```
docker inspect bidms-build-amq
```

To list the running containers on the host:
```
docker ps
```