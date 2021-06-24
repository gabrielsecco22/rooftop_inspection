--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: crew; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crew (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.crew OWNER TO postgres;

--
-- Name: crew_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crew_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.crew_id_seq OWNER TO postgres;

--
-- Name: crew_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crew_id_seq OWNED BY public.crew.id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    name character varying NOT NULL,
    cnpj character varying NOT NULL,
    is_active boolean NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_contact (
    id integer NOT NULL,
    name character varying NOT NULL,
    phone character varying,
    email character varying,
    customer_id integer NOT NULL
);


ALTER TABLE public.customer_contact OWNER TO postgres;

--
-- Name: customer_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_contact_id_seq OWNER TO postgres;

--
-- Name: customer_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_contact_id_seq OWNED BY public.customer_contact.id;


--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_id_seq OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_id_seq OWNED BY public.customer.id;


--
-- Name: inspection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inspection (
    id integer NOT NULL,
    description character varying NOT NULL
);


ALTER TABLE public.inspection OWNER TO postgres;

--
-- Name: inspection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inspection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inspection_id_seq OWNER TO postgres;

--
-- Name: inspection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inspection_id_seq OWNED BY public.inspection.id;


--
-- Name: rooftop; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooftop (
    id integer NOT NULL,
    description character varying,
    customer_id integer NOT NULL,
    latitude double precision,
    longitude double precision,
    area real NOT NULL
);


ALTER TABLE public.rooftop OWNER TO postgres;

--
-- Name: rooftop_frame_diagnostic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooftop_frame_diagnostic (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.rooftop_frame_diagnostic OWNER TO postgres;

--
-- Name: rooftop_frame_diagnostic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooftop_frame_diagnostic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooftop_frame_diagnostic_id_seq OWNER TO postgres;

--
-- Name: rooftop_frame_diagnostic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooftop_frame_diagnostic_id_seq OWNED BY public.rooftop_frame_diagnostic.id;


--
-- Name: rooftop_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooftop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooftop_id_seq OWNER TO postgres;

--
-- Name: rooftop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooftop_id_seq OWNED BY public.rooftop.id;


--
-- Name: rooftop_inspection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooftop_inspection (
    id integer NOT NULL,
    description character varying,
    inspection_time timestamp(0) without time zone,
    crew_id integer,
    rooftop_id integer NOT NULL,
    start_time timestamp(0) without time zone,
    end_time timestamp(0) without time zone,
    created_at timestamp(0) without time zone NOT NULL,
    rooftop_inspection_status_id integer NOT NULL,
    inspection_id integer
);


ALTER TABLE public.rooftop_inspection OWNER TO postgres;

--
-- Name: rooftop_inspection_frame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooftop_inspection_frame (
    id integer NOT NULL,
    frame_path character varying NOT NULL,
    rooftop_inspection_id integer NOT NULL,
    rooftop_frame_diagnostic_id integer,
    latitude double precision,
    longitude double precision,
    area real,
    length real,
    width real
);


ALTER TABLE public.rooftop_inspection_frame OWNER TO postgres;

--
-- Name: rooftop_inspection_frame_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooftop_inspection_frame_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooftop_inspection_frame_id_seq OWNER TO postgres;

--
-- Name: rooftop_inspection_frame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooftop_inspection_frame_id_seq OWNED BY public.rooftop_inspection_frame.id;


--
-- Name: rooftop_inspection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooftop_inspection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooftop_inspection_id_seq OWNER TO postgres;

--
-- Name: rooftop_inspection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooftop_inspection_id_seq OWNED BY public.rooftop_inspection.id;


--
-- Name: rooftop_inspection_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooftop_inspection_status (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.rooftop_inspection_status OWNER TO postgres;

--
-- Name: rooftop_inspection_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooftop_inspection_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooftop_inspection_status_id_seq OWNER TO postgres;

--
-- Name: rooftop_inspection_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooftop_inspection_status_id_seq OWNED BY public.rooftop_inspection_status.id;


--
-- Name: rooftop_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooftop_plan (
    id integer NOT NULL,
    rooftop_id integer NOT NULL,
    crated_at timestamp(0) without time zone NOT NULL,
    plan_path path
);


ALTER TABLE public.rooftop_plan OWNER TO postgres;

--
-- Name: rooftop_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooftop_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooftop_plan_id_seq OWNER TO postgres;

--
-- Name: rooftop_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooftop_plan_id_seq OWNED BY public.rooftop_plan.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    name character varying NOT NULL,
    crew_id integer NOT NULL
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_id_seq OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: crew id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew ALTER COLUMN id SET DEFAULT nextval('public.crew_id_seq'::regclass);


--
-- Name: customer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN id SET DEFAULT nextval('public.customer_id_seq'::regclass);


--
-- Name: customer_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_contact ALTER COLUMN id SET DEFAULT nextval('public.customer_contact_id_seq'::regclass);


--
-- Name: inspection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection ALTER COLUMN id SET DEFAULT nextval('public.inspection_id_seq'::regclass);


--
-- Name: rooftop id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop ALTER COLUMN id SET DEFAULT nextval('public.rooftop_id_seq'::regclass);


--
-- Name: rooftop_frame_diagnostic id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_frame_diagnostic ALTER COLUMN id SET DEFAULT nextval('public.rooftop_frame_diagnostic_id_seq'::regclass);


--
-- Name: rooftop_inspection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection ALTER COLUMN id SET DEFAULT nextval('public.rooftop_inspection_id_seq'::regclass);


--
-- Name: rooftop_inspection_frame id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection_frame ALTER COLUMN id SET DEFAULT nextval('public.rooftop_inspection_frame_id_seq'::regclass);


--
-- Name: rooftop_inspection_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection_status ALTER COLUMN id SET DEFAULT nextval('public.rooftop_inspection_status_id_seq'::regclass);


--
-- Name: rooftop_plan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_plan ALTER COLUMN id SET DEFAULT nextval('public.rooftop_plan_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Data for Name: crew; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crew (id, name) FROM stdin;
1	Equipe Alfa
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (name, cnpj, is_active, id) FROM stdin;
JOHNSON & JOHNSON INDUSTRIAL LTDA	59.748.988/0001-14	t	1
\.


--
-- Data for Name: customer_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_contact (id, name, phone, email, customer_id) FROM stdin;
1	Foolano de Tal	+5512987654321	ftal@teste.com	1
\.


--
-- Data for Name: inspection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inspection (id, description) FROM stdin;
1	Inspecao JOHNSON & JOHNSON SJC
\.


--
-- Data for Name: rooftop; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooftop (id, description, customer_id, latitude, longitude, area) FROM stdin;
1	Sampro - Fabrica de Absorventes	1	-23.23742886267635	-45.92448031049118	1780
2	Perfex	1	-23.2387	-45.922927	1420
3	Fabrica de Fraldas	1	-23.238065	-45.924102	3760
\.


--
-- Data for Name: rooftop_frame_diagnostic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooftop_frame_diagnostic (id, name) FROM stdin;
1	Avaria
2	Intederminado
3	Bom estado
\.


--
-- Data for Name: rooftop_inspection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooftop_inspection (id, description, inspection_time, crew_id, rooftop_id, start_time, end_time, created_at, rooftop_inspection_status_id, inspection_id) FROM stdin;
1	Telhado Sampro	2020-06-24 08:00:00	1	1	2020-06-24 08:35:26	2020-06-24 11:34:37	2020-06-23 09:37:37	3	1
2	Telhado perfex	2020-06-25 09:00:00	1	2	2020-06-25 09:35:26	2020-06-25 10:52:47	2020-06-23 09:37:37	3	1
3	Telhado Fabrica de Fraldas	2020-06-26 08:00:00	1	3	2020-06-26 08:05:16	2020-06-26 10:23:02	2020-06-23 09:41:27	3	1
\.


--
-- Data for Name: rooftop_inspection_frame; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooftop_inspection_frame (id, frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width) FROM stdin;
1	/frames/2021-06/ri00000001/00000001.png	1	1	-23.23742886267635	-45.92448031049118	0.07	0.41	0.35
2	/frames/2021-06/ri00000001/00000002.png	1	3	-23.23743886267635	-45.92449031049118	\N	\N	\N
3	/frames/2021-06/ri00000001/00000003.png	1	2	-23.23741886267635	-45.92447031049118	\N	\N	\N
4	/frames/2021-06/ri00000001/00000004.png	1	1	-23.23740886267635	-45.92445031049118	0.15	0.81	0.55
5	/frames/2021-06/ri00000001/00000005.png	1	3	-23.23742886267635	-45.92448031049118	\N	\N	\N
6	/frames/2021-06/ri00000001/00000006.png	1	3	-23.23742886267635	-45.92448031049118	\N	\N	\N
7	/frames/2021-06/ri00000001/00000007.png	1	3	-23.23742886267635	-45.92448031049118	\N	\N	\N
8	/frames/2021-06/ri00000002/00000001.png	2	1	-23.23742886267635	-45.92448031049118	0.03	0.21	0.25
9	/frames/2021-06/ri00000003/00000001.png	3	1	-23.23841	-45.924419	0.09	0.51	0.27
\.


--
-- Data for Name: rooftop_inspection_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooftop_inspection_status (id, name) FROM stdin;
1	Criado
2	Agendado
3	Finalizado
4	Cancelado
\.


--
-- Data for Name: rooftop_plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooftop_plan (id, rooftop_id, crated_at, plan_path) FROM stdin;
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (id, name, crew_id) FROM stdin;
1	Gabriel	1
2	Odair	1
3	Nilson	1
4	Thiago	1
\.


--
-- Name: crew_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crew_id_seq', 1, true);


--
-- Name: customer_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_contact_id_seq', 1, true);


--
-- Name: customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_id_seq', 1, true);


--
-- Name: inspection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inspection_id_seq', 1, true);


--
-- Name: rooftop_frame_diagnostic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooftop_frame_diagnostic_id_seq', 3, true);


--
-- Name: rooftop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooftop_id_seq', 3, true);


--
-- Name: rooftop_inspection_frame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooftop_inspection_frame_id_seq', 9, true);


--
-- Name: rooftop_inspection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooftop_inspection_id_seq', 3, true);


--
-- Name: rooftop_inspection_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooftop_inspection_status_id_seq', 4, true);


--
-- Name: rooftop_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooftop_plan_id_seq', 1, false);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_id_seq', 4, true);


--
-- Name: crew crew_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crew
    ADD CONSTRAINT crew_pk PRIMARY KEY (id);


--
-- Name: customer_contact customer_contact_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_contact
    ADD CONSTRAINT customer_contact_pk PRIMARY KEY (id);


--
-- Name: customer customer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pk PRIMARY KEY (id);


--
-- Name: inspection inspection_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection
    ADD CONSTRAINT inspection_pk PRIMARY KEY (id);


--
-- Name: rooftop_plan newtable_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_plan
    ADD CONSTRAINT newtable_pk PRIMARY KEY (id);


--
-- Name: rooftop_frame_diagnostic rooftop_frame_diagnostic_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_frame_diagnostic
    ADD CONSTRAINT rooftop_frame_diagnostic_pk PRIMARY KEY (id);


--
-- Name: rooftop_inspection_frame rooftop_inspection_frames_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection_frame
    ADD CONSTRAINT rooftop_inspection_frames_pk PRIMARY KEY (id);


--
-- Name: rooftop_inspection rooftop_inspection_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection
    ADD CONSTRAINT rooftop_inspection_pk PRIMARY KEY (id);


--
-- Name: rooftop_inspection_status rooftop_inspection_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection_status
    ADD CONSTRAINT rooftop_inspection_status_pk PRIMARY KEY (id);


--
-- Name: rooftop rooftop_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop
    ADD CONSTRAINT rooftop_pk PRIMARY KEY (id);


--
-- Name: staff staff_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (id);


--
-- Name: rooftop_inspection crew_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection
    ADD CONSTRAINT crew_fk FOREIGN KEY (crew_id) REFERENCES public.crew(id);


--
-- Name: customer_contact customer_contact_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_contact
    ADD CONSTRAINT customer_contact_fk FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: rooftop_inspection inspection_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection
    ADD CONSTRAINT inspection_fk FOREIGN KEY (inspection_id) REFERENCES public.inspection(id);


--
-- Name: rooftop rooftop_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop
    ADD CONSTRAINT rooftop_fk FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: rooftop_inspection_frame rooftop_frame_diagnostic_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection_frame
    ADD CONSTRAINT rooftop_frame_diagnostic_fk FOREIGN KEY (rooftop_frame_diagnostic_id) REFERENCES public.rooftop_frame_diagnostic(id);


--
-- Name: rooftop_inspection rooftop_inspection_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection
    ADD CONSTRAINT rooftop_inspection_fk FOREIGN KEY (rooftop_id) REFERENCES public.rooftop(id);


--
-- Name: rooftop_inspection_frame rooftop_inspection_frame_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection_frame
    ADD CONSTRAINT rooftop_inspection_frame_fk FOREIGN KEY (rooftop_inspection_id) REFERENCES public.rooftop_inspection(id);


--
-- Name: rooftop_inspection rooftop_inspection_status_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_inspection
    ADD CONSTRAINT rooftop_inspection_status_fk FOREIGN KEY (rooftop_inspection_status_id) REFERENCES public.rooftop_inspection_status(id);


--
-- Name: rooftop_plan rooftop_plan_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooftop_plan
    ADD CONSTRAINT rooftop_plan_fk FOREIGN KEY (rooftop_id) REFERENCES public.rooftop(id);


--
-- Name: staff staff_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_fk FOREIGN KEY (crew_id) REFERENCES public.crew(id);


--
-- PostgreSQL database dump complete
--

