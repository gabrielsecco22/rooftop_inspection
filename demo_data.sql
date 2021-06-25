INSERT INTO public.customer
("name", cnpj, is_active)
VALUES('INSTITUTO TECNOLÓGICO DE AERONÁUTICA', '00.394.429/0020-73', true);

INSERT INTO public.customer_contact
("name", phone, email, customer_id)
VALUES('Foolano de Tal', '+5512987654321', 'foolano@ita.br', 2);

INSERT INTO public.rooftop
(description, customer_id, latitude, longitude, area)
VALUES('Divisão de Ciência da Computação', 2, -23.209458, -45.874353, 5600);

INSERT INTO public.inspection
(description)
VALUES('Inspeção no ITA');

INSERT INTO public.rooftop_inspection
(description, inspection_time, crew_id, rooftop_id, start_time, end_time, created_at, rooftop_inspection_status_id, inspection_id)
VALUES('Telhado da COMP', '2020-06-25 08:00:00'::timestamp, 1, 4, '2020-06-25 10:15:25'::timestamp, '2020-06-25 15:36:17'::timestamp, '2020-06-24 22:02:37'::timestamp, 3, 2);

INSERT INTO public.rooftop_inspection_frame
(frame_path, rooftop_inspection_id, rooftop_frame_diagnostic_id, latitude, longitude, area, length, width)
VALUES('/frames/2021-06/ri00000004/00000001.png', 4, 1, -23.209458, -45.874353, 0.15, 0.61, 0.47);
