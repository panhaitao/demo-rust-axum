# build stage
FROM alpine:3.14 as build-stage

ADD repositories /etc/apk/repositories
ADD cargo-registry-config /root/.cargo/config
RUN apk add --update --no-cache wget gcc make clang-dev musl-dev yaml curl libmicrohttpd libuuid

ENV RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static \
    RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
#    RUSTFLAGS='-C target-feature=+crt-static'

RUN mkdir deps && wget -O - https://mirrors.ustc.edu.cn/rust-static/dist/rust-1.55.0-$(apk --print-arch)-unknown-linux-musl.tar.gz | tar -C deps -z -x -f - && \
    sh /deps/rust-1.55.0-$(apk --print-arch)-unknown-linux-musl/install.sh --prefix=/usr && \
    rm -rf /deps

ADD . /build-stage 
RUN cd /build-stage/axum-web && cargo build --release


# production stage
#FROM scratch
FROM alpine:3.14 as prod-stage

WORKDIR /
COPY --from=build-stage /build-stage/axum-web/target/release/axum-web /axum-web
RUN chmod 755 /axum-web
EXPOSE 3000

CMD ["/axum-web"]
