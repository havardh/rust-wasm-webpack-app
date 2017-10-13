FROM node:8.6.0

ENV DEBIAN_FRONTEND noninteractive

ENV PATH=/root/.cargo/bin:$PATH

RUN apt-get update && apt-get upgrade -qy && \
    apt-get install -y --no-install-recommends \
    curl git openssl libssl-dev ca-certificates \
    build-essential python cmake && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y && \
    rustup update && \
    rustup install stable && \
    rustup default stable && \
    rustup target add wasm32-unknown-emscripten

    RUN mkdir /cmake && cd /cmake && \
        wget  http://www.cmake.org/files/v3.4/cmake-3.4.3.tar.gz && \
        tar -xvf cmake-3.4.3.tar.gz && \
        cd cmake-3.4.3 && \
        ./configure && \
        make && \
        make install && \
        update-alternatives --install /usr/bin/cmake cmake /usr/local/bin/cmake 1 --force

RUN mkdir /emscripten && cd /emscripten && \
    wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz && \
    tar -xvf emsdk-portable.tar.gz

RUN cd /emscripten/emsdk-portable && \
    ./emsdk update

RUN cd /emscripten/emsdk-portable && \
    ./emsdk install sdk-incoming-64bit

RUN cd /emscripten/emsdk-portable && \
    ./emsdk activate sdk-incoming-64bit
#    cat emsdk_set_env.sh >> /root/.profile

ENV PATH=$PATH:/emscripten/emsdk-portable:/emscripten/emsdk-portable/clang/fastcomp/build_incoming_64/bin:/emscripten/emsdk-portable/emscripten/incoming

COPY package.json package.json
COPY package-lock.json package-lock.json

COPY . .

RUN npm i

RUN ./node_modules/.bin/webpack

CMD npm start
# CMD ["/bin/bash", "--login"]
