# Rust WebAssembly webpack app

This repository contains a skeleton for a WebAssembly demo using Rust, webpack
and docker.

## Running

```
docker pull havardh/rust-wasm-webpack-app`
./scripts/run
```

This runs a docker image with the emscripten and Rust compiler and
exposes a webserver on localhost:3000 of the host machine which loads
the example application. On windows the ip for the virtualbox guest must be
used. When setting up the virtualbox as described in the
[Troubleshooting](#troubleshooting) section below, the ip can be found with the
command `docker-machine ip rust-vbox`.

## Using

When the server is running, modify the `[src/index.js](src/index.js)` or
`[src/main.rs](src/main.rs)` files. On osx and linux this should trigger an
automatic update of the application. On Windows the docker process can be
restarted to trigger the update manually.

(If you want to fix this is suspect the `-v $(pwd)/src:/src` part of the run
command in `[scripts/run](scripts/run)` is not working on Windows)

## Troubleshooting

The docker image is fairly large (27.4G), in order to build and possibly install
it we need to increase some defaults size limts for docker.

### Linux

Setting the default storage limit for creation of docker images.

`sudo dockerd --storage-opt dm.basesize=30G`

The docker daemon needs to be stopped while performing this command.
`systemctl stop docker` using systemd and `service stop docker` using upstart.

### Windows using VirtualBox

If you do not have sufficient space on the default hard drive you can set a
different hard drive as the location for the virtualboxes, e.g. on d:\\machines

```
export MACHINE_STORAGE_PATH=D:\\machines
```

Create a virtualbox with sufficient space:

```
docker-machine create \
  --virtualbox-memory 8096 \
  --virtualbox-disk-size 60000 \
  rust-vbox
```

Set `rust-vbox` as the active virtualbox.

```
eval $(docker-machine env rust-vbox)
```
