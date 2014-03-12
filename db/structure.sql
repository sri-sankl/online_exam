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
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET search_path = public, pg_catalog;

--
-- Name: es; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: -
--

CREATE TEXT SEARCH CONFIGURATION es (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR asciiword WITH spanish_stem;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR word WITH unaccent, spanish_stem;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR numword WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR hword_part WITH unaccent, spanish_stem;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR hword_asciipart WITH spanish_stem;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR asciihword WITH spanish_stem;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR hword WITH unaccent, spanish_stem;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION es
    ADD MAPPING FOR uint WITH simple;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE courses (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE courses_id_seq OWNED BY courses.id;


--
-- Name: descriptive_questions; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE descriptive_questions (
    id integer NOT NULL,
    exam_id integer,
    description character varying(255),
    answer character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: descriptive_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE descriptive_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: descriptive_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE descriptive_questions_id_seq OWNED BY descriptive_questions.id;


--
-- Name: exams; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE exams (
    id integer NOT NULL,
    subject character varying(255),
    semester integer,
    exam_name character varying(255),
    course_id integer,
    duration double precision,
    no_of_questions integer,
    negative_mark double precision,
    pass_criteria_1 double precision,
    pass_text_1 text,
    pass_criteria_2 double precision,
    pass_text_2 character varying(255),
    pass_criteria_3 double precision,
    pass_text_3 character varying(255),
    pass_criteria_4 double precision,
    pass_text_4 character varying(255),
    multiple_choice integer,
    fill_in_blanks integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    faculty_id integer
);


--
-- Name: exams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE exams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE exams_id_seq OWNED BY exams.id;


--
-- Name: faculties; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE faculties (
    id integer NOT NULL,
    name character varying(255),
    designation character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: faculties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE faculties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faculties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE faculties_id_seq OWNED BY faculties.id;


--
-- Name: faculty_courses; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE faculty_courses (
    id integer NOT NULL,
    course_id integer,
    faculty_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: faculty_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE faculty_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faculty_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE faculty_courses_id_seq OWNED BY faculty_courses.id;


--
-- Name: multiple_choice_questions; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE multiple_choice_questions (
    id integer NOT NULL,
    exam_id integer,
    description character varying(255),
    option_1 character varying(255),
    option_2 character varying(255),
    option_3 character varying(255),
    option_4 character varying(255),
    answer character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: multiple_choice_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE multiple_choice_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: multiple_choice_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE multiple_choice_questions_id_seq OWNED BY multiple_choice_questions.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_id integer,
    searchable_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: results; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE results (
    id integer NOT NULL,
    schedule_id integer,
    total_marks integer,
    marks_secured double precision,
    exam_result character varying(255),
    student_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE results_id_seq OWNED BY results.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE roles (
    id integer NOT NULL,
    role character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE schedules (
    id integer NOT NULL,
    exam_id integer,
    exam_date_time timestamp without time zone,
    exam_end_date_time timestamp without time zone,
    schedule_date date,
    access_password character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE schedules_id_seq OWNED BY schedules.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    data text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE students (
    id integer NOT NULL,
    name character varying(255),
    dob date,
    joining_date date,
    course_id integer,
    semester integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    roll_number character varying(255),
    user_id integer
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE users (
    id integer NOT NULL,
    user_id character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    role_id integer,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    email character varying(255),
    resource_id integer
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

ALTER TABLE ONLY courses ALTER COLUMN id SET DEFAULT nextval('courses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptive_questions ALTER COLUMN id SET DEFAULT nextval('descriptive_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY exams ALTER COLUMN id SET DEFAULT nextval('exams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY faculties ALTER COLUMN id SET DEFAULT nextval('faculties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY faculty_courses ALTER COLUMN id SET DEFAULT nextval('faculty_courses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY multiple_choice_questions ALTER COLUMN id SET DEFAULT nextval('multiple_choice_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY schedules ALTER COLUMN id SET DEFAULT nextval('schedules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: descriptive_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY descriptive_questions
    ADD CONSTRAINT descriptive_questions_pkey PRIMARY KEY (id);


--
-- Name: exams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (id);


--
-- Name: faculties_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY faculties
    ADD CONSTRAINT faculties_pkey PRIMARY KEY (id);


--
-- Name: faculty_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY faculty_courses
    ADD CONSTRAINT faculty_courses_pkey PRIMARY KEY (id);


--
-- Name: multiple_choice_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY multiple_choice_questions
    ADD CONSTRAINT multiple_choice_questions_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: results_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX index_sessions_on_session_id ON sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE INDEX index_sessions_on_updated_at ON sessions USING btree (updated_at);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX index_users_on_user_id ON users USING btree (user_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace:
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140225101339');

INSERT INTO schema_migrations (version) VALUES ('20140225120150');

INSERT INTO schema_migrations (version) VALUES ('20140225123536');

INSERT INTO schema_migrations (version) VALUES ('20140225131021');

INSERT INTO schema_migrations (version) VALUES ('20140226051947');

INSERT INTO schema_migrations (version) VALUES ('20140226084856');

INSERT INTO schema_migrations (version) VALUES ('20140226093234');

INSERT INTO schema_migrations (version) VALUES ('20140226100651');

INSERT INTO schema_migrations (version) VALUES ('20140226102307');

INSERT INTO schema_migrations (version) VALUES ('20140226122236');

INSERT INTO schema_migrations (version) VALUES ('20140226123933');

INSERT INTO schema_migrations (version) VALUES ('20140226131135');

INSERT INTO schema_migrations (version) VALUES ('20140227023234');

INSERT INTO schema_migrations (version) VALUES ('20140227023325');

INSERT INTO schema_migrations (version) VALUES ('20140227070411');

INSERT INTO schema_migrations (version) VALUES ('20140227074133');

INSERT INTO schema_migrations (version) VALUES ('20140227080854');

INSERT INTO schema_migrations (version) VALUES ('20140227080914');

INSERT INTO schema_migrations (version) VALUES ('20140227091040');

INSERT INTO schema_migrations (version) VALUES ('20140227161821');

INSERT INTO schema_migrations (version) VALUES ('20140228183430');

INSERT INTO schema_migrations (version) VALUES ('20140301180941');

INSERT INTO schema_migrations (version) VALUES ('20140303053921');

INSERT INTO schema_migrations (version) VALUES ('20140306070512');

INSERT INTO schema_migrations (version) VALUES ('20140311104046');

INSERT INTO schema_migrations (version) VALUES ('20140311113319');

INSERT INTO schema_migrations (version) VALUES ('20140311120404');
