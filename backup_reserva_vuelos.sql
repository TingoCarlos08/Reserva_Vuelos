--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-12 02:26:26

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
-- TOC entry 4842 (class 0 OID 16448)
-- Dependencies: 221
-- Data for Name: aerolineas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aerolineas (id, nombre, iata, icao) FROM stdin;
1	Atlas Air	5Y	GTI
2	Air India Express	IX	AXB
3	Air China LTD	CA	CCA
4	China Eastern Airlines	MU	CES
5	Sichuan Airlines	3U	CSC
6	British Airways	BA	BAW
7	Japan Airlines	JL	JTL
8	Citilink	QG	CTV
9	Shenzhen Airlines	ZH	CSZ
10	Firefly	FY	FFM
11	Qatar Airways	QR	QTR
12	Jetstar	JQ	JST
14	Swiftair	WT	SWT
16	LATAM Airlines	LA	LAN
17	Ethiopian Airlines	ET	ETH
19	Middle East Airlines	ME	MEA
20	IndiGo	6E	IGO
22	Malaysia Airlines	MH	MAS
23	Corendon Air	XC	CAI
29	Air India	AI	AIC
30	Virgin Atlantic	VS	VIR
36	Singapore Airlines	SQ	SIA
46	Gulf Air	GF	GFA
61	Emirates	EK	UAE
\.


--
-- TOC entry 4840 (class 0 OID 16437)
-- Dependencies: 219
-- Data for Name: aeropuertos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeropuertos (id, nombre, ciudad, pais, iata, icao) FROM stdin;
1	Xiamen	\N	\N	XMN	ZSAM
2	Ted Stevens Anchorage International Airport	\N	\N	ANC	PANC
3	Srinagar	\N	\N	SXR	VISR
4	Indira Gandhi International	\N	\N	DEL	VIDP
5	Toowoomba Wellcamp Airport\r\n	\N	\N	WTB	YBWW
6	Maroochydore	\N	\N	MCY	YBSU
7	Injune	\N	\N	INJ	YINJ
9	Hangzhou	\N	\N	HGH	ZSHC
10	Beijing Capital International	\N	\N	PEK	ZBAA
11	Kunming	\N	\N	KMG	ZPPP
12	Shanghai Hongqiao International	\N	\N	SHA	ZSSS
13	Beijing Daxing International Airport	\N	\N	PKX	ZBAD
14	Urumqi	\N	\N	URC	ZWWW
15	Goa International	\N	\N	GOI	VOGO
16	Hyderabad Airport	\N	\N	HYD	VOHS
17	Narita International Airport	\N	\N	NRT	RJAA
18	Shanghai Pudong International	\N	\N	PVG	ZSPD
19	Soekarno-Hatta International	\N	\N	CGK	WIII
20	Hang Nadim	\N	\N	BTH	WIDD
21	Shenzhen	\N	\N	SZX	ZGSZ
22	Zhengzhou	\N	\N	CGO	ZHCC
23	Kuala Lumpur International Airport (klia)	\N	\N	KUL	WMKK
24	Tawau	\N	\N	TWU	WBKW
25	Doha International	\N	\N	DOH	OTHH
26	Noibai International	\N	\N	HAN	VVNB
27	Singapore Changi	\N	\N	SIN	WSSS
28	Ninoy Aquino International	\N	\N	MNL	RPLL
29	Barajas	\N	\N	MAD	LEMD
32	Gran Canaria	\N	\N	LPA	GCLP
36	Son Sant Joan Airport	\N	\N	PMI	LEPA
38	Jorge Chavez International	\N	\N	LIM	SPJC
39	Beirut Rafic Hariri Airport	\N	\N	BEY	OLBA
40	Bole International	\N	\N	ADD	HAAB
44	Kotoka	\N	\N	ACC	DGAA
45	Madras International (Meenambakkam)	\N	\N	MAA	VOMM
48	Vishakhapatnam	\N	\N	VTZ	VOVZ
52	Peelamedu	\N	\N	CJB	VOCB
54	Madurai	\N	\N	IXM	VOMD
56	Civil	\N	\N	TRZ	VOTR
62	Dubai	\N	\N	DXB	OMDB
64	Thiruvananthapuram International	\N	\N	TRV	VOTV
74	Surat	\N	\N	STV	VASU
78	Bandaranaike International	\N	\N	CMB	VCBI
84	Vijayawada	\N	\N	VGA	VOBZ
88	Chhatrapati Shivaji International (Sahar International)	\N	\N	BOM	VABB
94	Bhubaneswar	\N	\N	BBI	VEBS
98	Kozhikode Airport	\N	\N	CCJ	VOCL
100	Bahrain International	\N	\N	BAH	OBBI
230	Desconocido	\N	\N	DWC	OMDW
256	Desconocido	\N	\N	TCR	VOTK
\.


