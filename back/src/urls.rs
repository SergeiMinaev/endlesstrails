use futures_lite::{ Future, FutureExt };
use saras::http::{ Request,Resp };
use urlmatch::urlmatch;
use saras::http;
use crate::core;
use crate::admin;
use saras::users::users;
use saras::auth;


struct Path<Fut>
where
	Fut: Future<Output = Resp>,
{
	p: &'static str,
	f: fn(Request) -> Fut,
}

pub async fn url_dispatcher(mut req: Request) -> Resp {
	//println!("Route request: {req:?}");
	let url = req.path.to_string().to_lowercase();
	let routes = vec![
		Path {p: &"", f: |req| core::index(req).boxed()},
		Path {p: &"/admin", f: |req| admin::index(req).boxed()},
		Path {p: &"/admin/:ctg", f: |req| admin::index(req).boxed()},
		Path {p: &"/admin/:ctg/:subctg", f: |req| admin::index(req).boxed()},
		Path {p: &"/admin/:ctg/:subctg/:_", f: |req| admin::index(req).boxed()},

		Path {p: &"/api/user", f: |req| auth::api::get_user(req).boxed()},
		Path {p: &"/api/auth/login", f: |req| auth::api::login(req).boxed()},
		Path {p: &"/api/auth/logout", f: |req| auth::api::logout(req).boxed()},
	];
	let protected_routes = vec![
        Path {p: &"/api/users/users", f: |req| users::api::users(req).boxed()},
        Path {p: &"/api/users/users/:id", f: |req| users::api::users(req).boxed()},
		Path {p: &"/api/admin_schema", f: |req| admin::api::admin_schema(req).boxed()},
	];

	for route in routes.iter() {
		let r = urlmatch(&url, route.p);
		req.route = r.keys;
		if r.is_matched {
			return (route.f)(req).await;
		}
	}
	for route in protected_routes.iter() {
		  let r = urlmatch(&url, route.p);
		  req.route = r.keys;
		  if r.is_matched {
			  return auth::check_su(req, route.f).await;
		  }
	}
	http::not_found()

}
