use futures_lite::{ future };
use saras::listener;
use endlesstrails::urls;


fn main() {
	let _ = future::block_on(listener::run(urls::url_dispatcher));
}

