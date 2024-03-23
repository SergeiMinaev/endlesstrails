use std::io::{Read, Write};
use std::fs;
use serde::Deserialize;
use serde_json::json;
use saras::http::{Request,Resp,json_resp,session_resp,del_session_resp};
use saras::http;
use saras::http::JsonResp;
use saras::users;
use saras::conf::CONF;

use std::path::PathBuf;
use saras::schema::schemars::{schema_for, JsonSchema};


pub async fn admin_schema(req: Request) -> Resp {
	let conf = CONF.read().await;
	let schema = json!({
		"storage": {
			"hostname": conf.selectel.container_hostname,
		},
		"images": {
			"sizes": conf.image_sizes,
		},
		"ctgs": [
			users::schemas::users_schema(),
			//tiregame::schemas::tiregame_schema(),
		]
	});
	JsonResp::ok("").content(schema).to_http()
}
