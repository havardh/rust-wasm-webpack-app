# Rust wasm webpack app

This repository contains a skeloton for a Rust wasm demo using
webpack and docker.

## Running

`docker pull havardh/rust-wasm-webpack-app`
`npm run-docker`

This runs a docker image with the emscripten and Rust compiler and
exposes a webserver on localhost:3000 of the host machine which loads
the example application.

## Using

When the server is running, modify the `src/index.js` or `src/main.rs` files.