--
-- TOC entry 4844 (class 0 OID 16479)
-- Dependencies: 223
-- Data for Name: reservas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservas (id, id_usuario, id_vuelo, fecha_reserva, estado) FROM stdin;
26d2f125-b77c-4468-866c-0330fa5d45f5	417b2b48-a012-44b3-8b6d-03f9307387ce	50430a34-7f24-4267-8b99-d3e3d9f62a41	2025-03-12 01:25:50.813812	Confirmada
281983ca-962e-4496-bab5-68716de920f4	417b2b48-a012-44b3-8b6d-03f9307387ce	1c9bd034-4a56-498c-8a81-59fa39308d13	2025-03-12 01:28:20.251404	Confirmada
\.


--
-- TOC entry 4838 (class 0 OID 16425)
-- Dependencies: 217
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, email, password, fecha_registro) FROM stdin;
a9403292-b3eb-4d60-9139-d105b44ef0ce	Usuario de prueba	usuario@example.com	123456	2025-03-11 20:22:29.272777
417b2b48-a012-44b3-8b6d-03f9307387ce	Carlos	carlos@example.com	$2b$10$mlSaz3kiyfPQadyiDD.Jq.mWnEHKWS8LlnFxAGUK6l0ElKC0DaR02	2025-03-11 20:34:12.87003
505c311e-404f-4040-a1d5-4d87763dab51	Juan Perez	juan@example.com	$2b$10$9EZGkyzh.Rt6yOZZX9CJ0OKlsR9Wd3FCIaJ5/SvPxdt7FdhkFewjq	2025-03-11 20:51:31.862475
aad7633f-6860-4526-98d4-ff41cae56ead	Raul Borbor	rborobr@example.com	$2b$10$HaT9GASCU33LCFaIOJ8KLeoHZeIKPXSK645aIYje4BhcIY1.giPE6	2025-03-12 01:34:15.158221
\.


