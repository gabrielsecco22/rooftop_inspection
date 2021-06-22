create role metabase LOGIN password 'metabase';
create database metabase owner = metabase;

-- public.rooftop_frame_diagnostic definition

-- Drop table

-- DROP TABLE public.rooftop_frame_diagnostic;

CREATE TABLE public.rooftop_frame_diagnostic (
	id serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT rooftop_frame_diagnostic_pk PRIMARY KEY (id)
);

-- public.customer definition

-- Drop table

-- DROP TABLE public.customer;

CREATE TABLE public.customer (
	"name" varchar NOT NULL,
	cnpj varchar NOT NULL,
	is_active bool NOT NULL,
	id serial NOT NULL,
	CONSTRAINT customer_pk PRIMARY KEY (id)
);


-- public.rooftop_inspection_status definition

-- Drop table

-- DROP TABLE public.rooftop_inspection_status;

CREATE TABLE public.rooftop_inspection_status (
	id serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT rooftop_inspection_status_pk PRIMARY KEY (id)
);

-- public.crew definition

-- Drop table

-- DROP TABLE public.crew;

CREATE TABLE public.crew (
	id serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT crew_pk PRIMARY KEY (id)
);


-- public.staff definition

-- Drop table

-- DROP TABLE public.staff;

CREATE TABLE public.staff (
	id serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT staff_pk PRIMARY KEY (id)
);



-- public.rooftop definition

-- Drop table

-- DROP TABLE public.rooftop;

CREATE TABLE public.rooftop (
	id serial NOT NULL,
	description varchar NULL,
	customer_id int4 NOT NULL,
	latitude float8 NULL,
	longitude float8 NULL,
	CONSTRAINT rooftop_pk PRIMARY KEY (id),
	CONSTRAINT rooftop_fk FOREIGN KEY (customer_id) REFERENCES public.customer(id)
);

-- public.customer_contact definition

-- Drop table

-- DROP TABLE public.customer_contact;

CREATE TABLE public.customer_contact (
	id serial NOT NULL,
	"name" varchar NOT NULL,
	phone varchar NULL,
	email varchar NULL,
	customer_id int4 NOT NULL,
	CONSTRAINT customer_contact_pk PRIMARY KEY (id),
	CONSTRAINT customer_contact_fk FOREIGN KEY (customer_id) REFERENCES public.customer(id)
);


-- public.staff_crew_assoc definition

-- Drop table

-- DROP TABLE public.staff_crew_assoc;

CREATE TABLE public.staff_crew_assoc (
	id serial NOT NULL,
	crew_id int4 NOT NULL,
	staff_id int4 NOT NULL,
	CONSTRAINT staff_crew_assoc_pk PRIMARY KEY (id),
	CONSTRAINT crew_fk FOREIGN KEY (crew_id) REFERENCES public.crew(id),
	CONSTRAINT staff_fk FOREIGN KEY (staff_id) REFERENCES public.staff(id)
);


-- public.rooftop_inspection definition

-- Drop table

-- DROP TABLE public.rooftop_inspection;

CREATE TABLE public.rooftop_inspection (
	id serial NOT NULL,
	description varchar NULL,
	inspection_time timestamp(0) NULL,
	crew_id int4 NULL,
	rooftop_id int4 NOT NULL,
	start_time timestamp(0) NULL,
	end_time timestamp(0) NULL,
	created_at timestamp(0) NOT NULL,
	rooftop_inspection_status_id int4 NOT NULL,
	CONSTRAINT rooftop_inspection_pk PRIMARY KEY (id),
	CONSTRAINT crew_fk FOREIGN KEY (crew_id) REFERENCES public.crew(id),
	CONSTRAINT rooftop_inspection_fk FOREIGN KEY (rooftop_id) REFERENCES public.rooftop(id),
	CONSTRAINT rooftop_inspection_status_fk FOREIGN KEY (rooftop_inspection_status_id) REFERENCES public.rooftop_inspection_status(id)
);


-- public.rooftop_inspection_frame definition

-- Drop table

-- DROP TABLE public.rooftop_inspection_frame;

CREATE TABLE public.rooftop_inspection_frame (
	id serial NOT NULL,
	frame_path varchar NOT NULL,
	rooftop_inspection_id int4 NOT NULL,
	rooftop_frame_diagnostic_id int4 NULL,
	latitude float8 NULL,
	longitude float8 NULL,
	area float4 NULL,
	length float4 NULL,
	width float4 NULL,
	CONSTRAINT rooftop_inspection_frames_pk PRIMARY KEY (id),
	CONSTRAINT rooftop_frame_diagnostic_fk FOREIGN KEY (rooftop_frame_diagnostic_id) REFERENCES public.rooftop_frame_diagnostic(id),
	CONSTRAINT rooftop_inspection_frame_fk FOREIGN KEY (rooftop_inspection_id) REFERENCES public.rooftop_inspection(id)
);

-- Permissions

--ALTER TABLE public.rooftop_inspection_frame OWNER TO app;
--GRANT ALL ON TABLE public.rooftop_inspection_frame TO app;
--ALTER TABLE public.rooftop_inspection OWNER TO app;
--GRANT ALL ON TABLE public.rooftop_inspection TO app;
--ALTER TABLE public.staff_crew_assoc OWNER TO app;
--GRANT ALL ON TABLE public.staff_crew_assoc TO app;
--ALTER TABLE public.customer_contact OWNER TO app;
--GRANT ALL ON TABLE public.customer_contact TO app;
--ALTER TABLE public.rooftop OWNER TO app;
--GRANT ALL ON TABLE public.rooftop TO app;
--ALTER TABLE public.staff OWNER TO app;
--GRANT ALL ON TABLE public.staff TO app;
--ALTER TABLE public.crew OWNER TO app;
--GRANT ALL ON TABLE public.crew TO app;
--ALTER TABLE public.rooftop_inspection_status OWNER TO app;
--GRANT ALL ON TABLE public.rooftop_inspection_status TO app;
--ALTER TABLE public.customer OWNER TO app;
--GRANT ALL ON TABLE public.customer TO app;
--ALTER TABLE public.rooftop_frame_diagnostic OWNER TO app;
--GRANT ALL ON TABLE public.rooftop_frame_diagnostic TO app;