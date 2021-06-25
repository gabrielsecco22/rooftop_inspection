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
	inspection_id int4 NULL,
	CONSTRAINT rooftop_inspection_pk PRIMARY KEY (id)
);


-- public.rooftop_inspection foreign keys

ALTER TABLE public.rooftop_inspection ADD CONSTRAINT crew_fk FOREIGN KEY (crew_id) REFERENCES public.crew(id);
ALTER TABLE public.rooftop_inspection ADD CONSTRAINT inspection_fk FOREIGN KEY (inspection_id) REFERENCES public.inspection(id);
ALTER TABLE public.rooftop_inspection ADD CONSTRAINT rooftop_inspection_fk FOREIGN KEY (rooftop_id) REFERENCES public.rooftop(id);
ALTER TABLE public.rooftop_inspection ADD CONSTRAINT rooftop_inspection_status_fk FOREIGN KEY (rooftop_inspection_status_id) REFERENCES public.rooftop_inspection_status(id);