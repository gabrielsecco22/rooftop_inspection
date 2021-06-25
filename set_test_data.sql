
INSERT INTO public.crew
(name)
VALUES('Equipe Alfa');

INSERT INTO public.staff
("name", crew_id)
VALUES('Gabriel', 1);

INSERT INTO public.staff
("name", crew_id)
VALUES('Odair', 1);

INSERT INTO public.staff
("name", crew_id)
VALUES('Nilson', 1);

INSERT INTO public.staff
("name", crew_id)
VALUES('Thiago', 1);

INSERT INTO public.customer
("name", cnpj, is_active)
VALUES('JOHNSON & JOHNSON INDUSTRIAL LTDA', '59.748.988/0001-14', true);

INSERT INTO public.customer_contact
("name", phone, email, customer_id)
VALUES('Foolano de Tal', '+5512987654321', 'ftal@teste.com', 1);

INSERT INTO public.rooftop
(description, customer_id, latitude, longitude, area)
VALUES('Sampro - Fabrica de Absorventes', 1, -23.23742886267635, -45.92448031049118, 1780);

INSERT INTO public.rooftop
(description, customer_id, latitude, longitude, area)
VALUES('Perfex', 1, -23.238700, -45.922927, 1420);

INSERT INTO public.rooftop
(description, customer_id, latitude, longitude, area)
VALUES('Fabrica de Fraldas', 1, -23.238065, -45.924102, 3760);

INSERT INTO public.rooftop_frame_diagnostic
("name")
VALUES('Avaria');

INSERT INTO public.rooftop_frame_diagnostic
("name")
VALUES('Intederminado');

INSERT INTO public.rooftop_frame_diagnostic
("name")
VALUES('Bom estado');

INSERT INTO public.rooftop_inspection_status
("name")
VALUES('Criado');

INSERT INTO public.rooftop_inspection_status
("name")
VALUES('Agendado');

INSERT INTO public.rooftop_inspection_status
("name")
VALUES('Finalizado');

INSERT INTO public.rooftop_inspection_status
("name")
VALUES('Cancelado');

INSERT INTO public.inspection
(description)
VALUES('Inspecao JOHNSON & JOHNSON SJC');


INSERT INTO public.rooftop_inspection
(description, inspection_time, crew_id, rooftop_id, start_time, end_time, created_at, rooftop_inspection_status_id, inspection_id)
VALUES('Telhado Sampro', '2020-06-24 08:00:00'::timestamp, 1, 1, '2020-06-24 08:35:26'::timestamp, '2020-06-24 11:34:37'::timestamp, '2020-06-23 09:37:37'::timestamp, 3, 1);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000001/00000001.png', 1, 1, -23.23742886267635, -45.92448031049118, 0.07, 0.41, 0.35);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000001/00000002.png', 1, 3, -23.23743886267635, -45.92449031049118, null, null, null);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000001/00000003.png', 1, 2, -23.23741886267635, -45.92447031049118, null, null, null);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000001/00000004.png', 1, 1, -23.23740886267635, -45.92445031049118, 0.15, 0.81, 0.55);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000001/00000005.png', 1, 3, -23.23742886267635, -45.92448031049118, null, null, null);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000001/00000006.png', 1, 3, -23.23742886267635, -45.92448031049118, null, null, null);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000001/00000007.png', 1, 3, -23.23742886267635, -45.92448031049118, null, null, null);


INSERT INTO public.rooftop_inspection
(description, inspection_time, crew_id, rooftop_id, start_time, end_time, created_at, rooftop_inspection_status_id, inspection_id)
VALUES('Telhado perfex', '2020-06-25 09:00:00'::timestamp, 1, 2, '2020-06-25 09:35:26'::timestamp, '2020-06-25 10:52:47'::timestamp, '2020-06-23 09:37:37'::timestamp, 3, 1);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000002/00000001.png', 2, 1, -23.238762, -45.923120, 0.03, 0.21, 0.25);

INSERT INTO public.rooftop_inspection
(description, inspection_time, crew_id, rooftop_id, start_time, end_time, created_at, rooftop_inspection_status_id, inspection_id)
VALUES('Telhado Fabrica de Fraldas', '2020-06-26 08:00:00'::timestamp, 1, 3, '2020-06-26 08:05:16'::timestamp, '2020-06-26 10:23:02'::timestamp, '2020-06-23 09:41:27'::timestamp, 3, 1);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000003/00000001.png', 3, 1, -23.238410, -45.924419, 0.09, 0.51, 0.27);

