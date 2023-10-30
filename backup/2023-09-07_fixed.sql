--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

-- --
-- -- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
-- --

-- CREATE TABLE public.databasechangelog (
--     id character varying(255) NOT NULL,
--     author character varying(255) NOT NULL,
--     filename character varying(255) NOT NULL,
--     dateexecuted timestamp without time zone NOT NULL,
--     orderexecuted integer NOT NULL,
--     exectype character varying(10) NOT NULL,
--     md5sum character varying(35),
--     description character varying(255),
--     comments character varying(255),
--     tag character varying(255),
--     liquibase character varying(20),
--     contexts character varying(255),
--     labels character varying(255),
--     deployment_id character varying(10)
-- );


-- --
-- -- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
-- --

-- CREATE TABLE public.databasechangeloglock (
--     id integer NOT NULL,
--     locked boolean NOT NULL,
--     lockgranted timestamp without time zone,
--     lockedby character varying(255)
-- );


--
-- Name: department; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.department (
    id bigint NOT NULL,
    disable boolean DEFAULT false,
    name character varying(255) NOT NULL
);


--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.department_id_seq OWNED BY public.department.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.groups (
    id bigint NOT NULL,
    disable boolean DEFAULT false,
    title character varying(35) NOT NULL,
    sort_order integer
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lessons (
    id bigint NOT NULL,
    hours integer NOT NULL,
    lessontype character varying(255) NOT NULL,
    subject_for_site character varying(255) NOT NULL,
    group_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    teacher_id bigint NOT NULL,
    grouped boolean DEFAULT false,
    semester_id bigint NOT NULL,
    link_to_meeting character varying(255),
    CONSTRAINT lessons_hours_check CHECK ((hours >= 1))
);


--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- Name: periods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.periods (
    id bigint NOT NULL,
    end_time time without time zone NOT NULL,
    name character varying(35) NOT NULL,
    start_time time without time zone NOT NULL
);


--
-- Name: periods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.periods_id_seq OWNED BY public.periods.id;


--
-- Name: room_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.room_types (
    id bigint NOT NULL,
    description character varying(40) NOT NULL
);


--
-- Name: room_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.room_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: room_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.room_types_id_seq OWNED BY public.room_types.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rooms (
    id bigint NOT NULL,
    disable boolean DEFAULT false,
    name character varying(35) NOT NULL,
    room_type_id bigint,
    sort_order integer
);


--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schedules (
    id bigint NOT NULL,
    day_of_week character varying(35) NOT NULL,
    evenodd character varying(255) NOT NULL,
    lesson_id bigint NOT NULL,
    period_id bigint NOT NULL,
    room_id bigint NOT NULL
);


--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.schedules_id_seq OWNED BY public.schedules.id;


--
-- Name: semester_day; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.semester_day (
    semester_id bigint NOT NULL,
    day character varying(255)
);


--
-- Name: semester_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.semester_group (
    semester_id bigint NOT NULL,
    group_id bigint NOT NULL
);


--
-- Name: semester_period; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.semester_period (
    semester_id bigint NOT NULL,
    period_id bigint NOT NULL
);


--
-- Name: semesters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.semesters (
    id bigint NOT NULL,
    current_semester boolean DEFAULT false,
    description character varying(255),
    disable boolean DEFAULT false,
    end_day date NOT NULL,
    start_day date NOT NULL,
    year integer NOT NULL,
    default_semester boolean DEFAULT false,
    CONSTRAINT semesters_year_check CHECK ((year >= 1999))
);


--
-- Name: semesters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.semesters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: semesters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.semesters_id_seq OWNED BY public.semesters.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id bigint NOT NULL,
    name character varying(35) NOT NULL,
    patronymic character varying(35) NOT NULL,
    surname character varying(35) NOT NULL,
    group_id bigint NOT NULL,
    user_id bigint
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subjects (
    id bigint NOT NULL,
    disable boolean DEFAULT false,
    name character varying(80) NOT NULL
);


--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subjects_id_seq OWNED BY public.subjects.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teachers (
    id bigint NOT NULL,
    disable boolean DEFAULT false,
    name character varying(35) NOT NULL,
    patronymic character varying(35) NOT NULL,
    "position" character varying(35) NOT NULL,
    surname character varying(35) NOT NULL,
    user_id bigint,
    department_id bigint
);


--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teachers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- Name: temporary_schedule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temporary_schedule (
    id bigint NOT NULL,
    date date NOT NULL,
    grouped boolean DEFAULT false,
    lessontype character varying(255),
    subject_for_site character varying(255),
    vacation boolean DEFAULT false,
    group_id bigint,
    period_id bigint,
    room_id bigint,
    semester_id bigint,
    subject_id bigint,
    teacher_id bigint,
    notification boolean DEFAULT false,
    schedule_id bigint,
    link_to_meeting character varying(255)
);


--
-- Name: temporary_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.temporary_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: temporary_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.temporary_schedule_id_seq OWNED BY public.temporary_schedule.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(40) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(32) DEFAULT 'ROLE_USER'::character varying,
    token character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: department id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.department ALTER COLUMN id SET DEFAULT nextval('public.department_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- Name: periods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periods ALTER COLUMN id SET DEFAULT nextval('public.periods_id_seq'::regclass);


--
-- Name: room_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_types ALTER COLUMN id SET DEFAULT nextval('public.room_types_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: schedules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules ALTER COLUMN id SET DEFAULT nextval('public.schedules_id_seq'::regclass);


--
-- Name: semesters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semesters ALTER COLUMN id SET DEFAULT nextval('public.semesters_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: subjects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subjects ALTER COLUMN id SET DEFAULT nextval('public.subjects_id_seq'::regclass);


--
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- Name: temporary_schedule id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temporary_schedule ALTER COLUMN id SET DEFAULT nextval('public.temporary_schedule_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


-- --
-- -- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
-- --

-- COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
-- 1642775490693-1	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.308637	1	EXECUTED	8:aa5f97d9722ad33a04b1b2604046bdbf	createSequence sequenceName=department_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-2	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.316322	2	MARK_RAN	8:4896ada120320a0099ac0a904738457a	createTable tableName=department		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-3	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.323814	3	EXECUTED	8:8ed2ff06276e50ed7df1252d5e964474	createSequence sequenceName=groups_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-4	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.327729	4	MARK_RAN	8:0a68a94209f06f338b787eee9b8c57c8	createTable tableName=groups		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-5	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.334689	5	EXECUTED	8:a1bd6eab09d5f33081a2b68a290c47ce	createSequence sequenceName=lessons_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-6	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.341283	6	EXECUTED	8:6b79bf22a12c0dfdc6223d215fee1fe4	createSequence sequenceName=lessons_group_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-7	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.348928	7	EXECUTED	8:223d25bd1534e0266e2f3826eb2aa3ec	createSequence sequenceName=lessons_subject_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-8	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.356245	8	EXECUTED	8:6748c77819ff10f3adfef668487463c4	createSequence sequenceName=lessons_teacher_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-9	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.362916	9	EXECUTED	8:9e0b93e60a718df788ea9ee88f76c4ac	createSequence sequenceName=lessons_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-10	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.367251	10	MARK_RAN	8:e66111b48e5cae5e152ae2a669db4804	createTable tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-11	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.374242	11	EXECUTED	8:29e36d7770f7324389a1e645d2aa0c64	createSequence sequenceName=periods_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-12	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.377939	12	MARK_RAN	8:3017bf41941925296ba9ea4268c326a4	createTable tableName=periods		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-13	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.384531	13	EXECUTED	8:83d7f1ccac23afb00541a32bb8789f89	createSequence sequenceName=room_types_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-14	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.388246	14	MARK_RAN	8:2d9b1495eb58ec31cf1257b63c5ca093	createTable tableName=room_types		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-15	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.39597	15	EXECUTED	8:9216eda2c38e21fed8e1b4f7e0de15b7	createSequence sequenceName=rooms_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-16	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.404173	16	EXECUTED	8:9dce0005a32a5cb4d6c021be7db05afa	createSequence sequenceName=rooms_room_type_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-17	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.40865	17	MARK_RAN	8:42355d333e41bbf56e72d723d7618738	createTable tableName=rooms		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-18	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.420351	18	EXECUTED	8:5ed500717ecbce8f13a26fe2d3049fcf	createSequence sequenceName=schedules_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-19	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.427197	19	EXECUTED	8:9be95727039ac12224e43765fa41ee62	createSequence sequenceName=schedules_lesson_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-20	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.434088	20	EXECUTED	8:0b055e793e9c3f6d4c48d6821a59bd0d	createSequence sequenceName=schedules_period_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-21	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.440305	21	EXECUTED	8:7a63c25c4030c4cb70ec39a9a69dacaf	createSequence sequenceName=schedules_room_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-22	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.443774	22	MARK_RAN	8:89146ae8ad9af9e430a8dab09338c2a9	createTable tableName=schedules		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-23	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.45109	23	EXECUTED	8:6a63364cd9b7187764be3877dec94e6a	createSequence sequenceName=semester_day_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-24	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.455344	24	MARK_RAN	8:4dafb3ef4261b4006d46bf3bc7c36369	createTable tableName=semester_day		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-25	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.461523	25	EXECUTED	8:4f9d33e17a227c2e8c9f2aa48a61d890	createSequence sequenceName=semester_period_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-26	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.467802	26	EXECUTED	8:b8e3e4811e1ec5e2163038d6fa3ad970	createSequence sequenceName=semester_period_period_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-27	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.471526	27	MARK_RAN	8:5ff42a04568a8902488b504a06a2c7e0	createTable tableName=semester_period		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-28	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.477843	28	EXECUTED	8:6862c6f3a7ca7d1e8a47b2c256cc1d60	createSequence sequenceName=semesters_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-29	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.481582	29	MARK_RAN	8:f8b0d745274e244a11e71a8249c68258	createTable tableName=semesters		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-30	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.488154	30	EXECUTED	8:41f4a310e93e676e815571ae83e33766	createSequence sequenceName=students_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-31	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.49185	31	MARK_RAN	8:aeadb27a46fb0269adac892f5d30b2ff	createTable tableName=students		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-32	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.498534	32	EXECUTED	8:84690b8ed6999897da78d6cd7c1d3e91	createSequence sequenceName=subjects_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-33	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.502073	33	MARK_RAN	8:b19c14bdfa1f1e670d7a5026ec99b9c9	createTable tableName=subjects		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-34	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.508496	34	EXECUTED	8:aec286ed2878ffe6b71cd3427104460a	createSequence sequenceName=teachers_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-35	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.512331	35	MARK_RAN	8:86995232d247ea06c1a839ceef591dfc	createTable tableName=teachers		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-36	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.519105	36	EXECUTED	8:f0cdf595819a9dfc9c422e2fa261ec19	createSequence sequenceName=temporary_schedule_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-37	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.525355	37	EXECUTED	8:7508d26727002cf9c1b534bb1561aa39	createSequence sequenceName=temporary_schedule_group_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-38	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.531591	38	EXECUTED	8:240a5f936579d49f730c1328fb667ddf	createSequence sequenceName=temporary_schedule_period_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-39	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.543346	39	EXECUTED	8:99732f27b396fde52313a6c0f7d9bb9f	createSequence sequenceName=temporary_schedule_room_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-40	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.549584	40	EXECUTED	8:911d56ba64649b525d2664a0e283b475	createSequence sequenceName=temporary_schedule_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-41	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.556039	41	EXECUTED	8:de2ec953bfe5ea6e8d40edbf9b353a00	createSequence sequenceName=temporary_schedule_subject_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-42	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.562319	42	EXECUTED	8:6a8e5302703d9359f375e32e3e2d95f2	createSequence sequenceName=temporary_schedule_teacher_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-43	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.565836	43	MARK_RAN	8:5a212ec5297598066d10ce281ee18408	createTable tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-44	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.572214	44	EXECUTED	8:1fc72d3f0ba1f7821fa95765a828d81f	createSequence sequenceName=users_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-45	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.576242	45	MARK_RAN	8:4f383803e2e73d127b6a0624e22ceca4	createTable tableName=users		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-46	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.579985	46	MARK_RAN	8:4232f84c6bcd4e03074b154e7dc19177	createTable tableName=semester_group		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-47	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.585323	47	MARK_RAN	8:b0bf6d019ccdd5b69d56fd21104e4c23	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-48	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.59005	48	MARK_RAN	8:e1cc48a2fc60ea73e1ca3dafdc77e6f7	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-49	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.595098	49	MARK_RAN	8:dd670767f3e7f98351a8a4a5f739fac7	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-50	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.600745	50	MARK_RAN	8:616dfae1e362f59afa65af500632da1e	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-51	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.606187	51	MARK_RAN	8:d392f2e6fa728990e7dc6601cf1d87c1	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-52	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.610566	52	MARK_RAN	8:ba66cc1d4be5293a7000b68f4103b628	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-53	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.615874	53	MARK_RAN	8:f84c42c82b26547a41a134bd57b937f7	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-54	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.620632	54	MARK_RAN	8:19506382dc5b6c9f788fc9a655941a5b	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-55	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.625355	55	MARK_RAN	8:70d8fd0dcba2ce1a439c4c44c6ecc335	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-56	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.629606	56	MARK_RAN	8:2b312df599de7463eb572810947fd0a4	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-57	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.634411	57	MARK_RAN	8:45185e227ea186f350f9f496cebead43	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-58	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.639209	58	MARK_RAN	8:ca7d2a588be5114d6a638a42e8e072c8	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-59	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.644314	59	MARK_RAN	8:47c8f4b18daebb3908ce03f47288acf3	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-60	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.649008	60	MARK_RAN	8:118b1a15bcedff399acbadb2f6b92229	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-61	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.653982	61	MARK_RAN	8:c598d35e3a1a3727a4e2161cae12b59f	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-62	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.659492	62	MARK_RAN	8:2a6597848aa164d2db2ef51f0c0e4cee	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-63	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.664996	63	MARK_RAN	8:aa895b06f6db9b86f7222540496af958	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-64	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.67408	64	MARK_RAN	8:a46f19ef46e891039b9a4b6d428fbb42	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-65	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.67873	65	MARK_RAN	8:49b0ad140200aaf68d3335c3ef37af34	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-66	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.682953	66	MARK_RAN	8:e8b46acb519e8ea12df94c256d9ad22b	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-67	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.687505	67	MARK_RAN	8:da1610fa29dc67dabf249369c4c3325b	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-68	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.691772	68	MARK_RAN	8:f0d6852310ad0436794babb2a4ca6e5a	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-69	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.696197	69	MARK_RAN	8:bb13e4f59ba39e1fea31648fc9cee68a	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-70	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.701565	70	MARK_RAN	8:84ccaccf28493e7589cb7143fc7b249d	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-71	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.706943	71	MARK_RAN	8:86a0d37ed9d956c63ed58af883e87988	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-72	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.711532	72	MARK_RAN	8:faf66c2827cc5a196fd6b6facad399c5	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-73	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.716389	73	MARK_RAN	8:fe0f3c5c60ef1c63fb1a13068d42aff4	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-74	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.722126	74	MARK_RAN	8:692a67a26c178eb0710cd256a6f1c0d3	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-75	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.726881	75	MARK_RAN	8:ef04e306378056fe343e37afd3308eb8	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-76	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.734877	76	MARK_RAN	8:542fc5834480107a9a2019c53155c373	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-77	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.872516	77	MARK_RAN	8:d6605bd16f9fa778f4666b33e4c17592	addForeignKeyConstraint baseTableName=teachers, constraintName=fkl19hwymwn2ra2gwwty5trvyas, referencedTableName=department		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-78	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:12.927049	78	MARK_RAN	8:92e410f164024b025b39f791c615ddcb	addUniqueConstraint constraintName=uk_biw7tevwc07g3iutlbmkes0cm, tableName=department		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-79	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:13.181619	79	MARK_RAN	8:465c63a8d0aad41af7715824a6811e76	addForeignKeyConstraint baseTableName=temporary_schedule, constraintName=fka1bsm9fsuxn5t098i2cb7nncu, referencedTableName=groups		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-80	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:13.288884	80	MARK_RAN	8:1f599d60e1a0ee82e55a2e8432a6583a	addForeignKeyConstraint baseTableName=students, constraintName=fkmsev1nou0j86spuk5jrv19mss, referencedTableName=groups		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-81	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:13.404146	81	MARK_RAN	8:c2ce82437856bf0de8f73b1e21c68247	addForeignKeyConstraint baseTableName=semester_group, constraintName=fkpf19s66cmi8qpqc0iaeigbrhh, referencedTableName=groups		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-82	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:13.56793	82	MARK_RAN	8:85c3d7011d3bc89475e66a218f6fe5ad	addForeignKeyConstraint baseTableName=lessons, constraintName=fktdolsaotaqlwxbxwaxt00kimk, referencedTableName=groups		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-83	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:13.613132	83	MARK_RAN	8:1df26f8066f87c9cacf341066d12d61b	addUniqueConstraint constraintName=uk_ct3jhny5hfe6uj2osyn8a4p83, tableName=groups		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-84	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:13.814556	84	MARK_RAN	8:1e1856a98e992362e9ab38f2848de099	addForeignKeyConstraint baseTableName=schedules, constraintName=fk7f954gltrwny6pe4see76kpw8, referencedTableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-85	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:13.96347	85	MARK_RAN	8:bc72e72b5b0365d6f49c067b3394f1ca	addForeignKeyConstraint baseTableName=lessons, constraintName=fkbr76cuebuufbbltujpfq04tto, referencedTableName=teachers		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-86	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:14.114507	86	MARK_RAN	8:81e7637290fb17036b3661fecc1d789c	addForeignKeyConstraint baseTableName=lessons, constraintName=fke94a0k21xpi7glv89af90lwjv, referencedTableName=subjects		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-87	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:14.279996	87	MARK_RAN	8:1bc0cf8f1426b6cd71582595f79e40d3	addForeignKeyConstraint baseTableName=lessons, constraintName=fkil1jt6gri8x6yfaa3ijf7d6d9, referencedTableName=semesters		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-88	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:14.489622	88	MARK_RAN	8:80d91bbd4140a4695b1fcbbe2051ba30	addForeignKeyConstraint baseTableName=schedules, constraintName=fk4g2p59v3jm7hk6a9ufdufy8ie, referencedTableName=periods		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-89	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:14.606179	89	MARK_RAN	8:2c350da08193fe556a01900172cf850a	addForeignKeyConstraint baseTableName=semester_period, constraintName=fkm237asf73ugk3vvw47aq266kl, referencedTableName=periods		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-90	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:14.803291	90	MARK_RAN	8:ea07065afa17f3cc89e5e6e5d9e6e778	addForeignKeyConstraint baseTableName=temporary_schedule, constraintName=fkr76lbhlv0di8ix7iviixs0p4g, referencedTableName=periods		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-91	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:14.836314	91	MARK_RAN	8:a4b42c93e1b2f18d49d612f5fb7cd3e4	addUniqueConstraint constraintName=uk_bgj9vbqf54b7iryxqu895bggh, tableName=periods		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-92	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:14.9456	92	MARK_RAN	8:d76a837afcdadae3d25413843c321915	addForeignKeyConstraint baseTableName=rooms, constraintName=fkh9m2n1paq5hmd3u0klfl7wsfv, referencedTableName=room_types		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-93	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:14.984319	93	MARK_RAN	8:bdaf4cec3aa0a4d5f53aa223a80ba939	addUniqueConstraint constraintName=uk_gunh6313ruq1dghti9p00529u, tableName=room_types		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-94	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:15.189373	94	MARK_RAN	8:bfd6aacdf47b887c990faf116da73f82	addForeignKeyConstraint baseTableName=schedules, constraintName=fk34r5t4jexlcas19pleifb8ihv, referencedTableName=rooms		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-95	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:15.37333	95	MARK_RAN	8:0f9fadd0354b14b3f54b846d04abcb72	addForeignKeyConstraint baseTableName=temporary_schedule, constraintName=fk3hid2313ah5gjqqye9d3eik2g, referencedTableName=rooms		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-96	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:15.493153	96	MARK_RAN	8:495474e8b7a4d5af182d08b7373ed7a6	addForeignKeyConstraint baseTableName=semester_day, constraintName=fk36f17dewxqjhb23rhlmc7slk3, referencedTableName=semesters		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-97	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:15.625168	97	MARK_RAN	8:53da83c0a726bb47762c3a651d742968	addForeignKeyConstraint baseTableName=semester_period, constraintName=fk94poii1rmjhoevjx7bsymtbtd, referencedTableName=semesters		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-98	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:15.743076	98	MARK_RAN	8:4975056c1d0a39f3e6759a176c870661	addForeignKeyConstraint baseTableName=semester_group, constraintName=fk4j15tivie8ttfhl0s7x3o3syv, referencedTableName=semesters		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-99	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:15.950036	99	MARK_RAN	8:af1fa9da5c42068c9da41f5aacbe0544	addForeignKeyConstraint baseTableName=temporary_schedule, constraintName=fkaqmj2bajc0ud8wproqn4843pk, referencedTableName=semesters		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-100	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:16.012622	100	MARK_RAN	8:3334c996979993bafdab1fa3be1b3fd6	addUniqueConstraint constraintName=uk_e2rndfrsx22acpq2ty1caeuyw, tableName=students		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-101	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:16.194456	101	MARK_RAN	8:bf49fb25ba5f2a530326d65285a2c469	addForeignKeyConstraint baseTableName=temporary_schedule, constraintName=fkqn6ufkok0nhqdkn46ctqckb76, referencedTableName=subjects		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-102	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:16.22784	102	MARK_RAN	8:0d0dc8e776721f293d981e1bf40b480c	addUniqueConstraint constraintName=uk_aodt3utnw0lsov4k9ta88dbpr, tableName=subjects		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-103	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:16.415814	103	MARK_RAN	8:b5f3e48312b92ce1c8d606087feea4c8	addForeignKeyConstraint baseTableName=temporary_schedule, constraintName=fko7tild8vhrqlodd3oaf8acvyw, referencedTableName=teachers		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-104	SaneQQQQ	db/changelog/initial-schema.yaml	2023-01-10 00:54:16.453053	104	MARK_RAN	8:930ca191405d374f276f19715b20d1b7	addUniqueConstraint constraintName=uk_6dotkott2kjsp8vw4d0m25fb7, tableName=users		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-105	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.457418	105	EXECUTED	8:10321f44b60d2c561d72a8c72b64a1d1	addColumn tableName=groups		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-106	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.460705	106	EXECUTED	8:42d9501e3337b724e4462939571ee5f2	createSequence sequenceName=sorting_order_sequence		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-107	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.468491	107	EXECUTED	8:f284a97909c948c5202647e82989d574	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-108	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.472719	108	EXECUTED	8:efd43fc6321ad8d944d03972d1e94a57	addColumn tableName=rooms		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-109	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.476471	109	EXECUTED	8:7825fbb05324f80b3b1152538de9cc02	createSequence sequenceName=sort_order_sequence		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-110	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.479951	110	EXECUTED	8:bc0f2b8b4e0cc5a70f678ecdbd231467	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-111	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.482895	111	EXECUTED	8:0ba76dec1bc756a0fb890c9bbefc8336	createSequence sequenceName=semester_group_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-112	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.487291	112	EXECUTED	8:6aefa45b11ebb5dcdbdb01e1c106446b	addDefaultValue columnName=semester_id, tableName=semester_group		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-113	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.490724	113	EXECUTED	8:d6f83e9cabb791f2096ab63dd2373439	createSequence sequenceName=semester_group_group_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-114	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.494346	114	EXECUTED	8:a2a0ab383b40b69cb57f64f8780c5cff	addDefaultValue columnName=group_id, tableName=semester_group		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-115	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.497605	115	EXECUTED	8:87ced3bd1c87b927544343e97ae954d2	addColumn tableName=students		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-116	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.506919	116	EXECUTED	8:efff72f0775752b90765801a6893c763	addForeignKeyConstraint baseTableName=students, constraintName=user_id_fk, referencedTableName=users		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-117	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.510443	117	EXECUTED	8:25e7d0e93b9bf75318818823125240ef	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-118	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.515376	118	EXECUTED	8:f37777b07c0fbd5686349263bfb84b59	dropColumn columnName=email, tableName=students		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-119	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.521075	119	EXECUTED	8:a928ea0676d296c8daf28606a41843ef	modifyDataType columnName=user_id, tableName=teachers		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-120	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.523943	120	EXECUTED	8:f77ada9c5aa5aa6094a3048e16f422d4	dropColumn columnName=lesson_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-121	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.52673	121	EXECUTED	8:dae9fb6baa1f293aa01722044c4cea0c	dropColumn columnName=teacher_for_site, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-122	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.531072	122	EXECUTED	8:32c00fe103876b8e56d30b44444d77bd	dropSequence sequenceName=sort_order_sequence		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-123	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.535163	123	EXECUTED	8:35099e4db18af2a4ca175ac95ea6b0cc	dropSequence sequenceName=sorting_order_sequence		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-124	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.538669	124	EXECUTED	8:1008a89e30f6c17fba04f5b604d376af	dropNotNullConstraint columnName=group_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-125	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.541862	125	EXECUTED	8:34e6693a8cfdefed793334a24de26fca	dropNotNullConstraint columnName=period_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-126	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.545397	126	EXECUTED	8:cbd9f5a0788008a2a5a2fd2842afc30d	dropNotNullConstraint columnName=room_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-127	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.548857	127	EXECUTED	8:8535a69b9c33f3df8b17868eaa67e090	dropNotNullConstraint columnName=room_type_id, tableName=rooms		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-128	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.552055	128	EXECUTED	8:dd8de81e18018b429783da039b3e97b2	dropNotNullConstraint columnName=semester_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-129	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.555007	129	EXECUTED	8:f989bc4abbb973dda43cfc5602994bc3	dropNotNullConstraint columnName=subject_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-130	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.557771	130	EXECUTED	8:df3a4ef19feb0c6923839274f00d55be	dropNotNullConstraint columnName=teacher_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-131	vchornyy12	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.560865	131	EXECUTED	8:d4d6d78dca0d8b2035c6471d6447b90c	delete tableName=students		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-132	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.564529	132	EXECUTED	8:a18e1ac1ea080d5f9e012e62577c63e4	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-133	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.567848	133	EXECUTED	8:20eebf8805602fc09404e556e078ce86	sql		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-134	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.570883	134	EXECUTED	8:c017b83ff51b6a70048be2a7dea5d31f	dropDefaultValue columnName=group_id, tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-135	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.585024	135	EXECUTED	8:b4f3146b8b2e18e233a1f95f1da4630d	modifyDataType columnName=group_id, tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-136	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.589989	136	EXECUTED	8:f22ebbe7a3903e2b9d7fc43ed839b94f	dropSequence sequenceName=lessons_group_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-137	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.593411	137	EXECUTED	8:51baf8e5166c0cc5859956630cb42318	dropDefaultValue columnName=semester_id, tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-138	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.604456	138	EXECUTED	8:581300a10d3b525692bef085daf3c201	modifyDataType columnName=semester_id, tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-139	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.60757	139	EXECUTED	8:731785025bd4392fef9945a985776f22	dropSequence sequenceName=lessons_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-140	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.610475	140	EXECUTED	8:672a62effd789acb76132b9ed3b3af11	dropDefaultValue columnName=subject_id, tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-141	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.622277	141	EXECUTED	8:f0e8b4d913b62b92f28952fd91e441c3	modifyDataType columnName=subject_id, tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-142	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.625414	142	EXECUTED	8:feffd59078b8ac1cbfbc257fa5d48ae6	dropSequence sequenceName=lessons_subject_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-143	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.6283	143	EXECUTED	8:67b6f9273e4622976c45ab7c576dde8e	dropDefaultValue columnName=teacher_id, tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-144	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.641862	144	EXECUTED	8:26169cb4f37e64e583acf9f891b97d8f	modifyDataType columnName=teacher_id, tableName=lessons		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-145	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.644986	145	EXECUTED	8:d2e2ad799accd360ef53ab006c7ea21f	dropSequence sequenceName=lessons_teacher_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-146	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.648026	146	EXECUTED	8:49adfdce8b9cc6b4d5efeebd4acd1f46	dropDefaultValue columnName=room_type_id, tableName=rooms		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-147	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.653948	147	EXECUTED	8:c37cfe648bf725745088d4042b3f79e8	modifyDataType columnName=room_type_id, tableName=rooms		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-148	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.65744	148	EXECUTED	8:449729f3816c5c7cfe947a5d42c70dcb	dropSequence sequenceName=rooms_room_type_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-149	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.66043	149	EXECUTED	8:87283be462c2c7ac0e57ee3bd0325290	dropDefaultValue columnName=lesson_id, tableName=schedules		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-150	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.672177	150	EXECUTED	8:d6633ae95b80efc0bec4ee1b2c4fc45c	modifyDataType columnName=lesson_id, tableName=schedules		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-151	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.675564	151	EXECUTED	8:c668f41841404c56f0fbe9d222bae8bd	dropSequence sequenceName=schedules_lesson_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-152	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.678642	152	EXECUTED	8:d4b76f0f28b7aa9a47e15f6e20c57d25	dropDefaultValue columnName=period_id, tableName=schedules		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-153	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.692323	153	EXECUTED	8:694545abc17ac55cd47b4c8bc8d656fc	modifyDataType columnName=period_id, tableName=schedules		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-154	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.696234	154	EXECUTED	8:8a955e2590a32d688ab42b9c1190edb0	dropSequence sequenceName=schedules_period_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-155	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.699492	155	EXECUTED	8:b7f3f05cb8fbcdcdba1068301595aefe	dropDefaultValue columnName=room_id, tableName=schedules		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-156	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.7171	156	EXECUTED	8:22d7f4d81555776ddd049dc149f10bca	modifyDataType columnName=room_id, tableName=schedules		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-157	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.720834	157	EXECUTED	8:5acc3c57bcd26c536ac2a59eac96bf80	dropSequence sequenceName=schedules_room_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-158	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.724436	158	EXECUTED	8:32129a6b3d276ea56ded71c807abc6a6	dropDefaultValue columnName=semester_id, tableName=semester_day		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-159	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.729256	159	EXECUTED	8:1d6c875b213cb928798311040c8c362b	modifyDataType columnName=semester_id, tableName=semester_day		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-160	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.732292	160	EXECUTED	8:bacff4b797297a1f903c4923a4115182	dropSequence sequenceName=semester_day_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-161	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.735005	161	EXECUTED	8:c148c9109ecbe4193f29782be66e9e7d	dropDefaultValue columnName=group_id, tableName=semester_group		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-162	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.741019	162	EXECUTED	8:5791479959cd9c1290e0f94b8f271671	modifyDataType columnName=group_id, tableName=semester_group		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-163	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.744323	163	EXECUTED	8:fce54fe695b703f28132b28bba37bf00	dropSequence sequenceName=semester_group_group_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-164	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.747524	164	EXECUTED	8:86a24f64e9e372564c94e38fff246288	dropDefaultValue columnName=semester_id, tableName=semester_group		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-165	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.753977	165	EXECUTED	8:a5592c1017d9ee2b45b261d5283649bd	modifyDataType columnName=semester_id, tableName=semester_group		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-166	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.757485	166	EXECUTED	8:7e58b91e4ef8a8da617a59dcc3bed5eb	dropSequence sequenceName=semester_group_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-167	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.760449	167	EXECUTED	8:a842b484eaaebf20934b76087393b28a	dropDefaultValue columnName=period_id, tableName=semester_period		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-168	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.766226	168	EXECUTED	8:0990d1a552dc6674c0d8cdf966f2e110	modifyDataType columnName=period_id, tableName=semester_period		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-169	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.769408	169	EXECUTED	8:208e59596226fad60e997ed06a251d79	dropSequence sequenceName=semester_period_period_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-170	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.772228	170	EXECUTED	8:d40183e646e8acbd3432b2f7f1386327	dropDefaultValue columnName=semester_id, tableName=semester_period		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-171	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.777669	171	EXECUTED	8:aa4e7d10441bab87a29bf3955f01e67e	modifyDataType columnName=semester_id, tableName=semester_period		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-172	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.780689	172	EXECUTED	8:c069e1e09acaa7aaf8a6de4f66195763	dropSequence sequenceName=semester_period_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-173	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.783799	173	EXECUTED	8:ff592de6322cb52f0dc14ba4c03dd689	dropDefaultValue columnName=group_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-174	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.790758	174	EXECUTED	8:549c16aa402e0a27029d044a73e6c331	modifyDataType columnName=group_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-175	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.793779	175	EXECUTED	8:a50734a8f82c1b02d150a3d5da89e55c	dropSequence sequenceName=temporary_schedule_group_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-176	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.796815	176	EXECUTED	8:bd503d8314dcaf7a5af4e52250b4fca5	dropDefaultValue columnName=period_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-177	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.804519	177	EXECUTED	8:5c8fd0f13dbf796b4c7230ba6a2bf6c8	modifyDataType columnName=period_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-178	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.80765	178	EXECUTED	8:ad5ce0416f6e31d999d1d7aee39d2ee2	dropSequence sequenceName=temporary_schedule_period_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-179	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.810567	179	EXECUTED	8:9d95d343e131eb7bcd5f25ba3b85cd12	dropDefaultValue columnName=room_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-180	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.816712	180	EXECUTED	8:a6905f0ddd94333a2674dbd746e044dc	modifyDataType columnName=room_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-181	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.819479	181	EXECUTED	8:9828723df3085b83283fb76bc43cbb4f	dropSequence sequenceName=temporary_schedule_room_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-182	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.822378	182	EXECUTED	8:079e403c2f1eb89222a40ccaeae67f09	dropDefaultValue columnName=semester_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-183	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.8298	183	EXECUTED	8:f5e2f0c4db249765d0d1b390b295a17f	modifyDataType columnName=semester_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-184	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.833154	184	EXECUTED	8:a47756409b37689995022aa750dfb92c	dropSequence sequenceName=temporary_schedule_semester_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-185	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.836084	185	EXECUTED	8:e1f5841ac4b048c06b6d37d09a6359cd	dropDefaultValue columnName=subject_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-186	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.842538	186	EXECUTED	8:d2b8a810281004ab1b0be2b240d2f8a3	modifyDataType columnName=subject_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-187	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.845745	187	EXECUTED	8:bf3c8abc9761f2b6e47cf50e5b0ede88	dropSequence sequenceName=temporary_schedule_subject_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-188	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.848717	188	EXECUTED	8:69095186b0bd9908df7f5141affcabda	dropDefaultValue columnName=teacher_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-189	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.855313	189	EXECUTED	8:4a8c0747ea06b4396b729e218cf99435	modifyDataType columnName=teacher_id, tableName=temporary_schedule		\N	4.6.2	\N	\N	3304852089
-- 1642775490693-190	SaneQQQQ	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.858331	190	EXECUTED	8:30027935fd55013a359f4dd372b92bcb	dropSequence sequenceName=temporary_schedule_teacher_id_seq		\N	4.6.2	\N	\N	3304852089
-- 1653908145376-191	RuslanSlobodian	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.86277	191	EXECUTED	8:9e4cd7cb34395a3b9e084191d1b091c3	modifyDataType columnName=sort_order, tableName=rooms		\N	4.6.2	\N	\N	3304852089
-- 1653908145376-192	petrokrechunyak	db/changelog/changeset/v1.0/db.changelog-v1.0.yaml	2023-01-10 00:54:16.866016	192	EXECUTED	8:b670fa15db3b634c34b8c00ac80bda7a	renameColumn newColumnName=sort_order, oldColumnName=sorting_order, tableName=groups		\N	4.6.2	\N	\N	3304852089
-- \.


-- --
-- -- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
-- --

-- COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
-- 1	f	\N	\N
-- \.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.department (id, disable, name) FROM stdin;
1	f	Математичного моделювання
3	f	Математичного аналізу
4	f	Прикладної математики та інформаційних технологій
5	f	Диференціальних рівнянь
6	f	Алгебри та інформатики
13	t	Алгебри 
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.groups (id, disable, title, sort_order) FROM stdin;
90	t	test	153
17	t	Ch-099.UI	152
106	f	608	120
92	f	212-Б	36
40	f	302-А	49
45	f	401-А	90
46	f	401-Б	91
41	f	322	86
42	f	308	87
43	f	306	88
44	f	305	89
38	f	321	46
103	f	302-Б	50
63	f	601	114
94	f	311-Б	45
100	f	511	101
95	f	311-А	43
98	f	508	113
58	f	501	100
60	f	507	109
59	f	502	110
61	f	505	111
54	f	202-А	33
104	f	411	92
5	f	111-А	10
85	f	111-Б	11
65	f	607	116
64	f	602	117
66	f	605	118
87	f	202-Б	34
67	f	606	119
39	f	307-А	47
102	f	307-Б	48
32	f	212-А	35
55	f	208	37
36	f	301-А	41
29	f	101-Б	7
84	f	211-А	26
93	f	211-Б	27
27	f	102-А	17
26	f	102-Б	18
31	f	106	22
28	f	105	23
51	f	201-А	24
52	f	201-Б	25
33	f	108	21
37	f	301-Б	42
57	f	205	39
56	f	206	38
53	f	207	28
86	f	107	12
62	f	506	112
71	f	405	99
70	f	422	96
72	f	408	97
73	f	406	98
49	f	421	93
50	f	407	94
68	f	402	95
30	f	101-А	6
105	f	611	115
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lessons (id, hours, lessontype, subject_for_site, group_id, subject_id, teacher_id, grouped, semester_id, link_to_meeting) FROM stdin;
3726	1	LECTURE	Актуальні питання історії та культури України	30	257	51	t	55	\N
3727	1	LECTURE	Актуальні питання історії та культури України	29	257	51	t	55	\N
3728	1	LECTURE	Актуальні питання історії та культури України	5	257	51	t	55	\N
3729	1	LECTURE	Актуальні питання історії та культури України	85	257	51	t	55	\N
3730	1	LECTURE	Актуальні питання історії та культури України	86	257	51	t	55	\N
3731	1	LECTURE	Актуальні питання історії та культури України	27	257	51	t	55	\N
3732	1	LECTURE	Актуальні питання історії та культури України	26	257	51	t	55	\N
3733	3	PRACTICAL	Математичний аналіз	30	55	28	f	55	\N
3734	3	PRACTICAL	Математичний аналіз	29	55	28	f	55	\N
3740	1	LECTURE	Актуальні питання історії та культури України	33	257	51	f	55	\N
3741	1	LECTURE	Актуальні питання історії та культури України	31	257	51	f	55	\N
3742	1	LECTURE	Актуальні питання історії та культури України	28	257	51	f	55	\N
3743	2	LECTURE	Диференціальні рівняння	51	45	108	t	55	\N
3744	2	LECTURE	Диференціальні рівняння	52	45	108	t	55	\N
3745	2	LECTURE	Диференціальні рівняння	84	45	108	t	55	\N
3746	2	LECTURE	Диференціальні рівняння	93	45	108	t	55	\N
3751	2	PRACTICAL	Диференціальні рівняння	53	45	78	f	55	\N
3756	2	PRACTICAL	Диференціальні рівняння	55	45	78	f	55	\N
3757	2	PRACTICAL	Диференціальні рівняння	56	45	78	f	55	\N
2856	3	PRACTICAL	Математичний аналіз*	5	103	28	t	55	\N
2857	3	PRACTICAL	Математичний аналіз*	85	103	28	t	55	\N
3758	2	PRACTICAL	Диференціальні рівняння	57	45	78	f	55	\N
3759	2	LECTURE	Комп'ютерні мережі	51	50	70	t	55	\N
3760	2	LECTURE	Комп'ютерні мережі	52	50	70	t	55	\N
3761	2	LECTURE	Комп'ютерні мережі	84	50	70	t	55	\N
3762	2	LECTURE	Комп'ютерні мережі	93	50	70	t	55	\N
3763	2	LECTURE	Комп'ютерні мережі	53	50	70	t	55	\N
3764	2	LECTURE	Комп'ютерні мережі	54	50	70	t	55	\N
3765	2	LECTURE	Комп'ютерні мережі	87	50	70	t	55	\N
2864	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	86	169	102	f	55	\N
3766	2	LECTURE	Комп'ютерні мережі	32	50	70	t	55	\N
3767	2	LECTURE	Комп'ютерні мережі	92	50	70	t	55	\N
3768	2	LECTURE	Комп'ютерні мережі	55	50	70	t	55	\N
3739	2	LABORATORY	Програмування	26	15	19	f	55	\N
3747	2	PRACTICAL	Диференціальні рівняння	51	45	108	f	55	\N
3752	2	PRACTICAL	Диференціальні рівняння	54	45	77	f	55	\N
3770	2	LABORATORY	Комп'ютерні мережі	52	50	70	f	55	\N
3771	2	LABORATORY	Комп'ютерні мережі	84	50	70	f	55	\N
3772	2	LABORATORY	Комп'ютерні мережі	93	50	70	f	55	\N
3769	2	LABORATORY	Комп'ютерні мережі	51	50	70	f	55	\N
3773	2	LABORATORY	Комп'ютерні мережі	53	50	107	f	55	\N
3748	2	PRACTICAL	Диференціальні рівняння	52	45	108	f	55	\N
3749	2	PRACTICAL	Диференціальні рівняння	84	45	108	f	55	\N
3750	2	PRACTICAL	Диференціальні рівняння	93	45	108	f	55	\N
3753	2	PRACTICAL	Диференціальні рівняння	87	45	77	f	55	\N
3754	2	PRACTICAL	Диференціальні рівняння	32	45	77	f	55	\N
3755	2	PRACTICAL	Диференціальні рівняння	92	45	77	f	55	\N
3778	2	LABORATORY	Комп'ютерні мережі	55	50	70	f	55	\N
2923	2	LABORATORY	Програмування	5	15	203	f	55	\N
2930	2	LABORATORY	Програмування	86	15	70	f	55	\N
4055	2	LECTURE	Платформи корпоративних інформаційних систем	70	67	66	t	55	\N
3777	2	LABORATORY	Комп'ютерні мережі	92	50	97	f	55	\N
4056	2	LABORATORY	Платформи корпоративних інформаційних систем	68	67	66	t	55	\N
4057	2	LABORATORY	Платформи корпоративних інформаційних систем	70	67	66	t	55	\N
4058	2	LECTURE	Геометричні перетворення	73	85	49	t	55	\N
4059	2	LECTURE	Геометричні перетворення	71	85	49	t	55	\N
2917	2	PRACTICAL	Англійська мова	29	132	87	t	55	\N
2918	2	PRACTICAL	Англійська мова	5	132	87	t	55	\N
2925	2	PRACTICAL	Англійська мова	85	132	161	f	55	\N
2927	3	PRACTICAL	Математичний аналіз	86	55	105	f	55	\N
3794	2	LABORATORY	Об'єктно-орієнтоване програмування	87	46	71	f	55	\N
3795	2	LABORATORY	Об'єктно-орієнтоване програмування	32	46	71	f	55	\N
3796	2	LABORATORY	Об'єктно-орієнтоване програмування	92	46	71	f	55	\N
3797	2	LECTURE	Основи інтернет-технологгій	51	40	73	t	55	\N
3798	2	LECTURE	Основи інтернет-технологгій	52	40	73	t	55	\N
3799	2	LECTURE	Основи інтернет-технологгій	84	40	73	t	55	\N
3800	2	LECTURE	Основи інтернет-технологгій	93	40	73	t	55	\N
3801	2	LECTURE	Основи інтернет-технологгій	53	40	73	t	55	\N
3802	2	LECTURE	Основи інтернет-технологгій	55	40	73	t	55	\N
3803	2	LECTURE	Основи інтернет-технологгій	57	40	73	t	55	\N
3804	2	LABORATORY	Основи інтернет-технологгій	51	40	73	f	55	\N
3806	2	LABORATORY	Основи інтернет-технологгій	84	40	73	f	55	\N
3808	2	LABORATORY	Основи інтернет-технологгій	53	40	73	f	55	\N
2986	2	LECTURE	Програмування	33	15	32	t	55	\N
2987	2	LECTURE	Програмування	31	15	32	t	55	\N
2988	2	LECTURE	Програмування	28	15	32	t	55	\N
3005	2	LABORATORY	Програмування	28	15	203	f	55	\N
3004	2	LABORATORY	Програмування	31	15	32	f	55	\N
2916	2	LABORATORY	Програмування	29	15	203	f	55	\N
2924	2	LABORATORY	Програмування	85	15	185	f	55	\N
2962	2	PRACTICAL	Англійська мова*	26	291	149	f	55	\N
2931	2	PRACTICAL	Англійська мова	86	132	187	f	55	\N
2973	2	PRACTICAL	Англійська мова	33	132	149	f	55	\N
2963	2	PRACTICAL	Англійська мова	28	132	187	f	55	\N
2929	2	PRACTICAL	Програмування	86	15	33	f	55	\N
2935	3	PRACTICAL	Математичний аналіз	27	55	22	t	55	\N
2936	3	PRACTICAL	Математичний аналіз	26	55	22	t	55	\N
3774	2	LABORATORY	Комп'ютерні мережі	54	50	107	f	55	\N
3775	2	LABORATORY	Комп'ютерні мережі	87	50	107	f	55	\N
3776	2	LABORATORY	Комп'ютерні мережі	32	50	107	f	55	\N
3789	2	LABORATORY	Об'єктно-орієнтоване програмування	52	46	75	f	55	\N
3791	2	LABORATORY	Об'єктно-орієнтоване програмування	93	46	75	f	55	\N
3792	2	LABORATORY	Об'єктно-орієнтоване програмування	53	46	97	f	55	\N
3811	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	51	43	53	f	55	\N
3805	2	LABORATORY	Основи інтернет-технологгій	52	40	189	f	55	\N
3807	2	LABORATORY	Основи інтернет-технологгій	93	40	189	f	55	\N
3809	2	LABORATORY	Основи інтернет-технологгій	55	40	189	f	55	\N
2990	2	LABORATORY	Програмування	33	15	64	f	55	\N
3006	2	PRACTICAL	Англійська мова	31	132	187	f	55	\N
2989	1	PRACTICAL	Програмування	33	15	64	f	55	\N
3788	2	LABORATORY	Об'єктно-орієнтоване програмування	51	46	97	f	55	\N
3790	2	LABORATORY	Об'єктно-орієнтоване програмування	84	46	72	f	55	\N
3810	2	LABORATORY	Основи інтернет-технологгій	57	40	189	f	55	\N
3779	3	LECTURE	Об'єктно-орієнтоване програмування	51	46	71	t	55	\N
3813	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	84	43	87	f	55	\N
3780	3	LECTURE	Об'єктно-орієнтоване програмування	52	46	71	t	55	\N
3781	3	LECTURE	Об'єктно-орієнтоване програмування	84	46	71	t	55	\N
3782	3	LECTURE	Об'єктно-орієнтоване програмування	93	46	71	t	55	\N
3783	3	LECTURE	Об'єктно-орієнтоване програмування	53	46	71	t	55	\N
3831	3	LABORATORY	Теорія алгоритмів	93	36	33	f	55	\N
3839	2	LABORATORY	Програмування мовою Python	52	48	36	f	55	\N
3833	1	LECTURE	Програмування мовою Python	51	48	36	t	55	\N
3834	1	LECTURE	Програмування мовою Python	52	48	36	t	55	\N
3835	1	LECTURE	Програмування мовою Python	84	48	36	t	55	\N
3836	1	LECTURE	Програмування мовою Python	93	48	36	t	55	\N
3837	1	LECTURE	Програмування мовою Python	53	48	36	t	55	\N
3003	1	PRACTICAL	Програмування	28	15	203	f	55	\N
3002	1	PRACTICAL	Програмування	31	15	32	f	55	\N
3828	3	LABORATORY	Теорія алгоритмів	51	36	203	f	55	\N
3838	2	LABORATORY	Програмування мовою Python	51	48	185	f	55	\N
3841	2	LABORATORY	Програмування мовою Python	93	48	185	f	55	\N
3850	1	LECTURE	Використання MS Excel y BigData	52	258	34	t	55	\N
3852	1	LECTURE	Використання MS Excel y BigData	93	258	34	t	55	\N
3854	2	LABORATORY	Використання MS Excel y BigData	52	258	34	t	55	\N
3856	2	LABORATORY	Використання MS Excel y BigData	93	258	34	t	55	\N
3829	3	LABORATORY	Теорія алгоритмів	52	36	203	f	55	\N
3830	3	LABORATORY	Теорія алгоритмів	84	36	203	f	55	\N
3832	3	LABORATORY	Теорія алгоритмів	53	36	203	f	55	\N
3815	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	53	43	149	f	55	\N
3819	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	54	43	149	f	55	\N
3820	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	87	43	149	f	55	\N
3821	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	32	43	149	f	55	\N
3822	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	92	43	149	f	55	\N
3818	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	56	43	53	f	55	\N
3817	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	57	43	149	f	55	\N
3840	2	LABORATORY	Програмування мовою Python	84	48	185	f	55	\N
3842	2	LABORATORY	Програмування мовою Python	53	48	185	f	55	\N
3816	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	55	43	187	f	55	\N
3874	2	LECTURE	Прикладний функціональний аналіз	51	51	21	t	55	\N
3877	2	LECTURE	Прикладний функціональний аналіз	53	51	21	t	55	\N
3878	2	LECTURE	Прикладний функціональний аналіз	54	51	21	t	55	\N
3879	2	LECTURE	Прикладний функціональний аналіз	87	51	21	t	55	\N
3880	2	LECTURE	Прикладний функціональний аналіз	32	51	21	t	55	\N
3881	2	LECTURE	Прикладний функціональний аналіз	92	51	21	t	55	\N
3890	2	LECTURE	Python для Data Science	51	323	26	t	55	\N
3892	2	LECTURE	Python для Data Science	54	323	26	t	55	\N
3893	2	LECTURE	Python для Data Science	87	323	26	t	55	\N
3894	2	LECTURE	Python для Data Science	32	323	26	t	55	\N
3895	2	LECTURE	Python для Data Science	92	323	26	t	55	\N
3896	2	LECTURE	Python для Data Science	52	323	26	t	55	\N
3897	1	LABORATORY	Python для Data Science	51	323	26	f	55	\N
3898	1	LABORATORY	Python для Data Science	71	323	26	f	55	\N
3899	1	LABORATORY	Python для Data Science	54	323	26	f	55	\N
3900	1	LABORATORY	Python для Data Science	87	323	26	f	55	\N
3901	1	LABORATORY	Python для Data Science	32	323	26	f	55	\N
3902	1	LABORATORY	Python для Data Science	92	323	26	f	55	\N
3903	1	LABORATORY	Python для Data Science	52	323	26	f	55	\N
3904	2	LECTURE	Теорія алгоритмів	51	36	41	t	55	\N
3905	2	LECTURE	Теорія алгоритмів	52	36	41	t	55	\N
3906	2	LECTURE	Теорія алгоритмів	84	36	41	t	55	\N
3907	2	LECTURE	Теорія алгоритмів	93	36	41	t	55	\N
3908	2	LECTURE	Теорія алгоритмів	53	36	41	t	55	\N
3916	2	LECTURE	Інтерпретована динамічна візуальна мова програмування	33	207	79	t	55	\N
3917	2	LECTURE	Інтерпретована динамічна візуальна мова програмування	55	207	79	t	55	\N
3918	2	LECTURE	Інтерпретована динамічна візуальна мова програмування	42	207	79	t	55	\N
3914	2	PRACTICAL	Програмування	5	15	203	f	55	\N
3915	2	PRACTICAL	Програмування	85	15	203	f	55	\N
3919	1	LECTURE	Основи інформаційних технологій	33	53	194	t	55	\N
3921	2	LABORATORY	Основи інформаційних технологій	33	53	194	f	55	\N
3922	2	LABORATORY	Основи інформаційних технологій	56	53	194	f	55	\N
2996	3	PRACTICAL	Математичний аналіз	33	55	105	f	55	\N
3923	2	PRACTICAL	Аналітична геометрія	31	24	50	t	55	\N
3924	2	PRACTICAL	Аналітична геометрія	28	24	50	t	55	\N
3928	3	PRACTICAL	Лінійна алгебра	31	22	47	t	55	\N
3929	3	PRACTICAL	Лінійна алгебра	28	22	47	t	55	\N
3930	3	PRACTICAL	Математичний аналіз	31	55	105	f	55	\N
3931	3	PRACTICAL	Математичний аналіз	28	55	105	f	55	\N
3784	3	LECTURE	Об'єктно-орієнтоване програмування	54	46	71	t	55	\N
3785	3	LECTURE	Об'єктно-орієнтоване програмування	87	46	71	t	55	\N
3786	3	LECTURE	Об'єктно-орієнтоване програмування	32	46	71	t	55	\N
3787	3	LECTURE	Об'єктно-орієнтоване програмування	92	46	71	t	55	\N
3932	2	LECTURE	Бази даних та знань	54	184	34	t	55	\N
3933	2	LECTURE	Бази даних та знань	87	184	34	t	55	\N
3934	2	LECTURE	Бази даних та знань	32	184	34	t	55	\N
3935	2	LECTURE	Бази даних та знань	92	184	34	t	55	\N
3936	3	LABORATORY	Бази даних та знань	54	184	34	f	55	\N
3937	3	LABORATORY	Бази даних та знань	87	184	34	f	55	\N
3938	3	LABORATORY	Бази даних та знань	32	184	34	f	55	\N
3940	2	LECTURE	Психологія (загальна, вікова, педагогічна)	55	52	76	t	55	\N
3941	2	LECTURE	Психологія (загальна, вікова, педагогічна)	56	52	76	t	55	\N
3942	2	LECTURE	Психологія (загальна, вікова, педагогічна)	57	52	76	t	55	\N
3943	2	PRACTICAL	Психологія (загальна, вікова, педагогічна)	55	52	76	f	55	\N
3944	2	PRACTICAL	Психологія (загальна, вікова, педагогічна)	56	52	76	f	55	\N
3945	2	PRACTICAL	Психологія (загальна, вікова, педагогічна)	57	52	76	f	55	\N
3946	2	LECTURE	Дискретна математика	55	17	199	t	55	\N
3947	2	LECTURE	Дискретна математика	56	17	199	t	55	\N
3948	2	LECTURE	Дискретна математика	57	17	199	t	55	\N
3949	1	PRACTICAL	Дискретна математика	55	17	199	f	55	\N
3950	1	PRACTICAL	Дискретна математика	56	17	199	f	55	\N
3951	1	PRACTICAL	Дискретна математика	57	17	199	f	55	\N
3952	2	LECTURE	Об'єктно-орієнтоване програмування	55	46	32	f	55	\N
3954	2	LECTURE	Диференціальні рівняння	53	45	77	t	55	\N
3955	2	LECTURE	Диференціальні рівняння	54	45	77	t	55	\N
3956	2	LECTURE	Диференціальні рівняння	87	45	77	t	55	\N
3957	2	LECTURE	Диференціальні рівняння	32	45	77	t	55	\N
3958	2	LECTURE	Диференціальні рівняння	92	45	77	t	55	\N
3959	2	LECTURE	Диференціальні рівняння	55	45	77	t	55	\N
3960	2	LECTURE	Диференціальні рівняння	56	45	77	t	55	\N
3961	2	LECTURE	Диференціальні рівняння	57	45	77	t	55	\N
3962	2	LECTURE	Бази даних у навчальному процесі	56	324	34	f	55	\N
3953	2	LABORATORY	Об'єктно-орієнтоване програмування	55	46	32	f	55	\N
3966	2	LECTURE	Створення веб-додатків з використанням фреймворку Django мови Python	36	325	36	t	55	\N
3967	2	LECTURE	Створення веб-додатків з використанням фреймворку Django мови Python	37	325	36	t	55	\N
3968	2	LECTURE	Створення веб-додатків з використанням фреймворку Django мови Python	94	325	36	t	55	\N
3969	2	LECTURE	Створення веб-додатків з використанням фреймворку Django мови Python	95	325	36	t	55	\N
3970	2	LECTURE	Створення веб-додатків з використанням фреймворку Django мови Python	38	325	36	t	55	\N
3939	3	LABORATORY	Бази даних та знань	92	184	63	f	55	\N
3971	2	LECTURE	Створення веб-додатків з використанням фреймворку Django мови Python	39	325	36	t	55	\N
3972	2	LECTURE	Створення веб-додатків з використанням фреймворку Django мови Python	102	325	36	t	55	\N
3973	2	LABORATORY	Створення веб-додатків з використанням фреймворку Django мови Python	36	325	36	f	55	\N
3974	2	LABORATORY	Створення веб-додатків з використанням фреймворку Django мови Python	37	325	36	f	55	\N
3975	2	LABORATORY	Створення веб-додатків з використанням фреймворку Django мови Python	94	325	36	f	55	\N
3976	2	LABORATORY	Створення веб-додатків з використанням фреймворку Django мови Python	95	325	36	f	55	\N
3977	2	LABORATORY	Створення веб-додатків з використанням фреймворку Django мови Python	38	325	36	f	55	\N
3978	2	LABORATORY	Створення веб-додатків з використанням фреймворку Django мови Python	39	325	36	f	55	\N
3979	2	LABORATORY	Створення веб-додатків з використанням фреймворку Django мови Python	102	325	36	f	55	\N
3980	2	LECTURE	Теорія ймовірностей та математична статистика	38	30	40	t	55	\N
3981	2	LECTURE	Теорія ймовірностей та математична статистика	36	30	40	t	55	\N
3982	2	LECTURE	Теорія ймовірностей та математична статистика	37	30	40	t	55	\N
3983	2	LECTURE	Теорія ймовірностей та математична статистика	95	30	40	t	55	\N
3984	2	LECTURE	Теорія ймовірностей та математична статистика	94	30	40	t	55	\N
3985	2	LECTURE	Теорія ймовірностей та математична статистика	39	30	40	t	55	\N
3986	2	LECTURE	Теорія ймовірностей та математична статистика	102	30	40	t	55	\N
3987	2	LECTURE	Теорія ймовірностей та математична статистика	40	30	40	t	55	\N
3988	2	LECTURE	Теорія ймовірностей та математична статистика	103	30	40	t	55	\N
3989	2	LECTURE	Теорія ймовірностей та математична статистика	41	30	40	t	55	\N
3990	3	PRACTICAL	Теорія ймовірностей та математична статистика	38	30	40	f	55	\N
3963	2	LABORATORY	Бази даних у навчальному процесі	56	324	63	f	55	\N
3995	3	PRACTICAL	Теорія ймовірностей та математична статистика	39	30	40	f	55	\N
3996	3	PRACTICAL	Теорія ймовірностей та математична статистика	102	30	40	f	55	\N
4000	1	LECTURE	Сучасні СУБД	38	35	34	t	55	\N
4001	1	LECTURE	Сучасні СУБД	36	35	34	t	55	\N
4002	1	LECTURE	Сучасні СУБД	37	35	34	t	55	\N
4003	1	LECTURE	Сучасні СУБД	95	35	34	t	55	\N
4004	1	LECTURE	Сучасні СУБД	94	35	34	t	55	\N
4005	1	LECTURE	Сучасні СУБД	39	35	34	t	55	\N
4006	1	LECTURE	Сучасні СУБД	102	35	34	t	55	\N
4007	2	LABORATORY	Сучасні СУБД	38	35	34	f	55	\N
4008	2	LABORATORY	Сучасні СУБД	36	35	34	f	55	\N
3964	4	LECTURE	Математичний аналіз2	57	54	21	f	55	\N
3965	4	PRACTICAL	Математичний аналіз2	57	54	28	f	55	\N
4009	2	LABORATORY	Сучасні СУБД	37	35	34	f	55	\N
4010	2	LABORATORY	Сучасні СУБД	95	35	34	f	55	\N
4011	2	LABORATORY	Сучасні СУБД	94	35	34	f	55	\N
4012	2	LABORATORY	Сучасні СУБД	39	35	34	f	55	\N
4013	2	LABORATORY	Сучасні СУБД	102	35	34	f	55	\N
4014	2	LECTURE	Комп'ютерна математика	40	42	60	t	55	\N
4015	2	LECTURE	Комп'ютерна математика	103	42	60	t	55	\N
4016	2	LECTURE	Комп'ютерна математика	41	42	60	t	55	\N
4017	1	LABORATORY	Комп'ютерна математика	40	42	60	f	55	\N
4020	2	LECTURE	Бази даних та інформаційні системи	42	326	34	f	55	\N
4021	2	LABORATORY	Бази даних та інформаційні системи	42	326	34	f	55	\N
2633	2	LECTURE	Архітектура обчислювальних систем	30	173	60	t	53	\N
2634	2	LECTURE	Архітектура обчислювальних систем	29	173	60	t	53	\N
2635	2	LECTURE	Архітектура обчислювальних систем	5	173	60	t	53	\N
2636	2	LECTURE	Архітектура обчислювальних систем	85	173	60	t	53	\N
2637	2	LECTURE	Архітектура обчислювальних систем	86	173	60	t	53	\N
2638	2	LECTURE	Архітектура обчислювальних систем	32	173	60	t	53	\N
2639	2	LECTURE	Архітектура обчислювальних систем	27	173	60	t	53	\N
2640	2	LECTURE	Архітектура обчислювальних систем	26	173	60	t	53	\N
2641	2	LECTURE	Архітектура обчислювальних систем	33	173	60	t	53	\N
2659	3	PRACTICAL	Математичний аналіз	30	55	28	t	53	\N
2660	3	PRACTICAL	Математичний аналіз	29	55	28	t	53	\N
2770	2	LABORATORY	Програмування	33	15	32	f	53	\N
2771	2	LABORATORY	Програмування	28	15	32	f	53	\N
2772	4	LECTURE	Математичний аналіз1	33	16	20	t	53	\N
2773	4	LECTURE	Математичний аналіз1	31	16	20	t	53	\N
2774	4	LECTURE	Математичний аналіз1	28	16	20	t	53	\N
2775	3	PRACTICAL	Математичний аналіз1	33	16	28	f	53	\N
2776	3	PRACTICAL	Математичний аналіз1	31	16	28	f	53	\N
2777	2	PRACTICAL	Англійська мова	31	132	96	f	53	\N
2778	2	LABORATORY	Програмування	31	15	64	f	53	\N
2779	1	LECTURE	Вступ до спеціальності	31	25	45	t	53	\N
2780	1	LECTURE	Вступ до спеціальності	28	25	45	t	53	\N
2786	1	PRACTICAL	Програмування	28	15	32	f	53	\N
3993	3	PRACTICAL	Теорія ймовірностей та математична статистика	95	30	35	f	55	\N
3992	3	PRACTICAL	Теорія ймовірностей та математична статистика	37	30	35	f	55	\N
4018	1	LABORATORY	Комп'ютерна математика	103	42	60	t	55	\N
3997	3	PRACTICAL	Теорія ймовірностей та математична статистика	40	30	40	t	55	\N
2787	2	PRACTICAL	Англійська мова	28	132	161	f	53	\N
2642	2	LABORATORY	Архітектура комп'ютерів	30	170	60	f	53	\N
2643	2	LABORATORY	Архітектура комп'ютерів	29	170	60	f	53	\N
2644	2	LABORATORY	Архітектура комп'ютерів	5	170	60	f	53	\N
2645	2	LABORATORY	Архітектура комп'ютерів	85	170	60	f	53	\N
2646	2	LABORATORY	Архітектура комп'ютерів	86	170	60	f	53	\N
2647	2	LABORATORY	Архітектура комп'ютерів	32	170	60	f	53	\N
2648	2	LABORATORY	Архітектура комп'ютерів	27	170	60	f	53	\N
2649	2	LABORATORY	Архітектура комп'ютерів	26	170	60	f	53	\N
2735	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	27	169	183	t	53	\N
2736	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	26	169	183	t	53	\N
2650	1	LABORATORY	Архітектура комп'ютерів	33	170	60	f	53	\N
2760	2	LECTURE	Лінійна алгебра	33	22	46	t	53	\N
2761	2	LECTURE	Лінійна алгебра	31	22	46	t	53	\N
2762	2	LECTURE	Лінійна алгебра	28	22	46	t	53	\N
2763	3	PRACTICAL	Лінійна алгебра	33	22	47	t	53	\N
2764	3	PRACTICAL	Лінійна алгебра	31	22	47	t	53	\N
2631	2	PRACTICAL	Алгебра і геометрія	30	14	50	t	53	\N
2632	2	PRACTICAL	Алгебра і геометрія	29	14	50	t	53	\N
2672	2	PRACTICAL	Англійська мова	30	132	53	f	53	\N
2673	2	PRACTICAL	Англійська мова	29	132	53	f	53	\N
2698	2	LABORATORY	Програмування	30	15	42	f	53	\N
2708	2	LABORATORY	Програмування	29	15	42	t	53	\N
2709	2	LABORATORY	Програмування	5	15	42	t	53	\N
2716	3	PRACTICAL	Математичний аналіз	86	55	105	t	53	\N
2717	3	PRACTICAL	Математичний аналіз	32	55	105	t	53	\N
2718	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	86	169	102	t	53	\N
2719	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	32	169	102	t	53	\N
2722	2	LABORATORY	Програмування	86	15	33	f	53	\N
2723	2	PRACTICAL	Програмування	86	15	33	t	53	\N
2724	2	PRACTICAL	Програмування	32	15	33	t	53	\N
2725	2	LECTURE	Алгебра і геометрія	27	14	43	t	53	\N
2726	2	LECTURE	Алгебра і геометрія	30	14	43	t	53	\N
2727	2	LECTURE	Алгебра і геометрія	29	14	43	t	53	\N
2728	2	LECTURE	Алгебра і геометрія	5	14	43	t	53	\N
2729	2	LECTURE	Алгебра і геометрія	85	14	43	t	53	\N
2730	2	LECTURE	Алгебра і геометрія	86	14	43	t	53	\N
2731	2	LECTURE	Алгебра і геометрія	32	14	43	t	53	\N
2732	2	LECTURE	Алгебра і геометрія	26	14	43	t	53	\N
2737	2	PRACTICAL	Англійська мова	27	132	149	f	53	\N
2738	2	PRACTICAL	Англійська мова	26	132	53	f	53	\N
2739	2	LECTURE	Програмування	27	15	60	t	53	\N
2740	2	LECTURE	Програмування	26	15	60	t	53	\N
2741	2	PRACTICAL	Програмування	27	15	60	t	53	\N
2742	2	PRACTICAL	Програмування	26	15	60	t	53	\N
2758	2	PRACTICAL	Аналітична геометрія	33	24	44	t	53	\N
2759	2	PRACTICAL	Аналітична геометрія	31	24	44	t	53	\N
2651	2	LECTURE	Математичний аналіз	30	55	21	t	53	\N
2652	2	LECTURE	Математичний аналіз	29	55	21	t	53	\N
2653	2	LECTURE	Математичний аналіз	5	55	21	t	53	\N
2654	2	LECTURE	Математичний аналіз	85	55	21	t	53	\N
2655	2	LECTURE	Математичний аналіз	86	55	21	t	53	\N
2656	2	LECTURE	Математичний аналіз	32	55	21	t	53	\N
2657	2	LECTURE	Математичний аналіз	27	55	21	t	53	\N
2658	2	LECTURE	Математичний аналіз	26	55	21	t	53	\N
2662	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	30	169	111	t	53	\N
2663	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	29	169	111	t	53	\N
2664	2	LECTURE	Програмування	30	15	41	t	53	\N
2665	2	LECTURE	Програмування	29	15	41	t	53	\N
2666	2	LECTURE	Програмування	5	15	41	t	53	\N
2667	2	LECTURE	Програмування	85	15	41	t	53	\N
2668	2	LECTURE	Програмування	86	15	41	t	53	\N
2669	2	LECTURE	Програмування	32	15	41	t	53	\N
2765	2	LECTURE	Програмування	33	15	32	t	53	\N
2766	2	LECTURE	Програмування	31	15	32	t	53	\N
2767	2	LECTURE	Програмування	28	15	32	t	53	\N
2781	1	PRACTICAL	Вступ до спеціальності	31	25	45	t	53	\N
2782	1	PRACTICAL	Вступ до спеціальності	28	25	45	t	53	\N
2783	2	PRACTICAL	Аналітична геометрія	28	24	44	f	53	\N
2670	2	PRACTICAL	Програмування	30	15	42	t	53	\N
2671	2	PRACTICAL	Програмування	29	15	42	t	53	\N
2674	1	LECTURE	Олімпіадні задачі з інформаційних технологій	30	175	33	t	53	\N
2675	1	LECTURE	Олімпіадні задачі з інформаційних технологій	29	175	33	t	53	\N
2676	1	LECTURE	Олімпіадні задачі з інформаційних технологій	5	175	33	t	53	\N
2677	1	LECTURE	Олімпіадні задачі з інформаційних технологій	85	175	33	t	53	\N
2678	1	LECTURE	Олімпіадні задачі з інформаційних технологій	86	175	33	t	53	\N
2679	1	LECTURE	Олімпіадні задачі з інформаційних технологій	32	175	33	t	53	\N
2680	2	LABORATORY	Олімпіадні задачі з інформаційних технологій	30	175	33	f	53	\N
2681	2	LABORATORY	Олімпіадні задачі з інформаційних технологій	29	175	33	f	53	\N
2682	2	LABORATORY	Олімпіадні задачі з інформаційних технологій	5	175	33	f	53	\N
2683	2	LABORATORY	Олімпіадні задачі з інформаційних технологій	85	175	33	f	53	\N
2684	2	LABORATORY	Олімпіадні задачі з інформаційних технологій	86	175	33	f	53	\N
2685	2	LABORATORY	Олімпіадні задачі з інформаційних технологій	32	175	33	f	53	\N
2692	2	LABORATORY	Пакети прикладних програм	30	174	63	f	53	\N
2693	2	LABORATORY	Пакети прикладних програм	29	174	63	f	53	\N
2694	2	LABORATORY	Пакети прикладних програм	5	174	63	f	53	\N
2695	2	LABORATORY	Пакети прикладних програм	85	174	63	f	53	\N
2696	2	LABORATORY	Пакети прикладних програм	86	174	63	f	53	\N
2697	2	LABORATORY	Пакети прикладних програм	32	174	63	f	53	\N
2720	2	PRACTICAL	Англійська мова	86	132	149	t	53	\N
2721	2	PRACTICAL	Англійська мова	32	132	149	t	53	\N
2733	2	PRACTICAL	Алгебра і геометрія	27	14	45	t	53	\N
2734	2	PRACTICAL	Алгебра і геометрія	26	14	45	t	53	\N
2768	1	PRACTICAL	Програмування	33	15	32	t	53	\N
2769	1	PRACTICAL	Програмування	31	15	32	t	53	\N
2784	3	PRACTICAL	Лінійна алгебра	28	22	47	f	53	\N
2785	3	PRACTICAL	Математичний аналіз1	28	16	105	f	53	\N
2700	2	PRACTICAL	Алгебра і геометрія*	5	259	50	t	53	\N
2701	2	PRACTICAL	Алгебра і геометрія*	85	259	50	t	53	\N
2704	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	5	169	102	t	53	\N
2705	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	85	169	102	t	53	\N
2710	2	PRACTICAL	Програмування	5	15	70	t	53	\N
2711	2	PRACTICAL	Програмування	85	15	70	t	53	\N
2712	2	LABORATORY	Програмування	85	15	70	f	53	\N
2713	2	LABORATORY	Програмування	32	15	70	f	53	\N
2702	3	PRACTICAL	Математичний аналіз*	5	103	28	t	53	\N
2703	3	PRACTICAL	Математичний аналіз*	85	103	28	t	53	\N
2714	2	PRACTICAL	Алгебра і геометрія	86	14	45	t	53	\N
2715	2	PRACTICAL	Алгебра і геометрія	32	14	45	t	53	\N
2745	3	PRACTICAL	Математичний аналіз*	27	103	105	t	53	\N
2746	3	PRACTICAL	Математичний аналіз*	26	103	105	t	53	\N
2747	1	LECTURE	Математична логіка та теорія алгоритмів	27	171	52	t	53	\N
2748	1	LECTURE	Математична логіка та теорія алгоритмів	26	171	52	t	53	\N
2706	2	PRACTICAL	Англійська мова	5	132	161	t	53	\N
2707	2	PRACTICAL	Англійська мова	85	132	161	t	53	\N
2749	2	PRACTICAL	Математична логіка та теорія алгоритмів	27	171	52	t	53	\N
2750	2	PRACTICAL	Математична логіка та теорія алгоритмів	26	171	52	t	53	\N
2751	2	PRACTICAL	Англійська мова	33	132	90	f	53	\N
2752	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	33	169	183	f	53	\N
2753	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	31	169	183	f	53	\N
2754	2	PRACTICAL	Українська  мова (за професійним спрямуванням)	28	169	183	f	53	\N
2755	2	LECTURE	Аналітична геометрія	33	24	44	t	53	\N
2756	2	LECTURE	Аналітична геометрія	31	24	44	t	53	\N
2757	2	LECTURE	Аналітична геометрія	28	24	44	t	53	\N
2788	1	LECTURE	Пакети прикладних програм	86	174	63	t	53	\N
2789	1	LECTURE	Пакети прикладних програм	30	174	63	t	53	\N
2790	1	LECTURE	Пакети прикладних програм	29	174	63	t	53	\N
2791	1	LECTURE	Пакети прикладних програм	5	174	63	t	53	\N
2792	1	LECTURE	Пакети прикладних програм	85	174	63	t	53	\N
2793	1	LECTURE	Пакети прикладних програм	32	174	63	t	53	\N
2794	1	LECTURE	Пакети прикладних програм	28	174	63	t	53	\N
2795	2	LABORATORY	Пакети прикладних програм	28	174	63	f	53	\N
2945	2	LABORATORY	Програмування	27	15	19	f	55	\N
4022	2	LECTURE	Методика викладання математики	42	63	46	t	55	\N
4023	2	LECTURE	Методика викладання математики	43	63	46	t	55	\N
4024	2	LECTURE	Методика викладання математики	44	63	46	t	55	\N
4025	2	PRACTICAL	Методика викладання математики	42	63	46	t	55	\N
4026	2	PRACTICAL	Методика викладання математики	43	63	46	t	55	\N
4027	2	PRACTICAL	Методика викладання математики	44	63	46	t	55	\N
4033	2	PRACTICAL	Теорія міри та інтеграла	44	59	105	f	55	\N
4032	3	LECTURE	Теорія міри та інтеграла	44	59	20	f	55	\N
3653	2	LECTURE	Алгебра і геометрія	30	14	43	t	55	\N
3654	2	LECTURE	Алгебра і геометрія	29	14	43	t	55	\N
3655	2	LECTURE	Алгебра і геометрія	5	14	43	t	55	\N
3656	2	LECTURE	Алгебра і геометрія	85	14	43	t	55	\N
3657	2	LECTURE	Алгебра і геометрія	86	14	43	t	55	\N
3658	2	LECTURE	Алгебра і геометрія	27	14	43	t	55	\N
3659	2	LECTURE	Алгебра і геометрія	26	14	43	t	55	\N
3660	2	LECTURE	Алгебра і геометрія	33	14	43	t	55	\N
3651	1	PRACTICAL	Актуальні питання історії та культури України	30	257	51	t	55	\N
3652	1	PRACTICAL	Актуальні питання історії та культури України	29	257	51	t	55	\N
3661	2	LECTURE	Математичний аналіз	30	55	22	t	55	\N
3662	2	LECTURE	Математичний аналіз	29	55	22	t	55	\N
3663	2	LECTURE	Математичний аналіз	5	55	22	t	55	\N
3664	2	LECTURE	Математичний аналіз	85	55	22	t	55	\N
3675	2	LECTURE	Дискретна математика	27	17	52	t	55	\N
3676	2	LECTURE	Дискретна математика	26	17	52	t	55	\N
3677	2	PRACTICAL	Дискретна математика	30	17	52	f	55	\N
3665	2	LECTURE	Математичний аналіз	86	55	22	t	55	\N
3666	2	LECTURE	Математичний аналіз	27	55	22	t	55	\N
3670	2	LECTURE	Дискретна математика	30	17	52	t	55	\N
3671	2	LECTURE	Дискретна математика	29	17	52	t	55	\N
3672	2	LECTURE	Дискретна математика	5	17	52	t	55	\N
3673	2	LECTURE	Дискретна математика	85	17	52	t	55	\N
3674	2	LECTURE	Дискретна математика	86	17	52	t	55	\N
3678	2	PRACTICAL	Дискретна математика	29	17	52	f	55	\N
3679	2	PRACTICAL	Дискретна математика	5	17	52	f	55	\N
3680	2	PRACTICAL	Дискретна математика	85	17	52	f	55	\N
3681	2	PRACTICAL	Дискретна математика	86	17	52	f	55	\N
3682	2	PRACTICAL	Дискретна математика	27	17	52	f	55	\N
3683	2	PRACTICAL	Дискретна математика	26	17	52	f	55	\N
3684	1	PRACTICAL	Актуальні питання історії та культури України	5	257	51	f	55	\N
3685	1	PRACTICAL	Актуальні питання історії та культури України	85	257	51	f	55	\N
3667	2	LECTURE	Математичний аналіз	26	55	22	t	55	\N
3686	1	PRACTICAL	Актуальні питання історії та культури України	86	257	51	f	55	\N
3687	1	PRACTICAL	Актуальні питання історії та культури України	27	257	51	f	55	\N
3688	1	PRACTICAL	Актуальні питання історії та культури України	26	257	51	f	55	\N
3689	1	PRACTICAL	Актуальні питання історії та культури України	33	257	51	f	55	\N
3690	1	PRACTICAL	Актуальні питання історії та культури України	31	257	51	f	55	\N
3691	1	PRACTICAL	Актуальні питання історії та культури України	28	257	51	f	55	\N
3701	2	PRACTICAL	Алгебра і геометрія	86	14	204	f	55	\N
3704	2	PRACTICAL	Алгебра і геометрія	33	14	204	f	55	\N
3715	2	LABORATORY	Інтерпретована динамічна візуальна мова програмування	33	207	79	f	55	\N
3702	2	PRACTICAL	Алгебра і геометрія	27	14	43	f	55	\N
4034	2	LECTURE	Інформаційні системи обліку та логістика	45	70	73	t	55	\N
4035	2	LECTURE	Інформаційні системи обліку та логістика	46	70	73	t	55	\N
3697	2	PRACTICAL	Алгебра і геометрія	30	14	50	f	55	\N
3698	2	PRACTICAL	Алгебра і геометрія	29	14	50	f	55	\N
3699	2	PRACTICAL	Алгебра і геометрія	5	14	50	f	55	\N
3700	2	PRACTICAL	Алгебра і геометрія	85	14	50	f	55	\N
4036	2	LECTURE	Інформаційні системи обліку та логістика	104	70	73	t	55	\N
4037	2	LECTURE	Інформаційні системи обліку та логістика	49	70	73	t	55	\N
4038	2	LECTURE	Інформаційні системи обліку та логістика	50	70	73	t	55	\N
3708	2	LECTURE	Математичний аналіз	33	55	26	t	55	\N
3709	2	LECTURE	Математичний аналіз	31	55	26	t	55	\N
3710	2	LECTURE	Математичний аналіз	28	55	26	t	55	\N
3711	2	LECTURE	Математичний аналіз*	33	103	26	t	55	\N
3712	2	LECTURE	Математичний аналіз*	31	103	26	t	55	\N
3713	2	LECTURE	Математичний аналіз*	28	103	26	t	55	\N
3718	2	LECTURE	Аналітична геометрія	31	24	44	t	55	\N
3719	2	LECTURE	Аналітична геометрія	28	24	44	t	55	\N
3720	2	LECTURE	Лінійна алгебра	31	22	46	t	55	\N
3721	2	LECTURE	Лінійна алгебра	28	22	46	t	55	\N
3722	1	LECTURE	Вступ до спеціальності	31	25	45	t	55	\N
3723	1	LECTURE	Вступ до спеціальності	28	25	45	t	55	\N
3724	1	PRACTICAL	Вступ до спеціальності	31	25	45	t	55	\N
3725	1	PRACTICAL	Вступ до спеціальності	28	25	45	t	55	\N
4039	2	LABORATORY	Інформаційні системи обліку та логістика	45	70	73	f	55	\N
4040	2	LABORATORY	Інформаційні системи обліку та логістика	46	70	73	f	55	\N
4044	1	LECTURE	Системи та методи прийняття рішень	45	69	40	t	55	\N
4045	1	LECTURE	Системи та методи прийняття рішень	46	69	40	t	55	\N
4046	1	LECTURE	Системи та методи прийняття рішень	104	69	40	t	55	\N
4047	1	LECTURE	Системи та методи прийняття рішень	49	69	40	t	55	\N
4048	1	LECTURE	Системи та методи прийняття рішень	50	69	40	t	55	\N
4049	2	LABORATORY	Системи та методи прийняття рішень	45	69	40	f	55	\N
4050	2	LABORATORY	Системи та методи прийняття рішень	46	69	40	f	55	\N
4054	2	LECTURE	Платформи корпоративних інформаційних систем	68	67	66	t	55	\N
2872	2	PRACTICAL	Англійська мова	30	132	97	f	55	\N
2881	2	LABORATORY	Програмування	30	15	33	f	55	
2874	2	PRACTICAL	Програмування	30	15	33	f	55	\N
2875	2	PRACTICAL	Програмування	29	15	33	f	55	\N
3703	2	PRACTICAL	Алгебра і геометрія	26	14	43	f	55	\N
2932	2	PRACTICAL	Англійська мова	27	132	149	f	55	\N
4060	2	LECTURE	Програмування	27	15	19	t	55	\N
4061	2	LECTURE	Програмування	26	15	19	t	55	\N
4062	2	PRACTICAL	Програмування	27	15	19	t	55	\N
4063	2	PRACTICAL	Програмування	26	15	19	t	55	\N
3920	1	LECTURE	Основи інформаційних технологій	56	53	194	t	55	\N
3793	2	LABORATORY	Об'єктно-орієнтоване програмування	54	46	71	f	55	\N
4064	1	PRACTICAL	Прикладний функціональний аналіз	92	51	21	t	55	\N
4065	1	PRACTICAL	Прикладний функціональний аналіз	51	51	21	t	55	\N
4066	1	PRACTICAL	Прикладний функціональний аналіз	53	51	21	t	55	\N
4067	1	PRACTICAL	Прикладний функціональний аналіз	54	51	21	t	55	\N
4068	1	PRACTICAL	Прикладний функціональний аналіз	87	51	21	t	55	\N
4069	1	PRACTICAL	Прикладний функціональний аналіз	32	51	21	t	55	\N
4070	2	LECTURE	Алгоритми і структури даних	54	44	190	t	55	\N
4071	2	LECTURE	Алгоритми і структури даних	87	44	190	t	55	\N
4072	2	LECTURE	Алгоритми і структури даних	32	44	190	t	55	\N
4073	2	LECTURE	Алгоритми і структури даних	92	44	190	t	55	\N
4074	2	LABORATORY	Алгоритми і структури даних	54	44	190	f	55	\N
4075	2	LABORATORY	Алгоритми і структури даних	87	44	190	f	55	\N
4076	2	LABORATORY	Алгоритми і структури даних	32	44	190	f	55	\N
4077	2	LABORATORY	Алгоритми і структури даних	92	44	190	f	55	\N
4078	2	LABORATORY	Інтерпретована динамічна візуальна мова програмування	55	207	79	f	55	\N
4079	2	LECTURE	Алгебра і теорія чисел	56	56	46	t	55	\N
4080	2	LECTURE	Алгебра і теорія чисел	57	56	46	t	55	\N
4081	2	PRACTICAL	Алгебра і теорія чисел	56	56	46	t	55	\N
4082	2	PRACTICAL	Алгебра і теорія чисел	57	56	46	t	55	\N
3991	3	PRACTICAL	Теорія ймовірностей та математична статистика	36	30	35	f	55	\N
4083	2	LECTURE	Комп'ютерне моделювання жорстких процесів та систем	36	328	30	t	55	\N
4084	2	LECTURE	Комп'ютерне моделювання жорстких процесів та систем	37	328	30	t	55	\N
4085	2	LECTURE	Комп'ютерне моделювання жорстких процесів та систем	95	328	30	t	55	\N
4042	2	LABORATORY	Інформаційні системи обліку та логістика	49	70	73	t	55	\N
3814	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	93	43	161	f	55	\N
4053	2	LABORATORY	Системи та методи прийняття рішень	50	69	40	t	55	\N
4052	2	LABORATORY	Системи та методи прийняття рішень	49	69	40	t	55	\N
4086	2	LECTURE	Комп'ютерне моделювання жорстких процесів та систем	94	328	30	t	55	\N
4087	2	LECTURE	Комп'ютерне моделювання жорстких процесів та систем	38	328	30	t	55	\N
4088	2	LECTURE	Комп'ютерне моделювання жорстких процесів та систем	39	328	30	t	55	\N
4089	2	LECTURE	Комп'ютерне моделювання жорстких процесів та систем	102	328	30	t	55	\N
4092	2	LABORATORY	Комп'ютерне моделювання жорстких процесів та систем	95	328	63	f	55	\N
4093	2	LABORATORY	Комп'ютерне моделювання жорстких процесів та систем	94	328	63	f	55	\N
4094	2	LABORATORY	Комп'ютерне моделювання жорстких процесів та систем	38	328	63	f	55	\N
4095	2	LABORATORY	Комп'ютерне моделювання жорстких процесів та систем	39	328	63	f	55	\N
4096	2	LABORATORY	Комп'ютерне моделювання жорстких процесів та систем	102	328	63	f	55	\N
4106	2	LABORATORY	Операційні системи	95	27	189	f	55	\N
4097	1	LECTURE	Операційні системи	36	27	42	t	55	\N
4098	1	LECTURE	Операційні системи	37	27	42	t	55	\N
4099	1	LECTURE	Операційні системи	95	27	42	t	55	\N
4100	1	LECTURE	Операційні системи	94	27	42	t	55	\N
4101	1	LECTURE	Операційні системи	38	27	42	t	55	\N
4102	1	LECTURE	Операційні системи	39	27	42	t	55	\N
4103	1	LECTURE	Операційні системи	102	27	42	t	55	\N
4104	2	LABORATORY	Операційні системи	36	27	42	f	55	\N
4105	2	LABORATORY	Операційні системи	37	27	42	f	55	\N
4118	1	LECTURE	Програмування та підтримка Веб-застосунків	36	198	42	t	55	\N
4119	1	LECTURE	Програмування та підтримка Веб-застосунків	37	198	42	t	55	\N
4120	1	LECTURE	Програмування та підтримка Веб-застосунків	95	198	42	t	55	\N
4121	1	LECTURE	Програмування та підтримка Веб-застосунків	94	198	42	t	55	\N
4122	1	LECTURE	Програмування та підтримка Веб-застосунків	38	198	42	t	55	\N
4123	1	LECTURE	Програмування та підтримка Веб-застосунків	39	198	42	t	55	\N
4124	1	LECTURE	Програмування та підтримка Веб-застосунків	102	198	42	t	55	\N
4125	1	LECTURE	Програмування та підтримка Веб-застосунків	42	198	42	t	55	\N
4129	2	LABORATORY	Програмування та підтримка Веб-застосунків	95	198	42	f	55	\N
4130	2	LABORATORY	Програмування та підтримка Веб-застосунків	94	198	42	f	55	\N
4127	2	LABORATORY	Програмування та підтримка Веб-застосунків	36	198	107	f	55	\N
4128	2	LABORATORY	Програмування та підтримка Веб-застосунків	37	198	107	f	55	\N
4091	2	LABORATORY	Комп'ютерне моделювання жорстких процесів та систем	37	328	30	f	55	\N
4107	2	LABORATORY	Операційні системи	94	27	189	f	55	\N
4108	2	LABORATORY	Операційні системи	38	27	189	f	55	\N
4109	2	LABORATORY	Операційні системи	39	27	189	f	55	\N
4110	2	LABORATORY	Операційні системи	102	27	189	f	55	\N
4134	2	LABORATORY	Програмування та підтримка Веб-застосунків	42	198	107	f	55	\N
4111	2	PRACTICAL	Професійна іноземна мова	36	28	53	f	55	\N
4112	2	PRACTICAL	Професійна іноземна мова	37	28	53	f	55	\N
4113	2	PRACTICAL	Професійна іноземна мова	95	28	161	f	55	\N
4114	2	PRACTICAL	Професійна іноземна мова	94	28	161	f	55	\N
4115	2	PRACTICAL	Професійна іноземна мова	38	28	91	f	55	\N
4116	2	PRACTICAL	Професійна іноземна мова	39	28	91	f	55	\N
4117	3	PRACTICAL	Професійна іноземна мова	102	28	91	f	55	\N
4136	1	LECTURE	Поглиблена 3D графіка	36	181	42	t	55	\N
4137	1	LECTURE	Поглиблена 3D графіка	37	181	42	t	55	\N
4138	1	LECTURE	Поглиблена 3D графіка	95	181	42	t	55	\N
4139	1	LECTURE	Поглиблена 3D графіка	94	181	42	t	55	\N
4140	1	LECTURE	Поглиблена 3D графіка	38	181	42	t	55	\N
4141	1	LECTURE	Поглиблена 3D графіка	39	181	42	t	55	\N
4142	1	LECTURE	Поглиблена 3D графіка	102	181	42	t	55	\N
4143	2	LABORATORY	Поглиблена 3D графіка	36	181	42	f	55	\N
4144	2	LABORATORY	Поглиблена 3D графіка	37	181	42	f	55	\N
4145	2	LABORATORY	Поглиблена 3D графіка	95	181	42	f	55	\N
4146	2	LABORATORY	Поглиблена 3D графіка	94	181	42	f	55	\N
4147	2	LABORATORY	Поглиблена 3D графіка	38	181	42	f	55	\N
4148	2	LABORATORY	Поглиблена 3D графіка	39	181	42	f	55	\N
4149	2	LABORATORY	Поглиблена 3D графіка	102	181	42	f	55	\N
4150	2	LECTURE	Технології програмування на Java	36	32	62	t	55	\N
4151	2	LECTURE	Технології програмування на Java	37	32	62	t	55	\N
4152	2	LECTURE	Технології програмування на Java	95	32	62	t	55	\N
4153	2	LECTURE	Технології програмування на Java	94	32	62	t	55	\N
4154	2	LECTURE	Технології програмування на Java	38	32	62	t	55	\N
4155	2	LECTURE	Технології програмування на Java	39	32	62	t	55	\N
4156	2	LECTURE	Технології програмування на Java	102	32	62	t	55	\N
4157	2	LECTURE	Технології програмування на Java	40	32	62	t	55	\N
4158	2	LECTURE	Технології програмування на Java	103	32	62	t	55	\N
4159	2	LECTURE	Технології програмування на Java	41	32	62	t	55	\N
4160	2	LABORATORY	Технології програмування на Java	36	32	62	f	55	\N
4161	2	LABORATORY	Технології програмування на Java	37	32	62	f	55	\N
4162	2	LABORATORY	Технології програмування на Java	95	32	62	f	55	\N
4163	2	LABORATORY	Технології програмування на Java	94	32	62	f	55	\N
4164	2	LABORATORY	Технології програмування на Java	38	32	62	f	55	\N
4165	2	LABORATORY	Технології програмування на Java	39	32	62	f	55	\N
4166	2	LABORATORY	Технології програмування на Java	102	32	62	f	55	\N
4167	2	LABORATORY	Технології програмування на Java	40	32	62	f	55	\N
4181	2	LABORATORY	Основи штучного інтелекту	38	329	32	f	55	\N
4182	2	LABORATORY	Основи штучного інтелекту	39	329	32	f	55	\N
4183	2	LABORATORY	Основи штучного інтелекту	102	329	32	f	55	\N
4184	2	LECTURE	Основи теорії систем	39	37	64	t	55	\N
4185	2	LECTURE	Основи теорії систем	102	37	64	t	55	\N
4186	2	PRACTICAL	Основи теорії систем	39	37	64	t	55	\N
4187	2	PRACTICAL	Основи теорії систем	102	37	64	t	55	\N
4188	2	LECTURE	Числові методи	40	39	65	t	55	\N
4168	2	LABORATORY	Технології програмування на Java	103	32	62	t	55	\N
4179	2	LABORATORY	Основи штучного інтелекту	95	329	208	f	55	\N
4170	2	LECTURE	Основи штучного інтелекту	36	329	32	t	55	\N
4180	2	LABORATORY	Основи штучного інтелекту	94	329	208	f	55	\N
4177	2	LABORATORY	Основи штучного інтелекту	36	329	208	f	55	\N
4178	2	LABORATORY	Основи штучного інтелекту	37	329	208	f	55	\N
4169	2	LABORATORY	Технології програмування на Java	41	32	62	t	55	\N
4189	2	LECTURE	Числові методи	103	39	65	t	55	\N
4190	2	LECTURE	Числові методи	41	39	65	t	55	\N
4191	2	LABORATORY	Числові методи	40	39	75	f	55	\N
4194	2	LECTURE	Математична теорія ризиків	40	41	66	t	55	\N
4195	2	LECTURE	Математична теорія ризиків	103	41	66	t	55	\N
4196	2	LECTURE	Математична теорія ризиків	41	41	66	t	55	\N
4197	2	LABORATORY	Математична теорія ризиків	40	41	66	f	55	\N
4200	2	LECTURE	Управління проектами	40	331	67	t	55	\N
4201	2	LECTURE	Управління проектами	103	331	67	t	55	\N
4202	2	LECTURE	Управління проектами	41	331	67	t	55	\N
4203	1	LABORATORY	Управління проектами	40	331	67	f	55	\N
4206	2	LECTURE	Web-дизайн	40	205	195	t	55	\N
4207	2	LECTURE	Web-дизайн	103	205	195	t	55	\N
4208	2	LECTURE	Web-дизайн	41	205	195	t	55	\N
4029	1	LECTURE	Здоров'язбережувальні технології та домедична допомога	43	332	206	f	55	\N
4224	3	LECTURE	Комплексний аналіз	43	58	20	t	55	\N
4225	3	LECTURE	Комплексний аналіз	44	58	20	t	55	\N
4226	2	PRACTICAL	Комплексний аналіз	43	58	20	t	55	\N
4215	2	LABORATORY	Інтерпретована динамічна візуальна мова програмування	42	207	79	f	55	\N
4218	1	LECTURE	Операційні системи	42	27	42	f	55	\N
4220	1	LECTURE	Хмарні технології	42	333	77	t	55	\N
4221	1	LECTURE	Хмарні технології	72	333	77	t	55	\N
4222	1	PRACTICAL	Хмарні технології	42	333	77	t	55	\N
4223	1	PRACTICAL	Хмарні технології	72	333	77	t	55	\N
4234	1	LECTURE	Вибрані питання геометрії (основна школа)	71	335	44	f	55	\N
4028	2	PRACTICAL	Здоров'язбережувальні технології та домедична допомога	42	332	206	f	55	\N
4030	1	LECTURE	Здоров'язбережувальні технології та домедична допомога	42	332	206	f	55	\N
4031	2	PRACTICAL	Здоров'язбережувальні технології та домедична допомога	43	332	206	f	55	\N
4227	2	PRACTICAL	Комплексний аналіз	44	58	20	t	55	\N
4228	2	LECTURE	Методика викладання інформатики	43	64	45	f	55	\N
4229	2	LABORATORY	Методика викладання інформатики	43	64	45	f	55	\N
4230	1	LECTURE	Елементи теорії чисел у ЗЗСО	43	334	45	f	55	\N
4231	2	PRACTICAL	Елементи теорії чисел у ЗЗСО	43	334	45	f	55	\N
4232	1	LECTURE	Вибрані питання геометрії (основна школа)	43	335	44	f	55	\N
4233	1	LECTURE	Вибрані питання геометрії (основна школа)	73	335	44	f	55	\N
4235	2	PRACTICAL	Вибрані питання геометрії (основна школа)	43	335	44	t	55	\N
4236	2	PRACTICAL	Вибрані питання геометрії (основна школа)	73	335	44	t	55	\N
4237	2	PRACTICAL	Вибрані питання геометрії (основна школа)	71	335	44	t	55	\N
4238	2	LECTURE	Основи інклюзивної освіти	43	264	191	f	55	\N
4219	2	LABORATORY	Операційні системи	42	27	189	f	55	\N
4211	1	LABORATORY	Web-дизайн	41	205	195	t	55	\N
4199	2	LABORATORY	Математична теорія ризиків	41	41	66	t	55	\N
4204	1	LABORATORY	Управління проектами	103	331	67	t	55	\N
4192	2	LABORATORY	Числові методи	103	39	75	t	55	\N
4216	2	LECTURE	Методика викладання інформатики	42	64	205	f	55	\N
4212	2	PRACTICAL	Професійна іноземна мова	40	28	79	t	55	\N
4205	1	LABORATORY	Управління проектами	41	331	67	t	55	\N
4193	2	LABORATORY	Числові методи	41	39	75	t	55	\N
4217	2	LABORATORY	Методика викладання інформатики	42	64	205	f	55	\N
4213	2	PRACTICAL	Професійна іноземна мова	103	28	79	t	55	\N
4239	1	PRACTICAL	Основи інклюзивної освіти	43	264	191	f	55	\N
4240	2	LECTURE	Диференціальна геометрія	44	57	44	f	55	\N
4241	2	PRACTICAL	Диференціальна геометрія	44	57	44	f	55	\N
4135	2	LABORATORY	Поглиблена 3D графіка	44	181	42	f	55	\N
4126	1	LECTURE	Поглиблена 3D графіка	44	181	42	f	55	\N
4242	3	LECTURE	Рівняння математичної фізики	44	60	207	f	55	\N
4243	2	PRACTICAL	Рівняння математичної фізики	44	60	207	f	55	\N
4244	2	LECTURE	Основи штучного інтелекту	44	329	32	f	55	\N
4245	2	LABORATORY	Основи штучного інтелекту	44	329	32	f	55	\N
4246	2	LECTURE	Методи оптимізації та дослідження операцій	45	66	35	t	55	\N
4247	2	LECTURE	Методи оптимізації та дослідження операцій	46	66	35	t	55	\N
4248	2	LECTURE	Методи оптимізації та дослідження операцій	104	66	35	t	55	\N
4249	2	LECTURE	Методи оптимізації та дослідження операцій	49	66	35	t	55	\N
4250	2	LECTURE	Методи оптимізації та дослідження операцій	50	66	35	t	55	\N
4251	1	PRACTICAL	Методи оптимізації та дослідження операцій	45	66	35	f	55	\N
4252	1	PRACTICAL	Методи оптимізації та дослідження операцій	46	66	35	f	55	\N
4267	2	LECTURE	Платформи корпоративних інформаційних систем	46	67	80	t	55	\N
4268	2	LECTURE	Платформи корпоративних інформаційних систем	45	67	80	t	55	\N
4269	2	LECTURE	Платформи корпоративних інформаційних систем	104	67	80	t	55	\N
4270	2	LECTURE	Платформи корпоративних інформаційних систем	49	67	80	t	55	\N
4271	2	LECTURE	Платформи корпоративних інформаційних систем	50	67	80	t	55	\N
4272	2	LABORATORY	Платформи корпоративних інформаційних систем	46	67	80	f	55	\N
4273	2	LABORATORY	Платформи корпоративних інформаційних систем	45	67	80	f	55	\N
4277	2	PRACTICAL	Комунікативні технології в управлінні проектами	45	336	42	f	55	\N
4278	2	PRACTICAL	Комунікативні технології в управлінні проектами	46	336	42	f	55	\N
4282	2	LECTURE	Розробка програмних додатків для мобільних пристроїв	45	217	61	t	55	\N
4283	2	LECTURE	Розробка програмних додатків для мобільних пристроїв	46	217	61	t	55	\N
4284	2	LECTURE	Розробка програмних додатків для мобільних пристроїв	104	217	61	t	55	\N
4285	2	LECTURE	Розробка програмних додатків для мобільних пристроїв	49	217	61	t	55	\N
4286	2	LECTURE	Розробка програмних додатків для мобільних пристроїв	50	217	61	t	55	\N
4287	2	LABORATORY	Розробка програмних додатків для мобільних пристроїв	45	217	61	f	55	\N
4288	2	LABORATORY	Розробка програмних додатків для мобільних пристроїв	46	217	61	f	55	\N
4281	2	PRACTICAL	Комунікативні технології в управлінні проектами	50	336	42	t	55	\N
4255	1	PRACTICAL	Методи оптимізації та дослідження операцій	50	66	35	t	55	\N
4276	2	LABORATORY	Платформи корпоративних інформаційних систем	50	67	80	t	55	\N
4291	2	LABORATORY	Розробка програмних додатків для мобільних пристроїв	50	217	61	t	55	\N
4280	2	PRACTICAL	Комунікативні технології в управлінні проектами	49	336	42	t	55	\N
4254	1	PRACTICAL	Методи оптимізації та дослідження операцій	49	66	35	t	55	\N
4275	2	LABORATORY	Платформи корпоративних інформаційних систем	49	67	80	t	55	\N
4290	2	LABORATORY	Розробка програмних додатків для мобільних пристроїв	49	217	61	t	55	\N
4292	2	LECTURE	Прикладний статистичний аналіз з використанням Python	45	337	36	t	55	\N
4293	2	LECTURE	Прикладний статистичний аналіз з використанням Python	46	337	36	t	55	\N
4294	2	LECTURE	Прикладний статистичний аналіз з використанням Python	104	337	36	t	55	\N
4295	2	LECTURE	Прикладний статистичний аналіз з використанням Python	49	337	36	t	55	\N
4296	2	LECTURE	Прикладний статистичний аналіз з використанням Python	50	337	36	t	55	\N
4297	2	LABORATORY	Прикладний статистичний аналіз з використанням Python	45	337	36	t	55	\N
4298	2	LABORATORY	Прикладний статистичний аналіз з використанням Python	46	337	36	t	55	\N
4299	2	LABORATORY	Прикладний статистичний аналіз з використанням Python	104	337	36	t	55	\N
4300	2	LABORATORY	Прикладний статистичний аналіз з використанням Python	49	337	36	t	55	\N
4301	2	LABORATORY	Прикладний статистичний аналіз з використанням Python	50	337	36	t	55	\N
4312	2	LECTURE	Теорія керування	45	72	37	t	55	\N
4313	2	LECTURE	Теорія керування	46	72	37	t	55	\N
4314	2	LECTURE	Теорія керування	104	72	37	t	55	\N
4315	2	LECTURE	Теорія керування	49	72	37	t	55	\N
4316	2	LECTURE	Теорія керування	50	72	37	t	55	\N
4317	2	LABORATORY	Теорія керування	45	72	37	f	55	\N
4318	2	LABORATORY	Теорія керування	46	72	37	f	55	\N
4322	2	LECTURE	Елементи теорії випадкових процесів	104	338	166	t	55	\N
4323	2	LECTURE	Елементи теорії випадкових процесів	50	338	166	t	55	\N
4324	2	PRACTICAL	Елементи теорії випадкових процесів	104	338	166	t	55	\N
4325	2	PRACTICAL	Елементи теорії випадкових процесів	50	338	166	t	55	\N
4326	2	LECTURE	Операційні системи	68	27	60	t	55	\N
4327	2	LECTURE	Операційні системи	70	27	60	t	55	\N
4328	2	LABORATORY	Операційні системи	68	27	60	t	55	\N
4329	2	LABORATORY	Операційні системи	70	27	60	t	55	\N
4336	2	LECTURE	Основи математичного моделювання та системного аналізу	68	76	81	t	55	\N
4337	2	LECTURE	Основи математичного моделювання та системного аналізу	70	76	81	t	55	\N
4338	2	LABORATORY	Основи математичного моделювання та системного аналізу	68	76	81	t	55	\N
4339	2	LABORATORY	Основи математичного моделювання та системного аналізу	70	76	81	t	55	\N
4340	2	LECTURE	Технології програмування мовою Python	68	77	19	t	55	\N
4341	2	LECTURE	Технології програмування мовою Python	70	77	19	t	55	\N
4334	2	LABORATORY	Методи оптимізації та дослідження операцій	68	66	35	f	55	\N
4321	2	LABORATORY	Теорія керування	50	72	37	t	55	\N
4335	2	LABORATORY	Методи оптимізації та дослідження операцій	70	66	35	f	55	\N
4331	2	LECTURE	Методи оптимізації та дослідження операцій	70	66	35	f	55	\N
4330	2	LECTURE	Методи оптимізації та дослідження операцій	68	66	35	f	55	\N
4307	1	LABORATORY	Управління проектами	45	331	61	f	55	\N
4302	1	LECTURE	Управління проектами	45	331	34	t	55	\N
4303	1	LECTURE	Управління проектами	46	331	34	t	55	\N
4304	1	LECTURE	Управління проектами	104	331	34	t	55	\N
4305	1	LECTURE	Управління проектами	49	331	34	t	55	\N
4308	1	LABORATORY	Управління проектами	46	331	61	f	55	\N
4309	1	LABORATORY	Управління проектами	104	331	34	t	55	\N
4310	1	LABORATORY	Управління проектами	49	331	34	t	55	\N
4311	1	LABORATORY	Управління проектами	50	331	34	t	55	\N
4342	2	LABORATORY	Технології програмування мовою Python	68	77	19	t	55	\N
4343	2	LABORATORY	Технології програмування мовою Python	70	77	19	t	55	\N
4344	2	LABORATORY	Frontend-розробка Web-додатків	68	78	195	f	55	\N
4346	1	LECTURE	Frontend-розробка Web-додатків	68	78	195	f	55	\N
4345	2	LABORATORY	Frontend-розробка Web-додатків	70	78	195	f	55	\N
4347	1	LECTURE	Frontend-розробка Web-додатків	70	78	195	f	55	\N
4348	1	LECTURE	Основи DevOps	68	339	62	t	55	\N
4349	1	LECTURE	Основи DevOps	70	339	62	t	55	\N
4350	2	LABORATORY	Основи DevOps	68	339	62	t	55	\N
4351	2	LABORATORY	Основи DevOps	70	339	62	t	55	\N
4352	1	LECTURE	Основи інформаційної безпеки	72	201	61	f	55	\N
4388	1	PRACTICAL	Математична статистика з елементами теорії випадкових процесів	71	342	26	f	55	\N
4359	3	LABORATORY	Інформаційно-комунікаційні технології в освіті	72	80	78	t	55	\N
4360	3	LABORATORY	Інформаційно-комунікаційні технології в освіті	73	80	78	t	55	\N
4361	1	LECTURE	Методика впровадження дослідних робіт з інформатики	72	84	205	f	55	\N
4362	2	LABORATORY	Методика впровадження дослідних робіт з інформатики	72	84	205	f	55	\N
4363	3	LECTURE	Варіаційне числення і методи оптимізації	72	222	82	t	55	\N
4364	3	LECTURE	Варіаційне числення і методи оптимізації	71	222	82	t	55	\N
4365	2	PRACTICAL	Варіаційне числення і методи оптимізації	72	222	82	t	55	\N
4366	2	PRACTICAL	Варіаційне числення і методи оптимізації	71	222	82	t	55	\N
4367	2	LECTURE	Задачі прикладного характеру	72	268	45	t	55	\N
4368	2	LECTURE	Задачі прикладного характеру	73	268	45	t	55	\N
4369	2	PRACTICAL	Задачі прикладного характеру	72	268	45	t	55	\N
4370	2	PRACTICAL	Задачі прикладного характеру	73	268	45	t	55	\N
4371	1	LECTURE	Комп'ютерні технології у тестуванні	72	320	78	f	55	\N
4372	1	LABORATORY	Комп'ютерні технології у тестуванні	72	320	78	f	55	\N
4373	1	PRACTICAL	Геометричні перетворення	73	85	49	t	55	\N
4374	1	PRACTICAL	Геометричні перетворення	71	85	49	t	55	\N
4356	2	LABORATORY	Методика розв'язування олімп. задач з ІТ	72	82	78	t	55	\N
4392	1	LECTURE	Програмування та підтримка Веб-застосунків	71	198	42	f	55	\N
4375	1	LECTURE	Олімпіадні задачі з алгебри і теорії чисел	73	271	105	t	55	\N
4376	1	LECTURE	Олімпіадні задачі з алгебри і теорії чисел	71	271	105	t	55	\N
4377	2	PRACTICAL	Олімпіадні задачі з алгебри і теорії чисел	73	271	105	t	55	\N
4378	2	PRACTICAL	Олімпіадні задачі з алгебри і теорії чисел	71	271	105	t	55	\N
4379	1	LECTURE	Тренінг професійного розвитку вчителя	73	340	97	f	55	\N
4380	2	PRACTICAL	Тренінг професійного розвитку вчителя	73	340	97	f	55	\N
4381	1	LECTURE	Практикум з тригонометрії	73	341	43	f	55	\N
4382	2	PRACTICAL	Практикум з тригонометрії	73	341	43	f	55	\N
4383	2	LECTURE	Історія математики	73	267	78	t	55	\N
4384	2	LECTURE	Історія математики	71	267	78	t	55	\N
4385	2	LECTURE	Математична логіка	71	86	28	f	55	\N
4386	1	PRACTICAL	Математична логіка	71	86	28	f	55	\N
4387	2	LECTURE	Математична статистика з елементами теорії випадкових процесів	71	342	26	f	55	\N
4391	2	LABORATORY	Програмування та підтримка Веб-застосунків	71	198	42	f	55	\N
4393	1	LECTURE	Фреймворки JavaScript	36	330	61	t	55	\N
4394	1	LECTURE	Фреймворки JavaScript	37	330	61	t	55	\N
4395	1	LECTURE	Фреймворки JavaScript	95	330	61	t	55	\N
4396	1	LECTURE	Фреймворки JavaScript	94	330	61	t	55	\N
4397	1	LECTURE	Фреймворки JavaScript	38	330	61	t	55	\N
4398	1	LECTURE	Фреймворки JavaScript	39	330	61	t	55	\N
4399	1	LECTURE	Фреймворки JavaScript	102	330	61	t	55	\N
4400	2	LABORATORY	Фреймворки JavaScript	36	330	61	t	55	\N
4401	2	LABORATORY	Фреймворки JavaScript	37	330	61	t	55	\N
4402	2	LABORATORY	Фреймворки JavaScript	95	330	61	t	55	\N
4403	2	LABORATORY	Фреймворки JavaScript	94	330	61	t	55	\N
4404	2	LABORATORY	Фреймворки JavaScript	38	330	189	t	55	\N
4405	2	LABORATORY	Фреймворки JavaScript	39	330	189	t	55	\N
4406	2	LABORATORY	Фреймворки JavaScript	102	330	189	t	55	\N
4407	2	LECTURE	Програмування	30	15	33	t	55	\N
4408	2	LECTURE	Програмування	29	15	33	t	55	\N
4409	2	LECTURE	Програмування	5	15	33	t	55	\N
4410	2	LECTURE	Програмування	85	15	33	t	55	\N
4411	2	LECTURE	Програмування	86	15	33	t	55	\N
3994	3	PRACTICAL	Теорія ймовірностей та математична статистика	94	30	35	f	55	\N
4090	2	LABORATORY	Комп'ютерне моделювання жорстких процесів та систем	36	328	30	f	55	\N
4171	2	LECTURE	Основи штучного інтелекту	37	329	32	t	55	\N
4172	2	LECTURE	Основи штучного інтелекту	95	329	32	t	55	\N
4173	2	LECTURE	Основи штучного інтелекту	94	329	32	t	55	\N
4174	2	LECTURE	Основи штучного інтелекту	38	329	32	t	55	\N
4175	2	LECTURE	Основи штучного інтелекту	39	329	32	t	55	\N
4176	2	LECTURE	Основи штучного інтелекту	102	329	32	t	55	\N
4412	2	LABORATORY	Програмування та підтримка Веб-застосунків	102	198	208	t	55	\N
4413	2	LABORATORY	Програмування та підтримка Веб-застосунків	38	198	208	t	55	\N
4414	2	LABORATORY	Програмування та підтримка Веб-застосунків	39	198	208	t	55	\N
4209	1	LABORATORY	Web-дизайн	40	205	195	f	55	\N
4210	1	LABORATORY	Web-дизайн	103	205	195	t	55	\N
4019	1	LABORATORY	Комп'ютерна математика	41	42	60	t	55	\N
4198	2	LABORATORY	Математична теорія ризиків	103	41	66	t	55	\N
4436	2	PRACTICAL	Громадське здоров'я та медицина порятунку	92	49	206	t	55	\N
3998	3	PRACTICAL	Теорія ймовірностей та математична статистика	103	30	40	t	55	\N
3999	3	PRACTICAL	Теорія ймовірностей та математична статистика	41	30	40	t	55	\N
4437	2	PRACTICAL	Громадське здоров'я та медицина порятунку	56	49	206	t	55	\N
4415	2	LABORATORY	Методика розв'язування олімп. задач з ІТ	71	82	78	t	55	\N
4214	2	PRACTICAL	Професійна іноземна мова	41	28	79	t	55	\N
3812	2	PRACTICAL	Іноземна мова (за професійним спрямуванням)	52	43	87	f	55	\N
4043	2	LABORATORY	Інформаційні системи обліку та логістика	50	70	73	t	55	\N
4041	2	LABORATORY	Інформаційні системи обліку та логістика	104	70	73	t	55	\N
4279	2	PRACTICAL	Комунікативні технології в управлінні проектами	104	336	42	t	55	\N
4253	1	PRACTICAL	Методи оптимізації та дослідження операцій	104	66	35	t	55	\N
4419	2	PRACTICAL	Фізичне виховання	51	13	97	t	55	\N
4420	2	PRACTICAL	Фізичне виховання	52	13	97	t	55	\N
4274	2	LABORATORY	Платформи корпоративних інформаційних систем	104	67	80	t	55	\N
4289	2	LABORATORY	Розробка програмних додатків для мобільних пристроїв	104	217	61	t	55	\N
4051	2	LABORATORY	Системи та методи прийняття рішень	104	69	40	t	55	\N
4320	2	LABORATORY	Теорія керування	49	72	37	t	55	\N
4319	2	LABORATORY	Теорія керування	104	72	37	t	55	\N
4332	1	PRACTICAL	Методи оптимізації та дослідження операцій	68	66	35	f	55	\N
4333	1	PRACTICAL	Методи оптимізації та дослідження операцій	70	66	35	f	55	\N
3891	2	LECTURE	Python для Data Science	71	323	26	f	55	\N
4353	1	LABORATORY	Основи інформаційної безпеки	72	201	61	f	55	\N
4421	2	PRACTICAL	Фізичне виховання	84	13	97	t	55	\N
4354	2	LECTURE	Методика розв'язування олімп. задач з ІТ	72	82	78	t	55	\N
4416	2	LECTURE	Методика розв'язування олімп. задач з ІТ	71	82	78	t	55	\N
4422	2	PRACTICAL	Фізичне виховання	93	13	97	t	55	\N
4423	2	PRACTICAL	Фізичне виховання	54	13	97	t	55	\N
4424	2	PRACTICAL	Фізичне виховання	87	13	97	t	55	\N
4425	2	PRACTICAL	Фізичне виховання	32	13	97	t	55	\N
4426	2	PRACTICAL	Фізичне виховання	92	13	97	t	55	\N
4427	2	PRACTICAL	Фізичне виховання	57	13	97	t	55	\N
4428	2	PRACTICAL	Фізичне виховання	56	13	97	t	55	\N
4429	2	PRACTICAL	Громадське здоров'я та медицина порятунку	51	49	206	t	55	\N
4430	2	PRACTICAL	Громадське здоров'я та медицина порятунку	52	49	206	t	55	\N
4431	2	PRACTICAL	Громадське здоров'я та медицина порятунку	84	49	206	t	55	\N
4432	2	PRACTICAL	Громадське здоров'я та медицина порятунку	93	49	206	t	55	\N
4433	2	PRACTICAL	Громадське здоров'я та медицина порятунку	54	49	206	t	55	\N
4434	2	PRACTICAL	Громадське здоров'я та медицина порятунку	87	49	206	t	55	\N
4435	2	PRACTICAL	Громадське здоров'я та медицина порятунку	32	49	206	t	55	\N
4438	2	PRACTICAL	Громадське здоров'я та медицина порятунку	57	49	206	t	55	\N
4439	2	PRACTICAL	Французька мова	33	134	97	f	55	\N
4440	2	PRACTICAL	Німецька мова	31	133	88	f	55	\N
4441	2	PRACTICAL	Фізичне виховання	103	13	97	t	55	\N
4442	2	PRACTICAL	Фізичне виховання	42	13	97	t	55	\N
4443	2	PRACTICAL	Фізичне виховання	43	13	97	t	55	\N
4444	2	PRACTICAL	Фізичне виховання	45	13	97	t	55	\N
4445	2	PRACTICAL	Фізичне виховання	46	13	97	t	55	\N
4306	1	LECTURE	Управління проектами	50	331	34	t	55	\N
4446	1	LECTURE	Управління проектами	45	331	61	t	55	\N
4447	1	LECTURE	Управління проектами	46	331	61	t	55	\N
4448	1	LECTURE	Управління проектами	104	331	61	t	55	\N
4449	1	LECTURE	Управління проектами	50	331	61	t	55	\N
4450	1	LECTURE	Управління проектами	49	331	61	t	55	\N
4451	1	LABORATORY	Управління проектами	45	331	34	f	55	\N
4452	1	LABORATORY	Управління проектами	46	331	34	f	55	\N
4453	1	LABORATORY	Управління проектами	104	331	61	f	55	\N
4456	1	LABORATORY	Управління проектами	49	331	61	f	55	\N
4455	1	LABORATORY	Управління проектами	50	331	61	f	55	\N
4457	2	PRACTICAL	Професійна іноземна мова	42	28	161	f	55	\N
\.


--
-- Data for Name: periods; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.periods (id, end_time, name, start_time) FROM stdin;
8	17:30:00	6	16:10:00
1	09:40:00	1	08:20:00
2	11:10:00	2	09:50:00
3	12:50:00	3	11:30:00
4	14:20:00	4	13:00:00
7	16:00:00	5	14:40:00
\.


--
-- Data for Name: room_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.room_types (id, description) FROM stdin;
25	Лекційна
26	практична
27	лабораторія
6	кафедра ПМіІТ
7	кафедра диф.рівнянь
8	кафедра мат.моделювання
9	кафедра алгебри та інформатики
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rooms (id, disable, name, room_type_id, sort_order) FROM stdin;
52	f	1 к. 15 ауд.	27	14
55	f	1 к. 19 ауд.	27	15
56	f	1 к. 21 ауд.	27	16
60	f	1 к. 27 ауд.	27	17
63	f	1 к. 31 ауд.	27	18
118	f	1 к. 13 ауд.	9	19
111	f	1 к. 17 ауд.	8	20
110	f	1 к. 26 ауд.	6	21
108	f	1 К. 36 АУД.	7	23
114	t	14 корпус 60 ауд.	25	48
113	t	14 корпус 54 ауд.	25	49
112	t	14 корпус 1-А	25	50
74	f	1 к. 40 ауд.	25	25
107	f	1 К. 44 АУД.	27	26
50	f	1 к. 7 ауд.	25	27
109	t	6 к. 22 ауд.	25	29
115	t	6 к. 26 ауд.	25	30
119	f	Проводиться онлайн	25	47
72	f	Факультет ФКтаЗЛ	26	46
68	f	1 к. 39 ауд.	25	1
65	f	1 к. 33 ауд.	25	2
53	f	1 к. 18 ауд.	25	3
59	f	1 к. 22 ауд.	25	4
61	f	1 к. 28 ауд.	25	5
54	f	1 к. 3 ауд.	25	6
51	f	1 к. 11 ауд.	26	7
57	f	1 к. 23 ауд.	25	8
58	f	1 к. 24 ауд.	25	9
66	f	1 к. 37 ауд.	25	10
67	f	1 к. 38 ауд.	25	11
62	f	1 к. 29 ауд.	26	12
64	f	1 к. 32 ауд.	27	13
120	f	1к. 43 ауд.	26	48
121	f	Ботанічний сад	27	49
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.schedules (id, day_of_week, evenodd, lesson_id, period_id, room_id) FROM stdin;
8783	TUESDAY	ODD	4324	4	119
8784	TUESDAY	ODD	4325	4	119
7672	WEDNESDAY	ODD	3679	2	53
7673	WEDNESDAY	EVEN	3679	2	53
7655	TUESDAY	ODD	2917	1	57
7657	TUESDAY	EVEN	2917	1	57
7656	TUESDAY	ODD	2918	1	57
7658	TUESDAY	EVEN	2918	1	57
7578	MONDAY	ODD	3661	2	68
7579	MONDAY	ODD	3662	2	68
7580	MONDAY	ODD	3663	2	68
7581	MONDAY	ODD	3664	2	68
7582	MONDAY	ODD	3665	2	68
7583	MONDAY	ODD	3666	2	68
7584	MONDAY	ODD	3667	2	68
7585	MONDAY	EVEN	3661	2	68
7586	MONDAY	EVEN	3662	2	68
7587	MONDAY	EVEN	3663	2	68
7588	MONDAY	EVEN	3664	2	68
7589	MONDAY	EVEN	3665	2	68
7590	MONDAY	EVEN	3666	2	68
7591	MONDAY	EVEN	3667	2	68
7594	MONDAY	EVEN	3726	3	68
7595	MONDAY	EVEN	3727	3	68
7596	MONDAY	EVEN	3728	3	68
7597	MONDAY	EVEN	3729	3	68
7598	MONDAY	EVEN	3730	3	68
7599	MONDAY	EVEN	3731	3	68
7600	MONDAY	EVEN	3732	3	68
7601	TUESDAY	ODD	2872	1	58
7602	TUESDAY	EVEN	2872	1	58
7604	TUESDAY	ODD	4407	2	68
7605	TUESDAY	ODD	4408	2	68
7606	TUESDAY	ODD	4409	2	68
7607	TUESDAY	ODD	4410	2	68
7608	TUESDAY	ODD	4411	2	68
7609	TUESDAY	EVEN	4407	2	68
7610	TUESDAY	EVEN	4408	2	68
7611	TUESDAY	EVEN	4409	2	68
7612	TUESDAY	EVEN	4410	2	68
7613	TUESDAY	EVEN	4411	2	68
7614	WEDNESDAY	ODD	3653	1	68
7615	WEDNESDAY	ODD	3654	1	68
7616	WEDNESDAY	ODD	3655	1	68
7617	WEDNESDAY	ODD	3656	1	68
7618	WEDNESDAY	ODD	3657	1	68
7619	WEDNESDAY	ODD	3658	1	68
7620	WEDNESDAY	ODD	3659	1	68
7621	WEDNESDAY	ODD	3660	1	68
7622	WEDNESDAY	EVEN	3653	1	68
7623	WEDNESDAY	EVEN	3654	1	68
7624	WEDNESDAY	EVEN	3655	1	68
7625	WEDNESDAY	EVEN	3656	1	68
7626	WEDNESDAY	EVEN	3657	1	68
7627	WEDNESDAY	EVEN	3658	1	68
7628	WEDNESDAY	EVEN	3659	1	68
7629	WEDNESDAY	EVEN	3660	1	68
7630	WEDNESDAY	ODD	2881	2	56
7631	WEDNESDAY	EVEN	2881	2	56
7632	WEDNESDAY	ODD	3697	3	59
7633	WEDNESDAY	EVEN	3697	3	59
7634	THURSDAY	ODD	3733	1	58
7635	THURSDAY	EVEN	3733	1	58
7636	THURSDAY	ODD	2874	2	54
7637	THURSDAY	EVEN	2874	2	54
7639	FRIDAY	ODD	3675	2	68
7640	FRIDAY	ODD	3676	2	68
7641	FRIDAY	ODD	3670	2	68
7642	FRIDAY	ODD	3671	2	68
7643	FRIDAY	ODD	3672	2	68
7644	FRIDAY	ODD	3673	2	68
7645	FRIDAY	ODD	3674	2	68
7646	FRIDAY	EVEN	3675	2	68
7647	FRIDAY	EVEN	3676	2	68
7648	FRIDAY	EVEN	3670	2	68
7649	FRIDAY	EVEN	3671	2	68
7650	FRIDAY	EVEN	3672	2	68
7651	FRIDAY	EVEN	3673	2	68
7652	FRIDAY	EVEN	3674	2	68
7653	FRIDAY	ODD	3677	3	57
7654	FRIDAY	EVEN	3677	3	57
7659	WEDNESDAY	ODD	2916	2	55
7660	WEDNESDAY	EVEN	2916	2	55
7661	WEDNESDAY	ODD	3698	3	59
7662	WEDNESDAY	EVEN	3698	3	59
7663	THURSDAY	ODD	3734	1	58
7664	THURSDAY	EVEN	3734	1	58
7665	THURSDAY	ODD	2875	2	54
7666	THURSDAY	EVEN	2875	2	54
7668	FRIDAY	ODD	3678	3	57
7669	FRIDAY	EVEN	3678	3	57
7670	MONDAY	ODD	3699	1	58
7671	MONDAY	EVEN	3699	1	58
7674	THURSDAY	ODD	3914	1	54
7675	THURSDAY	EVEN	3914	1	54
7676	THURSDAY	ODD	2856	2	59
7677	THURSDAY	ODD	2857	2	59
7678	THURSDAY	EVEN	2856	2	59
7679	THURSDAY	EVEN	2857	2	59
7685	MONDAY	ODD	3700	1	58
7687	TUESDAY	ODD	2925	1	61
7691	THURSDAY	ODD	3915	1	54
7693	THURSDAY	ODD	2924	3	60
7697	TUESDAY	ODD	2931	1	51
7701	WEDNESDAY	ODD	3701	2	58
7703	WEDNESDAY	ODD	2927	3	58
7705	THURSDAY	ODD	3681	2	58
7707	THURSDAY	ODD	2929	3	51
7709	FRIDAY	ODD	2930	1	55
8785	TUESDAY	EVEN	4324	4	119
8786	TUESDAY	EVEN	4325	4	119
8787	WEDNESDAY	ODD	4044	1	119
8788	WEDNESDAY	ODD	4045	1	119
8789	WEDNESDAY	ODD	4046	1	119
8790	WEDNESDAY	ODD	4047	1	119
8791	WEDNESDAY	ODD	4048	1	119
8795	WEDNESDAY	ODD	4053	2	119
8796	WEDNESDAY	ODD	4052	2	119
8797	WEDNESDAY	ODD	4051	2	119
8827	THURSDAY	ODD	4321	2	119
8828	THURSDAY	ODD	4320	2	119
8829	THURSDAY	ODD	4319	2	119
8836	THURSDAY	EVEN	4291	3	119
8837	THURSDAY	EVEN	4290	3	119
8838	THURSDAY	EVEN	4289	3	119
8847	THURSDAY	EVEN	4315	4	119
8848	THURSDAY	EVEN	4316	4	119
8854	FRIDAY	EVEN	4034	1	119
8855	FRIDAY	EVEN	4035	1	119
8856	FRIDAY	EVEN	4036	1	119
8857	FRIDAY	EVEN	4037	1	119
8858	FRIDAY	EVEN	4038	1	119
8870	THURSDAY	EVEN	4317	3	119
9020	FRIDAY	ODD	4375	1	119
9021	FRIDAY	ODD	4376	1	119
9024	THURSDAY	EVEN	4220	4	119
9025	THURSDAY	EVEN	4221	4	119
7689	WEDNESDAY	ODD	3680	2	53
9031	FRIDAY	ODD	2927	3	51
9032	MONDAY	ODD	3686	1	57
7699	TUESDAY	ODD	2864	3	58
7686	MONDAY	EVEN	3700	1	58
7688	TUESDAY	EVEN	2925	1	61
7692	THURSDAY	EVEN	3915	1	54
7694	THURSDAY	EVEN	2924	3	60
7698	TUESDAY	EVEN	2931	1	51
7702	WEDNESDAY	EVEN	3701	2	58
7704	WEDNESDAY	EVEN	2927	3	58
7706	THURSDAY	EVEN	3681	2	58
7708	THURSDAY	EVEN	2929	3	51
7710	FRIDAY	EVEN	2930	1	55
8792	WEDNESDAY	EVEN	4255	1	119
8793	WEDNESDAY	EVEN	4254	1	119
8794	WEDNESDAY	EVEN	4253	1	119
8798	WEDNESDAY	EVEN	4053	2	119
8799	WEDNESDAY	EVEN	4052	2	119
8800	WEDNESDAY	EVEN	4051	2	119
8815	WEDNESDAY	EVEN	4310	4	119
8816	WEDNESDAY	EVEN	4311	4	119
8822	THURSDAY	EVEN	4282	1	119
8823	THURSDAY	EVEN	4283	1	119
8824	THURSDAY	EVEN	4284	1	119
8825	THURSDAY	EVEN	4285	1	119
8826	THURSDAY	EVEN	4286	1	119
8833	THURSDAY	ODD	4291	3	119
8834	THURSDAY	ODD	4290	3	119
8835	THURSDAY	ODD	4289	3	119
8839	THURSDAY	ODD	4312	4	119
8840	THURSDAY	ODD	4313	4	119
8841	THURSDAY	ODD	4314	4	119
8842	THURSDAY	ODD	4315	4	119
8843	THURSDAY	ODD	4316	4	119
8849	FRIDAY	ODD	4034	1	119
8850	FRIDAY	ODD	4035	1	119
8851	FRIDAY	ODD	4036	1	119
8852	FRIDAY	ODD	4037	1	119
8853	FRIDAY	ODD	4038	1	119
8859	FRIDAY	ODD	4042	2	119
8860	FRIDAY	ODD	4043	2	119
8861	FRIDAY	ODD	4041	2	119
8871	FRIDAY	ODD	4049	2	119
8872	FRIDAY	EVEN	4049	2	119
9027	FRIDAY	EVEN	3684	1	53
7690	WEDNESDAY	EVEN	3680	2	53
9033	FRIDAY	ODD	2945	1	60
9039	MONDAY	ODD	3689	1	57
9042	WEDNESDAY	EVEN	3718	3	65
9043	WEDNESDAY	EVEN	3719	3	65
9047	WEDNESDAY	ODD	3950	2	61
7700	TUESDAY	EVEN	2864	3	58
7714	MONDAY	ODD	2935	1	74
7715	MONDAY	ODD	2936	1	74
7730	WEDNESDAY	EVEN	3702	2	59
7791	MONDAY	EVEN	3741	4	68
7719	TUESDAY	ODD	4060	1	53
7720	TUESDAY	ODD	4061	1	53
7721	TUESDAY	EVEN	4060	1	53
7722	TUESDAY	EVEN	4061	1	53
7723	TUESDAY	ODD	4062	2	53
7724	TUESDAY	ODD	4063	2	53
7725	TUESDAY	EVEN	4062	2	53
7726	TUESDAY	EVEN	4063	2	53
7727	TUESDAY	EVEN	2935	3	66
7728	TUESDAY	EVEN	2936	3	66
7731	THURSDAY	ODD	2932	2	57
7732	THURSDAY	EVEN	2932	2	57
7733	THURSDAY	ODD	3682	3	57
7734	THURSDAY	EVEN	3682	3	57
7759	MONDAY	EVEN	3740	4	68
7741	THURSDAY	EVEN	2962	2	57
7742	THURSDAY	ODD	2962	2	57
7743	THURSDAY	ODD	3683	3	57
7744	THURSDAY	EVEN	3683	3	57
7747	MONDAY	ODD	3708	2	74
7748	MONDAY	ODD	3709	2	74
7749	MONDAY	ODD	3710	2	74
7750	MONDAY	EVEN	3708	2	74
7751	MONDAY	EVEN	3709	2	74
7752	MONDAY	EVEN	3710	2	74
7753	MONDAY	ODD	3916	3	53
7754	MONDAY	ODD	3917	3	53
7755	MONDAY	ODD	3918	3	53
7756	MONDAY	EVEN	3916	3	53
7757	MONDAY	EVEN	3917	3	53
7758	MONDAY	EVEN	3918	3	53
7760	TUESDAY	ODD	2996	3	67
7761	TUESDAY	EVEN	2996	3	67
7762	TUESDAY	ODD	2990	4	56
7763	TUESDAY	EVEN	2990	4	56
7764	WEDNESDAY	ODD	3711	2	65
7765	WEDNESDAY	ODD	3712	2	65
7766	WEDNESDAY	ODD	3713	2	65
7767	WEDNESDAY	EVEN	3711	2	65
7768	WEDNESDAY	EVEN	3712	2	65
7769	WEDNESDAY	EVEN	3713	2	65
7770	WEDNESDAY	ODD	3704	3	61
7771	WEDNESDAY	EVEN	3704	3	61
7772	THURSDAY	ODD	2973	1	66
7773	THURSDAY	EVEN	2973	1	66
7774	THURSDAY	ODD	2989	2	66
7775	THURSDAY	EVEN	2996	2	66
7776	THURSDAY	EVEN	3919	3	53
7777	THURSDAY	EVEN	3920	3	53
7778	THURSDAY	ODD	3715	3	52
7779	THURSDAY	EVEN	3715	4	52
7780	FRIDAY	ODD	2986	1	74
7781	FRIDAY	ODD	2987	1	74
7782	FRIDAY	ODD	2988	1	74
7783	FRIDAY	EVEN	2986	1	74
7784	FRIDAY	EVEN	2987	1	74
7785	FRIDAY	EVEN	2988	1	74
7786	FRIDAY	ODD	3921	2	56
7787	FRIDAY	EVEN	3921	2	56
7789	MONDAY	ODD	3930	3	66
7790	MONDAY	EVEN	3930	3	66
7796	TUESDAY	ODD	3928	2	58
7797	TUESDAY	ODD	3929	2	58
7798	TUESDAY	EVEN	3002	2	58
7799	TUESDAY	ODD	3006	3	57
7800	TUESDAY	EVEN	3006	3	57
7801	WEDNESDAY	ODD	3923	1	57
7802	WEDNESDAY	ODD	3924	1	57
7803	WEDNESDAY	EVEN	3923	1	57
7804	WEDNESDAY	EVEN	3924	1	57
7805	THURSDAY	ODD	3928	1	57
7806	THURSDAY	ODD	3929	1	57
7807	THURSDAY	EVEN	3928	1	57
7808	THURSDAY	EVEN	3929	1	57
7809	THURSDAY	ODD	3724	2	65
7810	THURSDAY	ODD	3725	2	65
7811	THURSDAY	EVEN	3722	2	65
7812	THURSDAY	EVEN	3723	2	65
7817	WEDNESDAY	ODD	2923	3	56
7818	WEDNESDAY	EVEN	2923	3	56
7819	FRIDAY	ODD	3930	2	66
7820	FRIDAY	EVEN	3690	2	66
7821	FRIDAY	ODD	3004	3	55
7822	FRIDAY	EVEN	3004	3	55
7823	MONDAY	ODD	3931	3	66
7729	WEDNESDAY	ODD	3702	2	59
7739	WEDNESDAY	ODD	3703	2	59
7740	WEDNESDAY	EVEN	3703	2	59
7716	MONDAY	EVEN	2935	1	74
7717	MONDAY	EVEN	2936	1	74
7824	MONDAY	EVEN	3931	3	66
7829	THURSDAY	ODD	3005	3	56
7830	THURSDAY	EVEN	3005	3	56
7839	MONDAY	ODD	3803	1	68
7842	MONDAY	EVEN	3799	1	68
7843	MONDAY	EVEN	3800	1	68
7844	MONDAY	EVEN	3801	1	68
7845	MONDAY	EVEN	3802	1	68
7846	MONDAY	EVEN	3803	1	68
8814	WEDNESDAY	EVEN	4309	4	119
7849	TUESDAY	ODD	3747	1	59
7850	TUESDAY	EVEN	3747	1	59
9044	THURSDAY	ODD	3830	4	63
9045	WEDNESDAY	ODD	3832	4	63
9046	WEDNESDAY	EVEN	3832	4	63
7828	TUESDAY	EVEN	3003	2	67
7832	FRIDAY	EVEN	3691	2	66
7833	MONDAY	ODD	3797	1	68
7834	MONDAY	ODD	3798	1	68
7835	MONDAY	ODD	3799	1	68
7836	MONDAY	ODD	3800	1	68
7837	MONDAY	ODD	3801	1	68
7838	MONDAY	ODD	3802	1	68
7840	MONDAY	EVEN	3797	1	68
7841	MONDAY	EVEN	3798	1	68
7847	MONDAY	ODD	3769	2	55
7848	MONDAY	EVEN	3769	2	55
7852	TUESDAY	EVEN	3811	2	51
8817	THURSDAY	ODD	4282	1	119
8818	THURSDAY	ODD	4283	1	119
8819	THURSDAY	ODD	4284	1	119
8820	THURSDAY	ODD	4285	1	119
8821	THURSDAY	ODD	4286	1	119
7825	MONDAY	EVEN	3742	4	68
9048	WEDNESDAY	ODD	3964	2	67
9051	FRIDAY	EVEN	3965	3	66
7826	TUESDAY	ODD	2963	3	57
7827	TUESDAY	EVEN	2963	3	57
7831	FRIDAY	ODD	3931	2	66
7851	TUESDAY	ODD	3811	2	51
7853	TUESDAY	ODD	3897	4	55
7854	WEDNESDAY	ODD	3890	1	65
7856	WEDNESDAY	ODD	3892	1	65
7857	WEDNESDAY	ODD	3893	1	65
7858	WEDNESDAY	ODD	3894	1	65
7859	WEDNESDAY	ODD	3895	1	65
7860	WEDNESDAY	ODD	3896	1	65
7861	WEDNESDAY	EVEN	3890	1	65
7863	WEDNESDAY	EVEN	3892	1	65
7864	WEDNESDAY	EVEN	3893	1	65
7865	WEDNESDAY	EVEN	3894	1	65
7866	WEDNESDAY	EVEN	3895	1	65
7867	WEDNESDAY	EVEN	3896	1	65
7868	WEDNESDAY	EVEN	3779	2	68
7869	WEDNESDAY	EVEN	3780	2	68
7870	WEDNESDAY	EVEN	3781	2	68
7871	WEDNESDAY	EVEN	3782	2	68
7872	WEDNESDAY	EVEN	3783	2	68
7873	WEDNESDAY	EVEN	3784	2	68
7874	WEDNESDAY	EVEN	3785	2	68
7875	WEDNESDAY	EVEN	3786	2	68
7876	WEDNESDAY	EVEN	3787	2	68
7877	WEDNESDAY	ODD	3779	2	68
7878	WEDNESDAY	ODD	3780	2	68
7879	WEDNESDAY	ODD	3781	2	68
7880	WEDNESDAY	ODD	3782	2	68
7881	WEDNESDAY	ODD	3783	2	68
7882	WEDNESDAY	ODD	3784	2	68
7883	WEDNESDAY	ODD	3785	2	68
7884	WEDNESDAY	ODD	3786	2	68
7885	WEDNESDAY	ODD	3787	2	68
7886	WEDNESDAY	ODD	3759	3	68
7887	WEDNESDAY	ODD	3760	3	68
7888	WEDNESDAY	ODD	3761	3	68
7889	WEDNESDAY	ODD	3762	3	68
7890	WEDNESDAY	ODD	3763	3	68
7891	WEDNESDAY	ODD	3764	3	68
7892	WEDNESDAY	ODD	3765	3	68
7893	WEDNESDAY	ODD	3766	3	68
7894	WEDNESDAY	ODD	3767	3	68
7895	WEDNESDAY	ODD	3768	3	68
7896	WEDNESDAY	EVEN	3759	3	68
7897	WEDNESDAY	EVEN	3760	3	68
7898	WEDNESDAY	EVEN	3761	3	68
7899	WEDNESDAY	EVEN	3762	3	68
7900	WEDNESDAY	EVEN	3763	3	68
7901	WEDNESDAY	EVEN	3764	3	68
7902	WEDNESDAY	EVEN	3765	3	68
7903	WEDNESDAY	EVEN	3766	3	68
7904	WEDNESDAY	EVEN	3767	3	68
7905	WEDNESDAY	EVEN	3768	3	68
7930	THURSDAY	ODD	3743	1	74
7931	THURSDAY	ODD	3744	1	74
7932	THURSDAY	ODD	3745	1	74
7933	THURSDAY	ODD	3746	1	74
7934	THURSDAY	EVEN	3743	1	74
7935	THURSDAY	EVEN	3744	1	74
7936	THURSDAY	EVEN	3745	1	74
7937	THURSDAY	EVEN	3746	1	74
7938	THURSDAY	ODD	3804	2	52
7939	THURSDAY	EVEN	3804	2	52
7940	THURSDAY	ODD	3779	3	68
7941	THURSDAY	ODD	3780	3	68
7942	THURSDAY	ODD	3781	3	68
7943	THURSDAY	ODD	3782	3	68
7944	THURSDAY	ODD	3783	3	68
7945	THURSDAY	ODD	3784	3	68
7946	THURSDAY	ODD	3785	3	68
7947	THURSDAY	ODD	3786	3	68
7948	THURSDAY	ODD	3787	3	68
7949	THURSDAY	EVEN	3833	3	68
7950	THURSDAY	EVEN	3834	3	68
7951	THURSDAY	EVEN	3835	3	68
7952	THURSDAY	EVEN	3836	3	68
7953	THURSDAY	EVEN	3837	3	68
7955	FRIDAY	ODD	3788	1	107
7956	FRIDAY	EVEN	3788	1	107
7957	FRIDAY	ODD	3904	3	68
7958	FRIDAY	ODD	3905	3	68
7959	FRIDAY	ODD	3906	3	68
7960	FRIDAY	ODD	3907	3	68
7961	FRIDAY	ODD	3908	3	68
7963	FRIDAY	EVEN	3905	3	68
7984	TUESDAY	ODD	3850	7	53
7985	TUESDAY	ODD	3852	7	53
7988	THURSDAY	ODD	3839	4	55
7969	FRIDAY	ODD	3838	4	63
7970	FRIDAY	EVEN	3838	4	63
7990	FRIDAY	ODD	3770	4	56
7991	FRIDAY	EVEN	3770	4	56
8003	THURSDAY	ODD	3749	2	67
8004	THURSDAY	EVEN	3749	2	67
8006	FRIDAY	EVEN	3790	4	55
8009	MONDAY	ODD	3791	3	60
8016	THURSDAY	ODD	3750	2	67
8017	THURSDAY	EVEN	3750	2	67
8830	THURSDAY	EVEN	4321	2	119
8831	THURSDAY	EVEN	4320	2	119
8832	THURSDAY	EVEN	4319	2	119
8844	THURSDAY	EVEN	4312	4	119
8845	THURSDAY	EVEN	4313	4	119
8846	THURSDAY	EVEN	4314	4	119
8862	FRIDAY	EVEN	4042	2	119
8863	FRIDAY	EVEN	4043	2	119
8864	FRIDAY	EVEN	4041	2	119
8865	WEDNESDAY	ODD	4307	2	119
8867	THURSDAY	ODD	4287	2	119
8868	THURSDAY	EVEN	4287	2	119
8869	THURSDAY	ODD	4317	3	119
7996	TUESDAY	ODD	3830	1	63
7997	TUESDAY	EVEN	3830	1	63
9049	WEDNESDAY	EVEN	3964	2	67
7977	TUESDAY	ODD	3812	2	57
7978	TUESDAY	EVEN	3812	2	57
9050	FRIDAY	ODD	3965	3	66
7962	FRIDAY	EVEN	3904	3	68
7964	FRIDAY	EVEN	3906	3	68
7965	FRIDAY	EVEN	3907	3	68
7966	FRIDAY	EVEN	3908	3	68
7973	MONDAY	ODD	3805	3	52
7989	THURSDAY	EVEN	3839	4	55
7992	MONDAY	ODD	3806	2	52
8001	WEDNESDAY	ODD	3771	1	52
8002	WEDNESDAY	EVEN	3771	1	52
8005	FRIDAY	ODD	3790	4	55
8011	TUESDAY	ODD	3841	1	52
8012	TUESDAY	EVEN	3841	1	52
8014	TUESDAY	EVEN	3814	2	61
8873	FRIDAY	ODD	4039	3	119
8879	THURSDAY	ODD	4318	3	119
8880	THURSDAY	EVEN	4318	3	119
8883	FRIDAY	ODD	4040	3	119
7975	TUESDAY	ODD	3748	1	59
8539	WEDNESDAY	EVEN	4203	2	57
7967	FRIDAY	ODD	3828	2	107
7968	FRIDAY	EVEN	3828	2	107
7971	MONDAY	ODD	3789	2	56
7972	MONDAY	EVEN	3789	2	56
7974	MONDAY	EVEN	3805	3	52
7979	TUESDAY	EVEN	3829	3	56
7980	TUESDAY	ODD	3854	4	52
7981	TUESDAY	ODD	3856	4	52
7982	TUESDAY	EVEN	3854	4	52
7983	TUESDAY	EVEN	3856	4	52
7986	THURSDAY	ODD	3829	2	107
7987	THURSDAY	EVEN	3829	2	107
7993	MONDAY	EVEN	3806	2	52
7994	MONDAY	ODD	3840	3	56
7995	MONDAY	EVEN	3840	3	56
8007	MONDAY	ODD	3807	2	60
8008	MONDAY	EVEN	3807	2	60
8010	MONDAY	EVEN	3791	3	60
8013	TUESDAY	ODD	3814	2	61
8018	THURSDAY	ODD	3831	4	56
8019	THURSDAY	EVEN	3831	4	56
8022	MONDAY	ODD	3773	2	63
8023	MONDAY	EVEN	3773	2	63
8024	MONDAY	ODD	3874	3	74
8025	MONDAY	ODD	3877	3	74
8026	MONDAY	ODD	3878	3	74
8027	MONDAY	ODD	3879	3	74
8028	MONDAY	ODD	3880	3	74
8029	MONDAY	ODD	3881	3	74
8030	MONDAY	EVEN	3874	3	74
8031	MONDAY	EVEN	3877	3	74
8032	MONDAY	EVEN	3878	3	74
8033	MONDAY	EVEN	3879	3	74
8034	MONDAY	EVEN	3880	3	74
8035	MONDAY	EVEN	3881	3	74
8036	MONDAY	ODD	4064	4	74
8037	MONDAY	ODD	4065	4	74
8038	MONDAY	ODD	4066	4	74
8039	MONDAY	ODD	4067	4	74
8040	MONDAY	ODD	4068	4	74
8041	MONDAY	ODD	4069	4	74
8042	TUESDAY	ODD	3815	2	59
8043	TUESDAY	EVEN	3815	2	59
8044	TUESDAY	ODD	3792	3	60
8045	TUESDAY	EVEN	3792	3	60
8046	TUESDAY	ODD	3842	4	60
8047	TUESDAY	EVEN	3842	4	60
8050	THURSDAY	ODD	3808	1	52
8051	THURSDAY	EVEN	3808	1	52
8052	THURSDAY	ODD	3954	2	68
8053	THURSDAY	ODD	3955	2	68
8054	THURSDAY	ODD	3956	2	68
8055	THURSDAY	ODD	3957	2	68
8056	THURSDAY	ODD	3958	2	68
8057	THURSDAY	ODD	3959	2	68
8058	THURSDAY	ODD	3960	2	68
8059	THURSDAY	ODD	3961	2	68
8060	THURSDAY	EVEN	3954	2	68
8061	THURSDAY	EVEN	3955	2	68
8062	THURSDAY	EVEN	3956	2	68
8063	THURSDAY	EVEN	3957	2	68
8064	THURSDAY	EVEN	3958	2	68
8065	THURSDAY	EVEN	3959	2	68
8066	THURSDAY	EVEN	3960	2	68
8067	THURSDAY	EVEN	3961	2	68
8068	THURSDAY	EVEN	3832	4	63
8069	FRIDAY	ODD	3751	2	67
8070	FRIDAY	EVEN	3751	2	67
8071	MONDAY	ODD	3752	1	67
8072	MONDAY	EVEN	3752	1	67
8073	MONDAY	ODD	4070	2	65
8074	MONDAY	ODD	4071	2	65
8075	MONDAY	ODD	4072	2	65
8076	MONDAY	ODD	4073	2	65
8077	MONDAY	EVEN	4070	2	65
8078	MONDAY	EVEN	4071	2	65
8079	MONDAY	EVEN	4072	2	65
8080	MONDAY	EVEN	4073	2	65
8084	TUESDAY	EVEN	3819	2	59
8085	THURSDAY	ODD	3936	4	52
8086	TUESDAY	ODD	3899	4	55
8087	THURSDAY	ODD	3774	1	63
8088	THURSDAY	EVEN	3774	1	63
8089	FRIDAY	ODD	3932	1	68
8090	FRIDAY	ODD	3933	1	68
8091	FRIDAY	ODD	3934	1	68
8092	FRIDAY	ODD	3935	1	68
8093	FRIDAY	EVEN	3932	1	68
8094	FRIDAY	EVEN	3933	1	68
8095	FRIDAY	EVEN	3934	1	68
8096	FRIDAY	EVEN	3935	1	68
8097	FRIDAY	ODD	3793	2	55
8098	FRIDAY	EVEN	3793	2	55
8099	FRIDAY	ODD	3936	3	52
8100	FRIDAY	EVEN	3936	3	52
8101	MONDAY	ODD	3753	1	67
8102	MONDAY	EVEN	3753	1	67
8103	TUESDAY	ODD	3820	1	67
8081	TUESDAY	ODD	4074	1	60
8082	TUESDAY	EVEN	4074	1	60
8015	WEDNESDAY	ODD	3831	1	63
7999	TUESDAY	EVEN	3813	2	57
8020	FRIDAY	ODD	3772	2	60
8021	FRIDAY	EVEN	3772	2	60
7998	TUESDAY	ODD	3813	2	57
8104	TUESDAY	EVEN	3820	1	67
8107	TUESDAY	ODD	3794	3	55
8874	FRIDAY	EVEN	4039	3	119
8877	THURSDAY	ODD	4288	2	119
8878	THURSDAY	EVEN	4288	2	119
8881	FRIDAY	ODD	4050	2	119
8882	FRIDAY	EVEN	4050	2	119
8884	FRIDAY	EVEN	4040	3	119
8300	WEDNESDAY	ODD	3991	4	53
8875	WEDNESDAY	ODD	4308	2	119
8372	WEDNESDAY	ODD	3992	4	53
8108	TUESDAY	ODD	4075	2	63
8109	TUESDAY	EVEN	4075	2	63
8111	TUESDAY	EVEN	3900	4	55
9052	THURSDAY	ODD	4228	1	53
8110	TUESDAY	EVEN	3794	3	55
8112	THURSDAY	EVEN	3937	3	52
8113	THURSDAY	ODD	3775	4	60
8114	THURSDAY	EVEN	3775	4	60
8115	FRIDAY	ODD	3937	2	52
8116	FRIDAY	EVEN	3937	2	52
8117	TUESDAY	ODD	3821	1	67
8118	TUESDAY	EVEN	3821	1	67
8119	TUESDAY	ODD	4076	2	63
8120	TUESDAY	EVEN	4076	2	63
8121	TUESDAY	ODD	3795	3	55
8122	TUESDAY	EVEN	3795	3	55
8123	TUESDAY	EVEN	3901	4	55
8124	THURSDAY	EVEN	3938	3	52
8125	THURSDAY	ODD	3776	4	60
8126	THURSDAY	EVEN	3776	4	60
8127	FRIDAY	ODD	3938	2	52
8128	FRIDAY	EVEN	3938	2	52
8129	THURSDAY	ODD	3754	1	67
8130	THURSDAY	EVEN	3754	1	67
8133	MONDAY	EVEN	3939	4	63
8134	TUESDAY	ODD	3822	1	67
8135	TUESDAY	EVEN	3822	1	67
8136	TUESDAY	ODD	3796	2	55
8137	TUESDAY	EVEN	3796	2	55
8138	TUESDAY	ODD	3939	3	63
8139	TUESDAY	EVEN	3939	3	63
8140	TUESDAY	EVEN	3902	4	55
8141	THURSDAY	ODD	3755	1	67
8142	THURSDAY	EVEN	3755	1	67
8145	MONDAY	ODD	3940	2	59
8146	MONDAY	ODD	3941	2	59
8147	MONDAY	ODD	3942	2	59
8148	MONDAY	EVEN	3940	2	59
8149	MONDAY	EVEN	3941	2	59
8150	MONDAY	EVEN	3942	2	59
8151	MONDAY	ODD	4078	4	60
8152	MONDAY	EVEN	4078	4	60
8153	TUESDAY	ODD	3953	1	55
8154	TUESDAY	EVEN	3953	1	55
8155	TUESDAY	ODD	3816	2	66
8156	TUESDAY	EVEN	3816	2	66
8157	TUESDAY	ODD	3946	3	65
8158	TUESDAY	ODD	3947	3	65
8159	TUESDAY	ODD	3948	3	65
8160	TUESDAY	EVEN	3946	3	65
8161	TUESDAY	EVEN	3947	3	65
8162	TUESDAY	EVEN	3948	3	65
8164	WEDNESDAY	ODD	3778	2	52
8165	WEDNESDAY	EVEN	3778	2	52
8166	THURSDAY	ODD	3809	1	55
8167	THURSDAY	EVEN	3809	1	55
8168	FRIDAY	ODD	3943	1	51
8169	FRIDAY	EVEN	3943	1	51
8170	FRIDAY	ODD	3952	2	58
8171	FRIDAY	EVEN	3952	2	58
8172	FRIDAY	ODD	3756	3	67
8173	FRIDAY	EVEN	3756	3	67
8174	MONDAY	ODD	3963	3	63
8175	MONDAY	EVEN	3963	3	63
8178	WEDNESDAY	ODD	3757	1	58
8179	WEDNESDAY	EVEN	3757	1	58
8185	THURSDAY	ODD	4081	1	59
8186	THURSDAY	ODD	4082	1	59
8187	THURSDAY	EVEN	4081	1	59
8188	THURSDAY	EVEN	4082	1	59
8189	FRIDAY	ODD	3962	1	68
8190	FRIDAY	EVEN	3962	1	68
8191	FRIDAY	ODD	3944	2	51
8192	FRIDAY	EVEN	3944	2	51
8193	FRIDAY	ODD	3922	3	63
8194	FRIDAY	EVEN	3922	3	63
8195	MONDAY	ODD	3945	3	51
8196	MONDAY	EVEN	3945	3	51
8201	TUESDAY	ODD	3951	4	57
8204	WEDNESDAY	ODD	3758	3	67
8205	WEDNESDAY	EVEN	3758	3	67
8208	FRIDAY	ODD	3810	1	63
8209	FRIDAY	EVEN	3810	1	63
8210	FRIDAY	ODD	3817	2	61
8211	FRIDAY	EVEN	3817	2	61
8212	MONDAY	ODD	4400	1	119
8213	MONDAY	ODD	4401	1	119
8214	MONDAY	ODD	4402	1	119
8215	MONDAY	ODD	4403	1	119
8216	MONDAY	EVEN	4400	1	119
8217	MONDAY	EVEN	4401	1	119
8131	MONDAY	ODD	4077	1	56
8132	MONDAY	EVEN	4077	1	56
8143	FRIDAY	ODD	3777	2	63
8144	FRIDAY	EVEN	3777	2	63
8163	TUESDAY	EVEN	3949	4	53
8206	THURSDAY	ODD	3965	3	66
8207	THURSDAY	EVEN	3965	3	66
8218	MONDAY	EVEN	4402	1	119
8219	MONDAY	EVEN	4403	1	119
8220	MONDAY	ODD	3973	2	119
8221	MONDAY	EVEN	3973	2	119
8222	MONDAY	ODD	4150	3	119
8223	MONDAY	ODD	4151	3	119
8224	MONDAY	ODD	4152	3	119
8225	MONDAY	ODD	4153	3	119
8226	MONDAY	ODD	4154	3	119
8227	MONDAY	ODD	4155	3	119
8228	MONDAY	ODD	4156	3	119
8229	MONDAY	ODD	4157	3	119
8230	MONDAY	ODD	4158	3	119
8231	MONDAY	ODD	4159	3	119
8232	MONDAY	EVEN	4150	3	119
8233	MONDAY	EVEN	4151	3	119
8234	MONDAY	EVEN	4152	3	119
8235	MONDAY	EVEN	4153	3	119
8236	MONDAY	EVEN	4154	3	119
8237	MONDAY	EVEN	4155	3	119
8238	MONDAY	EVEN	4156	3	119
8239	MONDAY	EVEN	4157	3	119
8240	MONDAY	EVEN	4158	3	119
8241	MONDAY	EVEN	4159	3	119
8242	MONDAY	ODD	4160	7	119
8243	MONDAY	EVEN	4160	7	119
8244	TUESDAY	ODD	4393	1	68
8245	TUESDAY	ODD	4394	1	68
8246	TUESDAY	ODD	4395	1	68
8247	TUESDAY	ODD	4396	1	68
8248	TUESDAY	ODD	4397	1	68
8249	TUESDAY	ODD	4398	1	68
8250	TUESDAY	ODD	4399	1	68
8251	TUESDAY	EVEN	4097	1	68
8252	TUESDAY	EVEN	4098	1	68
8253	TUESDAY	EVEN	4099	1	68
8254	TUESDAY	EVEN	4100	1	68
8255	TUESDAY	EVEN	4101	1	68
8256	TUESDAY	EVEN	4102	1	68
8257	TUESDAY	EVEN	4103	1	68
8258	TUESDAY	ODD	4104	2	56
8259	TUESDAY	EVEN	4104	2	56
8260	TUESDAY	ODD	3980	3	68
8261	TUESDAY	ODD	3981	3	68
8262	TUESDAY	ODD	3982	3	68
8263	TUESDAY	ODD	3983	3	68
8264	TUESDAY	ODD	3984	3	68
8265	TUESDAY	ODD	3985	3	68
8266	TUESDAY	ODD	3986	3	68
8267	TUESDAY	ODD	3987	3	68
8268	TUESDAY	ODD	3988	3	68
8269	TUESDAY	ODD	3989	3	68
8270	TUESDAY	EVEN	3980	3	68
8271	TUESDAY	EVEN	3981	3	68
8272	TUESDAY	EVEN	3982	3	68
8273	TUESDAY	EVEN	3983	3	68
8274	TUESDAY	EVEN	3984	3	68
8275	TUESDAY	EVEN	3985	3	68
8276	TUESDAY	EVEN	3986	3	68
8277	TUESDAY	EVEN	3987	3	68
8278	TUESDAY	EVEN	3988	3	68
8279	TUESDAY	EVEN	3989	3	68
8280	TUESDAY	ODD	4111	4	58
8281	TUESDAY	EVEN	4111	4	58
8282	WEDNESDAY	ODD	4127	1	55
8283	WEDNESDAY	EVEN	4127	1	55
8284	WEDNESDAY	ODD	4083	2	74
8285	WEDNESDAY	ODD	4084	2	74
8286	WEDNESDAY	ODD	4085	2	74
8287	WEDNESDAY	ODD	4086	2	74
8288	WEDNESDAY	ODD	4087	2	74
8289	WEDNESDAY	ODD	4088	2	74
8290	WEDNESDAY	ODD	4089	2	74
8291	WEDNESDAY	EVEN	4083	2	74
8292	WEDNESDAY	EVEN	4084	2	74
8293	WEDNESDAY	EVEN	4085	2	74
8294	WEDNESDAY	EVEN	4086	2	74
8295	WEDNESDAY	EVEN	4087	2	74
8296	WEDNESDAY	EVEN	4088	2	74
8297	WEDNESDAY	EVEN	4089	2	74
8298	WEDNESDAY	ODD	4090	3	52
8299	WEDNESDAY	EVEN	4090	3	52
8302	THURSDAY	ODD	4118	1	68
8303	THURSDAY	ODD	4119	1	68
8304	THURSDAY	ODD	4120	1	68
8305	THURSDAY	ODD	4121	1	68
8306	THURSDAY	ODD	4122	1	68
8307	THURSDAY	ODD	4123	1	68
8308	THURSDAY	ODD	4124	1	68
8309	THURSDAY	ODD	4125	1	68
8311	THURSDAY	EVEN	4136	1	68
8312	THURSDAY	EVEN	4137	1	68
8313	THURSDAY	EVEN	4138	1	68
8314	THURSDAY	EVEN	4139	1	68
8315	THURSDAY	EVEN	4140	1	68
8316	THURSDAY	EVEN	4141	1	68
8317	THURSDAY	EVEN	4142	1	68
8318	THURSDAY	ODD	4177	2	56
8319	THURSDAY	EVEN	4177	2	56
8320	THURSDAY	ODD	4170	3	74
8321	THURSDAY	ODD	4171	3	74
8322	THURSDAY	ODD	4172	3	74
8323	THURSDAY	ODD	4173	3	74
8324	THURSDAY	ODD	4174	3	74
8301	WEDNESDAY	EVEN	3991	4	53
8325	THURSDAY	ODD	4175	3	74
8326	THURSDAY	ODD	4176	3	74
8329	THURSDAY	EVEN	4172	3	74
8330	THURSDAY	EVEN	4173	3	74
8331	THURSDAY	EVEN	4174	3	74
8332	THURSDAY	EVEN	4175	3	74
8333	THURSDAY	EVEN	4176	3	74
8335	THURSDAY	EVEN	4000	4	53
8336	THURSDAY	EVEN	4001	4	53
8337	THURSDAY	EVEN	4002	4	53
8338	THURSDAY	EVEN	4003	4	53
8887	TUESDAY	ODD	4377	2	119
8888	TUESDAY	ODD	4378	2	119
8896	TUESDAY	EVEN	4388	3	119
8900	WEDNESDAY	ODD	4351	2	119
8334	THURSDAY	ODD	3991	4	53
8373	WEDNESDAY	EVEN	3992	4	53
8327	THURSDAY	EVEN	4170	3	74
8328	THURSDAY	EVEN	4171	3	74
8889	TUESDAY	EVEN	4377	2	119
8890	TUESDAY	EVEN	4378	2	119
8898	WEDNESDAY	EVEN	4349	1	119
9053	THURSDAY	EVEN	4228	1	53
8339	THURSDAY	EVEN	4004	4	53
8340	THURSDAY	EVEN	4005	4	53
8341	THURSDAY	EVEN	4006	4	53
8342	THURSDAY	ODD	4008	7	52
8343	THURSDAY	EVEN	4008	7	52
8344	FRIDAY	ODD	4143	1	52
8345	FRIDAY	EVEN	4143	1	52
8346	FRIDAY	ODD	3966	2	53
8347	FRIDAY	ODD	3967	2	53
8348	FRIDAY	ODD	3968	2	53
8349	FRIDAY	ODD	3969	2	53
8350	FRIDAY	ODD	3970	2	53
8351	FRIDAY	ODD	3971	2	53
8352	FRIDAY	ODD	3972	2	53
8353	FRIDAY	EVEN	3966	2	53
8354	FRIDAY	EVEN	3967	2	53
8355	FRIDAY	EVEN	3968	2	53
8356	FRIDAY	EVEN	3969	2	53
8357	FRIDAY	EVEN	3970	2	53
8358	FRIDAY	EVEN	3971	2	53
8359	FRIDAY	EVEN	3972	2	53
8360	MONDAY	ODD	3974	2	119
8361	MONDAY	EVEN	3974	2	119
8362	MONDAY	ODD	4161	7	119
8363	MONDAY	EVEN	4161	7	119
8364	TUESDAY	ODD	4105	2	56
8365	TUESDAY	EVEN	4105	2	56
8366	TUESDAY	ODD	4112	4	58
8367	TUESDAY	EVEN	4112	4	58
8368	WEDNESDAY	ODD	4128	1	55
8369	WEDNESDAY	EVEN	4128	1	55
8370	WEDNESDAY	ODD	4091	3	52
8371	WEDNESDAY	EVEN	4091	3	52
8374	THURSDAY	ODD	4178	2	56
8375	THURSDAY	EVEN	4178	2	56
8377	THURSDAY	ODD	4009	7	52
8378	THURSDAY	EVEN	4009	7	52
8379	FRIDAY	ODD	4144	1	52
8380	FRIDAY	EVEN	4144	1	52
8381	MONDAY	ODD	3976	2	119
8382	MONDAY	EVEN	3976	2	119
8383	MONDAY	ODD	4162	7	119
8384	TUESDAY	ODD	4092	2	60
8385	TUESDAY	EVEN	4092	2	60
8388	WEDNESDAY	ODD	4106	1	60
8389	WEDNESDAY	EVEN	4106	1	60
8390	WEDNESDAY	ODD	3993	3	57
8391	WEDNESDAY	EVEN	3993	3	57
8392	WEDNESDAY	ODD	4179	4	56
8393	WEDNESDAY	EVEN	4179	4	56
8394	THURSDAY	ODD	4129	2	55
8395	THURSDAY	EVEN	4129	2	55
8397	THURSDAY	ODD	4010	7	52
8398	THURSDAY	EVEN	4010	7	52
8399	MONDAY	EVEN	4162	7	119
8400	FRIDAY	ODD	4145	1	52
8401	FRIDAY	EVEN	4145	1	52
8402	MONDAY	ODD	3975	2	119
8403	MONDAY	EVEN	3975	2	119
8404	MONDAY	ODD	4163	7	119
8405	MONDAY	EVEN	4163	7	119
8406	TUESDAY	ODD	4093	2	60
8407	TUESDAY	EVEN	4093	2	60
8410	WEDNESDAY	ODD	4107	1	60
8411	WEDNESDAY	EVEN	4107	1	60
8412	WEDNESDAY	ODD	3994	3	57
8413	WEDNESDAY	EVEN	3994	3	57
8414	WEDNESDAY	ODD	4180	4	56
8415	WEDNESDAY	EVEN	4180	4	56
8416	THURSDAY	ODD	4130	2	55
8417	THURSDAY	EVEN	4130	2	55
8419	THURSDAY	ODD	4011	7	52
8420	THURSDAY	EVEN	4011	7	52
8421	FRIDAY	ODD	4146	1	52
8422	FRIDAY	EVEN	4146	1	52
8423	MONDAY	ODD	4404	1	119
8424	MONDAY	ODD	4405	1	119
8425	MONDAY	ODD	4406	1	119
8426	MONDAY	EVEN	4404	1	119
8427	MONDAY	EVEN	4405	1	119
8428	MONDAY	EVEN	4406	1	119
8429	MONDAY	ODD	4147	2	119
8376	THURSDAY	ODD	3992	4	53
8431	MONDAY	ODD	4164	4	119
8432	MONDAY	EVEN	4164	4	119
8433	TUESDAY	ODD	3990	2	54
8434	TUESDAY	EVEN	3990	2	54
8386	TUESDAY	ODD	4113	4	68
8436	TUESDAY	EVEN	4115	4	61
8437	TUESDAY	ODD	4115	4	61
8387	TUESDAY	EVEN	4113	4	68
8439	MONDAY	EVEN	4147	2	119
8440	WEDNESDAY	ODD	4412	1	56
8441	WEDNESDAY	ODD	4413	1	56
8442	WEDNESDAY	ODD	4414	1	56
8443	WEDNESDAY	EVEN	4412	1	56
8444	WEDNESDAY	EVEN	4413	1	56
8445	WEDNESDAY	EVEN	4414	1	56
8446	WEDNESDAY	ODD	4108	3	55
8447	WEDNESDAY	EVEN	4108	3	55
8448	WEDNESDAY	ODD	4094	4	52
8396	THURSDAY	ODD	3993	4	53
8408	TUESDAY	ODD	4114	4	68
8409	TUESDAY	EVEN	4114	4	68
8418	THURSDAY	ODD	3994	4	53
8449	WEDNESDAY	EVEN	4094	4	52
8453	FRIDAY	ODD	3977	3	56
8459	MONDAY	ODD	4165	4	119
8897	WEDNESDAY	EVEN	4348	1	119
8899	WEDNESDAY	ODD	4350	2	119
9054	WEDNESDAY	EVEN	4302	3	119
9055	WEDNESDAY	EVEN	4303	3	119
9058	WEDNESDAY	EVEN	4306	3	119
8450	THURSDAY	ODD	4181	2	60
8465	WEDNESDAY	ODD	4109	3	55
8901	WEDNESDAY	EVEN	4350	2	119
8902	WEDNESDAY	EVEN	4351	2	119
8907	WEDNESDAY	ODD	4338	4	119
8908	WEDNESDAY	ODD	4339	4	119
8911	THURSDAY	ODD	4330	1	119
8914	THURSDAY	EVEN	4334	2	119
8938	WEDNESDAY	EVEN	4352	1	119
8944	THURSDAY	EVEN	4365	1	119
8945	THURSDAY	EVEN	4366	1	119
8958	WEDNESDAY	EVEN	4383	2	119
8959	WEDNESDAY	EVEN	4384	2	119
8960	WEDNESDAY	ODD	4387	3	119
8961	WEDNESDAY	EVEN	4387	3	119
9056	WEDNESDAY	EVEN	4304	3	119
9057	WEDNESDAY	EVEN	4305	3	119
8451	THURSDAY	EVEN	4181	2	60
8455	FRIDAY	ODD	4007	4	52
8456	FRIDAY	EVEN	4007	4	52
8457	MONDAY	ODD	4148	2	119
8458	MONDAY	EVEN	4148	2	119
8460	MONDAY	EVEN	4165	4	119
8461	TUESDAY	ODD	3995	2	54
8903	WEDNESDAY	ODD	4336	3	119
8904	WEDNESDAY	ODD	4337	3	119
8909	WEDNESDAY	EVEN	4338	4	119
8910	WEDNESDAY	EVEN	4339	4	119
8913	THURSDAY	ODD	4332	2	119
8915	THURSDAY	ODD	4328	3	119
8916	THURSDAY	ODD	4329	3	119
8921	FRIDAY	EVEN	4055	1	119
8922	FRIDAY	EVEN	4054	1	119
8925	FRIDAY	EVEN	4056	2	119
8926	FRIDAY	EVEN	4057	2	119
9059	WEDNESDAY	EVEN	4451	2	119
8452	FRIDAY	ODD	3990	1	54
8454	FRIDAY	EVEN	3977	3	56
8463	TUESDAY	ODD	4116	4	61
8464	TUESDAY	EVEN	4116	4	61
8905	WEDNESDAY	EVEN	4336	3	119
8906	WEDNESDAY	EVEN	4337	3	119
8912	THURSDAY	EVEN	4330	1	119
8939	WEDNESDAY	EVEN	4362	2	119
8940	WEDNESDAY	ODD	4362	2	119
8954	WEDNESDAY	EVEN	4373	1	119
8955	WEDNESDAY	EVEN	4374	1	119
8956	WEDNESDAY	ODD	4383	2	119
8957	WEDNESDAY	ODD	4384	2	119
8968	THURSDAY	ODD	4381	1	119
8969	THURSDAY	EVEN	4382	1	119
8970	THURSDAY	ODD	4379	3	119
8971	THURSDAY	EVEN	4380	3	119
8972	THURSDAY	EVEN	4380	2	119
9060	WEDNESDAY	ODD	4446	3	119
9061	WEDNESDAY	ODD	4447	3	119
9062	WEDNESDAY	ODD	4448	3	119
9063	WEDNESDAY	ODD	4449	3	119
9064	WEDNESDAY	ODD	4450	3	119
8462	TUESDAY	EVEN	3995	2	54
8466	WEDNESDAY	EVEN	4109	3	55
8467	WEDNESDAY	ODD	4095	4	52
8468	WEDNESDAY	EVEN	4095	4	52
8469	WEDNESDAY	ODD	4186	7	52
8470	WEDNESDAY	ODD	4187	7	52
8471	WEDNESDAY	EVEN	4186	7	52
8472	WEDNESDAY	EVEN	4187	7	52
8473	THURSDAY	ODD	4182	2	60
8474	THURSDAY	EVEN	4182	2	60
8477	THURSDAY	ODD	4184	7	57
8478	THURSDAY	ODD	4185	7	57
8479	FRIDAY	ODD	3995	1	54
8480	FRIDAY	ODD	3978	3	56
8481	FRIDAY	EVEN	3978	3	56
8482	FRIDAY	ODD	4012	4	52
8483	FRIDAY	EVEN	4012	4	52
8484	MONDAY	ODD	4149	2	119
8485	MONDAY	EVEN	4149	2	119
8486	MONDAY	ODD	4166	4	119
8487	MONDAY	EVEN	4166	4	119
8488	TUESDAY	ODD	3996	2	54
8489	TUESDAY	EVEN	3996	2	54
8490	WEDNESDAY	ODD	4096	3	63
8491	WEDNESDAY	EVEN	4096	3	63
8917	THURSDAY	EVEN	4328	3	119
8918	THURSDAY	EVEN	4329	3	119
8494	WEDNESDAY	ODD	4183	4	60
8919	FRIDAY	ODD	4055	1	119
8496	THURSDAY	ODD	4110	2	63
8497	THURSDAY	EVEN	4110	2	63
8498	FRIDAY	ODD	3996	1	54
8499	FRIDAY	EVEN	3979	3	56
8500	FRIDAY	ODD	3979	3	56
8501	FRIDAY	ODD	4013	4	52
8502	FRIDAY	EVEN	4013	4	52
8503	THURSDAY	ODD	4206	2	53
8504	THURSDAY	ODD	4207	2	53
8505	THURSDAY	ODD	4208	2	53
8506	THURSDAY	EVEN	4206	2	53
8507	THURSDAY	EVEN	4207	2	53
8508	THURSDAY	EVEN	4208	2	53
8509	THURSDAY	ODD	4211	1	60
8510	THURSDAY	ODD	4210	1	60
8511	MONDAY	ODD	4168	1	119
8512	MONDAY	ODD	4169	1	119
8513	MONDAY	EVEN	4168	1	119
8514	MONDAY	EVEN	4169	1	119
8515	MONDAY	ODD	4199	2	119
8516	MONDAY	ODD	4198	2	119
8517	MONDAY	EVEN	4199	2	119
8518	MONDAY	EVEN	4198	2	119
8519	MONDAY	ODD	4167	2	119
8520	MONDAY	EVEN	4167	2	119
8521	TUESDAY	ODD	4197	1	56
8522	TUESDAY	EVEN	4197	1	56
8523	TUESDAY	ODD	4194	2	74
8524	TUESDAY	ODD	4195	2	74
8525	TUESDAY	ODD	4196	2	74
8526	TUESDAY	EVEN	4194	2	74
8527	TUESDAY	EVEN	4195	2	74
8528	TUESDAY	EVEN	4196	2	74
8529	TUESDAY	ODD	3997	4	54
8530	TUESDAY	ODD	3998	4	54
8531	TUESDAY	ODD	3999	4	54
8532	WEDNESDAY	ODD	4188	1	53
8533	WEDNESDAY	ODD	4189	1	53
8534	WEDNESDAY	ODD	4190	1	53
8535	WEDNESDAY	EVEN	4188	1	53
8536	WEDNESDAY	EVEN	4189	1	53
8537	WEDNESDAY	EVEN	4190	1	53
8538	WEDNESDAY	ODD	4191	2	60
8540	WEDNESDAY	EVEN	4191	3	60
8541	THURSDAY	EVEN	4209	1	60
8542	THURSDAY	ODD	4212	3	61
8543	THURSDAY	ODD	4213	3	61
8544	THURSDAY	ODD	4214	3	61
8545	THURSDAY	EVEN	4212	3	61
8546	THURSDAY	EVEN	4213	3	61
8547	THURSDAY	EVEN	4214	3	61
8548	THURSDAY	ODD	4200	4	59
8549	THURSDAY	ODD	4201	4	59
8550	THURSDAY	ODD	4202	4	59
8551	THURSDAY	EVEN	4200	4	59
8552	THURSDAY	EVEN	4201	4	59
8553	THURSDAY	EVEN	4202	4	59
8554	FRIDAY	ODD	4017	1	56
8555	FRIDAY	ODD	4014	2	65
8556	FRIDAY	ODD	4015	2	65
8557	FRIDAY	ODD	4016	2	65
8558	FRIDAY	EVEN	4014	2	65
8559	FRIDAY	EVEN	4015	2	65
8560	FRIDAY	EVEN	4016	2	65
8561	FRIDAY	ODD	3997	3	54
8562	FRIDAY	ODD	3998	3	54
8563	FRIDAY	ODD	3999	3	54
8564	FRIDAY	EVEN	3997	3	54
8565	FRIDAY	EVEN	3998	3	54
8566	FRIDAY	EVEN	3999	3	54
8569	WEDNESDAY	EVEN	4192	2	60
8570	WEDNESDAY	EVEN	4193	2	60
8571	WEDNESDAY	ODD	4192	3	60
8567	WEDNESDAY	ODD	4204	2	57
8476	THURSDAY	ODD	4185	4	74
8475	THURSDAY	ODD	4184	4	74
8568	WEDNESDAY	ODD	4205	2	57
8572	WEDNESDAY	ODD	4193	3	60
8920	FRIDAY	ODD	4054	1	119
8923	FRIDAY	ODD	4056	2	119
8924	FRIDAY	ODD	4057	2	119
8931	MONDAY	EVEN	4369	4	119
8932	MONDAY	EVEN	4370	4	119
8941	WEDNESDAY	EVEN	4361	3	119
8948	THURSDAY	EVEN	4363	2	119
8949	THURSDAY	EVEN	4364	2	119
8966	FRIDAY	ODD	4385	2	119
8967	FRIDAY	EVEN	4385	2	119
8975	MONDAY	ODD	3651	3	57
8976	MONDAY	ODD	3652	3	57
8974	FRIDAY	EVEN	3733	1	65
9065	WEDNESDAY	ODD	4419	4	72
9066	WEDNESDAY	ODD	4420	4	72
9067	WEDNESDAY	ODD	4421	4	72
9068	WEDNESDAY	ODD	4422	4	72
9069	WEDNESDAY	ODD	4423	4	72
9070	WEDNESDAY	ODD	4424	4	72
9071	WEDNESDAY	ODD	4425	4	72
9072	WEDNESDAY	ODD	4426	4	72
9073	WEDNESDAY	ODD	4427	4	72
9074	WEDNESDAY	ODD	4428	4	72
9075	WEDNESDAY	ODD	4441	4	72
9076	WEDNESDAY	ODD	4442	4	72
9092	WEDNESDAY	EVEN	4443	4	72
9093	WEDNESDAY	EVEN	4444	4	72
9094	WEDNESDAY	EVEN	4445	4	72
9095	WEDNESDAY	EVEN	4452	2	119
8573	FRIDAY	EVEN	4018	1	56
8574	FRIDAY	EVEN	4019	1	56
8576	MONDAY	EVEN	4215	1	60
8591	THURSDAY	EVEN	4025	2	74
8592	THURSDAY	EVEN	4026	2	74
8593	THURSDAY	EVEN	4027	2	74
8929	MONDAY	ODD	4369	4	119
8930	MONDAY	ODD	4370	4	119
8937	WEDNESDAY	ODD	4353	1	119
8946	THURSDAY	ODD	4363	2	119
8947	THURSDAY	ODD	4364	2	119
8964	FRIDAY	EVEN	4058	1	119
8965	FRIDAY	EVEN	4059	1	119
8973	THURSDAY	ODD	4382	2	119
9077	WEDNESDAY	ODD	4443	4	72
9078	WEDNESDAY	ODD	4444	4	72
9079	WEDNESDAY	ODD	4445	4	72
8575	MONDAY	ODD	4215	1	60
8577	MONDAY	ODD	4216	2	51
8579	MONDAY	ODD	4217	4	52
8580	MONDAY	EVEN	4216	4	52
8588	THURSDAY	ODD	4025	2	74
8589	THURSDAY	ODD	4026	2	74
8590	THURSDAY	ODD	4027	2	74
8600	FRIDAY	ODD	4024	2	74
8977	TUESDAY	ODD	3828	3	56
7976	TUESDAY	EVEN	3748	1	59
8083	TUESDAY	ODD	3819	2	59
8984	TUESDAY	ODD	4079	2	65
8985	TUESDAY	ODD	4080	2	65
8990	TUESDAY	ODD	4232	7	119
8999	MONDAY	EVEN	4359	2	119
9000	MONDAY	EVEN	4360	2	119
9003	TUESDAY	EVEN	4354	1	119
9004	TUESDAY	EVEN	4416	1	119
9007	TUESDAY	ODD	4356	3	119
9008	TUESDAY	ODD	4415	3	119
9009	WEDNESDAY	ODD	4058	1	119
9010	WEDNESDAY	ODD	4059	1	119
9080	WEDNESDAY	EVEN	4419	4	72
9081	WEDNESDAY	EVEN	4420	4	72
9082	WEDNESDAY	EVEN	4421	4	72
9083	WEDNESDAY	EVEN	4422	4	72
9084	WEDNESDAY	EVEN	4423	4	72
9085	WEDNESDAY	EVEN	4424	4	72
9086	WEDNESDAY	EVEN	4425	4	72
9087	WEDNESDAY	EVEN	4426	4	72
9088	WEDNESDAY	EVEN	4427	4	72
9089	WEDNESDAY	EVEN	4428	4	72
9090	WEDNESDAY	EVEN	4441	4	72
9091	WEDNESDAY	EVEN	4442	4	72
8578	MONDAY	EVEN	4216	2	51
8587	THURSDAY	EVEN	4134	1	56
8598	FRIDAY	ODD	4022	2	74
8599	FRIDAY	ODD	4023	2	74
8601	FRIDAY	EVEN	4022	2	74
8602	FRIDAY	EVEN	4023	2	74
8603	FRIDAY	EVEN	4024	2	74
8978	TUESDAY	ODD	3720	1	65
8979	TUESDAY	ODD	3721	1	65
8986	TUESDAY	EVEN	4079	2	65
8987	TUESDAY	EVEN	4080	2	65
8988	TUESDAY	ODD	3818	1	66
8989	TUESDAY	EVEN	3818	1	66
8983	TUESDAY	EVEN	3964	1	74
9096	WEDNESDAY	ODD	4455	4	119
9097	WEDNESDAY	ODD	4456	4	119
9099	TUESDAY	ODD	4439	7	62
9100	TUESDAY	EVEN	4439	7	62
9103	WEDNESDAY	ODD	4436	7	121
9104	WEDNESDAY	ODD	4437	7	121
9105	WEDNESDAY	ODD	4429	7	121
9106	WEDNESDAY	ODD	4430	7	121
9107	WEDNESDAY	ODD	4431	7	121
9108	WEDNESDAY	ODD	4432	7	121
9109	WEDNESDAY	ODD	4433	7	121
9110	WEDNESDAY	ODD	4434	7	121
9111	WEDNESDAY	ODD	4435	7	121
9112	WEDNESDAY	ODD	4438	7	121
9123	THURSDAY	ODD	4331	1	119
9124	THURSDAY	EVEN	4331	1	119
9127	TUESDAY	ODD	4457	4	68
9128	TUESDAY	EVEN	4457	4	68
8581	TUESDAY	EVEN	4218	1	68
8980	TUESDAY	EVEN	3720	1	65
8584	TUESDAY	ODD	4134	3	52
8981	TUESDAY	EVEN	3721	1	65
8982	TUESDAY	ODD	3964	1	74
9098	WEDNESDAY	ODD	4453	4	119
9101	TUESDAY	ODD	4440	4	51
9102	TUESDAY	EVEN	4440	4	51
9113	WEDNESDAY	EVEN	4436	7	121
9114	WEDNESDAY	EVEN	4437	7	121
9115	WEDNESDAY	EVEN	4429	7	121
9116	WEDNESDAY	EVEN	4430	7	121
9117	WEDNESDAY	EVEN	4431	7	121
9118	WEDNESDAY	EVEN	4432	7	121
9119	WEDNESDAY	EVEN	4433	7	121
9120	WEDNESDAY	EVEN	4434	7	121
9121	WEDNESDAY	EVEN	4435	7	121
9122	WEDNESDAY	EVEN	4438	7	121
9125	THURSDAY	ODD	4333	2	119
8585	WEDNESDAY	ODD	4219	2	63
8586	WEDNESDAY	EVEN	4219	2	63
8607	TUESDAY	ODD	4021	2	52
8608	TUESDAY	EVEN	4021	2	52
8609	FRIDAY	ODD	4020	1	68
8610	FRIDAY	EVEN	4020	1	68
8611	TUESDAY	ODD	4224	1	119
8612	TUESDAY	ODD	4225	1	119
8613	TUESDAY	EVEN	4224	1	119
8614	TUESDAY	EVEN	4225	1	119
8615	TUESDAY	ODD	4224	2	119
8616	TUESDAY	ODD	4225	2	119
8617	TUESDAY	EVEN	4226	2	119
8618	TUESDAY	EVEN	4227	2	119
8619	TUESDAY	EVEN	4226	3	119
8620	TUESDAY	EVEN	4227	3	119
8622	TUESDAY	ODD	4235	4	119
8623	TUESDAY	ODD	4236	4	119
8624	TUESDAY	ODD	4237	4	119
8625	TUESDAY	EVEN	4235	4	119
8626	TUESDAY	EVEN	4236	4	119
8627	TUESDAY	EVEN	4237	4	119
8628	WEDNESDAY	ODD	4238	1	51
8629	WEDNESDAY	EVEN	4238	1	51
8630	WEDNESDAY	ODD	4239	2	51
8631	WEDNESDAY	EVEN	4230	2	51
8632	WEDNESDAY	ODD	4231	3	51
8633	WEDNESDAY	EVEN	4231	3	51
8634	THURSDAY	ODD	4229	3	55
8635	THURSDAY	EVEN	4229	3	55
8641	WEDNESDAY	EVEN	4242	1	61
8642	WEDNESDAY	ODD	4242	2	66
8643	WEDNESDAY	EVEN	4242	2	66
8644	WEDNESDAY	ODD	4243	3	66
8662	THURSDAY	ODD	4244	3	74
8659	THURSDAY	EVEN	4244	3	74
8647	MONDAY	EVEN	4032	1	119
8648	MONDAY	EVEN	4032	2	119
8660	THURSDAY	ODD	4033	4	67
8650	WEDNESDAY	ODD	4245	4	60
8651	WEDNESDAY	EVEN	4183	4	60
8652	TUESDAY	ODD	4117	4	61
8653	TUESDAY	EVEN	4117	4	61
8654	MONDAY	ODD	4240	3	119
8655	MONDAY	EVEN	4240	3	119
8656	WEDNESDAY	EVEN	4245	4	60
8657	THURSDAY	EVEN	4126	1	68
8661	THURSDAY	EVEN	4033	4	67
8664	FRIDAY	EVEN	4135	1	52
8665	MONDAY	ODD	4032	2	119
8666	WEDNESDAY	EVEN	4243	3	66
8669	MONDAY	ODD	4340	1	119
8670	MONDAY	ODD	4341	1	119
8671	MONDAY	EVEN	4340	1	119
8672	MONDAY	EVEN	4341	1	119
8673	MONDAY	ODD	4342	2	119
8674	MONDAY	ODD	4343	2	119
8675	MONDAY	EVEN	4342	2	119
8676	MONDAY	EVEN	4343	2	119
8677	MONDAY	ODD	4326	3	119
8678	MONDAY	ODD	4327	3	119
8679	MONDAY	EVEN	4326	3	119
8680	MONDAY	EVEN	4327	3	119
8681	TUESDAY	ODD	4334	1	119
8682	TUESDAY	ODD	4335	1	119
8683	TUESDAY	EVEN	4344	1	119
8684	TUESDAY	EVEN	4345	1	119
8685	TUESDAY	ODD	4346	2	119
8686	TUESDAY	ODD	4347	2	119
8687	TUESDAY	EVEN	4346	2	119
8688	TUESDAY	EVEN	4347	2	119
8689	MONDAY	ODD	4367	3	119
8690	MONDAY	ODD	4368	3	119
8691	MONDAY	EVEN	4367	3	119
8692	MONDAY	EVEN	4368	3	119
8703	TUESDAY	ODD	4233	7	119
8706	TUESDAY	ODD	4234	7	119
8707	MONDAY	ODD	4281	1	119
8708	MONDAY	ODD	4280	1	119
8709	MONDAY	ODD	4279	1	119
8710	MONDAY	EVEN	4281	1	119
8711	MONDAY	EVEN	4280	1	119
8712	MONDAY	EVEN	4279	1	119
8663	FRIDAY	ODD	4135	1	52
8667	FRIDAY	ODD	4241	3	53
8668	FRIDAY	EVEN	4241	3	53
8604	FRIDAY	ODD	4030	3	121
8605	FRIDAY	EVEN	4028	3	121
8606	FRIDAY	ODD	4028	4	121
8638	FRIDAY	ODD	4029	3	121
8639	FRIDAY	EVEN	4031	3	121
8640	FRIDAY	ODD	4031	4	121
8713	MONDAY	ODD	4267	2	119
8714	MONDAY	ODD	4268	2	119
8733	MONDAY	ODD	4297	7	119
8734	MONDAY	ODD	4298	7	119
8735	MONDAY	ODD	4299	7	119
8736	MONDAY	ODD	4300	7	119
8737	MONDAY	ODD	4301	7	119
8997	MONDAY	EVEN	4359	1	119
8998	MONDAY	EVEN	4360	1	119
9001	TUESDAY	ODD	4359	1	119
9002	TUESDAY	ODD	4360	1	119
9005	TUESDAY	EVEN	4371	2	119
9006	TUESDAY	ODD	4372	2	119
9126	THURSDAY	EVEN	4335	2	119
8715	MONDAY	ODD	4269	2	119
8716	MONDAY	ODD	4270	2	119
8717	MONDAY	ODD	4271	2	119
8718	MONDAY	EVEN	4267	2	119
8719	MONDAY	EVEN	4268	2	119
8720	MONDAY	EVEN	4269	2	119
8721	MONDAY	EVEN	4270	2	119
8722	MONDAY	EVEN	4271	2	119
9011	WEDNESDAY	EVEN	4354	4	119
9012	WEDNESDAY	EVEN	4416	4	119
9015	THURSDAY	EVEN	4363	3	119
9017	THURSDAY	ODD	4365	3	119
9018	THURSDAY	ODD	4366	3	119
9030	FRIDAY	EVEN	3685	1	53
8738	MONDAY	EVEN	4297	7	119
8739	MONDAY	EVEN	4298	7	119
8740	MONDAY	EVEN	4299	7	119
8741	MONDAY	EVEN	4300	7	119
8742	MONDAY	EVEN	4301	7	119
8743	MONDAY	ODD	4292	4	119
8744	MONDAY	ODD	4293	4	119
8745	MONDAY	ODD	4294	4	119
8746	MONDAY	ODD	4295	4	119
8747	MONDAY	ODD	4296	4	119
8748	MONDAY	EVEN	4292	4	119
8749	MONDAY	EVEN	4293	4	119
8750	MONDAY	EVEN	4294	4	119
8751	MONDAY	EVEN	4295	4	119
8752	MONDAY	EVEN	4296	4	119
8753	TUESDAY	ODD	4276	1	119
8754	TUESDAY	ODD	4275	1	119
8755	TUESDAY	ODD	4274	1	119
8756	TUESDAY	EVEN	4276	1	119
8757	TUESDAY	EVEN	4275	1	119
8758	TUESDAY	EVEN	4274	1	119
8759	MONDAY	ODD	4273	1	119
8760	MONDAY	EVEN	4273	1	119
8761	MONDAY	ODD	4277	3	119
8762	MONDAY	EVEN	4277	3	119
8763	MONDAY	ODD	4272	1	119
8764	MONDAY	EVEN	4272	1	119
8765	MONDAY	ODD	4278	3	119
8766	TUESDAY	EVEN	4252	1	119
8767	MONDAY	EVEN	4278	3	119
8768	TUESDAY	EVEN	4251	1	119
8769	TUESDAY	ODD	4246	2	119
8770	TUESDAY	ODD	4247	2	119
8771	TUESDAY	ODD	4248	2	119
8772	TUESDAY	ODD	4249	2	119
8773	TUESDAY	ODD	4250	2	119
8774	TUESDAY	EVEN	4246	2	119
8775	TUESDAY	EVEN	4247	2	119
8776	TUESDAY	EVEN	4248	2	119
8777	TUESDAY	EVEN	4249	2	119
8778	TUESDAY	EVEN	4250	2	119
8779	TUESDAY	ODD	4322	3	119
8780	TUESDAY	ODD	4323	3	119
8781	TUESDAY	EVEN	4322	3	119
8782	TUESDAY	EVEN	4323	3	119
9013	WEDNESDAY	ODD	4356	4	119
9014	WEDNESDAY	ODD	4415	4	119
9016	THURSDAY	EVEN	4364	3	119
9019	THURSDAY	ODD	4386	4	119
9022	THURSDAY	ODD	4222	4	119
9023	THURSDAY	ODD	4223	4	119
9026	FRIDAY	EVEN	3734	1	65
9028	FRIDAY	ODD	2856	1	65
9029	FRIDAY	ODD	2857	1	65
9034	FRIDAY	EVEN	2945	3	60
9035	TUESDAY	ODD	3688	3	66
9036	FRIDAY	EVEN	3739	1	60
9037	FRIDAY	ODD	3739	3	60
9038	TUESDAY	ODD	3687	3	66
9040	WEDNESDAY	ODD	3718	3	65
9041	WEDNESDAY	ODD	3719	3	65
\.


--
-- Data for Name: semester_day; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.semester_day (semester_id, day) FROM stdin;
55	WEDNESDAY
55	THURSDAY
55	MONDAY
55	TUESDAY
55	FRIDAY
\.


--
-- Data for Name: semester_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.semester_group (semester_id, group_id) FROM stdin;
55	56
55	37
55	43
55	33
55	28
55	52
55	30
55	49
55	41
55	27
55	71
55	86
55	70
55	63
55	84
55	87
55	62
55	60
55	59
55	50
55	42
55	55
55	29
55	72
55	5
55	45
55	26
55	38
55	66
55	53
55	31
55	64
55	65
55	73
55	36
55	85
55	57
55	32
55	46
55	51
55	39
55	44
55	61
55	67
55	40
55	58
55	54
55	68
55	92
55	93
55	94
55	95
55	98
55	100
55	102
55	103
55	104
55	105
55	106
\.


--
-- Data for Name: semester_period; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.semester_period (semester_id, period_id) FROM stdin;
55	1
55	2
55	3
55	4
55	7
\.


--
-- Data for Name: semesters; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.semesters (id, current_semester, description, disable, end_day, start_day, year, default_semester) FROM stdin;
53	f	2	f	2022-05-19	2022-02-01	2022	f
55	t	1 семестр 23/24	f	2023-12-22	2023-09-01	2023	t
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.students (id, name, patronymic, surname, group_id, user_id) FROM stdin;
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.subjects (id, disable, name) FROM stdin;
7	t	Pain
10	t	IOS
1	t	Computer Science
4	t	Node.js
3	t	Бекенд
2	t	Фронтенд
169	f	Українська  мова (за професійним спрямуванням)
15	f	Програмування
14	f	Алгебра і геометрія
13	f	Фізичне виховання
18	f	Іноземна мова
65	f	Вибрані розділи математичної фізики
170	f	Архітектура комп'ютерів
17	f	Дискретна математика
57	f	Диференціальна геометрія
114	f	Суч.ймовірн.задачі оптим.керув.та їх реалізація на ПК
32	f	Технології програмування на Java
58	f	Комплексний аналіз
86	f	Математична логіка
89	f	Мат.статистика з елементами теорії випадкових процесів
79	f	Методика викладання інформатики в початковій школі
33	f	Моделювання жорстких систем
93	f	Основи криптології
62	f	Основи медичний знань
67	f	Платформи корпоративних інформаційних систем
48	f	Програмування мовою Python
52	f	Психологія (загальна, вікова, педагогічна)
35	f	Сучасні СУБД
257	f	Актуальні питання історії та культури України
22	f	Лінійна алгебра
24	f	Аналітична геометрія
25	f	Вступ до спеціальності
26	f	Бази даниих та інформаційні системи
27	f	Операційні системи
28	f	Професійна іноземна мова
30	f	Теорія ймовірностей та математична статистика
31	f	Теорія програмування
36	f	Теорія алгоритмів
37	f	Основи теорії систем
39	f	Числові методи
40	f	Основи інтернет-технологгій
41	f	Математична теорія ризиків
42	f	Комп'ютерна математика
43	f	Іноземна мова (за професійним спрямуванням)
44	f	Алгоритми і структури даних
45	f	Диференціальні рівняння
46	f	Об'єктно-орієнтоване програмування
77	f	Технології програмування мовою Python
50	f	Комп'ютерні мережі
51	f	Прикладний функціональний аналіз
53	f	Основи інформаційних технологій
54	f	Математичний аналіз2
16	f	Математичний аналіз1
55	f	Математичний аналіз
56	f	Алгебра і теорія чисел
60	f	Рівняння математичної фізики
61	f	Елементарна математика і методика викладання математики
63	f	Методика викладання математики
64	f	Методика викладання інформатики
66	f	Методи оптимізації та дослідження операцій
68	f	Проектування програмних систем
69	f	Системи та методи прийняття рішень
72	f	Теорія керування
73	f	Системний аналіз та теорія прийняття рішень
74	f	Випадкові процеси
75	f	Методи оптимізації
76	f	Основи математичного моделювання та системного аналізу
80	f	Інформаційно-комунікаційні технології в освіті
59	f	Теорія міри та інтеграла
83	f	Методи обчислень
84	f	Методика впровадження дослідних робіт з інформатики
92	f	Топологічні векторні простори
178	f	Обчислювальні методи
179	f	Філософія
82	f	Методика розв'язування олімп. задач з ІТ
94	f	Науковий семінар
99	f	Маг.семінар "Сучасні інформаційні технології"
102	f	Основи наукових досліджень
103	f	Математичний аналіз*
106	f	Інф.системи і техн.створення та управління проектами
107	f	Математичне моделювання динамічних систем і процесів
108	f	Мережеві інформаційні технології
109	f	Обробка структурованих та нестрктурованих даних BigData
110	f	Системи штучного інтелекту
111	f	Програмні засоби управління проектами
116	f	Розробка професійного програмного забезпечення
119	f	Системи і методи захисту інформації
121	f	Професійне та особистісне становлення вчителя ЗНЗ
122	f	Технології викладання математики у закладах освіти
123	f	Теорія функцій багатьох змінних
171	f	Математична логіка та теорія алгоритмів
128	f	Диференц.моделі соціальних та природничих процесів
129	f	Зображення геометричних фігур у просторі
78	f	Frontend-розробка Web-додатків
132	f	Англійська мова
133	f	Німецька мова
134	f	Французька мова
100	f	Філософія освіти і науки
173	f	Архітектура обчислювальних систем
174	f	Пакети прикладних програм
175	f	Олімпіадні задачі з інформаційних технологій
124	f	Інноваційні технології навчання в сучасній школі
81	f	Хмарні технології в освіті
130	f	Конфліктно-керовані процеси та нелінійні моделі
97	f	Інтелектуальна власність в ІТ-галузі
96	f	Комунікації та теорії конфліктів
117	t	Методи Data Science
105	f	Педагогіка і психологія вищої школи
95	f	Охорона праці в ІТ-галузі
113	f	Інтелектуальні системи прийняття рішень
118	f	Розробка крос-платформених додатків
258	f	Використання MS Excel y BigData
101	f	Охорона праці в галузі та цивільний захист
131	f	Системи та методи захисту інформації
115	f	Технології розробки розподілених баз даних
181	f	Поглиблена 3D графіка
182	f	Інформаційні технології менеджменту
183	f	Бібліотеки мови Python
184	f	Бази даних та знань
49	f	Громадське здоров'я та медицина порятунку
185	f	Програмування у Visual Studio NET
186	f	Математичне моделювання еволюційних процесів
187	f	Розробка UI/UX дизайну
188	f	Педагогіка з основами педмайстерності
189	f	Комп'ютерні мережі та Інтернет
190	f	Програмно-педагогічні засоби навчання
191	f	Векторна та растрова графіка
192	f	Обчислювальна геометрія
193	f	Топологія
196	f	Захист інформації
197	f	Платформи корпоративних інформ.систем
198	f	Програмування та підтримка Веб-застосунків
199	f	Системне програмування
201	f	Основи інформаційної безпеки
202	f	Теорія інформації та кодування
203	f	Серверна мова РНР
204	f	Контроль якості та тестування програмного забезпечення
205	f	Web-дизайн
207	f	Інтерпретована динамічна візуальна мова програмування
208	f	Функціональний аналіз
209	f	Нестандартні задачі математики та методи їх розв'язання
71	f	Комунікаційні технології в управлінні проектами
211	f	Загальна теорія функцій
212	f	Сучасні інформаційні технології
213	f	Теорія ймовірностей
194	f	Обробка зображень та мультимедія
214	f	Інтелектуальні інформаційні системи
215	f	Аналіз даних
218	f	Розробка комп'ютерних ігор
219	f	Актуарна математика
220	f	Теорія компіляції
221	f	Математичне моделювання природничих процесів
222	f	Варіаційне числення і методи оптимізації
223	f	Управління навчальними процесами
224	f	Базові алгоритми олімпіадних задач з інформатики
225	f	Методика розв'язування олімпіадних задач з математики
226	f	Інформаційні технології у підготовці дидакт.матеріалів
228	f	Основи геометрії
230	f	Методологія та організація наукових досліджень
231	f	Багатопроцесорні машини та техн.паралельного прогр.
232	f	Маркетингові комунікації в інформаційному суспільстві
233	f	Методика викладання комп.наук у вищій школі
235	f	Комунікаційні технології аналітичних систем
236	f	Інтелект.системи прийняття рішень
237	f	Системи машинного навчання
238	f	Програмні засоби в системному аналізі
239	f	Технології паралельного програмування
240	f	Моделювання соціальних та кризових явищ
243	f	Розробка мобільних додатків для ОС Android
244	f	Java-технології в клієнт-серверних системах
245	f	Паралельне програмування
246	f	Магістерський семінар 1
248	f	Задачі з параметрами
249	f	Сучасні технології в дистанційній освіті
251	f	Класифікація методів розв'язування олімпіадних задач
253	f	Методика викладання математики у закладах вищої освіти
254	f	Теорія наближень
255	f	Комунікаційні техн.в управлінні проектами
241	f	Сучасні клієнтські Web-технології
19	t	Актуальні питання історії та кул.України
259	f	Алгебра і геометрія*
260	f	Лінійна алгебра*
261	f	Диференціальні рівняння.
262	f	Ств.веб-додатків з вик.фреймворку Django мови Python
264	f	Основи інклюзивної освіти
217	f	Розробка програмних додатків для мобільних пристроїв
112	f	Сіткове планування
267	f	Історія математики
268	f	Задачі прикладного характеру
85	f	Геометричні перетворення
269	f	Стереометрія в задачах
271	f	Олімпіадні задачі з алгебри і теорії чисел
272	f	Прогнозування в системному аналізі
274	f	Методи DataScience
277	f	Партнерство і професійна комунікація вчителя
278	f	Технології викладання інформатики у закладах освіти
200	f	Математичні моделі макро- і мікроекономіки
242	f	Комп'ютерне моделювання еколого-економ.систем
176	f	Обчислювальна геометрія та комп'ютерна графіка
276	f	Інклюзивна педагогіка
234	f	Моделювання соціального-економічних та еколог.процесів
265	f	Вибрані питання Ріманової геометрії
206	f	Методика соціально-виховної роботи в сучасних умовах
279	f	Розподілені інформаційно-аналітичні системи
281	f	Практика особистої та ділової комунікації іноземною мовою
288	f	Ознайомлювальна практика
290	f	Математична логіка та теорія алгоритмів*
291	f	Архітектура ПК
292	f	Фінансова математика
293	f	3D графіка та моделювання
294	f	ІТ та онлайн сервіси в професійній діяльності вчителя*
295	f	Векторні гратки
296	f	Прикладні алгоритми теорії чисел
297	f	Професійно зорієнтована практика
298	f	Предметний практикум
299	f	Навчально-педагогічна практика
300	f	Професійно зорієнтована практика з елементами програмування
301	f	Інтелектуальний аналіз даних та моделювання кризових явищ
302	f	Інформаційні системи і  технології створення та управління проектами
303	f	Інформаційні системи та технології в системному аналізі
304	f	Технології Blockechain та прогнозування фінансових ризиків
305	f	Бізнес аналіз в ІТ-проектах
306	f	Математична майстерня
307	f	Web-розробка з використанням фреймворків
308	f	Адміністрування навчальних систем
309	f	Мережні інформаційні та освітні системи
310	f	Особливості розв'язування олімп.задач з інформатики та ІТ
311	f	Лідерство та основи партнерської взаємодії в освітньому процесі
312	f	Математичні студії (особливості викладання інформатики у початк.та середній НУШ
313	f	STEM-практики в освіті
314	f	Принципи та методи навчання інформатики в закладах освіти
315	f	Методика навчання математики в закладах освіти
316	f	Геометричні та комбінаторні олімпіадні задачі
317	f	Польська мова для професійного спілкування
318	f	Методика організації позаурочної роботи з математики
319	f	Методика розв'язування олімпіадних задач з інформатики
320	f	Комп'ютерні технології у тестуванні
321	f	Інформаційні технології у підготовці дидактичних матеріалів
322	f	Чинники успішного працевлаштування
323	f	Python для Data Science
324	f	Бази даних у навчальному процесі
325	f	Створення веб-додатків з використанням фреймворку Django мови Python
326	f	Бази даних та інформаційні системи
70	f	Інформаційні системи обліку та логістика
328	f	Комп'ютерне моделювання жорстких процесів та систем
329	f	Основи штучного інтелекту
330	f	Фреймворки JavaScript
331	f	Управління проектами
327	f	Здоров'язбережувальні технології та медицина порятунку
332	f	Здоров'язбережувальні технології та домедична допомога
333	f	Хмарні технології
334	f	Елементи теорії чисел у ЗЗСО
335	f	Вибрані питання геометрії (основна школа)
336	f	Комунікативні технології в управлінні проектами
337	f	Прикладний статистичний аналіз з використанням Python
338	f	Елементи теорії випадкових процесів
339	f	Основи DevOps
340	f	Тренінг професійного розвитку вчителя
341	f	Практикум з тригонометрії
342	f	Математична статистика з елементами теорії випадкових процесів
\.


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teachers (id, disable, name, patronymic, "position", surname, user_id, department_id) FROM stdin;
102	f	Наталія	Михайлівна	доцент	Попович	\N	\N
19	f	Ігор	Дмитрович	асистент	Скутар	\N	\N
21	f	Володимир	Васильович	професор	Михайлюк	\N	\N
23	f	Тарас	Іванович	доцент	Звоздецький	\N	\N
26	f	Василь	Володимирович	доцент	Нестеренко	\N	\N
7	t	Олександр	Петровичd	Професор	Рурський	44	\N
28	f	Олена	Георгіївна	асистент	Фотій	\N	\N
30	f	Ігор	Михайлович	професор	Черевко	\N	\N
31	f	Наталія	Іллівна	асистент	Фонарюк	\N	\N
32	f	Тоня	Михайлівна	доцент	Фратавчан	\N	\N
34	f	Лариса	Андріївна	доцент	Піддубна	\N	\N
36	f	Ігор	Валерійович	доцент	Юрченко	\N	\N
5	t	Дмитро	Святославович	Юніті	Савостьянов	13	\N
40	f	Василь	Йосипович	доцент	Кушнірчук	\N	\N
41	f	Тетяна	Петрівна	доцент	Караванова	\N	\N
42	f	Андрій	Богданович	асистент	Дорош	\N	\N
43	f	Руслана	Степанівна	доцент	Колісник	\N	\N
44	f	Вадим	Ілліч	доцент	Мироник	\N	\N
45	f	Вікторія	Сергіївна	асистент	Лучко	\N	\N
46	f	Віра	Степанівна	доцент	Сікора	\N	\N
47	f	Наталія	Михайлівна	асистент	Шевчук	\N	\N
48	f	Ольга	Василівна	професор	Мартинюк	\N	\N
49	f	Світлана	Богданівна	доцент	Боднарук	\N	\N
50	f	Жана	Ілінічна	асистент	Довгей	\N	\N
52	f	Микола	Петрович	доцент	Філіпчук	\N	\N
3	t	Денисs	Павлович	Помічник	Чікар	8	\N
20	f	Олександр	Володимирович	професор	Маслюченко	\N	\N
108	f	Владислав	Антонович	професор	Літовченко	\N	\N
66	f	Галина	Василівна	доцент	Мельник	\N	\N
67	f	Богдан	Дмитрович	доцент	Шепетюк	\N	\N
70	f	Олександр	Васильович	доцент	Матвій	\N	\N
71	f	Тетяна	Миколаївна	доцент	Сопронюк	\N	\N
37	f	Іван	Іванович	професор	Клевчук	\N	\N
96	f	Аліна	Андріївна	асистент	Плегуца	\N	\N
4	t	Anton	Petrovych	Cool	Shevchuk	38	\N
11	t	Tetiana	Tanasiivna	teacher	Vykliuk	48	\N
10	t	Макійaaaaaa	Іванович	Сейморв	Джудуж	\N	\N
1	t	Бамбіно	Брусте	Професор	Діно	14	\N
6	t	Дмитро	Васильович	Помічник	Колодюк	21	\N
145	f	Інна	Владиславівна	доцент	Ковальчук	\N	\N
106	f	Тетяна	Іванівна	доцент	Радзиняк	\N	\N
101	t	Валентина	Візіторівна	професор	Балахтар	\N	\N
60	f	Іван	Михайлович	асистент	Данилюк	\N	\N
63	f	Світлана	Анатоліївна	асистент	Іліка	\N	\N
72	f	Лідія	Миколаївна	асистент	Сергєєва	\N	\N
73	f	Тетяна	Іванівна	доцент	Готинчан	\N	\N
77	f	Володимир	Миколайович	доцент	Лучко	\N	\N
78	f	Олег	Михайлович	доцент	Ленюк	\N	\N
75	f	Анастасія	Олександрівна	асистент	Юрійчук	\N	\N
79	f	Лілія	Михайлівна	доцент	Мельничук	\N	\N
80	f	Микола	Юрійович	асистент	Горбатенко	\N	\N
61	f	Андрій	Сергійович	доцент	Перцов	\N	\N
81	f	Василь	Григорович	доцент	Маценко	\N	\N
33	f	Галина	Петрівна	доцент	Івасюк	\N	1
35	f	Галина	Савеліївна	доцент	Пасічник	\N	\N
65	f	Ярослав	Йосипович	професор	Бігун	\N	\N
64	f	Ірина	Вікторівна	доцент	Дорошенко	\N	\N
51	f	Лілія	Миколаївна	асистент	Дробіна	\N	\N
22	f	Олена	Олексіївна	професор	Карлова	\N	\N
82	f	Галина	Михайлівна	доцент	Перун	\N	\N
83	f	Іван	Васильович	професор	Житарюк	\N	\N
111	f	Оксана	Любомирівна	доцент	Даскалюк	\N	\N
97	f	Викладач	Викладач	асистент	Викладач	\N	\N
85	f	Олена	Миколаївна	асистент	Гусак	\N	\N
90	f	Ірина	Олександрівна	асистент	Захарчук	\N	\N
99	t	Василь	Сергійович	асистент	Мельник	\N	\N
98	t	Ольга	Сергіївна	доцент	Шестобуз	\N	\N
105	f	Денис	Павлович	асистент	Онипа	\N	\N
107	f	Дмитро	Валерійович	асистент	Шкільнюк	\N	\N
87	f	Лілія	Василівна	асистент	Маковійчук	\N	\N
149	f	Наталя	Олександрівна	асистент	Мельничук	\N	\N
91	f	Тетяна	Василівна	доцент	Тоненчук	\N	\N
94	f	Оксана	Євгенівна	доцент	Гордійчук	\N	\N
76	f	Світлана	Сільвестрівна	доцент	Доскач	\N	\N
162	f	Оксана	Мирославівна	асистент	Яцько	\N	6
54	t	Олександр	Олександрович	асистент	Блажевський	\N	\N
166	f	Ігор	Володимирович	доцент	Малик	\N	\N
88	f	Мирослава 	Миколаївна	асистент	Шенько	\N	\N
168	f	Михайло	Михайлович	професор	Попович	\N	\N
62	f	Наталія	Вікторівна	асистент	Романенко	\N	4
180	f	Людмила	Іванівна	професор	Тимчук	\N	\N
183	t	Викладач	Викладач	асистент	Викладач	\N	\N
184	f	Ганна	Павлівна	доцент	Бигар	\N	\N
185	f	Юрій	Віталійович	асистент	Луцюк	\N	\N
189	f	Василь	Сергійович	асистент	Мельник	\N	\N
190	f	Іннеса	Володимирівна	доцент	Краснокутська	\N	\N
191	f	Наталія	Іванівна	доцент	Кучумова 	\N	\N
194	f	Богдан	Олегович	асистент	Яшан	\N	\N
195	f	Ганна	Петрівна	асистент	Вережак	\N	\N
198	f	Сергій	Васильович	доцент	Мартинюк 	\N	\N
199	f	Галина 	Михайлівна	асистент	Унгурян	\N	\N
200	f	Лариса	Василівна	доцент	Мафтин	\N	\N
204	f	Наталя	Сергіївна	асистент	Правіцка 	\N	\N
203	f	Василь	Михайлович	асистент	Косован	\N	\N
205	f	Маріан	Філаретович	професор	Бирка	\N	\N
206	f	Василь	Васильович	асистент	Білоус	\N	\N
207	f	Іван	Дмитрович	професор	Пукальський 	\N	\N
208	f	Дмитро.	Валерійович.	асистент	Шкільнюк.	\N	\N
161	f	Наталія	Василівна	асистент	Цинтар	\N	\N
53	f	Олена	Василівна	асистент	Мудра	\N	\N
187	f	Анна	Миколаївна	асистент	Симака	\N	\N
\.


--
-- Data for Name: temporary_schedule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.temporary_schedule (id, date, grouped, lessontype, subject_for_site, vacation, group_id, period_id, room_id, semester_id, subject_id, teacher_id, notification, schedule_id, link_to_meeting) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email, password, role, token) FROM stdin;
11	test41@test.com	$2a$10$JY/bzDg4cY6Am1R1RPkk2.JieH0DRKSjQ1FwAUt9BMSnIp/H4bNzC	ROLE_USER	33dd9cb6-75db-4222-b036-66f235a787c1
12	test50@test.com	$2a$10$.RGmFapkahytT9xtgnJspOUmzeVRyXtrHtxY1hdybyNSX7U33XrPK	ROLE_USER	f6abe608-6381-4f87-b9c8-139ec5892be5
15	test410@test.com	$2a$10$bpJDasyJxm.ltw5ZMZYZHe0hmddKKAqvYP4CQMzRkZYaL.2jionQG	ROLE_USER	a6b56362-6170-4d5b-a1d8-1a7067a75c69
17	das@mail.com	$2a$10$.kRighywghveMzRXAPC.r.muVm5jh.sZb5nhlm871LF2.oqV.9fZ6	ROLE_USER	918b5320-81c2-4883-819c-bf1fdc44ba94
1	folf_test@test.com	$2a$10$a/wpHr7KA8.gvk8kmOvIr.wCK2mZUp0Jv46MzIoVW4Y/PYMS/pmcC	ROLE_MANAGER	\N
3	Fedir_@i.ua	$2a$10$a/wpHr7KA8.gvk8kmOvIr.wCK2mZUp0Jv46MzIoVW4Y/PYMS/pmcC	ROLE_MANAGER	\N
9	test4@test.com	$2a$10$fwBnMzbASCdAHaeiwlNji.Y9EnitJevRdHOrwIEYjlBbPBl7sq4ea	ROLE_TEACHER	0bbb3631-be44-4bc2-930e-4d377c4da9ff
20	oleksandrkravets1995@gmail.com	$2a$10$PgvbsX9gmvBDcXcWcU0Ak.RcluITm77XQCrsvZZsHMGlA4nY3wFye	ROLE_MANAGER	\N
6	test@test.com	$2a$10$J7mqEk43IlKMZD72NqaYi.IcCi/fNFYqpjNyed/aVpiQCr17.cIVe	ROLE_USER	3bf11b95-3771-4533-9fa5-0311e2fea7d8
22	aaaaasdfcvgtbhj7ku@gmail.com	adsfdvgftjhgn	ROLE_USER	\N
23	noname@gmail.com	adsfdvgftjhgn	ROLE_USER	\N
25	noname2@gmail.com	adsfdvgftjhgn	ROLE_USER	\N
2	vasja.mazuryk@gmail.com	$2a$04$SpUhTZ/SjkDQop/Zvx1.seftJdqvOploGce/wau247zQhpEvKtz9.	ROLE_MANAGER	\N
26	Fedir_@email.ua	$2a$10$KxihjeqGUUUoEf7WrOEjbu77C8VTfEWK5kDnDVNkGkKA8C1fZ2QZK	ROLE_USER	d906f12c-4a7d-478f-9fd5-08e57efac2ad
32	test4021312312312312@test.com	$2a$10$hqtQdFER6EXsDsbLaWw6g.e92lGob99jwImkLSNCMlVrE0LAbRFYO	ROLE_USER	3625ca8c-d2b0-49fa-a35c-a9896f5b69ee
10	test40@test.com	$2a$10$HrN7h.UlANnxyNlgvHQ7eOKI4RGWoqfzCiAt4RLq649rsSLsSNaGq	ROLE_TEACHER	5ae335bc-cc26-491e-a366-cc532e892a7c
4	aaaaqewdf@gmail.com	string	ROLE_USER	\N
19	aaaaqewdfaaa@gmail.com	string	ROLE_USER	\N
18	degvtawsfdgnf@gmail.com	string	ROLE_USER	\N
28	jowiti1173@emailhost99.com	$2a$10$0c/pG/8U/yjhFNBniCyYHOAas4gOF.O9b8ZJTsDEvjn4xQ338J3M6	ROLE_USER	\N
34	oleksandrkravets1995123213312@gmail.com	$2a$10$x38zos8srXPYtM1HrkRVtOzWf9lRQKmmLvzRccf9A7/6TiZAd87WO	ROLE_USER	d5d9cf02-0b8e-4a17-b223-67d492f3e5ff
30	aaaassssssasqewdf@gmail.com	string	ROLE_USER	\N
29	aaaasssssaasasqewdf@gmail.com	string	ROLE_USER	\N
33	mitrobaz91@gmail.com	$2a$10$AkdUxFiC.NUS7nC1S4wrh.5HOU8s5Hqev2ZVvNlhvxrU6GKCrrgui	ROLE_USER	\N
35	toxa13.01@ukr.net	$2a$10$gGqAlAo4jXtdUw6fQHFsDuy19lDz9fcnEfQ4JCkzTd/ucs61zJPpu	ROLE_USER	dedf6dc2-d603-4605-987e-c30fb27475f0
36	toxa13.02@ukr.net	$2a$10$n42piLaPdPXrjztMBqkaJurcKRRD0yZodW.S282aY1vS3GbKtgqhS	ROLE_USER	893b2551-8610-49d3-9613-d8652a31da65
27	aaaaaa@gmail.com	aaaavregtdrfhberb	ROLE_USER	\N
37	sdfsdvsdvdv@gmail.com	stringsssss	ROLE_USER	\N
8	test_user	$2a$04$SpUhTZ/SjkDQop/Zvx1.seftJdqvOploGce/wau247zQhpEvKtz9.	ROLE_TEACHER	\N
42	test540123@test.com	$2a$10$gj3wgw2LcEBqEZlvWj1TO.F4lW0UZ9Hmp2Wi2jdWiD3uk2HDAkHQW	ROLE_USER	c6d151b1-8535-4fd5-933e-1a2c69099656
43	gafowe1087@coalamails.com	$2a$10$8hKpi/Vj5vMwqdVPcSVArOMlXw/L7lz/QWXYGgMHsooiqEG5G177G	ROLE_TEACHER	\N
50	notice.board1221@gmail.com	$2a$10$U1QB090zQBtbWKVb0dBLT.E1Y9KH1tddOcfAYLUZHvx/Q1aWs1IkK	ROLE_USER	\N
40	stringsds@gmail.com	stringsdsd	ROLE_USER	\N
45	stringsds111@gmail.com	stringsdsd	ROLE_USER	\N
47	stringsdcfervedb@gmail.com	string	ROLE_USER	\N
46	stringaasasq@gmail.com	string	ROLE_USER	\N
49	stringasdfvsrg@gmail.com	$2a$10$/gCJFc6ithNWbZuj9EGFSO1Wb2hJCQP.EJhS.ettiCTFTpxYLeNXO	ROLE_USER	8cfb8c81-4025-457c-881b-8cf2193838e3
44	toxa13.00@ukr.net	$2a$10$WQT0t7ql5JkRoEqG7D7jMeRqjbtyAwLkBKHiz7Ect.X/FSQTfVWHO	ROLE_USER	\N
13	test45@test.com	$2a$10$zmLW/J700eouFqK3f9BThep2ca0caPFRDrEPEijInUSD/ngIbqxCC	ROLE_USER	c496655b-37e2-40fd-8661-7decaecf631b
38	mnepohuinanickname@gmail.com	$2a$10$5fbAftld306o4Ug84Pe6IOTYoW9ITGTgosP6Otvj4YCMKKbZ5SpTe	ROLE_USER	\N
48	tanya.vykliuk@gmail.com	$2a$10$rrFW0heVYunJFJwfLvggl.VresUzyJKZgc79.MRrfGB6XwitjLQKe	ROLE_USER	\N
14	test80@test.com	$2a$10$x7KDBNenz3PLeaXdYjXyFuHL/9GRmMpVzrqh1AZ9NUyyokCpEQysS	ROLE_USER	14fe6942-85da-49cb-a14e-3b743820e36e
21	aaaa@gmail.com	$2a$04$zpA2SNu7WAjToGz5C6ZKKOCwYnOHpMQ1bEisxfwWtMTM3jJMugAkq	ROLE_USER	\N
7	i.masliuchenko@chnu.edu.ua	$2a$04$zpA2SNu7WAjToGz5C6ZKKOCwYnOHpMQ1bEisxfwWtMTM3jJMugAkq	ROLE_MANAGER	\N
16	petrofediuk004@gmail.com	$2a$04$zpA2SNu7WAjToGz5C6ZKKOCwYnOHpMQ1bEisxfwWtMTM3jJMugAkq	ROLE_TEACHER	\N
65	ivankozmulyak@gmail.com	$2a$10$yg9fyW242kM.Rz0tLa8LReYaQzskLOElilC.vonvxHU1yMIsKyFWy	ROLE_USER	fe814151-62a7-4745-96e5-34e29b45c52d
66	herasymchuk.anastasiia@chnu.edu.ua	$2a$10$5LAQW.cXwh6TkZncy9p8C.3DkOOM3WDquvfnliDYjdOTB0cMBpV8a	ROLE_USER	26dd3055-0639-474f-8a4a-be37edfd4e6f
68	admin@gmail.com	$2a$10$o.Q3V2u2TcRgMlup2E3m3OhQrK2jOuRhV5H3iBs5AEK6Oh1BSmy4G	ROLE_USER	b8b09edc-d141-4317-bd29-a01a08ba1694
67	offic6e@chnu.edu.ua	$2a$10$34kt/1Zt4SdxZCSg8tv8oei53REQgH6qZ/TDGU.7O19i61anT7yiK	ROLE_USER	d731d3df-30b0-422f-8cae-4551df03a216
73	gerasymchuk88888888@gmail.com	A&vbSdvSeук4му%ца349ІВмк432ем0!Qfdruevvb	ROLE_USER	\N
64	kondrserg1@gmail.com	$2a$10$VGyx651t21jGGx0aVVKK4uFvyV6nl6NYu4LJQJkWB5YUobrlF4zRu	ROLE_MANAGER	\N
78	yashchemskyio@gmail.com	A&vbSdvSeук4му%ца349ІВмк432ем0!Qfdruevvb	ROLE_USER	\N
77	ivan.demianchuk@kpk-lp.com.ua	A&vbSdvSeук4му%ца349ІВмк432ем0!Qfdruevvb	ROLE_USER	\N
79	akr1sdevelop@gmail.com	A&vbSdvSeук4му%ца349ІВмк432ем0!Qfdruevvb	ROLE_USER	\N
80	viktoriia.kosovan@gmail.com	A&vbSdvSeук4му%ца349ІВмк432ем0!Qfdruevvb	ROLE_USER	\N
85	see4.whoami@gmail.com	$2a$10$e7a8dxs8J.qSu8W9RYsjte67pe88mQ2M9afe.sQ24M36zFpQo3XO.	ROLE_USER	21037a99-4201-4d20-bb2a-2b80a98b09fd
86	popesku.andrii@chnu.edu.ua	$2a$10$nW2BHhowDif8kwqan8X7guIroo4HojI991q1m0AzV2hVeaEnegAbW	ROLE_USER	f08b31a5-70e9-4589-9504-2cf7876e9c16
87	andepopeskua@gmail.com	$2a$10$adiz0bLpDW4du5Yitken3ePrfzFMW126t1pNZk3KPNNVYBldiK2ui	ROLE_USER	7021a42b-89d3-4121-b52e-2dc635781432
88	kolyabolabolya678@gmail.com	$2a$10$yz1O3cvhbw0eiaJf0rHsBOOKmS86gSJQ2bBeHb2XazKE8nhZsxlsq	ROLE_USER	0581d8c7-43a3-44b7-82c5-6cf15704051d
89	vlasenko.yuliia@gmail.com	$2a$10$VPVZyQ0CmmEEVUj6Sa1jrO9qt/BfHYu0QHCdr1HccVRSZNgo44hnu	ROLE_USER	7650966d-1cdf-4b45-9c29-8ece717c0480
90	jbegou26@gmail.com	$2a$10$9MX6ywespCWLu1y6P1pCjOjUWGHP1vQh3OX1KQEk5KPbfPSwWRoXS	ROLE_USER	7edb4ebd-2512-4821-a1fe-b79046981a7a
91	ivanunik@icloud.com	$2a$10$7aJ1AwH.ILE5.iQ4r/eBQeWDFAibWnorZCYX.QmAHLJWgpcIUq4Ke	ROLE_USER	77f43337-b34b-4189-8629-8435b0dbac78
92	shevtsova19931993@gmail.com	$2a$10$RS09YnzR1rtz.X51hsaScOgsTCTck59nh..aVLtreJDQU1mr9sea.	ROLE_USER	ee446e90-cefa-43a9-9665-2ce0c91486b1
93	23elina94@gmail.com	$2a$10$dcdCx8wkhmzSMwteuAYEOe4m.cZ/dlcBKjxOYr7YBdqKy/T4cYfZ6	ROLE_USER	5114b366-fa07-4fcc-8a15-b3df3e473780
\.


--
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.department_id_seq', 16, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.groups_id_seq', 106, true);


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lessons_id_seq', 4457, true);


--
-- Name: periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.periods_id_seq', 9, true);


--
-- Name: room_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.room_types_id_seq', 9, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rooms_id_seq', 121, true);


--
-- Name: schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.schedules_id_seq', 9128, true);


--
-- Name: semesters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.semesters_id_seq', 56, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.students_id_seq', 12, true);


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subjects_id_seq', 342, true);


--
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.teachers_id_seq', 208, true);


--
-- Name: temporary_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.temporary_schedule_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 93, true);


-- --
-- -- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
-- --

-- ALTER TABLE ONLY public.databasechangeloglock
--     ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: periods periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT periods_pkey PRIMARY KEY (id);


--
-- Name: room_types room_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_types
    ADD CONSTRAINT room_types_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: semester_group semester_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semester_group
    ADD CONSTRAINT semester_group_pkey PRIMARY KEY (semester_id, group_id);


--
-- Name: semester_period semester_period_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semester_period
    ADD CONSTRAINT semester_period_pkey PRIMARY KEY (semester_id, period_id);


--
-- Name: semesters semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: temporary_schedule temporary_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temporary_schedule
    ADD CONSTRAINT temporary_schedule_pkey PRIMARY KEY (id);


--
-- Name: users uk_6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- Name: subjects uk_aodt3utnw0lsov4k9ta88dbpr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT uk_aodt3utnw0lsov4k9ta88dbpr UNIQUE (name);


--
-- Name: periods uk_bgj9vbqf54b7iryxqu895bggh; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periods
    ADD CONSTRAINT uk_bgj9vbqf54b7iryxqu895bggh UNIQUE (name);


--
-- Name: department uk_biw7tevwc07g3iutlbmkes0cm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT uk_biw7tevwc07g3iutlbmkes0cm UNIQUE (name);


--
-- Name: groups uk_ct3jhny5hfe6uj2osyn8a4p83; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT uk_ct3jhny5hfe6uj2osyn8a4p83 UNIQUE (title);


--
-- Name: room_types uk_gunh6313ruq1dghti9p00529u; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.room_types
    ADD CONSTRAINT uk_gunh6313ruq1dghti9p00529u UNIQUE (description);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: schedules fk34r5t4jexlcas19pleifb8ihv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk34r5t4jexlcas19pleifb8ihv FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- Name: semester_day fk36f17dewxqjhb23rhlmc7slk3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semester_day
    ADD CONSTRAINT fk36f17dewxqjhb23rhlmc7slk3 FOREIGN KEY (semester_id) REFERENCES public.semesters(id);


--
-- Name: temporary_schedule fk3hid2313ah5gjqqye9d3eik2g; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temporary_schedule
    ADD CONSTRAINT fk3hid2313ah5gjqqye9d3eik2g FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- Name: schedules fk4g2p59v3jm7hk6a9ufdufy8ie; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk4g2p59v3jm7hk6a9ufdufy8ie FOREIGN KEY (period_id) REFERENCES public.periods(id);


--
-- Name: semester_group fk4j15tivie8ttfhl0s7x3o3syv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semester_group
    ADD CONSTRAINT fk4j15tivie8ttfhl0s7x3o3syv FOREIGN KEY (semester_id) REFERENCES public.semesters(id);


--
-- Name: schedules fk7f954gltrwny6pe4see76kpw8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk7f954gltrwny6pe4see76kpw8 FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: semester_period fk94poii1rmjhoevjx7bsymtbtd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semester_period
    ADD CONSTRAINT fk94poii1rmjhoevjx7bsymtbtd FOREIGN KEY (semester_id) REFERENCES public.semesters(id);


--
-- Name: temporary_schedule fka1bsm9fsuxn5t098i2cb7nncu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temporary_schedule
    ADD CONSTRAINT fka1bsm9fsuxn5t098i2cb7nncu FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: temporary_schedule fkaqmj2bajc0ud8wproqn4843pk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temporary_schedule
    ADD CONSTRAINT fkaqmj2bajc0ud8wproqn4843pk FOREIGN KEY (semester_id) REFERENCES public.semesters(id);


--
-- Name: lessons fkbr76cuebuufbbltujpfq04tto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fkbr76cuebuufbbltujpfq04tto FOREIGN KEY (teacher_id) REFERENCES public.teachers(id);


--
-- Name: lessons fke94a0k21xpi7glv89af90lwjv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fke94a0k21xpi7glv89af90lwjv FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- Name: rooms fkh9m2n1paq5hmd3u0klfl7wsfv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT fkh9m2n1paq5hmd3u0klfl7wsfv FOREIGN KEY (room_type_id) REFERENCES public.room_types(id);


--
-- Name: lessons fkil1jt6gri8x6yfaa3ijf7d6d9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fkil1jt6gri8x6yfaa3ijf7d6d9 FOREIGN KEY (semester_id) REFERENCES public.semesters(id);


--
-- Name: teachers fkl19hwymwn2ra2gwwty5trvyas; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fkl19hwymwn2ra2gwwty5trvyas FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: semester_period fkm237asf73ugk3vvw47aq266kl; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semester_period
    ADD CONSTRAINT fkm237asf73ugk3vvw47aq266kl FOREIGN KEY (period_id) REFERENCES public.periods(id);


--
-- Name: students fkmsev1nou0j86spuk5jrv19mss; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT fkmsev1nou0j86spuk5jrv19mss FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: temporary_schedule fko7tild8vhrqlodd3oaf8acvyw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temporary_schedule
    ADD CONSTRAINT fko7tild8vhrqlodd3oaf8acvyw FOREIGN KEY (teacher_id) REFERENCES public.teachers(id);


--
-- Name: semester_group fkpf19s66cmi8qpqc0iaeigbrhh; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.semester_group
    ADD CONSTRAINT fkpf19s66cmi8qpqc0iaeigbrhh FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: temporary_schedule fkqn6ufkok0nhqdkn46ctqckb76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temporary_schedule
    ADD CONSTRAINT fkqn6ufkok0nhqdkn46ctqckb76 FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- Name: temporary_schedule fkr76lbhlv0di8ix7iviixs0p4g; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temporary_schedule
    ADD CONSTRAINT fkr76lbhlv0di8ix7iviixs0p4g FOREIGN KEY (period_id) REFERENCES public.periods(id);


--
-- Name: lessons fktdolsaotaqlwxbxwaxt00kimk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fktdolsaotaqlwxbxwaxt00kimk FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: students user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