--
-- TOC entry 4843 (class 0 OID 16458)
-- Dependencies: 222
-- Data for Name: vuelos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vuelos (id, fecha, estado, id_aeropuerto_origen, id_aeropuerto_destino, id_aerolinea, numero_vuelo, iata, icao, horario_salida, horario_llegada) FROM stdin;
50430a34-7f24-4267-8b99-d3e3d9f62a41	2025-03-12	scheduled	1	2	1	8546	5Y8546	GTI8546	2025-03-12 08:45:00	2025-03-12 01:55:00
29adff76-0217-4530-890c-29cd0a7ed30f	2025-03-12	scheduled	3	4	2	1122	IX1122	AXB1122	2025-03-12 07:45:00	2025-03-12 09:20:00
47e64bb2-4dfa-4049-9ec9-58f12d9be2b6	2025-03-12	scheduled	9	10	3	1703	CA1703	CCA1703	2025-03-12 08:00:00	2025-03-12 10:10:00
1c9bd034-4a56-498c-8a81-59fa39308d13	2025-03-12	scheduled	11	12	4	5803	MU5803	CES5803	2025-03-12 09:00:00	2025-03-12 11:50:00
8244cb97-0314-4437-a59b-3ca2df5c05fd	2025-03-12	cancelled	13	14	5	1886	3U1886	CSC1886	2025-03-12 09:00:00	2025-03-12 13:20:00
f44549db-c100-4005-9e07-7b9c0bc39172	2025-03-12	active	15	16	6	8815	BA8815	BAW8815	2025-03-12 00:50:00	2025-03-12 01:55:00
af21f29d-5b9d-43f1-8191-36a026e4506e	2025-03-12	scheduled	17	18	7	5603	JL5603	JTL5603	2025-03-12 10:55:00	2025-03-12 13:40:00
4a849460-57d3-4b51-a32f-2e1fbd37542c	2025-03-12	scheduled	19	20	8	940	QG940	CTV940	2025-03-12 05:45:00	2025-03-12 07:25:00
9d812240-4b1a-4f75-bc7c-d79ee518075b	2025-03-12	scheduled	21	22	9	9301	ZH9301	CSZ9301	2025-03-12 07:05:00	2025-03-12 09:25:00
287148d6-1098-45d8-bc9c-403af53ab1d1	2025-03-12	scheduled	23	24	10	7690	FY7690	FFM7690	2025-03-12 07:30:00	2025-03-12 10:25:00
31e831ae-32e8-4b09-ae31-ad5ad6cb427f	2025-03-12	scheduled	25	26	11	976	QR976	QTR976	2025-03-12 02:00:00	2025-03-12 12:20:00
bec4ae8e-92fd-4bbb-83ab-0861cc4dbd4d	2025-03-12	landed	27	28	12	763	JQ763	JST763	2025-03-12 02:20:00	2025-03-12 05:55:00
e8977e21-b1ce-445f-8565-8978161086d4	2025-03-12	scheduled	29	10	3	898	CA898	CCA898	2025-03-12 01:40:00	2025-03-12 19:30:00
1bf15ef2-6178-4962-9846-fdc9b767ae8a	2025-03-12	scheduled	29	32	14	184	WT184	SWT184	2025-03-12 01:30:00	2025-03-12 05:00:00
d6b7745c-5533-4854-aba1-2f3832a64ea0	2025-03-12	scheduled	29	36	14	100	WT100	SWT100	2025-03-12 01:00:00	2025-03-12 02:45:00
5ac3ba9c-e98e-42e7-a272-1fa8b59f242e	2025-03-12	scheduled	29	38	16	2485	LA2485	LAN2485	2025-03-12 00:45:00	2025-03-12 06:30:00
194687e8-8e48-497a-b51e-3c3d78115849	2025-03-12	scheduled	39	40	17	417	ET417	ETH417	2025-03-12 02:55:00	2025-03-12 08:40:00
ecf48c2c-f422-47ac-8ded-b9594f6eb878	2025-03-12	scheduled	39	40	17	407	ET407	ETH407	2025-03-12 02:25:00	2025-03-12 07:50:00
2fe2f1ff-0d97-4378-8644-5ae8f006646d	2025-03-12	scheduled	39	44	19	575	ME575	MEA575	2025-03-12 02:05:00	2025-03-12 06:30:00
c57480b0-e4a7-4208-9cc2-e8f3f69ebe49	2025-03-12	scheduled	45	27	20	1025	6E1025	IGO1025	2025-03-12 06:30:00	2025-03-12 13:20:00
7395ba52-6e74-435e-a411-b68f04696801	2025-03-12	scheduled	45	48	20	557	6E557	IGO557	2025-03-12 06:25:00	2025-03-12 07:45:00
ed97e1dc-028c-411a-9ca4-b50a70f5ce12	2025-03-12	scheduled	45	48	22	5616	MH5616	MAS5616	2025-03-12 06:25:00	2025-03-12 07:45:00
fe14ff7c-6abb-485c-8a94-2f00b1121208	2025-03-12	scheduled	45	52	23	6194	XC6194	CAI6194	2025-03-12 06:20:00	2025-03-12 07:30:00
fd73cd47-76b3-4fc2-a3b6-d9fd332c3257	2025-03-12	scheduled	45	54	20	7183	6E7183	IGO7183	2025-03-12 06:15:00	2025-03-12 07:40:00
c9f21925-8780-45d2-93fe-4465dbb93e20	2025-03-12	scheduled	45	56	20	7298	6E7298	IGO7298	2025-03-12 06:05:00	2025-03-12 07:15:00
7ef84b54-691d-4ef4-8867-8d412d278169	2025-03-12	scheduled	45	56	22	5563	MH5563	MAS5563	2025-03-12 06:05:00	2025-03-12 07:15:00
67b77069-6608-4e89-adb2-98a0c555eaa5	2025-03-12	scheduled	45	62	20	1471	6E1471	IGO1471	2025-03-12 06:00:00	2025-03-12 09:15:00
6fe8c1c9-7cd6-41e0-84b6-1df45dd57ee8	2025-03-12	scheduled	45	64	20	624	6E624	IGO624	2025-03-12 06:00:00	2025-03-12 07:20:00
515a93e7-b80a-44ac-9d0e-c75517caccf1	2025-03-12	scheduled	45	4	29	440	AI440	AIC440	2025-03-12 06:00:00	2025-03-12 08:50:00
f6e30af7-c329-4321-ba3b-b58084db0e10	2025-03-12	scheduled	45	4	30	8534	VS8534	VIR8534	2025-03-12 05:55:00	2025-03-12 08:50:00
44289d87-230f-4fc4-91d5-77b7acb0d760	2025-03-12	scheduled	45	4	7	9684	JL9684	JTL9684	2025-03-12 05:55:00	2025-03-12 08:50:00
2e131dd0-3f42-4ea3-bb90-b9e9914f9832	2025-03-12	scheduled	45	4	6	8803	BA8803	BAW8803	2025-03-12 05:55:00	2025-03-12 08:50:00
c8bd3d90-0bff-448b-a9c0-1f0782b36723	2025-03-12	scheduled	45	74	2	1681	IX1681	AXB1681	2025-03-12 05:55:00	2025-03-12 08:05:00
7b22ada8-922d-478c-a45f-b239da84a6d8	2025-03-12	scheduled	45	74	29	9984	AI9984	AIC9984	2025-03-12 05:55:00	2025-03-12 08:05:00
31a96da1-7827-414c-9236-5a0d0bb9913b	2025-03-12	scheduled	45	78	29	273	AI273	AIC273	2025-03-12 05:55:00	2025-03-12 07:10:00
5426cf77-eae8-4e1a-928c-3c6babcb11d8	2025-03-12	scheduled	45	78	36	4941	SQ4941	SIA4941	2025-03-12 05:55:00	2025-03-12 07:10:00
6aebce8a-53ce-4bbf-9366-4a52ad742376	2025-03-12	scheduled	45	78	17	1767	ET1767	ETH1767	2025-03-12 05:55:00	2025-03-12 07:10:00
3c112f22-8e20-468e-b166-26deb258b89b	2025-03-12	scheduled	45	84	20	7084	6E7084	IGO7084	2025-03-12 05:50:00	2025-03-12 07:10:00
926988a1-b456-48bc-8bad-b27f54b4dbc4	2025-03-12	scheduled	45	15	20	907	6E907	IGO907	2025-03-12 05:45:00	2025-03-12 07:20:00
93ecf2ab-df0e-47b1-8af1-008951c630ed	2025-03-12	scheduled	45	88	20	682	6E682	IGO682	2025-03-12 05:45:00	2025-03-12 07:50:00
6c8f26cc-e182-47c6-9381-ca02d538a0b3	2025-03-12	scheduled	45	88	30	8452	VS8452	VIR8452	2025-03-12 05:45:00	2025-03-12 07:50:00
788ec031-4b06-445a-ac6d-d97209da098c	2025-03-12	scheduled	45	88	6	8794	BA8794	BAW8794	2025-03-12 05:45:00	2025-03-12 07:50:00
cafbec45-f83c-4211-91dc-8f0359230e0c	2025-03-12	scheduled	45	94	2	2801	IX2801	AXB2801	2025-03-12 05:40:00	2025-03-12 07:25:00
40328d39-1ed2-47f1-952a-056c3063be76	2025-03-12	scheduled	45	94	29	9772	AI9772	AIC9772	2025-03-12 05:40:00	2025-03-12 07:25:00
d143568c-3a53-45ee-a546-5350ad6a392e	2025-03-12	scheduled	45	98	20	7091	6E7091	IGO7091	2025-03-12 05:35:00	2025-03-12 07:20:00
c347047e-c7bc-499f-9b4e-e6875083e6fd	2025-03-12	scheduled	45	100	46	69	GF69	GFA69	2025-03-12 05:35:00	2025-03-12 08:20:00
055eaa38-23b7-4883-b98d-15ec8cd88995	2025-03-12	scheduled	29	230	61	9390	EK9390	UAE9390	2025-03-12 01:15:00	2025-03-12 11:15:00
6a0df5b7-6f97-4fcf-8135-e794ebdb5486	2025-03-12	scheduled	45	256	20	7193	6E7193	IGO7193	2025-03-12 06:00:00	2025-03-12 07:35:00
\.


--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 220
-- Name: aerolineas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aerolineas_id_seq', 142, true);


--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 218
-- Name: aeropuertos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aeropuertos_id_seq', 296, true);


-- Completed on 2025-03-12 02:26:26

--
-- PostgreSQL database dump complete
--

