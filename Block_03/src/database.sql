--
-- PostgreSQL database dump
--

\restrict wyYLxqLo2rLVn6hz1mYN4D2CeMv7eovLbHmfdBSAYocSO3KZNmohyCdcgygxkvZ

-- Dumped from database version 16.15 (Homebrew)
-- Dumped by pg_dump version 16.15 (Homebrew)

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
-- Name: hikers; Type: TABLE; Schema: public; Owner: kirimusha
--

CREATE TABLE public.hikers (
    "H#" integer NOT NULL,
    hfirstname character varying(20),
    hlastname character varying(20),
    hexperience integer,
    hemail character varying(100),
    hphone bigint
);


ALTER TABLE public.hikers OWNER TO kirimusha;

--
-- Name: mountains; Type: TABLE; Schema: public; Owner: kirimusha
--

CREATE TABLE public.mountains (
    "M#" integer NOT NULL,
    mname character varying(30),
    mheight integer,
    mcountry character varying(30),
    mdifficulty character varying(10)
);


ALTER TABLE public.mountains OWNER TO kirimusha;

--
-- Name: participants; Type: TABLE; Schema: public; Owner: kirimusha
--

CREATE TABLE public.participants (
    "P#" integer NOT NULL,
    "T#" integer NOT NULL,
    "H#" integer NOT NULL,
    pregistrationdate date
);


ALTER TABLE public.participants OWNER TO kirimusha;

--
-- Name: trips; Type: TABLE; Schema: public; Owner: kirimusha
--

CREATE TABLE public.trips (
    "T#" integer NOT NULL,
    "M#" integer NOT NULL,
    ttripdate date,
    tduration integer,
    torganizername character varying(30),
    tmaxparticipants integer
);


ALTER TABLE public.trips OWNER TO kirimusha;

--
-- Data for Name: hikers; Type: TABLE DATA; Schema: public; Owner: kirimusha
--

COPY public.hikers ("H#", hfirstname, hlastname, hexperience, hemail, hphone) FROM stdin;
101	John	Doe	5	[john@example.com](mailto:john@example.com)	12345678901
102	Alice	Smith	2	[alice@example.com](mailto:alice@example.com)	98765432109
\.


--
-- Data for Name: mountains; Type: TABLE DATA; Schema: public; Owner: kirimusha
--

COPY public.mountains ("M#", mname, mheight, mcountry, mdifficulty) FROM stdin;
1	Everest	8848	Nepal	Hard
2	Mont Blanc	4810	France	Medium
3	Elbrus	5642	Russia	Medium
\.


--
-- Data for Name: participants; Type: TABLE DATA; Schema: public; Owner: kirimusha
--

COPY public.participants ("P#", "T#", "H#", pregistrationdate) FROM stdin;
1	1001	101	2026-05-01
\.


--
-- Data for Name: trips; Type: TABLE DATA; Schema: public; Owner: kirimusha
--

COPY public.trips ("T#", "M#", ttripdate, tduration, torganizername, tmaxparticipants) FROM stdin;
1001	1	2026-06-15	14	Alpine Club	10
\.


--
-- Name: hikers hikers_pkey; Type: CONSTRAINT; Schema: public; Owner: kirimusha
--

ALTER TABLE ONLY public.hikers
    ADD CONSTRAINT hikers_pkey PRIMARY KEY ("H#");


--
-- Name: mountains mountains_pkey; Type: CONSTRAINT; Schema: public; Owner: kirimusha
--

ALTER TABLE ONLY public.mountains
    ADD CONSTRAINT mountains_pkey PRIMARY KEY ("M#");


--
-- Name: participants participants_pkey; Type: CONSTRAINT; Schema: public; Owner: kirimusha
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY ("P#");


--
-- Name: trips trips_pkey; Type: CONSTRAINT; Schema: public; Owner: kirimusha
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY ("T#");


--
-- Name: participants participants_H#_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kirimusha
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT "participants_H#_fkey" FOREIGN KEY ("H#") REFERENCES public.hikers("H#") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: participants participants_T#_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kirimusha
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT "participants_T#_fkey" FOREIGN KEY ("T#") REFERENCES public.trips("T#") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: trips trips_M#_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kirimusha
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT "trips_M#_fkey" FOREIGN KEY ("M#") REFERENCES public.mountains("M#") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict wyYLxqLo2rLVn6hz1mYN4D2CeMv7eovLbHmfdBSAYocSO3KZNmohyCdcgygxkvZ

