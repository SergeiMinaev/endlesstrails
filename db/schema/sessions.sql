CREATE TABLE public.sessions (
    id bytea DEFAULT public.gen_random_bytes(30) NOT NULL,
    user_id integer,
    expires timestamp with time zone DEFAULT (now() + '48:00:00'::interval)
);

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

