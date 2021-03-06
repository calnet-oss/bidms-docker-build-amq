## Purpose

This [Docker](http://www.docker.com/) image builds the ActiveMQ WAR file for
the Berkeley Identity Management Suite.

The author does not currently publish the image in any public Docker
repository but a script, described below, is provided to easily create your
own image.

## License

The source code, which in this project is primarily shell scripts and the
Dockerfile, is licensed under the [BSD two-clause license](LICENSE.txt).

## Installing the Docker network bridge

This container requires the `bidms_nw` [user-defined Docker network
bridge](https://docs.docker.com/engine/userguide/networking/#bridge-networks)
before running.  If you have not yet created this network bridge on your
host (only needs to be done once), do so by running:
```
./createNetworkBridge.sh
```

If you don't remember if you have created this bridge yet, you can check by
issuing the following command (you should see `bidms_nw` listed as one of
the named networks):
```
docker network ls
```

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

Copy the `tomcat_pubkey.pem` file you generated when you set up the
[bidms-docker-tomcat-dev](http://www.github.com/calnet-oss/bidms-docker-tomcat-dev)
image.

```
cp ../bidms-docker-tomcat-dev/imageFiles/tmp_tomcat/tomcat_pubkey.pem imageFiles
```

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

## Building and Deploying the ActiveMQ WAR

Building requires the
[bidms-docker-tomcat-dev](http://www.github.com/calnet-oss/bidms-docker-tomcat-dev)
container already running.  If you haven't started that container, you must
start it first.  The reason is because the built artifacts must be deployed
to the BIDMS Archiva maven repository.

Follow the instructions to start this container.

Then run this script:
```
./doBuild.sh
```

You can check the exit status of this script to discover if the build
succeeded or not:
```
./doBuild.sh
if [ $? != 0 ]; then
  echo "Build failed"
else
  echo "Build succeeded"
fi
```

This deploys the ActiveMQ WAR file to the Archiva server running within the
`bidms-docker-tomcat-dev` container.
