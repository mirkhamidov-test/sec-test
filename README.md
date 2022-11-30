# Test work

## Run application

Before start, ensure that [Docker](https://docs.docker.com/get-docker/) installed.

All commands to run from the root directory of the project in Terminal.

### Start application
```sh
make start-app
```

### Stop application
```sh
make stop-app
```

### Go to the shell of the application
```sh
make bash-app
```

Now application web interface available at [http://secupay.localhost](http://secupay.localhost/ping).

### Configure application

All docker environment could be adjusted with local `.docker.env.local` env vile for 
the Application (working, build containers only).


- `USERID` Is an id of local user, result of `$(id -u)`
- `XDEBUG_REMOTE_HOST` 
  - For macOS `host.docker.internal`
  - Linux, set as a value result of the command `docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}'`
- `DOCKER_MOUNT_CONF` 
  - `delegated` For MacOS machine
  - `consistent` For Linux host machine
- `ARCHITECTURE`
  - `amd64` for Linux x86-64
  - `arm64v8` could be used for Mac with silicon processor
  - and [all available other architectures](https://docs.docker.com/build/building/multi-platform/)


# Endpoints

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/391045-a888983e-d00d-4f2f-9571-88764da9dc5d?action=collection%2Ffork&collection-url=entityId%3D391045-a888983e-d00d-4f2f-9571-88764da9dc5d%26entityType%3Dcollection%26workspaceId%3De9bc2bc0-d42d-4df8-8ab1-a627e82e9cb0)

## Step 1.

Current server time

`/ping` - [http://secupay.localhost/ping](http://secupay.localhost/ping)



