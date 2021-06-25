--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE metabase;




--
-- Drop roles
--

DROP ROLE metabase;
DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE metabase;
ALTER ROLE metabase WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md599b8ad6ec5822e34f93ea965ab9ad3b7';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md53175bce1d3201d16594cebf9d7eb3f9d';






--
-- Databases
--

--
-- Database "template1" dump
--

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "metabase" dump
--

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

--
-- Name: metabase; Type: DATABASE; Schema: -; Owner: metabase
--

CREATE DATABASE metabase WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE metabase OWNER TO metabase;

\connect metabase

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
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activity; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.activity (
    id integer NOT NULL,
    topic character varying(32) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    user_id integer,
    model character varying(16),
    model_id integer,
    database_id integer,
    table_id integer,
    custom_id character varying(48),
    details character varying NOT NULL
);


ALTER TABLE public.activity OWNER TO metabase;

--
-- Name: activity_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_id_seq OWNER TO metabase;

--
-- Name: activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.activity_id_seq OWNED BY public.activity.id;


--
-- Name: card_label; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.card_label (
    id integer NOT NULL,
    card_id integer NOT NULL,
    label_id integer NOT NULL
);


ALTER TABLE public.card_label OWNER TO metabase;

--
-- Name: card_label_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.card_label_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.card_label_id_seq OWNER TO metabase;

--
-- Name: card_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.card_label_id_seq OWNED BY public.card_label.id;


--
-- Name: collection; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.collection (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    color character(7) NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    location character varying(254) DEFAULT '/'::character varying NOT NULL,
    personal_owner_id integer,
    slug character varying(254) NOT NULL,
    namespace character varying(254)
);


ALTER TABLE public.collection OWNER TO metabase;

--
-- Name: TABLE collection; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.collection IS 'Collections are an optional way to organize Cards and handle permissions for them.';


--
-- Name: COLUMN collection.name; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection.name IS 'The user-facing name of this Collection.';


--
-- Name: COLUMN collection.description; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection.description IS 'Optional description for this Collection.';


--
-- Name: COLUMN collection.color; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection.color IS 'Seven-character hex color for this Collection, including the preceding hash sign.';


--
-- Name: COLUMN collection.archived; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection.archived IS 'Whether this Collection has been archived and should be hidden from users.';


--
-- Name: COLUMN collection.location; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection.location IS 'Directory-structure path of ancestor Collections. e.g. "/1/2/" means our Parent is Collection 2, and their parent is Collection 1.';


--
-- Name: COLUMN collection.personal_owner_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection.personal_owner_id IS 'If set, this Collection is a personal Collection, for exclusive use of the User with this ID.';


--
-- Name: COLUMN collection.slug; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection.slug IS 'Sluggified version of the Collection name. Used only for display purposes in URL; not unique or indexed.';


--
-- Name: COLUMN collection.namespace; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection.namespace IS 'The namespace (hierachy) this Collection belongs to. NULL means the Collection is in the default namespace.';


--
-- Name: collection_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_id_seq OWNER TO metabase;

--
-- Name: collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.collection_id_seq OWNED BY public.collection.id;


--
-- Name: collection_revision; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.collection_revision (
    id integer NOT NULL,
    before text NOT NULL,
    after text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    remark text
);


ALTER TABLE public.collection_revision OWNER TO metabase;

--
-- Name: TABLE collection_revision; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.collection_revision IS 'Used to keep track of changes made to collections.';


--
-- Name: COLUMN collection_revision.before; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection_revision.before IS 'Serialized JSON of the collections graph before the changes.';


--
-- Name: COLUMN collection_revision.after; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection_revision.after IS 'Serialized JSON of the collections graph after the changes.';


--
-- Name: COLUMN collection_revision.user_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection_revision.user_id IS 'The ID of the admin who made this set of changes.';


--
-- Name: COLUMN collection_revision.created_at; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection_revision.created_at IS 'The timestamp of when these changes were made.';


--
-- Name: COLUMN collection_revision.remark; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.collection_revision.remark IS 'Optional remarks explaining why these changes were made.';


--
-- Name: collection_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.collection_revision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_revision_id_seq OWNER TO metabase;

--
-- Name: collection_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.collection_revision_id_seq OWNED BY public.collection_revision.id;


--
-- Name: computation_job; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.computation_job (
    id integer NOT NULL,
    creator_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying(254) NOT NULL,
    status character varying(254) NOT NULL,
    context text,
    ended_at timestamp without time zone
);


ALTER TABLE public.computation_job OWNER TO metabase;

--
-- Name: TABLE computation_job; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.computation_job IS 'Stores submitted async computation jobs.';


--
-- Name: computation_job_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.computation_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.computation_job_id_seq OWNER TO metabase;

--
-- Name: computation_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.computation_job_id_seq OWNED BY public.computation_job.id;


--
-- Name: computation_job_result; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.computation_job_result (
    id integer NOT NULL,
    job_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    permanence character varying(254) NOT NULL,
    payload text NOT NULL
);


ALTER TABLE public.computation_job_result OWNER TO metabase;

--
-- Name: TABLE computation_job_result; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.computation_job_result IS 'Stores results of async computation jobs.';


--
-- Name: computation_job_result_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.computation_job_result_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.computation_job_result_id_seq OWNER TO metabase;

--
-- Name: computation_job_result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.computation_job_result_id_seq OWNED BY public.computation_job_result.id;


--
-- Name: core_session; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.core_session (
    id character varying(254) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    anti_csrf_token text
);


ALTER TABLE public.core_session OWNER TO metabase;

--
-- Name: COLUMN core_session.anti_csrf_token; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.core_session.anti_csrf_token IS 'Anti-CSRF token for full-app embed sessions.';


--
-- Name: core_user; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.core_user (
    id integer NOT NULL,
    email public.citext NOT NULL,
    first_name character varying(254) NOT NULL,
    last_name character varying(254) NOT NULL,
    password character varying(254) NOT NULL,
    password_salt character varying(254) DEFAULT 'default'::character varying NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    reset_token character varying(254),
    reset_triggered bigint,
    is_qbnewb boolean DEFAULT true NOT NULL,
    google_auth boolean DEFAULT false NOT NULL,
    ldap_auth boolean DEFAULT false NOT NULL,
    login_attributes text,
    updated_at timestamp without time zone,
    sso_source character varying(254),
    locale character varying(5)
);


ALTER TABLE public.core_user OWNER TO metabase;

--
-- Name: COLUMN core_user.login_attributes; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.core_user.login_attributes IS 'JSON serialized map with attributes used for row level permissions';


--
-- Name: COLUMN core_user.updated_at; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.core_user.updated_at IS 'When was this User last updated?';


--
-- Name: COLUMN core_user.sso_source; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.core_user.sso_source IS 'String to indicate the SSO backend the user is from';


--
-- Name: COLUMN core_user.locale; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.core_user.locale IS 'Preferred ISO locale (language/country) code, e.g "en" or "en-US", for this User. Overrides site default.';


--
-- Name: core_user_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.core_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_user_id_seq OWNER TO metabase;

--
-- Name: core_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.core_user_id_seq OWNED BY public.core_user.id;


--
-- Name: dashboard_favorite; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.dashboard_favorite (
    id integer NOT NULL,
    user_id integer NOT NULL,
    dashboard_id integer NOT NULL
);


ALTER TABLE public.dashboard_favorite OWNER TO metabase;

--
-- Name: TABLE dashboard_favorite; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.dashboard_favorite IS 'Presence of a row here indicates a given User has favorited a given Dashboard.';


--
-- Name: COLUMN dashboard_favorite.user_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.dashboard_favorite.user_id IS 'ID of the User who favorited the Dashboard.';


--
-- Name: COLUMN dashboard_favorite.dashboard_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.dashboard_favorite.dashboard_id IS 'ID of the Dashboard favorited by the User.';


--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.dashboard_favorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_favorite_id_seq OWNER TO metabase;

--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.dashboard_favorite_id_seq OWNED BY public.dashboard_favorite.id;


--
-- Name: dashboardcard_series; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.dashboardcard_series (
    id integer NOT NULL,
    dashboardcard_id integer NOT NULL,
    card_id integer NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE public.dashboardcard_series OWNER TO metabase;

--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.dashboardcard_series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboardcard_series_id_seq OWNER TO metabase;

--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.dashboardcard_series_id_seq OWNED BY public.dashboardcard_series.id;


--
-- Name: data_migrations; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.data_migrations (
    id character varying(254) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.data_migrations OWNER TO metabase;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO metabase;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO metabase;

--
-- Name: dependency; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.dependency (
    id integer NOT NULL,
    model character varying(32) NOT NULL,
    model_id integer NOT NULL,
    dependent_on_model character varying(32) NOT NULL,
    dependent_on_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dependency OWNER TO metabase;

--
-- Name: dependency_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.dependency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dependency_id_seq OWNER TO metabase;

--
-- Name: dependency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.dependency_id_seq OWNED BY public.dependency.id;


--
-- Name: dimension; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.dimension (
    id integer NOT NULL,
    field_id integer NOT NULL,
    name character varying(254) NOT NULL,
    type character varying(254) NOT NULL,
    human_readable_field_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.dimension OWNER TO metabase;

--
-- Name: TABLE dimension; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.dimension IS 'Stores references to alternate views of existing fields, such as remapping an integer to a description, like an enum';


--
-- Name: COLUMN dimension.field_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.dimension.field_id IS 'ID of the field this dimension row applies to';


--
-- Name: COLUMN dimension.name; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.dimension.name IS 'Short description used as the display name of this new column';


--
-- Name: COLUMN dimension.type; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.dimension.type IS 'Either internal for a user defined remapping or external for a foreign key based remapping';


--
-- Name: COLUMN dimension.human_readable_field_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.dimension.human_readable_field_id IS 'Only used with external type remappings. Indicates which field on the FK related table to use for display';


--
-- Name: COLUMN dimension.created_at; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.dimension.created_at IS 'The timestamp of when the dimension was created.';


--
-- Name: COLUMN dimension.updated_at; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.dimension.updated_at IS 'The timestamp of when these dimension was last updated.';


--
-- Name: dimension_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.dimension_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dimension_id_seq OWNER TO metabase;

--
-- Name: dimension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.dimension_id_seq OWNED BY public.dimension.id;


--
-- Name: group_table_access_policy; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.group_table_access_policy (
    id integer NOT NULL,
    group_id integer NOT NULL,
    table_id integer NOT NULL,
    card_id integer,
    attribute_remappings text
);


ALTER TABLE public.group_table_access_policy OWNER TO metabase;

--
-- Name: TABLE group_table_access_policy; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.group_table_access_policy IS 'Records that a given Card (Question) should automatically replace a given Table as query source for a given a Perms Group.';


--
-- Name: COLUMN group_table_access_policy.group_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.group_table_access_policy.group_id IS 'ID of the Permissions Group this policy affects.';


--
-- Name: COLUMN group_table_access_policy.table_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.group_table_access_policy.table_id IS 'ID of the Table that should get automatically replaced as query source for the Permissions Group.';


--
-- Name: COLUMN group_table_access_policy.card_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.group_table_access_policy.card_id IS 'ID of the Card (Question) to be used to replace the Table.';


--
-- Name: COLUMN group_table_access_policy.attribute_remappings; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.group_table_access_policy.attribute_remappings IS 'JSON-encoded map of user attribute identifier to the param name used in the Card.';


--
-- Name: group_table_access_policy_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.group_table_access_policy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_table_access_policy_id_seq OWNER TO metabase;

--
-- Name: group_table_access_policy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.group_table_access_policy_id_seq OWNED BY public.group_table_access_policy.id;


--
-- Name: label; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.label (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    slug character varying(254) NOT NULL,
    icon character varying(128)
);


ALTER TABLE public.label OWNER TO metabase;

--
-- Name: label_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.label_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.label_id_seq OWNER TO metabase;

--
-- Name: label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.label_id_seq OWNED BY public.label.id;


--
-- Name: login_history; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.login_history (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT now() NOT NULL,
    user_id integer NOT NULL,
    session_id character varying(254),
    device_id character(36) NOT NULL,
    device_description text NOT NULL,
    ip_address text NOT NULL
);


ALTER TABLE public.login_history OWNER TO metabase;

--
-- Name: TABLE login_history; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.login_history IS 'Keeps track of various logins for different users and additional info such as location and device';


--
-- Name: COLUMN login_history."timestamp"; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.login_history."timestamp" IS 'When this login occurred.';


--
-- Name: COLUMN login_history.user_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.login_history.user_id IS 'ID of the User that logged in.';


--
-- Name: COLUMN login_history.session_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.login_history.session_id IS 'ID of the Session created by this login if one is currently active. NULL if Session is no longer active.';


--
-- Name: COLUMN login_history.device_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.login_history.device_id IS 'Cookie-based unique identifier for the device/browser the user logged in from.';


--
-- Name: COLUMN login_history.device_description; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.login_history.device_description IS 'Description of the device that login happened from, for example a user-agent string, but this might be something different if we support alternative auth mechanisms in the future.';


--
-- Name: COLUMN login_history.ip_address; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.login_history.ip_address IS 'IP address of the device that login happened from, so we can geocode it and determine approximate location.';


--
-- Name: login_history_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.login_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_history_id_seq OWNER TO metabase;

--
-- Name: login_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.login_history_id_seq OWNED BY public.login_history.id;


--
-- Name: metabase_database; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.metabase_database (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    details text,
    engine character varying(254) NOT NULL,
    is_sample boolean DEFAULT false NOT NULL,
    is_full_sync boolean DEFAULT true NOT NULL,
    points_of_interest text,
    caveats text,
    metadata_sync_schedule character varying(254) DEFAULT '0 50 * * * ? *'::character varying NOT NULL,
    cache_field_values_schedule character varying(254) DEFAULT '0 50 0 * * ? *'::character varying NOT NULL,
    timezone character varying(254),
    is_on_demand boolean DEFAULT false NOT NULL,
    options text,
    auto_run_queries boolean DEFAULT true NOT NULL,
    refingerprint boolean
);


ALTER TABLE public.metabase_database OWNER TO metabase;

--
-- Name: COLUMN metabase_database.metadata_sync_schedule; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_database.metadata_sync_schedule IS 'The cron schedule string for when this database should undergo the metadata sync process (and analysis for new fields).';


--
-- Name: COLUMN metabase_database.cache_field_values_schedule; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_database.cache_field_values_schedule IS 'The cron schedule string for when FieldValues for eligible Fields should be updated.';


--
-- Name: COLUMN metabase_database.timezone; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_database.timezone IS 'Timezone identifier for the database, set by the sync process';


--
-- Name: COLUMN metabase_database.is_on_demand; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_database.is_on_demand IS 'Whether we should do On-Demand caching of FieldValues for this DB. This means FieldValues are updated when their Field is used in a Dashboard or Card param.';


--
-- Name: COLUMN metabase_database.options; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_database.options IS 'Serialized JSON containing various options like QB behavior.';


--
-- Name: COLUMN metabase_database.auto_run_queries; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_database.auto_run_queries IS 'Whether to automatically run queries when doing simple filtering and summarizing in the Query Builder.';


--
-- Name: COLUMN metabase_database.refingerprint; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_database.refingerprint IS 'Whether or not to enable periodic refingerprinting for this Database.';


--
-- Name: metabase_database_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.metabase_database_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metabase_database_id_seq OWNER TO metabase;

--
-- Name: metabase_database_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.metabase_database_id_seq OWNED BY public.metabase_database.id;


--
-- Name: metabase_field; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.metabase_field (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    base_type character varying(255) NOT NULL,
    semantic_type character varying(255),
    active boolean DEFAULT true NOT NULL,
    description text,
    preview_display boolean DEFAULT true NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    table_id integer NOT NULL,
    parent_id integer,
    display_name character varying(254),
    visibility_type character varying(32) DEFAULT 'normal'::character varying NOT NULL,
    fk_target_field_id integer,
    last_analyzed timestamp with time zone,
    points_of_interest text,
    caveats text,
    fingerprint text,
    fingerprint_version integer DEFAULT 0 NOT NULL,
    database_type text NOT NULL,
    has_field_values text,
    settings text,
    database_position integer DEFAULT 0 NOT NULL,
    custom_position integer DEFAULT 0 NOT NULL,
    effective_type character varying(255),
    coercion_strategy character varying(255)
);


ALTER TABLE public.metabase_field OWNER TO metabase;

--
-- Name: COLUMN metabase_field.fingerprint; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_field.fingerprint IS 'Serialized JSON containing non-identifying information about this Field, such as min, max, and percent JSON. Used for classification.';


--
-- Name: COLUMN metabase_field.fingerprint_version; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_field.fingerprint_version IS 'The version of the fingerprint for this Field. Used so we can keep track of which Fields need to be analyzed again when new things are added to fingerprints.';


--
-- Name: COLUMN metabase_field.database_type; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_field.database_type IS 'The actual type of this column in the database. e.g. VARCHAR or TEXT.';


--
-- Name: COLUMN metabase_field.has_field_values; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_field.has_field_values IS 'Whether we have FieldValues ("list"), should ad-hoc search ("search"), disable entirely ("none"), or infer dynamically (null)"';


--
-- Name: COLUMN metabase_field.settings; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_field.settings IS 'Serialized JSON FE-specific settings like formatting, etc. Scope of what is stored here may increase in future.';


--
-- Name: COLUMN metabase_field.effective_type; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_field.effective_type IS 'The effective type of the field after any coercions.';


--
-- Name: COLUMN metabase_field.coercion_strategy; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.metabase_field.coercion_strategy IS 'A strategy to coerce the base_type into the effective_type.';


--
-- Name: metabase_field_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.metabase_field_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metabase_field_id_seq OWNER TO metabase;

--
-- Name: metabase_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.metabase_field_id_seq OWNED BY public.metabase_field.id;


--
-- Name: metabase_fieldvalues; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.metabase_fieldvalues (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "values" text,
    human_readable_values text,
    field_id integer NOT NULL
);


ALTER TABLE public.metabase_fieldvalues OWNER TO metabase;

--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.metabase_fieldvalues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metabase_fieldvalues_id_seq OWNER TO metabase;

--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.metabase_fieldvalues_id_seq OWNED BY public.metabase_fieldvalues.id;


--
-- Name: metabase_table; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.metabase_table (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    entity_name character varying(254),
    entity_type character varying(254),
    active boolean NOT NULL,
    db_id integer NOT NULL,
    display_name character varying(254),
    visibility_type character varying(254),
    schema character varying(254),
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL,
    field_order character varying(254) DEFAULT 'database'::character varying NOT NULL
);


ALTER TABLE public.metabase_table OWNER TO metabase;

--
-- Name: metabase_table_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.metabase_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metabase_table_id_seq OWNER TO metabase;

--
-- Name: metabase_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.metabase_table_id_seq OWNED BY public.metabase_table.id;


--
-- Name: metric; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.metric (
    id integer NOT NULL,
    table_id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    archived boolean DEFAULT false NOT NULL,
    definition text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    points_of_interest text,
    caveats text,
    how_is_this_calculated text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE public.metric OWNER TO metabase;

--
-- Name: metric_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.metric_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metric_id_seq OWNER TO metabase;

--
-- Name: metric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.metric_id_seq OWNED BY public.metric.id;


--
-- Name: metric_important_field; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.metric_important_field (
    id integer NOT NULL,
    metric_id integer NOT NULL,
    field_id integer NOT NULL
);


ALTER TABLE public.metric_important_field OWNER TO metabase;

--
-- Name: metric_important_field_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.metric_important_field_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metric_important_field_id_seq OWNER TO metabase;

--
-- Name: metric_important_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.metric_important_field_id_seq OWNED BY public.metric_important_field.id;


--
-- Name: native_query_snippet; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.native_query_snippet (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    content text NOT NULL,
    creator_id integer NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    collection_id integer
);


ALTER TABLE public.native_query_snippet OWNER TO metabase;

--
-- Name: TABLE native_query_snippet; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.native_query_snippet IS 'Query snippets (raw text) to be substituted in native queries';


--
-- Name: COLUMN native_query_snippet.name; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.native_query_snippet.name IS 'Name of the query snippet';


--
-- Name: COLUMN native_query_snippet.content; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.native_query_snippet.content IS 'Raw query snippet';


--
-- Name: COLUMN native_query_snippet.collection_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.native_query_snippet.collection_id IS 'ID of the Snippet Folder (Collection) this Snippet is in, if any';


--
-- Name: native_query_snippet_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.native_query_snippet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.native_query_snippet_id_seq OWNER TO metabase;

--
-- Name: native_query_snippet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.native_query_snippet_id_seq OWNED BY public.native_query_snippet.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    object character varying(254) NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.permissions OWNER TO metabase;

--
-- Name: permissions_group; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.permissions_group (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.permissions_group OWNER TO metabase;

--
-- Name: permissions_group_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.permissions_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_group_id_seq OWNER TO metabase;

--
-- Name: permissions_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.permissions_group_id_seq OWNED BY public.permissions_group.id;


--
-- Name: permissions_group_membership; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.permissions_group_membership (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.permissions_group_membership OWNER TO metabase;

--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.permissions_group_membership_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_group_membership_id_seq OWNER TO metabase;

--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.permissions_group_membership_id_seq OWNED BY public.permissions_group_membership.id;


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO metabase;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: permissions_revision; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.permissions_revision (
    id integer NOT NULL,
    before text NOT NULL,
    after text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    remark text
);


ALTER TABLE public.permissions_revision OWNER TO metabase;

--
-- Name: TABLE permissions_revision; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.permissions_revision IS 'Used to keep track of changes made to permissions.';


--
-- Name: COLUMN permissions_revision.before; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.permissions_revision.before IS 'Serialized JSON of the permissions before the changes.';


--
-- Name: COLUMN permissions_revision.after; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.permissions_revision.after IS 'Serialized JSON of the permissions after the changes.';


--
-- Name: COLUMN permissions_revision.user_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.permissions_revision.user_id IS 'The ID of the admin who made this set of changes.';


--
-- Name: COLUMN permissions_revision.created_at; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.permissions_revision.created_at IS 'The timestamp of when these changes were made.';


--
-- Name: COLUMN permissions_revision.remark; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.permissions_revision.remark IS 'Optional remarks explaining why these changes were made.';


--
-- Name: permissions_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.permissions_revision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_revision_id_seq OWNER TO metabase;

--
-- Name: permissions_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.permissions_revision_id_seq OWNED BY public.permissions_revision.id;


--
-- Name: pulse; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.pulse (
    id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    skip_if_empty boolean DEFAULT false NOT NULL,
    alert_condition character varying(254),
    alert_first_only boolean,
    alert_above_goal boolean,
    collection_id integer,
    collection_position smallint,
    archived boolean DEFAULT false,
    dashboard_id integer,
    parameters text NOT NULL
);


ALTER TABLE public.pulse OWNER TO metabase;

--
-- Name: COLUMN pulse.skip_if_empty; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.skip_if_empty IS 'Skip a scheduled Pulse if none of its questions have any results';


--
-- Name: COLUMN pulse.alert_condition; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.alert_condition IS 'Condition (i.e. "rows" or "goal") used as a guard for alerts';


--
-- Name: COLUMN pulse.alert_first_only; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.alert_first_only IS 'True if the alert should be disabled after the first notification';


--
-- Name: COLUMN pulse.alert_above_goal; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.alert_above_goal IS 'For a goal condition, alert when above the goal';


--
-- Name: COLUMN pulse.collection_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.collection_id IS 'Options ID of Collection this Pulse belongs to.';


--
-- Name: COLUMN pulse.collection_position; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.collection_position IS 'Optional pinned position for this item in its Collection. NULL means item is not pinned.';


--
-- Name: COLUMN pulse.archived; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.archived IS 'Has this pulse been archived?';


--
-- Name: COLUMN pulse.dashboard_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.dashboard_id IS 'ID of the Dashboard if this Pulse is a Dashboard Subscription.';


--
-- Name: COLUMN pulse.parameters; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse.parameters IS 'Let dashboard subscriptions have their own filters';


--
-- Name: pulse_card; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.pulse_card (
    id integer NOT NULL,
    pulse_id integer NOT NULL,
    card_id integer NOT NULL,
    "position" integer NOT NULL,
    include_csv boolean DEFAULT false NOT NULL,
    include_xls boolean DEFAULT false NOT NULL,
    dashboard_card_id integer
);


ALTER TABLE public.pulse_card OWNER TO metabase;

--
-- Name: COLUMN pulse_card.include_csv; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse_card.include_csv IS 'True if a CSV of the data should be included for this pulse card';


--
-- Name: COLUMN pulse_card.include_xls; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse_card.include_xls IS 'True if a XLS of the data should be included for this pulse card';


--
-- Name: COLUMN pulse_card.dashboard_card_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.pulse_card.dashboard_card_id IS 'If this Pulse is a Dashboard subscription, the ID of the DashboardCard that corresponds to this PulseCard.';


--
-- Name: pulse_card_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.pulse_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pulse_card_id_seq OWNER TO metabase;

--
-- Name: pulse_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.pulse_card_id_seq OWNED BY public.pulse_card.id;


--
-- Name: pulse_channel; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.pulse_channel (
    id integer NOT NULL,
    pulse_id integer NOT NULL,
    channel_type character varying(32) NOT NULL,
    details text NOT NULL,
    schedule_type character varying(32) NOT NULL,
    schedule_hour integer,
    schedule_day character varying(64),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    schedule_frame character varying(32),
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.pulse_channel OWNER TO metabase;

--
-- Name: pulse_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.pulse_channel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pulse_channel_id_seq OWNER TO metabase;

--
-- Name: pulse_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.pulse_channel_id_seq OWNED BY public.pulse_channel.id;


--
-- Name: pulse_channel_recipient; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.pulse_channel_recipient (
    id integer NOT NULL,
    pulse_channel_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.pulse_channel_recipient OWNER TO metabase;

--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.pulse_channel_recipient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pulse_channel_recipient_id_seq OWNER TO metabase;

--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.pulse_channel_recipient_id_seq OWNED BY public.pulse_channel_recipient.id;


--
-- Name: pulse_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.pulse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pulse_id_seq OWNER TO metabase;

--
-- Name: pulse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.pulse_id_seq OWNED BY public.pulse.id;


--
-- Name: qrtz_blob_triggers; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_blob_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    blob_data bytea
);


ALTER TABLE public.qrtz_blob_triggers OWNER TO metabase;

--
-- Name: TABLE qrtz_blob_triggers; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_blob_triggers IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_calendars; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_calendars (
    sched_name character varying(120) NOT NULL,
    calendar_name character varying(200) NOT NULL,
    calendar bytea NOT NULL
);


ALTER TABLE public.qrtz_calendars OWNER TO metabase;

--
-- Name: TABLE qrtz_calendars; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_calendars IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_cron_triggers; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_cron_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    cron_expression character varying(120) NOT NULL,
    time_zone_id character varying(80)
);


ALTER TABLE public.qrtz_cron_triggers OWNER TO metabase;

--
-- Name: TABLE qrtz_cron_triggers; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_cron_triggers IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_fired_triggers; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_fired_triggers (
    sched_name character varying(120) NOT NULL,
    entry_id character varying(95) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    instance_name character varying(200) NOT NULL,
    fired_time bigint NOT NULL,
    sched_time bigint,
    priority integer NOT NULL,
    state character varying(16) NOT NULL,
    job_name character varying(200),
    job_group character varying(200),
    is_nonconcurrent boolean,
    requests_recovery boolean
);


ALTER TABLE public.qrtz_fired_triggers OWNER TO metabase;

--
-- Name: TABLE qrtz_fired_triggers; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_fired_triggers IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_job_details; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_job_details (
    sched_name character varying(120) NOT NULL,
    job_name character varying(200) NOT NULL,
    job_group character varying(200) NOT NULL,
    description character varying(250),
    job_class_name character varying(250) NOT NULL,
    is_durable boolean NOT NULL,
    is_nonconcurrent boolean NOT NULL,
    is_update_data boolean NOT NULL,
    requests_recovery boolean NOT NULL,
    job_data bytea
);


ALTER TABLE public.qrtz_job_details OWNER TO metabase;

--
-- Name: TABLE qrtz_job_details; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_job_details IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_locks; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_locks (
    sched_name character varying(120) NOT NULL,
    lock_name character varying(40) NOT NULL
);


ALTER TABLE public.qrtz_locks OWNER TO metabase;

--
-- Name: TABLE qrtz_locks; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_locks IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_paused_trigger_grps; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_paused_trigger_grps (
    sched_name character varying(120) NOT NULL,
    trigger_group character varying(200) NOT NULL
);


ALTER TABLE public.qrtz_paused_trigger_grps OWNER TO metabase;

--
-- Name: TABLE qrtz_paused_trigger_grps; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_paused_trigger_grps IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_scheduler_state; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_scheduler_state (
    sched_name character varying(120) NOT NULL,
    instance_name character varying(200) NOT NULL,
    last_checkin_time bigint NOT NULL,
    checkin_interval bigint NOT NULL
);


ALTER TABLE public.qrtz_scheduler_state OWNER TO metabase;

--
-- Name: TABLE qrtz_scheduler_state; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_scheduler_state IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_simple_triggers; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_simple_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    repeat_count bigint NOT NULL,
    repeat_interval bigint NOT NULL,
    times_triggered bigint NOT NULL
);


ALTER TABLE public.qrtz_simple_triggers OWNER TO metabase;

--
-- Name: TABLE qrtz_simple_triggers; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_simple_triggers IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_simprop_triggers; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_simprop_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    str_prop_1 character varying(512),
    str_prop_2 character varying(512),
    str_prop_3 character varying(512),
    int_prop_1 integer,
    int_prop_2 integer,
    long_prop_1 bigint,
    long_prop_2 bigint,
    dec_prop_1 numeric(13,4),
    dec_prop_2 numeric(13,4),
    bool_prop_1 boolean,
    bool_prop_2 boolean
);


ALTER TABLE public.qrtz_simprop_triggers OWNER TO metabase;

--
-- Name: TABLE qrtz_simprop_triggers; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_simprop_triggers IS 'Used for Quartz scheduler.';


--
-- Name: qrtz_triggers; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.qrtz_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    job_name character varying(200) NOT NULL,
    job_group character varying(200) NOT NULL,
    description character varying(250),
    next_fire_time bigint,
    prev_fire_time bigint,
    priority integer,
    trigger_state character varying(16) NOT NULL,
    trigger_type character varying(8) NOT NULL,
    start_time bigint NOT NULL,
    end_time bigint,
    calendar_name character varying(200),
    misfire_instr smallint,
    job_data bytea
);


ALTER TABLE public.qrtz_triggers OWNER TO metabase;

--
-- Name: TABLE qrtz_triggers; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.qrtz_triggers IS 'Used for Quartz scheduler.';


--
-- Name: query; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.query (
    query_hash bytea NOT NULL,
    average_execution_time integer NOT NULL,
    query text
);


ALTER TABLE public.query OWNER TO metabase;

--
-- Name: TABLE query; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.query IS 'Information (such as average execution time) for different queries that have been previously ran.';


--
-- Name: COLUMN query.query_hash; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query.query_hash IS 'The hash of the query dictionary. (This is a 256-bit SHA3 hash of the query dict.)';


--
-- Name: COLUMN query.average_execution_time; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query.average_execution_time IS 'Average execution time for the query, round to nearest number of milliseconds. This is updated as a rolling average.';


--
-- Name: COLUMN query.query; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query.query IS 'The actual "query dictionary" for this query.';


--
-- Name: query_cache; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.query_cache (
    query_hash bytea NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    results bytea NOT NULL
);


ALTER TABLE public.query_cache OWNER TO metabase;

--
-- Name: TABLE query_cache; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.query_cache IS 'Cached results of queries are stored here when using the DB-based query cache.';


--
-- Name: COLUMN query_cache.query_hash; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_cache.query_hash IS 'The hash of the query dictionary. (This is a 256-bit SHA3 hash of the query dict).';


--
-- Name: COLUMN query_cache.updated_at; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_cache.updated_at IS 'The timestamp of when these query results were last refreshed.';


--
-- Name: COLUMN query_cache.results; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_cache.results IS 'Cached, compressed results of running the query with the given hash.';


--
-- Name: query_execution; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.query_execution (
    id integer NOT NULL,
    hash bytea NOT NULL,
    started_at timestamp with time zone NOT NULL,
    running_time integer NOT NULL,
    result_rows integer NOT NULL,
    native boolean NOT NULL,
    context character varying(32),
    error text,
    executor_id integer,
    card_id integer,
    dashboard_id integer,
    pulse_id integer,
    database_id integer
);


ALTER TABLE public.query_execution OWNER TO metabase;

--
-- Name: TABLE query_execution; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.query_execution IS 'A log of executed queries, used for calculating historic execution times, auditing, and other purposes.';


--
-- Name: COLUMN query_execution.hash; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.hash IS 'The hash of the query dictionary. This is a 256-bit SHA3 hash of the query.';


--
-- Name: COLUMN query_execution.started_at; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.started_at IS 'Timestamp of when this query started running.';


--
-- Name: COLUMN query_execution.running_time; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.running_time IS 'The time, in milliseconds, this query took to complete.';


--
-- Name: COLUMN query_execution.result_rows; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.result_rows IS 'Number of rows in the query results.';


--
-- Name: COLUMN query_execution.native; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.native IS 'Whether the query was a native query, as opposed to an MBQL one (e.g., created with the GUI).';


--
-- Name: COLUMN query_execution.context; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.context IS 'Short string specifying how this query was executed, e.g. in a Dashboard or Pulse.';


--
-- Name: COLUMN query_execution.error; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.error IS 'Error message returned by failed query, if any.';


--
-- Name: COLUMN query_execution.executor_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.executor_id IS 'The ID of the User who triggered this query execution, if any.';


--
-- Name: COLUMN query_execution.card_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.card_id IS 'The ID of the Card (Question) associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.dashboard_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.dashboard_id IS 'The ID of the Dashboard associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.pulse_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.pulse_id IS 'The ID of the Pulse associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.database_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.query_execution.database_id IS 'ID of the database this query was ran against.';


--
-- Name: query_execution_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.query_execution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.query_execution_id_seq OWNER TO metabase;

--
-- Name: query_execution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.query_execution_id_seq OWNED BY public.query_execution.id;


--
-- Name: report_card; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.report_card (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    display character varying(254) NOT NULL,
    dataset_query text NOT NULL,
    visualization_settings text NOT NULL,
    creator_id integer NOT NULL,
    database_id integer,
    table_id integer,
    query_type character varying(16),
    archived boolean DEFAULT false NOT NULL,
    collection_id integer,
    public_uuid character(36),
    made_public_by_id integer,
    enable_embedding boolean DEFAULT false NOT NULL,
    embedding_params text,
    cache_ttl integer,
    result_metadata text,
    collection_position smallint
);


ALTER TABLE public.report_card OWNER TO metabase;

--
-- Name: COLUMN report_card.collection_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_card.collection_id IS 'Optional ID of Collection this Card belongs to.';


--
-- Name: COLUMN report_card.public_uuid; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_card.public_uuid IS 'Unique UUID used to in publically-accessible links to this Card.';


--
-- Name: COLUMN report_card.made_public_by_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_card.made_public_by_id IS 'The ID of the User who first publically shared this Card.';


--
-- Name: COLUMN report_card.enable_embedding; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_card.enable_embedding IS 'Is this Card allowed to be embedded in different websites (using a signed JWT)?';


--
-- Name: COLUMN report_card.embedding_params; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_card.embedding_params IS 'Serialized JSON containing information about required parameters that must be supplied when embedding this Card.';


--
-- Name: COLUMN report_card.cache_ttl; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_card.cache_ttl IS 'The maximum time, in seconds, to return cached results for this Card rather than running a new query.';


--
-- Name: COLUMN report_card.result_metadata; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_card.result_metadata IS 'Serialized JSON containing metadata about the result columns from running the query.';


--
-- Name: COLUMN report_card.collection_position; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_card.collection_position IS 'Optional pinned position for this item in its Collection. NULL means item is not pinned.';


--
-- Name: report_card_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.report_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_card_id_seq OWNER TO metabase;

--
-- Name: report_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.report_card_id_seq OWNED BY public.report_card.id;


--
-- Name: report_cardfavorite; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.report_cardfavorite (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    card_id integer NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE public.report_cardfavorite OWNER TO metabase;

--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.report_cardfavorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_cardfavorite_id_seq OWNER TO metabase;

--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.report_cardfavorite_id_seq OWNED BY public.report_cardfavorite.id;


--
-- Name: report_dashboard; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.report_dashboard (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    creator_id integer NOT NULL,
    parameters text NOT NULL,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL,
    public_uuid character(36),
    made_public_by_id integer,
    enable_embedding boolean DEFAULT false NOT NULL,
    embedding_params text,
    archived boolean DEFAULT false NOT NULL,
    "position" integer,
    collection_id integer,
    collection_position smallint
);


ALTER TABLE public.report_dashboard OWNER TO metabase;

--
-- Name: COLUMN report_dashboard.public_uuid; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_dashboard.public_uuid IS 'Unique UUID used to in publically-accessible links to this Dashboard.';


--
-- Name: COLUMN report_dashboard.made_public_by_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_dashboard.made_public_by_id IS 'The ID of the User who first publically shared this Dashboard.';


--
-- Name: COLUMN report_dashboard.enable_embedding; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_dashboard.enable_embedding IS 'Is this Dashboard allowed to be embedded in different websites (using a signed JWT)?';


--
-- Name: COLUMN report_dashboard.embedding_params; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_dashboard.embedding_params IS 'Serialized JSON containing information about required parameters that must be supplied when embedding this Dashboard.';


--
-- Name: COLUMN report_dashboard.archived; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_dashboard.archived IS 'Is this Dashboard archived (effectively treated as deleted?)';


--
-- Name: COLUMN report_dashboard."position"; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_dashboard."position" IS 'The position this Dashboard should appear in the Dashboards list, lower-numbered positions appearing before higher numbered ones.';


--
-- Name: COLUMN report_dashboard.collection_id; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_dashboard.collection_id IS 'Optional ID of Collection this Dashboard belongs to.';


--
-- Name: COLUMN report_dashboard.collection_position; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.report_dashboard.collection_position IS 'Optional pinned position for this item in its Collection. NULL means item is not pinned.';


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.report_dashboard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_dashboard_id_seq OWNER TO metabase;

--
-- Name: report_dashboard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.report_dashboard_id_seq OWNED BY public.report_dashboard.id;


--
-- Name: report_dashboardcard; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.report_dashboardcard (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "sizeX" integer NOT NULL,
    "sizeY" integer NOT NULL,
    "row" integer DEFAULT 0 NOT NULL,
    col integer DEFAULT 0 NOT NULL,
    card_id integer,
    dashboard_id integer NOT NULL,
    parameter_mappings text NOT NULL,
    visualization_settings text NOT NULL
);


ALTER TABLE public.report_dashboardcard OWNER TO metabase;

--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.report_dashboardcard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_dashboardcard_id_seq OWNER TO metabase;

--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.report_dashboardcard_id_seq OWNED BY public.report_dashboardcard.id;


--
-- Name: revision; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.revision (
    id integer NOT NULL,
    model character varying(16) NOT NULL,
    model_id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    object character varying NOT NULL,
    is_reversion boolean DEFAULT false NOT NULL,
    is_creation boolean DEFAULT false NOT NULL,
    message text
);


ALTER TABLE public.revision OWNER TO metabase;

--
-- Name: revision_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.revision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revision_id_seq OWNER TO metabase;

--
-- Name: revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.revision_id_seq OWNED BY public.revision.id;


--
-- Name: segment; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.segment (
    id integer NOT NULL,
    table_id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    archived boolean DEFAULT false NOT NULL,
    definition text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE public.segment OWNER TO metabase;

--
-- Name: segment_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.segment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.segment_id_seq OWNER TO metabase;

--
-- Name: segment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.segment_id_seq OWNED BY public.segment.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.setting (
    key character varying(254) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.setting OWNER TO metabase;

--
-- Name: task_history; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.task_history (
    id integer NOT NULL,
    task character varying(254) NOT NULL,
    db_id integer,
    started_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ended_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    duration integer NOT NULL,
    task_details text
);


ALTER TABLE public.task_history OWNER TO metabase;

--
-- Name: TABLE task_history; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON TABLE public.task_history IS 'Timing and metadata info about background/quartz processes';


--
-- Name: COLUMN task_history.task; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.task_history.task IS 'Name of the task';


--
-- Name: COLUMN task_history.task_details; Type: COMMENT; Schema: public; Owner: metabase
--

COMMENT ON COLUMN public.task_history.task_details IS 'JSON string with additional info on the task';


--
-- Name: task_history_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.task_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_history_id_seq OWNER TO metabase;

--
-- Name: task_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.task_history_id_seq OWNED BY public.task_history.id;


--
-- Name: view_log; Type: TABLE; Schema: public; Owner: metabase
--

CREATE TABLE public.view_log (
    id integer NOT NULL,
    user_id integer,
    model character varying(16) NOT NULL,
    model_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.view_log OWNER TO metabase;

--
-- Name: view_log_id_seq; Type: SEQUENCE; Schema: public; Owner: metabase
--

CREATE SEQUENCE public.view_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.view_log_id_seq OWNER TO metabase;

--
-- Name: view_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: metabase
--

ALTER SEQUENCE public.view_log_id_seq OWNED BY public.view_log.id;


--
-- Name: activity id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.activity ALTER COLUMN id SET DEFAULT nextval('public.activity_id_seq'::regclass);


--
-- Name: card_label id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.card_label ALTER COLUMN id SET DEFAULT nextval('public.card_label_id_seq'::regclass);


--
-- Name: collection id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.collection ALTER COLUMN id SET DEFAULT nextval('public.collection_id_seq'::regclass);


--
-- Name: collection_revision id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.collection_revision ALTER COLUMN id SET DEFAULT nextval('public.collection_revision_id_seq'::regclass);


--
-- Name: computation_job id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.computation_job ALTER COLUMN id SET DEFAULT nextval('public.computation_job_id_seq'::regclass);


--
-- Name: computation_job_result id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.computation_job_result ALTER COLUMN id SET DEFAULT nextval('public.computation_job_result_id_seq'::regclass);


--
-- Name: core_user id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.core_user ALTER COLUMN id SET DEFAULT nextval('public.core_user_id_seq'::regclass);


--
-- Name: dashboard_favorite id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboard_favorite ALTER COLUMN id SET DEFAULT nextval('public.dashboard_favorite_id_seq'::regclass);


--
-- Name: dashboardcard_series id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboardcard_series ALTER COLUMN id SET DEFAULT nextval('public.dashboardcard_series_id_seq'::regclass);


--
-- Name: dependency id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dependency ALTER COLUMN id SET DEFAULT nextval('public.dependency_id_seq'::regclass);


--
-- Name: dimension id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dimension ALTER COLUMN id SET DEFAULT nextval('public.dimension_id_seq'::regclass);


--
-- Name: group_table_access_policy id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.group_table_access_policy ALTER COLUMN id SET DEFAULT nextval('public.group_table_access_policy_id_seq'::regclass);


--
-- Name: label id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.label ALTER COLUMN id SET DEFAULT nextval('public.label_id_seq'::regclass);


--
-- Name: login_history id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.login_history ALTER COLUMN id SET DEFAULT nextval('public.login_history_id_seq'::regclass);


--
-- Name: metabase_database id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_database ALTER COLUMN id SET DEFAULT nextval('public.metabase_database_id_seq'::regclass);


--
-- Name: metabase_field id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_field ALTER COLUMN id SET DEFAULT nextval('public.metabase_field_id_seq'::regclass);


--
-- Name: metabase_fieldvalues id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_fieldvalues ALTER COLUMN id SET DEFAULT nextval('public.metabase_fieldvalues_id_seq'::regclass);


--
-- Name: metabase_table id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_table ALTER COLUMN id SET DEFAULT nextval('public.metabase_table_id_seq'::regclass);


--
-- Name: metric id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric ALTER COLUMN id SET DEFAULT nextval('public.metric_id_seq'::regclass);


--
-- Name: metric_important_field id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric_important_field ALTER COLUMN id SET DEFAULT nextval('public.metric_important_field_id_seq'::regclass);


--
-- Name: native_query_snippet id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.native_query_snippet ALTER COLUMN id SET DEFAULT nextval('public.native_query_snippet_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: permissions_group id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_group ALTER COLUMN id SET DEFAULT nextval('public.permissions_group_id_seq'::regclass);


--
-- Name: permissions_group_membership id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_group_membership ALTER COLUMN id SET DEFAULT nextval('public.permissions_group_membership_id_seq'::regclass);


--
-- Name: permissions_revision id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_revision ALTER COLUMN id SET DEFAULT nextval('public.permissions_revision_id_seq'::regclass);


--
-- Name: pulse id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse ALTER COLUMN id SET DEFAULT nextval('public.pulse_id_seq'::regclass);


--
-- Name: pulse_card id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_card ALTER COLUMN id SET DEFAULT nextval('public.pulse_card_id_seq'::regclass);


--
-- Name: pulse_channel id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_channel ALTER COLUMN id SET DEFAULT nextval('public.pulse_channel_id_seq'::regclass);


--
-- Name: pulse_channel_recipient id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_channel_recipient ALTER COLUMN id SET DEFAULT nextval('public.pulse_channel_recipient_id_seq'::regclass);


--
-- Name: query_execution id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.query_execution ALTER COLUMN id SET DEFAULT nextval('public.query_execution_id_seq'::regclass);


--
-- Name: report_card id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_card ALTER COLUMN id SET DEFAULT nextval('public.report_card_id_seq'::regclass);


--
-- Name: report_cardfavorite id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_cardfavorite ALTER COLUMN id SET DEFAULT nextval('public.report_cardfavorite_id_seq'::regclass);


--
-- Name: report_dashboard id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboard ALTER COLUMN id SET DEFAULT nextval('public.report_dashboard_id_seq'::regclass);


--
-- Name: report_dashboardcard id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboardcard ALTER COLUMN id SET DEFAULT nextval('public.report_dashboardcard_id_seq'::regclass);


--
-- Name: revision id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.revision ALTER COLUMN id SET DEFAULT nextval('public.revision_id_seq'::regclass);


--
-- Name: segment id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.segment ALTER COLUMN id SET DEFAULT nextval('public.segment_id_seq'::regclass);


--
-- Name: task_history id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.task_history ALTER COLUMN id SET DEFAULT nextval('public.task_history_id_seq'::regclass);


--
-- Name: view_log id; Type: DEFAULT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.view_log ALTER COLUMN id SET DEFAULT nextval('public.view_log_id_seq'::regclass);


--
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) FROM stdin;
1	install	2021-06-22 03:10:40.575266+00	\N	install	\N	\N	\N	\N	{}
2	user-joined	2021-06-23 23:37:45.762283+00	1	user	1	\N	\N	\N	{}
3	card-create	2021-06-24 18:28:41.909415+00	1	card	1	2	9	\N	{"name":"# de Avarias","description":null}
4	dashboard-create	2021-06-24 18:29:37.825167+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Inspection Summary"}
5	dashboard-add-cards	2021-06-24 18:30:29.42817+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Inspection Summary","dashcards":[{"name":"# de Avarias","description":null,"id":1,"card_id":1}]}
6	card-update	2021-06-24 18:32:23.856057+00	1	card	1	2	9	\N	{"name":"# de Avarias","description":null}
7	card-update	2021-06-24 18:32:36.639975+00	1	card	1	2	9	\N	{"name":"# de Avarias","description":null}
8	card-update	2021-06-24 18:55:45.702335+00	1	card	1	2	9	\N	{"name":"# de Avarias","description":null}
9	card-create	2021-06-24 19:03:12.507785+00	1	card	2	2	11	\N	{"name":"Inspected Area (m²)","description":null}
10	dashboard-add-cards	2021-06-24 19:03:25.92611+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Inspection Summary","dashcards":[{"name":"Inspected Area (m²)","description":null,"id":2,"card_id":2}]}
11	card-create	2021-06-24 19:21:10.300594+00	1	card	3	2	\N	\N	{"name":"Elapsed Time","description":null}
12	dashboard-add-cards	2021-06-24 19:21:53.828122+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Inspection Summary","dashcards":[{"name":"Elapsed Time","description":null,"id":3,"card_id":3}]}
13	card-update	2021-06-24 19:22:32.018098+00	1	card	3	2	\N	\N	{"name":"Elapsed Time","description":null}
14	card-create	2021-06-24 19:27:28.785742+00	1	card	4	2	9	\N	{"name":"Damaged roof tile list","description":null}
15	dashboard-add-cards	2021-06-24 19:28:02.30571+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Inspection Summary","dashcards":[{"name":"Damaged roof tile list","description":null,"id":4,"card_id":4}]}
16	card-create	2021-06-24 19:29:30.098457+00	1	card	5	2	9	\N	{"name":"Damaged roof area (m²)","description":null}
17	dashboard-add-cards	2021-06-24 19:29:37.698166+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Inspection Summary","dashcards":[{"name":"Damaged roof area (m²)","description":null,"id":5,"card_id":5}]}
18	card-update	2021-06-24 19:29:46.61519+00	1	card	5	2	9	\N	{"name":"Damaged roof area (m²)","description":null}
19	card-create	2021-06-24 19:31:14.011037+00	1	card	6	2	9	\N	{"name":"Damaged tile map","description":null}
20	dashboard-add-cards	2021-06-24 19:31:50.283731+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Inspection Summary","dashcards":[{"name":"Damaged tile map","description":null,"id":6,"card_id":6}]}
21	card-update	2021-06-25 00:21:11.926107+00	1	card	1	2	9	\N	{"name":"# de Avarias","description":null}
22	card-update	2021-06-25 00:25:38.037918+00	1	card	4	2	9	\N	{"name":"Damaged roof tile list","description":null}
23	card-update	2021-06-25 00:36:30.528338+00	1	card	1	2	9	\N	{"name":"# de Avarias","description":null}
24	card-update	2021-06-25 00:37:18.027279+00	1	card	2	2	11	\N	{"name":"Inspected Area (m²)","description":null}
25	card-update	2021-06-25 00:39:18.631645+00	1	card	3	2	\N	\N	{"name":"Elapsed Time","description":null}
26	card-update	2021-06-25 00:40:27.801722+00	1	card	6	2	9	\N	{"name":"Damaged tile map","description":null}
\.


--
-- Data for Name: card_label; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.card_label (id, card_id, label_id) FROM stdin;
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.collection (id, name, description, color, archived, location, personal_owner_id, slug, namespace) FROM stdin;
1	admin person's Personal Collection	\N	#31698A	f	/	1	admin_person_s_personal_collection	\N
2	Rooftop Inspection	\N	#509EE3	f	/	\N	rooftop_inspection	\N
\.


--
-- Data for Name: collection_revision; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.collection_revision (id, before, after, user_id, created_at, remark) FROM stdin;
\.


--
-- Data for Name: computation_job; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.computation_job (id, creator_id, created_at, updated_at, type, status, context, ended_at) FROM stdin;
\.


--
-- Data for Name: computation_job_result; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.computation_job_result (id, job_id, created_at, updated_at, permanence, payload) FROM stdin;
\.


--
-- Data for Name: core_session; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.core_session (id, user_id, created_at, anti_csrf_token) FROM stdin;
349513b9-9535-4ceb-b6f5-a99d78cb6ab0	1	2021-06-23 23:37:45.633951+00	\N
24215cae-f243-4918-a966-7d7abd045213	1	2021-06-24 18:23:22.932369+00	\N
e52ff473-daa0-4356-a20d-d5115831ff4f	1	2021-06-24 23:18:36.165475+00	\N
\.


--
-- Data for Name: core_user; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.core_user (id, email, first_name, last_name, password, password_salt, date_joined, last_login, is_superuser, is_active, reset_token, reset_triggered, is_qbnewb, google_auth, ldap_auth, login_attributes, updated_at, sso_source, locale) FROM stdin;
1	admin@gmail.com	admin	person	$2a$10$R5IXsKEvH3goo9/21SQYv.6uGN2HOIKhEfTSBNcb6OfcdZwEWUBX2	ec1704c7-3485-4be7-ba08-1ca57549f5ef	2021-06-23 23:37:45.633951+00	2021-06-24 23:18:36.1716+00	t	t	\N	\N	f	f	f	\N	2021-06-24 23:18:36.1716	\N	\N
\.


--
-- Data for Name: dashboard_favorite; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.dashboard_favorite (id, user_id, dashboard_id) FROM stdin;
\.


--
-- Data for Name: dashboardcard_series; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.dashboardcard_series (id, dashboardcard_id, card_id, "position") FROM stdin;
\.


--
-- Data for Name: data_migrations; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.data_migrations (id, "timestamp") FROM stdin;
add-users-to-default-permissions-groups	2021-06-22 03:10:38.339225
add-admin-group-root-entry	2021-06-22 03:10:38.455402
add-databases-to-magic-permissions-groups	2021-06-22 03:10:38.497858
migrate-field-types	2021-06-22 03:10:39.29429
fix-invalid-field-types	2021-06-22 03:10:39.373104
copy-site-url-setting-and-remove-trailing-slashes	2021-06-22 03:10:39.421791
ensure-protocol-specified-in-site-url	2021-06-22 03:10:39.465024
populate-card-database-id	2021-06-22 03:10:39.517518
migrate-humanization-setting	2021-06-22 03:10:39.549187
mark-category-fields-as-list	2021-06-22 03:10:39.590243
add-legacy-sql-directive-to-bigquery-sql-cards	2021-06-22 03:10:39.628654
clear-ldap-user-local-passwords	2021-06-22 03:10:39.667572
add-migrated-collections	2021-06-22 03:10:39.769226
migrate-click-through	2021-06-22 03:10:39.804312
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
15	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.094772	14	EXECUTED	8:505b91530103673a9be3382cd2db1070	addColumn tableName=revision		\N	3.6.3	\N	\N	4331435714
203	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.539269	198	EXECUTED	8:28b4ec07bfbf4b86532fe9357effdb8b	dropForeignKeyConstraint baseTableName=metric, constraintName=fk_metric_ref_creator_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
13	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.076743	12	EXECUTED	8:c2c65930bad8d3e9bab3bb6ae562fe0c	createTable tableName=activity; createIndex indexName=idx_activity_timestamp, tableName=activity; createIndex indexName=idx_activity_user_id, tableName=activity; createIndex indexName=idx_activity_custom_id, tableName=activity		\N	3.6.3	\N	\N	4331435714
14	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.089615	13	EXECUTED	8:320d2ca8ead3f31309674b2b7f54f395	createTable tableName=view_log; createIndex indexName=idx_view_log_user_id, tableName=view_log; createIndex indexName=idx_view_log_timestamp, tableName=view_log		\N	3.6.3	\N	\N	4331435714
16	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.099048	15	EXECUTED	8:ecc7f02641a589e6d35f88587ac6e02b	dropNotNullConstraint columnName=last_login, tableName=core_user		\N	3.6.3	\N	\N	4331435714
17	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.104841	16	EXECUTED	8:051c23cd15359364b9895c1569c319e7	addColumn tableName=metabase_database; sql		\N	3.6.3	\N	\N	4331435714
18	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.115707	17	EXECUTED	8:62a0483dde183cfd18dd0a86e9354288	createTable tableName=data_migrations; createIndex indexName=idx_data_migrations_id, tableName=data_migrations		\N	3.6.3	\N	\N	4331435714
19	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.120011	18	EXECUTED	8:269b129dbfc39a6f9e0d3bc61c3c3b70	addColumn tableName=metabase_table		\N	3.6.3	\N	\N	4331435714
20	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.155929	19	EXECUTED	8:0afa34e8b528b83aa19b4142984f8095	createTable tableName=pulse; createIndex indexName=idx_pulse_creator_id, tableName=pulse; createTable tableName=pulse_card; createIndex indexName=idx_pulse_card_pulse_id, tableName=pulse_card; createIndex indexName=idx_pulse_card_card_id, tableNam...		\N	3.6.3	\N	\N	4331435714
21	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.171881	20	EXECUTED	8:fb2cd308b17ab81b502d057ecde4fc1b	createTable tableName=segment; createIndex indexName=idx_segment_creator_id, tableName=segment; createIndex indexName=idx_segment_table_id, tableName=segment		\N	3.6.3	\N	\N	4331435714
22	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.175977	21	EXECUTED	8:80bc8a62a90791a79adedcf1ac3c6f08	addColumn tableName=revision		\N	3.6.3	\N	\N	4331435714
23	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.187642	22	EXECUTED	8:b6f054835db2b2688a1be1de3707f9a9	modifyDataType columnName=rows, tableName=metabase_table		\N	3.6.3	\N	\N	4331435714
24	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.205498	23	EXECUTED	8:60825b125b452747098b577310c142b1	createTable tableName=dependency; createIndex indexName=idx_dependency_model, tableName=dependency; createIndex indexName=idx_dependency_model_id, tableName=dependency; createIndex indexName=idx_dependency_dependent_on_model, tableName=dependency;...		\N	3.6.3	\N	\N	4331435714
25	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.221435	24	EXECUTED	8:61f25563911117df72f5621d78f10089	createTable tableName=metric; createIndex indexName=idx_metric_creator_id, tableName=metric; createIndex indexName=idx_metric_table_id, tableName=metric		\N	3.6.3	\N	\N	4331435714
26	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.226304	25	EXECUTED	8:ddef40b95c55cf4ac0e6a5161911a4cb	addColumn tableName=metabase_database; sql		\N	3.6.3	\N	\N	4331435714
27	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.23863	26	EXECUTED	8:001855139df2d5dac4eb954e5abe6486	createTable tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_dashboardcard_id, tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_card_id, tableName=dashboardcard_series		\N	3.6.3	\N	\N	4331435714
28	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.243645	27	EXECUTED	8:428e4eb05e4e29141735adf9ae141a0b	addColumn tableName=core_user		\N	3.6.3	\N	\N	4331435714
29	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.247838	28	EXECUTED	8:8b02731cc34add3722c926dfd7376ae0	addColumn tableName=pulse_channel		\N	3.6.3	\N	\N	4331435714
30	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.253492	29	EXECUTED	8:2c3a50cef177cb90d47a9973cd5934e5	addColumn tableName=metabase_field; addNotNullConstraint columnName=visibility_type, tableName=metabase_field		\N	3.6.3	\N	\N	4331435714
31	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.257528	30	EXECUTED	8:30a33a82bab0bcbb2ccb6738d48e1421	addColumn tableName=metabase_field		\N	3.6.3	\N	\N	4331435714
57	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.665736	56	EXECUTED	8:aab81d477e2d19a9ab18c58b78c9af88	addColumn tableName=report_card	Added 0.25.0	\N	3.6.3	\N	\N	4331435714
32	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.283403	31	EXECUTED	8:40830260b92cedad8da273afd5eca678	createTable tableName=label; createIndex indexName=idx_label_slug, tableName=label; createTable tableName=card_label; addUniqueConstraint constraintName=unique_card_label_card_id_label_id, tableName=card_label; createIndex indexName=idx_card_label...		\N	3.6.3	\N	\N	4331435714
32	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.313997	32	EXECUTED	8:483c6c6c8e0a8d056f7b9112d0b0125c	createTable tableName=raw_table; createIndex indexName=idx_rawtable_database_id, tableName=raw_table; addUniqueConstraint constraintName=uniq_raw_table_db_schema_name, tableName=raw_table; createTable tableName=raw_column; createIndex indexName=id...		\N	3.6.3	\N	\N	4331435714
34	tlrobinson	migrations/000_migrations.yaml	2021-06-22 03:10:36.319248	33	EXECUTED	8:52b082600b05bbbc46bfe837d1f37a82	addColumn tableName=pulse_channel		\N	3.6.3	\N	\N	4331435714
35	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.323602	34	EXECUTED	8:91b72167fca724e6b6a94b64f886cf09	modifyDataType columnName=value, tableName=setting		\N	3.6.3	\N	\N	4331435714
36	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.333296	35	EXECUTED	8:252e08892449dceb16c3d91337bd9573	addColumn tableName=report_dashboard; addNotNullConstraint columnName=parameters, tableName=report_dashboard; addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=parameter_mappings, tableName=report_dashboardcard		\N	3.6.3	\N	\N	4331435714
37	tlrobinson	migrations/000_migrations.yaml	2021-06-22 03:10:36.345067	36	EXECUTED	8:07d959eff81777e5690e2920583cfe5f	addColumn tableName=query_queryexecution; addNotNullConstraint columnName=query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_queryexecution_query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_querye...		\N	3.6.3	\N	\N	4331435714
38	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.3831	37	EXECUTED	8:43604ab55179b50306eb39353e760b46	addColumn tableName=metabase_database; addColumn tableName=metabase_table; addColumn tableName=metabase_field; addColumn tableName=report_dashboard; addColumn tableName=metric; addColumn tableName=segment; addColumn tableName=metabase_database; ad...		\N	3.6.3	\N	\N	4331435714
11	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.04904	10	EXECUTED	8:ca6561cab1eedbcf4dcb6d6e22cd46c6	sql		\N	3.6.3	\N	\N	4331435714
39	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.387654	38	EXECUTED	8:334adc22af5ded71ff27759b7a556951	addColumn tableName=core_user		\N	3.6.3	\N	\N	4331435714
40	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.437337	39	EXECUTED	8:ee7f50a264d6cf8d891bd01241eebd2c	createTable tableName=permissions_group; createIndex indexName=idx_permissions_group_name, tableName=permissions_group; createTable tableName=permissions_group_membership; addUniqueConstraint constraintName=unique_permissions_group_membership_user...		\N	3.6.3	\N	\N	4331435714
41	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.445881	40	EXECUTED	8:fae0855adf2f702f1133e32fc98d02a5	dropColumn columnName=field_type, tableName=metabase_field; addDefaultValue columnName=active, tableName=metabase_field; addDefaultValue columnName=preview_display, tableName=metabase_field; addDefaultValue columnName=position, tableName=metabase_...		\N	3.6.3	\N	\N	4331435714
42	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.471585	41	EXECUTED	8:e32b3a1624fa289a6ee1f3f0a2dac1f6	dropForeignKeyConstraint baseTableName=query_queryexecution, constraintName=fk_queryexecution_ref_query_id; dropColumn columnName=query_id, tableName=query_queryexecution; dropColumn columnName=is_staff, tableName=core_user; dropColumn columnName=...		\N	3.6.3	\N	\N	4331435714
43	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.486196	42	EXECUTED	8:165e9384e46d6f9c0330784955363f70	createTable tableName=permissions_revision		\N	3.6.3	\N	\N	4331435714
44	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.492601	43	EXECUTED	8:2e356e8a1049286f1c78324828ee7867	dropColumn columnName=public_perms, tableName=report_card; dropColumn columnName=public_perms, tableName=report_dashboard; dropColumn columnName=public_perms, tableName=pulse		\N	3.6.3	\N	\N	4331435714
45	tlrobinson	migrations/000_migrations.yaml	2021-06-22 03:10:36.501227	44	EXECUTED	8:421edd38ee0cb0983162f57193f81b0b	addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=visualization_settings, tableName=report_dashboardcard		\N	3.6.3	\N	\N	4331435714
46	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.510557	45	EXECUTED	8:131df3cdd9a8c67b32c5988a3fb7fe3d	addNotNullConstraint columnName=row, tableName=report_dashboardcard; addNotNullConstraint columnName=col, tableName=report_dashboardcard; addDefaultValue columnName=row, tableName=report_dashboardcard; addDefaultValue columnName=col, tableName=rep...		\N	3.6.3	\N	\N	4331435714
47	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.53371	46	EXECUTED	8:1d2474e49a27db344c250872df58a6ed	createTable tableName=collection; createIndex indexName=idx_collection_slug, tableName=collection; addColumn tableName=report_card; createIndex indexName=idx_card_collection_id, tableName=report_card		\N	3.6.3	\N	\N	4331435714
48	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.547176	47	EXECUTED	8:720ce9d4b9e6f0917aea035e9dc5d95d	createTable tableName=collection_revision		\N	3.6.3	\N	\N	4331435714
49	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.569717	48	EXECUTED	8:4508e7d5f6d4da3c4a2de3bf5e3c5851	addColumn tableName=report_card; addColumn tableName=report_card; createIndex indexName=idx_card_public_uuid, tableName=report_card; addColumn tableName=report_dashboard; addColumn tableName=report_dashboard; createIndex indexName=idx_dashboard_pu...		\N	3.6.3	\N	\N	4331435714
50	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.579036	49	EXECUTED	8:98a6ab6428ea7a589507464e34ade58a	addColumn tableName=report_card; addColumn tableName=report_card; addColumn tableName=report_dashboard; addColumn tableName=report_dashboard		\N	3.6.3	\N	\N	4331435714
51	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.602927	50	EXECUTED	8:43c90b5b9f6c14bfd0e41cc0b184617e	createTable tableName=query_execution; createIndex indexName=idx_query_execution_started_at, tableName=query_execution; createIndex indexName=idx_query_execution_query_hash_started_at, tableName=query_execution		\N	3.6.3	\N	\N	4331435714
52	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.618818	51	EXECUTED	8:5af9ea2a96cd6e75a8ac1e6afde7126b	createTable tableName=query_cache; createIndex indexName=idx_query_cache_updated_at, tableName=query_cache; addColumn tableName=report_card		\N	3.6.3	\N	\N	4331435714
53	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.628929	52	EXECUTED	8:78d015c5090c57cd6972eb435601d3d0	createTable tableName=query		\N	3.6.3	\N	\N	4331435714
54	tlrobinson	migrations/000_migrations.yaml	2021-06-22 03:10:36.633759	53	EXECUTED	8:e410005b585f5eeb5f202076ff9468f7	addColumn tableName=pulse		\N	3.6.3	\N	\N	4331435714
55	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.655736	54	EXECUTED	8:11bbd199bfa57b908ea3b1a470197de9	addColumn tableName=report_dashboard; addColumn tableName=report_dashboard; createTable tableName=dashboard_favorite; addUniqueConstraint constraintName=unique_dashboard_favorite_user_id_dashboard_id, tableName=dashboard_favorite; createIndex inde...		\N	3.6.3	\N	\N	4331435714
56	wwwiiilll	migrations/000_migrations.yaml	2021-06-22 03:10:36.660448	55	EXECUTED	8:9f46051abaee599e2838733512a32ad0	addColumn tableName=core_user	Added 0.25.0	\N	3.6.3	\N	\N	4331435714
58	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.685353	57	EXECUTED	8:3554219ca39e0fd682d0fba57531e917	createTable tableName=dimension; addUniqueConstraint constraintName=unique_dimension_field_id_name, tableName=dimension; createIndex indexName=idx_dimension_field_id, tableName=dimension	Added 0.25.0	\N	3.6.3	\N	\N	4331435714
59	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.691062	58	EXECUTED	8:5b6ce52371e0e9eee88e6d766225a94b	addColumn tableName=metabase_field	Added 0.26.0	\N	3.6.3	\N	\N	4331435714
60	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.69697	59	EXECUTED	8:2141162a1c99a5dd95e5a67c5595e6d7	addColumn tableName=metabase_database; addColumn tableName=metabase_database	Added 0.26.0	\N	3.6.3	\N	\N	4331435714
61	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.703623	60	EXECUTED	8:7dded6fd5bf74d79b9a0b62511981272	addColumn tableName=metabase_field	Added 0.26.0	\N	3.6.3	\N	\N	4331435714
62	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.708517	61	EXECUTED	8:cb32e6eaa1a2140703def2730f81fef2	addColumn tableName=metabase_database	Added 0.26.0	\N	3.6.3	\N	\N	4331435714
63	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.714212	62	EXECUTED	8:226f73b9f6617495892d281b0f8303db	addColumn tableName=metabase_database	Added 0.26.0	\N	3.6.3	\N	\N	4331435714
64	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.71987	63	EXECUTED	8:4dcc8ffd836b56756f494d5dfce07b50	dropForeignKeyConstraint baseTableName=raw_table, constraintName=fk_rawtable_ref_database	Added 0.26.0	\N	3.6.3	\N	\N	4331435714
66	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.732197	64	EXECUTED	8:e77d66af8e3b83d46c5a0064a75a1aac	sql; sql	Added 0.26.0	\N	3.6.3	\N	\N	4331435714
67	attekei	migrations/000_migrations.yaml	2021-06-22 03:10:36.750995	65	EXECUTED	8:59dfc37744fc362e0e312488fbc9a69b	createTable tableName=computation_job; createTable tableName=computation_job_result	Added 0.27.0	\N	3.6.3	\N	\N	4331435714
68	sbelak	migrations/000_migrations.yaml	2021-06-22 03:10:36.757071	66	EXECUTED	8:b4ac06d133dfbdc6567d992c7e18c6ec	addColumn tableName=computation_job; addColumn tableName=computation_job	Added 0.27.0	\N	3.6.3	\N	\N	4331435714
69	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.770814	67	EXECUTED	8:eadbe00e97eb53df4b3df60462f593f6	addColumn tableName=pulse; addColumn tableName=pulse; addColumn tableName=pulse; dropNotNullConstraint columnName=name, tableName=pulse	Added 0.27.0	\N	3.6.3	\N	\N	4331435714
70	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.778083	68	EXECUTED	8:4e4eff7abb983b1127a32ba8107e7fb8	addColumn tableName=metabase_field; addNotNullConstraint columnName=database_type, tableName=metabase_field	Added 0.28.0	\N	3.6.3	\N	\N	4331435714
71	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.783557	69	EXECUTED	8:755e5c3dd8a55793f29b2c95cb79c211	dropNotNullConstraint columnName=card_id, tableName=report_dashboardcard	Added 0.28.0	\N	3.6.3	\N	\N	4331435714
72	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.790586	70	EXECUTED	8:4dc6debdf779ab9273cf2158a84bb154	addColumn tableName=pulse_card; addColumn tableName=pulse_card	Added 0.28.0	\N	3.6.3	\N	\N	4331435714
73	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.795739	71	EXECUTED	8:3c0f03d18ff78a0bcc9915e1d9c518d6	addColumn tableName=metabase_database	Added 0.29.0	\N	3.6.3	\N	\N	4331435714
74	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.802524	72	EXECUTED	8:16726d6560851325930c25caf3c8ab96	addColumn tableName=metabase_field	Added 0.29.0	\N	3.6.3	\N	\N	4331435714
75	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.80835	73	EXECUTED	8:6072cabfe8188872d8e3da9a675f88c1	addColumn tableName=report_card	Added 0.28.2	\N	3.6.3	\N	\N	4331435714
76	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.813929	74	EXECUTED	8:9b7190c9171ccca72617d508875c3c82	addColumn tableName=metabase_table	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
77	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.819471	75	EXECUTED	8:07f0a6cd8dbbd9b89be0bd7378f7bdc8	addColumn tableName=core_user	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
78	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.842193	76	EXECUTED	8:1977d7278269cdd0dc4f941f9e82f548	createTable tableName=group_table_access_policy; createIndex indexName=idx_gtap_table_id_group_id, tableName=group_table_access_policy; addUniqueConstraint constraintName=unique_gtap_table_id_group_id, tableName=group_table_access_policy	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
79	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.861482	77	EXECUTED	8:3f31cb67f9cdf7754ca95cade22d87a2	addColumn tableName=report_dashboard; createIndex indexName=idx_dashboard_collection_id, tableName=report_dashboard; addColumn tableName=pulse; createIndex indexName=idx_pulse_collection_id, tableName=pulse	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
114	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.185109	110	MARK_RAN	8:7a0bcb25ece6d9a311d6c6be7ed89bb7	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
80	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.870811	78	EXECUTED	8:199d0ce28955117819ca15bcc29323e5	addColumn tableName=collection; createIndex indexName=idx_collection_location, tableName=collection		\N	3.6.3	\N	\N	4331435714
81	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.878747	79	EXECUTED	8:3a6dc22403660529194d004ca7f7ad39	addColumn tableName=report_dashboard; addColumn tableName=report_card; addColumn tableName=pulse	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
82	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.885265	80	EXECUTED	8:ac4b94df8c648f88cfff661284d6392d	addColumn tableName=core_user; sql	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
83	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.889243	81	EXECUTED	8:ccd897d737737c05248293c7d56efe96	dropNotNullConstraint columnName=card_id, tableName=group_table_access_policy	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
84	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.899849	82	EXECUTED	8:58afc10c3e283a8050ea471aac447a97	renameColumn newColumnName=archived, oldColumnName=is_active, tableName=metric; addDefaultValue columnName=archived, tableName=metric; renameColumn newColumnName=archived, oldColumnName=is_active, tableName=segment; addDefaultValue columnName=arch...	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
85	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.917404	83	EXECUTED	8:9b4c9878a5018452dd63eb6d7c17f415	addColumn tableName=collection; createIndex indexName=idx_collection_personal_owner_id, tableName=collection; addColumn tableName=collection; sql; addNotNullConstraint columnName=_slug, tableName=collection; dropColumn columnName=slug, tableName=c...	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
86	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.921859	84	EXECUTED	8:50c75bb29f479e0b3fb782d89f7d6717	sql	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
87	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.928589	85	EXECUTED	8:0eccf19a93cb0ba4017aafd1d308c097	dropTable tableName=raw_column; dropTable tableName=raw_table	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
88	senior	migrations/000_migrations.yaml	2021-06-22 03:10:36.933236	86	EXECUTED	8:04ff5a0738473938fc31d68c1d9952e1	addColumn tableName=core_user	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
129	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.233864	125	MARK_RAN	8:f890168c47cc2113a8af77ed3875c4b3	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
130	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.236718	126	MARK_RAN	8:ecdcf1fd66b3477e5b6882c3286b2fd8	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
89	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.062797	87	EXECUTED	8:94d5c406e3ec44e2bc85abe96f6fd91c	createTable tableName=QRTZ_JOB_DETAILS; addPrimaryKey constraintName=PK_QRTZ_JOB_DETAILS, tableName=QRTZ_JOB_DETAILS; createTable tableName=QRTZ_TRIGGERS; addPrimaryKey constraintName=PK_QRTZ_TRIGGERS, tableName=QRTZ_TRIGGERS; addForeignKeyConstra...	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
90	senior	migrations/000_migrations.yaml	2021-06-22 03:10:37.072752	88	EXECUTED	8:8562a72a1190deadc5fa59a23a6396dc	addColumn tableName=core_user; sql; dropColumn columnName=saml_auth, tableName=core_user	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
91	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.076798	89	EXECUTED	8:9b8831e1e409f08e874c4ece043d0340	dropColumn columnName=raw_table_id, tableName=metabase_table; dropColumn columnName=raw_column_id, tableName=metabase_field	Added 0.30.0	\N	3.6.3	\N	\N	4331435714
92	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.080686	90	EXECUTED	8:1e5bc2d66778316ea640a561862c23b4	addColumn tableName=query_execution	Added 0.31.0	\N	3.6.3	\N	\N	4331435714
93	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.084659	91	EXECUTED	8:93b0d408a3970e30d7184ed1166b5476	addColumn tableName=query	Added 0.31.0	\N	3.6.3	\N	\N	4331435714
94	senior	migrations/000_migrations.yaml	2021-06-22 03:10:37.098056	92	EXECUTED	8:a2a1eedf1e8f8756856c9d49c7684bfe	createTable tableName=task_history; createIndex indexName=idx_task_history_end_time, tableName=task_history; createIndex indexName=idx_task_history_db_id, tableName=task_history	Added 0.31.0	\N	3.6.3	\N	\N	4331435714
95	senior	migrations/000_migrations.yaml	2021-06-22 03:10:37.105737	93	EXECUTED	8:9824808283004e803003b938399a4cf0	addUniqueConstraint constraintName=idx_databasechangelog_id_author_filename, tableName=DATABASECHANGELOG	Added 0.31.0	\N	3.6.3	\N	\N	4331435714
96	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.110787	94	EXECUTED	8:5cb2f36edcca9c6e14c5e109d6aeb68b	addColumn tableName=metabase_field	Added 0.31.0	\N	3.6.3	\N	\N	4331435714
97	senior	migrations/000_migrations.yaml	2021-06-22 03:10:37.113713	95	MARK_RAN	8:9169e238663c5d036bd83428d2fa8e4b	modifyDataType columnName=results, tableName=query_cache	Added 0.32.0	\N	3.6.3	\N	\N	4331435714
98	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.12411	96	EXECUTED	8:f036d20a4dc86fb60ffb64ea838ed6b9	addUniqueConstraint constraintName=idx_uniq_table_db_id_schema_name, tableName=metabase_table; sql	Added 0.32.0	\N	3.6.3	\N	\N	4331435714
99	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.133898	97	EXECUTED	8:274bb516dd95b76c954b26084eed1dfe	addUniqueConstraint constraintName=idx_uniq_field_table_id_parent_id_name, tableName=metabase_field; sql	Added 0.32.0	\N	3.6.3	\N	\N	4331435714
100	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.13953	98	EXECUTED	8:948014f13b6198b50e3b7a066fae2ae0	sql	Added 0.32.0	\N	3.6.3	\N	\N	4331435714
101	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.14453	99	EXECUTED	8:58eabb08a175fafe8985208545374675	createIndex indexName=idx_field_parent_id, tableName=metabase_field	Added 0.32.0	\N	3.6.3	\N	\N	4331435714
103	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.148678	100	EXECUTED	8:fda3670fd16a40fd9d0f89a003098d54	addColumn tableName=metabase_database	Added 0.32.10	\N	3.6.3	\N	\N	4331435714
104	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.157742	101	EXECUTED	8:21709f17e6d1b521d3d3b8cbb5445218	addColumn tableName=core_session	Added EE 1.1.6/CE 0.33.0	\N	3.6.3	\N	\N	4331435714
106	sb	migrations/000_migrations.yaml	2021-06-22 03:10:37.16295	102	EXECUTED	8:a3dd42bbe25c415ce21e4c180dc1c1d7	modifyDataType columnName=database_type, tableName=metabase_field	Added 0.33.5	\N	3.6.3	\N	\N	4331435714
107	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.165388	103	MARK_RAN	8:605c2b4d212315c83727aa3d914cf57f	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
108	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.168058	104	MARK_RAN	8:d11419da9384fd27d7b1670707ac864c	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
109	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.171143	105	MARK_RAN	8:a5f4ea412eb1d5c1bc824046ad11692f	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
110	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.174196	106	MARK_RAN	8:82343097044b9652f73f3d3a2ddd04fe	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
111	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.17735	107	MARK_RAN	8:528de1245ba3aa106871d3e5b3eee0ba	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
112	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.180034	108	MARK_RAN	8:010a3931299429d1adfa91941c806ea4	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
116	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.191267	112	MARK_RAN	8:dbf7c3a1d8b1eb77b7f5888126b13c2e	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
117	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.193619	113	MARK_RAN	8:f2d7f9fb1b6713bc5362fe40bfe3f91f	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
118	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.196089	114	MARK_RAN	8:17f4410e30a0c7e84a36517ebf4dab64	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
119	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.19881	115	MARK_RAN	8:195cf171ac1d5531e455baf44d9d6561	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
120	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.206129	116	MARK_RAN	8:61f53fac337020aec71868656a719bba	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
121	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.208781	117	MARK_RAN	8:1baa145d2ffe1e18d097a63a95476c5f	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
122	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.211436	118	MARK_RAN	8:929b3c551a8f631cdce2511612d82d62	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
123	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.214249	119	MARK_RAN	8:35e5baddf78df5829fe6889d216436e5	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
124	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.217542	120	MARK_RAN	8:ce2322ca187dfac51be8f12f6a132818	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
125	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.220733	121	MARK_RAN	8:dd948ac004ceb9d0a300a8e06806945f	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
126	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.224274	122	MARK_RAN	8:3d34c0d4e5dbb32b432b83d5322e2aa3	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
127	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.228542	123	MARK_RAN	8:18314b269fe11898a433ca9048400975	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
128	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.231105	124	MARK_RAN	8:44acbe257817286d88b7892e79363b66	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
131	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.239553	127	MARK_RAN	8:453af2935194978c65b19eae445d85c9	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
132	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.242513	128	MARK_RAN	8:d2c37bc80b42a15b65f148bcb1daa86e	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
133	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.245345	129	MARK_RAN	8:5b9b539d146fbdb762577dc98e7f3430	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
134	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.248055	130	MARK_RAN	8:4d0f688a168db3e357a808263b6ad355	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
135	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.251278	131	MARK_RAN	8:2ca54b0828c6aca615fb42064f1ec728	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
136	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.253574	132	MARK_RAN	8:7115eebbcf664509b9fc0c39cb6f29e9	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
137	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.256278	133	MARK_RAN	8:da754ac6e51313a32de6f6389b29e1ca	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
138	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.258559	134	MARK_RAN	8:bfb201761052189e96538f0de3ac76cf	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
139	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.261349	135	MARK_RAN	8:fdad4ec86aefb0cdf850b1929b618508	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
140	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.26353	136	MARK_RAN	8:a0cfe6468160bba8c9d602da736c41fb	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
141	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.265957	137	MARK_RAN	8:b6b7faa02cba069e1ed13e365f59cb6b	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
142	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.268924	138	MARK_RAN	8:0c291eb50cc0f1fef3d55cfe6b62bedb	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
143	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.272453	139	MARK_RAN	8:3d9a5cb41f77a33e834d0562fdddeab6	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
144	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.274859	140	MARK_RAN	8:1d5b7f79f97906105e90d330a17c4062	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
145	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.277547	141	MARK_RAN	8:b162dd48ef850ab4300e2d714eac504e	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
146	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.280014	142	MARK_RAN	8:8c0c1861582d15fe7859358f5d553c91	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
147	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.282409	143	MARK_RAN	8:5ccf590332ea0744414e40a990a43275	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
148	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.28546	144	MARK_RAN	8:12b42e87d40cd7b6399c1fb0c6704fa7	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
149	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.28831	145	MARK_RAN	8:dd45bfc4af5e05701a064a5f2a046d7f	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
150	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.291581	146	MARK_RAN	8:48beda94aeaa494f798c38a66b90fb2a	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
151	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.294138	147	MARK_RAN	8:bb752a7d09d437c7ac294d5ab2600079	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
152	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.296683	148	MARK_RAN	8:4bcbc472f2d6ae3a5e7eca425940e52b	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
153	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.2993	149	MARK_RAN	8:adce2cca96fe0531b00f9bed6bed8352	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
154	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.301811	150	MARK_RAN	8:7a1df4f7a679f47459ea1a1c0991cfba	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
155	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.304954	151	MARK_RAN	8:3c78b79c784e3a3ce09a77db1b1d0374	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
156	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.308461	152	MARK_RAN	8:51859ee6cca4aca9d141a3350eb5d6b1	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
157	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.311443	153	MARK_RAN	8:0197c46bf8536a75dbf7e9aee731f3b2	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
158	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.314484	154	MARK_RAN	8:2ebdd5a179ce2487b2e23b6be74a407c	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
159	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.32038	155	MARK_RAN	8:c62719dad239c51f045315273b56e2a9	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
160	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.323864	156	MARK_RAN	8:1441c71af662abb809cba3b3b360ce81	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
162	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.337166	157	EXECUTED	8:c37f015ad11d77d66e09925eed605cdf	dropTable tableName=query_queryexecution	Added 0.23.0 as a data migration; converted to Liquibase migration in 0.35.0	\N	3.6.3	\N	\N	4331435714
163	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.340844	158	EXECUTED	8:9ef66a82624d70738fc89807a2398ed1	dropColumn columnName=read_permissions, tableName=report_card	Added 0.35.0	\N	3.6.3	\N	\N	4331435714
164	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.346409	159	EXECUTED	8:f19470701bbb33f19f91b1199a915881	addColumn tableName=core_user	Added 0.35.0	\N	3.6.3	\N	\N	4331435714
165	sb	migrations/000_migrations.yaml	2021-06-22 03:10:37.35319	160	EXECUTED	8:b3ae2b90db5c4264ea2ac50d304d6ad4	addColumn tableName=metabase_field; addColumn tableName=metabase_field; addColumn tableName=metabase_table; sql	Added field_order to Table and database_position to Field	\N	3.6.3	\N	\N	4331435714
166	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.361334	161	EXECUTED	8:92dafa5c15c46e2af8380304449c7dfa	modifyDataType columnName=updated_at, tableName=metabase_fieldvalues; modifyDataType columnName=updated_at, tableName=query_cache	Added 0.36.0/1.35.4	\N	3.6.3	\N	\N	4331435714
167	walterl, camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.375985	162	EXECUTED	8:4c11dc8c5e829b5263c198fe7879f161	sql; createTable tableName=native_query_snippet; createIndex indexName=idx_snippet_name, tableName=native_query_snippet	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
168	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.384126	163	EXECUTED	8:6d40bfa472bccd2d54284aeb89e1ec3c	modifyDataType columnName=started_at, tableName=query_execution	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
169	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.38798	164	EXECUTED	8:2b97e6eaa7854e179abb9f3749f73b18	dropColumn columnName=rows, tableName=metabase_table	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
170	sb	migrations/000_migrations.yaml	2021-06-22 03:10:37.391699	165	EXECUTED	8:dbd6ee52b0f9195e449a6d744606b599	dropColumn columnName=fields_hash, tableName=metabase_table	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
171	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.399364	166	EXECUTED	8:0798080c0796e6ab3e791bff007118b8	addColumn tableName=native_query_snippet; createIndex indexName=idx_snippet_collection_id, tableName=native_query_snippet	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
172	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.403981	167	EXECUTED	8:212f4010b504e358853fd017032f844f	addColumn tableName=collection	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
173	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.408692	168	EXECUTED	8:4d32b4b7be3f4801e51aeffa5dd47649	dropForeignKeyConstraint baseTableName=activity, constraintName=fk_activity_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
174	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.413678	169	EXECUTED	8:66f31503ba532702e54ea531af668531	addForeignKeyConstraint baseTableName=activity, constraintName=fk_activity_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
175	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.418663	170	EXECUTED	8:c3ceddfca8827d73474cd9a70ea01d1c	dropForeignKeyConstraint baseTableName=card_label, constraintName=fk_card_label_ref_card_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
176	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.423431	171	EXECUTED	8:89c918faa84b7f3f5fa291d4da74414c	addForeignKeyConstraint baseTableName=card_label, constraintName=fk_card_label_ref_card_id, referencedTableName=report_card	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
177	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.427652	172	EXECUTED	8:d45f2198befc83de1f1f963c750607af	dropForeignKeyConstraint baseTableName=card_label, constraintName=fk_card_label_ref_label_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
178	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.432587	173	EXECUTED	8:63d396999449da2d42b3d3e22f3454fa	addForeignKeyConstraint baseTableName=card_label, constraintName=fk_card_label_ref_label_id, referencedTableName=label	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
179	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.436701	174	EXECUTED	8:2a0a7956402ef074e5d54c73ac2d5405	dropForeignKeyConstraint baseTableName=collection, constraintName=fk_collection_personal_owner_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
180	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.441122	175	EXECUTED	8:b02225e5940a2bcca3d550f24f80123e	addForeignKeyConstraint baseTableName=collection, constraintName=fk_collection_personal_owner_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
181	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.445084	176	EXECUTED	8:16923f06b2bbb60c6ac78a0c4b7e4d4f	dropForeignKeyConstraint baseTableName=collection_revision, constraintName=fk_collection_revision_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
182	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.449188	177	EXECUTED	8:d59d864c038c530a49056704c93f231d	addForeignKeyConstraint baseTableName=collection_revision, constraintName=fk_collection_revision_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
183	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.452706	178	EXECUTED	8:c5ed9a4f44ee92af620a47c80e010a6b	dropForeignKeyConstraint baseTableName=computation_job, constraintName=fk_computation_job_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
184	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.45677	179	EXECUTED	8:70317e2bdaac90b9ddc33b1b93ada479	addForeignKeyConstraint baseTableName=computation_job, constraintName=fk_computation_job_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
185	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.460821	180	EXECUTED	8:12e7457ec2d2b1a99a3fadfc64d7b7f9	dropForeignKeyConstraint baseTableName=computation_job_result, constraintName=fk_computation_result_ref_job_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
186	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.464835	181	EXECUTED	8:526987d0f6b2f01d7bfc9e3179721be6	addForeignKeyConstraint baseTableName=computation_job_result, constraintName=fk_computation_result_ref_job_id, referencedTableName=computation_job	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
187	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.468809	182	EXECUTED	8:3fbb75c0c491dc6628583184202b8f39	dropForeignKeyConstraint baseTableName=core_session, constraintName=fk_session_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
188	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.473304	183	EXECUTED	8:4dc500830cd4c5715ca8b0956e37b3d5	addForeignKeyConstraint baseTableName=core_session, constraintName=fk_session_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
189	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.478331	184	EXECUTED	8:e07396e0ee587dcf321d21cffa9eec29	dropForeignKeyConstraint baseTableName=dashboardcard_series, constraintName=fk_dashboardcard_series_ref_card_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
190	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.482329	185	EXECUTED	8:eded791094a16bf398896c790645c411	addForeignKeyConstraint baseTableName=dashboardcard_series, constraintName=fk_dashboardcard_series_ref_card_id, referencedTableName=report_card	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
191	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.486074	186	EXECUTED	8:bb5b9a3d64b2e44318e159e7f1fecde2	dropForeignKeyConstraint baseTableName=dashboardcard_series, constraintName=fk_dashboardcard_series_ref_dashboardcard_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
192	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.490166	187	EXECUTED	8:7d96911036dec2fee64fe8ae57c131b3	addForeignKeyConstraint baseTableName=dashboardcard_series, constraintName=fk_dashboardcard_series_ref_dashboardcard_id, referencedTableName=report_dashboardcard	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
193	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.49489	188	EXECUTED	8:db171179fe094db9fee7e2e7df60fa4e	dropForeignKeyConstraint baseTableName=group_table_access_policy, constraintName=fk_gtap_card_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
194	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.499134	189	EXECUTED	8:fccb724d7ae7606e2e7638de1791392a	addForeignKeyConstraint baseTableName=group_table_access_policy, constraintName=fk_gtap_card_id, referencedTableName=report_card	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
195	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.502929	190	EXECUTED	8:1d720af9f917007024c91d40410bc91d	dropForeignKeyConstraint baseTableName=metabase_field, constraintName=fk_field_parent_ref_field_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
196	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.50713	191	EXECUTED	8:c52f5dbf742feef12a3803bda92a425b	addForeignKeyConstraint baseTableName=metabase_field, constraintName=fk_field_parent_ref_field_id, referencedTableName=metabase_field	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
197	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.511401	192	EXECUTED	8:9c1c950b709050abe91cea17fd5970cc	dropForeignKeyConstraint baseTableName=metabase_field, constraintName=fk_field_ref_table_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
198	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.515955	193	EXECUTED	8:e24198ff4825a41d17ceaebd71692103	addForeignKeyConstraint baseTableName=metabase_field, constraintName=fk_field_ref_table_id, referencedTableName=metabase_table	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
199	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.520338	194	EXECUTED	8:146efae3f2938538961835fe07433ee1	dropForeignKeyConstraint baseTableName=metabase_fieldvalues, constraintName=fk_fieldvalues_ref_field_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
200	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.525837	195	EXECUTED	8:f5e7e79cb81b8d2245663c482746c853	addForeignKeyConstraint baseTableName=metabase_fieldvalues, constraintName=fk_fieldvalues_ref_field_id, referencedTableName=metabase_field	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
201	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.530635	196	EXECUTED	8:2d79321a27fde6cb3c4fabdb86dc60ec	dropForeignKeyConstraint baseTableName=metabase_table, constraintName=fk_table_ref_database_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
202	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.53503	197	EXECUTED	8:d0cefed061c4abbf2b0a0fd2a66817cb	addForeignKeyConstraint baseTableName=metabase_table, constraintName=fk_table_ref_database_id, referencedTableName=metabase_database	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
204	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.545567	199	EXECUTED	8:7195937fd2144533edfa2302ba2ae653	addForeignKeyConstraint baseTableName=metric, constraintName=fk_metric_ref_creator_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
205	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.549848	200	EXECUTED	8:4b2d5f1458641dd1b9dbc5f41600be8e	dropForeignKeyConstraint baseTableName=metric, constraintName=fk_metric_ref_table_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
206	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.555216	201	EXECUTED	8:959ef448c23aaf3acf5b69f297fe4b2f	addForeignKeyConstraint baseTableName=metric, constraintName=fk_metric_ref_table_id, referencedTableName=metabase_table	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
207	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.561302	202	EXECUTED	8:18135d674f2fe502313adb0475f5f139	dropForeignKeyConstraint baseTableName=metric_important_field, constraintName=fk_metric_important_field_metabase_field_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
208	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.567689	203	EXECUTED	8:4c86c17a00a81dfdf35a181e3dd3b08f	addForeignKeyConstraint baseTableName=metric_important_field, constraintName=fk_metric_important_field_metabase_field_id, referencedTableName=metabase_field	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
209	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.571723	204	EXECUTED	8:1b9c3544bf89093fc9e4f7f191fdc6df	dropForeignKeyConstraint baseTableName=metric_important_field, constraintName=fk_metric_important_field_metric_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
210	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.576468	205	EXECUTED	8:842d166cdf7b0a29c88efdaf95c9d0bf	addForeignKeyConstraint baseTableName=metric_important_field, constraintName=fk_metric_important_field_metric_id, referencedTableName=metric	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
211	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.580387	206	EXECUTED	8:91c64815a1aefb07dd124d493bfeeea9	dropForeignKeyConstraint baseTableName=native_query_snippet, constraintName=fk_snippet_collection_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
212	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.584831	207	EXECUTED	8:b25064ee26b71f61906a833bc22ebbc2	addForeignKeyConstraint baseTableName=native_query_snippet, constraintName=fk_snippet_collection_id, referencedTableName=collection	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
213	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.588604	208	EXECUTED	8:60a7d628e4f68ee4c85f5f298b1d9865	dropForeignKeyConstraint baseTableName=permissions, constraintName=fk_permissions_group_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
214	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.592896	209	EXECUTED	8:1c3c480313967a2d9f324a094ba25f4d	addForeignKeyConstraint baseTableName=permissions, constraintName=fk_permissions_group_id, referencedTableName=permissions_group	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
215	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.596799	210	EXECUTED	8:5d2c67ccead52970e9d85beb7eda48b9	dropForeignKeyConstraint baseTableName=permissions_group_membership, constraintName=fk_permissions_group_group_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
216	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.601276	211	EXECUTED	8:35fcd5d48600e887188eb1b990e6cc35	addForeignKeyConstraint baseTableName=permissions_group_membership, constraintName=fk_permissions_group_group_id, referencedTableName=permissions_group	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
217	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.605449	212	EXECUTED	8:da7460a35a724109ae9b5096cd18666b	dropForeignKeyConstraint baseTableName=permissions_group_membership, constraintName=fk_permissions_group_membership_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
218	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.610265	213	EXECUTED	8:dc04b7eb04cd870c53102cb37fd75a5f	addForeignKeyConstraint baseTableName=permissions_group_membership, constraintName=fk_permissions_group_membership_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
219	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.619822	214	EXECUTED	8:02c690f34fe8803e42441f5037d33017	dropForeignKeyConstraint baseTableName=permissions_revision, constraintName=fk_permissions_revision_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
220	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.624699	215	EXECUTED	8:8b8447405d7b2b52358c9676d64b7651	addForeignKeyConstraint baseTableName=permissions_revision, constraintName=fk_permissions_revision_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
221	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.629182	216	EXECUTED	8:54a4c0d8a4eda80dc81fb549a629d075	dropForeignKeyConstraint baseTableName=pulse, constraintName=fk_pulse_collection_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
222	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.634479	217	EXECUTED	8:c5f22e925be3a8fd0e4f47a491f599ee	addForeignKeyConstraint baseTableName=pulse, constraintName=fk_pulse_collection_id, referencedTableName=collection	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
223	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.638776	218	EXECUTED	8:de743e384ff90a6a31a3caebe0abb775	dropForeignKeyConstraint baseTableName=pulse, constraintName=fk_pulse_ref_creator_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
224	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.644185	219	EXECUTED	8:b8fdf9c14d7ea3131a0a6b1f1036f91a	addForeignKeyConstraint baseTableName=pulse, constraintName=fk_pulse_ref_creator_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
225	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.648592	220	EXECUTED	8:495a4e12cf75cac5ff54738772e6a998	dropForeignKeyConstraint baseTableName=pulse_card, constraintName=fk_pulse_card_ref_card_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
226	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.654112	221	EXECUTED	8:cf383d74bc407065c78c060203ba4560	addForeignKeyConstraint baseTableName=pulse_card, constraintName=fk_pulse_card_ref_card_id, referencedTableName=report_card	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
227	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.659698	222	EXECUTED	8:e23eaf74ab7edacfb34bd5caf05cf66f	dropForeignKeyConstraint baseTableName=pulse_card, constraintName=fk_pulse_card_ref_pulse_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
228	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.665257	223	EXECUTED	8:d458ddb160f61e93bb69738f262de2b4	addForeignKeyConstraint baseTableName=pulse_card, constraintName=fk_pulse_card_ref_pulse_id, referencedTableName=pulse	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
229	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.669861	224	EXECUTED	8:1cb939d172989cb1629e9a3da768596d	dropForeignKeyConstraint baseTableName=pulse_channel, constraintName=fk_pulse_channel_ref_pulse_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
230	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.675844	225	EXECUTED	8:62baea3334ac5f21feac84497f6bf643	addForeignKeyConstraint baseTableName=pulse_channel, constraintName=fk_pulse_channel_ref_pulse_id, referencedTableName=pulse	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
231	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.680776	226	EXECUTED	8:d096a9ce70fc0b7dfbc67ee1be4c3e31	dropForeignKeyConstraint baseTableName=pulse_channel_recipient, constraintName=fk_pulse_channel_recipient_ref_pulse_channel_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
232	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.685743	227	EXECUTED	8:be2457ae1e386c9d5ec5bfa4ae681fd6	addForeignKeyConstraint baseTableName=pulse_channel_recipient, constraintName=fk_pulse_channel_recipient_ref_pulse_channel_id, referencedTableName=pulse_channel	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
233	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.694459	228	EXECUTED	8:d5c018882af16093de446e025e2599b7	dropForeignKeyConstraint baseTableName=pulse_channel_recipient, constraintName=fk_pulse_channel_recipient_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
234	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.699111	229	EXECUTED	8:edb6ced6c353064c46fa00b54e187aef	addForeignKeyConstraint baseTableName=pulse_channel_recipient, constraintName=fk_pulse_channel_recipient_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
235	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.703151	230	EXECUTED	8:550c64e41e55233d52ac3ef24d664be1	dropForeignKeyConstraint baseTableName=report_card, constraintName=fk_card_collection_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
236	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.708337	231	EXECUTED	8:04300b298b663fc2a2f3a324d1051c3c	addForeignKeyConstraint baseTableName=report_card, constraintName=fk_card_collection_id, referencedTableName=collection	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
237	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.71269	232	EXECUTED	8:227a9133cdff9f1b60d8af53688ab12e	dropForeignKeyConstraint baseTableName=report_card, constraintName=fk_card_made_public_by_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
238	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.716952	233	EXECUTED	8:7000766ddca2c914ac517611e7d86549	addForeignKeyConstraint baseTableName=report_card, constraintName=fk_card_made_public_by_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
239	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.721164	234	EXECUTED	8:672f4972653f70464982008a7abea3e1	dropForeignKeyConstraint baseTableName=report_card, constraintName=fk_card_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
240	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.726027	235	EXECUTED	8:165b07c8ceb004097c83ee1b689164e4	addForeignKeyConstraint baseTableName=report_card, constraintName=fk_card_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
241	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.735129	236	EXECUTED	8:b0a9e3d801e64e0a66c3190e458c01ae	dropForeignKeyConstraint baseTableName=report_card, constraintName=fk_report_card_ref_database_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
242	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.744711	237	EXECUTED	8:bf10f944715f87c3ad0dd7472d84df62	addForeignKeyConstraint baseTableName=report_card, constraintName=fk_report_card_ref_database_id, referencedTableName=metabase_database	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
243	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.749456	238	EXECUTED	8:cba5d2bfb36e13c60d82cc6cca659b61	dropForeignKeyConstraint baseTableName=report_card, constraintName=fk_report_card_ref_table_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
244	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.755809	239	EXECUTED	8:4d40104eaa47d01981644462ef56f369	addForeignKeyConstraint baseTableName=report_card, constraintName=fk_report_card_ref_table_id, referencedTableName=metabase_table	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
245	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.761545	240	EXECUTED	8:a8f9206dadfe23662d547035f71e3846	dropForeignKeyConstraint baseTableName=report_cardfavorite, constraintName=fk_cardfavorite_ref_card_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
246	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.766843	241	EXECUTED	8:e5db34b9db22254f7445fd65ecf45356	addForeignKeyConstraint baseTableName=report_cardfavorite, constraintName=fk_cardfavorite_ref_card_id, referencedTableName=report_card	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
247	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.772481	242	EXECUTED	8:76de7337a12a5ef42dcbb9274bd2d70f	dropForeignKeyConstraint baseTableName=report_cardfavorite, constraintName=fk_cardfavorite_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
248	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.777909	243	EXECUTED	8:0640fb00a090cbe5dc545afbe0d25811	addForeignKeyConstraint baseTableName=report_cardfavorite, constraintName=fk_cardfavorite_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
249	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.782828	244	EXECUTED	8:16ef5909a72ac4779427e432b3b3ce18	dropForeignKeyConstraint baseTableName=report_dashboard, constraintName=fk_dashboard_collection_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
250	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.793477	245	EXECUTED	8:2e80ebe19816b7bde99050638772cf99	addForeignKeyConstraint baseTableName=report_dashboard, constraintName=fk_dashboard_collection_id, referencedTableName=collection	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
251	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.800846	246	EXECUTED	8:c12aa099f293b1e3d71da5e3edb3c45a	dropForeignKeyConstraint baseTableName=report_dashboard, constraintName=fk_dashboard_made_public_by_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
252	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.812257	247	EXECUTED	8:26b16d4d0cf7a77c1d687f49b029f421	addForeignKeyConstraint baseTableName=report_dashboard, constraintName=fk_dashboard_made_public_by_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
253	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.818701	248	EXECUTED	8:bbf118edaa88a8ad486ec0d6965504b6	dropForeignKeyConstraint baseTableName=report_dashboard, constraintName=fk_dashboard_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
254	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.823865	249	EXECUTED	8:7fc35d78c63f41eb4dbd23cfd1505f0b	addForeignKeyConstraint baseTableName=report_dashboard, constraintName=fk_dashboard_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
255	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.829221	250	EXECUTED	8:f6564a7516ace55104a3173eebf4c629	dropForeignKeyConstraint baseTableName=report_dashboardcard, constraintName=fk_dashboardcard_ref_card_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
256	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.838938	251	EXECUTED	8:61db9be3b4dd7ed1e9d01a7254e87544	addForeignKeyConstraint baseTableName=report_dashboardcard, constraintName=fk_dashboardcard_ref_card_id, referencedTableName=report_card	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
257	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.844674	252	EXECUTED	8:c8b51dc7ba4da9f7995a0b0c17fadad2	dropForeignKeyConstraint baseTableName=report_dashboardcard, constraintName=fk_dashboardcard_ref_dashboard_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
258	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.8507	253	EXECUTED	8:58974c6ad8aee63f09e6e48b1a78c267	addForeignKeyConstraint baseTableName=report_dashboardcard, constraintName=fk_dashboardcard_ref_dashboard_id, referencedTableName=report_dashboard	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
259	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.857349	254	EXECUTED	8:be4a52feb3b12e655c0bbd34477749b0	dropForeignKeyConstraint baseTableName=revision, constraintName=fk_revision_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
260	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.864237	255	EXECUTED	8:4b370f9c9073a6f8f585aab713c57f47	addForeignKeyConstraint baseTableName=revision, constraintName=fk_revision_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
261	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.870913	256	EXECUTED	8:173fe552fdf72fdb4efbc01a6ac4f7ad	dropForeignKeyConstraint baseTableName=segment, constraintName=fk_segment_ref_creator_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
262	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.877023	257	EXECUTED	8:50927b8b1d1809f32c11d2e649dbcb94	addForeignKeyConstraint baseTableName=segment, constraintName=fk_segment_ref_creator_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
263	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.884882	258	EXECUTED	8:0b10c8664506917cc50359e9634c121c	dropForeignKeyConstraint baseTableName=segment, constraintName=fk_segment_ref_table_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
264	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.89143	259	EXECUTED	8:b132aedf6fbdcc5d956a2d3a154cc035	addForeignKeyConstraint baseTableName=segment, constraintName=fk_segment_ref_table_id, referencedTableName=metabase_table	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
113	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.182644	109	MARK_RAN	8:8f8e0836064bdea82487ecf64a129767	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
265	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.930562	260	EXECUTED	8:2e339ecb05463b3765f9bb266bd28297	dropForeignKeyConstraint baseTableName=view_log, constraintName=fk_view_log_ref_user_id	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
266	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.936531	261	EXECUTED	8:31506e118764f5e520f755f26c696bb8	addForeignKeyConstraint baseTableName=view_log, constraintName=fk_view_log_ref_user_id, referencedTableName=core_user	Added 0.36.0	\N	3.6.3	\N	\N	4331435714
268	rlotun	migrations/000_migrations.yaml	2021-06-22 03:10:37.943222	262	EXECUTED	8:9da2f706a7cd42b5101601e0106fa929	createIndex indexName=idx_lower_email, tableName=core_user	Added 0.37.0	\N	3.6.3	\N	\N	4331435714
269	rlotun	migrations/000_migrations.yaml	2021-06-22 03:10:37.948051	263	EXECUTED	8:215609ca9dce2181687b4fa65e7351ba	sql	Added 0.37.0	\N	3.6.3	\N	\N	4331435714
270	rlotun	migrations/000_migrations.yaml	2021-06-22 03:10:37.962563	264	EXECUTED	8:17001a192ba1df02104cc0d15569cbe5	sql	Added 0.37.0	\N	3.6.3	\N	\N	4331435714
271	rlotun	migrations/000_migrations.yaml	2021-06-22 03:10:37.972148	265	EXECUTED	8:ce8ddb253a303d4f8924ff5a187080c0	modifyDataType columnName=email, tableName=core_user	Added 0.37.0	\N	3.6.3	\N	\N	4331435714
273	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.978895	266	EXECUTED	8:5348576bb9852f6f947e1aa39cd1626f	addDefaultValue columnName=is_superuser, tableName=core_user	Added 0.37.1	\N	3.6.3	\N	\N	4331435714
274	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.98349	267	EXECUTED	8:11a8a84b9ba7634aeda625ff3f487d22	addDefaultValue columnName=is_active, tableName=core_user	Added 0.37.1	\N	3.6.3	\N	\N	4331435714
275	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:37.988671	268	EXECUTED	8:447d9e294f59dd1058940defec7e0f40	addColumn tableName=metabase_database	Added 0.38.0 refingerprint to Database	\N	3.6.3	\N	\N	4331435714
276	robroland	migrations/000_migrations.yaml	2021-06-22 03:10:37.995875	269	EXECUTED	8:59dd1fb0732c7a9b78bce896c0cff3c0	addColumn tableName=pulse_card	Added 0.38.0 - Dashboard subscriptions	\N	3.6.3	\N	\N	4331435714
277	tsmacdonald	migrations/000_migrations.yaml	2021-06-22 03:10:38.001175	270	EXECUTED	8:367180f0820b72ad2c60212e67ae53e7	dropForeignKeyConstraint baseTableName=pulse_card, constraintName=fk_pulse_card_ref_pulse_card_id	Added 0.38.0 - Dashboard subscriptions	\N	3.6.3	\N	\N	4331435714
288	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:38.076204	281	EXECUTED	8:943c6dd0c9339729fefcee9207227849	sql	Added 0.39 - Semantic type system - migrate unix timestamps	\N	3.6.3	\N	\N	4331435714
289	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:38.081542	282	EXECUTED	8:9f7f2e9bbf3236f204c644dc8ea7abef	sql	Added 0.39 - Semantic type system - migrate unix timestamps (corrects typo- seconds was migrated correctly, not millis and micros)	\N	3.6.3	\N	\N	4331435714
290	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:38.086164	283	EXECUTED	8:98ea7254bc843302db4afe493c4c75e6	sql	Added 0.39 - Semantic type system - Clobber semantic_type where there was a coercion	\N	3.6.3	\N	\N	4331435714
291	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.099179	284	EXECUTED	8:b3b15e2ad791618e3ab1300a5d4f072f	createTable tableName=login_history	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
292	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.104774	285	EXECUTED	8:e4ac005f4d4e73d5e1176bcbde510d6e	createIndex indexName=idx_user_id, tableName=login_history	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
293	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.109854	286	EXECUTED	8:7ba1bd887f8ae11a186b0e3fe69ab3e0	addForeignKeyConstraint baseTableName=login_history, constraintName=fk_login_history_session_id, referencedTableName=core_session	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
294	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.115331	287	EXECUTED	8:88d7a9c88866af42b9f0e7c1df9c2fd0	createIndex indexName=idx_session_id, tableName=login_history	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
295	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.120139	288	EXECUTED	8:501e85a50912649416ec22b2871af087	createIndex indexName=idx_timestamp, tableName=login_history	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
296	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.125972	289	EXECUTED	8:f9eb8b15c2c889334f3848a6bb4ebdb4	createIndex indexName=idx_user_id_device_id, tableName=login_history	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
297	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.131406	290	EXECUTED	8:06c180e4c8361f7550f6f4deaf9fc855	createIndex indexName=idx_user_id_timestamp, tableName=login_history	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
298	tsmacdonald	migrations/000_migrations.yaml	2021-06-22 03:10:38.136224	291	EXECUTED	8:3c73f77d8d939d14320964a35aeaad5e	addColumn tableName=pulse	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
299	tsmacdonald	migrations/000_migrations.yaml	2021-06-22 03:10:38.141517	292	EXECUTED	8:ee3a96e30b07f37240a933e2f0710082	addNotNullConstraint columnName=parameters, tableName=pulse	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
1	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:35.977534	1	EXECUTED	8:7182ca8e82947c24fa827d31f78b19aa	createTable tableName=core_organization; createTable tableName=core_user; createTable tableName=core_userorgperm; addUniqueConstraint constraintName=idx_unique_user_id_organization_id, tableName=core_userorgperm; createIndex indexName=idx_userorgp...		\N	3.6.3	\N	\N	4331435714
2	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:35.988438	2	EXECUTED	8:bdcf1238e2ccb4fbe66d7f9e1d9b9529	createTable tableName=core_session		\N	3.6.3	\N	\N	4331435714
4	cammsaul	migrations/000_migrations.yaml	2021-06-22 03:10:35.996732	3	EXECUTED	8:a8e7822a91ea122212d376f5c2d4158f	createTable tableName=setting		\N	3.6.3	\N	\N	4331435714
5	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.001036	4	EXECUTED	8:4f8653d16f4b102b3dff647277b6b988	addColumn tableName=core_organization		\N	3.6.3	\N	\N	4331435714
6	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.014495	5	EXECUTED	8:2d2f5d1756ecb81da7c09ccfb9b1565a	dropNotNullConstraint columnName=organization_id, tableName=metabase_database; dropForeignKeyConstraint baseTableName=metabase_database, constraintName=fk_database_ref_organization_id; dropNotNullConstraint columnName=organization_id, tableName=re...		\N	3.6.3	\N	\N	4331435714
7	cammsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.020796	6	EXECUTED	8:c57c69fd78d804beb77d261066521f7f	addColumn tableName=metabase_field		\N	3.6.3	\N	\N	4331435714
8	tlrobinson	migrations/000_migrations.yaml	2021-06-22 03:10:36.026098	7	EXECUTED	8:960ec59bbcb4c9f3fa8362eca9af4075	addColumn tableName=metabase_table; addColumn tableName=metabase_field		\N	3.6.3	\N	\N	4331435714
9	tlrobinson	migrations/000_migrations.yaml	2021-06-22 03:10:36.030082	8	EXECUTED	8:d560283a190e3c60802eb04f5532a49d	addColumn tableName=metabase_table		\N	3.6.3	\N	\N	4331435714
10	cammsaul	migrations/000_migrations.yaml	2021-06-22 03:10:36.042948	9	EXECUTED	8:9f03a236be31f54e8e5c894fe5fc7f00	createTable tableName=revision; createIndex indexName=idx_revision_model_model_id, tableName=revision		\N	3.6.3	\N	\N	4331435714
12	agilliland	migrations/000_migrations.yaml	2021-06-22 03:10:36.057846	11	EXECUTED	8:e862a199cba5b4ce0cba713110f66cfb	addColumn tableName=report_card; addColumn tableName=report_card; addColumn tableName=report_card		\N	3.6.3	\N	\N	4331435714
115	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:37.187802	111	MARK_RAN	8:55c10c2ff7e967e3ea1fdffc5aeed93a	sql	Added 0.34.2	\N	3.6.3	\N	\N	4331435714
278	tsmacdonald	migrations/000_migrations.yaml	2021-06-22 03:10:38.00595	271	EXECUTED	8:fc4fb1c1e3344374edd7b9f1f0d34c89	addForeignKeyConstraint baseTableName=pulse_card, constraintName=fk_pulse_card_ref_pulse_card_id, referencedTableName=report_dashboardcard	Added 0.38.0 - Dashboard subscrptions	\N	3.6.3	\N	\N	4331435714
279	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.011634	272	EXECUTED	8:63dfccd51b62b939da71fe4435f58679	addColumn tableName=pulse	Added 0.38.0 - Dashboard subscriptions	\N	3.6.3	\N	\N	4331435714
280	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.016337	273	EXECUTED	8:ae966ee1e40f20ea438daba954a8c2a6	addForeignKeyConstraint baseTableName=pulse, constraintName=fk_pulse_ref_dashboard_id, referencedTableName=report_dashboard	Added 0.38.0 - Dashboard subscriptions	\N	3.6.3	\N	\N	4331435714
281	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:38.020888	274	EXECUTED	8:3039286581c58eee7cca9c25fdf6d792	renameColumn newColumnName=semantic_type, oldColumnName=special_type, tableName=metabase_field	Added 0.39 - Semantic type system - rename special_type	\N	3.6.3	\N	\N	4331435714
282	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.025633	275	EXECUTED	8:d4b8566ee11d9f8a3d6c8c9539f6526d	sql; sql; sql	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
283	camsaul	migrations/000_migrations.yaml	2021-06-22 03:10:38.049286	276	EXECUTED	8:2220e1b1cdb57212820b96fa3107f7c3	sql; sql; sql	Added 0.39.0	\N	3.6.3	\N	\N	4331435714
284	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:38.055589	277	EXECUTED	8:c7dc9a60bcaf9b2ffcbaabd650c959b2	addColumn tableName=metabase_field	Added 0.39 - Semantic type system - add effective type	\N	3.6.3	\N	\N	4331435714
285	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:38.061448	278	EXECUTED	8:cf7d6f5135fa3397a7dc67509d1c286e	addColumn tableName=metabase_field	Added 0.39 - Semantic type system - add coercion column	\N	3.6.3	\N	\N	4331435714
286	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:38.065608	279	EXECUTED	8:bce9ab328411f05d8c52d64bff5bded0	sql	Added 0.39 - Semantic type system - set effective_type default	\N	3.6.3	\N	\N	4331435714
287	dpsutton	migrations/000_migrations.yaml	2021-06-22 03:10:38.071167	280	EXECUTED	8:0679eedae767a8648383aac2f923e413	sql	Added 0.39 - Semantic type system - migrate ISO8601 strings	\N	3.6.3	\N	\N	4331435714
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: dependency; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.dependency (id, model, model_id, dependent_on_model, dependent_on_id, created_at) FROM stdin;
\.


--
-- Data for Name: dimension; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.dimension (id, field_id, name, type, human_readable_field_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: group_table_access_policy; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.group_table_access_policy (id, group_id, table_id, card_id, attribute_remappings) FROM stdin;
\.


--
-- Data for Name: label; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.label (id, name, slug, icon) FROM stdin;
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.login_history (id, "timestamp", user_id, session_id, device_id, device_description, ip_address) FROM stdin;
1	2021-06-24 18:23:22.940406+00	1	24215cae-f243-4918-a966-7d7abd045213	fe93a526-c6c6-484e-a6d5-99f287004031	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36	172.20.0.1
2	2021-06-24 22:55:06.65616+00	1	\N	fe93a526-c6c6-484e-a6d5-99f287004031	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36	172.20.0.1
3	2021-06-24 23:18:36.171417+00	1	e52ff473-daa0-4356-a20d-d5115831ff4f	fe93a526-c6c6-484e-a6d5-99f287004031	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36	172.20.0.1
\.


--
-- Data for Name: metabase_database; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.metabase_database (id, created_at, updated_at, name, description, details, engine, is_sample, is_full_sync, points_of_interest, caveats, metadata_sync_schedule, cache_field_values_schedule, timezone, is_on_demand, options, auto_run_queries, refingerprint) FROM stdin;
2	2021-06-24 18:23:56.81134+00	2021-06-24 18:23:56.941703+00	App	\N	{"host":"postgres-db","port":5432,"dbname":"postgres","user":"postgres","password":"postgres","ssl":false,"additional-options":null,"tunnel-enabled":false}	postgres	f	t	\N	\N	0 4 * * * ? *	0 0 3 * * ? *	UTC	f	\N	t	\N
\.


--
-- Data for Name: metabase_field; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.metabase_field (id, created_at, updated_at, name, base_type, semantic_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version, database_type, has_field_values, settings, database_position, custom_position, effective_type, coercion_strategy) FROM stdin;
82	2021-06-24 23:04:00.25678+00	2021-06-24 23:04:00.25678+00	plan_path	type/*	\N	t	\N	t	3	15	\N	Plan Path	normal	\N	\N	\N	\N	\N	0	path	\N	\N	3	0	type/*	\N
84	2021-06-24 23:04:00.260097+00	2021-06-24 23:04:00.260097+00	id	type/Integer	type/PK	t	\N	t	0	15	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
85	2021-06-24 23:04:00.261198+00	2021-06-24 23:04:00.261198+00	crated_at	type/DateTime	\N	t	\N	t	2	15	\N	Crated At	normal	\N	\N	\N	\N	\N	0	timestamp	\N	\N	2	0	type/DateTime	\N
83	2021-06-24 23:04:00.258794+00	2021-06-24 23:04:00.415865+00	rooftop_id	type/Integer	type/FK	t	\N	t	1	15	\N	Rooftop ID	normal	70	\N	\N	\N	\N	0	int4	\N	\N	1	0	type/Integer	\N
51	2021-06-24 18:23:57.160715+00	2021-06-24 18:23:57.160715+00	id	type/Integer	type/PK	t	\N	t	0	8	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
74	2021-06-24 18:23:57.261599+00	2021-06-24 18:23:57.261599+00	id	type/Integer	type/PK	t	\N	t	3	13	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	3	0	type/Integer	\N
58	2021-06-24 18:23:57.193696+00	2021-06-24 18:23:57.193696+00	id	type/Integer	type/PK	t	\N	t	0	9	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
66	2021-06-24 18:23:57.220031+00	2021-06-24 18:23:57.220031+00	id	type/Integer	type/PK	t	\N	t	0	10	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
70	2021-06-24 18:23:57.235239+00	2021-06-24 18:23:57.235239+00	id	type/Integer	type/PK	t	\N	t	0	11	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
73	2021-06-24 18:23:57.248885+00	2021-06-24 18:23:57.248885+00	id	type/Integer	type/PK	t	\N	t	0	12	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
53	2021-06-24 18:23:57.16485+00	2021-06-24 18:23:57.731141+00	created_at	type/DateTime	type/CreationTimestamp	t	\N	t	7	8	\N	Created At	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/DateTime":{"earliest":"2020-06-23T09:37:37Z","latest":"2020-06-23T09:37:37Z"}}}	5	timestamp	\N	\N	7	0	type/DateTime	\N
38	2021-06-24 18:23:57.062957+00	2021-06-24 18:23:57.062957+00	id	type/Integer	type/PK	t	\N	t	0	5	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
41	2021-06-24 18:23:57.096578+00	2021-06-24 18:23:57.096578+00	id	type/Integer	type/PK	t	\N	t	0	6	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
43	2021-06-24 18:23:57.116528+00	2021-06-24 18:23:57.116528+00	id	type/Integer	type/PK	t	\N	t	0	7	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
54	2021-06-24 18:23:57.166756+00	2021-06-24 18:23:57.536224+00	inspection_time	type/DateTime	\N	t	\N	t	2	8	\N	Inspection Time	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/DateTime":{"earliest":"2020-06-24T08:00:00Z","latest":"2020-06-24T08:00:00Z"}}}	5	timestamp	\N	\N	2	0	type/DateTime	\N
55	2021-06-24 18:23:57.168372+00	2021-06-24 18:23:57.537522+00	end_time	type/DateTime	\N	t	\N	t	6	8	\N	End Time	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/DateTime":{"earliest":"2020-06-24T11:34:37Z","latest":"2020-06-24T11:34:37Z"}}}	5	timestamp	\N	\N	6	0	type/DateTime	\N
56	2021-06-24 18:23:57.191045+00	2021-06-24 18:23:57.575551+00	rooftop_frame_diagnostic_id	type/Integer	type/FK	t	\N	t	3	9	\N	Rooftop Frame Diagnostic ID	normal	66	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":3,"nil%":0.0}}	5	int4	\N	\N	3	0	type/Integer	\N
67	2021-06-24 18:23:57.232129+00	2021-06-24 18:23:57.762195+00	longitude	type/Float	type/Longitude	t	\N	t	4	11	\N	Longitude	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Number":{"min":-45.92448031049118,"q1":-45.92448031049118,"q3":-45.92448031049118,"max":-45.92448031049118,"sd":null,"avg":-45.92448031049118}}}	5	float8	\N	\N	4	0	type/Float	\N
39	2021-06-24 18:23:57.091443+00	2021-06-24 18:23:57.451396+00	crew_id	type/Integer	type/FK	t	\N	t	2	6	\N	Crew ID	normal	73	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	int4	\N	\N	2	0	type/Integer	\N
77	2021-06-24 18:23:57.265128+00	2021-06-24 18:23:57.78363+00	is_active	type/Boolean	type/Category	t	\N	t	2	13	\N	Is Active	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	bool	auto-list	\N	2	0	type/Boolean	\N
80	2021-06-24 18:52:36.627284+00	2021-06-24 18:54:29.286604+00	description	type/Text	type/Category	t	\N	t	1	14	\N	Description	normal	\N	2021-06-24 18:52:36.868348+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":30.0}}}	5	varchar	list	\N	1	0	type/Text	\N
78	2021-06-24 18:52:36.559502+00	2021-06-24 18:52:36.77076+00	inspection_id	type/Integer	type/FK	t	\N	t	9	8	\N	Inspection ID	normal	81	2021-06-24 18:52:36.868348+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	int4	\N	\N	9	0	type/Integer	\N
79	2021-06-24 18:52:36.596288+00	2021-06-24 18:52:36.792123+00	area	type/Float	\N	t	\N	t	5	11	\N	Area	normal	\N	2021-06-24 18:52:36.868348+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Number":{"min":1780.0,"q1":1780.0,"q3":1780.0,"max":1780.0,"sd":null,"avg":1780.0}}}	5	float4	\N	\N	5	0	type/Float	\N
75	2021-06-24 18:23:57.263241+00	2021-06-24 18:23:57.780031+00	cnpj	type/Text	type/Category	t	\N	t	1	13	\N	Cn Pj	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":18.0}}}	5	varchar	auto-list	\N	1	0	type/Text	\N
81	2021-06-24 18:52:36.628668+00	2021-06-24 18:52:36.628668+00	id	type/Integer	type/PK	t	\N	t	0	14	\N	ID	normal	\N	\N	\N	\N	\N	0	serial	\N	\N	0	0	type/Integer	\N
49	2021-06-24 18:23:57.155785+00	2021-06-24 18:23:57.73557+00	start_time	type/DateTime	type/CreationTimestamp	t	\N	t	5	8	\N	Start Time	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/DateTime":{"earliest":"2020-06-24T08:35:26Z","latest":"2020-06-24T08:35:26Z"}}}	5	timestamp	\N	\N	5	0	type/DateTime	\N
52	2021-06-24 18:23:57.163271+00	2021-06-24 18:23:57.533342+00	crew_id	type/Integer	type/FK	t	\N	t	3	8	\N	Crew ID	normal	73	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	int4	\N	\N	3	0	type/Integer	\N
60	2021-06-24 18:23:57.195886+00	2021-06-24 18:23:57.744767+00	latitude	type/Float	type/Latitude	t	\N	t	4	9	\N	Latitude	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":4,"nil%":0.0},"type":{"type/Number":{"min":-23.23743886267635,"q1":-23.237432477756524,"q3":-23.237420799805783,"max":-23.23740886267635,"sd":9.51189731175332E-6,"avg":-23.23742600553349}}}	5	float8	\N	\N	4	0	type/Float	\N
57	2021-06-24 18:23:57.19259+00	2021-06-24 18:23:57.577519+00	rooftop_inspection_id	type/Integer	type/FK	t	\N	t	2	9	\N	Rooftop Inspection ID	normal	51	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	int4	\N	\N	2	0	type/Integer	\N
76	2021-06-24 18:23:57.264239+00	2021-06-24 18:23:57.776214+00	name	type/Text	type/Name	t	\N	t	0	13	\N	Name	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":33.0}}}	5	varchar	auto-list	\N	0	0	type/Text	\N
47	2021-06-24 18:23:57.150893+00	2021-06-24 18:23:57.524878+00	rooftop_id	type/Integer	type/FK	t	\N	t	4	8	\N	Rooftop ID	normal	70	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	int4	\N	\N	4	0	type/Integer	\N
48	2021-06-24 18:23:57.153645+00	2021-06-24 18:23:57.52673+00	rooftop_inspection_status_id	type/Integer	type/FK	t	\N	t	8	8	\N	Rooftop Inspection Status ID	normal	38	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	int4	\N	\N	8	0	type/Integer	\N
59	2021-06-24 18:23:57.19469+00	2021-06-24 18:23:57.740993+00	frame_path	type/Text	type/Category	t	\N	t	1	9	\N	Frame Path	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":7,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":39.0}}}	5	varchar	auto-list	\N	1	0	type/Text	\N
63	2021-06-24 18:23:57.199425+00	2021-06-24 18:23:57.747429+00	longitude	type/Float	type/Longitude	t	\N	t	5	9	\N	Longitude	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":4,"nil%":0.0},"type":{"type/Number":{"min":-45.92449031049118,"q1":-45.92448392557135,"q3":-45.92447224762061,"max":-45.92445031049118,"sd":1.2724180204327586E-5,"avg":-45.924476024776894}}}	5	float8	\N	\N	5	0	type/Float	\N
65	2021-06-24 18:23:57.218846+00	2021-06-24 18:23:57.753018+00	name	type/Text	type/Name	t	\N	t	1	10	\N	Name	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":3,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":9.666666666666666}}}	5	varchar	auto-list	\N	1	0	type/Text	\N
72	2021-06-24 18:23:57.247557+00	2021-06-24 18:23:57.771698+00	name	type/Text	type/Name	t	\N	t	1	12	\N	Name	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":11.0}}}	5	varchar	auto-list	\N	1	0	type/Text	\N
68	2021-06-24 18:23:57.23328+00	2021-06-24 18:23:57.644557+00	customer_id	type/Integer	type/FK	t	\N	t	2	11	\N	Customer ID	normal	74	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	int4	\N	\N	2	0	type/Integer	\N
37	2021-06-24 18:23:57.058969+00	2021-06-24 18:23:57.70621+00	name	type/Text	type/Name	t	\N	t	1	5	\N	Name	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":4,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":8.25}}}	5	varchar	auto-list	\N	1	0	type/Text	\N
44	2021-06-24 18:23:57.118826+00	2021-06-24 18:23:57.718673+00	phone	type/Text	type/Category	t	\N	t	2	7	\N	Phone	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":14.0}}}	5	varchar	auto-list	\N	2	0	type/Text	\N
45	2021-06-24 18:23:57.120728+00	2021-06-24 18:23:57.722448+00	email	type/Text	type/Email	t	\N	t	3	7	\N	Email	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":1.0,"percent-state":0.0,"average-length":14.0}}}	5	varchar	auto-list	\N	3	0	type/Text	\N
71	2021-06-24 18:23:57.236158+00	2021-06-24 18:23:57.758413+00	latitude	type/Float	type/Latitude	t	\N	t	3	11	\N	Latitude	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Number":{"min":-23.23742886267635,"q1":-23.23742886267635,"q3":-23.23742886267635,"max":-23.23742886267635,"sd":null,"avg":-23.23742886267635}}}	5	float8	\N	\N	3	0	type/Float	\N
69	2021-06-24 18:23:57.234322+00	2021-06-24 18:23:57.766343+00	description	type/Text	type/Description	t	\N	t	1	11	\N	Description	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":31.0}}}	5	varchar	auto-list	\N	1	0	type/Text	\N
46	2021-06-24 18:23:57.122341+00	2021-06-24 18:23:57.486684+00	customer_id	type/Integer	type/FK	t	\N	t	4	7	\N	Customer ID	normal	74	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0}}	5	int4	\N	\N	4	0	type/Integer	\N
61	2021-06-24 18:23:57.19743+00	2021-06-24 18:23:57.583957+00	area	type/Float	\N	t	\N	t	6	9	\N	Area	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.07000000029802322,"q1":0.07000000029802322,"q3":0.15000000596046448,"max":0.15000000596046448,"sd":0.05656854649887441,"avg":0.11000000312924385}}}	5	float4	\N	\N	6	0	type/Float	\N
62	2021-06-24 18:23:57.198416+00	2021-06-24 18:23:57.585907+00	length	type/Float	\N	t	\N	t	7	9	\N	Length	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.4099999964237213,"q1":0.4099999964237213,"q3":0.8100000023841858,"max":0.8100000023841858,"sd":0.2828427166893039,"avg":0.6099999994039536}}}	5	float4	\N	\N	7	0	type/Float	\N
64	2021-06-24 18:23:57.200576+00	2021-06-24 18:23:57.59147+00	width	type/Float	\N	t	\N	t	8	9	\N	Width	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.3499999940395355,"q1":0.3499999940395355,"q3":0.550000011920929,"max":0.550000011920929,"sd":0.14142136888136406,"avg":0.45000000298023224}}}	5	float4	\N	\N	8	0	type/Float	\N
40	2021-06-24 18:23:57.094117+00	2021-06-24 18:23:57.710873+00	name	type/Text	type/Name	t	\N	t	1	6	\N	Name	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":4,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":6.0}}}	5	varchar	auto-list	\N	1	0	type/Text	\N
42	2021-06-24 18:23:57.115045+00	2021-06-24 18:23:57.715042+00	name	type/Text	type/Name	t	\N	t	1	7	\N	Name	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":14.0}}}	5	varchar	auto-list	\N	1	0	type/Text	\N
50	2021-06-24 18:23:57.158471+00	2021-06-24 18:33:58.514361+00	description	type/Text	type/Category	t	\N	t	1	8	\N	Description	normal	\N	2021-06-24 18:23:57.832011+00	\N	\N	{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":14.0}}}	5	varchar	list	\N	1	0	type/Text	\N
\.


--
-- Data for Name: metabase_fieldvalues; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) FROM stdin;
20	2021-06-24 18:53:56.908445+00	2021-06-24 18:53:56.908445+00	["Agendado","Cancelado","Criado","Finalizado"]	\N	37
21	2021-06-24 18:53:56.92777+00	2021-06-24 18:53:56.92777+00	["Gabriel","Nilson","Odair","Thiago"]	\N	40
22	2021-06-24 18:53:56.950346+00	2021-06-24 18:53:56.950346+00	["+5512987654321"]	\N	44
23	2021-06-24 18:53:56.966126+00	2021-06-24 18:53:56.966126+00	["ftal@teste.com"]	\N	45
24	2021-06-24 18:53:56.982975+00	2021-06-24 18:53:56.982975+00	["Foolano de Tal"]	\N	42
25	2021-06-24 18:53:57.009151+00	2021-06-24 18:53:57.009151+00	["Telhado Sampro"]	\N	50
26	2021-06-24 18:53:57.028657+00	2021-06-24 18:53:57.028657+00	["/frames/2021-06/ri00000001/00000001.png","/frames/2021-06/ri00000001/00000002.png","/frames/2021-06/ri00000001/00000003.png","/frames/2021-06/ri00000001/00000004.png","/frames/2021-06/ri00000001/00000005.png","/frames/2021-06/ri00000001/00000006.png","/frames/2021-06/ri00000001/00000007.png"]	\N	59
27	2021-06-24 18:53:57.051642+00	2021-06-24 18:53:57.051642+00	["Avaria","Bom estado","Intederminado"]	\N	65
28	2021-06-24 18:53:57.073597+00	2021-06-24 18:53:57.073597+00	["Sampro - Fabrica de Absorventes"]	\N	69
29	2021-06-24 18:53:57.093862+00	2021-06-24 18:53:57.093862+00	["Equipe Alfa"]	\N	72
30	2021-06-24 18:53:57.112917+00	2021-06-24 18:53:57.112917+00	[true]	\N	77
31	2021-06-24 18:53:57.139918+00	2021-06-24 18:53:57.139918+00	["59.748.988/0001-14"]	\N	75
32	2021-06-24 18:53:57.157835+00	2021-06-24 18:53:57.157835+00	["JOHNSON & JOHNSON INDUSTRIAL LTDA"]	\N	76
33	2021-06-24 18:53:57.177043+00	2021-06-24 18:53:57.177043+00	["Inspecao JOHNSON & JOHNSON SJC"]	\N	80
\.


--
-- Data for Name: metabase_table; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.metabase_table (id, created_at, updated_at, name, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, points_of_interest, caveats, show_in_getting_started, field_order) FROM stdin;
5	2021-06-24 18:23:56.984468+00	2021-06-24 18:23:57.792674+00	rooftop_inspection_status	\N	\N	entity/GenericTable	t	2	Rooftop Inspection Status	\N	public	\N	\N	f	database
6	2021-06-24 18:23:56.991195+00	2021-06-24 18:23:57.797491+00	staff	\N	\N	entity/GenericTable	t	2	Staff	\N	public	\N	\N	f	database
7	2021-06-24 18:23:56.999321+00	2021-06-24 18:23:57.803261+00	customer_contact	\N	\N	entity/GenericTable	t	2	Customer Contact	\N	public	\N	\N	f	database
8	2021-06-24 18:23:57.004985+00	2021-06-24 18:23:57.808213+00	rooftop_inspection	\N	\N	entity/GenericTable	t	2	Rooftop Inspection	\N	public	\N	\N	f	database
9	2021-06-24 18:23:57.010387+00	2021-06-24 18:23:57.811885+00	rooftop_inspection_frame	\N	\N	entity/GenericTable	t	2	Rooftop Inspection Frame	\N	public	\N	\N	f	database
10	2021-06-24 18:23:57.015167+00	2021-06-24 18:23:57.816125+00	rooftop_frame_diagnostic	\N	\N	entity/GenericTable	t	2	Rooftop Frame Diagnostic	\N	public	\N	\N	f	database
11	2021-06-24 18:23:57.020165+00	2021-06-24 18:23:57.819206+00	rooftop	\N	\N	entity/GenericTable	t	2	Rooftop	\N	public	\N	\N	f	database
12	2021-06-24 18:23:57.025916+00	2021-06-24 18:23:57.821993+00	crew	\N	\N	entity/GenericTable	t	2	Crew	\N	public	\N	\N	f	database
13	2021-06-24 18:23:57.03162+00	2021-06-24 18:23:57.824904+00	customer	\N	\N	entity/GenericTable	t	2	Customer	\N	public	\N	\N	f	database
14	2021-06-24 18:52:36.509714+00	2021-06-24 18:52:36.861105+00	inspection	\N	\N	entity/GenericTable	t	2	Inspection	\N	public	\N	\N	f	database
15	2021-06-24 23:04:00.085155+00	2021-06-24 23:04:00.647179+00	rooftop_plan	\N	\N	entity/GenericTable	t	2	Rooftop Plan	\N	public	\N	\N	f	database
\.


--
-- Data for Name: metric; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.metric (id, table_id, creator_id, name, description, archived, definition, created_at, updated_at, points_of_interest, caveats, how_is_this_calculated, show_in_getting_started) FROM stdin;
\.


--
-- Data for Name: metric_important_field; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.metric_important_field (id, metric_id, field_id) FROM stdin;
\.


--
-- Data for Name: native_query_snippet; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.native_query_snippet (id, name, description, content, creator_id, archived, created_at, updated_at, collection_id) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.permissions (id, object, group_id) FROM stdin;
1	/	2
2	/collection/root/	1
3	/collection/root/	3
5	/db/2/	1
6	/collection/2/	1
7	/collection/2/	3
\.


--
-- Data for Name: permissions_group; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.permissions_group (id, name) FROM stdin;
1	All Users
2	Administrators
3	MetaBot
\.


--
-- Data for Name: permissions_group_membership; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.permissions_group_membership (id, user_id, group_id) FROM stdin;
1	1	1
2	1	2
\.


--
-- Data for Name: permissions_revision; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.permissions_revision (id, before, after, user_id, created_at, remark) FROM stdin;
\.


--
-- Data for Name: pulse; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.pulse (id, creator_id, name, created_at, updated_at, skip_if_empty, alert_condition, alert_first_only, alert_above_goal, collection_id, collection_position, archived, dashboard_id, parameters) FROM stdin;
\.


--
-- Data for Name: pulse_card; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.pulse_card (id, pulse_id, card_id, "position", include_csv, include_xls, dashboard_card_id) FROM stdin;
\.


--
-- Data for Name: pulse_channel; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.pulse_channel (id, pulse_id, channel_type, details, schedule_type, schedule_hour, schedule_day, created_at, updated_at, schedule_frame, enabled) FROM stdin;
\.


--
-- Data for Name: pulse_channel_recipient; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.pulse_channel_recipient (id, pulse_channel_id, user_id) FROM stdin;
\.


--
-- Data for Name: qrtz_blob_triggers; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_blob_triggers (sched_name, trigger_name, trigger_group, blob_data) FROM stdin;
\.


--
-- Data for Name: qrtz_calendars; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_calendars (sched_name, calendar_name, calendar) FROM stdin;
\.


--
-- Data for Name: qrtz_cron_triggers; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_cron_triggers (sched_name, trigger_name, trigger_group, cron_expression, time_zone_id) FROM stdin;
MetabaseScheduler	metabase.task.upgrade-checks.trigger	DEFAULT	0 15 6,18 * * ? *	GMT
MetabaseScheduler	metabase.task.anonymous-stats.trigger	DEFAULT	0 15 7 * * ? *	GMT
MetabaseScheduler	metabase.task.abandonment-emails.trigger	DEFAULT	0 0 12 * * ? *	GMT
MetabaseScheduler	metabase.task.follow-up-emails.trigger	DEFAULT	0 0 12 * * ? *	GMT
MetabaseScheduler	metabase.task.send-pulses.trigger	DEFAULT	0 0 * * * ? *	GMT
MetabaseScheduler	metabase.task.task-history-cleanup.trigger	DEFAULT	0 0 * * * ? *	GMT
MetabaseScheduler	metabase.task.sync-and-analyze.trigger.2	DEFAULT	0 4 * * * ? *	GMT
MetabaseScheduler	metabase.task.update-field-values.trigger.2	DEFAULT	0 0 3 * * ? *	GMT
\.


--
-- Data for Name: qrtz_fired_triggers; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_fired_triggers (sched_name, entry_id, trigger_name, trigger_group, instance_name, fired_time, sched_time, priority, state, job_name, job_group, is_nonconcurrent, requests_recovery) FROM stdin;
\.


--
-- Data for Name: qrtz_job_details; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_job_details (sched_name, job_name, job_group, description, job_class_name, is_durable, is_nonconcurrent, is_update_data, requests_recovery, job_data) FROM stdin;
MetabaseScheduler	metabase.task.upgrade-checks.job	DEFAULT	\N	metabase.task.upgrade_checks.CheckForNewVersions	f	f	f	f	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f40000000000010770800000010000000007800
MetabaseScheduler	metabase.task.anonymous-stats.job	DEFAULT	\N	metabase.task.send_anonymous_stats.SendAnonymousUsageStats	f	f	f	f	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f40000000000010770800000010000000007800
MetabaseScheduler	metabase.task.abandonment-emails.job	DEFAULT	\N	metabase.task.follow_up_emails.AbandonmentEmail	f	f	f	f	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f40000000000010770800000010000000007800
MetabaseScheduler	metabase.task.send-pulses.job	DEFAULT	\N	metabase.task.send_pulses.SendPulses	f	f	f	f	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f40000000000010770800000010000000007800
MetabaseScheduler	metabase.task.follow-up-emails.job	DEFAULT	\N	metabase.task.follow_up_emails.FollowUpEmail	f	f	f	f	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f40000000000010770800000010000000007800
MetabaseScheduler	metabase.task.task-history-cleanup.job	DEFAULT	\N	metabase.task.task_history_cleanup.TaskHistoryCleanup	f	f	f	f	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f40000000000010770800000010000000007800
MetabaseScheduler	metabase.task.sync-and-analyze.job	DEFAULT	sync-and-analyze for all databases	metabase.task.sync_databases.SyncAndAnalyzeDatabase	t	t	f	f	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f40000000000010770800000010000000007800
MetabaseScheduler	metabase.task.update-field-values.job	DEFAULT	update-field-values for all databases	metabase.task.sync_databases.UpdateFieldValues	t	t	f	f	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f40000000000010770800000010000000007800
\.


--
-- Data for Name: qrtz_locks; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_locks (sched_name, lock_name) FROM stdin;
MetabaseScheduler	STATE_ACCESS
MetabaseScheduler	TRIGGER_ACCESS
\.


--
-- Data for Name: qrtz_paused_trigger_grps; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_paused_trigger_grps (sched_name, trigger_group) FROM stdin;
\.


--
-- Data for Name: qrtz_scheduler_state; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_scheduler_state (sched_name, instance_name, last_checkin_time, checkin_interval) FROM stdin;
MetabaseScheduler	048d4ee18a641624575940631	1624582136824	7500
\.


--
-- Data for Name: qrtz_simple_triggers; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_simple_triggers (sched_name, trigger_name, trigger_group, repeat_count, repeat_interval, times_triggered) FROM stdin;
\.


--
-- Data for Name: qrtz_simprop_triggers; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_simprop_triggers (sched_name, trigger_name, trigger_group, str_prop_1, str_prop_2, str_prop_3, int_prop_1, int_prop_2, long_prop_1, long_prop_2, dec_prop_1, dec_prop_2, bool_prop_1, bool_prop_2) FROM stdin;
\.


--
-- Data for Name: qrtz_triggers; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.qrtz_triggers (sched_name, trigger_name, trigger_group, job_name, job_group, description, next_fire_time, prev_fire_time, priority, trigger_state, trigger_type, start_time, end_time, calendar_name, misfire_instr, job_data) FROM stdin;
MetabaseScheduler	metabase.task.update-field-values.trigger.2	DEFAULT	metabase.task.update-field-values.job	DEFAULT	update-field-values Database 2	1624590000000	-1	5	WAITING	CRON	1624559036000	0	\N	2	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787001737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c7708000000100000000174000564622d6964737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000027800
MetabaseScheduler	metabase.task.send-pulses.trigger	DEFAULT	metabase.task.send-pulses.job	DEFAULT	\N	1624582800000	1624579200000	5	WAITING	CRON	1624575940000	0	\N	1	\\x
MetabaseScheduler	metabase.task.task-history-cleanup.trigger	DEFAULT	metabase.task.task-history-cleanup.job	DEFAULT	\N	1624582800000	1624579200000	5	WAITING	CRON	1624575940000	0	\N	0	\\x
MetabaseScheduler	metabase.task.sync-and-analyze.trigger.2	DEFAULT	metabase.task.sync-and-analyze.job	DEFAULT	sync-and-analyze Database 2	1624583040000	1624579440000	5	WAITING	CRON	1624559036000	0	\N	2	\\xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787001737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c7708000000100000000174000564622d6964737200116a6176612e6c616e672e496e746567657212e2a0a4f781873802000149000576616c7565787200106a6176612e6c616e672e4e756d62657286ac951d0b94e08b0200007870000000027800
MetabaseScheduler	metabase.task.upgrade-checks.trigger	DEFAULT	metabase.task.upgrade-checks.job	DEFAULT	\N	1624601700000	-1	5	WAITING	CRON	1624575940000	0	\N	0	\\x
MetabaseScheduler	metabase.task.anonymous-stats.trigger	DEFAULT	metabase.task.anonymous-stats.job	DEFAULT	\N	1624605300000	-1	5	WAITING	CRON	1624575940000	0	\N	0	\\x
MetabaseScheduler	metabase.task.abandonment-emails.trigger	DEFAULT	metabase.task.abandonment-emails.job	DEFAULT	\N	1624622400000	-1	5	WAITING	CRON	1624575940000	0	\N	0	\\x
MetabaseScheduler	metabase.task.follow-up-emails.trigger	DEFAULT	metabase.task.follow-up-emails.job	DEFAULT	\N	1624622400000	-1	5	WAITING	CRON	1624575940000	0	\N	0	\\x
\.


--
-- Data for Name: query; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.query (query_hash, average_execution_time, query) FROM stdin;
\\xff84035baefa9dddef71321e0bb35c941079edf12809f9a589c7652241ebedb5	51	{"type":"query","database":2,"query":{"source-table":9,"aggregation":[["count"]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x6b240ff904bd8d23fa4420c5094cb1b839bcec8ebe66ab971ea511ecbdd20b8f	144	{"type":"query","database":2,"query":{"source-table":9,"aggregation":[["distinct",["field",51,{"source-field":57}]]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x3af790bd97c76643fd6bd237eeadd17fb0fea0b3a3e11a93a0cfef4fc1511b6d	87	{"type":"query","database":2,"query":{"source-table":9,"breakout":[["field",61,{"binning":{"strategy":"default"}}]],"aggregation":[["count"]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xb58f9b989825b5c3cc7e2b9430f6dd4f078f19ba8fd3274f325eee208b2038d6	124	{"type":"query","database":2,"query":{"source-table":9,"breakout":[["field",64,{"binning":{"strategy":"default"}}]],"aggregation":[["count"]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xbab60538a126922f7d53e8dde416f02acf5571c383218ab1b926f2d1aa9af9e8	140	{"type":"query","database":2,"query":{"source-table":9,"breakout":[["field",62,{"binning":{"strategy":"default"}}]],"aggregation":[["count"]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xf166a1379de5c67b08aff6615dc28327c263c05d87c17c6ef62baeb37f1ab1f2	162	{"type":"query","database":2,"query":{"source-table":9,"aggregation":[["distinct",["field",66,{"source-field":56}]]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x5fe3566b41cc9aadb85545ef79bb3f06a0f1951ceeb271b7f530b3988b712bb7	82	{"type":"query","database":2,"query":{"source-table":9,"breakout":[["field",63,null],["field",60,null]],"aggregation":[["count"]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x840d74a61802017b14e992e363d52d075e04c82258d89650f597abc840901707	149	{"type":"query","database":2,"query":{"source-table":9,"breakout":[["field",65,{"source-field":56}]],"aggregation":[["count"]],"order-by":[["desc",["aggregation",0]]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x4b80506609cdd8e603eea71477a1b79b9b2abd8b5c1196062fc5c70708c48553	99	{"type":"query","database":2,"query":{"source-table":9,"breakout":[["field",59,null]],"aggregation":[["count"]],"order-by":[["desc",["aggregation",0]]]},"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x2d9f34c32bc11c0150389d08b8887eb2f054a38a7f6d751cee8519b56d847718	31	{"database":2,"query":{"source-table":10},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xf52e641a17482d3b465db2940e023e3fb75bb647a9963a76eed6912e8339a10d	24	{"type":"query","query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]]},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x6c09c705b3ae9de6f8c15accf34ca4aee27bedec7dc80598e37783d7e12b0b6f	28	{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1]},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x114a95e20e36576bd492c0820662e724aad424cd09d41e4c4c8094d19bf4376d	28	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1]},"async?":true,"cache-ttl":null}
\\x24f90b4237a35de3b419c133722d77b07979a0534c48549fc123e3e316a7fc1d	26	{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection"}]},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	27	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection"}]},"async?":true,"cache-ttl":null}
\\xce53214408de7a530ceae0881e2b8198a564adf6d7ad0b3ea30855ca64ed698a	60	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection"}]},"parameters":[{"type":"category","value":["Telhado Sampro"],"target":["dimension",["field",50,{"join-alias":"Rooftop Inspection"}]]}],"async?":true,"cache-ttl":null}
\\xafdc84d44c7f714e72a59dfff40c109debc020ae94d55cf640bd79dd3d8791bb	31	{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x9874682a930cd29c37fa2558429daf223e1fbe7fc43140b1073b272545a8c30e	40	{"database":2,"query":{"source-table":9},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x573af66d3c50d56c8bbca4f9f2ca5aab5b1baabed8f82735d882f6b75861da37	34	{"type":"query","query":{"source-table":9,"limit":10},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	115	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"async?":true,"cache-ttl":null}
\\x0a265e1abe3664a22e13a5b070b27c2136513c8ef52b589cb4899f575597a4c8	37	{"database":2,"query":{"source-table":9,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"},{"fields":"all","source-table":11,"condition":["=",["field",47,{"join-alias":"Rooftop Inspection"}],["field",70,{"join-alias":"Rooftop"}]],"alias":"Rooftop","strategy":"inner-join"}],"aggregation":[["sum",["field",79,{"join-alias":"Rooftop"}]]]},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x67ceec3809e993f38e718abba1406822aa84e1c5ada3c6124dcf998767243033	61	{"database":2,"query":{"source-table":9,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"}],"limit":10},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x01b93f48b1cacc33b09e94bb7a5fb65abb337d1c5fc9fb60c01f2cd704815d84	40	{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"}],"limit":10},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x020f0be62a28b4ffef15c5303db7c1c57d40792105f48968427642c2ea501bf7	22	{"database":2,"query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]]},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	105	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]]},"async?":true,"cache-ttl":null}
\\x2b5478a5dc49099413a01b42688214e958ade306cac867b8eb317acb2011734e	40	{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"limit":10},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xe3f110542fde8cb6aeb9eaee0c065ad43d5d7e7c29a92a1d84e3a0df89195a2e	54	{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"expressions":{"as":["-",["field",55,{"join-alias":"Rooftop Inspection"}],["field",49,{"join-alias":"Rooftop Inspection"}]]}},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x81b4eb869e7463234f37ce3f8c0b469da6cfdc34819434aca533c34f16a37337	14	{"type":"native","native":{"query":"SELECT sum(\\"source\\".\\"Duration\\") AS \\"sum\\"\\nFROM (SELECT \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\tto_char(\\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\", 'HH24:MI:SS') AS \\"Duration\\" FROM \\"public\\".\\"rooftop\\" INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\") \\"source\\"","template-tags":{}},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x601613ce355a45f73ce46c4d7bb48c7f5751fbcd03d252ecfdbb1d815dc2f1a1	15	{"type":"native","native":{"query":"SELECT to_char(sum(\\"source\\".\\"Duration\\"), 'HH24:MI:SS') AS \\"sum\\"\\nFROM (SELECT \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", (\\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\") AS \\"Duration\\" FROM \\"public\\".\\"rooftop\\" INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\") \\"source\\"","template-tags":{}},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x6e808bc89e47f327d8a33d29160fd23e92b0a45905fb8fc860e702894c21e73e	29	{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]],"expressions":{"as":["-",["field",55,{"join-alias":"Rooftop Inspection"}],["field",49,{"join-alias":"Rooftop Inspection"}]]}},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x90b3dbf5487e23c54336f53393f763b239708e6ca6bbfebf259b903fd0988207	46	{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"expressions":{"as":["-",["field",55,{"join-alias":"Rooftop Inspection"}],["field",49,{"join-alias":"Rooftop Inspection"}]]},"limit":10},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xe666b34caa367675c64179c3756f64f3f69b3f8addcc4b21959fae91a1f18c63	29	{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"expressions":{"Duration":["-",["field",55,{"join-alias":"Rooftop Inspection"}],["field",49,{"join-alias":"Rooftop Inspection"}]]},"aggregation":[["sum",["expression","Duration"]]]},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xbd580e5e081edd596bf432a70c5a87c2eb2d5642c8714cbf28dc0efb852b4fdd	17	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"native","middleware":{"js-int-to-string?":true},"native":{"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE 1=1 \\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop}}]]\\n  ) \\"source\\"","template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop","display-name":"Rooftop","type":"dimension","dimension":["field",69,null]}}},"database":2,"async?":true,"cache-ttl":null}
\\x12346cc78ce70bbcf85f80e981e37247f8440ffe40ea32eac3376eb316928527	39	{"database":2,"query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x85d3a859771c4de429fe00575eb3b186d79aa89467954db7f9ab1cea8afe50ec	32	{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":"none","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x5c31186164fac00e84b3bfe0e33ebeb48332e44d675b8e85c69bc8a62d5542f4	28	{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xd067274083b371dd655dd39e5cd6e4e4e900e2a1361feadfd9544708eafa7ab3	45	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]],"filter":["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]},"async?":true,"cache-ttl":null}
\\xc5689499835f767c7b7a08ad323b123b485599e93fea451395d5d989de24814e	20	{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",61,null]]]},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	88	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",61,null]]]},"async?":true,"cache-ttl":null}
\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	119	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"async?":true,"cache-ttl":null}
\\x005a03f9c055d3b3eeef1164e530f09781147f740bf847a607d0e776d14d2718	59	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"native","middleware":{"js-int-to-string?":true},"native":{"template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop_inspection":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop_inspection","display-name":"Rooftop inspection","type":"dimension","dimension":["field",50,null],"widget-type":"category"}},"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE 1=1 \\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop_inspection}}]]\\n  ) \\"source\\""},"database":2,"parameters":[{"type":"category","value":["Inspecao JOHNSON & JOHNSON SJC"],"target":["dimension",["template-tag","inspection"]]}],"async?":true,"cache-ttl":null}
\\x32bbf33a427e56dbd45e14dc8822617bf73715d3f65621d55d6607be38c81a60	141	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]]},"parameters":[{"type":"category","value":["Inspecao JOHNSON & JOHNSON SJC"],"target":["dimension",["field",80,{"join-alias":"Inspection"}]]}],"async?":true,"cache-ttl":null}
\\xb4019346949a9028ee32d591a323a217254c763fd7c70840ab6c428162e69e07	57	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"parameters":[{"type":"category","value":["Inspecao JOHNSON & JOHNSON SJC"],"target":["dimension",["field",80,{"join-alias":"Inspection"}]]}],"async?":true,"cache-ttl":null}
\\x34f531a4117dc35bddbbc66daedb8b064136bf993ff17a40506fab39fe81e390	37	{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xbdd5481be2761fa4c719bc20c16bbb8e8b36865e134973956dbf961fb8f5e78a	14	{"database":2,"native":{"template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop_inspection":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop_inspection","display-name":"Rooftop inspection","type":"dimension","dimension":["field",50,null],"widget-type":"category"}},"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE  \\"Rooftop Inspection\\".\\"rooftop_inspection_status_id\\" = 3\\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop_inspection}}]]\\n  ) \\"source\\""},"type":"native","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x9ec4a41886b3f2543e1a99638e7f60e6f098efda1cc4347a8fec129f56bf423d	16	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"native","middleware":{"js-int-to-string?":true},"native":{"template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop_inspection":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop_inspection","display-name":"Rooftop inspection","type":"dimension","dimension":["field",50,null],"widget-type":"category"}},"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE  \\"Rooftop Inspection\\".\\"rooftop_inspection_status_id\\" = 3\\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop_inspection}}]]\\n  ) \\"source\\""},"database":2,"async?":true,"cache-ttl":null}
\\xefce829a0fd2f803f4d20f2ad57c4e14af068ae818ea74766c4a3a7a5cde936f	46	{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"},{"fields":[["field",79,{"join-alias":"Rooftop"}]],"source-table":11,"condition":["=",["field",47,{"join-alias":"Rooftop Inspection"}],["field",70,{"join-alias":"Rooftop"}]],"alias":"Rooftop","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x49e969ea2a7e94dcf65bc4cb6be7f5f4717e28235772e800f7c07cf01fe06a70	134	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"aggregation":[["count"]],"filter":["and",["=",["field",56,null],1],["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"async?":true,"cache-ttl":null}
\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	51	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"native","middleware":{"js-int-to-string?":true},"native":{"template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop_inspection":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop_inspection","display-name":"Rooftop inspection","type":"dimension","dimension":["field",50,null],"widget-type":"category"}},"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE 1=1 \\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop_inspection}}]]\\n  ) \\"source\\""},"database":2,"async?":true,"cache-ttl":null}
\\xdf0069e89181bcf275c5da6043cc4c5c4753ef6c4479a917c4d794886aa3ddbc	61	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"aggregation":[["count"]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"async?":true,"cache-ttl":null}
\\x9140c24ed0d9135f7c1204a222a9b6c0858b6941c376778ea6415b5392006451	41	{"type":"query","query":{"source-table":9,"aggregation":[["count"]],"filter":["and",["=",["field",56,null],1],["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x4cbbae2c418606fba3ca18c264c1940125e6cb0eb81788f5ca282bc159733c0c	28	{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]],"filter":["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]},"database":2,"middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\x4de29e6c1eae3b970cb045264913671c2df8d5af6e2afd24278f3a72bff76764	99	{"constraints":{"max-results":10000,"max-results-bare-rows":2000},"type":"query","middleware":{"js-int-to-string?":true},"database":2,"query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"},{"fields":[["field",79,{"join-alias":"Rooftop"}]],"source-table":11,"condition":["=",["field",47,{"join-alias":"Rooftop Inspection"}],["field",70,{"join-alias":"Rooftop"}]],"alias":"Rooftop","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"async?":true,"cache-ttl":null}
\\xf899f84655d99f26fdc70514015598043cb40ffd093c8f49ab20bf382b5501dd	14	{"database":2,"native":{"template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop_inspection":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop_inspection","display-name":"Rooftop inspection","type":"dimension","dimension":["field",50,null],"widget-type":"category"}},"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE  \\"rooftop_inspection\\".\\"rooftop_inspection_status_id\\" = 3\\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop_inspection}}]]\\n  ) \\"source\\""},"type":"native","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	37	{"database":2,"query":{"source-table":9,"filter":["and",["=",["field",56,null],1],["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"type":"query","middleware":{"js-int-to-string?":true,"add-default-userland-constraints?":true}}
\.


--
-- Data for Name: query_cache; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.query_cache (query_hash, updated_at, results) FROM stdin;
\.


--
-- Data for Name: query_execution; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id, database_id) FROM stdin;
1	\\xff84035baefa9dddef71321e0bb35c941079edf12809f9a589c7652241ebedb5	2021-06-24 18:24:04.25595+00	51	1	f	ad-hoc	\N	1	\N	\N	\N	2
2	\\x6b240ff904bd8d23fa4420c5094cb1b839bcec8ebe66ab971ea511ecbdd20b8f	2021-06-24 18:24:04.302644+00	144	1	f	ad-hoc	\N	1	\N	\N	\N	2
3	\\x3af790bd97c76643fd6bd237eeadd17fb0fea0b3a3e11a93a0cfef4fc1511b6d	2021-06-24 18:24:04.361069+00	87	3	f	ad-hoc	\N	1	\N	\N	\N	2
4	\\xb58f9b989825b5c3cc7e2b9430f6dd4f078f19ba8fd3274f325eee208b2038d6	2021-06-24 18:24:04.391253+00	124	3	f	ad-hoc	\N	1	\N	\N	\N	2
5	\\xbab60538a126922f7d53e8dde416f02acf5571c383218ab1b926f2d1aa9af9e8	2021-06-24 18:24:04.335705+00	140	3	f	ad-hoc	\N	1	\N	\N	\N	2
6	\\xf166a1379de5c67b08aff6615dc28327c263c05d87c17c6ef62baeb37f1ab1f2	2021-06-24 18:24:04.285121+00	162	1	f	ad-hoc	\N	1	\N	\N	\N	2
7	\\x5fe3566b41cc9aadb85545ef79bb3f06a0f1951ceeb271b7f530b3988b712bb7	2021-06-24 18:24:04.513098+00	82	4	f	ad-hoc	\N	1	\N	\N	\N	2
8	\\x840d74a61802017b14e992e363d52d075e04c82258d89650f597abc840901707	2021-06-24 18:24:04.445573+00	149	3	f	ad-hoc	\N	1	\N	\N	\N	2
9	\\x4b80506609cdd8e603eea71477a1b79b9b2abd8b5c1196062fc5c70708c48553	2021-06-24 18:24:04.496765+00	99	7	f	ad-hoc	\N	1	\N	\N	\N	2
10	\\x2d9f34c32bc11c0150389d08b8887eb2f054a38a7f6d751cee8519b56d847718	2021-06-24 18:26:25.069427+00	31	3	f	ad-hoc	\N	1	\N	\N	\N	2
11	\\x9874682a930cd29c37fa2558429daf223e1fbe7fc43140b1073b272545a8c30e	2021-06-24 18:26:36.798809+00	39	7	f	ad-hoc	\N	1	\N	\N	\N	2
12	\\x9874682a930cd29c37fa2558429daf223e1fbe7fc43140b1073b272545a8c30e	2021-06-24 18:27:17.847329+00	45	7	f	ad-hoc	\N	1	\N	\N	\N	2
13	\\xf52e641a17482d3b465db2940e023e3fb75bb647a9963a76eed6912e8339a10d	2021-06-24 18:27:53.145248+00	24	1	f	ad-hoc	\N	1	\N	\N	\N	2
14	\\x6c09c705b3ae9de6f8c15accf34ca4aee27bedec7dc80598e37783d7e12b0b6f	2021-06-24 18:28:04.380921+00	28	1	f	ad-hoc	\N	1	\N	\N	\N	2
15	\\x114a95e20e36576bd492c0820662e724aad424cd09d41e4c4c8094d19bf4376d	2021-06-24 18:29:38.113674+00	28	1	f	question	\N	1	1	\N	\N	2
16	\\x114a95e20e36576bd492c0820662e724aad424cd09d41e4c4c8094d19bf4376d	2021-06-24 18:30:31.287061+00	30	1	f	question	\N	1	1	\N	\N	2
17	\\x24f90b4237a35de3b419c133722d77b07979a0534c48549fc123e3e316a7fc1d	2021-06-24 18:31:50.94081+00	26	1	f	ad-hoc	\N	1	\N	\N	\N	2
18	\\x9874682a930cd29c37fa2558429daf223e1fbe7fc43140b1073b272545a8c30e	2021-06-24 18:32:27.367844+00	41	7	f	ad-hoc	\N	1	\N	\N	\N	2
19	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:32:38.851085+00	23	1	f	question	\N	1	1	\N	\N	2
20	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:34:41.732773+00	26	1	f	question	\N	1	1	\N	\N	2
21	\\xce53214408de7a530ceae0881e2b8198a564adf6d7ad0b3ea30855ca64ed698a	2021-06-24 18:35:06.255731+00	60	1	f	question	\N	1	1	\N	\N	2
22	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:35:11.797882+00	33	1	f	question	\N	1	1	\N	\N	2
23	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:36:05.955117+00	27	1	f	question	\N	1	1	\N	\N	2
24	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:50:53.208338+00	36	1	f	question	\N	1	1	\N	\N	2
25	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:51:54.401511+00	30	1	f	question	\N	1	1	\N	\N	2
26	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:52:48.804497+00	33	1	f	question	\N	1	1	\N	\N	2
27	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:54:45.331679+00	30	1	f	question	\N	1	1	\N	\N	2
28	\\x86c8a50ef286be05de8b8712ba961ae355e78b27da185dada3402c18331b8c97	2021-06-24 18:54:48.122683+00	29	1	f	question	\N	1	1	\N	\N	2
29	\\xafdc84d44c7f714e72a59dfff40c109debc020ae94d55cf640bd79dd3d8791bb	2021-06-24 18:55:36.345786+00	31	1	f	ad-hoc	\N	1	\N	\N	\N	2
30	\\x9874682a930cd29c37fa2558429daf223e1fbe7fc43140b1073b272545a8c30e	2021-06-24 18:55:57.244414+00	35	7	f	ad-hoc	\N	1	\N	\N	\N	2
31	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 18:56:07.587676+00	29	1	f	question	\N	1	1	\N	\N	2
32	\\xb4019346949a9028ee32d591a323a217254c763fd7c70840ab6c428162e69e07	2021-06-24 18:57:03.569824+00	41	1	f	question	\N	1	1	\N	\N	2
33	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 18:57:07.814572+00	32	1	f	question	\N	1	1	\N	\N	2
34	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 18:57:13.431147+00	40	1	f	question	\N	1	1	\N	\N	2
35	\\x0a265e1abe3664a22e13a5b070b27c2136513c8ef52b589cb4899f575597a4c8	2021-06-24 18:59:40.983983+00	37	1	f	ad-hoc	\N	1	\N	\N	\N	2
36	\\x573af66d3c50d56c8bbca4f9f2ca5aab5b1baabed8f82735d882f6b75861da37	2021-06-24 19:00:02.054974+00	34	7	f	ad-hoc	\N	1	\N	\N	\N	2
37	\\x67ceec3809e993f38e718abba1406822aa84e1c5ada3c6124dcf998767243033	2021-06-24 19:00:06.792994+00	61	7	f	ad-hoc	\N	1	\N	\N	\N	2
38	\\x01b93f48b1cacc33b09e94bb7a5fb65abb337d1c5fc9fb60c01f2cd704815d84	2021-06-24 19:01:06.579751+00	40	1	f	ad-hoc	\N	1	\N	\N	\N	2
39	\\x2b5478a5dc49099413a01b42688214e958ade306cac867b8eb317acb2011734e	2021-06-24 19:01:59.094219+00	40	1	f	ad-hoc	\N	1	\N	\N	\N	2
40	\\x020f0be62a28b4ffef15c5303db7c1c57d40792105f48968427642c2ea501bf7	2021-06-24 19:02:21.011441+00	22	1	f	ad-hoc	\N	1	\N	\N	\N	2
41	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:03:22.203263+00	30	1	f	question	\N	1	1	\N	\N	2
42	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:03:22.356184+00	27	1	f	question	\N	1	2	\N	\N	2
43	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:04:03.722873+00	35	1	f	question	\N	1	2	\N	\N	2
44	\\x2b5478a5dc49099413a01b42688214e958ade306cac867b8eb317acb2011734e	2021-06-24 19:05:03.97028+00	42	1	f	ad-hoc	\N	1	\N	\N	\N	2
45	\\x6e808bc89e47f327d8a33d29160fd23e92b0a45905fb8fc860e702894c21e73e	2021-06-24 19:07:29.327954+00	29	1	f	ad-hoc	\N	1	\N	\N	\N	2
46	\\xe3f110542fde8cb6aeb9eaee0c065ad43d5d7e7c29a92a1d84e3a0df89195a2e	2021-06-24 19:07:36.719319+00	54	1	f	ad-hoc	\N	1	\N	\N	\N	2
47	\\x90b3dbf5487e23c54336f53393f763b239708e6ca6bbfebf259b903fd0988207	2021-06-24 19:07:53.550634+00	46	1	f	ad-hoc	\N	1	\N	\N	\N	2
48	\\xe666b34caa367675c64179c3756f64f3f69b3f8addcc4b21959fae91a1f18c63	2021-06-24 19:08:26.138305+00	30	1	f	ad-hoc	\N	1	\N	\N	\N	2
49	\\xe666b34caa367675c64179c3756f64f3f69b3f8addcc4b21959fae91a1f18c63	2021-06-24 19:15:26.360088+00	24	1	f	ad-hoc	\N	1	\N	\N	\N	2
50	\\x81b4eb869e7463234f37ce3f8c0b469da6cfdc34819434aca533c34f16a37337	2021-06-24 19:16:15.507026+00	14	0	t	ad-hoc	Error executing query	1	\N	\N	\N	2
51	\\x601613ce355a45f73ce46c4d7bb48c7f5751fbcd03d252ecfdbb1d815dc2f1a1	2021-06-24 19:16:52.493651+00	15	1	t	ad-hoc	\N	1	\N	\N	\N	2
52	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:21:16.596874+00	30	1	f	question	\N	1	2	\N	\N	2
53	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:21:16.593457+00	39	1	f	question	\N	1	1	\N	\N	2
54	\\xbd580e5e081edd596bf432a70c5a87c2eb2d5642c8714cbf28dc0efb852b4fdd	2021-06-24 19:21:16.775112+00	17	1	t	question	\N	1	3	\N	\N	2
55	\\xbd580e5e081edd596bf432a70c5a87c2eb2d5642c8714cbf28dc0efb852b4fdd	2021-06-24 19:21:55.083306+00	14	1	t	question	\N	1	3	\N	\N	2
56	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-24 19:22:47.817839+00	24	1	t	question	\N	1	3	\N	\N	2
57	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:22:47.80797+00	44	1	f	question	\N	1	2	\N	\N	2
58	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:22:47.804872+00	62	1	f	question	\N	1	1	\N	\N	2
59	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:23:27.409479+00	31	1	f	question	\N	1	1	\N	\N	2
60	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:23:39.352094+00	27	1	f	question	\N	1	1	\N	\N	2
61	\\x12346cc78ce70bbcf85f80e981e37247f8440ffe40ea32eac3376eb316928527	2021-06-24 19:24:43.232502+00	39	2	f	ad-hoc	\N	1	\N	\N	\N	2
62	\\x85d3a859771c4de429fe00575eb3b186d79aa89467954db7f9ab1cea8afe50ec	2021-06-24 19:26:13.119304+00	32	2	f	ad-hoc	\N	1	\N	\N	\N	2
63	\\x5c31186164fac00e84b3bfe0e33ebeb48332e44d675b8e85c69bc8a62d5542f4	2021-06-24 19:26:32.263622+00	28	2	f	ad-hoc	\N	1	\N	\N	\N	2
64	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:27:32.614758+00	41	1	f	question	\N	1	2	\N	\N	2
65	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:27:32.614621+00	46	1	f	question	\N	1	1	\N	\N	2
66	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-24 19:27:32.634327+00	36	1	t	question	\N	1	3	\N	\N	2
67	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 19:27:32.853221+00	32	2	f	question	\N	1	4	\N	\N	2
68	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 19:28:42.810603+00	36	2	f	question	\N	1	4	\N	\N	2
69	\\xc5689499835f767c7b7a08ad323b123b485599e93fea451395d5d989de24814e	2021-06-24 19:28:58.915903+00	20	1	f	ad-hoc	\N	1	\N	\N	\N	2
70	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:29:34.009203+00	58	1	f	question	\N	1	1	\N	\N	2
71	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:29:34.00912+00	61	1	f	question	\N	1	2	\N	\N	2
72	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-24 19:29:34.024693+00	61	1	t	question	\N	1	3	\N	\N	2
73	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 19:29:34.026858+00	67	2	f	question	\N	1	4	\N	\N	2
91	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 19:31:18.96765+00	50	2	f	question	\N	1	4	\N	\N	2
93	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 19:31:19.214448+00	31	2	f	question	\N	1	6	\N	\N	2
74	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-24 19:29:34.242431+00	19	1	f	question	\N	1	5	\N	\N	2
79	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:30:03.548599+00	63	1	f	question	\N	1	1	\N	\N	2
84	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-24 19:30:28.013018+00	29	1	f	question	\N	1	5	\N	\N	2
75	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-24 19:29:38.964067+00	28	1	f	question	\N	1	5	\N	\N	2
76	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-24 19:30:03.551449+00	24	1	t	question	\N	1	3	\N	\N	2
77	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-24 19:30:03.55531+00	23	1	f	question	\N	1	5	\N	\N	2
78	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:30:03.543335+00	65	1	f	question	\N	1	2	\N	\N	2
81	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:30:26.038132+00	32	1	f	question	\N	1	1	\N	\N	2
82	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-24 19:30:27.994452+00	18	1	t	question	\N	1	3	\N	\N	2
85	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 19:30:27.998691+00	60	2	f	question	\N	1	4	\N	\N	2
90	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:31:18.962482+00	39	1	f	question	\N	1	2	\N	\N	2
80	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 19:30:03.573936+00	67	2	f	question	\N	1	4	\N	\N	2
83	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:30:27.990296+00	34	1	f	question	\N	1	1	\N	\N	2
86	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 19:30:27.994451+00	66	1	f	question	\N	1	2	\N	\N	2
87	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 19:30:29.884936+00	37	2	f	question	\N	1	4	\N	\N	2
88	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-24 19:31:18.967225+00	16	1	t	question	\N	1	3	\N	\N	2
89	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-24 19:31:18.96586+00	36	1	f	question	\N	1	5	\N	\N	2
92	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 19:31:18.962514+00	57	1	f	question	\N	1	1	\N	\N	2
94	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-24 22:55:07.537685+00	411	1	t	question	\N	1	3	\N	\N	2
95	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-24 22:55:07.510725+00	599	3	f	question	\N	1	1	\N	\N	2
96	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 22:55:07.633378+00	457	4	f	question	\N	1	4	\N	\N	2
97	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-24 22:55:07.533409+00	572	1	f	question	\N	1	2	\N	\N	2
98	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 22:55:07.595454+00	527	4	f	question	\N	1	6	\N	\N	2
99	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-24 22:55:07.606188+00	492	1	f	question	\N	1	5	\N	\N	2
100	\\x005a03f9c055d3b3eeef1164e530f09781147f740bf847a607d0e776d14d2718	2021-06-24 22:55:40.267087+00	62	0	t	question	Error executing query	1	3	\N	\N	2
101	\\x32bbf33a427e56dbd45e14dc8822617bf73715d3f65621d55d6607be38c81a60	2021-06-24 22:55:40.258124+00	141	1	f	question	\N	1	2	\N	\N	2
102	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 22:55:40.265217+00	141	4	f	question	\N	1	6	\N	\N	2
103	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-24 22:55:40.284209+00	103	1	f	question	\N	1	5	\N	\N	2
104	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-24 22:55:40.286506+00	146	4	f	question	\N	1	4	\N	\N	2
105	\\xb4019346949a9028ee32d591a323a217254c763fd7c70840ab6c428162e69e07	2021-06-24 22:55:40.305105+00	200	3	f	question	\N	1	1	\N	\N	2
106	\\x005a03f9c055d3b3eeef1164e530f09781147f740bf847a607d0e776d14d2718	2021-06-24 22:55:42.801024+00	28	0	t	question	Error executing query	1	3	\N	\N	2
107	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-24 22:55:46.707173+00	25	1	t	question	\N	1	3	\N	\N	2
108	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-25 00:19:59.703369+00	122	1	t	question	\N	1	3	\N	\N	2
109	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:19:59.78119+00	234	4	f	question	\N	1	6	\N	\N	2
110	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-25 00:19:59.787239+00	268	1	f	question	\N	1	5	\N	\N	2
111	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-25 00:19:59.706754+00	380	1	f	question	\N	1	2	\N	\N	2
112	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-25 00:19:59.699296+00	367	3	f	question	\N	1	1	\N	\N	2
113	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:19:59.77244+00	316	4	f	question	\N	1	4	\N	\N	2
114	\\xc72edcab77f48ce9b750e8a0803d3bc6184ba413e2ded193bb7d938fca101c85	2021-06-25 00:20:13.345258+00	41	3	f	question	\N	1	1	\N	\N	2
115	\\x34f531a4117dc35bddbbc66daedb8b064136bf993ff17a40506fab39fe81e390	2021-06-25 00:21:08.218417+00	37	1	f	ad-hoc	\N	1	\N	\N	\N	2
116	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-25 00:21:16.862222+00	17	1	t	question	\N	1	3	\N	\N	2
117	\\xdf0069e89181bcf275c5da6043cc4c5c4753ef6c4479a917c4d794886aa3ddbc	2021-06-25 00:21:16.86609+00	55	1	f	question	\N	1	1	\N	\N	2
118	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:21:16.880325+00	90	4	f	question	\N	1	4	\N	\N	2
119	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-25 00:21:16.895037+00	74	1	f	question	\N	1	5	\N	\N	2
120	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:21:16.901405+00	91	4	f	question	\N	1	6	\N	\N	2
121	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-25 00:21:16.905237+00	100	1	f	question	\N	1	2	\N	\N	2
122	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:23:31.956017+00	47	4	f	question	\N	1	4	\N	\N	2
123	\\xefce829a0fd2f803f4d20f2ad57c4e14af068ae818ea74766c4a3a7a5cde936f	2021-06-25 00:25:22.858419+00	46	4	f	ad-hoc	\N	1	\N	\N	\N	2
124	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-25 00:25:40.596826+00	49	1	t	question	\N	1	3	\N	\N	2
125	\\xdf0069e89181bcf275c5da6043cc4c5c4753ef6c4479a917c4d794886aa3ddbc	2021-06-25 00:25:40.59588+00	69	1	f	question	\N	1	1	\N	\N	2
126	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-25 00:25:40.617235+00	63	1	f	question	\N	1	5	\N	\N	2
127	\\x4de29e6c1eae3b970cb045264913671c2df8d5af6e2afd24278f3a72bff76764	2021-06-25 00:25:40.629763+00	102	4	f	question	\N	1	4	\N	\N	2
128	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:25:40.604484+00	127	4	f	question	\N	1	6	\N	\N	2
129	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-25 00:25:40.646206+00	100	1	f	question	\N	1	2	\N	\N	2
130	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-25 00:35:19.460445+00	34	1	f	question	\N	1	2	\N	\N	2
131	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-25 00:35:27.761499+00	30	1	t	question	\N	1	3	\N	\N	2
132	\\x4de29e6c1eae3b970cb045264913671c2df8d5af6e2afd24278f3a72bff76764	2021-06-25 00:35:27.765881+00	89	4	f	question	\N	1	4	\N	\N	2
133	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-25 00:35:27.790707+00	105	1	f	question	\N	1	2	\N	\N	2
134	\\xdf0069e89181bcf275c5da6043cc4c5c4753ef6c4479a917c4d794886aa3ddbc	2021-06-25 00:35:27.782924+00	132	1	f	question	\N	1	1	\N	\N	2
135	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:35:27.801565+00	131	4	f	question	\N	1	6	\N	\N	2
136	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-25 00:35:27.804436+00	134	1	f	question	\N	1	5	\N	\N	2
137	\\xdf0069e89181bcf275c5da6043cc4c5c4753ef6c4479a917c4d794886aa3ddbc	2021-06-25 00:35:29.070751+00	36	1	f	question	\N	1	1	\N	\N	2
138	\\x9140c24ed0d9135f7c1204a222a9b6c0858b6941c376778ea6415b5392006451	2021-06-25 00:36:23.905367+00	41	1	f	ad-hoc	\N	1	\N	\N	\N	2
139	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-25 00:36:42.004771+00	56	1	t	question	\N	1	3	\N	\N	2
140	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-25 00:36:41.963067+00	135	1	f	question	\N	1	2	\N	\N	2
141	\\x49e969ea2a7e94dcf65bc4cb6be7f5f4717e28235772e800f7c07cf01fe06a70	2021-06-25 00:36:41.96872+00	153	1	f	question	\N	1	1	\N	\N	2
142	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:36:41.985415+00	152	4	f	question	\N	1	6	\N	\N	2
143	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-25 00:36:41.981861+00	154	1	f	question	\N	1	5	\N	\N	2
144	\\x4de29e6c1eae3b970cb045264913671c2df8d5af6e2afd24278f3a72bff76764	2021-06-25 00:36:41.986841+00	175	4	f	question	\N	1	4	\N	\N	2
145	\\xbaa30b1d7c642feebdda9c44be3e868d5f69aa337b8809cc18860dda5689f3d0	2021-06-25 00:36:52.423979+00	33	1	f	question	\N	1	2	\N	\N	2
146	\\x4cbbae2c418606fba3ca18c264c1940125e6cb0eb81788f5ca282bc159733c0c	2021-06-25 00:37:13.561984+00	28	1	f	ad-hoc	\N	1	\N	\N	\N	2
147	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-25 00:37:21.898053+00	28	1	t	question	\N	1	3	\N	\N	2
148	\\x49e969ea2a7e94dcf65bc4cb6be7f5f4717e28235772e800f7c07cf01fe06a70	2021-06-25 00:37:21.898233+00	45	1	f	question	\N	1	1	\N	\N	2
149	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-25 00:37:21.925944+00	35	1	f	question	\N	1	5	\N	\N	2
150	\\xd067274083b371dd655dd39e5cd6e4e4e900e2a1361feadfd9544708eafa7ab3	2021-06-25 00:37:21.918816+00	44	1	f	question	\N	1	2	\N	\N	2
151	\\x4de29e6c1eae3b970cb045264913671c2df8d5af6e2afd24278f3a72bff76764	2021-06-25 00:37:21.911319+00	65	4	f	question	\N	1	4	\N	\N	2
152	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:37:21.910082+00	91	4	f	question	\N	1	6	\N	\N	2
153	\\x5a7d0c515b6d0d4d76e2dd85e75d1e14f4e4469706892fd0ca3b49fe5f8ed2ab	2021-06-25 00:37:23.571144+00	14	1	t	question	\N	1	3	\N	\N	2
154	\\xf899f84655d99f26fdc70514015598043cb40ffd093c8f49ab20bf382b5501dd	2021-06-25 00:38:26.832238+00	14	0	t	ad-hoc	Error executing query	1	\N	\N	\N	2
155	\\xbdd5481be2761fa4c719bc20c16bbb8e8b36865e134973956dbf961fb8f5e78a	2021-06-25 00:39:12.861473+00	14	1	t	ad-hoc	\N	1	\N	\N	\N	2
156	\\x9ec4a41886b3f2543e1a99638e7f60e6f098efda1cc4347a8fec129f56bf423d	2021-06-25 00:39:21.499+00	16	1	t	question	\N	1	3	\N	\N	2
157	\\x4de29e6c1eae3b970cb045264913671c2df8d5af6e2afd24278f3a72bff76764	2021-06-25 00:39:21.486939+00	52	4	f	question	\N	1	4	\N	\N	2
158	\\xf4a5f2289fc2a60c47019c86fa546c277bf871376ec37caf77e79011e2c2e9e3	2021-06-25 00:39:21.49869+00	44	1	f	question	\N	1	5	\N	\N	2
159	\\x49e969ea2a7e94dcf65bc4cb6be7f5f4717e28235772e800f7c07cf01fe06a70	2021-06-25 00:39:21.486853+00	60	1	f	question	\N	1	1	\N	\N	2
160	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:39:21.503833+00	62	4	f	question	\N	1	6	\N	\N	2
161	\\xd067274083b371dd655dd39e5cd6e4e4e900e2a1361feadfd9544708eafa7ab3	2021-06-25 00:39:21.512051+00	57	1	f	question	\N	1	2	\N	\N	2
162	\\x054e8987f39730b20cc8099c91dda9034e689994828c4325b397e040d8e65f2a	2021-06-25 00:39:52.996524+00	60	4	f	question	\N	1	6	\N	\N	2
163	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:40:55.355753+00	37	4	f	ad-hoc	\N	1	\N	\N	\N	2
164	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:42:47.008042+00	33	4	f	ad-hoc	\N	1	\N	\N	\N	2
165	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:42:49.111649+00	34	4	f	ad-hoc	\N	1	\N	\N	\N	2
166	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:42:49.846901+00	35	4	f	ad-hoc	\N	1	\N	\N	\N	2
167	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:43:59.695824+00	35	4	f	ad-hoc	\N	1	\N	\N	\N	2
168	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:44:47.247648+00	36	4	f	ad-hoc	\N	1	\N	\N	\N	2
169	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:45:15.044554+00	37	4	f	ad-hoc	\N	1	\N	\N	\N	2
170	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:46:25.497506+00	37	4	f	ad-hoc	\N	1	\N	\N	\N	2
171	\\xcbdf9b5ffd5f44cd838843d430087867341fd27a71e4d990b4deb1446fdc5168	2021-06-25 00:46:54.548387+00	34	4	f	ad-hoc	\N	1	\N	\N	\N	2
\.


--
-- Data for Name: report_card; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.report_card (id, created_at, updated_at, name, description, display, dataset_query, visualization_settings, creator_id, database_id, table_id, query_type, archived, collection_id, public_uuid, made_public_by_id, enable_embedding, embedding_params, cache_ttl, result_metadata, collection_position) FROM stdin;
1	2021-06-24 18:28:41.882409+00	2021-06-25 00:39:21.545599+00	# de Avarias	\N	scalar	{"type":"query","query":{"source-table":9,"aggregation":[["count"]],"filter":["and",["=",["field",56,null],1],["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"database":2}	{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"}	1	2	9	query	f	2	\N	\N	f	\N	\N	[{"name":"count","display_name":"Count","base_type":"type/BigInteger","semantic_type":"type/Quantity","field_ref":["aggregation",0],"fingerprint":{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Number":{"min":4.0,"q1":4.0,"q3":4.0,"max":4.0,"sd":null,"avg":4.0}}}}]	\N
3	2021-06-24 19:21:10.277434+00	2021-06-25 00:39:21.512954+00	Elapsed Time	\N	scalar	{"database":2,"native":{"template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop_inspection":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop_inspection","display-name":"Rooftop inspection","type":"dimension","dimension":["field",50,null],"widget-type":"category"}},"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE  \\"Rooftop Inspection\\".\\"rooftop_inspection_status_id\\" = 3\\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop_inspection}}]]\\n  ) \\"source\\""},"type":"native"}	{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count","column_settings":{"[\\"name\\",\\"sum\\"]":{"time_enabled":"minutes","time_style":"HH:mm","date_abbreviate":false}}}	1	2	\N	native	f	2	\N	\N	f	\N	\N	[{"name":"sum","display_name":"sum","base_type":"type/Text","field_ref":["field","sum",{"base-type":"type/Text"}],"semantic_type":null,"fingerprint":{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":8.0}}}}]	\N
2	2021-06-24 19:03:12.487283+00	2021-06-25 00:39:21.568809+00	Inspected Area (m²)	\N	scalar	{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]],"filter":["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]},"database":2}	{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"}	1	2	11	query	f	2	\N	\N	f	\N	\N	[{"name":"sum","display_name":"Sum of Area","base_type":"type/Float","semantic_type":null,"field_ref":["aggregation",0],"fingerprint":{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Number":{"min":6960.0,"q1":6960.0,"q3":6960.0,"max":6960.0,"sd":null,"avg":6960.0}}}}]	\N
5	2021-06-24 19:29:30.081288+00	2021-06-25 00:39:21.536674+00	Damaged roof area (m²)	\N	scalar	{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",61,null]]]},"database":2}	{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"}	1	2	9	query	f	2	\N	\N	f	\N	\N	[{"name":"sum","display_name":"Sum of Area","base_type":"type/Float","semantic_type":null,"field_ref":["aggregation",0],"fingerprint":{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Number":{"min":0.3400000035762787,"q1":0.3400000035762787,"q3":0.3400000035762787,"max":0.3400000035762787,"sd":null,"avg":0.3400000035762787}}}}]	\N
4	2021-06-24 19:27:28.758335+00	2021-06-25 00:39:21.536004+00	Damaged roof tile list	\N	table	{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"},{"fields":[["field",79,{"join-alias":"Rooftop"}]],"source-table":11,"condition":["=",["field",47,{"join-alias":"Rooftop Inspection"}],["field",70,{"join-alias":"Rooftop"}]],"alias":"Rooftop","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"database":2}	{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"}	1	2	9	query	f	2	\N	\N	f	\N	\N	[{"semantic_type":"type/PK","coercion_strategy":null,"name":"id","field_ref":["field",58,null],"effective_type":"type/Integer","id":58,"display_name":"ID","fingerprint":null,"base_type":"type/Integer"},{"semantic_type":"type/Category","coercion_strategy":null,"name":"frame_path","field_ref":["field",59,null],"effective_type":"type/Text","id":59,"display_name":"Frame Path","fingerprint":{"global":{"distinct-count":7,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":39.0}}},"base_type":"type/Text"},{"semantic_type":"type/Latitude","coercion_strategy":null,"name":"latitude","field_ref":["field",60,null],"effective_type":"type/Float","id":60,"display_name":"Latitude","fingerprint":{"global":{"distinct-count":4,"nil%":0.0},"type":{"type/Number":{"min":-23.23743886267635,"q1":-23.237432477756524,"q3":-23.237420799805783,"max":-23.23740886267635,"sd":9.51189731175332E-6,"avg":-23.23742600553349}}},"base_type":"type/Float"},{"semantic_type":"type/Longitude","coercion_strategy":null,"name":"longitude","field_ref":["field",63,null],"effective_type":"type/Float","id":63,"display_name":"Longitude","fingerprint":{"global":{"distinct-count":4,"nil%":0.0},"type":{"type/Number":{"min":-45.92449031049118,"q1":-45.92448392557135,"q3":-45.92447224762061,"max":-45.92445031049118,"sd":1.2724180204327586E-5,"avg":-45.924476024776894}}},"base_type":"type/Float"},{"semantic_type":null,"coercion_strategy":null,"name":"area","field_ref":["field",61,null],"effective_type":"type/Float","id":61,"display_name":"Area","fingerprint":{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.07000000029802322,"q1":0.07000000029802322,"q3":0.15000000596046448,"max":0.15000000596046448,"sd":0.05656854649887441,"avg":0.11000000312924385}}},"base_type":"type/Float"},{"semantic_type":null,"coercion_strategy":null,"name":"length","field_ref":["field",62,null],"effective_type":"type/Float","id":62,"display_name":"Length","fingerprint":{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.4099999964237213,"q1":0.4099999964237213,"q3":0.8100000023841858,"max":0.8100000023841858,"sd":0.2828427166893039,"avg":0.6099999994039536}}},"base_type":"type/Float"},{"semantic_type":null,"coercion_strategy":null,"name":"width","field_ref":["field",64,null],"effective_type":"type/Float","id":64,"display_name":"Width","fingerprint":{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.3499999940395355,"q1":0.3499999940395355,"q3":0.550000011920929,"max":0.550000011920929,"sd":0.14142136888136406,"avg":0.45000000298023224}}},"base_type":"type/Float"},{"semantic_type":"type/Category","coercion_strategy":null,"name":"description","field_ref":["field",50,{"join-alias":"Rooftop Inspection"}],"effective_type":"type/Text","id":50,"display_name":"Rooftop Inspection → Description","fingerprint":{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":14.0}}},"base_type":"type/Text"},{"semantic_type":"type/Category","coercion_strategy":null,"name":"description_2","field_ref":["field",80,{"join-alias":"Inspection"}],"effective_type":"type/Text","id":80,"display_name":"Inspection → Description","fingerprint":{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"percent-state":0.0,"average-length":30.0}}},"base_type":"type/Text"},{"semantic_type":null,"coercion_strategy":null,"name":"area_2","field_ref":["field",79,{"join-alias":"Rooftop"}],"effective_type":"type/Float","id":79,"display_name":"Rooftop → Area","fingerprint":{"global":{"distinct-count":1,"nil%":0.0},"type":{"type/Number":{"min":1780.0,"q1":1780.0,"q3":1780.0,"max":1780.0,"sd":null,"avg":1780.0}}},"base_type":"type/Float"}]	\N
6	2021-06-24 19:31:13.991672+00	2021-06-25 00:40:27.778949+00	Damaged tile map	\N	map	{"database":2,"query":{"source-table":9,"filter":["and",["=",["field",56,null],1],["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"type":"query"}	{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count","map.type":"pin"}	1	2	9	query	f	2	\N	\N	f	\N	\N	[{"semantic_type":"type/PK","coercion_strategy":null,"name":"id","field_ref":["field",58,null],"effective_type":"type/Integer","id":58,"display_name":"ID","fingerprint":null,"base_type":"type/Integer"},{"semantic_type":"type/Category","coercion_strategy":null,"name":"frame_path","field_ref":["field",59,null],"effective_type":"type/Text","id":59,"display_name":"Frame Path","fingerprint":{"global":{"distinct-count":7,"nil%":0},"type":{"type/Text":{"percent-json":0,"percent-url":0,"percent-email":0,"percent-state":0,"average-length":39}}},"base_type":"type/Text"},{"semantic_type":"type/Latitude","coercion_strategy":null,"name":"latitude","field_ref":["field",60,null],"effective_type":"type/Float","id":60,"display_name":"Latitude","fingerprint":{"global":{"distinct-count":4,"nil%":0},"type":{"type/Number":{"min":-23.23743886267635,"q1":-23.237432477756524,"q3":-23.237420799805783,"max":-23.23740886267635,"sd":9.51189731175332E-6,"avg":-23.23742600553349}}},"base_type":"type/Float"},{"semantic_type":"type/Longitude","coercion_strategy":null,"name":"longitude","field_ref":["field",63,null],"effective_type":"type/Float","id":63,"display_name":"Longitude","fingerprint":{"global":{"distinct-count":4,"nil%":0},"type":{"type/Number":{"min":-45.92449031049118,"q1":-45.92448392557135,"q3":-45.92447224762061,"max":-45.92445031049118,"sd":1.2724180204327586E-5,"avg":-45.924476024776894}}},"base_type":"type/Float"},{"semantic_type":null,"coercion_strategy":null,"name":"area","field_ref":["field",61,null],"effective_type":"type/Float","id":61,"display_name":"Area","fingerprint":{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.07000000029802322,"q1":0.07000000029802322,"q3":0.15000000596046448,"max":0.15000000596046448,"sd":0.05656854649887441,"avg":0.11000000312924385}}},"base_type":"type/Float"},{"semantic_type":null,"coercion_strategy":null,"name":"length","field_ref":["field",62,null],"effective_type":"type/Float","id":62,"display_name":"Length","fingerprint":{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.4099999964237213,"q1":0.4099999964237213,"q3":0.8100000023841858,"max":0.8100000023841858,"sd":0.2828427166893039,"avg":0.6099999994039536}}},"base_type":"type/Float"},{"semantic_type":null,"coercion_strategy":null,"name":"width","field_ref":["field",64,null],"effective_type":"type/Float","id":64,"display_name":"Width","fingerprint":{"global":{"distinct-count":3,"nil%":0.7142857142857143},"type":{"type/Number":{"min":0.3499999940395355,"q1":0.3499999940395355,"q3":0.550000011920929,"max":0.550000011920929,"sd":0.14142136888136406,"avg":0.45000000298023224}}},"base_type":"type/Float"},{"semantic_type":"type/Category","coercion_strategy":null,"name":"description","field_ref":["field",50,{"join-alias":"Rooftop Inspection"}],"effective_type":"type/Text","id":50,"display_name":"Rooftop Inspection → Description","fingerprint":{"global":{"distinct-count":1,"nil%":0},"type":{"type/Text":{"percent-json":0,"percent-url":0,"percent-email":0,"percent-state":0,"average-length":14}}},"base_type":"type/Text"},{"semantic_type":"type/Category","coercion_strategy":null,"name":"description_2","field_ref":["field",80,{"join-alias":"Inspection"}],"effective_type":"type/Text","id":80,"display_name":"Inspection → Description","fingerprint":{"global":{"distinct-count":1,"nil%":0},"type":{"type/Text":{"percent-json":0,"percent-url":0,"percent-email":0,"percent-state":0,"average-length":30}}},"base_type":"type/Text"}]	\N
\.


--
-- Data for Name: report_cardfavorite; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.report_cardfavorite (id, created_at, updated_at, card_id, owner_id) FROM stdin;
\.


--
-- Data for Name: report_dashboard; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.report_dashboard (id, created_at, updated_at, name, description, creator_id, parameters, points_of_interest, caveats, show_in_getting_started, public_uuid, made_public_by_id, enable_embedding, embedding_params, archived, "position", collection_id, collection_position) FROM stdin;
1	2021-06-24 18:29:37.808425+00	2021-06-24 19:31:50.417177+00	Inspection Summary	\N	1	[{"name":"Inspection","slug":"inspection","id":"e38fb0ce","type":"category"},{"name":"Roof","slug":"roof","id":"bdfe2211","type":"category"}]	\N	\N	f	\N	\N	f	\N	f	\N	2	\N
\.


--
-- Data for Name: report_dashboardcard; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.report_dashboardcard (id, created_at, updated_at, "sizeX", "sizeY", "row", col, card_id, dashboard_id, parameter_mappings, visualization_settings) FROM stdin;
1	2021-06-24 18:30:29.403126+00	2021-06-24 19:31:50.344124+00	3	4	0	0	1	1	[{"parameter_id":"bdfe2211","card_id":1,"target":["dimension",["field",50,{"join-alias":"Rooftop Inspection"}]]},{"parameter_id":"e38fb0ce","card_id":1,"target":["dimension",["field",80,{"join-alias":"Inspection"}]]}]	{}
2	2021-06-24 19:03:25.912562+00	2021-06-24 19:31:50.349569+00	3	4	0	3	2	1	[{"parameter_id":"e38fb0ce","card_id":2,"target":["dimension",["field",80,{"join-alias":"Inspection"}]]},{"parameter_id":"bdfe2211","card_id":2,"target":["dimension",["field",50,{"join-alias":"Rooftop Inspection"}]]}]	{}
3	2021-06-24 19:21:53.809108+00	2021-06-24 19:31:50.353624+00	3	4	0	6	3	1	[{"parameter_id":"e38fb0ce","card_id":3,"target":["dimension",["template-tag","inspection"]]},{"parameter_id":"bdfe2211","card_id":3,"target":["dimension",["template-tag","rooftop_inspection"]]}]	{}
4	2021-06-24 19:28:02.2906+00	2021-06-24 19:31:50.35899+00	9	4	0	9	4	1	[]	{}
5	2021-06-24 19:29:37.685085+00	2021-06-24 19:31:50.363668+00	4	4	4	0	5	1	[]	{}
6	2021-06-24 19:31:50.266751+00	2021-06-24 19:31:50.368093+00	14	7	4	4	6	1	[]	{}
\.


--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) FROM stdin;
1	Card	1	1	2021-06-24 18:28:41.910824+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"# de Avarias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1]},"type":"query"},"id":1,"display":"table","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count"},"public_uuid":null}	f	t	\N
7	Card	1	1	2021-06-24 18:32:23.836955+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"# de Avarias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection"}]},"type":"query"},"id":1,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	f	\N
8	Card	1	1	2021-06-24 18:32:36.627522+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"# de Avarias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection"}]},"type":"query"},"id":1,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	f	\N
14	Card	1	1	2021-06-24 18:55:45.688336+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"# de Avarias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"breakout":[["field",57,null]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"type":"query"},"id":1,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	f	\N
18	Card	2	1	2021-06-24 19:03:12.497741+00	{"description":null,"archived":false,"collection_position":null,"table_id":11,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Inspected Area (m²)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]]},"type":"query"},"id":2,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	t	\N
21	Dashboard	1	1	2021-06-24 19:03:26.010345+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]}]}	f	f	\N
30	Dashboard	1	1	2021-06-24 19:28:02.311484+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":3,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":4,"card_id":4,"series":[]}]}	f	f	\N
31	Dashboard	1	1	2021-06-24 19:28:02.372233+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":3,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":3,"id":2,"card_id":2,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":6,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":4,"row":0,"col":9,"id":4,"card_id":4,"series":[]}]}	f	f	\N
32	Dashboard	1	1	2021-06-24 19:28:02.4024+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":3,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":3,"id":2,"card_id":2,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":6,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":4,"row":0,"col":9,"id":4,"card_id":4,"series":[]}]}	f	f	\N
34	Dashboard	1	1	2021-06-24 19:29:37.70574+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":3,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":3,"id":2,"card_id":2,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":6,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":4,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":5,"card_id":5,"series":[]}]}	f	f	\N
22	Card	3	1	2021-06-24 19:21:10.290891+00	{"description":null,"archived":false,"collection_position":null,"table_id":null,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"native","name":"Elapsed Time","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"type":"native","native":{"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE 1=1 \\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop}}]]\\n  ) \\"source\\"","template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop","display-name":"Rooftop","type":"dimension","dimension":["field",69,null]}}},"database":2},"id":3,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count","column_settings":{"[\\"name\\",\\"sum\\"]":{"time_enabled":"minutes","time_style":"HH:mm","date_abbreviate":false}}},"public_uuid":null}	f	t	\N
23	Dashboard	1	1	2021-06-24 19:21:53.833414+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":3,"card_id":3,"series":[]}]}	f	f	\N
24	Dashboard	1	1	2021-06-24 19:21:53.919601+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":3,"series":[]}]}	f	f	\N
25	Dashboard	1	1	2021-06-24 19:21:53.944972+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":3,"series":[]}]}	f	f	\N
26	Card	3	1	2021-06-24 19:22:32.014517+00	{"description":null,"archived":false,"collection_position":null,"table_id":null,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"native","name":"Elapsed Time","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"native":{"template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop_inspection":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop_inspection","display-name":"Rooftop inspection","type":"dimension","dimension":["field",50,null],"widget-type":"category"}},"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE 1=1 \\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop_inspection}}]]\\n  ) \\"source\\""},"type":"native"},"id":3,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count","column_settings":{"[\\"name\\",\\"sum\\"]":{"time_enabled":"minutes","time_style":"HH:mm","date_abbreviate":false}}},"public_uuid":null}	f	f	\N
27	Dashboard	1	1	2021-06-24 19:23:08.508662+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":3,"series":[]}]}	f	f	\N
28	Dashboard	1	1	2021-06-24 19:23:08.53707+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":3,"card_id":3,"series":[]}]}	f	f	\N
29	Card	4	1	2021-06-24 19:27:28.768675+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Damaged roof tile list","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"database":2},"id":4,"display":"table","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	t	\N
33	Card	5	1	2021-06-24 19:29:30.089875+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Damaged roof area (m²)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",61,null]]]},"database":2},"id":5,"display":"table","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	t	\N
38	Card	6	1	2021-06-24 19:31:14.002508+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Damaged tile map","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"database":2},"id":6,"display":"map","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count","map.type":"pin"},"public_uuid":null}	f	t	\N
40	Dashboard	1	1	2021-06-24 19:31:50.388134+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":3,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":3,"id":2,"card_id":2,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":6,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":4,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":4,"col":0,"id":5,"card_id":5,"series":[]},{"sizeX":14,"sizeY":7,"row":4,"col":4,"id":6,"card_id":6,"series":[]}]}	f	f	\N
35	Dashboard	1	1	2021-06-24 19:29:37.797588+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":3,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":3,"id":2,"card_id":2,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":6,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":4,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":4,"col":0,"id":5,"card_id":5,"series":[]}]}	f	f	\N
36	Dashboard	1	1	2021-06-24 19:29:37.841181+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":3,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":3,"id":2,"card_id":2,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":6,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":4,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":4,"col":0,"id":5,"card_id":5,"series":[]}]}	f	f	\N
37	Card	5	1	2021-06-24 19:29:46.608335+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Damaged roof area (m²)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",61,null]]]},"database":2},"id":5,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	f	\N
39	Dashboard	1	1	2021-06-24 19:31:50.29119+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":3,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":3,"id":2,"card_id":2,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":6,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":4,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":4,"col":0,"id":5,"card_id":5,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":6,"card_id":6,"series":[]}]}	f	f	\N
41	Dashboard	1	1	2021-06-24 19:31:50.429977+00	{"description":null,"name":"Inspection Summary","cards":[{"sizeX":3,"sizeY":4,"row":0,"col":0,"id":1,"card_id":1,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":3,"id":2,"card_id":2,"series":[]},{"sizeX":3,"sizeY":4,"row":0,"col":6,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":4,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":4,"col":0,"id":5,"card_id":5,"series":[]},{"sizeX":14,"sizeY":7,"row":4,"col":4,"id":6,"card_id":6,"series":[]}]}	f	f	\N
42	Card	1	1	2021-06-25 00:21:11.918871+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"# de Avarias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"query":{"source-table":9,"aggregation":[["count"]],"filter":["=",["field",56,null],1],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"type":"query"},"id":1,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	f	\N
43	Card	4	1	2021-06-25 00:25:38.027468+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Damaged roof tile list","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"type":"query","query":{"source-table":9,"filter":["=",["field",56,null],1],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"},{"fields":[["field",79,{"join-alias":"Rooftop"}]],"source-table":11,"condition":["=",["field",47,{"join-alias":"Rooftop Inspection"}],["field",70,{"join-alias":"Rooftop"}]],"alias":"Rooftop","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"database":2},"id":4,"display":"table","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	f	\N
44	Card	1	1	2021-06-25 00:36:30.515237+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"# de Avarias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"type":"query","query":{"source-table":9,"aggregation":[["count"]],"filter":["and",["=",["field",56,null],1],["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]],"joins":[{"fields":"all","source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}]},"database":2},"id":1,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	f	\N
45	Card	2	1	2021-06-25 00:37:18.015721+00	{"description":null,"archived":false,"collection_position":null,"table_id":11,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Inspected Area (m²)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"type":"query","query":{"source-table":11,"joins":[{"fields":"all","source-table":8,"condition":["=",["field",70,null],["field",47,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":"all","source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"aggregation":[["sum",["field",79,null]]],"filter":["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]},"database":2},"id":2,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count"},"public_uuid":null}	f	f	\N
46	Card	3	1	2021-06-25 00:39:18.62771+00	{"description":null,"archived":false,"collection_position":null,"table_id":null,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"native","name":"Elapsed Time","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"native":{"template-tags":{"inspection":{"id":"c324632f-a13f-0a67-3941-c5576b152a03","name":"inspection","display-name":"Inspection","type":"dimension","dimension":["field",80,null],"widget-type":"category"},"rooftop_inspection":{"id":"76d31601-30fb-ad81-755f-fdb84724c8bd","name":"rooftop_inspection","display-name":"Rooftop inspection","type":"dimension","dimension":["field",50,null],"widget-type":"category"}},"query":"SELECT \\n  to_char(\\n    sum(\\"source\\".\\"Duration\\"), \\n    'HH24:MI:SS'\\n  ) AS \\"sum\\" \\nFROM \\n  (\\n    SELECT \\n      \\"Rooftop Inspection\\".\\"end_time\\" AS \\"Rooftop Inspection__end_time\\", \\n      \\"Rooftop Inspection\\".\\"start_time\\" AS \\"Rooftop Inspection__start_time\\", \\n      (\\n        \\"Rooftop Inspection\\".\\"end_time\\" - \\"Rooftop Inspection\\".\\"start_time\\"\\n      ) AS \\"Duration\\" \\n    FROM \\n      \\"public\\".\\"rooftop\\" \\n      INNER JOIN \\"public\\".\\"rooftop_inspection\\" \\"Rooftop Inspection\\" ON \\"public\\".\\"rooftop\\".\\"id\\" = \\"Rooftop Inspection\\".\\"rooftop_id\\" \\n      INNER JOIN \\"public\\".\\"inspection\\" \\"Inspection\\" ON \\"Rooftop Inspection\\".\\"inspection_id\\" = \\"Inspection\\".\\"id\\"\\n    WHERE  \\"Rooftop Inspection\\".\\"rooftop_inspection_status_id\\" = 3\\n    [[AND {{inspection}}]]\\n    [[AND {{rooftop_inspection}}]]\\n  ) \\"source\\""},"type":"native"},"id":3,"display":"scalar","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count","column_settings":{"[\\"name\\",\\"sum\\"]":{"time_enabled":"minutes","time_style":"HH:mm","date_abbreviate":false}}},"public_uuid":null}	f	f	\N
47	Card	6	1	2021-06-25 00:40:27.791631+00	{"description":null,"archived":false,"collection_position":null,"table_id":9,"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Damaged tile map","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"query":{"source-table":9,"filter":["and",["=",["field",56,null],1],["=",["field",48,{"join-alias":"Rooftop Inspection"}],3]],"joins":[{"fields":[["field",50,{"join-alias":"Rooftop Inspection"}]],"source-table":8,"condition":["=",["field",57,null],["field",51,{"join-alias":"Rooftop Inspection"}]],"alias":"Rooftop Inspection","strategy":"inner-join"},{"fields":[["field",80,{"join-alias":"Inspection"}]],"source-table":14,"condition":["=",["field",78,{"join-alias":"Rooftop Inspection"}],["field",81,{"join-alias":"Inspection"}]],"alias":"Inspection","strategy":"inner-join"}],"fields":[["field",58,null],["field",59,null],["field",60,null],["field",63,null],["field",61,null],["field",62,null],["field",64,null]]},"type":"query"},"id":6,"display":"map","visualization_settings":{"table.pivot_column":"rooftop_inspection_id","table.cell_column":"count","scalar.field":"count","map.type":"pin"},"public_uuid":null}	f	f	\N
\.


--
-- Data for Name: segment; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.segment (id, table_id, creator_id, name, description, archived, definition, created_at, updated_at, points_of_interest, caveats, show_in_getting_started) FROM stdin;
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.setting (key, value) FROM stdin;
site-uuid	f384b105-16d6-4667-85c9-16e2a74e0267
redirect-all-requests-to-https	false
site-url	http://localhost:15010
site-name	analytics
admin-email	admin@gmail.com
site-locale	en
anon-tracking-enabled	true
version-info-last-checked	2021-06-24T18:15:00.010508Z
version-info	{"latest":{"version":"v0.39.4","released":"2021-06-16","patch":true,"highlights":["Javascript error when enabling JWT authentication","Switch to column settings when sidebar is already open","Questions on MongoDB return 'No results!' after upgrade from 0.38.5 to 0.39.0 when filtering against array ","Login blocked till timeout if Metabase can't reach GeoJS API","Missing tooltip for sharing individual question","Histograms should filter out null x values","Shifted chart values on line with ordinal x axis","Don't show Custom Expression helper, when input is not in focus","Dashboard filters dropdown only list the first 100 values","Cannot use arithmetic between two `case()` function in Custom Expression","LDAP login fails with Group Sync when user is assigned to 1 group","LDAP auth errors with \\"did not match stored password\\" if `givenName` or `sn` is missing","Cannot join Saved Questions that themselves contains joins","Human-reable numering not working properly","Time series filter and granularity widgets at bottom of screen are missing","LDAP group sync - LDAPException after removing user from a mapped group","Dashboard text cards aren't scrolling"]},"older":[{"version":"v0.39.3","released":"2021-05-27","patch":true,"highlights":["Feature flag causes problems with Number filters in Native query","Revoking access to users in multiple groups does not correctly cleanup GTAP","LDAP settings form hitting wrong API endpoint on save","ExpressionEditor loses value when user resizes browser window","ExpressionEditor loses value when user clicks away from associated name input","Filter dropdown not working for non-data users, when field has 300+ distinct values.","Tooltip only shows first Y-axis value when X-axis is numeric and style is Ordinal/Histogram","Gauge visualization on small screens can cause frontend refresh on hover","Serialization: `field-literal` converted to `field` since 1.39.0","Serialization dumps with static references instead of paths in 1.39.0","Fix Serialization P1s","Incorrect result + loss of user input when summarizing with Saved Question","Some places shows `{0}` placeholder instead of expected value","Serialization load-process does not update `source-table` in joins, leading to broken questions","Unchecking \\"Remember me\\" box has no effect -- close the browser and reopen, then go back to your MB instance and you're still logged in","Serialization `dump` includes Personal Collections","Serialization: Nested question references questions in other collection are moved and becomes corrupted","Serialization: Snippet folders and Collections collide on `dump` because of missing namespace separation","Serialization: Snippets are not transferred correctly, leading to incorrect references and broken queries","Serialization: Click Behavior not translating entitiy ID on dump, potentially referencing wrong entities on load","Wrong LDAP port input (non-numeric) can cause complete lockout","Nested queries using metric got wrong SQL","Cannot aggregate question with unix timestamp column that is converted/cast in Metabase","Test LDAP settings before saving","Nested queries using metrics need to include all columns used in metric filters"]},{"version":"v0.39.2","released":"2021-05-17","patch":true,"highlights":["Regression combining Druid date filters with dimension filters","Regression in filtering Druid table where greater than date","Variable Field Type after upgrade \\"Input to parse-value-to-field-type does not match schema\\"","Whitelabel favicon does not work correctly in all browsers","Show right versions on enterprise custom builds","Not possible to select pinned collection item using checkbox","The new \\"contains\\" behavior for field value lookup doesn't work outside of dashboards","Cannot restore table visibility in Data Model, when database is down","LDAP user authorization failed with `$` in password","Difficult to use some filters, when user has no data permissions [FE - Filter widget stops working if API endpoint returns 403]","Serialization: Dashboard cards are corrupted, when questions are outside of dashboard collection","Collection tree loader causes UI jump","Filters with dropdown lists uses query on the database","Login Failing for LDAP if user email isn't lowercase","Startup warning about unsupported class will impact performance","Auth Returns 400 Bad Request instead of 401 Unauthorized upon wrong credentials submission","Need better instructions for setting up Google Auth"]},{"version":"v0.39.1","released":"2021-04-27","patch":true,"highlights":["Tooltip shows incorrect values on unaggregated data with breakout","Can't use parentheses as expected in filter expressions","UI prevents adding 2 parameters to `Percentile()` function","Login logo is left-aligned on EE, when whitelabel features are enabled","No loading spinner when clicking a Collection on the home page","Tooltip on unaggregated data does not show summed value like the visualization","Table with multiple Entity Key columns incorrectly filtering on \\"Connected To\\" drill-through"]},{"version":"v0.39.0.1","released":"2021-04-20","patch":false,"highlights":["Cannot select category Field Filter in Native query on 0.39.0","map category/location to string so we can treat them like string/= in UI"]},{"version":"v0.39.0","released":"2021-04-19","patch":false,"highlights":["Strings with placeholders like {0} aren't translating correctly","Wrong tooltip labels and values for multiple series charts in dashboard","Add feature flag for the new 0.39.0 dashboard filter types","Pulse fails when visualization_settings is referring to a field-literal column","Login History not recording correct IP address","Add an ENV var setting for typeahead search","BigQuery with filter after aggregation of join table fails query with wrong alias reference on 38.x","Dashboard Textbox images are 100% width","Questions based on Saved Questions is not using the same query for date filters leading to wrong results","0.39 string translations","0.39 Docs","Add missing \\"is\\" assertions to various tests","Custom Expression autocomplete operator selection is appended to what was typed","Custom Expression formula starts with high cursor placement on Firefox","Custom Expression filter not setting the \\"Done\\" button to current state of the formula until onblur","Custom Expression editor is removing spaces too aggressive","Hitting return when modifying a custom expression incorrectly discards changes","metabase/metabase-enterprise-head Docker image doesn't have enterprise extensions","Custom expressions: UI is too wide when shown in the sidebar","Search: some results are as being in a folder which doesn't exist in the data reference","Error saving metric in data reference","Dashboard Subscription Filters: Set Parameter Values","Normalize queries in URL fragments on FE","Support string and number filter operators in dashboard parameter filters ","defsetting macro throw an Exception if you try to define a setting that's already defined in a different namespace","Fix render error when removing a dashboard parameter","Upgrade HoneySQL version to latest","Dashboard Filter Improvements (to support large-scale rollout)","SSH Connectivity Improvements","MBQL Refactor: Combine various Field clauses into one new clause"]},{"version":"v0.38.4","released":"2021-04-12","patch":true,"highlights":["Not possible to position Y-axis if there's only one series","Tooltip on unaggregated data does not show summed value like the visualization","For a new Custom column, I can set Style to \\"Currency\\", but cannot choose the Unit of Currency","Add Kyrgyz Som to currency list"]},{"version":"v0.38.3","released":"2021-04-01","patch":true,"highlights":["Overflow text on Ask a question page ","Filtering on coerced column doesn't always know its coerced","Wrong series label in multiple series scatterplot","Dashboard Subscription fails for all SQL questions with a Field Filter on date column connected on dashboard","Dashboard Subscription Emails do not work with filtered Native Queries","Dashboard Subscription sidebar broken for Sandboxed users","Provide more logging information on permission errors when creating Cards"," In Settings > Email, Save Changes is enabled even when there are no changes","Exports always uses UTC as timezone instead of the selected Report Timezone","Invalid Redirect Location After SAML Sign-in via Full App Embed","Cannot download XLSX if there's more than 1 million results","Frontend load issue: SMTP Email","Pie chart sometimes does not show total","Users with collections \\"edit\\" permissions and no data access permissions can't edit question metadata","Add Bitcoin as a unit of currency","Column \\"Custom title\\" not working in tooltips","Schema sync does not update changes in column type case","Error on visualization change of a question with SQL queries view only permission","Line chart dots don't have `cursor: pointer` when hovering"]},{"version":"v0.38.2","released":"2021-03-17","patch":true,"highlights":["Data model not showing PostgreSQL tables when they are partitioned","Migrate old pre-1.37 \\"Custom Drill-through\\" settings to x.37+ \\"Click Behavior\\"","Regression with URL links"]},{"version":"v0.38.1","released":"2021-03-03","patch":true,"highlights":["Serialization `dump` of aggregated questions are not copied over on `load`","Serialization doesn't update Sub-Query variable reference","Oracle, BigQuery filtering by column with day-of-week bucketing not working","Pivot Table export not working on unsaved questions","Pivot Table does not work for users without data permissions","Pivot Table not working with Sandboxed user","BigQuery: Joins in the query builder generate invalid table aliases","BigQuery: Question Stays running until timeout when query is error in Native Query","Serialization: Archived items are included in `dump`","Breadcrumbs can be confusing (the current one \\"seems\\" clickable when it's not)","regexextract breaks query on sandboxed table","Multi-level aggregations fails when filter is the last section","Pivot queries aren't recorded to query execution log","Start of Week not applied to Field Filter in Native question, which can lead to incorrect results","In Safari 14, add-grouping button disappears randomly but consistently","Serialization does not initialize 3rd party drivers when loading a dump","Wrong day names are displayed when using not-Sunday as start of the week and grouping by \\"Day of week\\"","Difficult to see which cells has \\"Click behavior\\" vs normal behavior","Object Detail previous/next buttons not working correctly","Global number formatting does not apply to percentages","Native question filter widget reordering doesn't work"]},{"version":"v0.38.0.1","released":"2021-02-19","patch":false,"highlights":[]},{"version":"v0.38.0","released":"2021-02-16","patch":false,"highlights":["Sandboxed question with `case` Custom Field doesn't substitute the \\"else\\" argument's table","Custom Expression using `case()` function fails when referencing the same column names","Filtering a Custom Column does not give correct results when using \\"Not equal to\\"","Cannot remove columns via QB sidebar, then query fails, but works if being removed via Notebook","fix(rotate-encryption-key) settings-last-updated is not encrypted","For Pivot Tables, download popup doesn't show","Dashboard Subscriptions: Have to click the close button multiple times after viewing a Subscription","Advanced Sandboxing ignores Data Model features like Object Detail of FK","Publish \\"latest\\" OSS JAR","Custom GeoJSON files are not sorted in the dropdown","user@password JDBC connection strings for application DB no longer work","Shrunken bubbles shown in question for null values","Drilling down by a Region Map assigns the wrong value to the filter","Using \\"Reset to defaults\\" on textbox causes it to become a corrupted card on dashboard","Add a lightweight notify api endpoint","Sandboxing on tables with remapped FK (Display Values) causes query to fail","Allow usage of PKCS-12 certificates with Postgres connections","dump-to-h2 does not return a non-zero exit code on failure","Advanced Sandboxing using questions that return more/other columns than the sandboxed table is not possible anymore, but the errors are not helpful","Bar chart x-axis positions can cause different spacing depending on the dates returned","Custom Columns breaks Pivot Table","Pivot tables broken on dashboard after resize","dump-to-h2 with --dump-plaintext should check for presence of MB_ENCRYPTION_SECRET_KEY","Right alignment of pivot table value cells looks broken","Don't inform admins about MB cloud on EE instances","add cmd rotate-encryption-key","Token check retry is too aggressive","Login page should automatically focus on the email input field","Dashboard subscriptions including cards no longer in dashboard","UI should update when a collection changes parent"]},{"version":"v0.37.9","released":"2021-02-11","patch":true,"highlights":[]},{"version":"v0.37.8","released":"2021-01-29","patch":true,"highlights":["Cannot add (date) filter if calendar is collapsed"]},{"version":"v0.37.7","released":"2021-01-20","patch":true,"highlights":[]},{"version":"v0.37.6","released":"2021-01-13","patch":true,"highlights":[]},{"version":"v0.37.5","released":"2021-01-05","patch":true,"highlights":["Linked filters breaking SQL questions on v0.37.2","Embedding loading slow","Cannot toggle off 'Automatically run queries when doing simple filtering and summarizing' "]},{"version":"v0.37.4","released":"2020-12-17","patch":true,"highlights":["Error in Query: Input to aggregation-name does not match schema","Revert #13895","Exports always uses UTC as timezone instead of the selected Report Timezone","Between Dates filter behaves inconsistently based on whether the column is from a joined table or not"]},{"version":"v0.37.3","released":"2020-12-03","patch":true,"highlights":["Fix chain filtering with temporal string params like 'last32weeks'","Linked filters breaking SQL questions on v0.37.2","Running with timezone `Europe/Moscow` shows Pulse timezone as `MT` instead of `MSK` and sends pulses on incorrect time","Order fields to dump by ID","Remove object count from log output"]},{"version":"v0.37.2","released":"2020-11-16","patch":true,"highlights":["When visualization returns `null` (No results), then UI becomes broken"]},{"version":"v0.37.1","released":"2020-11-12","patch":true,"highlights":["Table schema sync performance impact","v0.37.0.2 doesn't sync Vertica schema","Pie chart shows spinner, when returned measure/value is `null` or `0`","Wrong day names are displayed when using not-Sunday as start of the week and grouping by \\"Day of week\\"","When result row is `null`, then frontend incorrectly shows as \\"No results!\\"","Snowflake tables with a GEOGRAPHY column cannot be explored","Cannot edit BigQuery settings without providing service account JSON again","Sync crashes with OOM on very large columns/row samples [proposal]","500 stack overflow error on collection/graph API call","Custom Column after aggregation creates wrong query and fails","The expression editor shouldn't start in error mode without any user input","Pulse attachment file sent without file extension","Metric with unnamed Custom Expression breaks Data Model for table","Nested queries with duplicate column names fail","pulse attachment file(question name) Korean support problem","Pulse Bar Chart Negative Values Formatting"]},{"version":"v0.37.0.2","released":"2020-10-26","patch":false,"highlights":[]},{"version":"v0.36.8.2","released":"2020-10-26","patch":true,"highlights":[]},{"version":"v0.37.0.1","released":"2020-10-23","patch":false,"highlights":[]},{"version":"v0.36.8.1","released":"2020-10-23","patch":true,"highlights":[]},{"version":"v0.37.0","released":"2020-10-22","patch":false,"highlights":["Fix null handling in filters regression","Add translation for Bulgarian","0.37.0-rc3: Click behavior to Dashboard shown on Public/Embedded","NO_COLOR/MB_COLORIZE_LOGS does not remove all ansi codes","0.37.0-rc3: Filtering a joined table column by \\"Is not\\" or \\"Does not contain\\" fails","Update translations for final 0.37 release","0.37.0-rc2: Monday week start displays incorrectly on bar chart","0.37.0-rc2: Linked filter showing all values (not filtering)","Only get substrings in fingerprinting when supported [ci drivers]","0.37.0-rc2: log4j should not output to file by default","0.37-RC2: we should suppress drag behavior when custom click behavior is set","0.37-RC2: disable Done button in cases where click behavior target isn't specified","0.37-RC2: weird edit state when saving a dashboard with incomplete click behavior","0.37-RC2: Interactivity summary tokens squashed on small dashboard cards","0.37.0-rc2: Hovering on custom map no longer displays region name, displays region identifier instead","0.37.0-rc1: \\"Click behavior\\" to URL for non-table card, doesn't show reference fields to use as variables","0.37.0-rc1: Variables from Saved Question are referencing the same question","0.37.0-rc2: Cannot create custom drill-through to dashboard","0.37-rc1: after clicking a custom link that passes a value to a param, clicking Back shouldn't bring that value to the original dashboard","0.37-rc1: When mapping dashboard filters to columns, SQL questions should display the name of the column mapped to the field filter","0.37-rc1: customizing a dashboard card's click behavior without specifying a destination causes strange behavior","0.37-rc1: canceling the dashboard archive action takes you to the collection","Embedded versions of new chain filters endpoints ","\\"Does not contain\\" and \\"Is not\\" filter also removes nulls","Docs - 37 release - new dashboard functionality","forward slash on table name causes ORA-01424 and blocks the sync step","Update login layout and illustration.","MySQL grouping on a TIME field is not working","Field Filter variables in SQL question don’t show table name when connecting filters in dashboard","Upgrade to log4j 2.x"]},{"version":"v0.36.8","released":"2020-10-22","patch":true,"highlights":[]},{"version":"v0.36.7","released":"2020-10-09","patch":true,"highlights":["Presto not respecting SSL and always uses http instead of https","Footer (with export/fullscreen/refresh buttons) on Public/Embedded questions disappears when using Premium Embedding","Postgres sync not respecting SSH tunneling"]},{"version":"v0.36.6","released":"2020-09-15T22:58:04.727Z","patch":true,"highlights":["Various bug fixes"]},{"version":"v0.36.5.1","released":"2020-09-11T23:16:26.199Z","patch":true,"highlights":["Remappings should work on broken out fields"]},{"version":"v0.36.4","released":"2020-08-17T22:41:20.449Z","patch":true,"highlights":["Various bug fixes"]},{"version":"v0.36.3","released":"2020-08-04T23:57:45.595Z","patch":true,"highlights":["Support for externally linked tables"]},{"version":"v0.36.2","released":"2020-07-31T17:46:34.479Z","patch":true,"highlights":["Various bug fixes"]},{"version":"v0.36.1","released":"2020-07-30T18:10:44.459Z","patch":true,"highlights":["Various bug fixes"]},{"version":"v0.36.0","released":"2020-07-21T19:56:40.066Z","patch":false,"highlights":["SQL/native query snippets","Language selection"]},{"version":"v0.35.4","released":"2020-05-29T17:31:58.191Z","patch":true,"highlights":["Security fix for BigQuery and SparkSQL","Turkish translation available again","More than 20 additional bug fixes and enhancements"]},{"version":"v0.35.3","released":"2020-04-21T21:18:24.959Z","patch":true,"highlights":["Various bug fixes"]},{"version":"v0.35.2","released":"2020-04-10T23:03:53.756Z","patch":true,"highlights":["Fix email and premium embedding settings","Fix table permissions for database without a schema","Fix \\"Error reducing result rows\\" error"]},{"version":"v0.35.1","released":"2020-04-02T21:52:06.867Z","patch":true,"highlights":["Issue with date field filters after v0.35.0 upgrade","Unable to filter on manually JOINed table"]},{"version":"v0.35.0","released":"2020-03-25T18:29:17.286Z","patch":false,"highlights":["Filter expressions, string extracts, and more","Reference saved questions in your SQL queries","Performance improvements"]},{"version":"v0.34.3","released":"2020-02-25T20:47:03.897Z","patch":true,"highlights":["Line, area, bar, combo, and scatter charts now allow a maximum of 100 series instead of 20.","Chart labels now have more options to show significant decimal values.","Various bug fixes"]},{"version":"v0.34.2","released":"2020-02-05T22:02:15.277Z","patch":true,"highlights":["Various bug fixes"]},{"version":"v0.34.1","released":"2020-01-14T00:02:42.489Z","patch":true,"highlights":["Various bug fixes"]},{"version":"v0.34.0","released":"2019-12-20T01:21:39.568Z","patch":false,"highlights":["Added support for variables and field filters in native Mongo queries","Added option to display data values on Line, Bar, and Area charts","Many Timezone fixes"]},{"version":"v0.33.7.3","released":"2019-12-17T01:45:45.720Z","patch":true,"highlights":["Important security fix for Google Auth login"]},{"version":"v0.33.7","released":"2019-12-13T20:35:14.667Z","patch":true,"highlights":["Important security fix for Google Auth login"]},{"version":"v0.33.6","released":"2019-11-19T20:35:14.667Z","patch":true,"highlights":["Fixed regression that could cause saved questions to fail to render (#11297)","Fixed regression where No Results icon didn't show (#11282)","Pie chart visual improvements (#10837)"]},{"version":"v0.33.5","released":"2019-11-08T20:35:14.667Z","patch":true,"highlights":["Added Slovak translation","Fixed support for MySQL 8 with the default authentication method","Fixed issues with X-axis label formatting in timeseries charts"]},{"version":"v0.33.4","released":"2019-10-08T20:35:14.667Z","patch":true,"highlights":["Custom expression support for joined columns","Fixed issue with filtering by month-of-year in MongoDB","Misc Bug Fixes"]},{"version":"v0.33.3","released":"2019-09-20T08:09:36.358Z","patch":true,"highlights":["Chinese and Persian translations now available again","Misc Bug Fixes "]},{"version":"v0.33.2","released":"2019-09-04T08:09:36.358Z","patch":true,"highlights":["Fixed Cards not saving","Fixed searrch not working "]},{"version":"v0.33.1","released":"2019-09-04T08:09:36.358Z","patch":true,"highlights":["Fixed conditional formatting not working","Fixed an issue where some previously saved column settings were not applied ","Fixed an issue where pulses were not loading "]},{"version":"v0.33.0","released":"2019-08-19T08:09:36.358Z","patch":false,"highlights":["Notebook mode + Simple Query Mode","Joins","Post Aggregation filters"]},{"version":"v0.32.10","released":"2019-07-28T08:09:36.358Z","patch":true,"highlights":["Fix User can't logout / gets automatically logged in.","Fix No data displayed when pivoting data","Fixed Dashboard Filters on Linked Entities Broke"]},{"version":"v0.32.9","released":"2019-06-14T08:09:36.358Z","patch":true,"highlights":["Fix issues connecting to MongoDB Atlas Cluster","Fix database addition on setup","Fixed numeric category error with Postgres"]},{"version":"v0.32.8","released":"2019-05-13T08:09:36.358Z","patch":true,"highlights":["Fix i18n"]},{"version":"v0.32.7","released":"2019-05-09T08:09:36.358Z","patch":true,"highlights":["Fix published SHA Hash"]},{"version":"v0.32.6","released":"2019-05-08T12:09:36.358Z","patch":true,"highlights":["Fixed regression where Dashboards would fail to fully populate","Performance improvements when running queries","Security improvements"]},{"version":"v0.32.5","released":"2019-04-20T12:09:36.358Z","patch":true,"highlights":["Improve long-running query handling","Fix H2 to MySQL/Postgres migration issue","Fix issue with embedded maps with custom GeoJSON"]},{"version":"v0.32.4","released":"2019-04-09T12:09:36.358Z","patch":true,"highlights":["Fix issue where Google Auth login did not work","FFix issue where Google Auth login did not work"]},{"version":"v0.32.3","released":"2019-04-08T12:09:36.358Z","patch":true,"highlights":["Fixed Snowflake connection issues","Fixed Dashboard copy","Fixed non-root context logins"]},{"version":"v0.32.2","released":"2019-04-03T12:09:36.358Z","patch":true,"highlights":["Fixed dashboard date filters ","Fixed SSL error using Quartz w/ MySQL","Fix colors in dashboards"]},{"version":"v0.32.1","released":"2019-03-29T12:09:36.358Z","patch":true,"highlights":["Fixed MySQL connections with SSL","Fixed table sync issue"]},{"version":"v0.32.0","released":"2019-03-28T12:09:36.358Z","patch":false,"highlights":["Modular Drivers (reducing memory consumption)","Async queries (improving responsiveness)","Reduced memory consumption."]},{"version":"v0.31.2","released":"2018-12-07T12:09:36.358Z","patch":true,"highlights":["Added German translation","Fixed Heroku out-of-memory errors","Fixed issue with Slack-based Pulses due to rate limiting."]},{"version":"v0.31.1","released":"2018-11-21T12:09:36.358Z","patch":true,"highlights":["Ability to clone dashboards","Faster startup time and lower memory consumption","Migration issue fixes."]},{"version":"v0.31.0","released":"2018-11-08T12:09:36.358Z","patch":false,"highlights":["New visualizations and combo charts","Granular formatting controls","Snowflake Support"]},{"version":"v0.30.4","released":"2018-09-27T12:09:36.358Z","patch":true,"highlights":["Metabase fails to launch in Chinese","Fix token status checking","Fix BigQuery SQL parameters with encrypted DB details"]},{"version":"v0.30.3","released":"2018-09-13T12:09:36.358Z","patch":true,"highlights":["Localization for Chinese, Japanese, Turkish, Persian","Self referencing FK leads to exception","Security improvements"]},{"version":"v0.30.2","released":"2018-09-06T12:09:36.358Z","patch":true,"highlights":["Localization for French + Norwegian","Stability fixes for HTTP/2"]},{"version":"v0.30.1","released":"2018-08-08T12:09:36.358Z","patch":true,"highlights":["Localization for Portuguese","Timezone fix","SQL Template tag re-ordering fix"]},{"version":"v0.30.0","released":"2018-08-08T12:09:36.358Z","patch":false,"highlights":["App wide search","Enhanced Collection permissions","Comparison X-Rays"]},{"version":"v0.29.3","released":"2018-05-12T12:09:36.358Z","patch":true,"highlights":["Fix X-ray rules loading on Oracle JVM 8"]},{"version":"v0.29.2","released":"2018-05-10T12:09:36.358Z","patch":true,"highlights":["Fix Spark Driver"]},{"version":"v0.29.1","released":"2018-05-10T11:09:36.358Z","patch":true,"highlights":["Better heroku memory consumption","Fixed X-Ray Bugs","Drill through from line chart selects wrong date"]},{"version":"v0.29.0","released":"2018-05-01T11:09:36.358Z","patch":false,"highlights":["New and Improved X-Rays","Search field values","Spark SQL Support"]},{"version":"v0.28.6","released":"2018-04-12T11:09:36.358Z","patch":true,"highlights":["Fix chart rendering in pulses"]},{"version":"v0.28.5","released":"2018-04-04T11:09:36.358Z","patch":true,"highlights":["Fix memory consumption for SQL templates","Fix public dashboards parameter validation","Fix Unable to add cards to dashboards or search for cards, StackOverflowError on backend"]},{"version":"v0.28.4","released":"2018-03-29T11:09:36.358Z","patch":true,"highlights":["Fix broken embedded dashboards","Fix migration regression","Fix input typing bug"]},{"version":"v0.28.3","released":"2018-03-23T11:09:36.358Z","patch":true,"highlights":["Security improvements"]},{"version":"v0.28.2","released":"2018-03-20T11:09:36.358Z","patch":true,"highlights":["Security improvements","Sort on custom and saved metrics","Performance improvements for large numbers of questions and dashboards"]},{"version":"v0.28.1","released":"2018-02-09T11:09:36.358Z","patch":true,"highlights":["Fix admin panel update string","Fix pulse rendering bug","Fix CSV & XLS download bug"]},{"version":"v0.28.0","released":"2018-02-07T11:09:36.358Z","patch":false,"highlights":["Text Cards in Dashboards","Pulse + Alert attachments","Performance Improvements"]},{"version":"v0.27.2","released":"2017-12-12T11:09:36.358Z","patch":true,"highlights":["Migration bug fix"]},{"version":"v0.27.1","released":"2017-12-01T11:09:36.358Z","patch":true,"highlights":["Migration bug fix","Apply filters to embedded downloads"]},{"version":"v0.27.0","released":"2017-11-27T11:09:36.358Z","patch":false,"highlights":["Alerts","X-Ray insights","Charting improvements"]},{"version":"v0.26.2","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Update Redshift Driver","Support Java 9","Fix performance issue with fields listing"]},{"version":"v0.26.1","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Fix migration issue on MySQL"]},{"version":"v0.26.0","released":"2017-09-26T11:09:36.358Z","patch":true,"highlights":["Segment + Metric X-Rays and Comparisons","Better control over metadata introspection process","Improved Timezone support and bug fixes"]},{"version":"v0.25.2","released":"2017-08-09T11:09:36.358Z","patch":true,"highlights":["Bug and performance fixes"]},{"version":"v0.25.1","released":"2017-07-27T11:09:36.358Z","patch":true,"highlights":["After upgrading to 0.25, unknown protocol error.","Don't show saved questions in the permissions database lists","Elastic beanstalk upgrades broken in 0.25 "]},{"version":"v0.25.0","released":"2017-07-25T11:09:36.358Z","patch":false,"highlights":["Nested questions","Enum and custom remapping support","LDAP authentication support"]},{"version":"v0.24.2","released":"2017-06-01T11:09:36.358Z","patch":true,"highlights":["Misc Bug fixes"]},{"version":"v0.24.1","released":"2017-05-10T11:09:36.358Z","patch":true,"highlights":["Fix upgrades with MySQL/Mariadb"]},{"version":"v0.24.0","released":"2017-05-10T11:09:36.358Z","patch":false,"highlights":["Drill-through + Actions","Result Caching","Presto Driver"]},{"version":"v0.23.1","released":"2017-03-30T11:09:36.358Z","patch":true,"highlights":["Filter widgets for SQL Template Variables","Fix spurious startup error","Java 7 startup bug fixed"]},{"version":"v0.23.0","released":"2017-03-21T11:09:36.358Z","patch":false,"highlights":["Public links for cards + dashboards","Embedding cards + dashboards in other applications","Encryption of database credentials"]},{"version":"v0.22.2","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["Fix startup on OpenJDK 7"]},{"version":"v0.22.1","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["IMPORTANT: Closed a Collections Permissions security hole","Improved startup performance","Bug fixes"]},{"version":"v0.22.0","released":"2017-01-10T11:09:36.358Z","patch":false,"highlights":["Collections + Collections Permissions","Multiple Aggregations","Custom Expressions"]},{"version":"v0.21.1","released":"2016-12-08T11:09:36.358Z","patch":true,"highlights":["BigQuery bug fixes","Charting bug fixes"]},{"version":"v0.21.0","released":"2016-12-08T11:09:36.358Z","patch":false,"highlights":["Google Analytics Driver","Vertica Driver","Better Time + Date Filters"]},{"version":"v0.20.3","released":"2016-10-26T11:09:36.358Z","patch":true,"highlights":["Fix H2->MySQL/PostgreSQL migrations, part 2"]},{"version":"v0.20.2","released":"2016-10-25T11:09:36.358Z","patch":true,"highlights":["Support Oracle 10+11","Fix H2->MySQL/PostgreSQL migrations","Revision timestamp fix"]},{"version":"v0.20.1","released":"2016-10-18T11:09:36.358Z","patch":true,"highlights":["Lots of bug fixes"]},{"version":"v0.20.0","released":"2016-10-11T11:09:36.358Z","patch":false,"highlights":["Data access permissions","Oracle Driver","Charting improvements"]},{"version":"v0.19.3","released":"2016-08-12T11:09:36.358Z","patch":true,"highlights":["fix Dashboard editing header"]},{"version":"v0.19.2","released":"2016-08-10T11:09:36.358Z","patch":true,"highlights":["fix Dashboard chart titles","fix pin map saving"]},{"version":"v0.19.1","released":"2016-08-04T11:09:36.358Z","patch":true,"highlights":["fix Dashboard Filter Editing","fix CSV Download of SQL Templates","fix Metabot enabled toggle"]},{"version":"v0.19.0","released":"2016-08-01T21:09:36.358Z","patch":false,"highlights":["SSO via Google Accounts","SQL Templates","Better charting controls"]},{"version":"v0.18.1","released":"2016-06-29T21:09:36.358Z","patch":true,"highlights":["Fix for Hour of day sorting bug","Fix for Column ordering bug in BigQuery","Fix for Mongo charting bug"]},{"version":"v0.18.0","released":"2016-06-022T21:09:36.358Z","patch":false,"highlights":["Dashboard Filters","Crate.IO Support","Checklist for Metabase Admins","Converting Metabase Questions -> SQL"]},{"version":"v0.17.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fix for Line chart ordering bug","Fix for Time granularity bugs"]},{"version":"v0.17.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Tags + Search for Saved Questions","Calculated columns","Faster Syncing of Metadata","Lots of database driver improvements and bug fixes"]},{"version":"v0.16.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fixes for several time alignment issues (timezones)","Resolved problem with SQL Server db connections"]},{"version":"v0.16.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Fullscreen (and fabulous) Dashboards","Say hello to Metabot in Slack"]}]}
settings-last-updated	2021-06-24 18:15:01.378326+00
\.


--
-- Data for Name: task_history; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.task_history (id, task, db_id, started_at, ended_at, duration, task_details) FROM stdin;
1	sync	1	2021-06-22 03:10:40.695225+00	2021-06-22 03:10:42.091221+00	1395	\N
2	sync-timezone	1	2021-06-22 03:10:40.697355+00	2021-06-22 03:10:41.246712+00	549	{"timezone-id":"UTC"}
3	sync-tables	1	2021-06-22 03:10:41.247384+00	2021-06-22 03:10:41.414778+00	167	{"updated-tables":4,"total-tables":0}
4	sync-fields	1	2021-06-22 03:10:41.414869+00	2021-06-22 03:10:41.7888+00	373	{"total-fields":36,"updated-fields":36}
5	sync-fks	1	2021-06-22 03:10:41.788857+00	2021-06-22 03:10:41.866766+00	77	{"total-fks":3,"updated-fks":3,"total-failed":0}
6	sync-metabase-metadata	1	2021-06-22 03:10:41.866969+00	2021-06-22 03:10:42.091171+00	224	\N
7	analyze	1	2021-06-22 03:10:42.169307+00	2021-06-22 03:10:44.819759+00	2650	\N
8	fingerprint-fields	1	2021-06-22 03:10:42.169355+00	2021-06-22 03:10:44.611023+00	2441	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":32,"fingerprints-attempted":32}
9	classify-fields	1	2021-06-22 03:10:44.611283+00	2021-06-22 03:10:44.794086+00	182	{"fields-classified":32,"fields-failed":0}
10	classify-tables	1	2021-06-22 03:10:44.794138+00	2021-06-22 03:10:44.819678+00	25	{"total-tables":4,"tables-classified":4}
11	field values scanning	1	2021-06-22 03:10:44.83977+00	2021-06-22 03:10:45.434144+00	594	\N
12	update-field-values	1	2021-06-22 03:10:44.839806+00	2021-06-22 03:10:45.434095+00	594	{"errors":0,"created":5,"updated":0,"deleted":0}
13	sync	1	2021-06-22 03:50:00.030342+00	2021-06-22 03:50:00.281686+00	251	\N
14	sync-timezone	1	2021-06-22 03:50:00.03039+00	2021-06-22 03:50:00.035312+00	4	{"timezone-id":"UTC"}
15	sync-tables	1	2021-06-22 03:50:00.035365+00	2021-06-22 03:50:00.050475+00	15	{"updated-tables":0,"total-tables":4}
16	sync-fields	1	2021-06-22 03:50:00.050526+00	2021-06-22 03:50:00.111443+00	60	{"total-fields":36,"updated-fields":0}
17	sync-fks	1	2021-06-22 03:50:00.111624+00	2021-06-22 03:50:00.128772+00	17	{"total-fks":3,"updated-fks":0,"total-failed":0}
18	sync-metabase-metadata	1	2021-06-22 03:50:00.128827+00	2021-06-22 03:50:00.281646+00	152	\N
19	analyze	1	2021-06-22 03:50:00.297684+00	2021-06-22 03:50:00.323834+00	26	\N
20	fingerprint-fields	1	2021-06-22 03:50:00.29772+00	2021-06-22 03:50:00.312203+00	14	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
21	classify-fields	1	2021-06-22 03:50:00.312258+00	2021-06-22 03:50:00.319031+00	6	{"fields-classified":0,"fields-failed":0}
22	classify-tables	1	2021-06-22 03:50:00.319081+00	2021-06-22 03:50:00.323774+00	4	{"total-tables":4,"tables-classified":0}
23	task-history-cleanup	\N	2021-06-22 04:00:00.03+00	2021-06-22 04:00:00.032+00	2	\N
24	send-pulses	\N	2021-06-22 04:00:00.021+00	2021-06-22 04:00:00.032+00	11	\N
25	sync	1	2021-06-22 04:50:00.020498+00	2021-06-22 04:50:00.254761+00	234	\N
26	sync-timezone	1	2021-06-22 04:50:00.020536+00	2021-06-22 04:50:00.024939+00	4	{"timezone-id":"UTC"}
27	sync-tables	1	2021-06-22 04:50:00.024999+00	2021-06-22 04:50:00.033539+00	8	{"updated-tables":0,"total-tables":4}
28	sync-fields	1	2021-06-22 04:50:00.03359+00	2021-06-22 04:50:00.090761+00	57	{"total-fields":36,"updated-fields":0}
29	sync-fks	1	2021-06-22 04:50:00.090815+00	2021-06-22 04:50:00.101207+00	10	{"total-fks":3,"updated-fks":0,"total-failed":0}
30	sync-metabase-metadata	1	2021-06-22 04:50:00.101277+00	2021-06-22 04:50:00.25465+00	153	\N
31	analyze	1	2021-06-22 04:50:00.266908+00	2021-06-22 04:50:00.292169+00	25	\N
32	fingerprint-fields	1	2021-06-22 04:50:00.266943+00	2021-06-22 04:50:00.278912+00	11	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
33	classify-fields	1	2021-06-22 04:50:00.278977+00	2021-06-22 04:50:00.287001+00	8	{"fields-classified":0,"fields-failed":0}
34	classify-tables	1	2021-06-22 04:50:00.287178+00	2021-06-22 04:50:00.292114+00	4	{"total-tables":4,"tables-classified":0}
35	send-pulses	\N	2021-06-22 05:00:00.009+00	2021-06-22 05:00:00.017+00	8	\N
36	task-history-cleanup	\N	2021-06-22 05:00:00.028+00	2021-06-22 05:00:00.029+00	1	\N
37	send-pulses	\N	2021-06-23 23:04:41.668+00	2021-06-23 23:04:41.695+00	27	\N
38	task-history-cleanup	\N	2021-06-23 23:04:41.684+00	2021-06-23 23:04:41.691+00	7	\N
39	sync	1	2021-06-23 23:20:00.023658+00	2021-06-23 23:20:00.741061+00	717	\N
40	sync-timezone	1	2021-06-23 23:20:00.024719+00	2021-06-23 23:20:00.366961+00	342	{"timezone-id":"UTC"}
41	sync-tables	1	2021-06-23 23:20:00.367442+00	2021-06-23 23:20:00.420953+00	53	{"updated-tables":0,"total-tables":4}
42	sync-fields	1	2021-06-23 23:20:00.421087+00	2021-06-23 23:20:00.575372+00	154	{"total-fields":36,"updated-fields":0}
43	sync-fks	1	2021-06-23 23:20:00.57543+00	2021-06-23 23:20:00.593227+00	17	{"total-fks":3,"updated-fks":0,"total-failed":0}
44	sync-metabase-metadata	1	2021-06-23 23:20:00.593299+00	2021-06-23 23:20:00.741018+00	147	\N
45	analyze	1	2021-06-23 23:20:00.812+00	2021-06-23 23:20:00.851832+00	39	\N
46	fingerprint-fields	1	2021-06-23 23:20:00.81203+00	2021-06-23 23:20:00.833822+00	21	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
47	classify-fields	1	2021-06-23 23:20:00.833878+00	2021-06-23 23:20:00.841536+00	7	{"fields-classified":0,"fields-failed":0}
48	classify-tables	1	2021-06-23 23:20:00.841613+00	2021-06-23 23:20:00.851767+00	10	{"total-tables":4,"tables-classified":0}
49	send-pulses	\N	2021-06-24 00:00:00.009+00	2021-06-24 00:00:00.023+00	14	\N
50	task-history-cleanup	\N	2021-06-24 00:00:00.027+00	2021-06-24 00:00:00.029+00	2	\N
51	sync	1	2021-06-24 00:20:00.019509+00	2021-06-24 00:20:00.228186+00	208	\N
52	sync-timezone	1	2021-06-24 00:20:00.019535+00	2021-06-24 00:20:00.035403+00	15	{"timezone-id":"UTC"}
53	sync-tables	1	2021-06-24 00:20:00.035463+00	2021-06-24 00:20:00.046858+00	11	{"updated-tables":0,"total-tables":4}
54	sync-fields	1	2021-06-24 00:20:00.046904+00	2021-06-24 00:20:00.110785+00	63	{"total-fields":36,"updated-fields":0}
55	sync-fks	1	2021-06-24 00:20:00.110825+00	2021-06-24 00:20:00.119691+00	8	{"total-fks":3,"updated-fks":0,"total-failed":0}
56	sync-metabase-metadata	1	2021-06-24 00:20:00.119735+00	2021-06-24 00:20:00.228151+00	108	\N
57	analyze	1	2021-06-24 00:20:00.239247+00	2021-06-24 00:20:00.256897+00	17	\N
58	fingerprint-fields	1	2021-06-24 00:20:00.23927+00	2021-06-24 00:20:00.248953+00	9	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
59	classify-fields	1	2021-06-24 00:20:00.249+00	2021-06-24 00:20:00.253153+00	4	{"fields-classified":0,"fields-failed":0}
60	classify-tables	1	2021-06-24 00:20:00.253211+00	2021-06-24 00:20:00.256859+00	3	{"total-tables":4,"tables-classified":0}
61	send-pulses	\N	2021-06-24 01:00:00.006+00	2021-06-24 01:00:00.014+00	8	\N
62	task-history-cleanup	\N	2021-06-24 01:00:00.016+00	2021-06-24 01:00:00.017+00	1	\N
63	sync	1	2021-06-24 01:20:00.026185+00	2021-06-24 01:20:00.19657+00	170	\N
64	sync-timezone	1	2021-06-24 01:20:00.026208+00	2021-06-24 01:20:00.029852+00	3	{"timezone-id":"UTC"}
65	sync-tables	1	2021-06-24 01:20:00.029896+00	2021-06-24 01:20:00.039987+00	10	{"updated-tables":0,"total-tables":4}
66	sync-fields	1	2021-06-24 01:20:00.040038+00	2021-06-24 01:20:00.096615+00	56	{"total-fields":36,"updated-fields":0}
67	sync-fks	1	2021-06-24 01:20:00.096652+00	2021-06-24 01:20:00.10406+00	7	{"total-fks":3,"updated-fks":0,"total-failed":0}
68	sync-metabase-metadata	1	2021-06-24 01:20:00.104108+00	2021-06-24 01:20:00.19653+00	92	\N
69	analyze	1	2021-06-24 01:20:00.206254+00	2021-06-24 01:20:00.223248+00	16	\N
70	fingerprint-fields	1	2021-06-24 01:20:00.206274+00	2021-06-24 01:20:00.215188+00	8	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
71	classify-fields	1	2021-06-24 01:20:00.215233+00	2021-06-24 01:20:00.219663+00	4	{"fields-classified":0,"fields-failed":0}
72	classify-tables	1	2021-06-24 01:20:00.219706+00	2021-06-24 01:20:00.22321+00	3	{"total-tables":4,"tables-classified":0}
73	send-pulses	\N	2021-06-24 02:00:00.012+00	2021-06-24 02:00:00.015+00	3	\N
74	task-history-cleanup	\N	2021-06-24 02:00:00.021+00	2021-06-24 02:00:00.022+00	1	\N
75	sync	1	2021-06-24 02:20:00.010674+00	2021-06-24 02:20:00.166615+00	155	\N
76	sync-timezone	1	2021-06-24 02:20:00.010696+00	2021-06-24 02:20:00.013499+00	2	{"timezone-id":"UTC"}
77	sync-tables	1	2021-06-24 02:20:00.013537+00	2021-06-24 02:20:00.021076+00	7	{"updated-tables":0,"total-tables":4}
78	sync-fields	1	2021-06-24 02:20:00.021116+00	2021-06-24 02:20:00.070148+00	49	{"total-fields":36,"updated-fields":0}
79	sync-fks	1	2021-06-24 02:20:00.070189+00	2021-06-24 02:20:00.07827+00	8	{"total-fks":3,"updated-fks":0,"total-failed":0}
84	classify-tables	1	2021-06-24 02:20:00.200644+00	2021-06-24 02:20:00.20383+00	3	{"total-tables":4,"tables-classified":0}
111	send-pulses	\N	2021-06-24 05:00:00.012+00	2021-06-24 05:00:00.014+00	2	\N
80	sync-metabase-metadata	1	2021-06-24 02:20:00.078338+00	2021-06-24 02:20:00.166585+00	88	\N
81	analyze	1	2021-06-24 02:20:00.176548+00	2021-06-24 02:20:00.203863+00	27	\N
82	fingerprint-fields	1	2021-06-24 02:20:00.176565+00	2021-06-24 02:20:00.185769+00	9	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
83	classify-fields	1	2021-06-24 02:20:00.185811+00	2021-06-24 02:20:00.200599+00	14	{"fields-classified":0,"fields-failed":0}
85	send-pulses	\N	2021-06-24 03:00:00.005+00	2021-06-24 03:00:00.009+00	4	\N
86	task-history-cleanup	\N	2021-06-24 03:00:00.013+00	2021-06-24 03:00:00.014+00	1	\N
89	sync	1	2021-06-24 03:20:00.011799+00	2021-06-24 03:20:00.165213+00	153	\N
91	sync-tables	1	2021-06-24 03:20:00.014828+00	2021-06-24 03:20:00.021965+00	7	{"updated-tables":0,"total-tables":4}
93	sync-fks	1	2021-06-24 03:20:00.073928+00	2021-06-24 03:20:00.080909+00	6	{"total-fks":3,"updated-fks":0,"total-failed":0}
99	send-pulses	\N	2021-06-24 04:00:00.014+00	2021-06-24 04:00:00.017+00	3	\N
100	task-history-cleanup	\N	2021-06-24 04:00:00.021+00	2021-06-24 04:00:00.022+00	1	\N
101	sync	1	2021-06-24 04:20:00.022664+00	2021-06-24 04:20:00.19539+00	172	\N
102	sync-timezone	1	2021-06-24 04:20:00.022692+00	2021-06-24 04:20:00.032537+00	9	{"timezone-id":"UTC"}
103	sync-tables	1	2021-06-24 04:20:00.032595+00	2021-06-24 04:20:00.048336+00	15	{"updated-tables":0,"total-tables":4}
104	sync-fields	1	2021-06-24 04:20:00.048381+00	2021-06-24 04:20:00.095576+00	47	{"total-fields":36,"updated-fields":0}
105	sync-fks	1	2021-06-24 04:20:00.095614+00	2021-06-24 04:20:00.104987+00	9	{"total-fks":3,"updated-fks":0,"total-failed":0}
106	sync-metabase-metadata	1	2021-06-24 04:20:00.105032+00	2021-06-24 04:20:00.195358+00	90	\N
107	analyze	1	2021-06-24 04:20:00.207005+00	2021-06-24 04:20:00.222002+00	14	\N
108	fingerprint-fields	1	2021-06-24 04:20:00.207024+00	2021-06-24 04:20:00.215184+00	8	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
109	classify-fields	1	2021-06-24 04:20:00.215224+00	2021-06-24 04:20:00.219004+00	3	{"fields-classified":0,"fields-failed":0}
110	classify-tables	1	2021-06-24 04:20:00.219043+00	2021-06-24 04:20:00.221975+00	2	{"total-tables":4,"tables-classified":0}
112	task-history-cleanup	\N	2021-06-24 05:00:00.025+00	2021-06-24 05:00:00.03+00	5	\N
115	sync-tables	1	2021-06-24 05:20:00.032633+00	2021-06-24 05:20:00.038819+00	6	{"updated-tables":0,"total-tables":4}
117	sync-fks	1	2021-06-24 05:20:00.080149+00	2021-06-24 05:20:00.086981+00	6	{"total-fks":3,"updated-fks":0,"total-failed":0}
121	classify-fields	1	2021-06-24 05:20:00.185039+00	2021-06-24 05:20:00.189327+00	4	{"fields-classified":0,"fields-failed":0}
87	field values scanning	1	2021-06-24 03:00:00.032673+00	2021-06-24 03:00:01.416349+00	1383	\N
88	update-field-values	1	2021-06-24 03:00:00.032695+00	2021-06-24 03:00:01.416319+00	1383	{"errors":0,"created":0,"updated":0,"deleted":0}
90	sync-timezone	1	2021-06-24 03:20:00.011825+00	2021-06-24 03:20:00.014685+00	2	{"timezone-id":"UTC"}
92	sync-fields	1	2021-06-24 03:20:00.022013+00	2021-06-24 03:20:00.07389+00	51	{"total-fields":36,"updated-fields":0}
94	sync-metabase-metadata	1	2021-06-24 03:20:00.080956+00	2021-06-24 03:20:00.165184+00	84	\N
95	analyze	1	2021-06-24 03:20:00.17359+00	2021-06-24 03:20:00.188832+00	15	\N
96	fingerprint-fields	1	2021-06-24 03:20:00.173607+00	2021-06-24 03:20:00.181227+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
97	classify-fields	1	2021-06-24 03:20:00.181271+00	2021-06-24 03:20:00.185878+00	4	{"fields-classified":0,"fields-failed":0}
98	classify-tables	1	2021-06-24 03:20:00.185922+00	2021-06-24 03:20:00.1888+00	2	{"total-tables":4,"tables-classified":0}
113	sync	1	2021-06-24 05:20:00.029015+00	2021-06-24 05:20:00.168447+00	139	\N
114	sync-timezone	1	2021-06-24 05:20:00.029033+00	2021-06-24 05:20:00.032586+00	3	{"timezone-id":"UTC"}
116	sync-fields	1	2021-06-24 05:20:00.038856+00	2021-06-24 05:20:00.080113+00	41	{"total-fields":36,"updated-fields":0}
118	sync-metabase-metadata	1	2021-06-24 05:20:00.087024+00	2021-06-24 05:20:00.168421+00	81	\N
119	analyze	1	2021-06-24 05:20:00.177751+00	2021-06-24 05:20:00.191846+00	14	\N
120	fingerprint-fields	1	2021-06-24 05:20:00.177765+00	2021-06-24 05:20:00.185004+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
122	classify-tables	1	2021-06-24 05:20:00.189359+00	2021-06-24 05:20:00.191823+00	2	{"total-tables":4,"tables-classified":0}
123	send-pulses	\N	2021-06-24 06:00:00.01+00	2021-06-24 06:00:00.013+00	3	\N
124	task-history-cleanup	\N	2021-06-24 06:00:00.018+00	2021-06-24 06:00:00.019+00	1	\N
125	sync	1	2021-06-24 06:20:00.010001+00	2021-06-24 06:20:00.163355+00	153	\N
126	sync-timezone	1	2021-06-24 06:20:00.010017+00	2021-06-24 06:20:00.013688+00	3	{"timezone-id":"UTC"}
127	sync-tables	1	2021-06-24 06:20:00.013749+00	2021-06-24 06:20:00.020572+00	6	{"updated-tables":0,"total-tables":4}
128	sync-fields	1	2021-06-24 06:20:00.020611+00	2021-06-24 06:20:00.06321+00	42	{"total-fields":36,"updated-fields":0}
129	sync-fks	1	2021-06-24 06:20:00.063245+00	2021-06-24 06:20:00.072113+00	8	{"total-fks":3,"updated-fks":0,"total-failed":0}
130	sync-metabase-metadata	1	2021-06-24 06:20:00.07216+00	2021-06-24 06:20:00.163332+00	91	\N
131	analyze	1	2021-06-24 06:20:00.172956+00	2021-06-24 06:20:00.188273+00	15	\N
132	fingerprint-fields	1	2021-06-24 06:20:00.172971+00	2021-06-24 06:20:00.181415+00	8	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
133	classify-fields	1	2021-06-24 06:20:00.181456+00	2021-06-24 06:20:00.185378+00	3	{"fields-classified":0,"fields-failed":0}
134	classify-tables	1	2021-06-24 06:20:00.185418+00	2021-06-24 06:20:00.188246+00	2	{"total-tables":4,"tables-classified":0}
135	send-pulses	\N	2021-06-24 07:00:00.011+00	2021-06-24 07:00:00.013+00	2	\N
136	task-history-cleanup	\N	2021-06-24 07:00:00.018+00	2021-06-24 07:00:00.019+00	1	\N
137	sync	1	2021-06-24 07:20:00.027241+00	2021-06-24 07:20:00.174461+00	147	\N
138	sync-timezone	1	2021-06-24 07:20:00.027263+00	2021-06-24 07:20:00.031922+00	4	{"timezone-id":"UTC"}
139	sync-tables	1	2021-06-24 07:20:00.031975+00	2021-06-24 07:20:00.037948+00	5	{"updated-tables":0,"total-tables":4}
140	sync-fields	1	2021-06-24 07:20:00.03798+00	2021-06-24 07:20:00.087798+00	49	{"total-fields":36,"updated-fields":0}
141	sync-fks	1	2021-06-24 07:20:00.087831+00	2021-06-24 07:20:00.093923+00	6	{"total-fks":3,"updated-fks":0,"total-failed":0}
142	sync-metabase-metadata	1	2021-06-24 07:20:00.093959+00	2021-06-24 07:20:00.174434+00	80	\N
143	analyze	1	2021-06-24 07:20:00.184008+00	2021-06-24 07:20:00.197709+00	13	\N
144	fingerprint-fields	1	2021-06-24 07:20:00.184021+00	2021-06-24 07:20:00.191366+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
145	classify-fields	1	2021-06-24 07:20:00.191418+00	2021-06-24 07:20:00.195047+00	3	{"fields-classified":0,"fields-failed":0}
146	classify-tables	1	2021-06-24 07:20:00.195081+00	2021-06-24 07:20:00.197684+00	2	{"total-tables":4,"tables-classified":0}
147	send-pulses	\N	2021-06-24 08:00:00.006+00	2021-06-24 08:00:00.009+00	3	\N
148	task-history-cleanup	\N	2021-06-24 08:00:00.021+00	2021-06-24 08:00:00.021+00	0	\N
149	sync	1	2021-06-24 08:20:00.029582+00	2021-06-24 08:20:00.167655+00	138	\N
150	sync-timezone	1	2021-06-24 08:20:00.029598+00	2021-06-24 08:20:00.03288+00	3	{"timezone-id":"UTC"}
151	sync-tables	1	2021-06-24 08:20:00.032923+00	2021-06-24 08:20:00.038955+00	6	{"updated-tables":0,"total-tables":4}
152	sync-fields	1	2021-06-24 08:20:00.038994+00	2021-06-24 08:20:00.081506+00	42	{"total-fields":36,"updated-fields":0}
153	sync-fks	1	2021-06-24 08:20:00.081537+00	2021-06-24 08:20:00.086864+00	5	{"total-fks":3,"updated-fks":0,"total-failed":0}
154	sync-metabase-metadata	1	2021-06-24 08:20:00.086898+00	2021-06-24 08:20:00.167629+00	80	\N
155	analyze	1	2021-06-24 08:20:00.179802+00	2021-06-24 08:20:00.19329+00	13	\N
156	fingerprint-fields	1	2021-06-24 08:20:00.17982+00	2021-06-24 08:20:00.187186+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
157	classify-fields	1	2021-06-24 08:20:00.187225+00	2021-06-24 08:20:00.190712+00	3	{"fields-classified":0,"fields-failed":0}
158	classify-tables	1	2021-06-24 08:20:00.190748+00	2021-06-24 08:20:00.193264+00	2	{"total-tables":4,"tables-classified":0}
159	send-pulses	\N	2021-06-24 09:00:00.009+00	2021-06-24 09:00:00.012+00	3	\N
160	task-history-cleanup	\N	2021-06-24 09:00:00.017+00	2021-06-24 09:00:00.02+00	3	\N
161	sync	1	2021-06-24 09:20:00.011105+00	2021-06-24 09:20:00.141383+00	130	\N
162	sync-timezone	1	2021-06-24 09:20:00.01112+00	2021-06-24 09:20:00.014081+00	2	{"timezone-id":"UTC"}
163	sync-tables	1	2021-06-24 09:20:00.014122+00	2021-06-24 09:20:00.019885+00	5	{"updated-tables":0,"total-tables":4}
164	sync-fields	1	2021-06-24 09:20:00.019923+00	2021-06-24 09:20:00.06208+00	42	{"total-fields":36,"updated-fields":0}
165	sync-fks	1	2021-06-24 09:20:00.062113+00	2021-06-24 09:20:00.067703+00	5	{"total-fks":3,"updated-fks":0,"total-failed":0}
166	sync-metabase-metadata	1	2021-06-24 09:20:00.067738+00	2021-06-24 09:20:00.141356+00	73	\N
167	analyze	1	2021-06-24 09:20:00.149735+00	2021-06-24 09:20:00.164496+00	14	\N
168	fingerprint-fields	1	2021-06-24 09:20:00.14975+00	2021-06-24 09:20:00.157434+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
169	classify-fields	1	2021-06-24 09:20:00.15748+00	2021-06-24 09:20:00.161763+00	4	{"fields-classified":0,"fields-failed":0}
170	classify-tables	1	2021-06-24 09:20:00.161804+00	2021-06-24 09:20:00.164467+00	2	{"total-tables":4,"tables-classified":0}
171	send-pulses	\N	2021-06-24 10:00:00.005+00	2021-06-24 10:00:00.01+00	5	\N
172	task-history-cleanup	\N	2021-06-24 10:00:00.01+00	2021-06-24 10:00:00.011+00	1	\N
173	sync	1	2021-06-24 10:20:00.023946+00	2021-06-24 10:20:00.162708+00	138	\N
174	sync-timezone	1	2021-06-24 10:20:00.023973+00	2021-06-24 10:20:00.02799+00	4	{"timezone-id":"UTC"}
175	sync-tables	1	2021-06-24 10:20:00.02806+00	2021-06-24 10:20:00.036284+00	8	{"updated-tables":0,"total-tables":4}
176	sync-fields	1	2021-06-24 10:20:00.036361+00	2021-06-24 10:20:00.074086+00	37	{"total-fields":36,"updated-fields":0}
177	sync-fks	1	2021-06-24 10:20:00.074118+00	2021-06-24 10:20:00.079529+00	5	{"total-fks":3,"updated-fks":0,"total-failed":0}
178	sync-metabase-metadata	1	2021-06-24 10:20:00.079596+00	2021-06-24 10:20:00.162683+00	83	\N
179	analyze	1	2021-06-24 10:20:00.17104+00	2021-06-24 10:20:00.18444+00	13	\N
180	fingerprint-fields	1	2021-06-24 10:20:00.171055+00	2021-06-24 10:20:00.177707+00	6	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
181	classify-fields	1	2021-06-24 10:20:00.177742+00	2021-06-24 10:20:00.181876+00	4	{"fields-classified":0,"fields-failed":0}
182	classify-tables	1	2021-06-24 10:20:00.181919+00	2021-06-24 10:20:00.184415+00	2	{"total-tables":4,"tables-classified":0}
183	send-pulses	\N	2021-06-24 11:00:00.022+00	2021-06-24 11:00:00.026+00	4	\N
184	task-history-cleanup	\N	2021-06-24 11:00:00.034+00	2021-06-24 11:00:00.035+00	1	\N
185	sync	1	2021-06-24 11:20:00.013059+00	2021-06-24 11:20:00.149049+00	135	\N
188	sync-fields	1	2021-06-24 11:20:00.021494+00	2021-06-24 11:20:00.059724+00	38	{"total-fields":36,"updated-fields":0}
190	sync-metabase-metadata	1	2021-06-24 11:20:00.065643+00	2021-06-24 11:20:00.149022+00	83	\N
191	analyze	1	2021-06-24 11:20:00.15768+00	2021-06-24 11:20:00.171195+00	13	\N
192	fingerprint-fields	1	2021-06-24 11:20:00.157695+00	2021-06-24 11:20:00.164832+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
194	classify-tables	1	2021-06-24 11:20:00.168503+00	2021-06-24 11:20:00.171172+00	2	{"total-tables":4,"tables-classified":0}
186	sync-timezone	1	2021-06-24 11:20:00.013092+00	2021-06-24 11:20:00.016138+00	3	{"timezone-id":"UTC"}
187	sync-tables	1	2021-06-24 11:20:00.016177+00	2021-06-24 11:20:00.021459+00	5	{"updated-tables":0,"total-tables":4}
189	sync-fks	1	2021-06-24 11:20:00.059757+00	2021-06-24 11:20:00.065604+00	5	{"total-fks":3,"updated-fks":0,"total-failed":0}
193	classify-fields	1	2021-06-24 11:20:00.164873+00	2021-06-24 11:20:00.16847+00	3	{"fields-classified":0,"fields-failed":0}
195	send-pulses	\N	2021-06-24 12:00:00.006+00	2021-06-24 12:00:00.009+00	3	\N
196	task-history-cleanup	\N	2021-06-24 12:00:00.013+00	2021-06-24 12:00:00.014+00	1	\N
197	sync	1	2021-06-24 12:20:00.00858+00	2021-06-24 12:20:00.141452+00	132	\N
198	sync-timezone	1	2021-06-24 12:20:00.008595+00	2021-06-24 12:20:00.012703+00	4	{"timezone-id":"UTC"}
199	sync-tables	1	2021-06-24 12:20:00.012744+00	2021-06-24 12:20:00.018817+00	6	{"updated-tables":0,"total-tables":4}
200	sync-fields	1	2021-06-24 12:20:00.018851+00	2021-06-24 12:20:00.058587+00	39	{"total-fields":36,"updated-fields":0}
201	sync-fks	1	2021-06-24 12:20:00.05862+00	2021-06-24 12:20:00.064057+00	5	{"total-fks":3,"updated-fks":0,"total-failed":0}
202	sync-metabase-metadata	1	2021-06-24 12:20:00.064115+00	2021-06-24 12:20:00.141429+00	77	\N
203	analyze	1	2021-06-24 12:20:00.148857+00	2021-06-24 12:20:00.162955+00	14	\N
204	fingerprint-fields	1	2021-06-24 12:20:00.148872+00	2021-06-24 12:20:00.156233+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
205	classify-fields	1	2021-06-24 12:20:00.156269+00	2021-06-24 12:20:00.159626+00	3	{"fields-classified":0,"fields-failed":0}
206	classify-tables	1	2021-06-24 12:20:00.159661+00	2021-06-24 12:20:00.162902+00	3	{"total-tables":4,"tables-classified":0}
207	send-pulses	\N	2021-06-24 13:00:00.005+00	2021-06-24 13:00:00.008+00	3	\N
208	task-history-cleanup	\N	2021-06-24 13:00:00.023+00	2021-06-24 13:00:00.025+00	2	\N
209	sync	1	2021-06-24 13:20:00.012445+00	2021-06-24 13:20:00.156726+00	144	\N
210	sync-timezone	1	2021-06-24 13:20:00.012465+00	2021-06-24 13:20:00.016515+00	4	{"timezone-id":"UTC"}
211	sync-tables	1	2021-06-24 13:20:00.016557+00	2021-06-24 13:20:00.023189+00	6	{"updated-tables":0,"total-tables":4}
212	sync-fields	1	2021-06-24 13:20:00.023228+00	2021-06-24 13:20:00.066809+00	43	{"total-fields":36,"updated-fields":0}
213	sync-fks	1	2021-06-24 13:20:00.06684+00	2021-06-24 13:20:00.072859+00	6	{"total-fks":3,"updated-fks":0,"total-failed":0}
214	sync-metabase-metadata	1	2021-06-24 13:20:00.072898+00	2021-06-24 13:20:00.156697+00	83	\N
215	analyze	1	2021-06-24 13:20:00.165456+00	2021-06-24 13:20:00.179447+00	13	\N
216	fingerprint-fields	1	2021-06-24 13:20:00.165471+00	2021-06-24 13:20:00.173163+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
217	classify-fields	1	2021-06-24 13:20:00.173204+00	2021-06-24 13:20:00.176621+00	3	{"fields-classified":0,"fields-failed":0}
218	classify-tables	1	2021-06-24 13:20:00.176659+00	2021-06-24 13:20:00.179416+00	2	{"total-tables":4,"tables-classified":0}
219	send-pulses	\N	2021-06-24 14:00:00.007+00	2021-06-24 14:00:00.012+00	5	\N
220	task-history-cleanup	\N	2021-06-24 14:00:00.018+00	2021-06-24 14:00:00.019+00	1	\N
221	sync	1	2021-06-24 14:20:00.013546+00	2021-06-24 14:20:00.15096+00	137	\N
222	sync-timezone	1	2021-06-24 14:20:00.013584+00	2021-06-24 14:20:00.019074+00	5	{"timezone-id":"UTC"}
223	sync-tables	1	2021-06-24 14:20:00.019156+00	2021-06-24 14:20:00.025191+00	6	{"updated-tables":0,"total-tables":4}
224	sync-fields	1	2021-06-24 14:20:00.025226+00	2021-06-24 14:20:00.062947+00	37	{"total-fields":36,"updated-fields":0}
225	sync-fks	1	2021-06-24 14:20:00.062998+00	2021-06-24 14:20:00.069565+00	6	{"total-fks":3,"updated-fks":0,"total-failed":0}
226	sync-metabase-metadata	1	2021-06-24 14:20:00.069614+00	2021-06-24 14:20:00.150936+00	81	\N
227	analyze	1	2021-06-24 14:20:00.158223+00	2021-06-24 14:20:00.17428+00	16	\N
228	fingerprint-fields	1	2021-06-24 14:20:00.158236+00	2021-06-24 14:20:00.167505+00	9	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
229	classify-fields	1	2021-06-24 14:20:00.167546+00	2021-06-24 14:20:00.171697+00	4	{"fields-classified":0,"fields-failed":0}
230	classify-tables	1	2021-06-24 14:20:00.171827+00	2021-06-24 14:20:00.174251+00	2	{"total-tables":4,"tables-classified":0}
231	send-pulses	\N	2021-06-24 15:00:00.005+00	2021-06-24 15:00:00.008+00	3	\N
232	task-history-cleanup	\N	2021-06-24 15:00:00.021+00	2021-06-24 15:00:00.022+00	1	\N
233	sync	1	2021-06-24 15:20:00.016699+00	2021-06-24 15:20:00.151824+00	135	\N
234	sync-timezone	1	2021-06-24 15:20:00.016722+00	2021-06-24 15:20:00.020534+00	3	{"timezone-id":"UTC"}
235	sync-tables	1	2021-06-24 15:20:00.020586+00	2021-06-24 15:20:00.027279+00	6	{"updated-tables":0,"total-tables":4}
236	sync-fields	1	2021-06-24 15:20:00.027318+00	2021-06-24 15:20:00.068525+00	41	{"total-fields":36,"updated-fields":0}
237	sync-fks	1	2021-06-24 15:20:00.06856+00	2021-06-24 15:20:00.074541+00	5	{"total-fks":3,"updated-fks":0,"total-failed":0}
238	sync-metabase-metadata	1	2021-06-24 15:20:00.074575+00	2021-06-24 15:20:00.151799+00	77	\N
239	analyze	1	2021-06-24 15:20:00.160411+00	2021-06-24 15:20:00.174828+00	14	\N
240	fingerprint-fields	1	2021-06-24 15:20:00.160424+00	2021-06-24 15:20:00.16719+00	6	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
241	classify-fields	1	2021-06-24 15:20:00.167227+00	2021-06-24 15:20:00.171339+00	4	{"fields-classified":0,"fields-failed":0}
242	classify-tables	1	2021-06-24 15:20:00.171382+00	2021-06-24 15:20:00.17478+00	3	{"total-tables":4,"tables-classified":0}
243	send-pulses	\N	2021-06-24 16:00:00.005+00	2021-06-24 16:00:00.009+00	4	\N
244	task-history-cleanup	\N	2021-06-24 16:00:00.013+00	2021-06-24 16:00:00.014+00	1	\N
245	sync	1	2021-06-24 16:20:00.015623+00	2021-06-24 16:20:00.142986+00	127	\N
246	sync-timezone	1	2021-06-24 16:20:00.015644+00	2021-06-24 16:20:00.018794+00	3	{"timezone-id":"UTC"}
247	sync-tables	1	2021-06-24 16:20:00.018833+00	2021-06-24 16:20:00.023869+00	5	{"updated-tables":0,"total-tables":4}
248	sync-fields	1	2021-06-24 16:20:00.023907+00	2021-06-24 16:20:00.059688+00	35	{"total-fields":36,"updated-fields":0}
249	sync-fks	1	2021-06-24 16:20:00.05972+00	2021-06-24 16:20:00.065192+00	5	{"total-fks":3,"updated-fks":0,"total-failed":0}
250	sync-metabase-metadata	1	2021-06-24 16:20:00.065229+00	2021-06-24 16:20:00.142962+00	77	\N
251	analyze	1	2021-06-24 16:20:00.150729+00	2021-06-24 16:20:00.161998+00	11	\N
252	fingerprint-fields	1	2021-06-24 16:20:00.150764+00	2021-06-24 16:20:00.156567+00	5	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
253	classify-fields	1	2021-06-24 16:20:00.156616+00	2021-06-24 16:20:00.159615+00	2	{"fields-classified":0,"fields-failed":0}
254	classify-tables	1	2021-06-24 16:20:00.159642+00	2021-06-24 16:20:00.161979+00	2	{"total-tables":4,"tables-classified":0}
255	send-pulses	\N	2021-06-24 17:00:00.003+00	2021-06-24 17:00:00.006+00	3	\N
256	task-history-cleanup	\N	2021-06-24 17:00:00.01+00	2021-06-24 17:00:00.011+00	1	\N
257	sync	1	2021-06-24 17:20:00.017717+00	2021-06-24 17:20:00.163919+00	146	\N
258	sync-timezone	1	2021-06-24 17:20:00.01774+00	2021-06-24 17:20:00.022039+00	4	{"timezone-id":"UTC"}
259	sync-tables	1	2021-06-24 17:20:00.022091+00	2021-06-24 17:20:00.029082+00	6	{"updated-tables":0,"total-tables":4}
260	sync-fields	1	2021-06-24 17:20:00.02913+00	2021-06-24 17:20:00.07406+00	44	{"total-fields":36,"updated-fields":0}
261	sync-fks	1	2021-06-24 17:20:00.074097+00	2021-06-24 17:20:00.080853+00	6	{"total-fks":3,"updated-fks":0,"total-failed":0}
262	sync-metabase-metadata	1	2021-06-24 17:20:00.080889+00	2021-06-24 17:20:00.163895+00	83	\N
263	analyze	1	2021-06-24 17:20:00.17274+00	2021-06-24 17:20:00.185717+00	12	\N
264	fingerprint-fields	1	2021-06-24 17:20:00.172752+00	2021-06-24 17:20:00.179902+00	7	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
265	classify-fields	1	2021-06-24 17:20:00.179937+00	2021-06-24 17:20:00.183266+00	3	{"fields-classified":0,"fields-failed":0}
266	classify-tables	1	2021-06-24 17:20:00.1833+00	2021-06-24 17:20:00.185693+00	2	{"total-tables":4,"tables-classified":0}
267	send-pulses	\N	2021-06-24 18:00:00.005+00	2021-06-24 18:00:00.009+00	4	\N
268	task-history-cleanup	\N	2021-06-24 18:00:00.016+00	2021-06-24 18:00:00.018+00	2	\N
269	sync	1	2021-06-24 18:20:00.010024+00	2021-06-24 18:20:00.14626+00	136	\N
270	sync-timezone	1	2021-06-24 18:20:00.01004+00	2021-06-24 18:20:00.013432+00	3	{"timezone-id":"UTC"}
274	sync-metabase-metadata	1	2021-06-24 18:20:00.060108+00	2021-06-24 18:20:00.146236+00	86	\N
275	analyze	1	2021-06-24 18:20:00.155498+00	2021-06-24 18:20:00.17161+00	16	\N
276	fingerprint-fields	1	2021-06-24 18:20:00.155511+00	2021-06-24 18:20:00.164699+00	9	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
277	classify-fields	1	2021-06-24 18:20:00.164739+00	2021-06-24 18:20:00.168801+00	4	{"fields-classified":0,"fields-failed":0}
271	sync-tables	1	2021-06-24 18:20:00.013481+00	2021-06-24 18:20:00.019041+00	5	{"updated-tables":0,"total-tables":4}
272	sync-fields	1	2021-06-24 18:20:00.019074+00	2021-06-24 18:20:00.054238+00	35	{"total-fields":36,"updated-fields":0}
273	sync-fks	1	2021-06-24 18:20:00.054272+00	2021-06-24 18:20:00.060073+00	5	{"total-fks":3,"updated-fks":0,"total-failed":0}
278	classify-tables	1	2021-06-24 18:20:00.168838+00	2021-06-24 18:20:00.171583+00	2	{"total-tables":4,"tables-classified":0}
279	sync	2	2021-06-24 18:23:56.857392+00	2021-06-24 18:23:57.373153+00	515	\N
280	sync-timezone	2	2021-06-24 18:23:56.857407+00	2021-06-24 18:23:56.943131+00	85	{"timezone-id":"UTC"}
281	sync-tables	2	2021-06-24 18:23:56.943186+00	2021-06-24 18:23:57.036434+00	93	{"updated-tables":9,"total-tables":0}
282	sync-fields	2	2021-06-24 18:23:57.036493+00	2021-06-24 18:23:57.2689+00	232	{"total-fields":41,"updated-fields":41}
283	sync-fks	2	2021-06-24 18:23:57.268938+00	2021-06-24 18:23:57.362375+00	93	{"total-fks":8,"updated-fks":8,"total-failed":0}
284	sync-metabase-metadata	2	2021-06-24 18:23:57.362421+00	2021-06-24 18:23:57.373131+00	10	\N
285	analyze	2	2021-06-24 18:23:57.382888+00	2021-06-24 18:23:57.82656+00	443	\N
286	fingerprint-fields	2	2021-06-24 18:23:57.382902+00	2021-06-24 18:23:57.692196+00	309	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":32,"fingerprints-attempted":32}
287	classify-fields	2	2021-06-24 18:23:57.692239+00	2021-06-24 18:23:57.786021+00	93	{"fields-classified":32,"fields-failed":0}
288	classify-tables	2	2021-06-24 18:23:57.786073+00	2021-06-24 18:23:57.826527+00	40	{"total-tables":9,"tables-classified":9}
289	field values scanning	2	2021-06-24 18:23:57.834484+00	2021-06-24 18:23:58.141606+00	307	\N
290	update-field-values	2	2021-06-24 18:23:57.834498+00	2021-06-24 18:23:58.141573+00	307	{"errors":0,"created":13,"updated":0,"deleted":0}
291	sync	2	2021-06-24 18:52:36.482587+00	2021-06-24 18:52:36.736927+00	254	\N
292	sync-timezone	2	2021-06-24 18:52:36.482604+00	2021-06-24 18:52:36.487136+00	4	{"timezone-id":"UTC"}
293	sync-tables	2	2021-06-24 18:52:36.487194+00	2021-06-24 18:52:36.51279+00	25	{"updated-tables":1,"total-tables":9}
294	sync-fields	2	2021-06-24 18:52:36.512829+00	2021-06-24 18:52:36.63268+00	119	{"total-fields":45,"updated-fields":4}
295	sync-fks	2	2021-06-24 18:52:36.632726+00	2021-06-24 18:52:36.723281+00	90	{"total-fks":9,"updated-fks":1,"total-failed":0}
296	sync-metabase-metadata	2	2021-06-24 18:52:36.723328+00	2021-06-24 18:52:36.736895+00	13	\N
297	analyze	2	2021-06-24 18:52:36.747297+00	2021-06-24 18:52:36.862713+00	115	\N
298	fingerprint-fields	2	2021-06-24 18:52:36.747311+00	2021-06-24 18:52:36.821642+00	74	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":3,"fingerprints-attempted":3}
299	classify-fields	2	2021-06-24 18:52:36.82171+00	2021-06-24 18:52:36.839912+00	18	{"fields-classified":3,"fields-failed":0}
300	classify-tables	2	2021-06-24 18:52:36.840019+00	2021-06-24 18:52:36.862623+00	22	{"total-tables":10,"tables-classified":1}
301	field values scanning	2	2021-06-24 18:52:37.591444+00	2021-06-24 18:52:37.884684+00	293	\N
302	update-field-values	2	2021-06-24 18:52:37.591466+00	2021-06-24 18:52:37.884658+00	293	{"errors":0,"created":1,"updated":0,"deleted":0}
303	field values scanning	2	2021-06-24 18:53:56.884372+00	2021-06-24 18:53:57.179687+00	295	\N
304	update-field-values	2	2021-06-24 18:53:56.884387+00	2021-06-24 18:53:57.179657+00	295	{"errors":0,"created":14,"updated":0,"deleted":0}
305	sync	2	2021-06-24 18:53:57.680033+00	2021-06-24 18:53:57.857549+00	177	\N
306	sync-timezone	2	2021-06-24 18:53:57.680069+00	2021-06-24 18:53:57.684736+00	4	{"timezone-id":"UTC"}
307	sync-tables	2	2021-06-24 18:53:57.684779+00	2021-06-24 18:53:57.695213+00	10	{"updated-tables":0,"total-tables":10}
308	sync-fields	2	2021-06-24 18:53:57.695248+00	2021-06-24 18:53:57.778945+00	83	{"total-fields":45,"updated-fields":0}
309	sync-fks	2	2021-06-24 18:53:57.77898+00	2021-06-24 18:53:57.846107+00	67	{"total-fks":9,"updated-fks":0,"total-failed":0}
310	sync-metabase-metadata	2	2021-06-24 18:53:57.846151+00	2021-06-24 18:53:57.857526+00	11	\N
311	analyze	2	2021-06-24 18:53:57.866549+00	2021-06-24 18:53:57.900379+00	33	\N
312	fingerprint-fields	2	2021-06-24 18:53:57.866562+00	2021-06-24 18:53:57.882821+00	16	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
313	classify-fields	2	2021-06-24 18:53:57.882863+00	2021-06-24 18:53:57.890257+00	7	{"fields-classified":0,"fields-failed":0}
314	classify-tables	2	2021-06-24 18:53:57.890297+00	2021-06-24 18:53:57.900348+00	10	{"total-tables":10,"tables-classified":0}
315	send-pulses	\N	2021-06-24 19:00:00.007+00	2021-06-24 19:00:00.009+00	2	\N
317	sync	2	2021-06-24 19:04:00.013202+00	2021-06-24 19:04:00.197819+00	184	\N
318	sync-timezone	2	2021-06-24 19:04:00.013227+00	2021-06-24 19:04:00.018192+00	4	{"timezone-id":"UTC"}
319	sync-tables	2	2021-06-24 19:04:00.018242+00	2021-06-24 19:04:00.029313+00	11	{"updated-tables":0,"total-tables":10}
320	sync-fields	2	2021-06-24 19:04:00.029346+00	2021-06-24 19:04:00.118504+00	89	{"total-fields":45,"updated-fields":0}
330	sync-timezone	2	2021-06-24 20:04:00.012806+00	2021-06-24 20:04:00.018222+00	5	{"timezone-id":"UTC"}
331	sync-tables	2	2021-06-24 20:04:00.018274+00	2021-06-24 20:04:00.033416+00	15	{"updated-tables":0,"total-tables":10}
333	sync-fks	2	2021-06-24 20:04:00.123265+00	2021-06-24 20:04:00.190163+00	66	{"total-fks":9,"updated-fks":0,"total-failed":0}
316	task-history-cleanup	\N	2021-06-24 19:00:00.018+00	2021-06-24 19:00:00.019+00	1	\N
321	sync-fks	2	2021-06-24 19:04:00.118536+00	2021-06-24 19:04:00.188058+00	69	{"total-fks":9,"updated-fks":0,"total-failed":0}
322	sync-metabase-metadata	2	2021-06-24 19:04:00.188101+00	2021-06-24 19:04:00.197796+00	9	\N
323	analyze	2	2021-06-24 19:04:00.208393+00	2021-06-24 19:04:00.243392+00	34	\N
324	fingerprint-fields	2	2021-06-24 19:04:00.208412+00	2021-06-24 19:04:00.22715+00	18	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
325	classify-fields	2	2021-06-24 19:04:00.227194+00	2021-06-24 19:04:00.234734+00	7	{"fields-classified":0,"fields-failed":0}
326	classify-tables	2	2021-06-24 19:04:00.234777+00	2021-06-24 19:04:00.243365+00	8	{"total-tables":10,"tables-classified":0}
327	send-pulses	\N	2021-06-24 20:00:00.006+00	2021-06-24 20:00:00.009+00	3	\N
328	task-history-cleanup	\N	2021-06-24 20:00:00.014+00	2021-06-24 20:00:00.015+00	1	\N
329	sync	2	2021-06-24 20:04:00.012792+00	2021-06-24 20:04:00.203781+00	190	\N
332	sync-fields	2	2021-06-24 20:04:00.033449+00	2021-06-24 20:04:00.123225+00	89	{"total-fields":45,"updated-fields":0}
334	sync-metabase-metadata	2	2021-06-24 20:04:00.190246+00	2021-06-24 20:04:00.203755+00	13	\N
335	analyze	2	2021-06-24 20:04:00.215244+00	2021-06-24 20:04:00.255586+00	40	\N
336	fingerprint-fields	2	2021-06-24 20:04:00.215261+00	2021-06-24 20:04:00.234691+00	19	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
337	classify-fields	2	2021-06-24 20:04:00.234745+00	2021-06-24 20:04:00.244968+00	10	{"fields-classified":0,"fields-failed":0}
338	classify-tables	2	2021-06-24 20:04:00.245017+00	2021-06-24 20:04:00.255552+00	10	{"total-tables":10,"tables-classified":0}
339	send-pulses	\N	2021-06-24 21:00:00.004+00	2021-06-24 21:00:00.006+00	2	\N
340	task-history-cleanup	\N	2021-06-24 21:00:00.012+00	2021-06-24 21:00:00.013+00	1	\N
341	sync	2	2021-06-24 21:04:00.014671+00	2021-06-24 21:04:00.199568+00	184	\N
342	sync-timezone	2	2021-06-24 21:04:00.014687+00	2021-06-24 21:04:00.019019+00	4	{"timezone-id":"UTC"}
343	sync-tables	2	2021-06-24 21:04:00.019067+00	2021-06-24 21:04:00.030395+00	11	{"updated-tables":0,"total-tables":10}
344	sync-fields	2	2021-06-24 21:04:00.030444+00	2021-06-24 21:04:00.115022+00	84	{"total-fields":45,"updated-fields":0}
345	sync-fks	2	2021-06-24 21:04:00.115065+00	2021-06-24 21:04:00.187787+00	72	{"total-fks":9,"updated-fks":0,"total-failed":0}
346	sync-metabase-metadata	2	2021-06-24 21:04:00.187833+00	2021-06-24 21:04:00.199545+00	11	\N
347	analyze	2	2021-06-24 21:04:00.20791+00	2021-06-24 21:04:00.236412+00	28	\N
348	fingerprint-fields	2	2021-06-24 21:04:00.207924+00	2021-06-24 21:04:00.221263+00	13	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
349	classify-fields	2	2021-06-24 21:04:00.221301+00	2021-06-24 21:04:00.227522+00	6	{"fields-classified":0,"fields-failed":0}
350	classify-tables	2	2021-06-24 21:04:00.227559+00	2021-06-24 21:04:00.236384+00	8	{"total-tables":10,"tables-classified":0}
351	send-pulses	\N	2021-06-24 22:00:00.006+00	2021-06-24 22:00:00.01+00	4	\N
352	task-history-cleanup	\N	2021-06-24 22:00:00.013+00	2021-06-24 22:00:00.014+00	1	\N
353	sync	2	2021-06-24 22:04:00.010164+00	2021-06-24 22:04:00.208061+00	197	\N
354	sync-timezone	2	2021-06-24 22:04:00.010178+00	2021-06-24 22:04:00.013259+00	3	{"timezone-id":"UTC"}
355	sync-tables	2	2021-06-24 22:04:00.013296+00	2021-06-24 22:04:00.02323+00	9	{"updated-tables":0,"total-tables":10}
356	sync-fields	2	2021-06-24 22:04:00.023269+00	2021-06-24 22:04:00.117157+00	93	{"total-fields":45,"updated-fields":0}
357	sync-fks	2	2021-06-24 22:04:00.1172+00	2021-06-24 22:04:00.195771+00	78	{"total-fks":9,"updated-fks":0,"total-failed":0}
358	sync-metabase-metadata	2	2021-06-24 22:04:00.195818+00	2021-06-24 22:04:00.208025+00	12	\N
359	analyze	2	2021-06-24 22:04:00.215669+00	2021-06-24 22:04:00.248412+00	32	\N
360	fingerprint-fields	2	2021-06-24 22:04:00.215685+00	2021-06-24 22:04:00.229653+00	13	{"no-data-fingerprints":0,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":0}
361	classify-fields	2	2021-06-24 22:04:00.229689+00	2021-06-24 22:04:00.237386+00	7	{"fields-classified":0,"fields-failed":0}
362	classify-tables	2	2021-06-24 22:04:00.237433+00	2021-06-24 22:04:00.248377+00	10	{"total-tables":10,"tables-classified":0}
363	send-pulses	\N	2021-06-24 23:00:00.019+00	2021-06-24 23:00:00.033+00	14	\N
364	task-history-cleanup	\N	2021-06-24 23:00:00.034+00	2021-06-24 23:00:00.038+00	4	\N
365	sync	2	2021-06-24 23:04:00.01965+00	2021-06-24 23:04:00.432946+00	413	\N
366	sync-timezone	2	2021-06-24 23:04:00.020864+00	2021-06-24 23:04:00.037302+00	16	{"timezone-id":"UTC"}
367	sync-tables	2	2021-06-24 23:04:00.0377+00	2021-06-24 23:04:00.09453+00	56	{"updated-tables":1,"total-tables":10}
368	sync-fields	2	2021-06-24 23:04:00.09459+00	2021-06-24 23:04:00.268427+00	173	{"total-fields":49,"updated-fields":4}
369	sync-fks	2	2021-06-24 23:04:00.268493+00	2021-06-24 23:04:00.417347+00	148	{"total-fks":10,"updated-fks":1,"total-failed":0}
370	sync-metabase-metadata	2	2021-06-24 23:04:00.417404+00	2021-06-24 23:04:00.432911+00	15	\N
371	analyze	2	2021-06-24 23:04:00.471407+00	2021-06-24 23:04:00.649456+00	178	\N
372	fingerprint-fields	2	2021-06-24 23:04:00.471491+00	2021-06-24 23:04:00.603432+00	131	{"no-data-fingerprints":3,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":3}
373	classify-fields	2	2021-06-24 23:04:00.603565+00	2021-06-24 23:04:00.623116+00	19	{"fields-classified":0,"fields-failed":0}
374	classify-tables	2	2021-06-24 23:04:00.623199+00	2021-06-24 23:04:00.6494+00	26	{"total-tables":11,"tables-classified":1}
375	task-history-cleanup	\N	2021-06-25 00:00:00.03+00	2021-06-25 00:00:00.034+00	4	\N
376	send-pulses	\N	2021-06-25 00:00:00.016+00	2021-06-25 00:00:00.032+00	16	\N
377	sync	2	2021-06-25 00:04:00.018712+00	2021-06-25 00:04:00.388936+00	370	\N
378	sync-timezone	2	2021-06-25 00:04:00.01966+00	2021-06-25 00:04:00.0777+00	58	{"timezone-id":"UTC"}
379	sync-tables	2	2021-06-25 00:04:00.078013+00	2021-06-25 00:04:00.109031+00	31	{"updated-tables":0,"total-tables":11}
380	sync-fields	2	2021-06-25 00:04:00.109098+00	2021-06-25 00:04:00.28206+00	172	{"total-fields":49,"updated-fields":0}
381	sync-fks	2	2021-06-25 00:04:00.282139+00	2021-06-25 00:04:00.3744+00	92	{"total-fks":10,"updated-fks":0,"total-failed":0}
382	sync-metabase-metadata	2	2021-06-25 00:04:00.374464+00	2021-06-25 00:04:00.388894+00	14	\N
383	analyze	2	2021-06-25 00:04:00.427625+00	2021-06-25 00:04:00.644318+00	216	\N
384	fingerprint-fields	2	2021-06-25 00:04:00.427658+00	2021-06-25 00:04:00.607167+00	179	{"no-data-fingerprints":3,"failed-fingerprints":0,"updated-fingerprints":0,"fingerprints-attempted":3}
385	classify-fields	2	2021-06-25 00:04:00.607236+00	2021-06-25 00:04:00.623968+00	16	{"fields-classified":0,"fields-failed":0}
386	classify-tables	2	2021-06-25 00:04:00.624024+00	2021-06-25 00:04:00.644277+00	20	{"total-tables":11,"tables-classified":0}
\.


--
-- Data for Name: view_log; Type: TABLE DATA; Schema: public; Owner: metabase
--

COPY public.view_log (id, user_id, model, model_id, "timestamp") FROM stdin;
1	1	card	1	2021-06-24 18:28:41.898501+00
2	1	dashboard	1	2021-06-24 18:29:37.968608+00
3	1	card	1	2021-06-24 18:29:38.045067+00
4	1	dashboard	1	2021-06-24 18:30:29.579237+00
5	1	card	1	2021-06-24 18:30:31.173237+00
6	1	dashboard	1	2021-06-24 18:32:38.817897+00
7	1	dashboard	1	2021-06-24 18:34:41.699213+00
8	1	dashboard	1	2021-06-24 18:35:02.197152+00
9	1	dashboard	1	2021-06-24 18:36:05.903271+00
10	1	card	1	2021-06-24 18:50:53.065567+00
11	1	card	1	2021-06-24 18:51:54.114045+00
12	1	card	1	2021-06-24 18:52:48.644387+00
13	1	dashboard	1	2021-06-24 18:54:45.289667+00
14	1	card	1	2021-06-24 18:54:48.048708+00
15	1	dashboard	1	2021-06-24 18:56:07.538651+00
16	1	dashboard	1	2021-06-24 18:57:00.294297+00
17	1	card	1	2021-06-24 18:57:13.271555+00
18	1	card	2	2021-06-24 19:03:12.494927+00
19	1	dashboard	1	2021-06-24 19:03:22.145271+00
20	1	card	2	2021-06-24 19:03:22.285419+00
21	1	dashboard	1	2021-06-24 19:03:26.038891+00
22	1	card	2	2021-06-24 19:04:03.617841+00
23	1	card	2	2021-06-24 19:15:26.331699+00
24	1	card	3	2021-06-24 19:21:10.290168+00
25	1	dashboard	1	2021-06-24 19:21:16.553237+00
26	1	card	3	2021-06-24 19:21:16.689894+00
27	1	dashboard	1	2021-06-24 19:21:53.98022+00
28	1	card	3	2021-06-24 19:21:54.916485+00
29	1	dashboard	1	2021-06-24 19:22:47.746919+00
30	1	dashboard	1	2021-06-24 19:23:08.569024+00
31	1	card	1	2021-06-24 19:23:27.27095+00
32	1	card	1	2021-06-24 19:23:39.289368+00
33	1	card	4	2021-06-24 19:27:28.765622+00
34	1	dashboard	1	2021-06-24 19:27:32.560371+00
35	1	card	4	2021-06-24 19:27:32.744288+00
36	1	dashboard	1	2021-06-24 19:28:02.441185+00
37	1	card	4	2021-06-24 19:28:42.660064+00
38	1	card	5	2021-06-24 19:29:30.087586+00
39	1	dashboard	1	2021-06-24 19:29:33.966466+00
40	1	card	5	2021-06-24 19:29:34.144216+00
41	1	dashboard	1	2021-06-24 19:29:37.896308+00
42	1	card	5	2021-06-24 19:29:38.875737+00
43	1	dashboard	1	2021-06-24 19:30:03.491243+00
44	1	card	1	2021-06-24 19:30:25.927252+00
45	1	dashboard	1	2021-06-24 19:30:27.944682+00
46	1	card	4	2021-06-24 19:30:29.771501+00
47	1	card	6	2021-06-24 19:31:13.999212+00
48	1	dashboard	1	2021-06-24 19:31:18.921341+00
49	1	card	6	2021-06-24 19:31:19.114284+00
50	1	dashboard	1	2021-06-24 19:31:50.479904+00
51	1	dashboard	1	2021-06-24 22:55:07.162734+00
52	1	card	3	2021-06-24 22:55:42.550712+00
53	1	dashboard	1	2021-06-25 00:19:59.538168+00
54	1	card	1	2021-06-25 00:20:13.212406+00
55	1	dashboard	1	2021-06-25 00:21:16.812393+00
56	1	card	4	2021-06-25 00:23:31.846758+00
57	1	dashboard	1	2021-06-25 00:25:40.544488+00
58	1	card	2	2021-06-25 00:35:19.312255+00
59	1	dashboard	1	2021-06-25 00:35:27.702952+00
60	1	card	1	2021-06-25 00:35:28.979491+00
61	1	dashboard	1	2021-06-25 00:36:41.913391+00
62	1	card	2	2021-06-25 00:36:52.330804+00
63	1	dashboard	1	2021-06-25 00:37:21.841861+00
64	1	card	3	2021-06-25 00:37:23.412383+00
65	1	dashboard	1	2021-06-25 00:39:21.441818+00
66	1	card	6	2021-06-25 00:39:52.855893+00
\.


--
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.activity_id_seq', 26, true);


--
-- Name: card_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.card_label_id_seq', 1, false);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.collection_id_seq', 2, true);


--
-- Name: collection_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.collection_revision_id_seq', 1, false);


--
-- Name: computation_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.computation_job_id_seq', 1, false);


--
-- Name: computation_job_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.computation_job_result_id_seq', 1, false);


--
-- Name: core_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.core_user_id_seq', 1, true);


--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.dashboard_favorite_id_seq', 1, false);


--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.dashboardcard_series_id_seq', 1, false);


--
-- Name: dependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.dependency_id_seq', 1, false);


--
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.dimension_id_seq', 1, false);


--
-- Name: group_table_access_policy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.group_table_access_policy_id_seq', 1, false);


--
-- Name: label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.label_id_seq', 1, false);


--
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.login_history_id_seq', 3, true);


--
-- Name: metabase_database_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.metabase_database_id_seq', 2, true);


--
-- Name: metabase_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.metabase_field_id_seq', 85, true);


--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.metabase_fieldvalues_id_seq', 33, true);


--
-- Name: metabase_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.metabase_table_id_seq', 15, true);


--
-- Name: metric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.metric_id_seq', 1, false);


--
-- Name: metric_important_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.metric_important_field_id_seq', 1, false);


--
-- Name: native_query_snippet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.native_query_snippet_id_seq', 1, false);


--
-- Name: permissions_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.permissions_group_id_seq', 3, true);


--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.permissions_group_membership_id_seq', 2, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.permissions_id_seq', 7, true);


--
-- Name: permissions_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.permissions_revision_id_seq', 1, false);


--
-- Name: pulse_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.pulse_card_id_seq', 1, false);


--
-- Name: pulse_channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.pulse_channel_id_seq', 1, false);


--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.pulse_channel_recipient_id_seq', 1, false);


--
-- Name: pulse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.pulse_id_seq', 1, false);


--
-- Name: query_execution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.query_execution_id_seq', 171, true);


--
-- Name: report_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.report_card_id_seq', 6, true);


--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.report_cardfavorite_id_seq', 1, false);


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.report_dashboard_id_seq', 1, true);


--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.report_dashboardcard_id_seq', 6, true);


--
-- Name: revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.revision_id_seq', 47, true);


--
-- Name: segment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.segment_id_seq', 1, false);


--
-- Name: task_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.task_history_id_seq', 386, true);


--
-- Name: view_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: metabase
--

SELECT pg_catalog.setval('public.view_log_id_seq', 66, true);


--
-- Name: activity activity_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT activity_pkey PRIMARY KEY (id);


--
-- Name: card_label card_label_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.card_label
    ADD CONSTRAINT card_label_pkey PRIMARY KEY (id);


--
-- Name: collection collection_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (id);


--
-- Name: collection_revision collection_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.collection_revision
    ADD CONSTRAINT collection_revision_pkey PRIMARY KEY (id);


--
-- Name: computation_job computation_job_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.computation_job
    ADD CONSTRAINT computation_job_pkey PRIMARY KEY (id);


--
-- Name: computation_job_result computation_job_result_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.computation_job_result
    ADD CONSTRAINT computation_job_result_pkey PRIMARY KEY (id);


--
-- Name: core_session core_session_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.core_session
    ADD CONSTRAINT core_session_pkey PRIMARY KEY (id);


--
-- Name: core_user core_user_email_key; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT core_user_email_key UNIQUE (email);


--
-- Name: core_user core_user_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.core_user
    ADD CONSTRAINT core_user_pkey PRIMARY KEY (id);


--
-- Name: dashboard_favorite dashboard_favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboard_favorite
    ADD CONSTRAINT dashboard_favorite_pkey PRIMARY KEY (id);


--
-- Name: dashboardcard_series dashboardcard_series_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboardcard_series
    ADD CONSTRAINT dashboardcard_series_pkey PRIMARY KEY (id);


--
-- Name: data_migrations data_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.data_migrations
    ADD CONSTRAINT data_migrations_pkey PRIMARY KEY (id);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: dependency dependency_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dependency
    ADD CONSTRAINT dependency_pkey PRIMARY KEY (id);


--
-- Name: dimension dimension_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dimension
    ADD CONSTRAINT dimension_pkey PRIMARY KEY (id);


--
-- Name: group_table_access_policy group_table_access_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.group_table_access_policy
    ADD CONSTRAINT group_table_access_policy_pkey PRIMARY KEY (id);


--
-- Name: databasechangelog idx_databasechangelog_id_author_filename; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.databasechangelog
    ADD CONSTRAINT idx_databasechangelog_id_author_filename UNIQUE (id, author, filename);


--
-- Name: metabase_field idx_uniq_field_table_id_parent_id_name; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_field
    ADD CONSTRAINT idx_uniq_field_table_id_parent_id_name UNIQUE (table_id, parent_id, name);


--
-- Name: metabase_table idx_uniq_table_db_id_schema_name; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_table
    ADD CONSTRAINT idx_uniq_table_db_id_schema_name UNIQUE (db_id, schema, name);


--
-- Name: report_cardfavorite idx_unique_cardfavorite_card_id_owner_id; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_cardfavorite
    ADD CONSTRAINT idx_unique_cardfavorite_card_id_owner_id UNIQUE (card_id, owner_id);


--
-- Name: label label_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.label
    ADD CONSTRAINT label_pkey PRIMARY KEY (id);


--
-- Name: label label_slug_key; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.label
    ADD CONSTRAINT label_slug_key UNIQUE (slug);


--
-- Name: login_history login_history_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_pkey PRIMARY KEY (id);


--
-- Name: metabase_database metabase_database_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_database
    ADD CONSTRAINT metabase_database_pkey PRIMARY KEY (id);


--
-- Name: metabase_field metabase_field_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_field
    ADD CONSTRAINT metabase_field_pkey PRIMARY KEY (id);


--
-- Name: metabase_fieldvalues metabase_fieldvalues_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_fieldvalues
    ADD CONSTRAINT metabase_fieldvalues_pkey PRIMARY KEY (id);


--
-- Name: metabase_table metabase_table_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_table
    ADD CONSTRAINT metabase_table_pkey PRIMARY KEY (id);


--
-- Name: metric_important_field metric_important_field_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric_important_field
    ADD CONSTRAINT metric_important_field_pkey PRIMARY KEY (id);


--
-- Name: metric metric_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric
    ADD CONSTRAINT metric_pkey PRIMARY KEY (id);


--
-- Name: native_query_snippet native_query_snippet_name_key; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.native_query_snippet
    ADD CONSTRAINT native_query_snippet_name_key UNIQUE (name);


--
-- Name: native_query_snippet native_query_snippet_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.native_query_snippet
    ADD CONSTRAINT native_query_snippet_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_group_id_object_key; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_group_id_object_key UNIQUE (group_id, object);


--
-- Name: permissions_group_membership permissions_group_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_group_membership
    ADD CONSTRAINT permissions_group_membership_pkey PRIMARY KEY (id);


--
-- Name: permissions_group permissions_group_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_group
    ADD CONSTRAINT permissions_group_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: permissions_revision permissions_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_revision
    ADD CONSTRAINT permissions_revision_pkey PRIMARY KEY (id);


--
-- Name: qrtz_blob_triggers pk_qrtz_blob_triggers; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_blob_triggers
    ADD CONSTRAINT pk_qrtz_blob_triggers PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_calendars pk_qrtz_calendars; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_calendars
    ADD CONSTRAINT pk_qrtz_calendars PRIMARY KEY (sched_name, calendar_name);


--
-- Name: qrtz_cron_triggers pk_qrtz_cron_triggers; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_cron_triggers
    ADD CONSTRAINT pk_qrtz_cron_triggers PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_fired_triggers pk_qrtz_fired_triggers; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_fired_triggers
    ADD CONSTRAINT pk_qrtz_fired_triggers PRIMARY KEY (sched_name, entry_id);


--
-- Name: qrtz_job_details pk_qrtz_job_details; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_job_details
    ADD CONSTRAINT pk_qrtz_job_details PRIMARY KEY (sched_name, job_name, job_group);


--
-- Name: qrtz_locks pk_qrtz_locks; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_locks
    ADD CONSTRAINT pk_qrtz_locks PRIMARY KEY (sched_name, lock_name);


--
-- Name: qrtz_scheduler_state pk_qrtz_scheduler_state; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_scheduler_state
    ADD CONSTRAINT pk_qrtz_scheduler_state PRIMARY KEY (sched_name, instance_name);


--
-- Name: qrtz_simple_triggers pk_qrtz_simple_triggers; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_simple_triggers
    ADD CONSTRAINT pk_qrtz_simple_triggers PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simprop_triggers pk_qrtz_simprop_triggers; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_simprop_triggers
    ADD CONSTRAINT pk_qrtz_simprop_triggers PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_triggers pk_qrtz_triggers; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_triggers
    ADD CONSTRAINT pk_qrtz_triggers PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_paused_trigger_grps pk_sched_name; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_paused_trigger_grps
    ADD CONSTRAINT pk_sched_name PRIMARY KEY (sched_name, trigger_group);


--
-- Name: pulse_card pulse_card_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_card
    ADD CONSTRAINT pulse_card_pkey PRIMARY KEY (id);


--
-- Name: pulse_channel pulse_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_channel
    ADD CONSTRAINT pulse_channel_pkey PRIMARY KEY (id);


--
-- Name: pulse_channel_recipient pulse_channel_recipient_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_channel_recipient
    ADD CONSTRAINT pulse_channel_recipient_pkey PRIMARY KEY (id);


--
-- Name: pulse pulse_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse
    ADD CONSTRAINT pulse_pkey PRIMARY KEY (id);


--
-- Name: query_cache query_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.query_cache
    ADD CONSTRAINT query_cache_pkey PRIMARY KEY (query_hash);


--
-- Name: query_execution query_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.query_execution
    ADD CONSTRAINT query_execution_pkey PRIMARY KEY (id);


--
-- Name: query query_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.query
    ADD CONSTRAINT query_pkey PRIMARY KEY (query_hash);


--
-- Name: report_card report_card_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT report_card_pkey PRIMARY KEY (id);


--
-- Name: report_card report_card_public_uuid_key; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT report_card_public_uuid_key UNIQUE (public_uuid);


--
-- Name: report_cardfavorite report_cardfavorite_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_cardfavorite
    ADD CONSTRAINT report_cardfavorite_pkey PRIMARY KEY (id);


--
-- Name: report_dashboard report_dashboard_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT report_dashboard_pkey PRIMARY KEY (id);


--
-- Name: report_dashboard report_dashboard_public_uuid_key; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT report_dashboard_public_uuid_key UNIQUE (public_uuid);


--
-- Name: report_dashboardcard report_dashboardcard_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboardcard
    ADD CONSTRAINT report_dashboardcard_pkey PRIMARY KEY (id);


--
-- Name: revision revision_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.revision
    ADD CONSTRAINT revision_pkey PRIMARY KEY (id);


--
-- Name: segment segment_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.segment
    ADD CONSTRAINT segment_pkey PRIMARY KEY (id);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (key);


--
-- Name: task_history task_history_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.task_history
    ADD CONSTRAINT task_history_pkey PRIMARY KEY (id);


--
-- Name: card_label unique_card_label_card_id_label_id; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.card_label
    ADD CONSTRAINT unique_card_label_card_id_label_id UNIQUE (card_id, label_id);


--
-- Name: collection unique_collection_personal_owner_id; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT unique_collection_personal_owner_id UNIQUE (personal_owner_id);


--
-- Name: dashboard_favorite unique_dashboard_favorite_user_id_dashboard_id; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboard_favorite
    ADD CONSTRAINT unique_dashboard_favorite_user_id_dashboard_id UNIQUE (user_id, dashboard_id);


--
-- Name: dimension unique_dimension_field_id_name; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dimension
    ADD CONSTRAINT unique_dimension_field_id_name UNIQUE (field_id, name);


--
-- Name: group_table_access_policy unique_gtap_table_id_group_id; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.group_table_access_policy
    ADD CONSTRAINT unique_gtap_table_id_group_id UNIQUE (table_id, group_id);


--
-- Name: metric_important_field unique_metric_important_field_metric_id_field_id; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric_important_field
    ADD CONSTRAINT unique_metric_important_field_metric_id_field_id UNIQUE (metric_id, field_id);


--
-- Name: permissions_group_membership unique_permissions_group_membership_user_id_group_id; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_group_membership
    ADD CONSTRAINT unique_permissions_group_membership_user_id_group_id UNIQUE (user_id, group_id);


--
-- Name: permissions_group unique_permissions_group_name; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_group
    ADD CONSTRAINT unique_permissions_group_name UNIQUE (name);


--
-- Name: view_log view_log_pkey; Type: CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.view_log
    ADD CONSTRAINT view_log_pkey PRIMARY KEY (id);


--
-- Name: idx_activity_custom_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_activity_custom_id ON public.activity USING btree (custom_id);


--
-- Name: idx_activity_timestamp; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_activity_timestamp ON public.activity USING btree ("timestamp");


--
-- Name: idx_activity_user_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_activity_user_id ON public.activity USING btree (user_id);


--
-- Name: idx_card_collection_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_card_collection_id ON public.report_card USING btree (collection_id);


--
-- Name: idx_card_creator_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_card_creator_id ON public.report_card USING btree (creator_id);


--
-- Name: idx_card_label_card_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_card_label_card_id ON public.card_label USING btree (card_id);


--
-- Name: idx_card_label_label_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_card_label_label_id ON public.card_label USING btree (label_id);


--
-- Name: idx_card_public_uuid; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_card_public_uuid ON public.report_card USING btree (public_uuid);


--
-- Name: idx_cardfavorite_card_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_cardfavorite_card_id ON public.report_cardfavorite USING btree (card_id);


--
-- Name: idx_cardfavorite_owner_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_cardfavorite_owner_id ON public.report_cardfavorite USING btree (owner_id);


--
-- Name: idx_collection_location; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_collection_location ON public.collection USING btree (location);


--
-- Name: idx_collection_personal_owner_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_collection_personal_owner_id ON public.collection USING btree (personal_owner_id);


--
-- Name: idx_dashboard_collection_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboard_collection_id ON public.report_dashboard USING btree (collection_id);


--
-- Name: idx_dashboard_creator_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboard_creator_id ON public.report_dashboard USING btree (creator_id);


--
-- Name: idx_dashboard_favorite_dashboard_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboard_favorite_dashboard_id ON public.dashboard_favorite USING btree (dashboard_id);


--
-- Name: idx_dashboard_favorite_user_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboard_favorite_user_id ON public.dashboard_favorite USING btree (user_id);


--
-- Name: idx_dashboard_public_uuid; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboard_public_uuid ON public.report_dashboard USING btree (public_uuid);


--
-- Name: idx_dashboardcard_card_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboardcard_card_id ON public.report_dashboardcard USING btree (card_id);


--
-- Name: idx_dashboardcard_dashboard_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboardcard_dashboard_id ON public.report_dashboardcard USING btree (dashboard_id);


--
-- Name: idx_dashboardcard_series_card_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboardcard_series_card_id ON public.dashboardcard_series USING btree (card_id);


--
-- Name: idx_dashboardcard_series_dashboardcard_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dashboardcard_series_dashboardcard_id ON public.dashboardcard_series USING btree (dashboardcard_id);


--
-- Name: idx_data_migrations_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_data_migrations_id ON public.data_migrations USING btree (id);


--
-- Name: idx_dependency_dependent_on_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dependency_dependent_on_id ON public.dependency USING btree (dependent_on_id);


--
-- Name: idx_dependency_dependent_on_model; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dependency_dependent_on_model ON public.dependency USING btree (dependent_on_model);


--
-- Name: idx_dependency_model; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dependency_model ON public.dependency USING btree (model);


--
-- Name: idx_dependency_model_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dependency_model_id ON public.dependency USING btree (model_id);


--
-- Name: idx_dimension_field_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_dimension_field_id ON public.dimension USING btree (field_id);


--
-- Name: idx_field_parent_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_field_parent_id ON public.metabase_field USING btree (parent_id);


--
-- Name: idx_field_table_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_field_table_id ON public.metabase_field USING btree (table_id);


--
-- Name: idx_fieldvalues_field_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_fieldvalues_field_id ON public.metabase_fieldvalues USING btree (field_id);


--
-- Name: idx_gtap_table_id_group_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_gtap_table_id_group_id ON public.group_table_access_policy USING btree (table_id, group_id);


--
-- Name: idx_label_slug; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_label_slug ON public.label USING btree (slug);


--
-- Name: idx_lower_email; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_lower_email ON public.core_user USING btree (lower((email)::text));


--
-- Name: idx_metabase_table_db_id_schema; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_metabase_table_db_id_schema ON public.metabase_table USING btree (db_id, schema);


--
-- Name: idx_metabase_table_show_in_getting_started; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_metabase_table_show_in_getting_started ON public.metabase_table USING btree (show_in_getting_started);


--
-- Name: idx_metric_creator_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_metric_creator_id ON public.metric USING btree (creator_id);


--
-- Name: idx_metric_important_field_field_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_metric_important_field_field_id ON public.metric_important_field USING btree (field_id);


--
-- Name: idx_metric_important_field_metric_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_metric_important_field_metric_id ON public.metric_important_field USING btree (metric_id);


--
-- Name: idx_metric_show_in_getting_started; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_metric_show_in_getting_started ON public.metric USING btree (show_in_getting_started);


--
-- Name: idx_metric_table_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_metric_table_id ON public.metric USING btree (table_id);


--
-- Name: idx_permissions_group_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_permissions_group_id ON public.permissions USING btree (group_id);


--
-- Name: idx_permissions_group_id_object; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_permissions_group_id_object ON public.permissions USING btree (group_id, object);


--
-- Name: idx_permissions_group_membership_group_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_permissions_group_membership_group_id ON public.permissions_group_membership USING btree (group_id);


--
-- Name: idx_permissions_group_membership_group_id_user_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_permissions_group_membership_group_id_user_id ON public.permissions_group_membership USING btree (group_id, user_id);


--
-- Name: idx_permissions_group_membership_user_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_permissions_group_membership_user_id ON public.permissions_group_membership USING btree (user_id);


--
-- Name: idx_permissions_group_name; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_permissions_group_name ON public.permissions_group USING btree (name);


--
-- Name: idx_permissions_object; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_permissions_object ON public.permissions USING btree (object);


--
-- Name: idx_pulse_card_card_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_pulse_card_card_id ON public.pulse_card USING btree (card_id);


--
-- Name: idx_pulse_card_pulse_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_pulse_card_pulse_id ON public.pulse_card USING btree (pulse_id);


--
-- Name: idx_pulse_channel_pulse_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_pulse_channel_pulse_id ON public.pulse_channel USING btree (pulse_id);


--
-- Name: idx_pulse_channel_schedule_type; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_pulse_channel_schedule_type ON public.pulse_channel USING btree (schedule_type);


--
-- Name: idx_pulse_collection_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_pulse_collection_id ON public.pulse USING btree (collection_id);


--
-- Name: idx_pulse_creator_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_pulse_creator_id ON public.pulse USING btree (creator_id);


--
-- Name: idx_qrtz_ft_inst_job_req_rcvry; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_ft_inst_job_req_rcvry ON public.qrtz_fired_triggers USING btree (sched_name, instance_name, requests_recovery);


--
-- Name: idx_qrtz_ft_j_g; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_ft_j_g ON public.qrtz_fired_triggers USING btree (sched_name, job_name, job_group);


--
-- Name: idx_qrtz_ft_jg; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_ft_jg ON public.qrtz_fired_triggers USING btree (sched_name, job_group);


--
-- Name: idx_qrtz_ft_t_g; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_ft_t_g ON public.qrtz_fired_triggers USING btree (sched_name, trigger_name, trigger_group);


--
-- Name: idx_qrtz_ft_tg; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_ft_tg ON public.qrtz_fired_triggers USING btree (sched_name, trigger_group);


--
-- Name: idx_qrtz_ft_trig_inst_name; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_ft_trig_inst_name ON public.qrtz_fired_triggers USING btree (sched_name, instance_name);


--
-- Name: idx_qrtz_j_grp; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_j_grp ON public.qrtz_job_details USING btree (sched_name, job_group);


--
-- Name: idx_qrtz_j_req_recovery; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_j_req_recovery ON public.qrtz_job_details USING btree (sched_name, requests_recovery);


--
-- Name: idx_qrtz_t_c; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_c ON public.qrtz_triggers USING btree (sched_name, calendar_name);


--
-- Name: idx_qrtz_t_g; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_g ON public.qrtz_triggers USING btree (sched_name, trigger_group);


--
-- Name: idx_qrtz_t_j; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_j ON public.qrtz_triggers USING btree (sched_name, job_name, job_group);


--
-- Name: idx_qrtz_t_jg; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_jg ON public.qrtz_triggers USING btree (sched_name, job_group);


--
-- Name: idx_qrtz_t_n_g_state; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_n_g_state ON public.qrtz_triggers USING btree (sched_name, trigger_group, trigger_state);


--
-- Name: idx_qrtz_t_n_state; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_n_state ON public.qrtz_triggers USING btree (sched_name, trigger_name, trigger_group, trigger_state);


--
-- Name: idx_qrtz_t_next_fire_time; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_next_fire_time ON public.qrtz_triggers USING btree (sched_name, next_fire_time);


--
-- Name: idx_qrtz_t_nft_misfire; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_nft_misfire ON public.qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time);


--
-- Name: idx_qrtz_t_nft_st; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_nft_st ON public.qrtz_triggers USING btree (sched_name, trigger_state, next_fire_time);


--
-- Name: idx_qrtz_t_nft_st_misfire; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_nft_st_misfire ON public.qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time, trigger_state);


--
-- Name: idx_qrtz_t_nft_st_misfire_grp; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_nft_st_misfire_grp ON public.qrtz_triggers USING btree (sched_name, misfire_instr, next_fire_time, trigger_group, trigger_state);


--
-- Name: idx_qrtz_t_state; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_qrtz_t_state ON public.qrtz_triggers USING btree (sched_name, trigger_state);


--
-- Name: idx_query_cache_updated_at; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_query_cache_updated_at ON public.query_cache USING btree (updated_at);


--
-- Name: idx_query_execution_query_hash_started_at; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_query_execution_query_hash_started_at ON public.query_execution USING btree (hash, started_at);


--
-- Name: idx_query_execution_started_at; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_query_execution_started_at ON public.query_execution USING btree (started_at);


--
-- Name: idx_report_dashboard_show_in_getting_started; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_report_dashboard_show_in_getting_started ON public.report_dashboard USING btree (show_in_getting_started);


--
-- Name: idx_revision_model_model_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_revision_model_model_id ON public.revision USING btree (model, model_id);


--
-- Name: idx_segment_creator_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_segment_creator_id ON public.segment USING btree (creator_id);


--
-- Name: idx_segment_show_in_getting_started; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_segment_show_in_getting_started ON public.segment USING btree (show_in_getting_started);


--
-- Name: idx_segment_table_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_segment_table_id ON public.segment USING btree (table_id);


--
-- Name: idx_session_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_session_id ON public.login_history USING btree (session_id);


--
-- Name: idx_snippet_collection_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_snippet_collection_id ON public.native_query_snippet USING btree (collection_id);


--
-- Name: idx_snippet_name; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_snippet_name ON public.native_query_snippet USING btree (name);


--
-- Name: idx_table_db_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_table_db_id ON public.metabase_table USING btree (db_id);


--
-- Name: idx_task_history_db_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_task_history_db_id ON public.task_history USING btree (db_id);


--
-- Name: idx_task_history_end_time; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_task_history_end_time ON public.task_history USING btree (ended_at);


--
-- Name: idx_timestamp; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_timestamp ON public.login_history USING btree ("timestamp");


--
-- Name: idx_uniq_field_table_id_parent_id_name_2col; Type: INDEX; Schema: public; Owner: metabase
--

CREATE UNIQUE INDEX idx_uniq_field_table_id_parent_id_name_2col ON public.metabase_field USING btree (table_id, name) WHERE (parent_id IS NULL);


--
-- Name: idx_uniq_table_db_id_schema_name_2col; Type: INDEX; Schema: public; Owner: metabase
--

CREATE UNIQUE INDEX idx_uniq_table_db_id_schema_name_2col ON public.metabase_table USING btree (db_id, name) WHERE (schema IS NULL);


--
-- Name: idx_user_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_user_id ON public.login_history USING btree (user_id);


--
-- Name: idx_user_id_device_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_user_id_device_id ON public.login_history USING btree (session_id, device_id);


--
-- Name: idx_user_id_timestamp; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_user_id_timestamp ON public.login_history USING btree (user_id, "timestamp");


--
-- Name: idx_view_log_timestamp; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_view_log_timestamp ON public.view_log USING btree (model_id);


--
-- Name: idx_view_log_user_id; Type: INDEX; Schema: public; Owner: metabase
--

CREATE INDEX idx_view_log_user_id ON public.view_log USING btree (user_id);


--
-- Name: activity fk_activity_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT fk_activity_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: report_card fk_card_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_card_collection_id FOREIGN KEY (collection_id) REFERENCES public.collection(id) ON DELETE SET NULL;


--
-- Name: card_label fk_card_label_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.card_label
    ADD CONSTRAINT fk_card_label_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id) ON DELETE CASCADE;


--
-- Name: card_label fk_card_label_ref_label_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.card_label
    ADD CONSTRAINT fk_card_label_ref_label_id FOREIGN KEY (label_id) REFERENCES public.label(id) ON DELETE CASCADE;


--
-- Name: report_card fk_card_made_public_by_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_card_made_public_by_id FOREIGN KEY (made_public_by_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: report_card fk_card_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_card_ref_user_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: report_cardfavorite fk_cardfavorite_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_cardfavorite
    ADD CONSTRAINT fk_cardfavorite_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id) ON DELETE CASCADE;


--
-- Name: report_cardfavorite fk_cardfavorite_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_cardfavorite
    ADD CONSTRAINT fk_cardfavorite_ref_user_id FOREIGN KEY (owner_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: collection fk_collection_personal_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT fk_collection_personal_owner_id FOREIGN KEY (personal_owner_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: collection_revision fk_collection_revision_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.collection_revision
    ADD CONSTRAINT fk_collection_revision_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: computation_job fk_computation_job_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.computation_job
    ADD CONSTRAINT fk_computation_job_ref_user_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: computation_job_result fk_computation_result_ref_job_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.computation_job_result
    ADD CONSTRAINT fk_computation_result_ref_job_id FOREIGN KEY (job_id) REFERENCES public.computation_job(id) ON DELETE CASCADE;


--
-- Name: report_dashboard fk_dashboard_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT fk_dashboard_collection_id FOREIGN KEY (collection_id) REFERENCES public.collection(id) ON DELETE SET NULL;


--
-- Name: dashboard_favorite fk_dashboard_favorite_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboard_favorite
    ADD CONSTRAINT fk_dashboard_favorite_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES public.report_dashboard(id) ON DELETE CASCADE;


--
-- Name: dashboard_favorite fk_dashboard_favorite_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboard_favorite
    ADD CONSTRAINT fk_dashboard_favorite_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: report_dashboard fk_dashboard_made_public_by_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT fk_dashboard_made_public_by_id FOREIGN KEY (made_public_by_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: report_dashboard fk_dashboard_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboard
    ADD CONSTRAINT fk_dashboard_ref_user_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: report_dashboardcard fk_dashboardcard_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboardcard
    ADD CONSTRAINT fk_dashboardcard_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id) ON DELETE CASCADE;


--
-- Name: report_dashboardcard fk_dashboardcard_ref_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_dashboardcard
    ADD CONSTRAINT fk_dashboardcard_ref_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES public.report_dashboard(id) ON DELETE CASCADE;


--
-- Name: dashboardcard_series fk_dashboardcard_series_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboardcard_series
    ADD CONSTRAINT fk_dashboardcard_series_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id) ON DELETE CASCADE;


--
-- Name: dashboardcard_series fk_dashboardcard_series_ref_dashboardcard_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dashboardcard_series
    ADD CONSTRAINT fk_dashboardcard_series_ref_dashboardcard_id FOREIGN KEY (dashboardcard_id) REFERENCES public.report_dashboardcard(id) ON DELETE CASCADE;


--
-- Name: dimension fk_dimension_displayfk_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dimension
    ADD CONSTRAINT fk_dimension_displayfk_ref_field_id FOREIGN KEY (human_readable_field_id) REFERENCES public.metabase_field(id) ON DELETE CASCADE;


--
-- Name: dimension fk_dimension_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.dimension
    ADD CONSTRAINT fk_dimension_ref_field_id FOREIGN KEY (field_id) REFERENCES public.metabase_field(id) ON DELETE CASCADE;


--
-- Name: metabase_field fk_field_parent_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_field
    ADD CONSTRAINT fk_field_parent_ref_field_id FOREIGN KEY (parent_id) REFERENCES public.metabase_field(id) ON DELETE CASCADE;


--
-- Name: metabase_field fk_field_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_field
    ADD CONSTRAINT fk_field_ref_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id) ON DELETE CASCADE;


--
-- Name: metabase_fieldvalues fk_fieldvalues_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_fieldvalues
    ADD CONSTRAINT fk_fieldvalues_ref_field_id FOREIGN KEY (field_id) REFERENCES public.metabase_field(id) ON DELETE CASCADE;


--
-- Name: group_table_access_policy fk_gtap_card_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.group_table_access_policy
    ADD CONSTRAINT fk_gtap_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id) ON DELETE CASCADE;


--
-- Name: group_table_access_policy fk_gtap_group_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.group_table_access_policy
    ADD CONSTRAINT fk_gtap_group_id FOREIGN KEY (group_id) REFERENCES public.permissions_group(id) ON DELETE CASCADE;


--
-- Name: group_table_access_policy fk_gtap_table_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.group_table_access_policy
    ADD CONSTRAINT fk_gtap_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id) ON DELETE CASCADE;


--
-- Name: login_history fk_login_history_session_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT fk_login_history_session_id FOREIGN KEY (session_id) REFERENCES public.core_session(id) ON DELETE SET NULL;


--
-- Name: login_history fk_login_history_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT fk_login_history_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: metric_important_field fk_metric_important_field_metabase_field_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric_important_field
    ADD CONSTRAINT fk_metric_important_field_metabase_field_id FOREIGN KEY (field_id) REFERENCES public.metabase_field(id) ON DELETE CASCADE;


--
-- Name: metric_important_field fk_metric_important_field_metric_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric_important_field
    ADD CONSTRAINT fk_metric_important_field_metric_id FOREIGN KEY (metric_id) REFERENCES public.metric(id) ON DELETE CASCADE;


--
-- Name: metric fk_metric_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric
    ADD CONSTRAINT fk_metric_ref_creator_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: metric fk_metric_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metric
    ADD CONSTRAINT fk_metric_ref_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id) ON DELETE CASCADE;


--
-- Name: permissions_group_membership fk_permissions_group_group_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_group_membership
    ADD CONSTRAINT fk_permissions_group_group_id FOREIGN KEY (group_id) REFERENCES public.permissions_group(id) ON DELETE CASCADE;


--
-- Name: permissions fk_permissions_group_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT fk_permissions_group_id FOREIGN KEY (group_id) REFERENCES public.permissions_group(id) ON DELETE CASCADE;


--
-- Name: permissions_group_membership fk_permissions_group_membership_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_group_membership
    ADD CONSTRAINT fk_permissions_group_membership_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: permissions_revision fk_permissions_revision_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.permissions_revision
    ADD CONSTRAINT fk_permissions_revision_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: pulse_card fk_pulse_card_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_card_id FOREIGN KEY (card_id) REFERENCES public.report_card(id) ON DELETE CASCADE;


--
-- Name: pulse_card fk_pulse_card_ref_pulse_card_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_pulse_card_id FOREIGN KEY (dashboard_card_id) REFERENCES public.report_dashboardcard(id) ON DELETE CASCADE;


--
-- Name: pulse_card fk_pulse_card_ref_pulse_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_pulse_id FOREIGN KEY (pulse_id) REFERENCES public.pulse(id) ON DELETE CASCADE;


--
-- Name: pulse_channel_recipient fk_pulse_channel_recipient_ref_pulse_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_channel_recipient
    ADD CONSTRAINT fk_pulse_channel_recipient_ref_pulse_channel_id FOREIGN KEY (pulse_channel_id) REFERENCES public.pulse_channel(id) ON DELETE CASCADE;


--
-- Name: pulse_channel_recipient fk_pulse_channel_recipient_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_channel_recipient
    ADD CONSTRAINT fk_pulse_channel_recipient_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: pulse_channel fk_pulse_channel_ref_pulse_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse_channel
    ADD CONSTRAINT fk_pulse_channel_ref_pulse_id FOREIGN KEY (pulse_id) REFERENCES public.pulse(id) ON DELETE CASCADE;


--
-- Name: pulse fk_pulse_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse
    ADD CONSTRAINT fk_pulse_collection_id FOREIGN KEY (collection_id) REFERENCES public.collection(id) ON DELETE SET NULL;


--
-- Name: pulse fk_pulse_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse
    ADD CONSTRAINT fk_pulse_ref_creator_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: pulse fk_pulse_ref_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.pulse
    ADD CONSTRAINT fk_pulse_ref_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES public.report_dashboard(id) ON DELETE CASCADE;


--
-- Name: qrtz_blob_triggers fk_qrtz_blob_triggers_triggers; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_blob_triggers
    ADD CONSTRAINT fk_qrtz_blob_triggers_triggers FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_cron_triggers fk_qrtz_cron_triggers_triggers; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_cron_triggers
    ADD CONSTRAINT fk_qrtz_cron_triggers_triggers FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simple_triggers fk_qrtz_simple_triggers_triggers; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_simple_triggers
    ADD CONSTRAINT fk_qrtz_simple_triggers_triggers FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simprop_triggers fk_qrtz_simprop_triggers_triggers; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_simprop_triggers
    ADD CONSTRAINT fk_qrtz_simprop_triggers_triggers FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_triggers fk_qrtz_triggers_job_details; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.qrtz_triggers
    ADD CONSTRAINT fk_qrtz_triggers_job_details FOREIGN KEY (sched_name, job_name, job_group) REFERENCES public.qrtz_job_details(sched_name, job_name, job_group);


--
-- Name: report_card fk_report_card_ref_database_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_report_card_ref_database_id FOREIGN KEY (database_id) REFERENCES public.metabase_database(id) ON DELETE CASCADE;


--
-- Name: report_card fk_report_card_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.report_card
    ADD CONSTRAINT fk_report_card_ref_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id) ON DELETE CASCADE;


--
-- Name: revision fk_revision_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.revision
    ADD CONSTRAINT fk_revision_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: segment fk_segment_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.segment
    ADD CONSTRAINT fk_segment_ref_creator_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: segment fk_segment_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.segment
    ADD CONSTRAINT fk_segment_ref_table_id FOREIGN KEY (table_id) REFERENCES public.metabase_table(id) ON DELETE CASCADE;


--
-- Name: core_session fk_session_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.core_session
    ADD CONSTRAINT fk_session_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: native_query_snippet fk_snippet_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.native_query_snippet
    ADD CONSTRAINT fk_snippet_collection_id FOREIGN KEY (collection_id) REFERENCES public.collection(id) ON DELETE SET NULL;


--
-- Name: native_query_snippet fk_snippet_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.native_query_snippet
    ADD CONSTRAINT fk_snippet_creator_id FOREIGN KEY (creator_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- Name: metabase_table fk_table_ref_database_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.metabase_table
    ADD CONSTRAINT fk_table_ref_database_id FOREIGN KEY (db_id) REFERENCES public.metabase_database(id) ON DELETE CASCADE;


--
-- Name: view_log fk_view_log_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: metabase
--

ALTER TABLE ONLY public.view_log
    ADD CONSTRAINT fk_view_log_ref_user_id FOREIGN KEY (user_id) REFERENCES public.core_user(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


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
2	/frames/2021-06/ri00000001/00000002.png	1	3	-23.23743886267635	-45.92449031049118	\N	\N	\N
3	/frames/2021-06/ri00000001/00000003.png	1	2	-23.23741886267635	-45.92447031049118	\N	\N	\N
4	/frames/2021-06/ri00000001/00000004.png	1	1	-23.23740886267635	-45.92445031049118	0.15	0.81	0.55
5	/frames/2021-06/ri00000001/00000005.png	1	3	-23.23742886267635	-45.92448031049118	\N	\N	\N
6	/frames/2021-06/ri00000001/00000006.png	1	3	-23.23742886267635	-45.92448031049118	\N	\N	\N
7	/frames/2021-06/ri00000001/00000007.png	1	3	-23.23742886267635	-45.92448031049118	\N	\N	\N
9	/frames/2021-06/ri00000003/00000001.png	3	1	-23.23841	-45.924419	0.09	0.51	0.27
1	/frames/2021-06/ri00000001/00000001.png	1	1	-23.23762886267635	-45.92468031049118	0.07	0.41	0.35
8	/frames/2021-06/ri00000002/00000001.png	2	1	-23.238362	-45.92262	0.03	0.21	0.25
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

--
-- PostgreSQL database cluster dump complete
--

