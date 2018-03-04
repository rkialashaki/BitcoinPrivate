Bitcoin Docker Development Environment
----------------

This is a barebones docker config that will build the BTCPrivate source in a 
container and allow you to run the btcpd daemon inside that container.  



Build
----------------
To build the image on linux, you can run the provided build.sh script.
Currently there is no relative path support (will be added in the future) so
you must be in the docker directory to run the script:


```
git clone https://github.com/rkialashaki/BitcoinPrivate
cd BitcoinPrivate/docker/
./build.sh
``` 

The build process will take several minutes to complete so take a short break
as it builds.  When done, you will be left with a docker images named
`btcpdocker` with two tags `latest` and `<VERSION>`.  

 
Run
----------------
To run the docker image:

```
#!/bin/bash
PROJECT=`cat ./PROJECT`
VERSION=`cat ./VERSION`
VOLUME="btcprivate_data:/root/.btcprivate"
IMAGE="$PROJECT:$VERSION"
PORTS="-p 7932:7932 -p 7933:7933"
docker run --rm -it --name $PROJECT -v $VOLUME $PORTS $IMAGE
```

By default this will run the btcpd daemon. 

To run the btcpd-cli:

```
#!/bin/bash
PROJECT=`cat ./PROJECT`
docker exec $PROJECT btcp-cli listreceivedbyaddress 0 true
```

To get a bash shell to the container:

```
#!/bin/bash
PROJECT=`cat ./PROJECT`
docker exec -it $PROJECT /bin/bash
```
