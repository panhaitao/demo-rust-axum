use axum::{
    handler::get,
    response::Html,
    Router
};
use std::net::SocketAddr;

#[tokio::main]
async fn main() {
    let app = Router::new().route("/",get(index));

    let addr = SocketAddr::from(([0, 0, 0, 0], 3000));
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}

async fn index() -> Html<&'static str> {
    Html("<h1>Hello, World!<h1>")
}
