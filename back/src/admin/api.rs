use std::io::{Read, Write};
use std::fs;
use serde::Deserialize;
use serde_json::json;
use saras::http::{Request,Resp,json_resp,session_resp,del_session_resp};
use saras::http;
use saras::http::JsonResp;
use saras::users;

use std::path::PathBuf;
use saras::schema::schemars::{schema_for, JsonSchema};


pub async fn admin_schema(req: Request) -> Resp {
	let schema = json!({
		"common": {
			"storage_hostname": "https://1c2d2c90-a032-428c-9950-83fd4de0109b.selstorage.ru",
		},
		"ctgs": [
			users::schemas::users_schema(),
			//tiregame::schemas::tiregame_schema(),
		]
	});
	JsonResp::ok("").content(schema).to_http()
}
