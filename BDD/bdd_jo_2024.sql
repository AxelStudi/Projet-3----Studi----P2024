--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Homebrew)
-- Dumped by pg_dump version 17.0 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: nom_de_l_ad
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO nom_de_l_ad;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: nom_de_l_ad
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_offer; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.api_offer (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    price numeric(10,2) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.api_offer OWNER TO jo2024user;

--
-- Name: api_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.api_offer ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_offer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_order; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.api_order (
    id bigint NOT NULL,
    total_price numeric(10,2) NOT NULL,
    status character varying(50) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE public.api_order OWNER TO jo2024user;

--
-- Name: api_order_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.api_order ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_orderitem; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.api_orderitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    offer_id bigint NOT NULL,
    order_id bigint NOT NULL,
    CONSTRAINT api_orderitem_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.api_orderitem OWNER TO jo2024user;

--
-- Name: api_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.api_orderitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_ticket; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.api_ticket (
    id bigint NOT NULL,
    event_name character varying(255) NOT NULL,
    ticket_number character varying(100) NOT NULL,
    issued_at timestamp with time zone NOT NULL,
    qr_code character varying(100),
    order_item_id bigint NOT NULL
);


ALTER TABLE public.api_ticket OWNER TO jo2024user;

--
-- Name: api_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.api_ticket ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO jo2024user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO jo2024user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO jo2024user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO jo2024user;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO jo2024user;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO jo2024user;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO jo2024user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO jo2024user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO jo2024user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: jo2024user
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: jo2024user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO jo2024user;

--
-- Data for Name: api_offer; Type: TABLE DATA; Schema: public; Owner: jo2024user
--

INSERT INTO public.api_offer VALUES (1, 'Solo', 'Accès individuel aux événements avec flexibilité maximale.', 50.00, '2024-10-23 12:02:25.999007+02', '2024-10-23 12:02:52.003866+02');
INSERT INTO public.api_offer VALUES (2, 'Duo', 'Accès pour deux personnes avec des avantages supplémentaires.', 90.00, '2024-10-23 12:20:29.490128+02', '2024-10-23 12:20:29.490143+02');
INSERT INTO public.api_offer VALUES (3, 'Famille', 'Accès pour une famille de quatre personnes avec des avantages exclusifs.', 150.00, '2024-10-23 12:21:26.626889+02', '2024-10-23 12:21:26.626903+02');


--
-- Data for Name: api_order; Type: TABLE DATA; Schema: public; Owner: jo2024user
--



--
-- Data for Name: api_orderitem; Type: TABLE DATA; Schema: public; Owner: jo2024user
--



--
-- Data for Name: api_ticket; Type: TABLE DATA; Schema: public; Owner: jo2024user
--



--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: jo2024user
--



--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: jo2024user
--



--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: jo2024user
--




--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: jo2024user
--


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: jo2024user
--



--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: jo2024user
--



--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: jo2024user
--

INSERT INTO public.django_admin_log VALUES (1, '2024-10-22 14:02:16.061876+02', '2', 'User', 1, '[{"added": {}}]', 3, 1);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: jo2024user
--

INSERT INTO public.django_content_type VALUES (1, 'auth', 'permission');
INSERT INTO public.django_content_type VALUES (2, 'auth', 'group');
INSERT INTO public.django_content_type VALUES (3, 'auth', 'user');
INSERT INTO public.django_content_type VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type VALUES (5, 'api', 'offer');
INSERT INTO public.django_content_type VALUES (6, 'api', 'order');
INSERT INTO public.django_content_type VALUES (7, 'api', 'orderitem');
INSERT INTO public.django_content_type VALUES (8, 'api', 'ticket');
INSERT INTO public.django_content_type VALUES (9, 'admin', 'logentry');
INSERT INTO public.django_content_type VALUES (10, 'sessions', 'session');


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: jo2024user
--



--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: jo2024user
--


--
-- Name: api_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.api_offer_id_seq', 3, true);


--
-- Name: api_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.api_order_id_seq', 18, true);


--
-- Name: api_orderitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.api_orderitem_id_seq', 17, true);


--
-- Name: api_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.api_ticket_id_seq', 17, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 40, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 10, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 32, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 10, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jo2024user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 19, true);


--
-- Name: api_offer api_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_offer
    ADD CONSTRAINT api_offer_pkey PRIMARY KEY (id);


--
-- Name: api_order api_order_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_order
    ADD CONSTRAINT api_order_pkey PRIMARY KEY (id);


--
-- Name: api_orderitem api_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_orderitem
    ADD CONSTRAINT api_orderitem_pkey PRIMARY KEY (id);


--
-- Name: api_ticket api_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_ticket
    ADD CONSTRAINT api_ticket_pkey PRIMARY KEY (id);


--
-- Name: api_ticket api_ticket_ticket_number_key; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_ticket
    ADD CONSTRAINT api_ticket_ticket_number_key UNIQUE (ticket_number);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: api_order_customer_id_8cb4e7b7; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX api_order_customer_id_8cb4e7b7 ON public.api_order USING btree (customer_id);


--
-- Name: api_orderitem_offer_id_002739ca; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX api_orderitem_offer_id_002739ca ON public.api_orderitem USING btree (offer_id);


--
-- Name: api_orderitem_order_id_f9c0afc0; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX api_orderitem_order_id_f9c0afc0 ON public.api_orderitem USING btree (order_id);


--
-- Name: api_ticket_order_item_id_1a68e1f3; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX api_ticket_order_item_id_1a68e1f3 ON public.api_ticket USING btree (order_item_id);


--
-- Name: api_ticket_ticket_number_ed59615e_like; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX api_ticket_ticket_number_ed59615e_like ON public.api_ticket USING btree (ticket_number varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: jo2024user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: api_order api_order_customer_id_8cb4e7b7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_order
    ADD CONSTRAINT api_order_customer_id_8cb4e7b7_fk_auth_user_id FOREIGN KEY (customer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_orderitem api_orderitem_offer_id_002739ca_fk_api_offer_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_orderitem
    ADD CONSTRAINT api_orderitem_offer_id_002739ca_fk_api_offer_id FOREIGN KEY (offer_id) REFERENCES public.api_offer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_orderitem api_orderitem_order_id_f9c0afc0_fk_api_order_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_orderitem
    ADD CONSTRAINT api_orderitem_order_id_f9c0afc0_fk_api_order_id FOREIGN KEY (order_id) REFERENCES public.api_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_ticket api_ticket_order_item_id_1a68e1f3_fk_api_orderitem_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.api_ticket
    ADD CONSTRAINT api_ticket_order_item_id_1a68e1f3_fk_api_orderitem_id FOREIGN KEY (order_item_id) REFERENCES public.api_orderitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: jo2024user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: nom_de_l_ad
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

