--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: fragments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fragments (
    id integer NOT NULL,
    title character varying(255),
    code text,
    is_public boolean,
    hashie character varying(255),
    has_bugs boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    language character varying(255)
);


--
-- Name: fragments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fragments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fragments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fragments_id_seq OWNED BY fragments.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sharings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sharings (
    id integer NOT NULL,
    user_id integer,
    fragment_id integer
);


--
-- Name: sharings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sharings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sharings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sharings_id_seq OWNED BY sharings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    settings hstore,
    api_token character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fragments ALTER COLUMN id SET DEFAULT nextval('fragments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sharings ALTER COLUMN id SET DEFAULT nextval('sharings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: fragments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fragments
    ADD CONSTRAINT fragments_pkey PRIMARY KEY (id);


--
-- Name: sharings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sharings
    ADD CONSTRAINT sharings_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130221190410');

INSERT INTO schema_migrations (version) VALUES ('20130221192140');

INSERT INTO schema_migrations (version) VALUES ('20130221195830');

INSERT INTO schema_migrations (version) VALUES ('20130222090753');

INSERT INTO schema_migrations (version) VALUES ('20130222101712');

INSERT INTO schema_migrations (version) VALUES ('20130223225009');

INSERT INTO schema_migrations (version) VALUES ('20130223225111');

INSERT INTO schema_migrations (version) VALUES ('20130224111420');