# build stage
FROM harbor.onwalk.net/pts/alpine-rust-dev:v3.14.1 as build-stage

ADD . /build-stage 
RUN cd /build-stage/axum-web && cargo build --release


# production stage
#FROM scratch
FROM harbor.onwalk.net/pts/alpine:3.14

WORKDIR /
COPY --from=build-stage /build-stage/axum-web/target/release/axum-web /axum-web
RUN chmod 755 /axum-web
EXPOSE 3000

CMD ["/axum-web"]
