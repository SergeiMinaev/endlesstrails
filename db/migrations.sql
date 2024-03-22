#LAST_APPLIED: 6

# 1
create extension if not exists pgcrypto;

# 2
create table users (
	id serial primary key,
	email varchar(255) not null unique,
	hash varchar(255) not null,
	is_superuser boolean default false
);

# 3
create table sessions (
	id bytea default gen_random_bytes(30) primary key,
	user_id int null references users(id) on delete cascade,
	expires timestamp with time zone default now() + '48 hours'::interval
);

# 4
alter table users rename to users_users;
alter table sessions rename to users_sessions;

# 5
alter table users_sessions rename to auth_sessions;

# 6
alter table users_users add column avatar varchar(255);
