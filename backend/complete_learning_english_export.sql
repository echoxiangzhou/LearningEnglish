--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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
-- Data for Name: generated_sentences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generated_sentences (id, text, target_word, pattern, confidence, grammar_score, overall_score, readability_score, appropriateness_score, is_validated, validation_issues, approval_status, approved_by, approval_notes, usage_count, last_used, created_at, updated_at, chinese_translation, source_category, difficulty, audio_file_path, audio_cache_key, audio_generated_at) FROM stdin;
736	The community eagerly welcomed the charity's mission to provide essential services to the vulnerable.	welcome	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:43.321502	2025-07-09 13:28:02.266933	大家都很高兴慈善机构来帮助弱势群体，提供重要的服务。	AI generated	elementary	\N	\N	\N
3542	She likes to read books in the library.	library	SVO	0.82	0.85	0.83	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 14:55:36.47122	2025-07-09 14:55:36.471221	她喜欢在图书馆里读书。	AI generated	elementary	\N	\N	\N
3540	I usually get up at six o'clock in the morning.	usually	SV	0.95	0.92	0.93	0	0	f	\N	APPROVED	\N	\N	0	\N	2025-07-09 14:55:36.471213	2025-07-09 14:55:36.471216	我通常在早上六点起床。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b23c9f2001add2f7b20b8a2a0134634e.mp3	b23c9f2001add2f7b20b8a2a0134634e	2025-07-10 12:42:58.007997
11	She gave the dog a bone.	dog	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:18:40.022508	2025-07-09 13:22:11.333632	她给小狗一根骨头。	AI generated	elementary	\N	\N	\N
12	The elephant drank water from the river.	elephant	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:19:10.16846	2025-07-09 13:22:11.333635	大象从河里喝水。	AI generated	elementary	\N	\N	\N
13	An elephant is a very large animal.	elephant	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:19:10.168465	2025-07-09 13:22:11.333636	大象是一种非常大的动物。	AI generated	elementary	\N	\N	\N
14	The zookeeper fed the elephant some peanuts.	elephant	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:19:10.168468	2025-07-09 13:22:11.333636	动物园管理员喂了大象一些花生。	AI generated	elementary	\N	\N	\N
15	A beautiful butterfly landed on the flower.	butterfly	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:19:33.608712	2025-07-09 13:22:11.333637	一只美丽的蝴蝶落在了花上。	AI generated	elementary	\N	\N	\N
17	The children chased the butterfly.	butterfly	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:19:33.60872	2025-07-09 13:22:11.333637	孩子们追赶蝴蝶。	AI generated	elementary	\N	\N	\N
22	He wore a blue shirt.	blue	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:20:39.28059	2025-07-09 13:22:13.873897	他穿着一件蓝色的衬衫。	AI generated	elementary	\N	\N	\N
23	My favorite color is blue.	blue	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:20:39.280593	2025-07-09 13:22:13.8739	我最喜欢的颜色是蓝色。	AI generated	elementary	\N	\N	\N
25	He painted the door green.	green	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:00.069215	2025-07-09 13:22:13.873901	他把门漆成了绿色。	AI generated	elementary	\N	\N	\N
26	The frog is a small, green amphibian.	green	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:00.069217	2025-07-09 13:22:13.873901	青蛙是一种小小的、绿色的两栖动物。	AI generated	elementary	\N	\N	\N
27	The teacher gave each student an apple.	apple	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:08.340417	2025-07-09 13:22:13.873902	老师给每个学生一个苹果。	AI generated	elementary	\N	\N	\N
28	My favorite fruit is an apple.	apple	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:08.340425	2025-07-09 13:22:13.873902	我最喜欢的水果是苹果。	AI generated	elementary	\N	\N	\N
29	A red apple sat on the table.	apple	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:08.340428	2025-07-09 13:22:13.873903	一个红色的苹果放在桌子上。	AI generated	elementary	\N	\N	\N
30	The monkey ate a banana.	banana	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:17.795374	2025-07-09 13:22:13.873903	猴子吃了一根香蕉。	AI generated	elementary	\N	\N	\N
33	I made a delicious ham sandwich for lunch.	sandwich	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:39.521693	2025-07-09 13:22:18.788084	我做了个好吃的火腿三明治当午饭。	AI generated	elementary	\N	\N	\N
34	My favorite sandwich is a turkey and cheese.	sandwich	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:39.5217	2025-07-09 13:22:18.788089	我最喜欢的三明治是火鸡肉和奶酪的。	AI generated	elementary	\N	\N	\N
35	He ate the entire sandwich quickly.	sandwich	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:39.521703	2025-07-09 13:22:18.78809	他很快地吃掉了整个三明治。	AI generated	elementary	\N	\N	\N
36	My mother baked me a cake.	mother	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:22:41.197501	2025-07-09 13:22:18.78809	我的妈妈烤了一个蛋糕给我。	AI generated	elementary	\N	\N	\N
37	She is a loving mother.	mother	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:22:41.197508	2025-07-09 13:22:18.788091	她是一位有爱的妈妈。	AI generated	elementary	\N	\N	\N
38	The mother hugged her child.	mother	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:22:41.197511	2025-07-09 13:22:18.788092	妈妈抱了她的孩子。	AI generated	elementary	\N	\N	\N
39	My father is a doctor.	father	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:22:57.919973	2025-07-09 13:22:18.788092	我的爸爸是一位医生。	AI generated	elementary	\N	\N	\N
43	I love my sister very much.	sister	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:21.088801	2025-07-09 13:22:22.941356	我非常爱我的妹妹。	AI generated	elementary	\N	\N	\N
44	My sister gave me a gift.	sister	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:21.088802	2025-07-09 13:22:22.941361	我的妹妹给了我一个礼物。	AI generated	elementary	\N	\N	\N
45	My brother plays soccer every Saturday.	brother	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:35.23099	2025-07-09 13:22:22.941362	我的哥哥每个星期六都踢足球。	AI generated	elementary	\N	\N	\N
46	He is my older brother.	brother	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:35.230995	2025-07-09 13:22:22.941362	他是我的大哥哥。	AI generated	elementary	\N	\N	\N
47	I gave my brother a birthday present.	brother	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:35.230997	2025-07-09 13:22:22.941363	我给了我的哥哥一个生日礼物。	AI generated	elementary	\N	\N	\N
48	My grandmother baked me a delicious chocolate cake.	grandmother	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:48.090516	2025-07-09 13:22:22.941364	我的奶奶烤了一个好吃的巧克力蛋糕给我。	AI generated	elementary	\N	\N	\N
49	My grandmother is very kind and loving.	grandmother	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:48.090524	2025-07-09 13:22:22.941364	我的奶奶非常友善和有爱心。	AI generated	elementary	\N	\N	\N
3544	The elephant is very big and strong.	elephant	SVC	0.79	0.81	0.8	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 14:55:36.471223	2025-07-09 14:55:36.471223	大象非常大而且强壮。	AI generated	elementary	\N	\N	\N
742	They were worried about how their neighbors would welcome the proposed building extension.	worried	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:43.326357	2025-07-09 13:28:02.266936	他们担心邻居们会不会喜欢他们要扩建房子的计划。	AI generated	elementary	\N	\N	\N
751	He politely offered an interesting counter-argument during the debate.	politely	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:44.570561	2025-07-09 13:28:07.051742	他在辩论中礼貌地提出了一个有趣的反对观点。	AI generated	elementary	\N	\N	\N
3546	My grandmother makes delicious cookies.	grandmother	SVO	0.75	0.78	0.76	0	0	f	\N	REJECTED	\N	Grammar structure needs improvement	0	\N	2025-07-09 14:55:36.471225	2025-07-09 14:55:36.471226	我奶奶做美味的饼干。	AI generated	elementary	\N	\N	\N
3543	We go to school every day.	school	SV	0.94	0.96	0.95	0	0	f	\N	APPROVED	\N	\N	0	\N	2025-07-09 14:55:36.471221	2025-07-09 14:55:36.471222	我们每天上学。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/73e5447f608773868bfeceb4563b978c.mp3	73e5447f608773868bfeceb4563b978c	2025-07-10 12:42:58.007997
3545	He plays football with his friends.	football	SVO	0.91	0.89	0.9	0	0	f	\N	APPROVED	\N	\N	0	\N	2025-07-09 14:55:36.471224	2025-07-09 14:55:36.471224	他和朋友们一起踢足球。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/77aa6fdb6587c2298b429142499e7a4d.mp3	77aa6fdb6587c2298b429142499e7a4d	2025-07-10 12:42:58.007997
54	My family traveled abroad last summer.	abroad	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:24:45.075793	2025-07-09 13:22:25.757358	去年夏天，我的家人去了国外旅行。	AI generated	elementary	\N	\N	\N
64	A freak accident at the factory resulted in a significant production delay.	accident	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:26:07.788885	2025-07-09 13:22:29.432957	工厂里发生了一起奇怪的意外，导致生产大大延误了。	AI generated	elementary	\N	\N	\N
65	Her sudden illness was a tragic accident, leaving her family devastated.	accident	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:26:07.788887	2025-07-09 13:22:29.432962	她突然生病是一场不幸的意外，让她的家人非常伤心。	AI generated	elementary	\N	\N	\N
66	I almost missed the bus this morning because I woke up late.	almost	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946094	2025-07-09 13:22:29.432963	今天早上我差点没赶上公交车，因为我睡过头了。	AI generated	elementary	\N	\N	\N
67	After hours of simmering, the delicious stew is almost ready.	almost	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946103	2025-07-09 13:22:29.432964	炖了几个小时后，美味的炖菜就快做好了。	AI generated	elementary	\N	\N	\N
69	She decided to travel the world alone to discover her independence.	alone	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946107	2025-07-09 13:22:29.432965	她决定独自去环游世界，去发现自己的独立性。	AI generated	elementary	\N	\N	\N
74	The manager has already given the team their new assignments.	already	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946116	2025-07-09 13:22:33.204316	经理已经给团队布置了新的任务。	AI generated	elementary	\N	\N	\N
75	He always remembers his wife's birthday with a thoughtful gift.	always	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946118	2025-07-09 13:22:33.20432	他总是记得妻子的生日，还会送她一份贴心的礼物。	AI generated	elementary	\N	\N	\N
76	The coffee shop on the corner is always busy in the morning.	always	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.94612	2025-07-09 13:22:33.204321	街角的咖啡店早上总是很忙。	AI generated	elementary	\N	\N	\N
77	The sun always rises in the east, painting the sky with color.	always	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946121	2025-07-09 13:22:33.204321	太阳总是从东方升起，把天空染成美丽的颜色。	AI generated	elementary	\N	\N	\N
78	I am a dedicated member of the school's robotics club.	am	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946123	2025-07-09 13:22:33.204322	我是学校机器人俱乐部的热心成员。	AI generated	elementary	\N	\N	\N
79	At this very moment, I am writing the final chapter of my book.	am	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946125	2025-07-09 13:22:33.204322	现在，我正在写我书的最后一章。	AI generated	elementary	\N	\N	\N
80	If you need me, I am in the garden.	am	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946127	2025-07-09 13:22:33.204322	如果你需要我，我就在花园里。	AI generated	elementary	\N	\N	\N
81	The scientist made an amazing discovery that could change medicine.	amazing	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946128	2025-07-09 13:22:33.204323	那位科学家有了一个了不起的发现，可能会改变医学。	AI generated	elementary	\N	\N	\N
84	The company invested a significant amount of money into the new technology.	amount	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946134	2025-07-09 13:22:37.270348	公司在新技术上投入了很多钱。	AI generated	elementary	\N	\N	\N
85	The total amount for the groceries was higher than I expected.	amount	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946156	2025-07-09 13:22:37.270351	买菜的总价钱比我想的要贵。	AI generated	elementary	\N	\N	\N
86	A surprising amount of wildlife lives in this small urban park.	amount	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946158	2025-07-09 13:22:37.270351	在这个小小的城市公园里，住着很多让人惊讶的野生动物。	AI generated	elementary	\N	\N	\N
87	He saw an eagle soaring high above the mountains.	an	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.94616	2025-07-09 13:22:37.270352	他看到一只老鹰在山顶上飞得很高。	AI generated	elementary	\N	\N	\N
88	My goal is to become an accomplished musician.	an	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946162	2025-07-09 13:22:37.270352	我的目标是成为一个很棒的音乐家。	AI generated	elementary	\N	\N	\N
89	The librarian handed me an old book with a beautiful leather cover.	an	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946163	2025-07-09 13:22:37.270352	图书馆管理员递给我一本旧书，书皮是漂亮的皮革做的。	AI generated	elementary	\N	\N	\N
90	The financial advisor provided a thorough analysis of the stock market trends.	analysis	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946165	2025-07-09 13:22:37.270353	理财顾问对股市的走向做了非常仔细的分析。	AI generated	elementary	\N	\N	\N
761	Please call back and leave a message when you hear my voice.	voice	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.002258	2025-07-09 13:28:10.530166	听到我的声音后，请回电话并留言。	AI generated	elementary	\N	\N	\N
3548	We have math class today.	math	SVO	0.87	0.88	0.87	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 14:55:36.471228	2025-07-09 14:55:36.471228	我们今天有数学课。	AI generated	elementary	\N	\N	\N
767	Please sit down and read this page carefully.	page	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.002268	2025-07-09 13:28:13.914258	请坐下，仔细阅读这一页。	AI generated	elementary	\N	\N	\N
769	She broke a nail while walking in the swamp.	nail	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.005906	2025-07-09 13:28:13.914259	她在沼泽里走路的时候，指甲断了。	AI generated	elementary	\N	\N	\N
3549	She is reading a story book.	story	SVO	0.9	0.92	0.91	0	0	f	\N	APPROVED	\N	\N	0	\N	2025-07-09 14:55:36.471229	2025-07-09 14:55:36.471229	她在读故事书。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ad8225f6d0c5f4703c30c2c08a578a2a.mp3	ad8225f6d0c5f4703c30c2c08a578a2a	2025-07-10 12:42:58.007997
94	The new puppy is both playful and affectionate.	and	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946172	2025-07-09 13:22:40.100797	新的小狗既爱玩又很黏人。	AI generated	elementary	\N	\N	\N
104	We store our holiday decorations in the basement during the summer.	basement	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.116217	2025-07-09 13:22:43.260168	夏天的时候，我们把过节的装饰品放在地下室里。	AI generated	elementary	\N	\N	\N
105	You must learn the basic rules before you can play the game.	basic	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.118954	2025-07-09 13:22:43.260173	你必须先学会基本规则，才能玩这个游戏。	AI generated	elementary	\N	\N	\N
106	The instructions for the furniture were very basic and easy to follow.	basic	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.118958	2025-07-09 13:22:43.260174	家具的说明书很简单，很容易看懂。	AI generated	elementary	\N	\N	\N
107	The team practiced basic drills for the first hour.	basic	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.11896	2025-07-09 13:22:43.260175	队伍第一个小时练习了基本动作。	AI generated	elementary	\N	\N	\N
108	We are planning to renovate the main bathroom next year.	bathroom	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.121642	2025-07-09 13:22:43.260175	我们计划明年重新装修主浴室。	AI generated	elementary	\N	\N	\N
109	The hotel bathroom was surprisingly spacious and clean.	bathroom	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.121646	2025-07-09 13:22:43.260176	酒店的浴室非常宽敞干净，让人惊喜。	AI generated	elementary	\N	\N	\N
110	He went to the bathroom to wash his hands before dinner.	bathroom	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.121648	2025-07-09 13:22:43.260176	他在晚饭前去浴室洗手。	AI generated	elementary	\N	\N	\N
114	The hikers saw a large brown bear from a safe distance.	bear	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.126921	2025-07-09 13:22:46.374523	远足的人们从安全的距离看到了一只棕色的大熊。	AI generated	elementary	\N	\N	\N
115	A mother bear is extremely protective of her cubs.	bear	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.126925	2025-07-09 13:22:46.374526	熊妈妈会非常保护自己的小熊。	AI generated	elementary	\N	\N	\N
116	The warning sign said a bear had been spotted in the area.	bear	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.126927	2025-07-09 13:22:46.374527	警告牌上说，有人在这个区域发现了熊。	AI generated	elementary	\N	\N	\N
117	The artist painted a beautiful landscape of the mountains.	beautiful	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.129573	2025-07-09 13:22:46.374528	这位艺术家画了一幅美丽的山脉风景画。	AI generated	elementary	\N	\N	\N
118	The sunset over the ocean was absolutely beautiful.	beautiful	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.129577	2025-07-09 13:22:46.374528	海上的日落真是太美了。	AI generated	elementary	\N	\N	\N
119	He bought his wife a beautiful necklace for their anniversary.	beautiful	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.129579	2025-07-09 13:22:46.374529	他给妻子买了一条漂亮的项链作为他们的结婚纪念日礼物。	AI generated	elementary	\N	\N	\N
120	The tired child fell asleep as soon as his head hit the bed.	bed	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.132123	2025-07-09 13:22:46.37453	疲惫的孩子头一碰到床就睡着了。	AI generated	elementary	\N	\N	\N
124	I left my book on the nightstand in my bedroom.	bedroom	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.134644	2025-07-09 13:22:51.207141	我把书落在卧室的床头柜上了。	AI generated	elementary	\N	\N	\N
125	She chose a calming shade of green paint for her bedroom walls.	bedroom	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.134646	2025-07-09 13:22:51.207146	她为卧室的墙壁选择了让人平静的绿色油漆。	AI generated	elementary	\N	\N	\N
126	A small bee landed gently on the purple flower to collect pollen.	bee	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.207117	2025-07-09 13:22:51.207147	一只小蜜蜂轻轻地落在紫色的花朵上采集花粉。	AI generated	elementary	\N	\N	\N
127	The loud buzzing sound in the garden was a bumble bee.	bee	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.207123	2025-07-09 13:22:51.207148	花园里嗡嗡的响声是一只大黄蜂。	AI generated	elementary	\N	\N	\N
128	The queen bee lays all the eggs for the entire hive.	bee	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.207125	2025-07-09 13:22:51.207148	蜂后为整个蜂巢产下所有的卵。	AI generated	elementary	\N	\N	\N
129	For Sunday dinner, my grandmother always cooks roast beef.	beef	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.210062	2025-07-09 13:22:51.207149	星期天的晚餐，我的奶奶总是做烤牛肉。	AI generated	elementary	\N	\N	\N
130	The most popular item on the menu was the beef stew.	beef	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.210066	2025-07-09 13:22:51.20715	菜单上最受欢迎的是炖牛肉。	AI generated	elementary	\N	\N	\N
134	The marathon begins at the city hall and ends in the park.	begin	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.212911	2025-07-09 13:22:53.992172	马拉松从市政厅开始，在公园结束。	AI generated	elementary	\N	\N	\N
135	The author rewrote the beginning of the book to better capture the reader's attention.	beginning	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.215621	2025-07-09 13:22:53.992175	作者重写了书的开头，为了更好地吸引读者。	AI generated	elementary	\N	\N	\N
739	She was worried the ambitious mission to restore the old machinery would be too expensive.	worried	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:43.326352	2025-07-09 13:28:02.266934	她担心修复旧机器的这个大任务会太花钱。	AI generated	intermediate	\N	\N	\N
777	Unemployment can make even the most extraordinary person feel ordinary and lost.	unemployment	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.272788	2025-07-09 13:28:17.294801	失业会让最棒的人也觉得自己很普通，很迷茫。	AI generated	elementary	\N	\N	\N
53	Despite his physical limitations, he demonstrated a remarkable ability to overcome challenges and achieve his goals.	ability	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:24:06.418209	2025-07-09 13:22:25.757353	虽然他身体不太方便，但他表现出很棒的能力，克服困难，实现目标。	AI generated	intermediate	\N	\N	\N
779	The construction of the new highway aimed to alleviate unemployment by creating numerous jobs.	unemployment	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.272791	2025-07-09 13:28:17.294802	修建新的高速公路是为了创造很多工作机会，从而减少失业。	AI generated	elementary	\N	\N	\N
68	He almost fell on the icy sidewalk but caught his balance at the last second.	almost	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946105	2025-07-09 13:22:29.432964	他差点在结冰的人行道上摔倒，但在最后一秒稳住了。	AI generated	intermediate	\N	\N	\N
3343	Of all the four seasons, I like spring best.	seasons	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:02:58.644841	2025-07-09 13:23:00.141235	在四个季节里，我最喜欢春天。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/3408bccb05300488819a5fe2a2781b88.mp3	3408bccb05300488819a5fe2a2781b88	2025-07-10 12:42:58.007997
3344	The Photos on the Wall are my favorite ones.	Wall	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:02:58.998864	2025-07-09 13:23:00.141236	墙上的那些照片是我最喜欢的。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/bbf8ecbff7e9a29d36216d2da65a2916.mp3	bbf8ecbff7e9a29d36216d2da65a2916	2025-07-10 12:42:58.007997
3345	I can see lots of cows and sheep on the farm.	lots	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:02:59.493495	2025-07-09 13:23:00.141237	我在农场里看到了很多奶牛和绵羊。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b7e86ec236db8a3f1bc982b4dbb73295.mp3	b7e86ec236db8a3f1bc982b4dbb73295	2025-07-10 12:43:21.125645
3346	He is wearing new trousers and an old jacket.	trousers	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:02:59.845162	2025-07-09 13:02:59.845164	他穿着新裤子和一件旧夹克。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/5bfe4baefb658ba1c96ddb85456ffbb7.mp3	5bfe4baefb658ba1c96ddb85456ffbb7	2025-07-10 12:43:21.125645
3358	There are lots of beautiful places to go in China.	China	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:04.287974	2025-07-11 12:54:45.533138	在中国有很多美丽的地方可以去。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/2b2ef3a3b2e0276294757320a5f51673.mp3	2b2ef3a3b2e0276294757320a5f51673	2025-07-11 12:54:45.529862
138	The shy child hid behind his mother's legs.	behind	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.218233	2025-07-09 13:22:53.992177	害羞的孩子躲在他妈妈的腿后面。	AI generated	elementary	\N	\N	\N
144	I believe you have the potential to achieve great things.	believe	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.223224	2025-07-09 13:22:57.0526	我相信你很有潜力，能做成很棒的事情。	AI generated	elementary	\N	\N	\N
145	Against all evidence, she continued to believe in his innocence.	believe	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.223229	2025-07-09 13:22:57.052604	即使没有证据，她还是相信他是清白的。	AI generated	elementary	\N	\N	\N
146	Despite the challenges, the community chose to believe.	believe	SV	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.223231	2025-07-09 13:22:57.052605	虽然有很多困难，但大家还是选择相信。	AI generated	elementary	\N	\N	\N
147	These antique keys belong to my great-grandmother.	belong	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.225895	2025-07-09 13:22:57.052605	这些旧钥匙是我曾祖母的。	AI generated	elementary	\N	\N	\N
154	One major benefit of remote work is a more flexible schedule.	benefit	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.231095	2025-07-09 13:23:00.141223	远程工作的一个好处是时间更自由。	AI generated	elementary	\N	\N	\N
155	Students can benefit greatly from one-on-one tutoring sessions.	benefit	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.231097	2025-07-09 13:23:00.141234	一对一的辅导课对学生很有帮助。	AI generated	elementary	\N	\N	\N
771	Despite his high rank, the general's command style was surprisingly ordinary, marked by collaboration rather than strict orders.	command	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.270457	2025-07-09 13:28:13.91426	虽然将军的军衔很高，但他的指挥风格却出人意料地普通，以合作为主，而不是严格的命令。	AI generated	intermediate	\N	\N	\N
792	Please give me some lotion for my dry hands.	lotion	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.674781	2025-07-09 13:28:20.013032	请给我一些润肤露，我的手太干了。	AI generated	elementary	\N	\N	\N
148	After years of searching, she finally found a place where she felt she could belong.	belong	SV	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.225899	2025-07-09 13:22:57.052606	找了很多年，她终于找到了一个让她觉得可以属于的地方。	AI generated	intermediate	\N	\N	\N
800	We need to find a new source of funding to manage the project well.	source	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:46.019638	2025-07-09 13:28:23.223699	我们需要找到新的资金来源，才能更好地管理这个项目。	AI generated	elementary	\N	\N	\N
802	The worker got a bad injury after a piece of timber fell on him.	injury	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:46.022216	2025-07-09 13:28:23.2237	那位工人被一块木头砸到后受了重伤。	AI generated	elementary	\N	\N	\N
3361	She had a piece of pizza, because she doesn't like hamburgers.	piece	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:05.501368	2025-07-09 13:23:06.813101	她吃了一块披萨，因为她不喜欢汉堡包。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/34523ab74d931726fad3f5bd73ff7fbb.mp3	34523ab74d931726fad3f5bd73ff7fbb	2025-07-10 12:43:49.536677
3362	All of you should remember that health is very important to us.	health	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:05.835032	2025-07-09 13:23:06.813106	你们都要记住，健康对我们非常重要。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/2b03b4dc392fa3841ba9c5cf9e792b8d.mp3	2b03b4dc392fa3841ba9c5cf9e792b8d	2025-07-10 12:43:49.536677
3377	If you are worried about something, you can tell someone who cares about you.	tell	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:11.312466	2025-07-09 13:23:10.209157	如果你担心什么事情，你可以告诉关心你的人。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/01cde889dfc0198e93f272eaa84280e4.mp3	01cde889dfc0198e93f272eaa84280e4	2025-07-10 12:44:22.884091
3378	If you want to give me a present, then bring something you made yourself.	present	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:11.657492	2025-07-09 13:23:10.209158	如果你想送我礼物，那就带你自己做的东西来。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/cf80df2552aff64808357b53fb4e27ab.mp3	cf80df2552aff64808357b53fb4e27ab	2025-07-10 12:44:22.884091
3381	Our team got eighteen points and yours got twenty points.	team	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:12.873449	2025-07-10 13:39:15.153701	我们队得了18分，你们队得了20分。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/07a4235e096bac1b515027bdaf81c1a4.mp3	07a4235e096bac1b515027bdaf81c1a4	2025-07-10 13:39:15.149774
3365	Your school bag is bigger than mine.	school	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:06.866326	2025-07-11 11:45:32.054329	你的书包比我的大。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/8b10415f28a3f739611cc21fce3c70bf.mp3	8b10415f28a3f739611cc21fce3c70bf	2025-07-11 11:45:32.047287
3364	My father goes to work at eight o'clock every morning.	father	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:06.521038	2025-07-11 11:57:31.652479	我爸爸每天早上八点去上班。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/92c6b7d5e90aaa5cbdbb2e38595bd6eb.mp3	92c6b7d5e90aaa5cbdbb2e38595bd6eb	2025-07-11 11:57:31.64695
3375	Each day brings a new beginning.	day	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:10.626796	2025-07-12 04:52:41.938083	每一天都带来一个新的开始。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/cc114505f2354f97e0fe360b49dc9c32.mp3	cc114505f2354f97e0fe360b49dc9c32	2025-07-12 04:52:41.935302
3371	Who is going to the airport with you?	airport	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:09.089919	2025-07-09 13:03:09.089921	谁要和你一起去机场？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/4c43ae6c7b686fa399eebef62653db23.mp3	4c43ae6c7b686fa399eebef62653db23	2025-07-10 12:43:49.536677
3382	The black bag costs one hundred and eighteen yuan.	bag	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:13.233423	2025-07-09 13:23:13.21215	这个黑色的包包要118元。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/a811d7301e1e052d2b422083c2f6ff65.mp3	a811d7301e1e052d2b422083c2f6ff65	2025-07-10 12:44:22.884091
808	The beautiful sight of the sunrise made him drop his razor in surprise.	sight	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:47.47877	2025-07-09 13:28:26.729376	美丽的日出景象让他惊讶地把剃须刀都掉了。	AI generated	elementary	\N	\N	\N
810	The bee's sudden sting showed the power it had to inflict pain.	power	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:47.484481	2025-07-09 13:28:26.729377	蜜蜂突然的蜇刺显示了它能带来疼痛的力量。	AI generated	elementary	\N	\N	\N
781	The remote location, just off the main highway, offered a quiet escape from city life.	highway	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.272794	2025-07-09 13:28:17.294803	这个偏远的地方就在高速公路旁边，可以让人安静地逃离城市生活。	AI generated	intermediate	\N	\N	\N
812	It was a silly belief, that this magical realm existed.	silly	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:47.496197	2025-07-09 13:28:26.729379	相信存在这个魔法世界，真是个傻傻的想法。	AI generated	elementary	\N	\N	\N
818	I need to wash my car before I buy new tires for it.	wash	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:47.496208	2025-07-09 13:28:30.596037	我需要先洗车，然后再给它买新轮胎。	AI generated	elementary	\N	\N	\N
820	Taking a small step is the norm for babies learning to walk.	norm	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.533838	2025-07-09 13:28:30.596038	对于学习走路的宝宝来说，迈出一小步是很正常的。	AI generated	elementary	\N	\N	\N
3385	On the second day of Chinese New Year, we're going to watch fireworks in the evening.	Chinese	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:14.380055	2025-07-09 13:03:14.380059	大年初二晚上，我们要去看烟花。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/3886ce47478f3ca543d9d85c7ac40873.mp3	3886ce47478f3ca543d9d85c7ac40873	2025-07-10 12:44:55.937214
3412	Thirty years ago, Mike's grandpa listened to the radio and read newspaper for news.	Mike	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:24.65092	2025-07-09 13:23:23.882117	三十年前，迈克的爷爷通过收音机和报纸来了解新闻。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/d625e2938d9087ed8d3350107648d2a9.mp3	d625e2938d9087ed8d3350107648d2a9	2025-07-10 12:45:29.976707
3413	You can see green trees and beautiful flowers everywhere.	trees	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:24.982876	2025-07-09 13:23:23.882118	你到处都能看到绿色的树和美丽的花。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/e9e86d7b00a307510ae4102fe833da79.mp3	e9e86d7b00a307510ae4102fe833da79	2025-07-10 12:45:29.976707
3354	It usually takes me half an hour to get to school, because I live far from school.	hour	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:02.855412	2025-07-09 13:23:03.523496	我通常要花半个小时才能到学校，因为我家离学校很远。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/5944fbc155c286c2958f2c0ace4ea39d.mp3	5944fbc155c286c2958f2c0ace4ea39d	2025-07-10 12:44:22.884091
3391	You're 160 cm tall and you should choose the size M.	M.	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:16.636755	2025-07-09 13:23:17.063676	你身高160厘米，应该选M号。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/f2a0821ac06c3b3480b14fbfe3caa466.mp3	f2a0821ac06c3b3480b14fbfe3caa466	2025-07-10 12:44:22.884091
3392	We have three lessons in the morning and my favorite subject is art.	lessons	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:16.975798	2025-07-09 13:23:17.06368	我们上午有三节课，我最喜欢的科目是美术。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/1244947a19b75ee83c0ad42fc109c30c.mp3	1244947a19b75ee83c0ad42fc109c30c	2025-07-10 12:44:55.937214
3393	Always wash your hands before eating and after going to the toilet.	hands	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:17.337688	2025-07-09 13:23:17.063681	总是要在吃饭前和上完厕所后洗手。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/fa228f0ee61cdb210cf8c9c0853ae2d4.mp3	fa228f0ee61cdb210cf8c9c0853ae2d4	2025-07-10 12:44:55.937214
3376	We were very tired when we finished the work, but all of us were very happy.	work	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:10.971037	2025-07-09 13:23:10.209157	我们完成工作的时候非常累，但是我们都很开心。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/2a0be3b1b4995be9e002030d66047419.mp3	2a0be3b1b4995be9e002030d66047419	2025-07-10 12:44:55.937214
822	I shot the balloon and it popped!	shot	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.541233	2025-07-09 13:28:30.59604	我射中了气球，它爆炸了！	AI generated	elementary	\N	\N	\N
832	She likes to read mainly about animals.	she	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.614494	2025-07-09 13:28:33.21838	她主要喜欢读关于动物的书。	AI generated	elementary	\N	\N	\N
840	The movie scene showed his low salary.	salary	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.622436	2025-07-09 13:28:36.064477	电影里的场景显示了他的低工资。	AI generated	elementary	\N	\N	\N
842	The cave was a refuge from the mine's deep shaft.	refuge	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.62244	2025-07-09 13:28:36.064478	这个山洞是矿井深井道里的避难所。	AI generated	elementary	\N	\N	\N
850	I hope they grant the woman a new home.	grant	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.457454	2025-07-09 13:28:39.092084	我希望他们能给那个女人一个新的家。	AI generated	elementary	\N	\N	\N
852	These books on the desk are for you.	these	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.457457	2025-07-09 13:28:39.092084	桌子上的这些书是给你的。	AI generated	elementary	\N	\N	\N
854	I think they will grant the sly fox a chance.	grant	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.45746	2025-07-09 13:28:41.708667	我觉得他们会给狡猾的狐狸一个机会。	AI generated	elementary	\N	\N	\N
856	I am afraid to go to the doctor this week.	afraid	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.799977	2025-07-09 13:28:41.70867	我害怕这周去看医生。	AI generated	elementary	\N	\N	\N
3379	On October the 16th, 2021, she became the first female astronaut to enter the Tiangong Space Station.	October	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:12.010796	2025-07-09 13:23:10.209158	在2021年10月16日，她成为了第一位进入天宫空间站的女宇航员。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/f4af8cd2d887f33885bcde4e721cc1e9.mp3	f4af8cd2d887f33885bcde4e721cc1e9	2025-07-10 12:45:29.976707
3387	On the third floor, there are two teachers' offices, an art room and a computer room.	floor	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:15.072933	2025-07-09 13:23:13.212153	在三楼，有两间老师的办公室，一间美术室和一间电脑室。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/43e1bc266372fe0b0a3de6bca2bc4898.mp3	43e1bc266372fe0b0a3de6bca2bc4898	2025-07-10 12:45:29.976707
3433	Autumn is golden, and farmers are busy.	Autumn	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:32.237378	2025-07-09 13:23:30.512431	秋天是金色的，农民伯伯很忙。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/55d5d48149429b4e1753eb2f75e55da4.mp3	55d5d48149429b4e1753eb2f75e55da4	2025-07-10 12:46:09.921848
3434	If you don't drink enough water, you may feel tired.	water	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:32.75237	2025-07-09 13:23:30.512431	如果你喝水不够，你可能会觉得累。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/5e10e9fa2bda6a3bf484c2f1dec3aacb.mp3	5e10e9fa2bda6a3bf484c2f1dec3aacb	2025-07-10 12:46:09.921848
3388	Rain forests cover two percent  of the earth, but they have over fifty percent  of the world's plants and animals.	Rain	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:15.423678	2025-07-09 13:23:13.212153	雨林覆盖了地球的百分之二，但是它们拥有世界上超过百分之五十的植物和动物。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/792ff45e5948ec97fe5cd2357f994be3.mp3	792ff45e5948ec97fe5cd2357f994be3	2025-07-10 12:45:29.976707
3435	Drink some milk, and I'm sure you will sleep well and get better soon.	milk	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:33.106664	2025-07-09 13:23:30.512432	喝点牛奶，我相信你会睡得好，很快好起来。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/163e86b1775ceda69c7aec0de24eaad2.mp3	163e86b1775ceda69c7aec0de24eaad2	2025-07-10 12:46:09.921848
3423	His favourite food is noodles, but I like dumplings best.	food	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:28.596957	2025-07-09 13:23:27.291635	他最喜欢的食物是面条，但我最喜欢饺子。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/084b24a04e3326d45751ded582865e9c.mp3	084b24a04e3326d45751ded582865e9c	2025-07-10 12:45:29.976707
3436	Some girls are singing and dancing under a big tree.	girls	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:33.443762	2025-07-09 13:23:30.512432	一些女孩正在大树下唱歌跳舞。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/025500c93839fecf27974012c288ee0c.mp3	025500c93839fecf27974012c288ee0c	2025-07-10 12:46:09.921848
3437	My mother likes keeping pets and growing plants, but she doesn't like climbing rocks.	mother	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:33.808241	2025-07-09 13:23:30.512433	我妈妈喜欢养宠物和种植物，但是她不喜欢爬石头。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/2f51bd74ce3875437ccf5790a69acd6c.mp3	2f51bd74ce3875437ccf5790a69acd6c	2025-07-10 12:46:09.921848
3439	We can use ovens to bake bread and cookies.	ovens	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:34.500079	2025-07-09 13:23:30.512434	我们可以用烤箱烤面包和饼干。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/d2f05741ed4c0006b86ddd8960c9b85e.mp3	d2f05741ed4c0006b86ddd8960c9b85e	2025-07-10 12:46:09.921848
858	What do you know about the human soul?	do	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.806182	2025-07-09 13:28:41.708671	你知道关于人的灵魂什么吗？	AI generated	elementary	\N	\N	\N
860	I will teach you how to draw a deer.	teach	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.81954	2025-07-09 13:28:41.708671	我会教你怎样画一只鹿。	AI generated	elementary	\N	\N	\N
862	The wild flowers grew very tall in the field.	wild	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.819544	2025-07-09 13:28:41.708672	野花在田野里长得很高。	AI generated	elementary	\N	\N	\N
872	A line of rust appeared where the fence touched the wet ground.	line	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.851295	2025-07-09 13:28:44.625948	栅栏碰到湿地的地方出现了一道锈迹。	AI generated	elementary	\N	\N	\N
882	Now the donkey is sleeping in the sun.	now	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:51.759977	2025-07-09 13:28:48.733952	现在驴子正在阳光下睡觉。	AI generated	elementary	\N	\N	\N
3403	The young girl loves diving, and she is very hard working, training hard every day.	girl	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:21.099338	2025-07-09 13:23:20.426922	那个小女孩喜欢跳水，她非常努力，每天都认真训练。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ff7b5f257fb7f9a8a95ed79c8fc74f41.mp3	ff7b5f257fb7f9a8a95ed79c8fc74f41	2025-07-10 12:46:09.921848
3463	Dad and I are going to see a Beijing opera this afternoon.	Dad	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:43.585606	2025-07-09 13:23:41.775331	今天下午我和爸爸要去看京剧。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ede8526ef1d3b718bdda340dbd028dec.mp3	ede8526ef1d3b718bdda340dbd028dec	2025-07-10 12:47:28.512482
3408	I am interested in collecting stamps, because from collecting them, I learn more about the world.	stamps	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:23.077801	2025-07-09 13:23:20.426925	我喜欢集邮，因为通过集邮，我能学到更多关于世界的知识。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/034fb8ddfb981b254f37a09393799a69.mp3	034fb8ddfb981b254f37a09393799a69	2025-07-10 12:46:09.921848
3464	It will be sunny and warm tomorrow.	tomorrow	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:44.113227	2025-07-09 13:23:41.775332	明天会是晴天，而且很暖和。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ac8661a205ba3fa5645abbbe88deae6e.mp3	ac8661a205ba3fa5645abbbe88deae6e	2025-07-10 12:47:28.512482
3465	Mike and his classmates are going to see the film on Sunday evening.	Mike	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:44.464699	2025-07-09 13:23:41.775332	星期天晚上，迈克和他的同学们要去看电影。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ec84403cef3d2f3a4c377fd194977787.mp3	ec84403cef3d2f3a4c377fd194977787	2025-07-10 12:47:28.512482
3466	Lisa won't climb the mountains this summer.	Lisa	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:44.810974	2025-07-09 13:23:41.775332	今年夏天，丽莎不会去爬山。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/30500b276ef5cf6ce563d2282da0f0b5.mp3	30500b276ef5cf6ce563d2282da0f0b5	2025-07-10 12:47:28.512482
3414	The weather in the south of China is quite different from that in the north.	China	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:25.316727	2025-07-09 13:23:23.882118	中国南方的天气和北方很不一样。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/5d13306586577897105cf09bf9eab57e.mp3	5d13306586577897105cf09bf9eab57e	2025-07-10 12:46:50.140924
3451	Sometimes I play ping-pong with my family at the gym on Saturdays.	Saturdays	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:39.049044	2025-07-09 13:23:38.351377	有时候我星期六会在健身房和家人一起打乒乓球。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/8547c107e4c301f7805653359e4a2eef.mp3	8547c107e4c301f7805653359e4a2eef	2025-07-10 12:46:50.140924
3469	Yesterday we bought a pair of runners and a t-shirt for Jack.	Jack	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:45.883164	2025-07-09 13:23:41.775334	昨天我们给杰克买了一双跑鞋和一件T恤。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/4268d03f11593e95c3fef6ec30093150.mp3	4268d03f11593e95c3fef6ec30093150	2025-07-10 12:47:28.512482
3468	The holiday is coming next week.	holiday	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:45.509779	2025-07-12 04:54:07.101377	下个星期就要放假了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/bc95fdbbaf9c13517f848577315445da.mp3	bc95fdbbaf9c13517f848577315445da	2025-07-12 04:54:07.098401
3453	In the morning, John brushes his teeth and washes his face.	John	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:39.746538	2025-07-09 13:23:38.351383	早上，约翰刷牙和洗脸。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/f462e163de86bb42a1f6197c785409d3.mp3	f462e163de86bb42a1f6197c785409d3	2025-07-10 12:46:50.140924
892	The radio played a mild tune that helped me relax.	mild	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.141994	2025-07-09 13:28:51.473477	收音机播放了一首柔和的曲子，帮助我放松。	AI generated	elementary	\N	\N	\N
3454	The sun rises in the east and sets in the west.	sun	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:40.092471	2025-07-09 13:23:38.351384	太阳从东方升起，从西方落下。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/1ac844d24c44586458be29909a70184e.mp3	1ac844d24c44586458be29909a70184e	2025-07-10 12:46:50.140924
894	Please be polite and put the jar back in the fridge.	jar	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.148037	2025-07-09 13:28:51.473478	请有礼貌地把罐子放回冰箱里。	AI generated	elementary	\N	\N	\N
902	The choir had many vocal members, making plural harmonies.	vocal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.148051	2025-07-09 13:28:54.523119	合唱团有很多会唱歌的成员，所以能唱出很多声部的和声。	AI generated	elementary	\N	\N	\N
904	The witty comedian told a lovely joke, and everyone laughed.	witty	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.745576	2025-07-09 13:28:54.52312	那个聪明的喜剧演员讲了一个好笑的笑话，大家都笑了。	AI generated	elementary	\N	\N	\N
908	The acting in the drama was superb.	drama	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.763276	2025-07-09 13:28:57.442858	这部剧的表演太棒了。	AI generated	elementary	\N	\N	\N
910	The greedy cat made a drama when it wanted more food.	greedy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.767771	2025-07-09 13:28:57.442859	贪吃猫想吃更多食物的时候就闹起来了。	AI generated	elementary	\N	\N	\N
912	I saw the band play with perfect rhythm.	rhythm	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.767775	2025-07-09 13:28:57.44286	我看到乐队演奏得很有节奏感。	AI generated	elementary	\N	\N	\N
3431	The farmers want to drive away the pests, because they are bad for the vegetables.	farmers	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:31.547085	2025-07-09 13:23:30.512425	农民伯伯想赶走害虫，因为它们对蔬菜不好。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/3b692f3ddecf5d6139aac64f93fdcc51.mp3	3b692f3ddecf5d6139aac64f93fdcc51	2025-07-10 12:48:03.378598
3491	When you feel worried, you may think that something bad is going to happen.	feel	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:54.234437	2025-07-09 13:23:53.021637	当你感到担心时，你可能会觉得不好的事情要发生了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/1a668df77951659804d103648144a2a1.mp3	1a668df77951659804d103648144a2a1	2025-07-10 12:48:37.071559
3493	My aunt is an actress, but she isn't very famous.	aunt	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:54.921188	2025-07-09 13:23:53.021641	我的阿姨是个演员，但她不是很出名。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/0a04bf05972132cc4e2b611fec1170ee.mp3	0a04bf05972132cc4e2b611fec1170ee	2025-07-10 12:48:37.071559
3494	Plant eating dinosaurs don't eat meat because of their flat teeth.	Plant	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:55.457034	2025-07-09 13:23:53.021642	吃植物的恐龙不吃肉，因为它们有扁平的牙齿。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/800f5f6bf2e70fae5038095ce5de4877.mp3	800f5f6bf2e70fae5038095ce5de4877	2025-07-10 12:48:37.071559
3496	Are you as tall as your twin sister?	sister	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:56.144648	2025-07-09 13:23:53.021643	你和你双胞胎姐姐一样高吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b398ffae72eee9b9f7578bb08dde7a21.mp3	b398ffae72eee9b9f7578bb08dde7a21	2025-07-10 12:48:37.071559
3498	Do you often read books at the weekend?	books	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:56.833711	2025-07-09 13:23:53.021644	你周末经常看书吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/c6a5725dbe4204e9ef16755a5f75e3eb.mp3	c6a5725dbe4204e9ef16755a5f75e3eb	2025-07-10 12:48:37.071559
3495	Amy is crying because she can't find her favorite doll.	Amy	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:55.802206	2025-07-10 14:42:06.564195	艾米在哭，因为她找不到她最喜欢的娃娃了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/60c9ea94444f98e8ffdf0f7f0d14d430.mp3	60c9ea94444f98e8ffdf0f7f0d14d430	2025-07-10 14:42:06.560672
3471	Helen was not happy and she talked with her mum.	Helen	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:46.76264	2025-07-10 14:50:29.774421	海伦不开心，她和妈妈聊了聊。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/265f2fb325dbbcb17ee1c36d0edf4e69.mp3	265f2fb325dbbcb17ee1c36d0edf4e69	2025-07-10 14:50:29.770882
3481	I have looked for my dictionary everywhere, but still haven't found it.	dictionary	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:50.45381	2025-07-11 13:01:42.939329	我到处找我的字典，但是还是没有找到。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/c4a2cd6402cca994533ba05cea744fb6.mp3	c4a2cd6402cca994533ba05cea744fb6	2025-07-11 13:01:42.936267
3492	He always remembers to turn off the television when he isn't watching it.	television	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:54.577323	2025-07-11 13:03:35.004482	他总是记得在他不看电视的时候关掉电视。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/57d06647164a73606d9eecae1abc3630.mp3	57d06647164a73606d9eecae1abc3630	2025-07-11 13:03:35.000924
914	The witty play had superb actors and a great story.	witty	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.767779	2025-07-09 13:28:57.442861	这部有趣的剧有很棒的演员和一个精彩的故事。	AI generated	elementary	\N	\N	\N
922	I will offer you a pen to mark your name.	offer	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.046673	2025-07-09 13:29:00.229628	我会给你一支笔来写你的名字。	AI generated	elementary	\N	\N	\N
924	Please tap the table and change the topic now.	tap	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.046677	2025-07-09 13:29:00.22963	请敲一下桌子，现在换个话题吧。	AI generated	elementary	\N	\N	\N
3438	Einstein had many new ideas about physics that have changed the way we think about the world.	Einstein	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:34.158157	2025-07-09 13:23:30.512433	爱因斯坦有很多关于物理的新想法，这些想法改变了我们思考世界的方式。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/739d484f0fafd10fa612d4bbb03c8b94.mp3	739d484f0fafd10fa612d4bbb03c8b94	2025-07-10 12:48:37.071559
3501	How many types of transport do you know?	types	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:58.050479	2025-07-09 13:23:56.732968	你知道多少种交通工具？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/bfd9c42a9d557392e6354ca3cb123231.mp3	bfd9c42a9d557392e6354ca3cb123231	2025-07-10 12:48:37.071559
3502	How long can the camel live without water and food?	camel	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:58.406906	2025-07-09 13:23:56.732972	骆驼不喝水不吃东西能活多久？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/282ec011fed1be278e30f939c464862a.mp3	282ec011fed1be278e30f939c464862a	2025-07-10 12:49:13.233355
3515	What a big sweater he is wearing.	sweater	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:03.056588	2025-07-09 13:23:59.546936	他穿的毛衣真大啊！	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/d3beb5340d7b0b855e065919648e3e00.mp3	d3beb5340d7b0b855e065919648e3e00	2025-07-10 12:49:54.1596
3516	How interesting it is to play with them.	play	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:03.398549	2025-07-09 13:23:59.546937	和他们一起玩真有趣啊！	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/be3ac8933fded8391fd1fcb016fdc523.mp3	be3ac8933fded8391fd1fcb016fdc523	2025-07-10 12:49:54.1596
3517	There is a train station, a bookstore and a library in our town.	train	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:03.971932	2025-07-09 13:23:59.546938	我们镇里有一个火车站、一个书店和一个图书馆。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/baaf7cd7e8e6f43b3bc3d824f0c36276.mp3	baaf7cd7e8e6f43b3bc3d824f0c36276	2025-07-10 12:49:54.1596
3518	There aren't any lessons on Saturdays and Sundays.	Saturdays	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:04.319661	2025-07-09 13:23:59.546938	星期六和星期天没有课。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/1d08ab5d6024fb90617280ccc3e1b81f.mp3	1d08ab5d6024fb90617280ccc3e1b81f	2025-07-10 12:49:54.1596
3526	When cold weather comes, many birds move to warm places to find food.	weather	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:07.211125	2025-07-09 13:24:02.977183	当寒冷的天气来临时，许多鸟会飞到温暖的地方寻找食物。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/25f06c1fa0d3dcdbbbdd7f6b4260af55.mp3	25f06c1fa0d3dcdbbbdd7f6b4260af55	2025-07-10 12:50:23.375811
3525	Smoke alarms are tools that can tell if there is smoke in the air.	Smoke	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:06.866214	2025-07-10 14:21:30.548057	烟雾报警器是可以告诉你空气中是否有烟雾的工具。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/417b1530932d628fc6d675c2f0942d54.mp3	417b1530932d628fc6d675c2f0942d54	2025-07-10 14:21:30.542968
3527	We were very happy because we won the long jump and the long race.	jump	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:07.552787	2025-07-11 13:00:12.116394	我们非常高兴，因为我们赢了跳远和长跑比赛。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b60df9d1b907fcf4b978bbd61ca1ee54.mp3	b60df9d1b907fcf4b978bbd61ca1ee54	2025-07-11 13:00:12.112892
3514	How heavy the box is?	box	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:02.691701	2025-07-11 13:17:15.768318	这个箱子有多重啊？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/0094fa0c98042dadc209fb9127f4a171.mp3	0094fa0c98042dadc209fb9127f4a171	2025-07-11 13:17:15.765388
3519	Is there any apple juice in the fridge?	apple	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:04.654186	2025-07-09 13:23:59.546939	冰箱里有苹果汁吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/f5309410a13307b0bed4f9625481d001.mp3	f5309410a13307b0bed4f9625481d001	2025-07-10 12:49:54.1596
3520	How many pupils are there in your class?	pupils	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:04.988971	2025-07-09 13:23:59.546939	你们班有多少学生？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/30b0d3445d5036abe122e4ea411f97e1.mp3	30b0d3445d5036abe122e4ea411f97e1	2025-07-10 12:49:54.1596
3522	There is a desk and two chairs in the study.	desk	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:05.669358	2025-07-09 13:24:02.97718	书房里有一张桌子和两把椅子。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/8b0d8d28f536630139537e57e670f138.mp3	8b0d8d28f536630139537e57e670f138	2025-07-10 12:49:54.1596
3486	It is said that potato chips were invented by mistake about one hundred years ago.	potato	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:52.277937	2025-07-09 13:23:49.406571	据说薯片大约在一百年前被意外发明出来的。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b957c268de202b993018e86dc5b585de.mp3	b957c268de202b993018e86dc5b585de	2025-07-10 12:50:55.510325
3521	There were no mobile phones in the past, so they sent postcards to let others know they arrived safely.	phones	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:05.330451	2025-07-09 13:24:02.977175	过去没有手机，所以他们寄明信片告诉别人他们安全到达了。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/c7177a4daa028df418f11f889711996d.mp3	c7177a4daa028df418f11f889711996d	2025-07-10 12:50:55.510325
3528	Though it was not fine and clouds appeared in the sky that morning, the little girl made her daily trip to school as usual.	clouds	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:07.888599	2025-07-09 13:24:02.977184	虽然那天早上天气不好，天空出现了云，但小女孩还是像往常一样去上学了。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b0363ec2af5253dd92369f060dd8df73.mp3	b0363ec2af5253dd92369f060dd8df73	2025-07-10 12:50:55.510325
3539	I think my dream can come true one day.	dream	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:12.0557	2025-07-11 11:38:28.369734	我想我的梦想总有一天会实现的。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/6f5039f82757cc08574db04a9362719d.mp3	6f5039f82757cc08574db04a9362719d	2025-07-11 11:38:28.366121
3534	What day is it today?	day	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:10.13091	2025-07-10 12:47:16.520735	今天星期几？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/1592b7c63310ae6e693887718318c872.mp3	1592b7c63310ae6e693887718318c872	2025-07-10 12:47:16.510458
932	A sailor played a small part in the school play.	sailor	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.077967	2025-07-09 13:29:03.46312	一个水手在学校的戏剧里演了一个小角色。	AI generated	elementary	\N	\N	\N
936	Please use the internet to find the latest news.	use	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.077974	2025-07-09 13:29:03.463121	请用互联网查找最新的新闻。	AI generated	elementary	\N	\N	\N
944	The problems are global, and they affect many people.	global	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.282723	2025-07-09 13:29:06.340945	这些问题是全球性的，影响了很多人。	AI generated	elementary	\N	\N	\N
946	This period was such a happy time for everyone.	period	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.285075	2025-07-09 13:29:06.340946	这段时间对每个人来说都是快乐的时光。	AI generated	elementary	\N	\N	\N
948	For goodness' sake, these cookies are delicious!	sake	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.285078	2025-07-09 13:29:09.716531	天哪，这些饼干真好吃！	AI generated	elementary	\N	\N	\N
950	The scientists used a glass to conduct the experiment.	glass	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.285082	2025-07-09 13:29:09.716533	科学家们用一个玻璃杯来做实验。	AI generated	elementary	\N	\N	\N
952	I will call a taxi and throw my bag in the back.	taxi	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:55.920865	2025-07-09 13:29:09.716534	我会叫一辆出租车，然后把我的包扔到后座上。	AI generated	elementary	\N	\N	\N
51	Her innate ability to connect with people allowed her to build a strong and loyal team.	ability	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:24:06.418198	2025-07-09 13:22:22.941365	她与人沟通的天然能力让她建立了一个强大而忠诚的团队。	AI generated	intermediate	\N	\N	\N
954	The speed limit makes him an angry member of the community.	speed	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:55.920873	2025-07-09 13:29:09.716535	这个限速让他成了社区里一个愤怒的人。	AI generated	elementary	\N	\N	\N
52	The key to success in this field is the ability to adapt quickly to changing circumstances.	ability	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:24:06.418207	2025-07-09 13:22:22.941366	在这个领域成功的关键是快速适应变化的能力。	AI generated	intermediate	\N	\N	\N
956	The driver charged a lot for that small taxi item.	taxi	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:55.920877	2025-07-09 13:29:09.716536	司机为那个小小的出租车物品收了很多钱。	AI generated	elementary	\N	\N	\N
964	I saw a bright shooting star and wished I had fifty dollars.	fifty	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.394019	2025-07-09 13:29:12.693097	我看到一颗明亮的流星，希望我有五十美元。	AI generated	elementary	\N	\N	\N
149	The stray cat now belongs to the kind family at the end of the street.	belong	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.225901	2025-07-09 13:22:57.052607	这只流浪猫现在属于街尾的好心人家了。	AI generated	intermediate	\N	\N	\N
966	The rapid blinking of the lamp meant it needed a new bulb.	rapid	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.401828	2025-07-09 13:29:12.693098	灯快速闪烁意味着它需要一个新的灯泡。	AI generated	elementary	\N	\N	\N
974	He ran very fast, twice around the school track!	fast	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.409789	2025-07-09 13:29:15.885065	他跑得非常快，绕着学校的跑道跑了两圈！	AI generated	elementary	\N	\N	\N
976	I feel that I weigh too much after eating all that cake.	weigh	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.687614	2025-07-09 13:29:15.885066	我觉得吃了那么多蛋糕后，我太重了。	AI generated	elementary	\N	\N	\N
6	The cat sat on the mat.	cat	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:13:20.197367	2025-07-09 13:22:07.897856	猫咪坐在垫子上。	AI generated	elementary	\N	\N	\N
7	My cat loves to play with yarn.	cat	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:13:20.197375	2025-07-09 13:22:07.897857	我的猫咪喜欢玩毛线。	AI generated	elementary	\N	\N	\N
8	That is a fluffy cat.	cat	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:13:20.197378	2025-07-09 13:22:07.897857	那是一只毛茸茸的猫。	AI generated	elementary	\N	\N	\N
9	The dog chased the ball.	dog	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:18:40.022499	2025-07-09 13:22:07.897858	小狗追着球跑。	AI generated	elementary	\N	\N	\N
19	My car is a shiny red.	red	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:20:25.688658	2025-07-09 13:22:11.333638	我的车是闪亮的红色。	AI generated	elementary	\N	\N	\N
20	He painted the fence red.	red	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:20:25.68866	2025-07-09 13:22:11.333638	他把栅栏漆成了红色。	AI generated	elementary	\N	\N	\N
31	My favorite fruit is a banana.	banana	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:17.795382	2025-07-09 13:22:13.873904	我最喜欢的水果是香蕉。	AI generated	elementary	\N	\N	\N
32	I peeled the banana and ate it.	banana	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:17.795385	2025-07-09 13:22:13.873904	我剥了香蕉皮，然后把它吃了。	AI generated	elementary	\N	\N	\N
40	He is a good father to his children.	father	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:22:57.919981	2025-07-09 13:22:18.788093	他对他的孩子们来说是个好爸爸。	AI generated	elementary	\N	\N	\N
41	The father gave his son a toy.	father	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:22:57.919984	2025-07-09 13:22:18.788093	爸爸给了他的儿子一个玩具。	AI generated	elementary	\N	\N	\N
42	My sister is a doctor.	sister	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:21.088795	2025-07-09 13:22:18.788094	我的姐姐是一位医生。	AI generated	elementary	\N	\N	\N
50	I visited my grandmother last weekend.	grandmother	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:23:48.090527	2025-07-09 13:22:22.941365	我上周末去看了我的奶奶。	AI generated	elementary	\N	\N	\N
56	He sent a postcard from abroad.	abroad	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:24:45.0758	2025-07-09 13:22:25.757359	他从国外寄来一张明信片。	AI generated	elementary	\N	\N	\N
57	Her absence from the meeting was noted, and her explanation was deemed unsatisfactory.	absence	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:25:05.67693	2025-07-09 13:22:25.75736	大家注意到她没来开会，而且她的解释也不让人满意。	AI generated	elementary	\N	\N	\N
58	The prolonged absence of rainfall led to a severe drought in the region.	absence	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:25:05.676938	2025-07-09 13:22:25.75736	长时间不下雨导致这个地区发生了严重的旱灾。	AI generated	elementary	\N	\N	\N
59	In the absence of clear evidence, the jury delivered a not-guilty verdict.	absence	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:25:05.676941	2025-07-09 13:22:25.757361	因为没有明确的证据，陪审团判决无罪。	AI generated	elementary	\N	\N	\N
60	The students need access to the library.	access	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:25:34.717572	2025-07-09 13:22:25.757362	学生们需要能去图书馆。	AI generated	elementary	\N	\N	\N
61	We have access to clean water.	access	SV	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:25:34.71758	2025-07-09 13:22:25.757362	我们能用到干净的水。	AI generated	elementary	\N	\N	\N
62	The key gives you access to the building.	access	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:25:34.717583	2025-07-09 13:22:25.757363	这把钥匙能让你进入这栋楼。	AI generated	elementary	\N	\N	\N
63	The driver swerved to avoid a child, causing a minor accident.	accident	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:26:07.788879	2025-07-09 13:22:25.757363	司机为了躲避一个小孩，猛打方向盘，导致了一起小事故。	AI generated	elementary	\N	\N	\N
70	After the busy party, he was finally alone with his thoughts.	alone	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946109	2025-07-09 13:22:29.432965	在热闹的聚会之后，他终于可以一个人静静地思考了。	AI generated	elementary	\N	\N	\N
71	The old lighthouse stands alone on the rocky cliff.	alone	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946111	2025-07-09 13:22:29.432966	古老的灯塔独自矗立在岩石峭壁上。	AI generated	elementary	\N	\N	\N
72	By the time I offered to help, she had already completed the entire project.	already	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946113	2025-07-09 13:22:29.432967	等我说要帮忙的时候，她已经完成了整个项目。	AI generated	elementary	\N	\N	\N
73	I can't believe the year is already over; it feels like it just began.	already	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946114	2025-07-09 13:22:29.432967	我不敢相信一年已经结束了；感觉好像才刚刚开始。	AI generated	elementary	\N	\N	\N
82	Her performance in the play was truly amazing.	amazing	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.94613	2025-07-09 13:22:33.204323	她在戏剧里的表演真是太棒了。	AI generated	elementary	\N	\N	\N
83	The host showed us an amazing collection of historical artifacts.	amazing	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946132	2025-07-09 13:22:33.204324	主人向我们展示了一个令人惊叹的历史文物收藏。	AI generated	elementary	\N	\N	\N
1	The cat is sleeping on the bed.	is	SVO	0.9	0.9	0.9	0	0	t	\N	APPROVED	\N	\N	0	\N	2025-07-06 08:13:50.991993	2025-07-09 13:22:07.897848	猫咪正在床上睡觉。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/fc446705359c31ec380f8ceb94a0f72c.mp3	fc446705359c31ec380f8ceb94a0f72c	2025-07-10 12:50:55.510325
3341	The Dragon Boat Festival is usually in June in China.	Dragon	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:02:57.93867	2025-07-09 13:22:11.333639	中国的端午节通常在六月。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/59b9a15bff464eeb24e64ef2ae8a4ece.mp3	59b9a15bff464eeb24e64ef2ae8a4ece	2025-07-10 12:51:32.563377
91	According to the official report, the final analysis was inconclusive.	analysis	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946167	2025-07-09 13:22:37.270353	根据官方报告，最终的分析结果没有明确的结论。	AI generated	elementary	\N	\N	\N
92	The team's detailed analysis pointed to a critical flaw in the design.	analysis	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946169	2025-07-09 13:22:37.270354	团队的详细分析指出了设计中一个很重要的错误。	AI generated	elementary	\N	\N	\N
93	For breakfast, I usually have toast and orange juice.	and	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946171	2025-07-09 13:22:37.270354	我早餐通常吃吐司和橙汁。	AI generated	elementary	\N	\N	\N
95	The children played happily in the park and at the beach.	and	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:01:26.946174	2025-07-09 13:22:40.100801	孩子们在公园和海滩上开心地玩耍。	AI generated	elementary	\N	\N	\N
96	The little boy kicked the red ball across the field.	ball	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.109995	2025-07-09 13:22:40.100801	小男孩把红色的球踢过了场地。	AI generated	elementary	\N	\N	\N
97	The soccer ball is a standard size five.	ball	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.110001	2025-07-09 13:22:40.100802	这个足球是标准的五号大小。	AI generated	elementary	\N	\N	\N
98	The tennis ball bounced high over the net.	ball	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.110003	2025-07-09 13:22:40.100803	网球高高地弹过了球网。	AI generated	elementary	\N	\N	\N
99	I need to deposit this check at the bank.	bank	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.113408	2025-07-09 13:22:40.100803	我需要把这张支票存到银行。	AI generated	elementary	\N	\N	\N
100	The children sat on the grassy bank of the river.	bank	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.113412	2025-07-09 13:22:40.100804	孩子们坐在河边长满草的岸上。	AI generated	elementary	\N	\N	\N
101	The bank offered us a loan with a low interest rate.	bank	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.113414	2025-07-09 13:22:40.100804	银行给我们提供了一个低利率的贷款。	AI generated	elementary	\N	\N	\N
102	The heavy rain completely flooded our basement.	basement	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.116211	2025-07-09 13:22:40.100805	大雨完全淹没了我们的地下室。	AI generated	elementary	\N	\N	\N
103	Because of the lack of windows, the basement was always dark.	basement	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.116215	2025-07-09 13:22:40.100805	因为没有窗户，地下室总是很黑。	AI generated	elementary	\N	\N	\N
111	The waves on the beach were perfect for surfing today.	beach	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.124356	2025-07-09 13:22:43.260177	今天海滩上的浪非常适合冲浪。	AI generated	elementary	\N	\N	\N
112	My family goes to the beach every summer for vacation.	beach	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.12436	2025-07-09 13:22:43.260178	每年夏天，我的家人都会去海滩度假。	AI generated	elementary	\N	\N	\N
113	The children built a large sandcastle on the beach.	beach	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.124362	2025-07-09 13:22:43.260178	孩子们在海滩上建造了一个很大的沙堡。	AI generated	elementary	\N	\N	\N
121	This new bed is much more comfortable than my old one.	bed	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.132127	2025-07-09 13:22:46.37453	这张新床比我的旧床舒服多了。	AI generated	elementary	\N	\N	\N
122	Please remember to make your bed every morning.	bed	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.132129	2025-07-09 13:22:46.374531	请记住每天早上都要整理你的床。	AI generated	elementary	\N	\N	\N
123	Her bedroom is her private sanctuary where she can relax.	bedroom	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:49.13464	2025-07-09 13:22:46.374532	她的卧室是她私人的避风港，在那里她可以放松。	AI generated	elementary	\N	\N	\N
131	The butcher sold us a wonderful cut of beef for the barbecue.	beef	SVOO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.210068	2025-07-09 13:22:51.20715	肉店老板卖给我们一块很棒的牛肉用来烧烤。	AI generated	elementary	\N	\N	\N
132	Let's begin the meeting with a review of last week's minutes.	begin	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.212905	2025-07-09 13:22:51.207151	让我们从回顾上周的会议记录开始这次会议。	AI generated	elementary	\N	\N	\N
133	The movie will begin in five minutes.	begin	SV	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.212909	2025-07-09 13:22:51.207152	电影将在五分钟后开始。	AI generated	elementary	\N	\N	\N
136	At the beginning of the semester, all students receive their new schedules.	beginning	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.215625	2025-07-09 13:22:53.992176	在学期开始的时候，所有学生都会收到新的课程表。	AI generated	elementary	\N	\N	\N
137	Learning a new language is difficult, but this is only the beginning.	beginning	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.215627	2025-07-09 13:22:53.992177	学习一门新的语言很难，但这只是个开始。	AI generated	elementary	\N	\N	\N
139	Despite a slow start, he refused to fall behind in the competition.	behind	SV	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.218237	2025-07-09 13:22:53.992178	尽管开始很慢，他拒绝在比赛中落后。	AI generated	elementary	\N	\N	\N
140	The team put the tough loss behind them and focused on the next game.	behind	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.218239	2025-07-09 13:22:53.992178	团队把艰难的失败抛在脑后，专注于下一场比赛。	AI generated	elementary	\N	\N	\N
141	Her core belief is that kindness can change the world.	belief	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.220711	2025-07-09 13:22:53.992179	她的核心信念是善良可以改变世界。	AI generated	elementary	\N	\N	\N
142	The team's strong belief in their strategy helped them win the championship.	belief	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.220715	2025-07-09 13:22:53.99218	团队对他们策略的坚定信念帮助他们赢得了冠军。	AI generated	elementary	\N	\N	\N
143	He acted on his belief that everyone deserves fair treatment.	belief	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.220718	2025-07-09 13:22:53.99218	他根据他的信念行事，那就是每个人都应该得到公平的对待。	AI generated	elementary	\N	\N	\N
150	He wore a brown leather belt to match his new shoes.	belt	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.228614	2025-07-09 13:22:57.052607	他戴了一条棕色皮带，和他的新鞋很配。	AI generated	elementary	\N	\N	\N
151	An important safety rule is to always wear your seat belt.	belt	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.228618	2025-07-09 13:22:57.052608	一个重要的安全规则是总是要系好安全带。	AI generated	elementary	\N	\N	\N
152	Her tools hung conveniently from the utility belt around her waist.	belt	SVA	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.22862	2025-07-09 13:22:57.052608	她的工具很方便地挂在她腰上的工具带上。	AI generated	elementary	\N	\N	\N
153	The new public library will benefit citizens of all ages.	benefit	SVO	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:02:59.231091	2025-07-09 13:22:57.052609	新的公共图书馆会让所有年龄段的市民受益。	AI generated	elementary	\N	\N	\N
3360	If we take good care of our Earth today, it will be more beautiful tomorrow.	Earth	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:05.157835	2025-07-09 13:23:03.5235	如果我们今天好好爱护地球，明天它会更美丽。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/8bc1fe105c837f5151a0895796f98dbb.mp3	8bc1fe105c837f5151a0895796f98dbb	2025-07-10 12:51:32.563377
3389	He goes to school at seven thirty, and he gets to school at eight o'clock.	school	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:15.958104	2025-07-09 13:23:13.212154	他七点半去上学，八点钟到学校。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/0df1896e63ab819f8d414ddd421c9c89.mp3	0df1896e63ab819f8d414ddd421c9c89	2025-07-10 12:51:32.563377
3350	The Teacher's Office is next to the classroom.	Office	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:01.292526	2025-07-09 13:23:00.14124	老师的办公室在教室旁边。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/cf2db6fd12187cbad755bd2e1f8fa212.mp3	cf2db6fd12187cbad755bd2e1f8fa212	2025-07-10 12:51:32.563377
3359	I can play basketball well, but I am not good at football.	basketball	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:04.815697	2025-07-09 13:23:03.523499	我篮球打得很好，但是我不擅长踢足球。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/873eb31826279138667723cb05a2d904.mp3	873eb31826279138667723cb05a2d904	2025-07-10 12:51:32.563377
3370	These are the flowers my mum planted in the garden.	flowers	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:08.750328	2025-07-09 13:23:06.813109	这些是妈妈在花园里种的花。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/c22ca2537f70d4cccc7fb222d6637759.mp3	c22ca2537f70d4cccc7fb222d6637759	2025-07-10 12:52:10.992925
3380	It's an invitation to my birthday party and I'm going to be eleven.	invitation	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:12.35637	2025-07-09 13:23:10.209159	这是一张我的生日派对邀请函，我今年要十一岁了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ec0f2695ad75b64757b21db0026631c9.mp3	ec0f2695ad75b64757b21db0026631c9	2025-07-10 12:52:10.992925
3394	On the beach, some girls are drawing pictures under an umbrella.	beach	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:17.684034	2025-07-09 13:23:17.063681	在沙滩上，一些女孩正在伞下画画。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/9ae75ae996e6b28952e6f97cba9a983f.mp3	9ae75ae996e6b28952e6f97cba9a983f	2025-07-10 12:52:10.992925
3395	The subway station is in front of the bus stop.	subway	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:18.036499	2025-07-09 13:23:17.063682	地铁站在公交车站的前面。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/32eaafdd5d61d506d1d4826c3879cc94.mp3	32eaafdd5d61d506d1d4826c3879cc94	2025-07-10 12:52:10.992925
3396	You can have lunch in the Chinese restaurant, which is next to the cinema.	lunch	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:18.385543	2025-07-09 13:23:17.063682	你可以在中餐馆吃午饭，它就在电影院旁边。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/605005576c3ced61ae78e637ce9f5783.mp3	605005576c3ced61ae78e637ce9f5783	2025-07-10 12:52:10.992925
3419	The waiters in the restaurant are very friendly and helpful.	waiters	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:27.205716	2025-07-09 13:23:23.882122	餐馆里的服务员非常友好和乐于助人。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/d1828ddc281d04096fa5bc5d102cdfca.mp3	d1828ddc281d04096fa5bc5d102cdfca	2025-07-10 12:52:55.718167
3420	You will never get the true feelings without trying.	feelings	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:27.550628	2025-07-09 13:23:23.882122	不去尝试，你永远不会得到真实的感受。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/30bebae34aa4d91ef9a5c189589c3520.mp3	30bebae34aa4d91ef9a5c189589c3520	2025-07-10 12:52:55.718167
3368	Help yourself.	Help	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:08.078304	2025-07-11 13:16:48.65386	请随便吃/喝。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/74a9d9b1bf42623e392dacf886212188.mp3	74a9d9b1bf42623e392dacf886212188	2025-07-11 13:16:48.650489
3442	Shall we meet at one thirty in front of the garden theatre?	front	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:35.728182	2025-07-09 13:23:34.15257	我们要在花园剧院前面一点半见面吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/857b1fa7ee580e7921b33aa46d37901c.mp3	857b1fa7ee580e7921b33aa46d37901c	2025-07-10 12:52:55.718167
3444	In a lion family, mother lions catch animals, but father lions sleep a lot.	lion	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:36.401226	2025-07-09 13:23:34.152572	在狮子家庭里，母狮子抓动物，但是公狮子睡很多觉。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/c462db639af5a7281f09846143270177.mp3	c462db639af5a7281f09846143270177	2025-07-10 12:52:55.718167
3445	To keep our school clean, we should put rubbish in the bin.	bin	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:36.737173	2025-07-09 13:23:34.152572	为了保持学校干净，我们应该把垃圾扔进垃圾桶。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b78f10a86ed4a4a5c66e5410eca3848e.mp3	b78f10a86ed4a4a5c66e5410eca3848e	2025-07-10 12:52:55.718167
3446	My uncle likes to cook, but he never washes the dishes.	uncle	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:37.085381	2025-07-09 13:23:34.152573	我的叔叔喜欢做饭，但是他从来不洗碗。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/13b92618ea0377eeb6c630974e392b79.mp3	13b92618ea0377eeb6c630974e392b79	2025-07-10 12:52:55.718167
3472	I took lots of pictures and I also went swimming yesterday.	lots	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:47.117032	2025-07-09 13:23:45.02721	昨天我拍了很多照片，还去游泳了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/d4f5eb18c37a2bd9c5218522ea08cc51.mp3	d4f5eb18c37a2bd9c5218522ea08cc51	2025-07-10 12:53:41.955169
3474	The old man's son didn't join the army because his leg was broken.	man	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:47.805909	2025-07-09 13:23:45.027211	那个老人的儿子没有参军，因为他的腿摔断了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/3f83952ee0511a6a77192de74361d743.mp3	3f83952ee0511a6a77192de74361d743	2025-07-10 12:53:41.955169
3475	I got a ride this morning, so I wasn't late for school.	ride	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:48.148817	2025-07-09 13:23:45.027212	今天早上我搭了车，所以上学没有迟到。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/60c88ddd0fe5ab1554839a56f5725549.mp3	60c88ddd0fe5ab1554839a56f5725549	2025-07-10 12:53:41.955169
3476	Susan's parents have bought a large house with a swimming pool.	Susan	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:48.493477	2025-07-09 13:23:45.027212	苏珊的爸爸妈妈买了一栋带游泳池的大房子。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/eee5f3e481523729331c6685723baae7.mp3	eee5f3e481523729331c6685723baae7	2025-07-10 12:53:41.955169
3479	David has finally arrived at the museum.	David	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:49.756806	2025-07-09 13:23:45.027214	大卫终于到达博物馆了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/3a773ac05278d4ad883673e3c683c0de.mp3	3a773ac05278d4ad883673e3c683c0de	2025-07-10 12:53:41.955169
3504	What time does Jenny usually go to school?	Jenny	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:59.09087	2025-07-09 13:23:56.732973	珍妮通常几点去上学？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/36e77ead4d816af964fe587ae11a0af1.mp3	36e77ead4d816af964fe587ae11a0af1	2025-07-10 12:54:21.827374
3505	Which is the better way to go to the hotel?	way	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:59.436491	2025-07-09 13:23:56.732974	去宾馆哪个方法更好？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b1f57acaa4804828e5065601f87b4388.mp3	b1f57acaa4804828e5065601f87b4388	2025-07-10 12:54:21.827374
3506	She seldom goes to work by bicycle on rainy days.	work	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:59.778497	2025-07-09 13:23:56.732974	下雨天她很少骑自行车去上班。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/8d5bfd6ba837222eebd5d41c1de485c5.mp3	8d5bfd6ba837222eebd5d41c1de485c5	2025-07-10 12:54:21.827374
3507	These are his father's favorite things, aren't they?	father	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:00.120464	2025-07-09 13:23:56.732975	这些是他爸爸最喜欢的东西，不是吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/35e91d28d241e661d6065a8a7073d92b.mp3	35e91d28d241e661d6065a8a7073d92b	2025-07-10 12:54:21.827374
3429	He had lots of chocolate yesterday, so today he has got a stomach ache.	lots	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:30.861409	2025-07-11 12:50:26.67627	他昨天吃了很多巧克力，所以今天他肚子疼。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/9e867e683b345746918a6e23741a329f.mp3	9e867e683b345746918a6e23741a329f	2025-07-11 12:50:26.672046
3470	There was no gym in my school twenty years ago.	gym	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:46.244	2025-07-11 12:52:39.745619	二十年前我的学校里没有体育馆。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/5476784ba315e6f8f21c47a8f9d84683.mp3	5476784ba315e6f8f21c47a8f9d84683	2025-07-11 12:52:39.74164
991	You should not tell a joke if you can’t remember it.	joke	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.707536	2025-07-09 13:29:21.706944	如果你记不住笑话，就不要讲。	AI generated	elementary	\N	\N	\N
993	The movie about the haunted oak tree filled him with terror.	terror	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.70754	2025-07-09 13:29:21.706945	关于闹鬼橡树的电影让他感到非常害怕。	AI generated	elementary	\N	\N	\N
995	The cat licked its paw, trying to undo the knot in its fur.	its	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.900943	2025-07-09 13:29:21.706947	猫舔着爪子，想解开毛上的结。	AI generated	elementary	\N	\N	\N
1003	I saw the colorful kite slip from his hand.	slip	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.905939	2025-07-09 13:29:24.395157	我看到那只彩色的风筝从他的手里滑落了。	AI generated	elementary	\N	\N	\N
1005	It is wise to make the surface smooth before you paint.	wise	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.905942	2025-07-09 13:29:24.395158	在油漆之前把表面弄光滑是明智的。	AI generated	elementary	\N	\N	\N
3509	The library rule says don't talk in the library.	library	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:01.005698	2025-07-09 13:23:56.732976	图书馆规定说不要在图书馆里说话。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/cbf9260ef978f068a2d9bb0ea27cf670.mp3	cbf9260ef978f068a2d9bb0ea27cf670	2025-07-10 12:54:21.827374
3510	Let's go and watch the games on the playground.	games	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:01.344813	2025-07-09 13:23:56.732976	咱们去操场看比赛吧。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/db0f4c5f495a64333c577587cff6fdb0.mp3	db0f4c5f495a64333c577587cff6fdb0	2025-07-10 12:54:21.827374
3390	I was very happy when I heard the news that China's first manned spacecraft, Shen Zhou Five, was launched on October 15th,	China	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:16.297377	2025-07-09 13:23:13.212154	当我听到中国第一个载人宇宙飞船，神舟五号，在10月15日发射的消息时，我非常高兴。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/158d9eaa3008700ffafda95ed885aec5.mp3	158d9eaa3008700ffafda95ed885aec5	2025-07-10 12:54:21.827374
3397	Mr. Green wants to take his car out, so he asks a man to clean the road from his garage to the gate. 7	Mr.	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:18.911827	2025-07-09 13:23:17.063683	格林先生想把车开出去，所以他请一个人打扫从他家车库到大门口的路。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/139eb44ff7521133aed9c99314fe3998.mp3	139eb44ff7521133aed9c99314fe3998	2025-07-10 12:54:21.827374
3400	The school is next to his home, so he always goes to school on foot and comes back home on time.	school	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:19.967827	2025-07-09 13:23:17.063685	学校在他家旁边，所以他总是走路去上学，并且按时回家。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/f8bf6d6a7c88b3194893892af2455b05.mp3	f8bf6d6a7c88b3194893892af2455b05	2025-07-10 12:55:09.4915
3426	At the parties there are all kinds of food and drinks, and people often sing and dance until the arrival of new year.	parties	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:29.64439	2025-07-09 13:23:27.291637	在聚会上，有各种各样的食物和饮料，人们常常唱歌跳舞直到新年到来。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/adf5702c5d59977da956fc3d656ab527.mp3	adf5702c5d59977da956fc3d656ab527	2025-07-10 12:55:09.4915
3428	In the morning and in the evening, when people go to or come back from work, the streets are very busy.	morning	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:30.528856	2025-07-09 13:23:27.291638	早上和晚上，当人们上班或下班的时候，街道上非常繁忙。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/a2dac53ec60f95bcf2785295c6868acf.mp3	a2dac53ec60f95bcf2785295c6868acf	2025-07-10 12:55:09.4915
3508	Be careful!	careful	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:00.475706	2025-07-11 13:12:46.156615	小心！	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ae3f0a0be98c5b83248c0e5fc2a34920.mp3	ae3f0a0be98c5b83248c0e5fc2a34920	2025-07-11 13:12:46.150963
508	Showing courtesy to people with different backgrounds is important, otherwise, you might face social isolation.	courtesy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:29.090946	2025-07-09 13:24:08.98096	对不同背景的人有礼貌很重要，不然你可能会被大家孤立。	AI generated	intermediate	\N	\N	\N
55	She lives abroad in a foreign country.	abroad	SV	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:24:45.075798	2025-07-09 13:24:38.827555	她住在国外的一个外国。	AI generated	elementary	\N	\N	\N
156	Her generosity was supreme, an unmatched act of kindness to all.	generosity	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.407171	2025-07-09 13:24:38.827556	她的慷慨是最高的，是对大家无与伦比的善举。	AI generated	elementary	\N	\N	\N
160	A key provision of the contract guaranteed the success of the project.	provision	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.407184	2025-07-09 13:24:41.683026	合同里重要的一条保证了项目的成功。	AI generated	elementary	\N	\N	\N
163	The officer gave clear direction to evacuate the building immediately.	officer	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.407189	2025-07-09 13:24:41.683027	警官清楚地指示大家立刻离开大楼。	AI generated	elementary	\N	\N	\N
165	He reacted angrily when his holiday vacation was cancelled.	holiday	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.407193	2025-07-09 13:24:41.683028	当他的假期被取消时，他生气了。	AI generated	elementary	\N	\N	\N
3529	If you want to be healthy, you have to learn which foods are good for you.	foods	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:08.249671	2025-07-09 13:24:02.977184	如果你想保持健康，你必须学习哪些食物对你有好处。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/638eea72058c9654dfdf99e6400627cd.mp3	638eea72058c9654dfdf99e6400627cd	2025-07-10 12:55:09.4915
175	A professional musician requires a finely tuned instrument.	professional	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.475125	2025-07-09 13:24:45.754925	专业的音乐家需要一个音调准确的乐器。	AI generated	elementary	\N	\N	\N
185	Scientific advancements often challenge pre-existing philosophy.	scientific	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.509538	2025-07-09 13:24:51.00904	科学的进步常常会挑战以前的想法。	AI generated	elementary	\N	\N	\N
189	Maintaining mental strength requires a consistent daily schedule.	strength	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.509544	2025-07-09 13:24:54.577636	保持心理强大需要每天都有规律的安排。	AI generated	elementary	\N	\N	\N
191	We must forgive past errors to advance scientific progress.	forgive	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.509547	2025-07-09 13:24:54.577637	我们必须原谅过去的错误，才能让科学进步。	AI generated	elementary	\N	\N	\N
193	The academic publication detailed the city's capital improvement projects for the next decade.	capital	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.557689	2025-07-09 13:24:54.577638	学术刊物详细介绍了这个城市未来十年的大型改进工程。	AI generated	elementary	\N	\N	\N
195	The submarine captain made a sizable charity donation after his successful mission.	submarine	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.565051	2025-07-09 13:24:54.577639	潜艇艇长在成功完成任务后，捐了一大笔钱给慈善机构。	AI generated	elementary	\N	\N	\N
204	The scientist reported an unusual detection in the atmospheric data.	detection	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.569526	2025-07-09 13:24:57.299854	科学家报告说在大气数据中发现了一个奇怪的东西。	AI generated	elementary	\N	\N	\N
246	Achieving that level of precision requires a specific vitamin and mineral balance in the diet.	precision	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.535752	2025-07-09 13:25:11.565513	要达到那种精确度，饮食中需要有特定的维生素和矿物质平衡。	AI generated	intermediate	\N	\N	\N
206	My husband was incredibly helpful when I struggled with the new software at work.	husband	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.5892	2025-07-09 13:24:57.299855	当我在工作中遇到新软件难题时，我的丈夫非常乐于助人。	AI generated	elementary	\N	\N	\N
214	Finding a suitable apartment can be a real difficulty in such a competitive market.	suitable	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.596903	2025-07-09 13:25:01.044097	在竞争激烈的市场中找到合适的公寓可能非常困难。	AI generated	elementary	\N	\N	\N
3541	The cat is sleeping on the bed.	cat	SVO	0.88	0.9	0.89	0	0	f	\N	APPROVED	\N	\N	0	\N	2025-07-09 14:55:36.471219	2025-07-09 14:55:36.471219	猫正在床上睡觉。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/fc446705359c31ec380f8ceb94a0f72c.mp3	fc446705359c31ec380f8ceb94a0f72c	2025-07-10 12:42:58.007997
216	Our guide was helpful in ensuring our jungle adventure was both safe and exhilarating.	adventure	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.596906	2025-07-09 13:25:01.044099	我们的导游很乐于助人，确保我们的丛林探险既安全又刺激。	AI generated	elementary	\N	\N	\N
224	The shallow bay made coastal navigation tricky, even with modern technology.	shallow	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:12.046218	2025-07-09 13:25:04.742957	这个浅浅的海湾让沿海航行变得很困难，即使有现代科技也是如此。	AI generated	elementary	\N	\N	\N
3342	I like pandas because they're cute and fat.	pandas	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:02:58.286828	2025-07-09 13:02:58.286831	我喜欢熊猫，因为它们又可爱又胖。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/3f0d9fc00a3d620aa64afad38d6b382b.mp3	3f0d9fc00a3d620aa64afad38d6b382b	2025-07-10 12:42:58.007997
226	We must conduct ourselves with integrity, understanding the privilege we've been given.	conduct	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:12.046222	2025-07-09 13:25:04.742958	我们必须正直行事，明白我们被赋予的特权。	AI generated	elementary	\N	\N	\N
3547	The bird is flying in the sky.	bird	SV	0.93	0.91	0.92	0	0	f	\N	APPROVED	\N	\N	0	\N	2025-07-09 14:55:36.471226	2025-07-09 14:55:36.471227	鸟儿在天空中飞翔。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/5833b69a22f18d38ddb995c7d148dfca.mp3	5833b69a22f18d38ddb995c7d148dfca	2025-07-10 12:42:58.007997
228	The organization secretly aimed for universal acceptance of their radical ideas.	secretly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:12.046226	2025-07-09 13:25:08.299429	那个组织偷偷地想要让所有人都接受他们很特别的想法。	AI generated	elementary	\N	\N	\N
232	My grandpa's positive attitude continues to influence my life.	grandpa	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.103973	2025-07-09 13:25:08.299433	我爷爷乐观的态度一直在影响我的生活。	AI generated	elementary	\N	\N	\N
3351	It's a picture of the Great Wall.	Great	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:01.814699	2025-07-09 13:23:03.523491	这是一张关于长城的照片。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/006d8f3afb32c06b2b35fb63c062775b.mp3	006d8f3afb32c06b2b35fb63c062775b	2025-07-10 12:43:21.125645
234	My anxiety lessened after talking to my grandpa about it.	anxiety	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.103977	2025-07-09 13:25:08.299435	和爷爷聊了之后，我的担心就减少了。	AI generated	elementary	\N	\N	\N
236	The instructor helped me correct my swimming technique efficiently.	swimming	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.103981	2025-07-09 13:25:08.299437	教练帮助我很快地改正了游泳的姿势。	AI generated	elementary	\N	\N	\N
3348	A hamburger, noodles and a glass of milk please.	hamburger	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:00.557176	2025-07-10 15:06:51.30127	请给我一个汉堡包、面条和一杯牛奶。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/2ad37884b8e9bd5ebb01087193ac289e.mp3	2ad37884b8e9bd5ebb01087193ac289e	2025-07-10 15:06:51.295703
244	The discovery that a daily vitamin supplement could prevent this rare disease was groundbreaking.	discovery	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.535748	2025-07-09 13:25:11.565512	发现每天吃维生素补充剂可以预防这种罕见疾病，这是一个很棒的发现。	AI generated	elementary	\N	\N	\N
3352	An apple a day keeps the doctor away.	apple	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:02.168358	2025-07-11 12:44:28.076355	一天一个苹果，医生远离我。（意思是：吃苹果对身体好，不容易生病。）	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/fbdb080ffd85edc875496678692a5ec4.mp3	fbdb080ffd85edc875496678692a5ec4	2025-07-11 12:44:28.072918
254	After the storm, we said goodbye and headed for the nearest shelter.	goodbye	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.715725	2025-07-09 13:25:14.600349	暴风雨过后，我们说了再见，然后前往最近的避难所。	AI generated	elementary	\N	\N	\N
3340	Look at my pink skirt.	skirt	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:02:57.581099	2025-07-12 04:36:15.42549	看看我的粉色裙子。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/90dfc56b3d528f513264c9bd43eeab7d.mp3	90dfc56b3d528f513264c9bd43eeab7d	2025-07-12 04:36:15.421299
256	Let's celebrate with a big party before we say goodbye to everyone.	celebrate	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.729014	2025-07-09 13:25:14.60035	在和大家说再见之前，我们开个大派对庆祝一下吧！	AI generated	elementary	\N	\N	\N
264	The speaker's voice was familiar to many in the audience.	familiar	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.733126	2025-07-09 13:25:17.97954	演讲者的声音对观众中的很多人来说都很熟悉。	AI generated	elementary	\N	\N	\N
3347	I'm hungry so I'd like some rice.	rice	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:00.207646	2025-07-12 05:06:33.311005	我饿了，所以我想吃点米饭。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/743fbfc26298c65247aa98f39c00a236.mp3	743fbfc26298c65247aa98f39c00a236	2025-07-12 05:06:33.307863
276	The sudden job loss caused a painful transition and cast a blanket of uncertainty over their future.	blanket	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.830163	2025-07-09 13:25:21.082202	突然失业带来痛苦的转变，也让他们的未来充满不确定。	AI generated	intermediate	\N	\N	\N
266	We hope to continue to see improvement in your academic performance this semester.	continue	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.820046	2025-07-09 13:25:17.979541	我们希望这个学期能继续看到你学习上的进步。	AI generated	elementary	\N	\N	\N
270	Her transition to a leadership role was an excellent move for the company.	excellent	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.826973	2025-07-09 13:25:21.082198	她转变成领导角色对公司来说是个很棒的举动。	AI generated	elementary	\N	\N	\N
3355	The gloves are nice and I'd like to try them on.	gloves	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:03.223427	2025-07-09 13:23:03.523497	这双手套很好看，我想试试。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/11d4f28121c04f966dccd23bec033903.mp3	11d4f28121c04f966dccd23bec033903	2025-07-10 12:43:21.125645
272	They found somewhere offering significant improvement to their living conditions.	somewhere	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.830157	2025-07-09 13:25:21.082199	他们找到了一个能大大改善他们生活条件的地方。	AI generated	elementary	\N	\N	\N
3356	At the Spring Festival, we eat lots of delicious food.	Spring	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:03.599473	2025-07-09 13:23:03.523498	在春节的时候，我们吃很多好吃的东西。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/6b197bfcf187d42ab265d100c6b16f44.mp3	6b197bfcf187d42ab265d100c6b16f44	2025-07-10 12:43:21.125645
274	Digital currency is challenging traditional notions of ownership and finance.	currency	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.83016	2025-07-09 13:25:21.0822	数字货币正在挑战我们对所有权和金融的传统想法。	AI generated	elementary	\N	\N	\N
3357	We have an art room on the second floor.	art	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:03.941822	2025-07-09 13:23:03.523498	我们在二楼有一个美术教室。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/6aec62fdbe0253040f54bc5246d34ee5.mp3	6aec62fdbe0253040f54bc5246d34ee5	2025-07-10 12:43:21.125645
3349	If we waste too much water, one day in the future, the last drop of water on the planet will be our tear.	water	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:00.92972	2025-07-09 13:23:00.141239	如果我们浪费太多水，将来有一天，地球上最后一滴水会变成我们的眼泪。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/2b279653cd0cddb3c88fdf06deb48d71.mp3	2b279653cd0cddb3c88fdf06deb48d71	2025-07-10 12:43:49.536677
286	My grandma's recommendation for the restaurant was spot on.	grandma	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.907876	2025-07-09 13:25:24.185176	我奶奶推荐的餐馆真是太棒了。	AI generated	elementary	\N	\N	\N
294	Maintaining a balance between work and life is relatively difficult in this demanding profession.	balance	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.955131	2025-07-09 13:25:27.918414	在这个要求很高的职业中，保持工作和生活的平衡比较难。	AI generated	elementary	\N	\N	\N
3373	Some squirrels have nests high in trees, and some live in holes in trees.	squirrels	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:09.781991	2025-07-09 13:23:10.209151	有些松鼠把窝搭在高高的树上，有些住在树洞里。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/c9a3a5a486f89aacb9e4c21b6ad180dc.mp3	c9a3a5a486f89aacb9e4c21b6ad180dc	2025-07-10 12:43:49.536677
296	I felt relieved when the exam results were relatively better than expected.	relieved	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.955134	2025-07-09 13:25:27.918416	当考试结果比预期的好一些时，我感到松了一口气。	AI generated	elementary	\N	\N	\N
302	A deeper understanding of orbital mechanics is a necessity for piloting the space shuttle.	understanding	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.39614	2025-07-09 13:25:30.940372	要驾驶航天飞机，必须更深入地了解轨道力学。	AI generated	elementary	\N	\N	\N
3374	Many sea animals die every year, because they eat plastic bags.	sea	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:10.2946	2025-07-09 13:23:10.209155	很多海洋动物每年都会死去，因为它们吃了塑料袋。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/d506f8dcd759d501c28cb847ce8c63b4.mp3	d506f8dcd759d501c28cb847ce8c63b4	2025-07-10 12:43:49.536677
3383	Mr. Li has about one thousand five hundred  clocks in his house.	Mr.	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:13.642064	2025-07-09 13:23:13.212151	李先生家里大约有1500个钟。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/e9bb64c4cfc6c55cb5c862e782257119.mp3	e9bb64c4cfc6c55cb5c862e782257119	2025-07-10 12:44:22.884091
305	The biologist used specialized software to analyze data from the genetic experiment.	experiment	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.39615	2025-07-09 13:25:30.940374	生物学家用特别的软件来分析基因实验的数据。	AI generated	elementary	\N	\N	\N
3353	I want to be an astronaut and fly a spaceship to the moon.	astronaut	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:02.506115	2025-07-10 13:22:29.614386	我想成为一名宇航员，开着宇宙飞船去月球。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/c37e2fca0c1ef4e992237f4c5b48ada5.mp3	c37e2fca0c1ef4e992237f4c5b48ada5	2025-07-10 13:22:29.608624
311	To sustain world peace, a greater understanding between cultures is essential.	sustain	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.396161	2025-07-09 13:25:34.573119	为了维持世界和平，不同文化之间互相理解非常重要。	AI generated	elementary	\N	\N	\N
3372	What do you think of the film last night?	film	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:09.439269	2025-07-10 13:42:31.041197	你觉得昨晚的电影怎么样？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/4f961cde1fc85462f9c2d9acb6557583.mp3	4f961cde1fc85462f9c2d9acb6557583	2025-07-10 13:42:31.037285
313	The sheer gravity of the situation became apparent when the warehouse roof collapsed.	gravity	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.479955	2025-07-09 13:25:34.573121	当仓库的屋顶塌下来的时候，大家才明白情况有多么严重。	AI generated	elementary	\N	\N	\N
315	The floral arrangement was a last-minute attempt to salvage the party.	arrangement	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.483955	2025-07-09 13:25:34.573122	那个花卉摆设是最后一刻才想起来，想要让派对好一点的办法。	AI generated	elementary	\N	\N	\N
355	Each dumpling was a taste of home, a reminder of his mother's cooking in their country.	dumpling	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.144501	2025-07-09 13:25:50.449577	每个饺子都是家乡的味道，让他想起妈妈在家乡做的饭。	AI generated	intermediate	\N	\N	\N
325	The trainer emphasized finding comfort during intense workout sessions to prevent injury.	trainer	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.861377	2025-07-09 13:25:37.653716	教练强调在剧烈运动时找到舒适感，以防止受伤。	AI generated	elementary	\N	\N	\N
373	There's a growing tendency for students to defer university until they can afford the tuition.	tendency	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.615297	2025-07-09 13:25:58.638438	越来越多的学生想推迟上大学，直到他们能负担得起学费。	AI generated	intermediate	\N	\N	\N
3384	You can find hundreds of wonderful houses and small beautiful gardens there.	hundreds	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:14.010262	2025-07-09 13:23:13.212151	在那里你能找到很多漂亮的房子和美丽的小花园。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/93889af416ece1136e3510fab3090523.mp3	93889af416ece1136e3510fab3090523	2025-07-10 12:44:22.884091
335	The plush armchair offered great comfort; however, it was too expensive.	comfort	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.878482	2025-07-09 13:25:42.082747	那个软软的扶手椅坐着很舒服，但是太贵了。	AI generated	elementary	\N	\N	\N
3386	Walk along the road and turn right at the first crossing.	road	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:14.728839	2025-07-09 13:23:13.212152	沿着这条路走，在第一个路口向右转。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/72da69aa2169ce8a79fe79db84439a76.mp3	72da69aa2169ce8a79fe79db84439a76	2025-07-10 12:44:22.884091
3401	Having a healthy diet and doing more outdoor exercise are good for your health.	diet	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:20.324806	2025-07-09 13:23:20.426916	吃得健康，多做户外运动，对你的身体好。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/08950b388d384ce3680778998eddcee9.mp3	08950b388d384ce3680778998eddcee9	2025-07-10 12:44:55.937214
341	The customer was thrilled to receive a diamond pendant as a loyalty reward.	customer	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.107168	2025-07-09 13:25:45.948154	顾客收到钻石吊坠作为忠诚奖励，非常高兴。	AI generated	elementary	\N	\N	\N
3404	There's something wrong with the lift.	lift	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:21.645771	2025-07-09 13:23:20.426922	电梯出问题了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/21059fadebb04e20e2c79e7ba69a8ccb.mp3	21059fadebb04e20e2c79e7ba69a8ccb	2025-07-10 12:44:55.937214
343	Scientists arrange data from telescopes to understand the vastness of the universe.	arrange	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.107172	2025-07-09 13:25:45.948156	科学家整理来自望远镜的数据，来了解宇宙有多大。	AI generated	elementary	\N	\N	\N
3405	I have short black hair and a round face.	hair	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:21.995337	2025-07-09 13:23:20.426923	我留着黑色的短发，有一张圆圆的脸。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/2f738df08799b2001fbf5c9bdbc21b9a.mp3	2f738df08799b2001fbf5c9bdbc21b9a	2025-07-10 12:44:55.937214
345	The company's representative needed positive publicity after the recent scandal.	representative	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.109815	2025-07-09 13:25:45.948157	公司代表在最近的丑闻后需要正面的宣传。	AI generated	elementary	\N	\N	\N
3406	The moon looks bigger than stars because it is much nearer to the earth.	moon	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:22.365205	2025-07-09 13:23:20.426924	月亮看起来比星星大，因为它离地球更近。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/519f52c2a5f1c5ddf814815b8820b5b6.mp3	519f52c2a5f1c5ddf814815b8820b5b6	2025-07-10 12:44:55.937214
3407	Smiling is the best way to show our kindness.	way	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:22.728088	2025-07-09 13:23:20.426924	微笑是表达我们友善的最好方式。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/9d56f770c5e22ff6453c6808863ddd7e.mp3	9d56f770c5e22ff6453c6808863ddd7e	2025-07-10 12:44:55.937214
353	The smooth surface of the lake reflected the clear blue sky of the country.	surface	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.144498	2025-07-09 13:25:50.449576	平静的湖面映出了乡村晴朗的蓝天。	AI generated	elementary	\N	\N	\N
3410	Now, more and more robot dogs come into use in some dangerous places.	robot	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:23.791629	2025-07-09 13:23:20.426926	现在，越来越多的机器狗被用在一些危险的地方。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/0fbe2b1910e766efe9c97cef95b66a25.mp3	0fbe2b1910e766efe9c97cef95b66a25	2025-07-10 12:44:55.937214
3424	The more you know, the better you can enjoy the place.	place	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:28.955447	2025-07-09 13:23:27.291636	你懂得越多，就越能更好地享受这个地方。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/a5a615e922861b29ece28152bb2fc0a6.mp3	a5a615e922861b29ece28152bb2fc0a6	2025-07-10 12:45:29.976707
3427	The washing machine is quite old, but it works well.	washing	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:30.185628	2025-07-09 13:23:27.291638	这台洗衣机很旧了，但是它还能很好地工作。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/0adade77ca6d6f20e683d435cdf0d039.mp3	0adade77ca6d6f20e683d435cdf0d039	2025-07-10 12:45:29.976707
365	Her collection of luggage grew throughout her lifetime of global travels.	luggage	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.267067	2025-07-09 13:25:54.336495	在她环游世界的旅途中，她的行李越来越多。	AI generated	elementary	\N	\N	\N
379	This sentence perfectly captures the feeling of waking up in paradise.	sentence	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.615319	2025-07-09 13:26:01.763949	这句话完美地表达了在天堂醒来的感觉。	AI generated	elementary	\N	\N	\N
381	I could scarcely realize how much time had passed since our last meeting.	scarcely	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.615324	2025-07-09 13:26:01.76395	我几乎没意识到自从上次见面已经过了这么久。	AI generated	elementary	\N	\N	\N
415	The team needed to adapt quickly to the changing business landscape to meet the CEO's expectation.	quickly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.91762	2025-07-09 13:26:14.043285	为了达到总裁的期望，团队需要快速适应不断变化的商业环境。	AI generated	intermediate	\N	\N	\N
383	Researchers eagerly awaited the latest statistics on global warming trends.	eagerly	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.615329	2025-07-09 13:26:01.763952	研究人员急切地等待着关于全球变暖趋势的最新数据。	AI generated	elementary	\N	\N	\N
423	Let's take a picture of the sunset tonight so we can remember this beautiful day.	picture	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.949886	2025-07-09 13:26:16.91506	我们今晚拍张日落的照片吧，这样我们就能记住这美好的一天。	AI generated	intermediate	\N	\N	\N
385	The peaceful settlement was a direct result of careful thought and planning.	settlement	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.663344	2025-07-09 13:26:01.763953	和平的解决是认真思考和计划的直接结果。	AI generated	elementary	\N	\N	\N
3402	They must look at the traffic lights and wait for the green light and then cross the street.	traffic	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:20.705499	2025-07-09 13:23:20.426921	他们必须看红绿灯，等绿灯亮了才能过马路。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/401988ce16b253ac883e25b1146f5132.mp3	401988ce16b253ac883e25b1146f5132	2025-07-10 12:45:29.976707
393	Gaining permission for the new settlement proved unexpectedly difficult.	settlement	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.6759	2025-07-09 13:26:05.958953	为新的居住地获得许可比想象的要难。	AI generated	elementary	\N	\N	\N
3432	Jenny likes to fly kites, but Steven likes to play volleyball.	Jenny	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:31.892888	2025-07-09 13:23:30.51243	珍妮喜欢放风筝，但是史蒂文喜欢打排球。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/828ecbf9837d11656816a5ac1bd8c761.mp3	828ecbf9837d11656816a5ac1bd8c761	2025-07-10 12:45:29.976707
395	The builder cut the wood precisely, to one quarter of an inch.	precisely	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.675904	2025-07-09 13:26:05.958955	建筑工人非常精确地切割木头，误差只有四分之一英寸。	AI generated	elementary	\N	\N	\N
3409	Blue whales are the biggest animals in the world, about twenty-nine meters long and as tall as a nine storey building.	whales	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:23.433533	2025-07-09 13:23:20.426925	蓝鲸是世界上最大的动物，大约有29米长，像九层楼那么高。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/440930e169ff7ed73f814e97c017acd2.mp3	440930e169ff7ed73f814e97c017acd2	2025-07-10 12:46:09.921848
3411	The Great Wall of China is one of the greatest and most famous projects built by Chinese people.	Great	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:24.308443	2025-07-09 13:23:23.882111	中国的长城是中国人建造的最伟大和最著名的工程之一。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/9234b27ff5f288187945539dbf2ff88f.mp3	9234b27ff5f288187945539dbf2ff88f	2025-07-10 12:46:09.921848
405	The visiting minister spoke well about the cultural variety in the region.	minister	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.841573	2025-07-09 13:26:10.105762	来访的牧师很好地讲述了这个地区丰富的文化。	AI generated	elementary	\N	\N	\N
3455	They like doing kung fu, but they don't like playing basketball.	kung	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:40.455103	2025-07-09 13:23:38.351385	他们喜欢练功夫，但是他们不喜欢打篮球。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/deb95e5ec2049f41a8c720b4da89c197.mp3	deb95e5ec2049f41a8c720b4da89c197	2025-07-10 12:46:50.140924
3458	Some children are doing a dragon dance now.	children	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:41.734555	2025-07-09 13:23:38.351386	一些小朋友现在正在舞龙。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ebdf47652235df6f2735b0dc3f4daed9.mp3	ebdf47652235df6f2735b0dc3f4daed9	2025-07-10 12:46:50.140924
3459	Now I am writing letters to all my teachers and classmates.	letters	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:42.091707	2025-07-09 13:23:38.351387	现在我正在给所有的老师和同学们写信。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ae0c3f0b426f4c569af148c308d3d4ba.mp3	ae0c3f0b426f4c569af148c308d3d4ba	2025-07-10 12:46:50.140924
3460	Apples look cute and they taste good.	Apples	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:42.452368	2025-07-09 13:23:38.351388	苹果看起来很可爱，而且味道很好。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/f6002fe50bb0120b261c5298fda67976.mp3	f6002fe50bb0120b261c5298fda67976	2025-07-10 12:46:50.140924
419	I resolve to avoid negative comparison with others and focus on my own progress.	resolve	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.917626	2025-07-09 13:26:16.915057	我决定不再和别人比，而是专注于自己的进步。	AI generated	elementary	\N	\N	\N
3461	Spring is coming and the flowers are becoming more and more beautiful.	Spring	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:42.804833	2025-07-09 13:23:41.775328	春天来了，花儿变得越来越漂亮。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/70070cf3bfb2049854d29e40fa7f59d0.mp3	70070cf3bfb2049854d29e40fa7f59d0	2025-07-10 12:46:50.140924
421	The local newspaper reported a significant increase in advertising revenue this quarter.	newspaper	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.947937	2025-07-09 13:26:16.915058	当地报纸报道说，这个季度广告收入大大增加了。	AI generated	elementary	\N	\N	\N
425	Her most prized possession was a letter that was a complete surprise to her.	possession	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.949889	2025-07-09 13:26:16.915061	她最珍贵的宝贝是一封让她非常惊喜的信。	AI generated	elementary	\N	\N	\N
435	Somebody needs to study the placebo effect, a remarkable phenomenon in medicine.	somebody	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:25.060582	2025-07-09 13:26:20.320792	有人需要研究安慰剂效应，这是医学上一个很特别的现象。	AI generated	elementary	\N	\N	\N
445	She began writing the email, tapping the keys nervously as she revised the first paragraph.	nervously	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:27.991572	2025-07-09 13:26:23.730226	她开始写邮件，一边紧张地敲着键盘，一边修改第一段。	AI generated	intermediate	\N	\N	\N
455	The teacher gave the student a satisfactory grade with emphasis on improvement in next semester.	satisfactory	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:27.991597	2025-07-09 13:26:27.008724	老师给了学生一个及格的分数，并强调下学期要继续努力。	AI generated	intermediate	\N	\N	\N
453	The peasant unwillingly paid his taxes to the local lord.	peasant	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:27.991593	2025-07-09 13:26:27.008723	这位农民不情愿地向当地的领主交了税。	AI generated	elementary	\N	\N	\N
493	The unexpected standing ovation after my nervous speech brought a wave of pure pleasure, and perhaps even a touch of relief.	pleasure	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.691669	2025-07-09 13:26:40.482737	在我紧张的演讲后，大家 неожиданно 起立鼓掌，这让我感到非常高兴，甚至有点放松。	AI generated	intermediate	\N	\N	\N
495	Her perception of the situation was different than mine, and perhaps she was right to be more cautious.	perception	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.701465	2025-07-09 13:26:40.482738	她对情况的看法和我不一样，也许她更谨慎是对的。	AI generated	intermediate	\N	\N	\N
459	I can certainly confirm that I arrived recently at the meeting.	certainly	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.195952	2025-07-09 13:26:29.864148	我能确定我最近才到会议的。	AI generated	elementary	\N	\N	\N
497	At fourteen, I had to perform the solo in the school play, which terrified me.	perform	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.701469	2025-07-09 13:26:40.482739	我十四岁的时候，要在学校的戏剧里表演独角戏，这让我很害怕。	AI generated	intermediate	\N	\N	\N
461	The observer noted the distinctive style of clothes worn by the performers.	clothes	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.195956	2025-07-09 13:26:29.86415	观察者注意到了表演者们穿着的特别的衣服。	AI generated	elementary	\N	\N	\N
3462	Are the children swimming in the river?	children	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:43.177623	2025-07-09 13:23:41.775331	孩子们在河里游泳吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/cb6b2e466da81018454952d1b1abe234.mp3	cb6b2e466da81018454952d1b1abe234	2025-07-10 12:46:50.140924
463	I chose a landscape portrait instead of the still life for my art project.	portrait	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.202264	2025-07-09 13:26:29.864152	我的美术作业，我选了风景画，没选静物画。	AI generated	elementary	\N	\N	\N
3421	When a car is going very fast, it will take a long time to stop.	car	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:27.885519	2025-07-09 13:23:27.29163	当汽车开得很快的时候，它需要很长时间才能停下来。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/4ec9cf611fb2cb450a074728c147e076.mp3	4ec9cf611fb2cb450a074728c147e076	2025-07-10 12:47:28.512482
465	We made it through, because we had a reliable team in charge.	reliable	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.202268	2025-07-09 13:26:29.864153	我们成功了，因为我们有一个可靠的团队负责。	AI generated	elementary	\N	\N	\N
3422	He gave up his acting career and trained even harder to be a professional snowboarder.	career	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:28.223193	2025-07-09 13:23:27.291634	他放弃了演戏，更加努力地训练，想成为一名专业的滑雪运动员。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/652010da753808faa06603e790b92c6d.mp3	652010da753808faa06603e790b92c6d	2025-07-10 12:47:28.512482
475	We can't guarantee a positive response, despite our best efforts.	guarantee	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.22959	2025-07-09 13:26:33.085511	即使我们尽了最大努力，也不能保证会有好的结果。	AI generated	elementary	\N	\N	\N
3425	Jack can sweep the floor and water the flowers, but he can't cook the meal.	Jack	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:29.301438	2025-07-09 13:23:27.291637	杰克可以扫地和浇花，但他不会做饭。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b3162ae17e152ed23d84b57e7bb26bb9.mp3	b3162ae17e152ed23d84b57e7bb26bb9	2025-07-10 12:47:28.512482
485	The international agricultural conference focused on improving the annual harvest yields.	conference	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.321473	2025-07-09 13:26:37.14344	国际农业会议主要讨论如何提高每年的粮食产量。	AI generated	elementary	\N	\N	\N
3482	Have you ever been to Beijing?	Beijing	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:50.804807	2025-07-12 04:43:14.417213	你去过北京吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/e5a95ae969b515e61d1bde1f081cc395.mp3	e5a95ae969b515e61d1bde1f081cc395	2025-07-12 04:43:14.415633
487	Despite strong opposition, he had nothing to retract from his earlier statement.	opposition	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.321477	2025-07-09 13:26:37.143441	尽管有强烈的反对，他还是坚持之前的说法，什么也不收回。	AI generated	elementary	\N	\N	\N
561	For fifteen years, she excelled in science, eventually securing a pension due to her groundbreaking research.	fifteen	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.576286	2025-07-09 13:27:01.733136	她努力研究科学十五年，最后因为厉害的研究成果拿到了退休金。	AI generated	intermediate	\N	\N	\N
503	Even though the fourteen-year-old prank seemed harmless, it caused a lot of trouble.	harmless	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.701479	2025-07-09 13:26:44.141144	即使那个十四岁小孩的恶作剧看起来无害，它也引起了很多麻烦。	AI generated	elementary	\N	\N	\N
3483	We haven't seen each other for a long time.	time	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:51.206668	2025-07-09 13:23:49.406569	我们已经很久没见面了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/54da75f6fd1f12a2f73e7027be6bf462.mp3	54da75f6fd1f12a2f73e7027be6bf462	2025-07-10 12:48:03.378598
511	He probably spent a hundred hours trying to translate the ancient text.	probably	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:29.095217	2025-07-09 13:26:44.141146	他可能花了一百个小时来翻译那篇古老的文章。	AI generated	elementary	\N	\N	\N
3485	The last day of Chinese New Year is called the lantern festival.	Chinese	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:51.909459	2025-07-09 13:23:49.40657	中国新年的最后一天叫做元宵节。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/983e8ce15e3c81f30f96a03310cf36ed.mp3	983e8ce15e3c81f30f96a03310cf36ed	2025-07-10 12:48:03.378598
3487	The environment will be improved greatly through our work in the near future.	environment	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:52.834632	2025-07-09 13:23:49.406571	通过我们近期的努力，环境将会得到很大的改善。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/71b503a2f441ae905d6d91d1d8523965.mp3	71b503a2f441ae905d6d91d1d8523965	2025-07-10 12:48:03.378598
3488	Each child should be praised after he has made progress.	child	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:53.181844	2025-07-09 13:23:49.406572	每个孩子取得进步后都应该被表扬。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/66208761eb32fe6447d9ba541b4de69a.mp3	66208761eb32fe6447d9ba541b4de69a	2025-07-10 12:48:03.378598
522	The candidate's political stance on healthcare insurance proved unpopular.	political	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:31.589747	2025-07-09 13:26:47.317407	那个候选人在医疗保险上的政治观点不太受欢迎。	AI generated	elementary	\N	\N	\N
530	Working diligently through the removal process helped ease the transition.	working	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:31.589765	2025-07-09 13:26:51.029913	努力完成移除过程有助于缓解过渡。	AI generated	elementary	\N	\N	\N
3489	He fell down several times, but luckily he didn't hurt himself.	times	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:53.530405	2025-07-09 13:23:49.406573	他摔倒了好几次，但幸运的是他没有受伤。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/4ea7ed711685dbbff681d922901e3bcd.mp3	4ea7ed711685dbbff681d922901e3bcd	2025-07-10 12:48:03.378598
532	That song evokes a personal emotion of bittersweet nostalgia.	personal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:31.589769	2025-07-09 13:26:51.029915	那首歌唤起了一种苦乐参半的怀旧个人情感。	AI generated	elementary	\N	\N	\N
3490	Jimmy is a student, and he likes stars.	Jimmy	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:53.893847	2025-07-09 13:23:49.406573	吉米是个学生，他喜欢星星。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/7d88225350eedc689bcceaeebf04e20f.mp3	7d88225350eedc689bcceaeebf04e20f	2025-07-10 12:48:03.378598
536	The train operation was delayed at the junction due to signaling problems.	junction	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.178821	2025-07-09 13:26:54.103463	因为信号问题，火车在岔路口晚点了。	AI generated	elementary	\N	\N	\N
3497	Can you tell me more about the Great Wall?	Great	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:56.491793	2025-07-09 13:23:53.021644	你能告诉我更多关于长城的事情吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/13959a31dbbae4f763d7b3fe6fba1814.mp3	13959a31dbbae4f763d7b3fe6fba1814	2025-07-10 12:48:37.071559
538	The witness, clearly depressed, reluctantly testified about the accident.	witness	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.185653	2025-07-09 13:26:54.103465	那个证人看起来很难过，不太情愿地说了关于事故的事情。	AI generated	elementary	\N	\N	\N
3440	If someone is talking too loudly, the manager of the restaurant may come and ask him or her to be quiet.	manager	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:34.843322	2025-07-09 13:23:30.512434	如果有人说话太大声，餐厅的经理可能会过来请他或她安静一点。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/af026092646108701095b5314385feda.mp3	af026092646108701095b5314385feda	2025-07-10 12:49:13.233355
540	This section of the report examines the impact of automation on the automotive industry.	section	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.190259	2025-07-09 13:26:54.103466	报告的这部分讲的是自动化对汽车行业的影响。	AI generated	elementary	\N	\N	\N
3484	I was shorter than you last year, but now I am taller than you.	year	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:51.55656	2025-07-10 13:10:07.84976	去年我比你矮，但是现在我比你高了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/87cda1b3b6fa55b1dac36d7db90e15b9.mp3	87cda1b3b6fa55b1dac36d7db90e15b9	2025-07-10 13:10:07.843391
542	The strong connection between the tech industry and education is now clear.	connection	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.190263	2025-07-09 13:26:54.103467	科技行业和教育之间的紧密联系现在很明显了。	AI generated	elementary	\N	\N	\N
548	A positive outcome is probable with prompt and effective treatment.	treatment	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.546734	2025-07-09 13:26:57.779863	如果及时有效地治疗，很有可能得到好的结果。	AI generated	elementary	\N	\N	\N
550	The magazine editor found the story attractive enough to publish it quickly.	attractive	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.546737	2025-07-09 13:26:57.779864	杂志编辑觉得这个故事很吸引人，所以很快就发表了。	AI generated	elementary	\N	\N	\N
552	The first-class lounge at the airport offers a superior level of comfort.	airport	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.54674	2025-07-09 13:26:57.779865	机场的头等舱休息室提供更舒适的环境。	AI generated	elementary	\N	\N	\N
3441	When there is a red light, the cars must stop and wait until the red light changes into green.	light	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:35.374388	2025-07-09 13:23:34.152566	当红灯亮的时候，汽车必须停下来，等到红灯变成绿灯。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/65609d88b105c06c4a1fa0bd6ac20bad.mp3	65609d88b105c06c4a1fa0bd6ac20bad	2025-07-10 12:49:13.233355
3452	The library is in front of my house, and I often read books there after school.	library	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:39.398785	2025-07-09 13:23:38.351382	图书馆在我家前面，我经常放学后去那里看书。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/8d70b166862f1f88de4c517dbab7dfd4.mp3	8d70b166862f1f88de4c517dbab7dfd4	2025-07-10 12:49:13.233355
3456	Sonia isn't interested in getting a job in medicine. She wants to be a professional tennis player.	Sonia	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:40.814299	2025-07-09 13:23:38.351385	索尼娅对从事医学工作不感兴趣。她想成为一名专业的网球运动员。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/e888f0b579382892b9e9acc5bedf4222.mp3	e888f0b579382892b9e9acc5bedf4222	2025-07-10 12:49:13.233355
3457	He is playing his favourite song and everyone is listening and clapping, but the bell rings.	song	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:41.387158	2025-07-09 13:23:38.351386	他正在播放他最喜欢的歌，每个人都在听和鼓掌，但是铃响了。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/780436ae8357d3aee4e78b124b20cc98.mp3	780436ae8357d3aee4e78b124b20cc98	2025-07-10 12:49:13.233355
3467	We are going to have a sports day tomorrow and I'm going to do the high jump.	sports	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:45.161015	2025-07-09 13:23:41.775333	明天我们要开运动会，我要参加跳高。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/58e1d6a06c588d0facdaf5b39c3b26a7.mp3	58e1d6a06c588d0facdaf5b39c3b26a7	2025-07-10 12:49:13.233355
3511	You've got a cold, so take some medicine and have a lot of rest.	cold	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:01.682576	2025-07-09 13:23:59.546928	你感冒了，所以要吃药，好好休息。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/50737254500613e8ac8670e0d7ba1156.mp3	50737254500613e8ac8670e0d7ba1156	2025-07-10 12:49:13.233355
3512	Let's go to the exhibition this afternoon, shall we?	exhibition	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:02.025422	2025-07-09 13:23:59.546934	我们今天下午去看展览，好吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/f0cbffc6b356b59ffd204223b72704fc.mp3	f0cbffc6b356b59ffd204223b72704fc	2025-07-10 12:49:13.233355
3513	What a tidy and clean study it is.	study	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:02.359483	2025-07-09 13:23:59.546935	多么整洁干净的书房啊！	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/4ff2151ea42a07da38819109219c040a.mp3	4ff2151ea42a07da38819109219c040a	2025-07-10 12:49:13.233355
3523	They think that these things are not important, but I don't agree with them.	things	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:06.011364	2025-07-09 13:24:02.977181	他们认为这些事情不重要，但我不同意他们的看法。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/072261a120df35a1d288bec45c579a35.mp3	072261a120df35a1d288bec45c579a35	2025-07-10 12:49:54.1596
3524	Do you know how much a hamburger is in the shopping mall?	hamburger	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:06.532146	2025-07-09 13:24:02.977181	你知道购物中心里一个汉堡多少钱吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/9dfe9ed8ce36feefd13f8e144d705bb1.mp3	9dfe9ed8ce36feefd13f8e144d705bb1	2025-07-10 12:49:54.1596
3530	Here are some tips to help you keep your teeth healthy.	tips	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:08.595289	2025-07-09 13:24:02.977185	这里有一些小建议，可以帮助你保持牙齿健康。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/332575af96b46d41d1911c5668bb1748.mp3	332575af96b46d41d1911c5668bb1748	2025-07-10 12:50:23.375811
3531	Why not use paper bags instead of plastic bags?	paper	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:09.108122	2025-07-09 13:24:06.097149	为什么不用纸袋代替塑料袋呢？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/927b9ff5e447a608763a451c0a91513f.mp3	927b9ff5e447a608763a451c0a91513f	2025-07-10 12:50:23.375811
3535	Thank you for your letter and some wonderful stamps.	letter	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:10.465721	2025-07-09 13:24:06.097152	谢谢你的来信和一些很棒的邮票。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/12dacb51108a16625ca3586cc3bb0ce3.mp3	12dacb51108a16625ca3586cc3bb0ce3	2025-07-10 12:50:23.375811
3538	It is very important for people to make everything new and fresh before the spring festival.	people	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:11.51125	2025-07-09 13:24:06.097154	在春节前，人们把所有东西都弄得焕然一新非常重要。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/081d36195cd761993f6775886cc279ce.mp3	081d36195cd761993f6775886cc279ce	2025-07-10 12:50:55.510325
2	I have a red apple for lunch.	a	SVO	0.9	0.9	0.9	0	0	t	\N	APPROVED	\N	\N	0	\N	2025-07-06 08:13:50.992019	2025-07-09 13:22:07.897852	我午饭吃一个红色的苹果。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/348e8f087772ccf5aa62a8248af3dcff.mp3	348e8f087772ccf5aa62a8248af3dcff	2025-07-10 12:50:55.510325
3536	How can I get there?	get	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:10.797973	2025-07-11 13:17:03.86269	我怎么去那里？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/c7dedc10ccc52cb7233e4e4eff75ab07.mp3	c7dedc10ccc52cb7233e4e4eff75ab07	2025-07-11 13:17:03.859697
3532	What's wrong with you?	wrong	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:09.459395	2025-07-12 04:35:31.819217	你怎么了？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ed12a06dfd459e9ef681aa3c198e79bf.mp3	ed12a06dfd459e9ef681aa3c198e79bf	2025-07-12 04:35:31.813326
3533	What's the weather like today?	weather	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:09.790478	2025-07-12 04:45:34.819881	今天天气怎么样？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/9bb79b24ccba6a545ba7b607aa3a456c.mp3	9bb79b24ccba6a545ba7b607aa3a456c	2025-07-12 04:45:34.787907
3	My mother likes blue flowers.	likes	SVO	0.9	0.9	0.9	0	0	t	\N	APPROVED	\N	\N	0	\N	2025-07-06 08:13:50.992021	2025-07-09 13:22:07.897853	我的妈妈喜欢蓝色的花。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ab9b05ea5dc5e305b068f61823e6fc3e.mp3	ab9b05ea5dc5e305b068f61823e6fc3e	2025-07-10 12:50:55.510325
4	The elephant is very big and gray.	is	SVO	0.9	0.9	0.9	0	0	t	\N	APPROVED	\N	\N	0	\N	2025-07-06 08:13:50.992022	2025-07-09 13:22:07.897854	大象非常大，而且是灰色的。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/ddc7ee6ca442fe3c331c035414a2e075.mp3	ddc7ee6ca442fe3c331c035414a2e075	2025-07-10 12:50:55.510325
934	Planning is a big part of building a good future.	future	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.077971	2025-07-09 13:24:08.980966	计划是建设美好未来的重要部分。	AI generated	elementary	\N	\N	\N
5	My grandmother makes delicious sandwiches.	makes	SVO	0.9	0.9	0.9	0	0	t	\N	APPROVED	\N	\N	0	\N	2025-07-06 08:13:50.992024	2025-07-09 13:22:07.897856	我的奶奶做的三明治很好吃。	AI generated	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/1fe6bd992a3cd6760cb7b86175fcb541.mp3	1fe6bd992a3cd6760cb7b86175fcb541	2025-07-10 12:50:55.510325
570	The process of recovery after surgery can be complex and comfortable.	process	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.581867	2025-07-09 13:27:04.764589	手术后的恢复过程可能既复杂又舒适。	AI generated	elementary	\N	\N	\N
3363	It rained heavily all day, so I had to stay inside.	day	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:06.172847	2025-07-09 13:23:06.813106	今天下了一整天的大雨，所以我不得不待在家里。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/8a43a90f125f5d773dd470cf61f11514.mp3	8a43a90f125f5d773dd470cf61f11514	2025-07-10 12:51:32.563377
3366	Her house is near mine, so we usually go to school together.	house	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:07.21904	2025-07-09 13:23:06.813107	她的家离我家很近，所以我们经常一起去上学。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/240210e10469aee5e868126b916782d4.mp3	240210e10469aee5e868126b916782d4	2025-07-10 12:51:32.563377
573	The opening act received a roaring round of appreciation from the crowd.	opening	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.581871	2025-07-09 13:27:08.333445	开场表演赢得了观众热烈的掌声。	AI generated	elementary	\N	\N	\N
3367	He teaches me to believe in myself and face difficulties bravely.	difficulties	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:07.74911	2025-07-09 13:23:06.813108	他教我相信自己，勇敢地面对困难。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/13469f3d5be8488a1eb737d8a338d938.mp3	13469f3d5be8488a1eb737d8a338d938	2025-07-10 12:51:32.563377
575	The design team's meeting focused on the interior of the new office space.	interior	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.601005	2025-07-09 13:27:08.333449	设计团队的会议主要讨论了新办公室的内部装修。	AI generated	elementary	\N	\N	\N
3369	This is a map of my city and the library is in the middle.	map	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:08.422068	2025-07-09 13:23:06.813109	这是一张我城市的地图，图书馆在中间。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/363d685b75428af70dba8027a535fedd.mp3	363d685b75428af70dba8027a535fedd	2025-07-10 12:51:32.563377
577	After a long deliberation session, the jury delivered its verdict.	session	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.603083	2025-07-09 13:27:08.33345	经过长时间的讨论，陪审团宣布了他们的判决。	AI generated	elementary	\N	\N	\N
3398	They get to the cinema by metro, but the film is over.	metro	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:19.273274	2025-07-09 13:23:17.063684	他们坐地铁去电影院，但是电影已经结束了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/e12176b4b3376ba3872a01f72d271a24.mp3	e12176b4b3376ba3872a01f72d271a24	2025-07-10 12:52:10.992925
579	The passenger had to pay extra postage for the oversized package.	passenger	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.603086	2025-07-09 13:27:08.333451	乘客不得不为超大的包裹支付额外的邮费。	AI generated	elementary	\N	\N	\N
3415	He usually gets up early in the morning and never goes to bed late.	morning	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:25.651174	2025-07-09 13:23:23.882119	他通常早上起得很早，而且从不睡得很晚。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/3f8a660b248f2b9761237563d0facc9c.mp3	3f8a660b248f2b9761237563d0facc9c	2025-07-10 12:52:10.992925
581	During the design session, they debated the interior color schemes at length.	session	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.610903	2025-07-09 13:27:08.333452	在设计会议中，他们详细讨论了内部的颜色搭配方案。	AI generated	elementary	\N	\N	\N
3416	She likes using computers, and she can type very quickly.	computers	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:25.992917	2025-07-09 13:23:23.88212	她喜欢用电脑，而且她打字非常快。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/68745b573727502752981a28ed1a27b0.mp3	68745b573727502752981a28ed1a27b0	2025-07-10 12:52:10.992925
589	Let's pretend this lumpy pancake is a delicious work of art.	pancake	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:34.159109	2025-07-09 13:27:11.937851	我们假装这个疙瘩不平的煎饼是一件美味的艺术品吧。	AI generated	elementary	\N	\N	\N
3417	Where did you go over the winter holiday?	winter	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:26.335313	2025-07-09 13:23:23.88212	寒假你去哪里了？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/d85bf40e5317781d6bff28fdb65d2482.mp3	d85bf40e5317781d6bff28fdb65d2482	2025-07-10 12:52:10.992925
591	The comedian's entertainment was straight to the point, and hilarious.	straight	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:34.159113	2025-07-09 13:27:11.937852	这位喜剧演员的表演很直接，而且非常搞笑。	AI generated	elementary	\N	\N	\N
601	Heavy velvet curtains hung from the ceiling, darkening the room.	curtain	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.183657	2025-07-09 13:27:15.225625	厚厚的丝绒窗帘从天花板上垂下来，让房间变暗了。	AI generated	elementary	\N	\N	\N
611	The seventh building downtown is the tallest, with a great view.	seventh	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.941733	2025-07-09 13:27:18.13795	市中心第七栋楼是最高的，风景很棒。	AI generated	elementary	\N	\N	\N
615	Her cheerful attitude provided valuable information to the team.	cheerful	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.951922	2025-07-09 13:27:21.312004	她开心的态度给团队提供了有用的信息。	AI generated	elementary	\N	\N	\N
617	The vertical blinds in the president's office were always drawn.	vertical	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.951926	2025-07-09 13:27:21.312005	总统办公室的竖条百叶窗总是拉着的。	AI generated	elementary	\N	\N	\N
661	He carved a rectangle out of wood to serve as a feeder for the chicken coop.	rectangle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:38.966233	2025-07-09 13:27:34.666557	他用木头雕刻了一个长方形，用来做鸡窝的喂食器。	AI generated	intermediate	\N	\N	\N
619	His nomination followed the traditional party lines despite his views.	nomination	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.957603	2025-07-09 13:27:21.312006	尽管他有自己的看法，他的提名还是遵循了党的传统路线。	AI generated	elementary	\N	\N	\N
3418	Everyone must watch the lights carefully and follow the traffic rules.	lights	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:26.676684	2025-07-09 13:23:23.882121	每个人都必须仔细看红绿灯，遵守交通规则。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/f04c46953d9638ade1cbec68f93ea56a.mp3	f04c46953d9638ade1cbec68f93ea56a	2025-07-10 12:52:10.992925
621	The musician played a traditional folk song with skill.	musician	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.957607	2025-07-09 13:27:21.312007	那位音乐家用精湛的技巧演奏了一首传统的民歌。	AI generated	elementary	\N	\N	\N
3448	Many foreign friends are looking forward to going sightseeing in Beijing.	Beijing	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:37.800127	2025-07-09 13:23:34.152574	很多外国朋友都盼望着去北京旅游。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/041a9b827e64f1522aa8325c7d6eb71b.mp3	041a9b827e64f1522aa8325c7d6eb71b	2025-07-10 12:52:55.718167
629	After a careful inspection, the pilot announced the departure was delayed.	careful	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.002854	2025-07-09 13:27:24.196906	经过仔细检查后，飞行员宣布起飞延误了。	AI generated	elementary	\N	\N	\N
3449	They decided to make a paper spaceship together.	paper	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:38.327795	2025-07-09 13:23:34.152574	他们决定一起做一个纸飞船。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/6d4a93a38b8e457ce844c30547c7f998.mp3	6d4a93a38b8e457ce844c30547c7f998	2025-07-10 12:52:55.718167
631	The company's failure to register the patent led to significant financial losses.	register	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.005203	2025-07-09 13:27:24.196907	公司没有注册专利，导致了很大的经济损失。	AI generated	elementary	\N	\N	\N
3450	The shopping centre is far away, so we go there on weekends.	shopping	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:38.689099	2025-07-09 13:23:34.152575	购物中心很远，所以我们周末才去那里。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/7052c3cf42286a93efbc60d1d149e620.mp3	7052c3cf42286a93efbc60d1d149e620	2025-07-10 12:52:55.718167
3480	Sally has already put her name tag on the suitcase.	Sally	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:50.101917	2025-07-09 13:23:45.027214	莎莉已经把她的姓名标签贴在行李箱上了。	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/a095cdb35c6da1c2fc97c1e0fbd26081.mp3	a095cdb35c6da1c2fc97c1e0fbd26081	2025-07-10 12:53:41.955169
641	The simplicity of the composition impressed the photographer greatly.	simplicity	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.033001	2025-07-09 13:27:27.117531	作品的简单让摄影师印象深刻。	AI generated	elementary	\N	\N	\N
3499	What do you want to be in the future?	future	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:57.178451	2025-07-09 13:23:53.021645	你将来想做什么？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/7fda59fc25699a9076d304080634cd56.mp3	7fda59fc25699a9076d304080634cd56	2025-07-10 12:53:41.955169
651	Her tireless dedication defines the servant's admirable personality.	servant	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.059912	2025-07-09 13:27:31.008294	她不知疲倦的付出，展现了仆人令人敬佩的品格。	AI generated	elementary	\N	\N	\N
3503	What can you do to help others in your life?	others	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:58.745162	2025-07-09 13:23:56.732973	在你的生活中，你能做些什么来帮助别人？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/1c9bde22c8d950b4d8649f90051d21bb.mp3	1c9bde22c8d950b4d8649f90051d21bb	2025-07-10 12:53:41.955169
655	I discussed the matter privately with several board members yesterday.	several	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.059918	2025-07-09 13:27:34.666553	昨天我私下和几个委员会成员讨论了这件事。	AI generated	elementary	\N	\N	\N
3399	Reading can make people get more knowledge and learn about the world without going out.	Reading	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:19.621008	2025-07-09 13:23:17.063684	读书可以让人获得更多知识，不用出门就能了解世界。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/3334b08e41f2d4900f10404d6b842155.mp3	3334b08e41f2d4900f10404d6b842155	2025-07-10 12:54:21.827374
657	The school fair is a fun activity with a lollipop booth.	lollipop	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.06466	2025-07-09 13:27:34.666554	学校的游园会是一个有趣的事情，里面还有卖棒棒糖的小摊。	AI generated	elementary	\N	\N	\N
3500	Whose birthday is in July?	July	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:57.531148	2025-07-12 04:36:54.550937	谁的生日在七月？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/de19efa6f591781095583f941ed05d7e.mp3	de19efa6f591781095583f941ed05d7e	2025-07-12 04:36:54.547944
659	The political violence marred the town's street decoration efforts and left residents fearful.	violence	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:38.959332	2025-07-09 13:27:34.666556	政治暴力破坏了小镇装饰街道的努力，让居民们感到害怕。	AI generated	elementary	\N	\N	\N
669	The company promised to deliver the software update instantly upon its release.	deliver	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:38.973581	2025-07-09 13:27:37.453575	公司承诺软件更新一发布就立即发送。	AI generated	elementary	\N	\N	\N
671	The sudden lightning storm made the special effects in the play even more dramatic.	lightning	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:40.227736	2025-07-09 13:27:37.453577	突然的雷雨让戏剧里的特效更加精彩了。	AI generated	elementary	\N	\N	\N
681	Her goodness shone brightly, making her a very special person to everyone she met.	goodness	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:40.237071	2025-07-09 13:27:40.986547	她很善良，所以每个人都觉得她很特别。	AI generated	elementary	\N	\N	\N
1031	The <b>clever</b> girl said "<b>ok</b>" to the easy problem.	clever	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.009408	2025-07-09 13:24:08.980967	那个<b>聪明</b>的女孩对简单的题目说“<b>好</b>”。	AI generated	elementary	\N	\N	\N
3430	You must not play football on the road, because there are many cars and bikes.	football	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:31.204336	2025-07-09 13:23:27.29164	你不能在马路上踢足球，因为那里有很多汽车和自行车。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/b62720ae779988dc03a40ba0b0bc8449.mp3	b62720ae779988dc03a40ba0b0bc8449	2025-07-10 12:55:09.4915
1033	The price <b>tag</b> fell into the spilled <b>liquid</b>.	tag	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.009417	2025-07-09 13:24:08.980968	那个价格<b>标签</b>掉进了洒出来的<b>液体</b>里。	AI generated	elementary	\N	\N	\N
3443	We should not cut down too many trees, because trees help keep the air clean.	trees	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:36.065735	2025-07-09 13:23:34.152571	我们不应该砍太多树，因为树能帮助保持空气干净。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/15199f683e234c102d120b0d8f59ebf0.mp3	15199f683e234c102d120b0d8f59ebf0	2025-07-10 12:55:09.4915
1035	The <b>coach</b> spilled his <b>liquid</b> sports drink on the bench.	coach	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.009422	2025-07-09 13:24:08.980969	<b>教练</b>把他的<b>液体</b>运动饮料洒在了长凳上。	AI generated	elementary	\N	\N	\N
3447	To save the animals in danger, we shouldn't buy the clothes made from these animals.	animals	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:37.442049	2025-07-09 13:23:34.152573	为了拯救有危险的动物，我们不应该买用这些动物做的衣服。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/78bbd1f11a1375e7a2d46a23ecf83d9b.mp3	78bbd1f11a1375e7a2d46a23ecf83d9b	2025-07-10 12:55:09.4915
1037	There is a <b>risk</b> of getting a <b>false</b> answer.	risk	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.009426	2025-07-09 13:24:12.651452	有得到错误答案的可能。	AI generated	elementary	\N	\N	\N
3473	After lunch she slept for an hour and then did her homework for two hours.	lunch	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:47.465899	2025-07-09 13:23:45.02721	午饭后，她睡了一个小时，然后做了两个小时的作业。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/4a9c22876d07c299ce87987e3838047b.mp3	4a9c22876d07c299ce87987e3838047b	2025-07-10 12:55:09.4915
1039	Using the wrong <b>method</b> can <b>ruin</b> your drawing.	method	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.00943	2025-07-09 13:24:12.651453	用错方法会毁了你的画。	AI generated	elementary	\N	\N	\N
3477	With the help of the teachers, they have made fewer mistakes this time than before.	help	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:48.857353	2025-07-09 13:23:45.027212	在老师们的帮助下，他们这次犯的错误比以前少了。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/cd5a8d9d8d1901ddc74e0c45a263e892.mp3	cd5a8d9d8d1901ddc74e0c45a263e892	2025-07-10 12:55:09.4915
1041	That <b>false</b> door is made of <b>wood</b>.	false	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.009434	2025-07-09 13:24:12.651453	那扇假的门是用木头做的。	AI generated	elementary	\N	\N	\N
3478	Joe has waited for the bus for about ten minutes, but it hasn't come yet.	Joe	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:03:49.198446	2025-07-09 13:23:45.027213	乔等公交车大约十分钟了，但是车还没来。	小学教材例句	intermediate	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/5d46589a572334dbad671a6ebc79abf7.mp3	5d46589a572334dbad671a6ebc79abf7	2025-07-10 12:55:09.4915
689	The modification to the machine made it subject to new regulations.	modification	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.060559	2025-07-09 13:27:43.601275	因为机器做了改动，所以它要遵守新的规定了。	AI generated	elementary	\N	\N	\N
691	An apology is a possibility, but I'm not expecting one.	apology	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.060562	2025-07-09 13:27:43.601277	他们可能会道歉，但是我不觉得他们会道歉。	AI generated	elementary	\N	\N	\N
695	Her newfound confidence will strengthen her resolve to succeed.	confidence	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.101157	2025-07-09 13:27:46.360953	她新获得的自信会让她更有决心去成功。	AI generated	elementary	\N	\N	\N
697	A sparkle in her eye suggested the elderly woman held a secret.	sparkle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.114387	2025-07-09 13:27:46.360954	她眼睛里的光芒表明这位老奶奶藏着一个秘密。	AI generated	elementary	\N	\N	\N
699	The investigation uncovered a fraudulent scholarship scheme.	investigation	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.114391	2025-07-09 13:27:46.360955	调查发现了一个骗人的奖学金计划。	AI generated	elementary	\N	\N	\N
719	Hearing the referee's loud whistle, the frustrated player kicked his slipper across the field in disgust.	whistle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.550554	2025-07-09 13:27:52.675889	听到裁判响亮的哨声，那个生气的球员厌恶地把拖鞋踢过了场地。	AI generated	intermediate	\N	\N	\N
701	Using assistive devices can strengthen an individual's hearing abilities.	hearing	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.120637	2025-07-09 13:27:46.360956	使用辅助设备可以增强一个人的听力。	AI generated	elementary	\N	\N	\N
721	My prediction is that wearing that old slipper onto the stage will bring terrible luck.	prediction	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.550561	2025-07-09 13:27:52.675891	我预言穿着那只旧拖鞋上台会带来坏运气。	AI generated	intermediate	\N	\N	\N
711	Her calming presence and the informative pamphlet eased everyone's anxieties.	presence	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.299148	2025-07-09 13:27:49.229106	她平静的样子和有用的宣传册减轻了大家的焦虑。	AI generated	elementary	\N	\N	\N
731	The professor hoped the guest lecture would stimulate further interest in the subject, but unfortunately, the sound system failed.	stimulate	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:43.307684	2025-07-09 13:27:56.82518	教授希望嘉宾讲座能激发大家对这个科目的兴趣，但不幸的是，音响系统坏了。	AI generated	intermediate	\N	\N	\N
3537	Would you like to have a picnic with us at the weekend?	picnic	SVO	1	1	1	1	1	t	\N	APPROVED	\N	\N	0	\N	2025-07-09 13:04:11.163744	2025-07-10 13:33:49.306273	你周末想和我们一起去野餐吗？	小学教材例句	elementary	/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache/4047f29bbaed77477d5c6b0f2a0935fa.mp3	4047f29bbaed77477d5c6b0f2a0935fa	2025-07-10 13:33:49.298181
729	The newly formed fire district relies on voluntary contributions from the community.	district	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.55433	2025-07-09 13:27:56.825179	新成立的消防区依靠社区的自愿捐款。	AI generated	elementary	\N	\N	\N
1358	That <u>hippo</u> is <u>really</u> big, and it sleeps all day in the water!	really	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.57504	2025-07-09 13:24:12.651454	那只河马真大，它整天都在水里睡觉！	AI generated	elementary	\N	\N	\N
1360	The <u>golden</u> sun made a huge <u>splash</u> on the lake this morning.	golden	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.58039	2025-07-09 13:24:12.651455	今天早上，金色的太阳在湖面上洒下了巨大的光芒。	AI generated	elementary	\N	\N	\N
1362	I got <u>zero</u> candy, so my mom will <u>treat</u> me to ice cream.	zero	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.585007	2025-07-09 13:24:16.951754	我没有得到<u>任何</u>糖果，所以妈妈会<u>请</u>我吃冰淇淋。	AI generated	elementary	\N	\N	\N
1364	The ice cream was <u>really</u> <u>solid</u> and hard to scoop.	solid	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.58501	2025-07-09 13:24:16.951756	冰淇淋<u>非常</u><u>硬</u>，很难挖。	AI generated	elementary	\N	\N	\N
1366	The <u>host</u> showed us the huge <u>hippo</u> at the zoo.	host	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.585013	2025-07-09 13:24:16.951757	<u>主持人</u>带我们看了动物园里巨大的<u>河马</u>。	AI generated	elementary	\N	\N	\N
1368	The teacher is the <u>host</u> in the classroom, and her <u>rule</u> is kindness.	host	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.585016	2025-07-09 13:24:16.951759	老师是教室里的<u>主持人</u>，她的<u>规则</u>是友善。	AI generated	elementary	\N	\N	\N
1399	The hospital staff needed a new pair of hands.	pair	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:19.391354	2025-07-09 13:24:16.95176	医院的工作人员需要新的帮手。	AI generated	elementary	\N	\N	\N
1527	On the fifth try, I had to shout to be heard.	fifth	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.898661	2025-07-09 13:24:21.607225	第五次尝试的时候，我不得不大声喊叫才能被听到。	AI generated	elementary	\N	\N	\N
1698	I know we need to widen the path.	widen	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:36.983293	2025-07-09 13:24:21.60723	我知道我们需要把路弄宽一点。	AI generated	elementary	\N	\N	\N
1912	The motorcycle roared past, startling a large percentage of the local population.	motorcycle	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.14008	2025-07-09 13:24:21.607231	摩托车轰隆隆地开过去，吓了一大群当地人。	AI generated	elementary	\N	\N	\N
1914	The record producer visited the radio station to promote the band's new single.	producer	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.144132	2025-07-09 13:24:21.607232	唱片制作人去电台宣传乐队的新歌。	AI generated	elementary	\N	\N	\N
1916	The sun seemed to transform the dark clouds near the horizon into gold.	horizon	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.144135	2025-07-09 13:24:21.607233	太阳好像把地平线附近的乌云变成了金色。	AI generated	elementary	\N	\N	\N
1918	Only the strong will survive without adequate welfare support during the crisis.	survive	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.150124	2025-07-09 13:24:21.607235	在危机期间，如果没有足够的福利帮助，只有坚强的人才能活下来。	AI generated	elementary	\N	\N	\N
1920	Consistent practice is essential for maximizing the benefits of any welfare program.	practice	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.150127	2025-07-09 13:24:25.146459	坚持练习对于让福利项目发挥最大作用很重要。	AI generated	elementary	\N	\N	\N
1922	The newly unveiled World War II monument proved to be deeply sensitive to many.	monument	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.15013	2025-07-09 13:24:25.146463	新建的二战纪念碑让很多人觉得很难过。	AI generated	elementary	\N	\N	\N
1936	A <u>national</u> park's <u>definition</u> often includes the preservation of native species.	national	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.640284	2025-07-09 13:24:25.146464	国家公园的定义通常包括保护当地的动植物。	AI generated	elementary	\N	\N	\N
1938	The <u>unemployed</u> man sadly ate a stale <u>doughnut</u>, a small comfort.	doughnut	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.644239	2025-07-09 13:24:25.146465	失业的男人难过地吃了一个不新鲜的甜甜圈，这让他稍微舒服了一点。	AI generated	elementary	\N	\N	\N
1940	He felt <u>nervous</u> adjusting his <u>underwear</u> before the big presentation.	nervous	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.649342	2025-07-09 13:24:25.146466	在重要的演讲前，他紧张地整理了一下内衣。	AI generated	elementary	\N	\N	\N
1942	We watched the squirrels <u>scramble</u> to bury nuts in a <u>spontaneous</u> frenzy.	scramble	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.654655	2025-07-09 13:24:29.243189	我们看到松鼠们赶紧地（scramble）在一个突然的（spontaneous）疯狂状态下埋坚果。	AI generated	elementary	\N	\N	\N
1944	<u>Happily</u>, the <u>national</u> holiday allowed everyone a day of rest.	national	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.654659	2025-07-09 13:24:29.243194	高兴地（Happily），这个全国（national）假日让每个人都休息了一天。	AI generated	elementary	\N	\N	\N
1946	We reached a quiet <u>agreement</u> after their soft <u>whisper</u> of concession.	whisper	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.654663	2025-07-09 13:24:29.24321	在他们轻轻地（whisper）让步后，我们达成了一个安静的（agreement）协议。	AI generated	elementary	\N	\N	\N
2082	I need to get home, the road is long.	get	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.265383	2025-07-09 13:24:29.243212	我需要回家了，路很长。	AI generated	elementary	\N	\N	\N
2158	He cut the lawn weekly to keep it nice and green.	lawn	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.584896	2025-07-09 13:24:29.243212	他每周都剪草坪，让它保持漂亮和绿色。	AI generated	elementary	\N	\N	\N
2298	He couldn't believe the luxury of the new car.	he	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.297387	2025-07-09 13:24:29.243214	他简直不敢相信这辆新车的豪华。	AI generated	elementary	\N	\N	\N
10	My dog is very happy today.	dog	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:18:40.022506	2025-07-09 13:24:32.413578	我的狗狗今天非常开心。	AI generated	elementary	\N	\N	\N
1681	The lady loves flowers in the summer.	lady	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.590846	2025-07-09 13:24:32.413586	这位女士喜欢夏天的花。	AI generated	elementary	\N	\N	\N
3098	My throat is sore, so I'll heat some soup on the stove.	stove	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.423332	2025-07-09 13:24:32.413587	我的嗓子疼，所以我要在炉子上热一些汤。	AI generated	elementary	\N	\N	\N
2102	I will set the vase beside the books.	set	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.461443	2025-07-09 13:24:32.413586	我会把花瓶放在书的旁边。	AI generated	elementary	\N	\N	\N
3218	As a new resident, her allergic reaction was reported immediately to the apartment management.	resident	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.025357	2025-07-09 13:24:32.413588	作为一个新住户，她的过敏反应立刻报告给了公寓管理处。	AI generated	elementary	\N	\N	\N
3224	The team made considerable progress after attending an insightful data analysis seminar.	progress	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.217602	2025-07-09 13:24:32.413589	团队在参加了一个有用的数据分析讲座后，取得了很大的进步。	AI generated	elementary	\N	\N	\N
505	The temperature outside made it difficult to grasp the concept of global warming, but I tried to understand..	temperature	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:29.0878	2025-07-09 13:24:32.413583	外面的温度让人很难理解全球变暖的概念，但我努力去理解。	AI generated	intermediate	\N	\N	\N
2160	Try to reach the shelf and make the room tidy..	reach	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.584899	2025-07-09 13:24:35.448547	试着够到架子，把房间弄整齐。	AI generated	elementary	\N	\N	\N
3216	The princess insisted, "I will wear whatever I choose to the ball!".	princess	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.023128	2025-07-09 13:24:35.448549	公主坚持说：“舞会上我想穿什么就穿什么！”	AI generated	elementary	\N	\N	\N
3331	That movie set a new record for ticket sales.	movie	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:37.174738	2025-07-09 13:24:35.44855	那部电影创造了新的票房纪录。	AI generated	elementary	\N	\N	\N
3332	It was a steep climb, but the rope felt secure.	steep	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:37.174739	2025-07-09 13:24:35.44855	攀登很陡峭，但绳子感觉很安全。	AI generated	elementary	\N	\N	\N
3334	Please wrap the gift after we watch the movie.	movie	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:37.174743	2025-07-09 13:24:35.448552	看完电影后，请把礼物包起来。	AI generated	elementary	\N	\N	\N
3336	The two friends agree to share the pizza.	two	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:37.177967	2025-07-09 13:24:38.827556	这两个朋友同意一起吃披萨。	AI generated	elementary	\N	\N	\N
3338	Her skate design is truly unique and beautiful.	skate	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:37.177971	2025-07-09 13:24:38.827558	她的滑冰鞋设计真的很特别，很漂亮。	AI generated	elementary	\N	\N	\N
16	The beautiful butterfly is very colorful.	butterfly	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:19:33.608718	2025-07-09 13:24:38.827547	这只漂亮的蝴蝶颜色非常鲜艳。	AI generated	elementary	\N	\N	\N
18	The fresh apple is bright red.	red	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:20:25.688651	2025-07-09 13:24:38.827553	这个新鲜的苹果是鲜红色的。	AI generated	elementary	\N	\N	\N
21	The clear sky is bright blue today.	blue	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:20:39.280583	2025-07-09 13:24:38.827554	今天晴朗的天空是亮蓝色的。	AI generated	elementary	\N	\N	\N
24	The fresh grass is vibrant green.	green	SVC	0.9	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 01:21:00.069209	2025-07-09 13:24:38.827554	新鲜的草是充满活力的绿色。	AI generated	elementary	\N	\N	\N
158	The specialist advised him to take the injury seriously and rest.	seriously	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.40718	2025-07-09 13:24:41.683025	专家建议他认真对待伤病，好好休息。	AI generated	elementary	\N	\N	\N
167	Citizens often complain about the conduct of an officer.	officer	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.407196	2025-07-09 13:24:45.754917	老百姓常常抱怨警察叔叔的行为。	AI generated	elementary	\N	\N	\N
169	The pianist perfected his complex instrument's sound with a demanding technique.	instrument	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.46579	2025-07-09 13:24:45.754922	钢琴家通过努力练习，让复杂的钢琴声音变得完美。	AI generated	elementary	\N	\N	\N
171	The soldier's bravery became the foundation for the nation's new hope.	foundation	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.472651	2025-07-09 13:24:45.754923	士兵的勇敢成了国家新希望的基石。	AI generated	elementary	\N	\N	\N
173	Using a secret channel, they gained an advantage over their rivals.	channel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.475122	2025-07-09 13:24:45.754924	他们利用秘密通道，比对手更厉害。	AI generated	elementary	\N	\N	\N
177	A good sponsor will always support a promising new technique.	technique	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.475129	2025-07-09 13:24:51.00903	好的赞助者总是会支持有希望的新方法。	AI generated	elementary	\N	\N	\N
179	His professional skills gave him a distinct advantage in the competition.	professional	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.479767	2025-07-09 13:24:51.009036	他的专业技能让他在比赛中有了明显的优势。	AI generated	elementary	\N	\N	\N
181	Her inner strength seemed to grow with every passing particle of doubt she overcame.	strength	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.496432	2025-07-09 13:24:51.009037	她克服的每一个小小的怀疑，都让她的内心力量似乎在增长。	AI generated	elementary	\N	\N	\N
183	The manager will directly update the project schedule after the meeting.	directly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.505352	2025-07-09 13:24:51.009039	会议结束后，经理会直接更新项目进度表。	AI generated	elementary	\N	\N	\N
187	Great literature often explores the complexities of democracy.	literature	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.509541	2025-07-09 13:24:54.57763	伟大的文学作品常常会讲民主的复杂之处。	AI generated	elementary	\N	\N	\N
218	The captain gave the order to release the lifeboat, trusting the crew's navigation skills in the storm.	release	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:12.034138	2025-07-09 13:25:04.742953	船长下令放下救生艇，相信船员们在暴风雨中的航行技术。	AI generated	intermediate	\N	\N	\N
220	The company offered extensive training and made a promise of career advancement to all new hires.	training	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:12.046211	2025-07-09 13:25:04.742955	公司提供大量的培训，并承诺所有新员工都有职业发展机会。	AI generated	intermediate	\N	\N	\N
197	They usually maintain a peaceful relationship, despite occasional disagreements.	relationship	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.569515	2025-07-09 13:24:57.299845	他们通常保持和平的关系，即使偶尔会有小争吵。	AI generated	elementary	\N	\N	\N
199	Early detection of the flaw led to immediate employment of a patching solution.	detection	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.569518	2025-07-09 13:24:57.299851	尽早发现错误，就能马上用补丁来解决。	AI generated	elementary	\N	\N	\N
201	Whenever possible, they chose a peaceful approach to conflict resolution.	whenever	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.569521	2025-07-09 13:24:57.299852	只要有可能，他们就选择用和平的方法来解决冲突。	AI generated	elementary	\N	\N	\N
208	A patient husband understands his wife's need for quiet time after a stressful day.	husband	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.591013	2025-07-09 13:25:01.044093	有耐心的丈夫明白妻子在压力大的一天后需要安静的时间。	AI generated	elementary	\N	\N	\N
210	This job requires a specific skill set and a suitable personality for teamwork.	suitable	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.596897	2025-07-09 13:25:01.044095	这份工作需要特定的技能和适合团队合作的性格。	AI generated	elementary	\N	\N	\N
212	Her suspicion grew as she observed his unusually patient behavior, sensing something amiss.	suspicion	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:11.5969	2025-07-09 13:25:01.044096	当她观察到他异常耐心的行为时，她的怀疑增加了，感觉有些不对劲。	AI generated	elementary	\N	\N	\N
222	His shallow understanding of the situation led to a poor judgment call.	shallow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:12.046215	2025-07-09 13:25:04.742956	他对情况了解不深，导致做出了错误的判断。	AI generated	elementary	\N	\N	\N
242	The small town, believed to be Shakespeare's birthplace, experienced a revelation about its own history during the festival.	birthplace	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.526934	2025-07-09 13:25:11.565511	那个小镇被认为是莎士比亚的出生地，在节日期间发现了关于自己历史的新秘密。	AI generated	intermediate	\N	\N	\N
248	Full cooperation from every visitor is essential for preserving the ecological balance in the park.	cooperation	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.535756	2025-07-09 13:25:14.600346	为了保护公园里的生态平衡，需要每位游客的完全合作。	AI generated	intermediate	\N	\N	\N
250	Exploring the spiritual dimension of the artifact led to a surprising revelation about its origins.	dimension	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.535759	2025-07-09 13:25:14.600347	探索这个文物的精神层面，对它的起源有了令人惊讶的发现。	AI generated	intermediate	\N	\N	\N
230	The swimming competition at the stadium was exhilarating.	swimming	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.103965	2025-07-09 13:25:08.299431	在体育场的游泳比赛真让人兴奋！	AI generated	elementary	\N	\N	\N
238	Yesterday, a bright student solved a complex math problem.	yesterday	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.103986	2025-07-09 13:25:11.565508	昨天，一个聪明的学生解决了一道很难的数学题。	AI generated	elementary	\N	\N	\N
240	Learning to swim well can influence a child's confidence while swimming.	swimming	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.10399	2025-07-09 13:25:11.56551	好好学游泳可以影响小朋友游泳时的自信心。	AI generated	elementary	\N	\N	\N
252	Generally, doctors recommend a daily vitamin D supplement, especially during winter months.	generally	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.535763	2025-07-09 13:25:14.600348	通常，医生建议每天补充维生素D，尤其是在冬季。	AI generated	elementary	\N	\N	\N
258	The company planned a formal dinner for the anniversary of his retirement.	anniversary	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.729018	2025-07-09 13:25:17.979535	公司为他退休周年纪念日准备了一个正式的晚餐。	AI generated	elementary	\N	\N	\N
260	The restaurant stopped selling tobacco products last year due to health concerns.	tobacco	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.729022	2025-07-09 13:25:17.979537	因为担心健康问题，这家餐厅去年停止卖烟草了。	AI generated	elementary	\N	\N	\N
262	Fortunately, we were fortunate to find shelter before the rain started.	fortunate	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.733122	2025-07-09 13:25:17.979538	幸运的是，在下雨之前我们找到了可以躲雨的地方。	AI generated	elementary	\N	\N	\N
290	The detective knew resisting the temptation to make contact would be crucial to the investigation's success.	contact	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.945131	2025-07-09 13:25:27.918412	侦探知道，忍住联系的冲动对调查成功至关重要。	AI generated	intermediate	\N	\N	\N
268	The new law provides improvement in online privacy for all citizens.	privacy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.82697	2025-07-09 13:25:21.082196	新的法律让所有公民的网上隐私得到了更好的保护。	AI generated	elementary	\N	\N	\N
278	Luckily, his new trousers fit perfectly; the old ones ripped.	luckily	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.895057	2025-07-09 13:25:24.185171	幸运的是，他的新裤子非常合身；旧裤子破了。	AI generated	elementary	\N	\N	\N
280	The organization established a protocol whereby donations are tracked.	whereby	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.896785	2025-07-09 13:25:24.185173	这个机构建立了一个规则，用来追踪捐款。	AI generated	elementary	\N	\N	\N
282	I used the dictionary to understand the kangaroo's indigenous name.	kangaroo	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.90557	2025-07-09 13:25:24.185174	我用字典来理解袋鼠的本地名字。	AI generated	elementary	\N	\N	\N
284	Luckily, I followed her recommendation and aced the test.	luckily	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.907873	2025-07-09 13:25:24.185175	幸运的是，我听了她的建议，考试考得很好。	AI generated	elementary	\N	\N	\N
288	His desperate request to halt the divorce was denied.	request	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.907878	2025-07-09 13:25:27.91841	他拼命请求停止离婚，但被拒绝了。	AI generated	elementary	\N	\N	\N
292	At sixteen, she worked at a local art gallery, learning about different artists.	sixteen	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.950641	2025-07-09 13:25:27.918413	十六岁时，她在当地一家美术馆工作，学习关于不同艺术家的知识。	AI generated	elementary	\N	\N	\N
298	The increase in sales was significant, but still relatively small compared to our competitors.	significant	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.955137	2025-07-09 13:25:30.94037	销售额增加了很多，但和我们的对手比起来还是比较少的。	AI generated	elementary	\N	\N	\N
300	Her intelligence was clear from the insightful analysis she provided at the art gallery.	intelligence	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:15.955139	2025-07-09 13:25:30.940371	她在美术馆的分析很有见地，一看就知道她很聪明。	AI generated	elementary	\N	\N	\N
337	Could you arrange for the jeweler to inspect the diamond before we commit to buying it?	arrange	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.100095	2025-07-09 13:25:45.948148	在决定买之前，你能安排珠宝商检查一下这颗钻石吗？	AI generated	intermediate	\N	\N	\N
307	Politics is a dirty game, and the politician knew he had to play it.	politics	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.396154	2025-07-09 13:25:34.573112	政治就像一场脏兮兮的游戏，那个政治家知道他必须玩下去。	AI generated	elementary	\N	\N	\N
309	New technologies are required to sustain the space shuttle program long-term.	sustain	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.396158	2025-07-09 13:25:34.573118	我们需要新的技术，才能让航天飞机计划持续更久。	AI generated	elementary	\N	\N	\N
317	Following her guidance, I used the scissors to carefully cut the fabric.	guidance	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.483958	2025-07-09 13:25:37.653707	在她的指导下，我用剪刀小心地剪布。	AI generated	elementary	\N	\N	\N
319	The fashionable young activists channeled their energy into peaceful rebellion.	rebellion	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.483962	2025-07-09 13:25:37.653713	时髦的年轻行动者们把精力投入到和平的反抗中。	AI generated	elementary	\N	\N	\N
321	I reserve the right to attempt that difficult climb again tomorrow.	reserve	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.488714	2025-07-09 13:25:37.653714	我保留明天再次尝试那次困难攀登的权利。	AI generated	elementary	\N	\N	\N
323	They decided to suspend the meeting until a more fashionable time.	suspend	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.488718	2025-07-09 13:25:37.653715	他们决定暂停会议，直到一个更合适的时间。	AI generated	elementary	\N	\N	\N
327	Finding comfort is difficult for the scholar amidst constant academic pressure.	comfort	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.863665	2025-07-09 13:25:42.082741	学者在不停的学习压力下，很难找到舒服的感觉。	AI generated	elementary	\N	\N	\N
329	The speaker hoped his words would provide some comfort to the grieving families.	comfort	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.866372	2025-07-09 13:25:42.082745	演讲者希望他的话能给悲伤的家庭带来一些安慰。	AI generated	elementary	\N	\N	\N
331	The scholar valued intellectual freedom above all else, even security.	scholar	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.878475	2025-07-09 13:25:42.082745	学者认为思想上的自由比什么都重要，甚至比安全还重要。	AI generated	elementary	\N	\N	\N
333	The maximum time allotted for reading this passage is five minutes.	passage	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:19.878479	2025-07-09 13:25:42.082746	读这篇文章最多只能用五分钟。	AI generated	elementary	\N	\N	\N
339	I suggest you get the diamond appraised independently, just to be safe.	diamond	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.103585	2025-07-09 13:25:45.948153	我建议你找个没关系的人来评估一下钻石，这样更保险。	AI generated	elementary	\N	\N	\N
351	The competition was fierce, and it was hard to swallow the defeat, but she learned a lot.	competition	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.135847	2025-07-09 13:25:50.449575	比赛很激烈，输了很难受，但她学到了很多东西。	AI generated	intermediate	\N	\N	\N
357	The talented artist's skill was evident in every brushstroke on the surface of the canvas.	talented	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.144504	2025-07-09 13:25:54.336485	这位有才华的画家的技巧在画布上的每一笔都看得出来。	AI generated	intermediate	\N	\N	\N
347	Taking out a large mortgage felt like buying a piece of the universe.	mortgage	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.112188	2025-07-09 13:25:50.44957	拿出很多钱贷款，感觉就像买下了宇宙的一部分。	AI generated	elementary	\N	\N	\N
349	The news spread through the village and shortly everyone knew about the upcoming festival.	village	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.131439	2025-07-09 13:25:50.449574	消息传遍了村庄，很快每个人都知道了即将到来的节日。	AI generated	elementary	\N	\N	\N
359	Many schools collect entry fees for the math competition each year.	competition	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.144507	2025-07-09 13:25:54.336491	很多学校每年都会为数学比赛收取报名费。	AI generated	elementary	\N	\N	\N
361	After a thorough investigation, the team celebrated their triumph over the complex case.	triumph	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.255503	2025-07-09 13:25:54.336492	经过仔细的调查，团队庆祝他们在这个复杂的案件中获胜。	AI generated	elementary	\N	\N	\N
363	She carried her handbag throughout her entire lifetime, a treasured memento.	lifetime	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.264545	2025-07-09 13:25:54.336494	她一生都带着她的手提包，这是一个珍贵的纪念品。	AI generated	elementary	\N	\N	\N
367	The architect designed the building with a parallel tower structure for aesthetic appeal.	parallel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.26707	2025-07-09 13:25:58.63843	建筑师设计的大楼有平行的塔，这样看起来更漂亮。	AI generated	elementary	\N	\N	\N
369	I was excited about the parallel paths our careers were taking.	parallel	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.267074	2025-07-09 13:25:58.638436	我很高兴我们的职业道路是平行的。	AI generated	elementary	\N	\N	\N
371	The project manager provided a detailed summary outlining each person's responsibility.	responsibility	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:20.269864	2025-07-09 13:25:58.638437	项目经理提供了一份详细的总结，说明了每个人的责任。	AI generated	elementary	\N	\N	\N
375	Tourism suffered when falling coconut prices impacted the island's economy.	tourism	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.615308	2025-07-09 13:25:58.63844	椰子价格下跌影响了岛上的经济，旅游业也受到了影响。	AI generated	elementary	\N	\N	\N
377	My relative is arriving tomorrow, bringing homemade pies for everyone.	tomorrow	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.615313	2025-07-09 13:26:01.763943	我的亲戚明天要来，给大家带来自制馅饼。	AI generated	elementary	\N	\N	\N
409	His firm standing in the community was built upon the chocolate factory he owned and operated.	chocolate	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.904984	2025-07-09 13:26:14.043282	他在社区里的好名声，是因为他拥有并经营着一家巧克力工厂。	AI generated	intermediate	\N	\N	\N
411	For pure convenience, nothing beats grabbing a hamburger at the airport before a long flight.	convenience	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.91482	2025-07-09 13:26:14.043283	为了方便，没有什么比在长途飞行前在机场吃个汉堡更好的了。	AI generated	intermediate	\N	\N	\N
387	The restoration of the antique car was a remarkable product of skilled craftsmanship.	restoration	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.675889	2025-07-09 13:26:05.958946	这辆老式汽车的修复是精湛工艺的杰出成果。	AI generated	elementary	\N	\N	\N
389	The heavy rainfall had a disastrous relation to the crop yields this year.	rainfall	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.675893	2025-07-09 13:26:05.958951	今年的大雨对农作物的收成造成了很糟糕的影响。	AI generated	elementary	\N	\N	\N
391	The machine stamped out each product precisely to the given specifications.	product	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.675897	2025-07-09 13:26:05.958952	这台机器按照给定的要求，精确地生产出每个产品。	AI generated	elementary	\N	\N	\N
397	The hiker entered the wilderness without a map, a decision he'd soon regret.	wilderness	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.822986	2025-07-09 13:26:10.105754	这个徒步者没有地图就进了野外，他很快就会后悔的。	AI generated	elementary	\N	\N	\N
399	Her leisure time allowed a significant contribution to the community garden.	leisure	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.841562	2025-07-09 13:26:10.105759	她的空闲时间让她为社区花园做了很多贡献。	AI generated	elementary	\N	\N	\N
401	Exploring the vast wilderness brought unexpected prestige to the small research team.	wilderness	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.841566	2025-07-09 13:26:10.10576	探索广阔的野外给这个小小的研究团队带来了意想不到的好名声。	AI generated	elementary	\N	\N	\N
403	The latest magazine featured stunning photography of the Alaskan wilderness.	wilderness	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.84157	2025-07-09 13:26:10.105761	最新一期的杂志刊登了阿拉斯加野外的美丽照片。	AI generated	elementary	\N	\N	\N
407	The patient rejected the physician's proposal for immediate surgery.	proposal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.841577	2025-07-09 13:26:14.043279	病人拒绝了医生提出的立即做手术的建议。	AI generated	elementary	\N	\N	\N
413	She surprised him with a gourmet chocolate hamburger cake for his birthday.	chocolate	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.917617	2025-07-09 13:26:14.043284	她用一个美味的巧克力汉堡蛋糕给他过生日，让他很惊喜。	AI generated	elementary	\N	\N	\N
417	She carried the heavy box on her shoulder, struggling to meet the company's standard for deliveries.	shoulder	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.917623	2025-07-09 13:26:16.915052	她扛着沉重的箱子在肩膀上，努力达到公司送货的标准。	AI generated	intermediate	\N	\N	\N
447	Confident that the rain would cease, she looked up to admire the vibrant rainbow arcing across the sky.	confident	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:27.991581	2025-07-09 13:26:27.008717	因为相信雨会停，她抬头欣赏天空中鲜艳的彩虹。	AI generated	intermediate	\N	\N	\N
427	The doctor spoke seriously and quietly about the risks of the surgery.	serious	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.955999	2025-07-09 13:26:20.320785	医生严肃又轻声地说了手术的危险。	AI generated	elementary	\N	\N	\N
429	I will study diligently tonight to impress my professor with my knowledge.	tonight	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.956002	2025-07-09 13:26:20.320789	我今晚会认真学习，让教授觉得我很有学问。	AI generated	elementary	\N	\N	\N
431	The front-page article in the newspaper discussed the new environmental regulations.	article	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:23.956005	2025-07-09 13:26:20.32079	报纸头版文章讲了新的环保规定。	AI generated	elementary	\N	\N	\N
433	The sudden shift in public opinion was a fascinating phenomenon debated fiercely within parliament.	phenomenon	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:25.0578	2025-07-09 13:26:20.320791	公众意见的突然改变是一个有趣的现象，议会在激烈讨论。	AI generated	elementary	\N	\N	\N
437	Dolphin pods are frequently observed playing in the waves near the coast.	dolphin	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:25.060585	2025-07-09 13:26:23.730218	海豚群经常被看到在海岸附近的浪花里玩耍。	AI generated	elementary	\N	\N	\N
439	Driven by anger, he frequently fantasized about revenge on those who wronged him.	frequently	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:25.060589	2025-07-09 13:26:23.730223	因为生气，他经常幻想向那些冤枉他的人报仇。	AI generated	elementary	\N	\N	\N
441	Each morning, the linguistic minority group broadcasts its news in its native tongue.	minority	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:25.060593	2025-07-09 13:26:23.730224	每天早上，说少数民族语言的人们用自己的语言播放新闻。	AI generated	elementary	\N	\N	\N
443	His desire for revenge clouded his judgment regarding sensible finance planning.	revenge	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:25.060597	2025-07-09 13:26:23.730225	他想报仇的念头让他在理财方面变得不理智。	AI generated	elementary	\N	\N	\N
449	The confident woman spoke with the quiet dignity of a hardened peasant.	confident	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:27.991585	2025-07-09 13:26:27.008722	这位自信的女士说话时带着饱经风霜的农民的安静尊严。	AI generated	elementary	\N	\N	\N
451	The farmer, essentially a peasant, received a care package from a local charity.	peasant	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:27.991589	2025-07-09 13:26:27.008723	这位农民，实际上是个乡下人，收到了一份来自当地慈善机构的关怀礼包。	AI generated	elementary	\N	\N	\N
457	The annual family picnic is a beloved tradition, but recently it rained, forcing us indoors.	tradition	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.183267	2025-07-09 13:26:29.864142	一年一度的家庭野餐是很棒的传统，但最近下雨了，我们只能待在屋里。	AI generated	intermediate	\N	\N	\N
481	The difficult climb presented a significant challenge, and water sources were scarce wherever we looked.	challenge	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.313726	2025-07-09 13:26:37.143437	这次困难的攀登是个很大的挑战，而且我们到处都找不到水。	AI generated	intermediate	\N	\N	\N
467	The western film critic acted as an observer during the festival.	western	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.202271	2025-07-09 13:26:33.085504	这位来自西方的电影评论家在电影节上像个观察员一样。	AI generated	elementary	\N	\N	\N
469	Their public quarrel didn't guarantee them any privacy afterward.	quarrel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.217887	2025-07-09 13:26:33.085508	他们在公共场合吵架，之后就更没有隐私了。	AI generated	elementary	\N	\N	\N
471	The solemn procession prompted a quiet discussion about remembrance.	procession	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.22707	2025-07-09 13:26:33.085509	庄严的队伍让大家安静地讨论起纪念的事情。	AI generated	elementary	\N	\N	\N
473	The political scandal demanded an immediate response from the administration.	scandal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.227073	2025-07-09 13:26:33.08551	政治丑闻需要政府立刻做出回应。	AI generated	elementary	\N	\N	\N
477	Following the heated quarrel, the secretary resigned immediately.	quarrel	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.229593	2025-07-09 13:26:33.085512	在激烈的争吵之后，秘书立刻辞职了。	AI generated	elementary	\N	\N	\N
479	The brilliant sound from the speaker made the room vibrate.	brilliant	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.229596	2025-07-09 13:26:37.143435	喇叭里发出的好听声音让房间都震动起来。	AI generated	elementary	\N	\N	\N
483	Faced with fierce opposition, the CEO announced his resignation at the meeting.	opposition	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.321469	2025-07-09 13:26:37.143439	因为遇到强烈的反对，首席执行官在会议上宣布辞职。	AI generated	elementary	\N	\N	\N
489	Amidst the confusion, I realized I had nothing of value to contribute.	confusion	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.327898	2025-07-09 13:26:40.482734	在混乱中，我发现我没有什么有用的东西可以贡献。	AI generated	elementary	\N	\N	\N
491	Follow the detailed instruction carefully to unearth the hidden treasure.	treasure	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.327902	2025-07-09 13:26:40.482736	仔细按照详细的说明，才能找到隐藏的宝藏。	AI generated	elementary	\N	\N	\N
499	For some, using online grocery delivery is convenient, but it can create more plastic garbage.	convenient	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.701472	2025-07-09 13:26:44.141142	对一些人来说，用网上买菜很方便，但它会产生更多的塑料垃圾。	AI generated	intermediate	\N	\N	\N
501	Choosing to adopt the rescue dog was the best decision of my life, a true blessing.	decision	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:28.701476	2025-07-09 13:26:44.141143	选择领养那只被救助的狗狗是我一生中最好的决定，真是个礼物。	AI generated	intermediate	\N	\N	\N
514	During my childhood, the temperature in summer was consistently above 30 degrees Celsius.	childhood	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:29.095222	2025-07-09 13:26:47.317402	我小时候，夏天总是超过30摄氏度。	AI generated	elementary	\N	\N	\N
516	I dislike waiting, and I'll probably retreat if the queue is too long.	dislike	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:29.095225	2025-07-09 13:26:47.317403	我不喜欢等待，如果队伍太长，我可能会走开。	AI generated	elementary	\N	\N	\N
519	The headline announced different approaches to the government's military spending.	headline	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:29.09523	2025-07-09 13:26:47.317405	标题说了政府在军事上的花钱方式不一样了。	AI generated	elementary	\N	\N	\N
524	Calculating the velocity of the debris is crucial for insurance claim adjustments.	velocity	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:31.589754	2025-07-09 13:26:51.029909	计算碎片的速度对于调整保险索赔很重要。	AI generated	elementary	\N	\N	\N
526	The clumsy translation made the majestic sound of the trumpet seem comical.	translation	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:31.589758	2025-07-09 13:26:51.029911	笨拙的翻译让小号雄伟的声音听起来很滑稽。	AI generated	elementary	\N	\N	\N
528	Nuance is often lost in translation, especially with sensitive political topics.	translation	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:31.589762	2025-07-09 13:26:51.029912	细微的差别在翻译中经常会丢失，尤其是在敏感的政治话题上。	AI generated	elementary	\N	\N	\N
534	The mysterious connection between poverty and the spread of disease is undeniable.	connection	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.174583	2025-07-09 13:26:54.103462	穷和疾病传播之间有很奇怪的关系，这是真的。	AI generated	elementary	\N	\N	\N
568	The grand opening of the new art gallery marked a significant conversation starter for the community.	opening	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.581864	2025-07-09 13:27:04.764588	新美术馆的盛大开幕，为社区开启了一个重要的话题。	AI generated	intermediate	\N	\N	\N
544	The rural junction has a bus stop, with one exception, during holidays.	junction	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.190266	2025-07-09 13:26:57.779861	乡村路口有一个公交车站，但节假日的时候有一个例外。	AI generated	elementary	\N	\N	\N
546	The learning curve is steep, but success is probable with dedication.	learning	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.544015	2025-07-09 13:26:57.779862	学习的过程可能有点难，但只要努力，成功很有希望。	AI generated	elementary	\N	\N	\N
554	I can only imagine the relief after undergoing such intensive treatment.	treatment	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.546744	2025-07-09 13:27:01.733132	我能想象到接受这么辛苦的治疗后放松的心情。	AI generated	elementary	\N	\N	\N
556	Imagine the look on her face when I present her with the gift.	imagine	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.549684	2025-07-09 13:27:01.733133	想象一下，当我把礼物送给她时，她会是什么表情。	AI generated	elementary	\N	\N	\N
558	The patient's slow recovery highlighted the importance of consistent physical therapy.	recovery	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.574115	2025-07-09 13:27:01.733134	病人恢复得很慢，说明坚持做身体锻炼很重要。	AI generated	elementary	\N	\N	\N
564	Despite the terrible weather, his strategy was to succeed and claim victory.	weather	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.581855	2025-07-09 13:27:04.764585	尽管天气很糟糕，他的计划是成功并赢得胜利。	AI generated	elementary	\N	\N	\N
583	The teenager transformed her bedroom's interior with vibrant posters.	teenager	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.610907	2025-07-09 13:27:11.937845	这个青少年用鲜艳的海报改变了她卧室的内部装饰。	AI generated	elementary	\N	\N	\N
585	The judge announced the verdict after confirming sufficient postage was paid for the notification.	verdict	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:32.61091	2025-07-09 13:27:11.937849	法官在确认通知已经支付了足够的邮资后，宣布了判决结果。	AI generated	elementary	\N	\N	\N
587	The cruise offered varied entertainment, but I wasn't sure whether I'd enjoy it.	entertainment	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:34.152952	2025-07-09 13:27:11.93785	这次邮轮旅行提供了各种各样的娱乐活动，但我不确定我是否会喜欢。	AI generated	elementary	\N	\N	\N
593	The official recipe called for a single enormous pancake.	pancake	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:34.159116	2025-07-09 13:27:15.225615	官方食谱说要做一个很大的煎饼。	AI generated	elementary	\N	\N	\N
595	My New Year's resolution is to document every step of my spiritual journey.	journey	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:34.15912	2025-07-09 13:27:15.225621	我的新年愿望是记录我心灵旅程的每一步。	AI generated	elementary	\N	\N	\N
597	I had to withdraw my application due to lack of satisfaction with the program.	withdraw	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:34.159124	2025-07-09 13:27:15.225623	因为我对这个项目不太满意，所以我不得不撤回我的申请。	AI generated	elementary	\N	\N	\N
599	The doctor prescribed a medical stocking to improve circulation in her leg.	medical	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.179348	2025-07-09 13:27:15.225624	医生开了医用袜子， чтобы 帮助她的腿部血液循环更好。	AI generated	elementary	\N	\N	\N
603	His hands trembled as he awaited the medical diagnosis.	tremble	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.18366	2025-07-09 13:27:18.137942	他的手在等待医生诊断的时候发抖了。	AI generated	elementary	\N	\N	\N
605	The vintage photograph showed her in good condition, despite its age.	photograph	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.183663	2025-07-09 13:27:18.137947	这张老照片显示她状态很好，虽然它很旧了。	AI generated	elementary	\N	\N	\N
607	String lights adorned the ceiling, creating a warm ambiance for the evening.	ceiling	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.183666	2025-07-09 13:27:18.137948	小彩灯装饰着天花板，为夜晚营造了温暖的气氛。	AI generated	elementary	\N	\N	\N
609	The old photograph facilitated a surprising communication with long-lost relatives.	photograph	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.183669	2025-07-09 13:27:18.137949	这张旧照片促成了一次与失散很久的亲戚的意外联系。	AI generated	elementary	\N	\N	\N
613	The property line runs vertical to the old oak tree.	property	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.947498	2025-07-09 13:27:21.311998	这条地界线垂直于那棵老橡树。	AI generated	elementary	\N	\N	\N
623	Please register the triangle for the geometry competition before the deadline.	register	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.991471	2025-07-09 13:27:24.196898	请在截止日期前报名参加几何竞赛的三角形。	AI generated	elementary	\N	\N	\N
625	The doctor was careful during her patient's surgery, therefore, complications were avoided.	therefore	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.998083	2025-07-09 13:27:24.196904	医生在给病人做手术时很小心，所以避免了并发症。	AI generated	elementary	\N	\N	\N
627	Feeling thirsty after the hike, he felt only temporary relief from the small spring.	thirsty	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:36.998086	2025-07-09 13:27:24.196905	徒步旅行后感到口渴，他从一个小泉眼中得到的只是暂时的缓解。	AI generated	elementary	\N	\N	\N
633	Her inspiration came while washing dishes in the kitchen, leading to a brilliant idea.	inspiration	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.005206	2025-07-09 13:27:27.117524	她的灵感来自在厨房洗碗的时候，这让她有了一个很棒的主意。	AI generated	elementary	\N	\N	\N
635	The esteemed professor received a thoughtful gift on his birthday.	professor	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.027502	2025-07-09 13:27:27.117528	那位受人尊敬的教授在他的生日收到了一份很贴心的礼物。	AI generated	elementary	\N	\N	\N
637	A rising unemployment rate is a clear symptom of a looming economic recession.	recession	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.029947	2025-07-09 13:27:27.117529	失业率上升是经济可能要变差的一个明显信号。	AI generated	elementary	\N	\N	\N
639	He needed a large portion of courage to speak his mind.	portion	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.032998	2025-07-09 13:27:27.11753	他需要很大的勇气才能说出自己的想法。	AI generated	elementary	\N	\N	\N
643	With unexpected courage, the photographer captured stunning images of the storm.	photographer	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.033004	2025-07-09 13:27:31.008285	摄影师鼓起勇气，拍下了暴风雨惊人的照片。	AI generated	elementary	\N	\N	\N
645	She had to undergo an interview with the experienced photographer.	undergo	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.033007	2025-07-09 13:27:31.008291	她需要接受一位有经验的摄影师的采访。	AI generated	elementary	\N	\N	\N
647	The government banned the sale of sugary lollipop brands to children under five.	lollipop	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.04698	2025-07-09 13:27:31.008292	政府禁止向五岁以下儿童出售含糖棒棒糖。	AI generated	elementary	\N	\N	\N
649	The loyal servant, bravely facing danger, protected the royal family.	bravely	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.059908	2025-07-09 13:27:31.008293	忠诚的仆人勇敢地面对危险，保护了王室。	AI generated	elementary	\N	\N	\N
653	Her vibrant personality shone through her multiple artistic endeavors.	personality	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:37.059915	2025-07-09 13:27:34.666546	她活泼的个性在她做的很多艺术作品中都能看出来。	AI generated	elementary	\N	\N	\N
663	The subtle variation in climate significantly impacts the local environment and wildlife.	variation	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:38.973572	2025-07-09 13:27:37.453569	气候的细微变化对当地环境和野生动物有很大影响。	AI generated	elementary	\N	\N	\N
665	It was remarkable how quickly the injured chicken recovered and rejoined the flock.	remarkable	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:38.973575	2025-07-09 13:27:37.453573	受伤的小鸡恢复得很快，又回到了鸡群，这真是太棒了。	AI generated	elementary	\N	\N	\N
667	The historian made a reference to the leather-bound journals found in the archives.	reference	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:38.973578	2025-07-09 13:27:37.453574	历史学家提到了在档案馆里找到的皮面日记。	AI generated	elementary	\N	\N	\N
673	The character's sudden change was due to a reduction in his medication.	character	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:40.237055	2025-07-09 13:27:40.986538	这个角色的突然改变是因为他吃的药减少了。	AI generated	elementary	\N	\N	\N
675	Expanding your vocabulary with reasonable effort will improve your communication skills.	vocabulary	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:40.237059	2025-07-09 13:27:40.986543	努力学习更多的词语，你的说话能力会更好。	AI generated	elementary	\N	\N	\N
677	The forest fire, started by lightning, devastated the local wildlife.	lightning	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:40.237063	2025-07-09 13:27:40.986545	森林大火是闪电引起的，它伤害了很多小动物。	AI generated	elementary	\N	\N	\N
679	The principle of fairness requires special consideration for disadvantaged groups.	principle	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:40.237067	2025-07-09 13:27:40.986546	公平的意思是，我们要特别关心那些有困难的人。	AI generated	elementary	\N	\N	\N
683	I didn't want to mention it, but our company headquarters are relocating.	mention	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.04781	2025-07-09 13:27:43.601267	我本来不想说的，但是我们公司的总部要搬家了。	AI generated	elementary	\N	\N	\N
685	There's a possibility we'll eat outside if the weather is nice.	possibility	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.057976	2025-07-09 13:27:43.601273	如果天气好的话，我们可能会在外面吃饭。	AI generated	elementary	\N	\N	\N
687	The subject of the debate was the appropriate punishment for vandalism.	subject	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.060555	2025-07-09 13:27:43.601274	辩论的主题是对乱涂乱画应该怎么处罚。	AI generated	elementary	\N	\N	\N
693	Keeping pets outside in violent weather is considered animal cruelty.	outside	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.060566	2025-07-09 13:27:46.36095	把宠物放在外面经历恶劣天气被认为是虐待动物。	AI generated	elementary	\N	\N	\N
703	A sparkle of innovation boosted the marketing campaign's success.	sparkle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.120641	2025-07-09 13:27:49.229096	一点点创新让营销活动更成功了。	AI generated	elementary	\N	\N	\N
705	A minor scratch was found on the new construction equipment.	construction	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.120645	2025-07-09 13:27:49.229102	新的建筑设备上发现了一点小划痕。	AI generated	elementary	\N	\N	\N
707	His positive attitude helped him overcome his average grades and succeed.	attitude	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.283893	2025-07-09 13:27:49.229104	他积极的态度帮助他克服了普通的成绩并取得了成功。	AI generated	elementary	\N	\N	\N
709	Poverty fueled a passionate protest against the unfair economic policies.	poverty	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.299144	2025-07-09 13:27:49.229105	贫穷引发了对不公平经济政策的强烈抗议。	AI generated	elementary	\N	\N	\N
713	The pamphlet contained instructions on how to reverse the effects of the harmful pesticide.	pamphlet	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.299152	2025-07-09 13:27:52.675883	这本小册子教你怎样消除有害农药的坏处。	AI generated	elementary	\N	\N	\N
715	The tourist wore a puzzled expression as he examined the ancient ruins.	expression	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.299155	2025-07-09 13:27:52.675887	那个游客看着古老的废墟，脸上带着疑惑的表情。	AI generated	elementary	\N	\N	\N
717	A community pamphlet outlined steps to combat poverty in their neighborhood.	poverty	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.299159	2025-07-09 13:27:52.675888	一份社区小册子介绍了帮助大家摆脱贫困的方法。	AI generated	elementary	\N	\N	\N
723	The athletic association chose to improve the entire school district over just one gymnasium.	district	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.550564	2025-07-09 13:27:56.825172	运动协会选择改善整个学区，而不是只改善一个体育馆。	AI generated	elementary	\N	\N	\N
725	Effective leadership requires navigating the challenges of governing a tropical island nation.	leadership	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.550567	2025-07-09 13:27:56.825176	有效的领导需要应对管理一个热带岛国的挑战。	AI generated	elementary	\N	\N	\N
727	The curious child approached the exotic butterfly cage carefully, mesmerized by its colors.	curious	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:41.554326	2025-07-09 13:27:56.825177	好奇的孩子小心地靠近了充满异国情调的蝴蝶笼，被它的颜色迷住了。	AI generated	elementary	\N	\N	\N
734	The new training program aims to stimulate growth and improve skills among all personnel.	stimulate	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:43.315206	2025-07-09 13:28:02.266931	新的培训计划想要让大家进步，提高所有员工的技能。	AI generated	elementary	\N	\N	\N
745	Despite the friendly introduction, I was still worried about making a good first impression.	worried	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:43.326362	2025-07-09 13:28:07.051739	虽然介绍很友好，但我还是担心能不能给人留下好印象。	AI generated	elementary	\N	\N	\N
747	The playful squirrel darted up the oak tree, hopefully finding a hidden acorn.	squirrel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:44.5646	2025-07-09 13:28:07.05174	那只爱玩的小松鼠飞快地爬上橡树，希望能找到藏起来的橡子。	AI generated	elementary	\N	\N	\N
749	The specialized vehicle could perfectly transport the delicate artifacts.	perfectly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:44.566861	2025-07-09 13:28:07.051741	这辆特别的车可以完美地运送那些易碎的文物。	AI generated	elementary	\N	\N	\N
753	The satellite downlink experienced technical difficulties right at sunrise.	sunrise	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:44.574848	2025-07-09 13:28:10.530158	卫星的信号接收在日出时遇到了技术问题。	AI generated	elementary	\N	\N	\N
755	The procedure was designed to perfectly address all technical issues.	perfectly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:44.57712	2025-07-09 13:28:10.530163	这个方法是为了完美地解决所有技术难题而设计的。	AI generated	elementary	\N	\N	\N
757	It's important to recognize the inherent dignity of all humanity.	recognize	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:44.577124	2025-07-09 13:28:10.530164	认识到所有人的天生尊严非常重要。	AI generated	elementary	\N	\N	\N
759	The pilot helped her find her seat on the plane.	her	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:44.987086	2025-07-09 13:28:10.530165	飞行员帮助她找到了在飞机上的座位。	AI generated	elementary	\N	\N	\N
763	That sticky note is stuck to the page in my book.	sticky	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.002261	2025-07-09 13:28:13.91425	那张便利贴粘在我书的页上了。	AI generated	elementary	\N	\N	\N
765	A good map can be useful when you are a pilot.	useful	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.002265	2025-07-09 13:28:13.914256	当你当飞行员的时候，一张好的地图会很有用。	AI generated	elementary	\N	\N	\N
775	The new factory's rural location, while scenic, did little to address the area's persistent unemployment.	unemployment	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.272785	2025-07-09 13:28:17.2948	新工厂建在乡下，风景很美，但对解决当地一直存在的失业问题没什么帮助。	AI generated	intermediate	\N	\N	\N
804	I have a keen eye for detail, so I can see a small pinch of salt.	keen	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:46.02222	2025-07-09 13:28:26.729373	我非常注重细节，所以能看到一小撮盐。	AI generated	intermediate	\N	\N	\N
773	The officer's firm command echoed across the highway, halting the convoy for inspection.	highway	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.272782	2025-07-09 13:28:17.294795	警官严厉的命令在高速公路上回响，让车队停下来接受检查。	AI generated	elementary	\N	\N	\N
783	I hope I pass the shooting test after using the rifle.	pass	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.66004	2025-07-09 13:28:20.013022	我希望用了步枪后，我能通过射击测试。	AI generated	elementary	\N	\N	\N
786	The tiny ant failed the test to carry the heavy leaf.	ant	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.674769	2025-07-09 13:28:20.013028	那只小蚂蚁没能通过搬运重叶子的测试。	AI generated	elementary	\N	\N	\N
788	I would trade my toy for that game, surely!	trade	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.674773	2025-07-09 13:28:20.013029	我肯定愿意用我的玩具换那个游戏！	AI generated	elementary	\N	\N	\N
790	The lotion will surely make your skin feel soft.	lotion	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.674777	2025-07-09 13:28:20.01303	这个润肤露肯定会让你的皮肤感觉柔软。	AI generated	elementary	\N	\N	\N
794	His favorite word describes the fluffy white rabbit.	rabbit	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:45.674785	2025-07-09 13:28:23.223695	他最喜欢的词语是用来形容毛茸茸的白色兔子的。	AI generated	elementary	\N	\N	\N
796	My warm coat helps my sore knee feel better when it's cold outside.	knee	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:46.011933	2025-07-09 13:28:23.223697	我的暖和外套能让我的膝盖在外面冷的时候感觉好一些。	AI generated	elementary	\N	\N	\N
798	Please open the box, but be careful not to pinch your fingers.	pinch	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:46.019635	2025-07-09 13:28:23.223698	请打开这个盒子，但是要小心别夹到手指。	AI generated	elementary	\N	\N	\N
806	Please open the wound so I can clean the blood.	open	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:46.022223	2025-07-09 13:28:26.729375	请把伤口打开，这样我才能清理血迹。	AI generated	elementary	\N	\N	\N
814	People hoping to reach heaven will often stare upwards in prayer.	heaven	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:47.496201	2025-07-09 13:28:30.596034	希望去天堂的人常常会抬头向上祈祷。	AI generated	elementary	\N	\N	\N
816	The king wanted a positive image of his realm to be shown.	image	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:47.496205	2025-07-09 13:28:30.596035	国王希望展示他的王国美好的一面。	AI generated	elementary	\N	\N	\N
824	I can swim one step further each day.	swim	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.541237	2025-07-09 13:28:33.218374	我每天都能游得更远一步。	AI generated	elementary	\N	\N	\N
826	Let's reveal secrets and rid this room of problems.	reveal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.54124	2025-07-09 13:28:33.218376	让我们说出秘密，解决房间里的问题。	AI generated	elementary	\N	\N	\N
828	My shot was better than yours!	shot	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.541243	2025-07-09 13:28:33.218377	我射得比你好！	AI generated	elementary	\N	\N	\N
830	I will never go to prison!	i	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.541246	2025-07-09 13:28:33.218378	我永远不会去监狱！	AI generated	elementary	\N	\N	\N
834	My diary has a funny scene about a cat.	diary	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.619378	2025-07-09 13:28:36.064473	我的日记里有一个关于猫的有趣场景。	AI generated	elementary	\N	\N	\N
836	We can unite and make a visual presentation.	unite	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.619382	2025-07-09 13:28:36.064475	我们可以团结起来做一个看的见的展示。	AI generated	elementary	\N	\N	\N
838	The monkey climbed the tall shaft of the building.	shaft	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:48.619386	2025-07-09 13:28:36.064476	猴子爬上了那栋高楼的竖井。	AI generated	elementary	\N	\N	\N
844	The young woman can run very fast in the park.	run	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.452535	2025-07-09 13:28:39.092081	那个年轻的女人在公园里跑得非常快。	AI generated	elementary	\N	\N	\N
846	The sly woman had a secret smile.	woman	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.454686	2025-07-09 13:28:39.092082	那个狡猾的女人带着一个秘密的微笑。	AI generated	elementary	\N	\N	\N
848	Is there a faster way to run to school?	way	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.45745	2025-07-09 13:28:39.092083	有没有更快的方法跑到学校？	AI generated	elementary	\N	\N	\N
864	I will get a black cat next week.	week	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.819548	2025-07-09 13:28:44.625942	我下周会得到一只黑猫。	AI generated	elementary	\N	\N	\N
866	He is afraid to use the knife to cut the bread.	afraid	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.819552	2025-07-09 13:28:44.625945	他害怕用刀切面包。	AI generated	elementary	\N	\N	\N
868	The old cup had rust on its handle because it stayed outside.	rust	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.848663	2025-07-09 13:28:44.625946	这个旧杯子的把手生锈了，因为它放在外面。	AI generated	elementary	\N	\N	\N
870	Don't weep, I'll get you another cup of juice.	weep	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.851291	2025-07-09 13:28:44.625947	别哭，我会给你再拿一杯果汁。	AI generated	elementary	\N	\N	\N
874	The tailor found a pretty shell button for the coat.	shell	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.851298	2025-07-09 13:28:48.733944	裁缝为外套找到了一颗漂亮的贝壳纽扣。	AI generated	elementary	\N	\N	\N
876	I weep when I try to play my big brother's guitar.	guitar	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.851301	2025-07-09 13:28:48.733949	当我试着弹哥哥的吉他时，我会哭。	AI generated	elementary	\N	\N	\N
878	There was rust on the zipper of his old shirt.	shirt	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:49.851305	2025-07-09 13:28:48.73395	他旧衬衫的拉链生锈了。	AI generated	elementary	\N	\N	\N
880	The radio from the south plays softly in the background.	south	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:51.746482	2025-07-09 13:28:48.733951	来自南方的收音机在背景里轻轻地播放着。	AI generated	elementary	\N	\N	\N
884	The social media panel talked about new trends.	panel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:51.762486	2025-07-09 13:28:51.47347	社交媒体小组讨论了新的潮流。	AI generated	elementary	\N	\N	\N
886	I think that shirt is a very cool style.	style	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:51.76249	2025-07-09 13:28:51.473475	我觉得那件衬衫是很酷的款式。	AI generated	elementary	\N	\N	\N
888	He gave a thumb's up to show he liked the style.	style	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:51.762493	2025-07-09 13:28:51.473476	他竖起大拇指表示他喜欢这个款式。	AI generated	elementary	\N	\N	\N
890	Her style showed her strong faith in herself.	style	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:51.762497	2025-07-09 13:28:51.473477	她的风格展现了她对自己强大的信心。	AI generated	elementary	\N	\N	\N
896	The mask will limit how much air I can breathe.	mask	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.148041	2025-07-09 13:28:54.523115	这个面罩会限制我能呼吸多少空气。	AI generated	elementary	\N	\N	\N
898	The harbor air was mild and smelled of the sea.	harbor	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.148044	2025-07-09 13:28:54.523116	港口空气很温和，闻起来有大海的味道。	AI generated	elementary	\N	\N	\N
900	The sky is beautiful in the fall season.	season	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.148048	2025-07-09 13:28:54.523118	秋天的天空真漂亮。	AI generated	elementary	\N	\N	\N
906	I come to the farm to see the stock.	stock	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:52.755602	2025-07-09 13:28:57.442856	我来农场看牲畜。	AI generated	elementary	\N	\N	\N
916	I admire the captain on his long voyage across the sea.	admire	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.029145	2025-07-09 13:29:00.229624	我敬佩船长横跨大海的漫长航行。	AI generated	elementary	\N	\N	\N
918	The two buildings stand apart near the big museum.	apart	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.038166	2025-07-09 13:29:00.229626	这两栋建筑在大博物馆附近分开矗立。	AI generated	elementary	\N	\N	\N
920	The party used a stone slab as a table outside.	party	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.046669	2025-07-09 13:29:00.229627	聚会用一块石板当做外面的桌子。	AI generated	elementary	\N	\N	\N
926	A buoy will mark the dangers in the river.	mark	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.04668	2025-07-09 13:29:03.463115	一个浮标会标出河里的危险。	AI generated	elementary	\N	\N	\N
928	My brain is busy, so I have a query about the math problem.	query	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.061058	2025-07-09 13:29:03.463117	我脑子很忙，所以我对这道数学题有个疑问。	AI generated	elementary	\N	\N	\N
930	I need tape to fix the torn part of my book.	tape	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.073876	2025-07-09 13:29:03.463118	我需要胶带把书上撕破的地方粘好。	AI generated	elementary	\N	\N	\N
938	The heavy fog made walking feel less steady this morning.	fog	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.077976	2025-07-09 13:29:06.340941	今天早上雾很大，走路感觉不太稳。	AI generated	elementary	\N	\N	\N
940	The TV viewer asked the judge a question about the case.	judge	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.272136	2025-07-09 13:29:06.340942	看电视的人问了法官一个关于案件的问题。	AI generated	elementary	\N	\N	\N
942	The sign turned pale from the sun's heat all day long.	sign	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:53.278259	2025-07-09 13:29:06.340943	牌子被太阳晒了一整天，颜色都变淡了。	AI generated	elementary	\N	\N	\N
978	If you let the butter spoil, it will spoil your living room and the whole thing will shift to the town square.	butter	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.702886	2025-07-09 13:29:19.291409	如果你让黄油坏掉，它会弄脏你的客厅，然后整个东西会移到城镇广场。	AI generated	intermediate	\N	\N	\N
958	I can't decide what speed to go in this car.	speed	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:55.920881	2025-07-09 13:29:12.693095	我不知道这辆车该开多快。	AI generated	elementary	\N	\N	\N
960	Do not throw it if you mean to keep it.	throw	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:55.920886	2025-07-09 13:29:12.693096	如果你想留下它，就不要扔掉它。	AI generated	elementary	\N	\N	\N
962	I want to go, but I can't find my keys.	but	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:55.92089	2025-07-09 13:29:12.693097	我想走，但是我找不到我的钥匙。	AI generated	elementary	\N	\N	\N
968	She's a genius and a very fast runner in our school.	genius	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.40544	2025-07-09 13:29:15.885061	她是天才，也是我们学校跑得最快的人。	AI generated	elementary	\N	\N	\N
970	Did you hear his silly remark about my old fifty cent coin?	remark	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.405443	2025-07-09 13:29:15.885063	你听到他对我那枚旧的五毛钱硬币说的傻话了吗？	AI generated	elementary	\N	\N	\N
972	The fine silver wire was used to make a small birdcage.	fine	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.405447	2025-07-09 13:29:15.885064	那种细细的银线被用来做一个小鸟笼。	AI generated	elementary	\N	\N	\N
985	My best memory from when I was nine was winning the spelling game.	memory	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.707525	2025-07-09 13:29:19.291414	我九岁时最美好的回忆是赢了拼写游戏。	AI generated	elementary	\N	\N	\N
988	The whole movie was short, only about six minutes long.	whole	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.707531	2025-07-09 13:29:21.706942	整部电影很短，只有大约六分钟。	AI generated	elementary	\N	\N	\N
1007	My mom asked me to clean the dishes; it was a simple task.	clean	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.429716	2025-07-09 13:41:46.265163	我妈妈让我洗碗，这是个简单的任务。	AI generated	elementary	\N	\N	\N
1009	If you look within yourself, you'll find the answer.	within	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.441636	2025-07-09 13:41:46.265168	如果你看看你的内心，你就能找到答案。	AI generated	elementary	\N	\N	\N
1011	I retain what I type when I take notes.	retain	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.44164	2025-07-09 13:41:46.265169	我做笔记的时候，打字能让我记住内容。	AI generated	elementary	\N	\N	\N
1013	The wax was used to prevent the vice from scratching the table.	wax	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.444466	2025-07-09 13:41:46.26517	用蜡是为了防止夹钳刮伤桌子。	AI generated	elementary	\N	\N	\N
1015	Happiness is rich within your heart, not your wallet.	within	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.444469	2025-07-09 13:41:46.265173	快乐藏在你的心里，而不是钱包里。	AI generated	elementary	\N	\N	\N
1017	The dog got sick after eating a block of wax.	wax	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.450245	2025-07-09 13:41:46.265174	狗狗吃了一块蜡后生病了。	AI generated	elementary	\N	\N	\N
1019	My mom put her purse on the shelf when she got home.	purse	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.472057	2025-07-09 13:41:46.265175	我妈妈回家后把她的钱包放在了架子上。	AI generated	elementary	\N	\N	\N
1021	Our new house in the suburb has a shelf for my books.	suburb	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.48537	2025-07-09 13:41:46.265176	我们在郊区的新房子里有一个放我书的书架。	AI generated	elementary	\N	\N	\N
1023	The spilled coffee on the saucer put me in a bad mood.	saucer	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.485373	2025-07-09 13:41:46.265177	碟子上洒出的咖啡让我心情不好。	AI generated	elementary	\N	\N	\N
1025	People like living in the suburb because it's quiet.	suburb	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.485376	2025-07-09 13:41:46.265177	人们喜欢住在郊区，因为那里很安静。	AI generated	elementary	\N	\N	\N
1027	The saucer shook when the tram went by.	saucer	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.49	2025-07-09 13:41:49.849666	当电车经过时，茶托摇晃了一下。	AI generated	elementary	\N	\N	\N
1029	They planted a pine tree near the finish line.	finish	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:57.490003	2025-07-09 13:41:49.849671	他们在终点线附近种了一棵松树。	AI generated	elementary	\N	\N	\N
1043	I can spell the word if you write it on the log.	spell	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.172512	2025-07-09 13:41:49.849671	如果你把这个词写在木头上，我就能拼写出来。	AI generated	elementary	\N	\N	\N
1045	They ate all the green grapes on the small island.	grapes	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.177661	2025-07-09 13:41:49.849672	他们吃掉了小岛上所有的绿色葡萄。	AI generated	elementary	\N	\N	\N
997	Watch the bright kite slide down the string; it's so fun!	slide	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.905928	2025-07-09 13:29:24.395149	看那鲜艳的风筝沿着线滑下来，真好玩！	AI generated	elementary	\N	\N	\N
999	I can undo the bottle cap to pour more juice.	juice	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.905932	2025-07-09 13:29:24.395154	我可以拧开瓶盖来倒更多的果汁。	AI generated	elementary	\N	\N	\N
1001	During the war, people often used old cloth for many things.	war	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:36:56.905935	2025-07-09 13:29:24.395155	在战争期间，人们经常用旧布做很多东西。	AI generated	elementary	\N	\N	\N
1048	Her smile was as sweet as the grapes from the vine.	smile	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.181886	2025-07-09 13:41:49.849673	她的笑容像葡萄藤上的葡萄一样甜美。	AI generated	elementary	\N	\N	\N
1088	I used my camera to take a photo of the painted strip on the wall.	camera	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.477367	2025-07-09 13:42:00.985208	我用相机拍了一张墙上涂的条纹照片。	AI generated	intermediate	\N	\N	\N
1050	The system works in the usual way we learned.	system	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.181889	2025-07-09 13:41:49.849674	这个系统按照我们学过的通常方式运行。	AI generated	elementary	\N	\N	\N
1092	The scary movie gave me a bad nerve and made the vein in my neck throb.	nerve	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.716558	2025-07-09 13:42:00.985209	那部恐怖电影让我很紧张，脖子上的血管都跳起来了。	AI generated	intermediate	\N	\N	\N
1052	I hope I can spell the name of the horse.	horse	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.181893	2025-07-09 13:41:49.849674	我希望我能拼写出那匹马的名字。	AI generated	elementary	\N	\N	\N
1054	Let's create an oral story together after school.	create	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.181896	2025-07-09 13:41:49.849675	放学后我们一起编一个口头故事吧。	AI generated	elementary	\N	\N	\N
1056	Let's talk about the flowers in the pot.	pot	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.851044	2025-07-09 13:41:49.849675	我们来聊聊花盆里的花吧。	AI generated	elementary	\N	\N	\N
1058	The dull movie made me talk too much.	dull	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.855379	2025-07-09 13:41:49.849676	无聊的电影让我说了很多话。	AI generated	elementary	\N	\N	\N
1060	That pot is full of pretty flowers.	pot	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.855383	2025-07-09 13:41:53.942548	那个罐子里装满了漂亮的花。	AI generated	elementary	\N	\N	\N
1062	The dull rock fell to the ground.	dull	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.855386	2025-07-09 13:41:53.942552	那块灰暗的石头掉到了地上。	AI generated	elementary	\N	\N	\N
1064	A lot of leaves are on the ground.	ground	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.85539	2025-07-09 13:41:53.942553	地上有很多树叶。	AI generated	elementary	\N	\N	\N
1066	I like to talk when I eat candy.	candy	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:00.855393	2025-07-09 13:41:53.942554	我喜欢吃糖的时候说话。	AI generated	elementary	\N	\N	\N
1068	The writer needs a plug for his computer.	writer	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.006483	2025-07-09 13:41:53.942555	作家需要一个电脑插头。	AI generated	elementary	\N	\N	\N
1070	The writer, deaf since birth, uses a special keyboard.	writer	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.013569	2025-07-09 13:41:53.942555	这位作家，生来就听不见，使用一种特别的键盘。	AI generated	elementary	\N	\N	\N
1072	Oh my god, please open the door!	god	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.021152	2025-07-09 13:41:53.942556	哦，我的天啊，请开门！	AI generated	elementary	\N	\N	\N
1074	My mom helps the deaf children at school.	mom	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.021156	2025-07-09 13:41:53.942557	我妈妈在学校帮助听不见的小朋友。	AI generated	elementary	\N	\N	\N
1076	I am sorry, but I ate a piece of your cake.	sorry	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.02116	2025-07-09 13:41:53.942557	对不起，我吃了一块你的蛋糕。	AI generated	elementary	\N	\N	\N
1078	Can you move that piece of paper, please?	move	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.023857	2025-07-09 13:41:53.942558	你能把那张纸移开吗？	AI generated	elementary	\N	\N	\N
1080	I used a tack to hold the velvet fabric in place while I sewed.	tack	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.466881	2025-07-09 13:42:00.9852	我用一个图钉把天鹅绒布固定住，这样缝的时候就不会跑了。	AI generated	elementary	\N	\N	\N
1082	The funny dog hid in the garage during the storm.	garage	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.474586	2025-07-09 13:42:00.985206	那只搞笑的狗狗在暴风雨的时候躲在车库里。	AI generated	elementary	\N	\N	\N
1084	The colorful strip of tape was stuck to the bottom of the box.	bottom	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.47459	2025-07-09 13:42:00.985206	那条彩色的胶带粘在了箱子的底部。	AI generated	elementary	\N	\N	\N
1086	I will pick you to be the hero of our play.	pick	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.477363	2025-07-09 13:42:00.985207	我会选你来当我们的戏剧英雄。	AI generated	elementary	\N	\N	\N
1090	The scout made toast over the campfire.	scout	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.47737	2025-07-09 13:42:00.985209	那个童子军在篝火上烤面包。	AI generated	elementary	\N	\N	\N
1094	I saw a blue vein on top of the delicious cake.	vein	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.728843	2025-07-09 13:42:00.98521	我在美味的蛋糕上看到了一条蓝色的纹路。	AI generated	elementary	\N	\N	\N
1096	The lip gloss box had a gender symbol on the label.	lip	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.731458	2025-07-09 13:42:00.98521	唇彩盒子的标签上有一个性别符号。	AI generated	elementary	\N	\N	\N
1099	It was the tenth time the car ran out of gas.	tenth	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.731463	2025-07-09 13:42:00.985211	这是汽车第十次没油了。	AI generated	elementary	\N	\N	\N
1101	The movie about the pirate showed people of every gender.	pirate	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.736523	2025-07-09 13:42:04.792397	关于海盗的电影里，有各种各样的人，有男的也有女的。	AI generated	elementary	\N	\N	\N
1103	He checked the gas tank to make sure it was proper.	proper	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:01.736527	2025-07-09 13:42:04.792402	他检查了油箱，看看是不是没问题。	AI generated	elementary	\N	\N	\N
1105	I will sew the sand-filled bag closed so it does not leak.	sew	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:03.712974	2025-07-09 13:42:04.792403	我会把装满沙子的袋子缝起来，这样沙子就不会漏出来了。	AI generated	elementary	\N	\N	\N
1107	The clock made a loud tick in front of his face.	face	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:03.720524	2025-07-09 13:42:04.792403	钟在他面前发出很大的滴答声。	AI generated	elementary	\N	\N	\N
1109	Her soft silk scarf brushed against her face gently.	silk	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:03.732267	2025-07-09 13:42:04.792404	她柔软的丝绸围巾轻轻地拂过她的脸。	AI generated	elementary	\N	\N	\N
1111	I yell when I see sand in my soup, it is gross!	sand	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:03.732271	2025-07-09 13:42:04.792405	当我在汤里看到沙子时，我会大叫，太恶心了！	AI generated	elementary	\N	\N	\N
1113	The antique clock was wrapped in old silk to protect it.	silk	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:03.732275	2025-07-09 13:42:04.792405	古老的钟被旧丝绸包起来， чтобы 保护它。	AI generated	elementary	\N	\N	\N
1115	Let's skip down to the nurse's office to get a bandage.	skip	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:03.732278	2025-07-09 13:42:04.792406	我们跳着去护士办公室拿绷带吧。	AI generated	elementary	\N	\N	\N
1117	There is a large gap in the data, so the report is incomplete.	data	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.222835	2025-07-09 13:42:04.792406	数据里有一个很大的空缺，所以报告不完整。	AI generated	elementary	\N	\N	\N
1119	I regard the ducks in the pond as my friends.	regard	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.234612	2025-07-09 13:42:04.792407	我把池塘里的鸭子当成我的朋友。	AI generated	elementary	\N	\N	\N
1121	Please close the door after the soccer match ends.	close	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.234616	2025-07-09 13:42:08.171764	足球比赛结束后，请把门关上。	AI generated	elementary	\N	\N	\N
1123	I accidentally rip the paper when I read the text.	rip	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.23462	2025-07-09 13:42:08.171769	我读课文的时候，不小心把纸弄破了。	AI generated	elementary	\N	\N	\N
1125	The little boy loved the funny animal story about the zoo.	zoo	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.234623	2025-07-09 13:42:08.17177	那个小男孩很喜欢关于动物园的有趣动物故事。	AI generated	elementary	\N	\N	\N
1127	More data helps me understand the text better.	text	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.234627	2025-07-09 13:42:08.171771	更多的数据能帮助我更好地理解课文。	AI generated	elementary	\N	\N	\N
1129	The clumsy thief didn't make a profit from the jewelry store.	thief	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.758576	2025-07-09 13:42:08.171771	那个笨手笨脚的小偷没有从珠宝店赚到钱。	AI generated	elementary	\N	\N	\N
1131	The key to starting a fire is dry wood and a little patience.	fire	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.763965	2025-07-09 13:42:08.171772	生火的诀窍是干燥的木头和一点耐心。	AI generated	elementary	\N	\N	\N
1133	Exercises vary, but they all help build muscle.	vary	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.763968	2025-07-09 13:42:08.171772	锻炼的方式有很多种，但它们都能帮助你锻炼肌肉。	AI generated	elementary	\N	\N	\N
1135	The crab turned bright red in the hot sun.	crab	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.768358	2025-07-09 13:42:08.171773	那只螃蟹在炎热的太阳下变成了鲜红色。	AI generated	elementary	\N	\N	\N
1137	He worked hard to build muscle and increase his profit.	profit	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.768362	2025-07-09 13:42:08.171774	他努力锻炼肌肉，并增加他的收入。	AI generated	elementary	\N	\N	\N
1139	The designs on the old key vary greatly.	key	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.768365	2025-07-09 13:42:08.171774	老钥匙上的图案差别很大。	AI generated	elementary	\N	\N	\N
1141	He put his warm socks inside his steel-toed boots before going to work.	socks	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.943711	2025-07-09 13:42:11.462295	他上班前把暖和的袜子放进了钢头靴子里。	AI generated	elementary	\N	\N	\N
1143	The small child hid his favorite stuffed animal inside the trunk with his socks.	socks	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.950073	2025-07-09 13:42:11.462299	小孩子把最喜欢的毛绒玩具和袜子一起藏在了箱子里。	AI generated	elementary	\N	\N	\N
1145	Staying inside is the safe option during the thunderstorm.	safe	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.955293	2025-07-09 13:42:11.462299	雷雨天待在室内是安全的选择。	AI generated	elementary	\N	\N	\N
1147	The safe's combination lock played a little jazz tune when opened.	safe	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.955297	2025-07-09 13:42:11.4623	保险箱的密码锁打开时会播放一段爵士乐。	AI generated	elementary	\N	\N	\N
1149	The magician showed a magic trick, pulling a rabbit from the old wooden trunk.	trunk	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.955301	2025-07-09 13:42:11.4623	魔术师表演了一个魔术，从旧木箱里拉出了一只兔子。	AI generated	elementary	\N	\N	\N
1151	The train's seat was cold steel on a winter morning.	steel	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.959717	2025-07-09 13:42:11.462301	冬天早上，火车的座位是冰冷的钢铁。	AI generated	elementary	\N	\N	\N
1153	The two brothers look very alike, and the waiter thought they were twins.	waiter	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.972246	2025-07-09 13:42:11.462301	两兄弟长得很像，服务员以为他们是双胞胎。	AI generated	elementary	\N	\N	\N
1155	To insult him after thirty long years of service was just wrong.	insult	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.986015	2025-07-09 13:42:11.462302	在他服务了三十年后侮辱他是不对的。	AI generated	elementary	\N	\N	\N
1157	I need to hurry and watch the sun rise over the mountain.	rise	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.986018	2025-07-09 13:42:11.462302	我得赶紧去看太阳从山上出来。	AI generated	elementary	\N	\N	\N
1159	The model had to hurry because she was late for the show.	model	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.986021	2025-07-09 13:42:11.462303	模特必须赶紧，因为她演出要迟到了。	AI generated	elementary	\N	\N	\N
1161	Don't insult the cook, or he will hurry your food!	insult	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.986025	2025-07-09 13:42:15.037159	不要侮辱厨师，不然他会很快做好你的饭！（可能不好吃哦！）	AI generated	elementary	\N	\N	\N
1163	We will march if you switch off the music.	march	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:04.986028	2025-07-09 13:42:15.037163	如果你关掉音乐，我们就要游行了。	AI generated	elementary	\N	\N	\N
1165	The crowd loved the ride on the roller coaster.	crowd	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:05.81809	2025-07-09 13:42:15.037164	人群很喜欢坐过山车。	AI generated	elementary	\N	\N	\N
1167	The vowel 'a' has less weight in that word.	vowel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:05.821928	2025-07-09 13:42:15.037165	字母“a”在那个单词里不太重要。	AI generated	elementary	\N	\N	\N
1169	It was so nice of her to carry the weight for me.	nice	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:05.821933	2025-07-09 13:42:15.037165	她帮我拿东西，真是太好了。	AI generated	elementary	\N	\N	\N
1171	The lawyer explained the vowel sounds in the contract.	vowel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:05.821936	2025-07-09 13:42:15.037166	律师解释了合同里的元音发音。	AI generated	elementary	\N	\N	\N
1173	The expert helped clean the spill very quickly.	expert	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:05.82194	2025-07-09 13:42:15.037167	专家很快就帮忙清理了洒出来的东西。	AI generated	elementary	\N	\N	\N
1175	A single tear added more weight to the sad moment.	tear	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:05.821943	2025-07-09 13:42:15.037167	一滴眼泪让这个悲伤的时刻更沉重了。	AI generated	elementary	\N	\N	\N
1177	Please buy a pint of milk; the volume in the carton is low.	pint	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.202521	2025-07-09 13:42:15.037168	请买一品脱牛奶；牛奶盒里的牛奶不多了。	AI generated	elementary	\N	\N	\N
1179	The real problem is that things are getting worse every day.	real	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.20253	2025-07-09 13:42:15.037169	真正的问题是事情每天都在变得更糟。	AI generated	elementary	\N	\N	\N
1181	Thank you for the gift, or would you like it back?	thank	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.202534	2025-07-09 13:42:18.612595	谢谢你的礼物，或者你想把它要回去吗？	AI generated	elementary	\N	\N	\N
1215	The farmer had to stall his work to clean up the trash that blew into his field.	stall	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.49746	2025-07-09 13:42:21.710108	农民不得不停下工作，清理吹到他田里的垃圾。	AI generated	intermediate	\N	\N	\N
1183	It is likely you'll need an eraser to fix your mistakes.	likely	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.202539	2025-07-09 13:42:18.6126	你可能需要一块橡皮擦来改正你的错误。	AI generated	elementary	\N	\N	\N
1185	This lock is super strong, so your bike is safe now.	lock	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.202543	2025-07-09 13:42:18.612601	这个锁非常结实，所以你的自行车现在安全了。	AI generated	elementary	\N	\N	\N
1187	Do you want a blue one or a pink one?	or	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.202547	2025-07-09 13:42:18.612602	你想要蓝色的还是粉色的？	AI generated	elementary	\N	\N	\N
1189	The sunset was a vivid orange and red, hanging low in the sky.	vivid	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.227165	2025-07-09 13:42:18.612602	日落是鲜艳的橙色和红色，挂在低低的天空中。	AI generated	elementary	\N	\N	\N
1191	The public sign was blank, so we didn't know which way to go.	blank	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.233617	2025-07-09 13:42:18.612603	公共标志是空白的，所以我们不知道该往哪走。	AI generated	elementary	\N	\N	\N
1193	The jewelry case had a beautiful swan on top of it.	case	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.235848	2025-07-09 13:42:18.612603	珠宝盒的顶上有一只美丽的 Swan (天鹅)。	AI generated	elementary	\N	\N	\N
1195	The pipes were frozen, so we need to mend them quickly.	frozen	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.239363	2025-07-09 13:42:18.612604	水管冻住了，所以我们需要尽快修理好它们。	AI generated	elementary	\N	\N	\N
1197	I got forty dollars off at the sale today!	forty	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.241411	2025-07-09 13:42:18.612605	我今天在打折的时候省了四十美元！	AI generated	elementary	\N	\N	\N
1199	The sun is out so the park is full of public enjoyment.	sun	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.243953	2025-07-09 13:42:18.612605	太阳出来了，所以公园里到处都是人，大家都很开心。	AI generated	elementary	\N	\N	\N
1201	The fierce dog was bold and barked loudly at the mailman.	fierce	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.436212	2025-07-09 13:42:21.7101	凶猛的狗很勇敢，对着邮递员大声叫。	AI generated	elementary	\N	\N	\N
1203	They rowed badly and lost the boat race to the other team.	badly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.440891	2025-07-09 13:42:21.710104	他们划船划得很差，输掉了和另一队的赛艇比赛。	AI generated	elementary	\N	\N	\N
1205	I would never regret sharing my toys with my friends.	would	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.447324	2025-07-09 13:42:21.710105	我永远不会后悔和朋友们分享我的玩具。	AI generated	elementary	\N	\N	\N
1207	The cat has a funny tongue and a bell on its ring.	ring	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.451751	2025-07-09 13:42:21.710105	这只猫有个有趣的舌头，它的铃铛在它的圈上。	AI generated	elementary	\N	\N	\N
1209	My dad calls me Nut by my first name.	nut	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.451754	2025-07-09 13:42:21.710106	我爸爸叫我 Nut，用我的名字叫我。	AI generated	elementary	\N	\N	\N
1211	He used a rope to tie the broken pipe together.	rope	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.451757	2025-07-09 13:42:21.710106	他用绳子把坏掉的管子绑在一起。	AI generated	elementary	\N	\N	\N
1213	We need to reform the way we handle the trash in our neighborhood.	trash	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.493755	2025-07-09 13:42:21.710107	我们需要改变处理我们社区垃圾的方式。	AI generated	elementary	\N	\N	\N
1217	An ideal camping spot would be a clean one, not dirty like this.	ideal	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.497463	2025-07-09 13:42:21.710108	理想的露营地应该是干净的，而不是像这里这样脏。	AI generated	elementary	\N	\N	\N
1219	I would rather paint the room blue than purple.	rather	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.497466	2025-07-09 13:42:21.710109	我宁愿把房间刷成蓝色，也不要刷成紫色。	AI generated	elementary	\N	\N	\N
1221	The ideal solution is to put the trash in the bin.	ideal	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.501054	2025-07-09 13:42:25.28924	最好的办法是把垃圾扔进垃圾桶里。	AI generated	elementary	\N	\N	\N
1223	My grandma uses her tablet to read books in her rural home.	tablet	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:08.501058	2025-07-09 13:42:25.289243	我的奶奶用她的平板电脑在乡下家里看书。	AI generated	elementary	\N	\N	\N
1225	I saw the rescue dog take a walk after a long day.	rescue	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.278488	2025-07-09 13:42:25.289244	我看到那只被救的狗狗在漫长的一天后散步。	AI generated	elementary	\N	\N	\N
1227	After a shower, I used a soft towel and watched the moon's orbit.	towel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.284814	2025-07-09 13:42:25.289244	洗完澡后，我用柔软的毛巾擦干身体，然后看月亮的轨道。	AI generated	elementary	\N	\N	\N
1229	The bird flew free after I dried it with a warm towel.	towel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.294462	2025-07-09 13:42:25.289245	我用温暖的毛巾把小鸟擦干后，它就自由地飞走了。	AI generated	elementary	\N	\N	\N
1231	The firefighters rescue the cat from the crowded building.	rescue	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.294465	2025-07-09 13:42:25.289245	消防员们从拥挤的建筑物里救出了猫。	AI generated	elementary	\N	\N	\N
1233	I used a fluffy towel to dry off after I awake.	towel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.294469	2025-07-09 13:42:25.289246	我醒来后，用蓬松的毛巾擦干身体。	AI generated	elementary	\N	\N	\N
1235	My mom gave me advice on how to handle a large task.	advice	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.294472	2025-07-09 13:42:25.289246	我妈妈给了我关于如何处理大任务的建议。	AI generated	elementary	\N	\N	\N
1237	It is unlike my brother to give a good reason.	unlike	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.632596	2025-07-09 13:42:25.289247	我的哥哥不太可能给出好的理由。	AI generated	elementary	\N	\N	\N
1239	The twin sisters are highly skilled at drawing.	twin	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.637535	2025-07-09 13:42:25.289247	这对双胞胎姐妹非常擅长画画。	AI generated	elementary	\N	\N	\N
1241	He felt stress when he had food in his mouth.	mouth	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.644665	2025-07-09 13:42:28.041496	他嘴里有食物的时候，感觉很紧张。	AI generated	elementary	\N	\N	\N
1243	The food will vanish quickly from her hungry mouth.	vanish	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.644669	2025-07-09 13:42:28.041502	食物会很快从她饥饿的嘴里消失。	AI generated	elementary	\N	\N	\N
1245	The thin fog will vanish in the bright sunshine.	thin	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.644672	2025-07-09 13:42:28.041503	薄雾会在明亮的阳光下消失。	AI generated	elementary	\N	\N	\N
1247	My twin brother enjoyed playing in the youth group.	youth	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:09.644675	2025-07-09 13:42:28.041504	我的双胞胎弟弟喜欢在青少年团体里玩。	AI generated	elementary	\N	\N	\N
1249	The simple tent has a pole to hold it up.	simple	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.301246	2025-07-09 13:42:28.041505	这个简单的帐篷有一根杆子来支撑它。	AI generated	elementary	\N	\N	\N
1251	If we don't find food, we will starve in the snow.	starve	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.301254	2025-07-09 13:42:28.041506	如果我们找不到食物，我们会在雪地里饿死。	AI generated	elementary	\N	\N	\N
1253	My aunt said the snow is very pretty today.	snow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.301259	2025-07-09 13:42:28.041507	我阿姨说今天的雪很漂亮。	AI generated	elementary	\N	\N	\N
1255	If I miss the target, I might starve because hunting will be difficult.	starve	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.301263	2025-07-09 13:42:28.041508	如果我没打中目标，我可能会饿死，因为打猎会很难。	AI generated	elementary	\N	\N	\N
1257	The red dot is the target, and the blue one is mine.	target	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.301267	2025-07-09 13:42:28.041509	红点是目标，蓝点是我的。	AI generated	elementary	\N	\N	\N
1259	My favorite hobby is drawing, and I like to paint, too.	hobby	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.301271	2025-07-09 13:42:28.04151	我最喜欢的爱好是画画，我也喜欢涂色。	AI generated	elementary	\N	\N	\N
1261	The little church felt so cold inside during the winter.	church	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.668657	2025-07-09 13:42:31.681883	冬天的时候，小教堂里面感觉好冷呀。	AI generated	elementary	\N	\N	\N
1263	I gave my garden gnome a little kiss on the head.	garden	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.685267	2025-07-09 13:42:31.681888	我亲了一下我的花园小矮人的头。	AI generated	elementary	\N	\N	\N
1265	I wanted to give her a kiss goodbye.	to	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.68824	2025-07-09 13:42:31.681889	我想给她一个吻来道别。	AI generated	elementary	\N	\N	\N
1267	The police used force and a pistol to stop the robber.	pistol	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.688244	2025-07-09 13:42:31.681889	警察叔叔用武力和枪来抓住坏人。	AI generated	elementary	\N	\N	\N
1269	My finger felt very cold after playing in the snow.	finger	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.688247	2025-07-09 13:42:31.68189	在雪地里玩过后，我的手指感觉好冷。	AI generated	elementary	\N	\N	\N
1271	I need to point my finger at the correct answer.	to	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.688251	2025-07-09 13:42:31.681891	我需要用手指指出正确的答案。	AI generated	elementary	\N	\N	\N
1273	The racial divide was worsened by the manual labor camps.	racial	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.83354	2025-07-09 13:42:31.681891	因为劳动营，不同种族的人们关系变得更差了。	AI generated	elementary	\N	\N	\N
1275	The racial slurs were known to cause deep hurt.	racial	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.842926	2025-07-09 13:42:31.681892	种族歧视的话语会让人很难过。	AI generated	elementary	\N	\N	\N
1277	The chef, whom I admire, makes a delicious tomato soup.	whom	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.849548	2025-07-09 13:42:31.681892	那位我喜欢的厨师做出来的番茄汤真好喝。	AI generated	elementary	\N	\N	\N
1279	The victim wanted to invent a time machine to change the past.	victim	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.855867	2025-07-09 13:42:31.681893	受害者想发明一台时光机来改变过去。	AI generated	elementary	\N	\N	\N
1281	I want to invent a machine that makes a perfect pear pie.	pear	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.85587	2025-07-09 13:42:35.039197	我想发明一台能做出完美梨子派的机器。	AI generated	elementary	\N	\N	\N
1283	The scientist, whom everyone respected, tried to invent teleportation.	whom	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:12.855873	2025-07-09 13:42:35.039201	那位科学家，大家都尊敬他，他尝试发明瞬间移动。	AI generated	elementary	\N	\N	\N
1285	I am so tired, but I will try to finish my homework before dinner.	so	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.156723	2025-07-09 13:42:35.039202	我太累了，但我会尽量在晚饭前完成作业。	AI generated	elementary	\N	\N	\N
1287	Look on the upside, let's get ice cream after the game!	upside	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.15849	2025-07-09 13:42:35.039202	往好处想，比赛后我们去吃冰淇淋吧！	AI generated	elementary	\N	\N	\N
1289	Patience is a virtue, so we must wait our turn.	virtue	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.162124	2025-07-09 13:42:35.039203	耐心是一种美德，所以我们必须等待轮到我们。	AI generated	elementary	\N	\N	\N
1291	Don't quit now; there's still an upside to finishing the race!	quit	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.162127	2025-07-09 13:42:35.039203	现在不要放弃；完成比赛还是有好处的！	AI generated	elementary	\N	\N	\N
1293	It is a fact that our team played really well today.	team	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.162129	2025-07-09 13:42:35.039204	我们的团队今天表现得非常好，这是一个事实。	AI generated	elementary	\N	\N	\N
1295	Honesty is a virtue, and my wife always tells the truth.	virtue	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.162132	2025-07-09 13:42:35.039205	诚实是一种美德，我的妻子总是说真话。	AI generated	elementary	\N	\N	\N
1297	I felt so dizzy from hunger, I needed to eat something right away.	hunger	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.57072	2025-07-09 13:42:35.039205	我饿得头晕，我需要马上吃点东西。	AI generated	elementary	\N	\N	\N
1300	The animal fell into a trap, but the farmers kept their barn stable.	trap	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.581289	2025-07-09 13:42:35.039206	动物掉进了一个陷阱，但农民们保持了他们的谷仓稳定。	AI generated	elementary	\N	\N	\N
1302	I told them not to snap the twig!	them	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.584271	2025-07-09 13:42:39.034129	我告诉他们不要弄断树枝！	AI generated	elementary	\N	\N	\N
1304	The old barn is stable yet, but for how much longer?	yet	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.584274	2025-07-09 13:42:39.034133	那个旧谷仓现在还很结实，但是还能撑多久呢？	AI generated	elementary	\N	\N	\N
1306	Too much rice can make me feel dizzy.	rice	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.584276	2025-07-09 13:42:39.034134	吃太多米饭会让我觉得头晕。	AI generated	elementary	\N	\N	\N
1308	The actress wore a dress with beautiful lace on stage.	stage	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:13.584279	2025-07-09 13:42:39.034135	那个女演员在舞台上穿了一件带着漂亮蕾丝的裙子。	AI generated	elementary	\N	\N	\N
1310	We sat at the table near the stream to eat our lunch.	stream	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:14.369937	2025-07-09 13:42:39.034135	我们坐在小溪边的桌子旁吃午饭。	AI generated	elementary	\N	\N	\N
1312	The warm tea on the table made me feel better.	warm	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:14.379473	2025-07-09 13:42:39.034136	桌子上热热的茶让我感觉好多了。	AI generated	elementary	\N	\N	\N
1314	I hope my new shoe brings me good luck!	shoe	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:14.379476	2025-07-09 13:42:39.034137	我希望我的新鞋能给我带来好运！	AI generated	elementary	\N	\N	\N
1316	From my window, I view a woman playing the violin.	violin	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:14.379479	2025-07-09 13:42:39.034137	从我的窗户，我看到一个女人在拉小提琴。	AI generated	elementary	\N	\N	\N
1318	The flowers grow on the vine, so I'll order some.	vine	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:14.379482	2025-07-09 13:42:39.034138	花儿长在葡萄藤上，所以我要订购一些。	AI generated	elementary	\N	\N	\N
1320	I have to use a spoon to eat my cereal.	spoon	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:14.384702	2025-07-09 13:42:39.034138	我得用勺子吃我的麦片。	AI generated	elementary	\N	\N	\N
1322	The slim new brand of phone fits perfectly in my pocket.	slim	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:15.657738	2025-07-09 13:42:42.345832	这个又薄又新的手机正好放进我的口袋里。	AI generated	elementary	\N	\N	\N
1324	The bronze statue has a small chip on its ear.	statue	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:15.669335	2025-07-09 13:42:42.345836	这个青铜雕像的耳朵上有一小块缺口。	AI generated	elementary	\N	\N	\N
1326	A slim layer of butter was spread on the toast.	slim	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:15.669339	2025-07-09 13:42:42.345836	烤面包上涂了一层薄薄的黄油。	AI generated	elementary	\N	\N	\N
1328	The science class kept the small plant alive.	class	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:15.669343	2025-07-09 13:42:42.345837	科学课上，我们让这棵小植物活了下来。	AI generated	elementary	\N	\N	\N
1330	My ear got cold, so I put on my warm gloves.	ear	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:15.672633	2025-07-09 13:42:42.345838	我的耳朵很冷，所以我戴上了暖和的手套。	AI generated	elementary	\N	\N	\N
1332	There is a danger sign at the construction site.	danger	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:15.672637	2025-07-09 13:42:42.345838	建筑工地有一个危险标志。	AI generated	elementary	\N	\N	\N
1334	I learned a valuable lesson via online courses this year.	lesson	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.586852	2025-07-09 13:42:42.345839	今年我通过在线课程学到了宝贵的一课。	AI generated	elementary	\N	\N	\N
1336	The tiny kitten died because of a lack of food.	tiny	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.591586	2025-07-09 13:42:42.34584	这只小猫因为缺少食物而死了。	AI generated	elementary	\N	\N	\N
1338	I serve chicken with a special spice blend.	serve	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.604182	2025-07-09 13:42:42.34584	我用一种特别的香料混合物来做鸡肉。	AI generated	elementary	\N	\N	\N
1340	We ate a big carrot at the summer camp.	camp	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.604186	2025-07-09 13:42:42.345841	我们在夏令营吃了一根大胡萝卜。	AI generated	elementary	\N	\N	\N
1342	I packed my favorite jeans for the summer camp.	camp	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.604189	2025-07-09 13:42:45.984506	我为夏令营打包了我最喜欢的牛仔裤。	AI generated	elementary	\N	\N	\N
1344	The tiny ant lived a long term in his colony.	tiny	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.604192	2025-07-09 13:42:45.984509	这只小蚂蚁在他的蚁群里住了很久。	AI generated	elementary	\N	\N	\N
1346	The little wooden train has a motor that makes it go fast.	wooden	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.630557	2025-07-09 13:42:45.98451	这个小木头火车有一个马达，让它跑得很快。	AI generated	elementary	\N	\N	\N
1348	He won the sports trophy this year for running very fast.	year	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.636154	2025-07-09 13:42:45.984511	他今年因为跑得非常快而赢得了运动奖杯。	AI generated	elementary	\N	\N	\N
1350	In winter, I put on my coat and warm hat.	winter	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.643562	2025-07-09 13:42:45.984511	冬天，我穿上外套和暖和的帽子。	AI generated	elementary	\N	\N	\N
1352	I saw a cute seal at the big mall downtown yesterday.	seal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.645486	2025-07-09 13:42:45.984512	昨天我在市中心的大商场看到了一只可爱的海豹。	AI generated	elementary	\N	\N	\N
1354	The old pirate tale told of a secret treasure plan.	tale	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.645489	2025-07-09 13:42:45.984513	古老的关于海盗的故事讲述了一个秘密的宝藏计划。	AI generated	elementary	\N	\N	\N
1356	The toy car with a motor is for sale at the mall.	motor	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:16.645492	2025-07-09 13:42:45.984513	带有马达的玩具车在商场出售。	AI generated	elementary	\N	\N	\N
1370	The friendly dog waited in a polite manner outside the house.	manner	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.783033	2025-07-09 13:42:45.984514	友好的狗狗很有礼貌地在房子外面等着。	AI generated	elementary	\N	\N	\N
1408	The tired wizard put on his robe and began to act like he was sleeping.	act	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.753348	2025-07-09 13:42:52.55162	疲惫的巫师穿上他的长袍，开始装睡。	AI generated	intermediate	\N	\N	\N
1372	The chef hoped his delicious roast would bring him fame.	roast	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.790019	2025-07-09 13:42:45.984515	厨师希望他美味的烤肉能给他带来名声。	AI generated	elementary	\N	\N	\N
1374	She packed a small sac filled with yogurt for her lunch.	yogurt	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.802288	2025-07-09 13:42:49.329962	她为午餐准备了一个装满酸奶的小袋子。	AI generated	elementary	\N	\N	\N
1376	The little girl found an orange in her lunch sac.	sac	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.802292	2025-07-09 13:42:49.329966	小女孩在她的午餐袋里发现了一个橙子。	AI generated	elementary	\N	\N	\N
1378	He showed me the proper manner to prepare the roast.	manner	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.802295	2025-07-09 13:42:49.329967	他教我准备烤肉的正确方法。	AI generated	elementary	\N	\N	\N
1380	The bank gave them a severe warning about the overdue loan.	severe	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:17.802298	2025-07-09 13:42:49.329968	银行就逾期贷款向他们发出了严厉警告。	AI generated	elementary	\N	\N	\N
1382	Even though it's small, the colorful poster makes me happy.	though	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:18.524356	2025-07-09 13:42:49.329968	即使它很小，这张彩色的海报也让我开心。	AI generated	elementary	\N	\N	\N
1384	The poster showed a big red arrow pointing north.	north	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:18.534297	2025-07-09 13:42:49.329969	海报上画着一个指向北方的大红色箭头。	AI generated	elementary	\N	\N	\N
1386	I felt sleepy and had a pain in my head.	sleepy	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:18.534301	2025-07-09 13:42:49.32997	我感到困倦，而且头疼。	AI generated	elementary	\N	\N	\N
1388	That store sells toys retail and is widely known.	retail	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:18.534304	2025-07-09 13:42:49.32997	那家商店零售玩具，而且广为人知。	AI generated	elementary	\N	\N	\N
1390	The cat put its paw on the film of dust.	paw	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:18.540908	2025-07-09 13:42:49.329971	猫把爪子放在一层灰尘上。	AI generated	elementary	\N	\N	\N
1392	Even though it was broken, I used the blue crayon.	though	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:18.540912	2025-07-09 13:42:49.329972	即使它坏了，我也用了那支蓝色的蜡笔。	AI generated	elementary	\N	\N	\N
1394	The device helps us explore the world around us.	world	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:19.376893	2025-07-09 13:42:52.551615	这个设备帮助我们探索周围的世界。	AI generated	elementary	\N	\N	\N
1396	The ghost didn't scare anyone, t was just a sheet.	ghost	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:19.385592	2025-07-09 13:42:52.551617	那个鬼没有吓到任何人，它只是一块布。	AI generated	elementary	\N	\N	\N
1400	I hope I win, t would be great.	win	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:19.391359	2025-07-09 13:42:52.551618	我希望我能赢，那太棒了。	AI generated	elementary	\N	\N	\N
1402	Eighty dollars is a lot for the tenant to pay.	eighty	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:19.391363	2025-07-09 13:42:52.551618	八十美元对租户来说是一大笔钱。	AI generated	elementary	\N	\N	\N
1404	The ripe mango fell upon the table.	mango	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:19.397631	2025-07-09 13:42:52.551619	成熟的芒果掉到了桌子上。	AI generated	elementary	\N	\N	\N
1406	The sun can damage your skin, so you should act carefully outside.	skin	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.747232	2025-07-09 13:42:52.551619	太阳会伤害你的皮肤，所以你在外面要小心。	AI generated	elementary	\N	\N	\N
1410	The bright yellow lemon stained the silk robe a funny color.	robe	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.760487	2025-07-09 13:42:52.55162	明亮的黄色柠檬把丝绸长袍染成了奇怪的颜色。	AI generated	elementary	\N	\N	\N
1412	I own a red hat that keeps the sun out of my eyes.	own	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.763684	2025-07-09 13:42:52.55162	我有一顶红色的帽子，可以遮挡阳光。	AI generated	elementary	\N	\N	\N
1414	I use a clean brush to remove dust from the old rent books.	brush	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.763688	2025-07-09 13:42:52.551621	我用干净的刷子清除旧租书上的灰尘。	AI generated	elementary	\N	\N	\N
1416	It is important to act responsibly if you cannot pay your rent.	act	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.76627	2025-07-09 13:42:55.344615	如果你付不起房租，负责任地处理很重要。	AI generated	elementary	\N	\N	\N
1418	Please write about the main issue with pencil marks on the wall.	issue	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.781903	2025-07-09 13:42:55.344617	请写一下墙上铅笔印的主要问题。	AI generated	elementary	\N	\N	\N
1420	Can I borrow your cooking oil for this recipe?	your	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.788514	2025-07-09 13:42:55.344618	我能借你的食用油来做这个菜谱吗？	AI generated	elementary	\N	\N	\N
1422	Peace is here if we all try to be kind.	peace	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.795117	2025-07-09 13:42:55.344618	如果我们都努力友善，和平就在这里。	AI generated	elementary	\N	\N	\N
1424	The brown paper bag had a stain of oil on it.	brown	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.795121	2025-07-09 13:42:55.344618	棕色的纸袋上有一块油渍。	AI generated	elementary	\N	\N	\N
1426	The test result was not good because I forgot my pencil.	result	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.795124	2025-07-09 13:42:55.344619	考试结果不好，因为我忘了带铅笔。	AI generated	elementary	\N	\N	\N
1428	The teacher spoke loudly here so everyone could hear.	loudly	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:20.795127	2025-07-09 13:42:55.344619	老师在这里大声说话，这样每个人都能听到。	AI generated	elementary	\N	\N	\N
1430	I am very hungry and don't have any spare money for lunch.	hungry	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:21.247924	2025-07-09 13:42:55.34462	我非常饿，而且没有多余的钱买午饭。	AI generated	elementary	\N	\N	\N
1432	The general had the rank of major and a spare uniform.	rank	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:21.252112	2025-07-09 13:42:55.34462	这位将军的军衔是少校，还有一套备用制服。	AI generated	elementary	\N	\N	\N
1434	I like the smell of cold cola in a glass bottle.	smell	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:21.252116	2025-07-09 13:42:55.34462	我喜欢玻璃瓶里冰镇可乐的味道。	AI generated	elementary	\N	\N	\N
1436	My teacher is very strict, but gives us spare time sometimes.	strict	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:21.256428	2025-07-09 13:42:58.658818	我的老师很严格，但有时候会给我们空闲时间。	AI generated	elementary	\N	\N	\N
1438	We are under very strict rules at school this year.	under	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:21.256432	2025-07-09 13:42:58.658822	今年我们在学校里要遵守非常严格的规定。	AI generated	elementary	\N	\N	\N
1440	Because of my strict diet, I worry about my height.	strict	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:21.256435	2025-07-09 13:42:58.658822	因为我严格控制饮食，所以我担心我的身高。	AI generated	elementary	\N	\N	\N
1442	The detective watched the whole series as a cold settled on his nose.	series	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:21.990092	2025-07-09 13:42:58.658823	侦探在感冒的时候看完了整个剧集。	AI generated	elementary	\N	\N	\N
1444	The series of talks was very helpful for the senior students.	series	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.00267	2025-07-09 13:42:58.658823	这一系列的讲座对高年级的学生很有帮助。	AI generated	elementary	\N	\N	\N
1446	This is my favorite movie to watch on a cold night.	this	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.002673	2025-07-09 13:42:58.658824	这是我最喜欢在寒冷的夜晚看的电影。	AI generated	elementary	\N	\N	\N
1448	Math is merely a tool; you must learn how to use it.	merely	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.002676	2025-07-09 13:42:58.658824	数学只是一种工具，你必须学会如何使用它。	AI generated	elementary	\N	\N	\N
1450	The salty air filled his nose as he boarded the ship.	ship	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.002679	2025-07-09 13:42:58.658825	当他登上船时，咸咸的空气充满了他的鼻子。	AI generated	elementary	\N	\N	\N
1452	The senior man had a red nose from spending too much time outside.	senior	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.002682	2025-07-09 13:42:58.658825	这位老爷爷因为在外面待太久，鼻子都冻红了。	AI generated	elementary	\N	\N	\N
1454	My friend made me cry when he left.	friend	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.628375	2025-07-09 13:42:58.658826	我的朋友离开的时候，我哭了起来。	AI generated	elementary	\N	\N	\N
1456	The weed blocked the plant's growth.	growth	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.643835	2025-07-09 13:43:01.872876	杂草挡住了植物的生长。	AI generated	elementary	\N	\N	\N
1458	The squirrel hid the nuts from the sun's ray.	nuts	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.643838	2025-07-09 13:43:01.872881	松鼠把坚果藏起来，不让太阳晒到。	AI generated	elementary	\N	\N	\N
1460	It is almost time for their delicious supper.	their	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.646367	2025-07-09 13:43:01.872882	快到他们吃美味晚餐的时间了。	AI generated	elementary	\N	\N	\N
1462	It was a tough day, but his speech made me smile.	tough	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.648498	2025-07-09 13:43:01.872883	今天很辛苦，但他的讲话让我笑了。	AI generated	elementary	\N	\N	\N
1464	We will eat supper early because we are tired.	early	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:22.648502	2025-07-09 13:43:01.872883	我们会早点吃晚饭，因为我们很累。	AI generated	elementary	\N	\N	\N
1467	The farmer grew golden wheat near his parent's old farm.	wheat	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:23.027215	2025-07-09 13:43:01.872884	农民在他父母的老农场附近种了金色的麦子。	AI generated	elementary	\N	\N	\N
1469	The goat followed the parent around the farm all day.	goat	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:23.041477	2025-07-09 13:43:01.872885	小山羊整天跟着它的妈妈在农场里走来走去。	AI generated	elementary	\N	\N	\N
1471	I ate a bowl of hot soup with a fried egg on top.	soup	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:23.041481	2025-07-09 13:43:01.872885	我吃了一碗热汤，上面有一个煎蛋。	AI generated	elementary	\N	\N	\N
1473	The little goat followed me into the store yesterday.	goat	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:23.041485	2025-07-09 13:43:01.872886	昨天，小山羊跟着我进了商店。	AI generated	elementary	\N	\N	\N
1475	The store has a useful link to their website online.	store	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:23.041488	2025-07-09 13:43:01.872887	这家商店有一个很有用的链接，可以连接到他们的网站。	AI generated	elementary	\N	\N	\N
1477	I owe my friend money from our trip to the lake.	owe	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:23.041492	2025-07-09 13:43:05.413667	我欠我朋友去湖边玩的时候的钱。	AI generated	elementary	\N	\N	\N
1479	The team played with glory, but it was quite a tough match.	glory	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.638007	2025-07-09 13:43:05.413672	队伍打得很棒，但是比赛非常艰难。	AI generated	elementary	\N	\N	\N
1481	The job was so boring I almost resigned today.	boring	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.64355	2025-07-09 13:43:05.413673	工作太无聊了，我今天差点辞职。	AI generated	elementary	\N	\N	\N
1483	The trip was quite expensive, and it broke my budget!	quite	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.647656	2025-07-09 13:43:05.413674	这次旅行很贵，花超了我的预算！	AI generated	elementary	\N	\N	\N
1485	She hopes to achieve glory in her study of science.	glory	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.653645	2025-07-09 13:43:05.413675	她希望在科学研究中获得荣誉。	AI generated	elementary	\N	\N	\N
1487	The show wasn't really magic, but it was quite entertaining.	magic	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.653649	2025-07-09 13:43:05.413675	这个表演不是真正的魔法，但是非常有趣。	AI generated	elementary	\N	\N	\N
1489	I might resign if they cut the training budget again.	resign	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.653652	2025-07-09 13:43:05.413676	如果他们再削减培训预算，我可能会辞职。	AI generated	elementary	\N	\N	\N
1491	I like to twist the dough when I follow a bread recipe.	twist	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.976283	2025-07-09 13:43:05.413677	我喜欢在做面包的时候揉面团。	AI generated	elementary	\N	\N	\N
1493	If you twist the lid too hard, the jar will fail to open.	twist	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.981656	2025-07-09 13:43:05.413677	如果你把盖子拧得太紧，罐子就打不开了。	AI generated	elementary	\N	\N	\N
1495	I follow the rules to make sure the game is fair.	follow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.983775	2025-07-09 13:43:05.413678	我遵守规则，确保游戏是公平的。	AI generated	elementary	\N	\N	\N
1497	We use a hammer as a tool to set up the tent.	tent	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.988186	2025-07-09 13:43:08.285344	我们用锤子当工具来搭帐篷。	AI generated	elementary	\N	\N	\N
1499	I don't want to fail because I am a native English speaker.	fail	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.990804	2025-07-09 13:43:08.285349	我不想失败，因为我是说英语的人。	AI generated	elementary	\N	\N	\N
1501	My grandma's yellow cake recipe is my favorite dessert.	yellow	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:24.990807	2025-07-09 13:43:08.285349	我奶奶做的黄色蛋糕是我最喜欢的甜点。	AI generated	elementary	\N	\N	\N
1503	I forget things in a sudden moment sometimes, like where I put my keys.	forget	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:25.123206	2025-07-09 13:43:08.28535	我有时候会突然忘记事情，比如我把钥匙放在哪里了。	AI generated	elementary	\N	\N	\N
1505	I hate to tell you this, but the cookies are all gone now.	hate	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:25.132609	2025-07-09 13:43:08.285351	我不想告诉你，但是饼干都吃光了。	AI generated	elementary	\N	\N	\N
1507	I must wait here and scan the area before crossing the street.	wait	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:25.132612	2025-07-09 13:43:08.285352	我必须在这里等着，并且看看周围，才能过马路。	AI generated	elementary	\N	\N	\N
1509	I hate the medium sized dogs because they bark too much.	medium	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:25.132615	2025-07-09 13:43:08.285352	我讨厌中等大小的狗，因为它们叫得太厉害了。	AI generated	elementary	\N	\N	\N
1511	The teacher wrote a nice phrase about kindness on my chair.	chair	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:25.132618	2025-07-09 13:43:08.285353	老师在我的椅子上写了一句关于友善的好话。	AI generated	elementary	\N	\N	\N
1513	It was my fault the paint got on the chair.	chair	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:25.132622	2025-07-09 13:43:08.285353	油漆弄到椅子上是我的错。	AI generated	elementary	\N	\N	\N
1515	The winding dirt lane led deep into the dark forest.	forest	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.387887	2025-07-09 13:43:08.285354	弯弯曲曲的泥土小路通往黑暗森林的深处。	AI generated	elementary	\N	\N	\N
1517	There's plenty of time to fix the leak in the roof.	time	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.401206	2025-07-09 13:43:11.250658	房顶的漏水有很多时间可以修好。	AI generated	elementary	\N	\N	\N
1519	We saw an old temple hidden in the dense forest.	forest	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.404717	2025-07-09 13:43:11.250662	我们看到一座古老的寺庙藏在茂密的森林里。	AI generated	elementary	\N	\N	\N
1521	Rain poured off the roof and splashed on my head.	head	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.404721	2025-07-09 13:43:11.250663	雨水从屋顶倾泻而下，溅到我的头上。	AI generated	elementary	\N	\N	\N
1523	The loud noise gave me a shock, and I jumped four feet.	shock	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.404724	2025-07-09 13:43:11.250664	巨大的噪音吓了我一跳，我跳起来一米多高。	AI generated	elementary	\N	\N	\N
1525	My excuse is that the birds damaged the roof again.	excuse	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.408338	2025-07-09 13:43:11.250665	我的理由是鸟儿又把屋顶弄坏了。	AI generated	elementary	\N	\N	\N
1529	If I choose, I will buy the marble statue.	choose	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.905191	2025-07-09 13:43:11.250665	如果我选择，我会买那个大理石雕像。	AI generated	elementary	\N	\N	\N
1531	It has been very noisy lately in our street.	noisy	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.909134	2025-07-09 13:43:11.250666	最近我们这条街非常吵闹。	AI generated	elementary	\N	\N	\N
1533	This is the fifth time I've seen this sort of thing.	fifth	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.909137	2025-07-09 13:43:11.250666	这是我第五次看到这种事情了。	AI generated	elementary	\N	\N	\N
1535	The toy plane is in the shop window.	plane	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.90914	2025-07-09 13:43:11.250667	玩具飞机在商店的橱窗里。	AI generated	elementary	\N	\N	\N
1537	The noble scientist looked through the powerful lens.	noble	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.909143	2025-07-09 13:43:11.250668	那个了不起的科学家用强大的镜片观察着。	AI generated	elementary	\N	\N	\N
1539	Those mature trees are very tall and green.	those	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.969251	2025-07-09 13:43:14.397713	那些长大的树非常高大而且是绿色的。	AI generated	elementary	\N	\N	\N
1541	The sum of notes made a beautiful melody.	sum	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.975222	2025-07-09 13:43:14.397718	音符加起来变成了一段美丽的旋律。	AI generated	elementary	\N	\N	\N
1543	It is nearly time for the old movie to start.	nearly	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.978652	2025-07-09 13:43:14.397719	那部老电影快要开始了。	AI generated	elementary	\N	\N	\N
1545	Put the cookies on the plate for those children.	plate	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.978655	2025-07-09 13:43:14.397719	把饼干放在盘子里给那些小朋友。	AI generated	elementary	\N	\N	\N
1547	We walked on rough roads to reach those hills.	rough	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.978658	2025-07-09 13:43:14.39772	我们走在崎岖的路上到达那些山丘。	AI generated	elementary	\N	\N	\N
1549	Those birds sang a lovely melody at dawn.	those	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:26.978661	2025-07-09 13:43:14.397721	那些鸟在黎明时唱了一首动听的歌。	AI generated	elementary	\N	\N	\N
1575	The sun is a big factor that helps the flowers grow in the green meadow.	factor	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.468192	2025-07-09 13:43:17.592755	太阳是一个很大的因素，它帮助绿草地里的花朵生长。	AI generated	intermediate	\N	\N	\N
1551	The sailor in the navy uniform tried to be self-sufficient on the ship.	self	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.375546	2025-07-09 13:43:14.397721	穿着海军制服的水手想在船上自己照顾自己。	AI generated	elementary	\N	\N	\N
1553	The sound of the music made the fat cat dance.	sound	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.390633	2025-07-09 13:43:14.397722	音乐的声音让那只胖猫跳起舞来。	AI generated	elementary	\N	\N	\N
1555	Please push the book back onto the shelf when you're done.	push	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.390637	2025-07-09 13:43:14.397723	看完后请把书放回书架上。	AI generated	elementary	\N	\N	\N
1557	Can you push this button to change the channel?	push	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.39064	2025-07-09 13:43:14.397723	你能按这个按钮来换频道吗？	AI generated	elementary	\N	\N	\N
1559	I saw him try to push the heavy door open.	him	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.390644	2025-07-09 13:43:17.592746	我看到他试着推开那扇很重的门。	AI generated	elementary	\N	\N	\N
1561	The fat ship belonged to the navy during the war.	fat	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.390647	2025-07-09 13:43:17.59275	那艘胖胖的船在战争的时候是海军的。	AI generated	elementary	\N	\N	\N
1563	I will mail you the recipe for delicious garlic prawn.	mail	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.450123	2025-07-09 13:43:17.592751	我会把好吃的蒜蓉虾的做法寄给你。	AI generated	elementary	\N	\N	\N
1565	The rigid statue of the owl stood still.	rigid	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.453788	2025-07-09 13:43:17.592752	那只僵硬的猫头鹰雕像一动不动地站着。	AI generated	elementary	\N	\N	\N
1567	The total cost for my prawn dinner was twenty dollars.	total	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.453792	2025-07-09 13:43:17.592752	我那顿虾晚餐一共花了二十美元。	AI generated	elementary	\N	\N	\N
1569	The silent delivery man left the mail at the door.	silent	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.453795	2025-07-09 13:43:17.592753	安静的送货员把邮件放在了门口。	AI generated	elementary	\N	\N	\N
1571	Can you solve this simple math problem to find the total?	solve	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.453798	2025-07-09 13:43:17.592754	你能解开这道简单的数学题来算出总数吗？	AI generated	elementary	\N	\N	\N
1573	That rude, single customer made everyone uncomfortable.	rude	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.453801	2025-07-09 13:43:17.592754	那个粗鲁的单身顾客让每个人都不舒服。	AI generated	elementary	\N	\N	\N
1577	The man traveled to a different region to find a new home.	man	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.47754	2025-07-09 13:43:17.592755	那个人去了一个不同的地方，想找一个新的家。	AI generated	elementary	\N	\N	\N
1579	He felt guilt when he broke the shiny metal toy.	guilt	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.482821	2025-07-09 13:43:21.241284	他弄坏了闪亮的金属玩具，感到很内疚。	AI generated	elementary	\N	\N	\N
1581	The son felt guilt for not helping his mother.	guilt	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.482824	2025-07-09 13:43:21.241288	儿子因为没有帮助妈妈而感到内疚。	AI generated	elementary	\N	\N	\N
1583	I cannot play unless the sun shines on the land.	unless	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.482827	2025-07-09 13:43:21.241289	除非阳光照耀着大地，否则我不能玩。	AI generated	elementary	\N	\N	\N
1585	Her skill with a shovel helped her plow the land quickly.	skill	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:29.48283	2025-07-09 13:43:21.24129	她用铲子的技巧帮助她快速地犁地。	AI generated	elementary	\N	\N	\N
1587	The flower garden is on the verge of blooming yearly.	yearly	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.453945	2025-07-09 13:43:21.24129	花园里的花快要每年都开了。	AI generated	elementary	\N	\N	\N
1589	The strong truck is saving the day by pulling the car.	saving	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.455628	2025-07-09 13:43:21.241291	强大的卡车正在拖车，拯救了这一天。	AI generated	elementary	\N	\N	\N
1591	The new regime changed many things in the city.	city	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.457731	2025-07-09 13:43:21.241291	新的政权改变了城市里的很多东西。	AI generated	elementary	\N	\N	\N
1593	The lawyer tried to spin the story during the trial.	spin	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.457734	2025-07-09 13:43:21.241292	律师在审判期间试图扭曲故事。	AI generated	elementary	\N	\N	\N
1595	We are on the verge of seeing the top spin again!	spin	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.463542	2025-07-09 13:43:21.241293	我们快要再次看到陀螺旋转了！	AI generated	elementary	\N	\N	\N
1597	It's a moral thing to pay back your debt.	moral	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.463545	2025-07-09 13:43:21.241293	偿还你的债务是一件道德的事情。	AI generated	elementary	\N	\N	\N
1599	I hope I do not break my joint when I dance.	joint	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.797825	2025-07-09 13:43:24.024408	我希望我跳舞的时候不要弄伤关节。	AI generated	elementary	\N	\N	\N
1601	She is a kind woman who gave me a slice of cake.	kind	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.80565	2025-07-09 13:43:24.024412	她是个好心的女人，给了我一块蛋糕。	AI generated	elementary	\N	\N	\N
1603	The new office design follows a modern trend.	office	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.813278	2025-07-09 13:43:24.024413	新的办公室设计很时髦。	AI generated	elementary	\N	\N	\N
1605	Painting the wall with this color is a new trend.	trend	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.813282	2025-07-09 13:43:24.024414	用这个颜色刷墙是一种新的潮流。	AI generated	elementary	\N	\N	\N
1607	My dad is busy at office all day long.	office	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.813285	2025-07-09 13:43:24.024414	我爸爸一整天都在办公室忙。	AI generated	elementary	\N	\N	\N
1609	It is kind to not wander off alone in the forest.	kind	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:30.813289	2025-07-09 13:43:24.024415	不独自在森林里乱跑是好的。	AI generated	elementary	\N	\N	\N
1611	Please show us your drawing, it's very good!	show	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:31.001617	2025-07-09 13:43:24.024415	请给我们看看你的画，它非常好！	AI generated	elementary	\N	\N	\N
1613	The roar of the lion will warn you to stay away.	warn	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:31.011242	2025-07-09 13:43:24.024416	狮子的吼叫会警告你远离它。	AI generated	elementary	\N	\N	\N
1615	He hurt his arm, so please help us lift that box.	arm	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:31.011246	2025-07-09 13:43:24.024417	他伤了胳膊，所以请帮我们抬那个箱子。	AI generated	elementary	\N	\N	\N
1617	The ninth knight in the legend was very brave.	ninth	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:31.011249	2025-07-09 13:43:24.024417	传说中的第九个骑士非常勇敢。	AI generated	elementary	\N	\N	\N
1619	I heard a loud scream and saw a scary robot!	scream	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:31.011253	2025-07-09 13:43:26.968193	我听到一声大叫，还看到一个可怕的机器人！	AI generated	elementary	\N	\N	\N
1621	It was stupid to put the green jelly on my head.	jelly	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:31.011256	2025-07-09 13:43:26.968197	把绿色的果冻放在我的头上真是太傻了。	AI generated	elementary	\N	\N	\N
1623	My finger is very sore because I pulled a thread.	thread	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:32.925517	2025-07-09 13:43:26.968198	我的手指很痛，因为我拉了一根线。	AI generated	elementary	\N	\N	\N
1625	The plum does seem ripe and ready to eat.	seem	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:32.93235	2025-07-09 13:43:26.968199	这个李子看起来很熟，可以吃了。	AI generated	elementary	\N	\N	\N
1627	I used a green thread to sew the plum onto the costume.	thread	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:32.942059	2025-07-09 13:43:26.968199	我用绿色的线把李子缝在了服装上。	AI generated	elementary	\N	\N	\N
1629	The hardest thing about the running course is the hill.	thing	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:32.942063	2025-07-09 13:43:26.9682	跑步路线最难的地方是那个山坡。	AI generated	elementary	\N	\N	\N
1631	She changed the course to dress better.	course	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:32.942067	2025-07-09 13:43:26.9682	她改变了穿衣风格，让自己穿得更好看。	AI generated	elementary	\N	\N	\N
1633	Eating a big salad can help your mental focus.	mental	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:32.94207	2025-07-09 13:43:26.968201	吃一大份沙拉可以帮助你集中注意力。	AI generated	elementary	\N	\N	\N
1635	The wait felt very long, and this is the worst day ever!	long	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.15687	2025-07-09 13:43:26.968202	等待感觉非常漫长，这是有史以来最糟糕的一天！	AI generated	elementary	\N	\N	\N
1659	Mom used a big metal pan to catch the water leaking from the roof's pitch.	pan	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.235656	2025-07-09 13:43:36.119531	妈妈用一个大金属盘子来接住从屋顶漏下来的水。	AI generated	intermediate	\N	\N	\N
1637	Her lucky charm stopped the mean gossip about her.	charm	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.163742	2025-07-09 13:43:26.968202	她的幸运符阻止了关于她的恶意闲话。	AI generated	elementary	\N	\N	\N
1661	I will kick the ball with all my might and send it at the pitch.	kick	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.239363	2025-07-09 13:43:36.119535	我会用尽全力踢球，把它踢到球场上。	AI generated	intermediate	\N	\N	\N
1639	I used my comb to make my long hair look neat.	comb	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.166488	2025-07-09 13:43:32.815103	我用梳子把我的长头发梳得整整齐齐。	AI generated	elementary	\N	\N	\N
1641	He felt a slight chill wearing his summer shorts.	shorts	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.166491	2025-07-09 13:43:32.815107	他穿着夏天的短裤，觉得有点冷。	AI generated	elementary	\N	\N	\N
1643	A random car stopped on the bridge, blocking traffic.	bridge	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.170292	2025-07-09 13:43:32.815108	一辆随便的车停在桥上，堵住了交通。	AI generated	elementary	\N	\N	\N
1645	The farmer grew long rows of sweet yellow corn.	long	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.170296	2025-07-09 13:43:32.815109	农民种了一排排又长又甜的黄色玉米。	AI generated	elementary	\N	\N	\N
1647	The grand duke spoke about sex education at the town hall.	sex	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.717037	2025-07-09 13:43:32.815109	大公爵在市政厅谈论了性教育。	AI generated	elementary	\N	\N	\N
1649	The fee to enter the maze was too expensive for me.	fee	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.72239	2025-07-09 13:43:32.81511	进入迷宫的费用对我来说太贵了。	AI generated	elementary	\N	\N	\N
1651	We saw five movies at the cinema last week.	five	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.726706	2025-07-09 13:43:32.815111	上个星期我们在电影院看了五部电影。	AI generated	elementary	\N	\N	\N
1653	The report said getting lost in the maze is common.	report	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.729042	2025-07-09 13:43:32.815112	报告说在迷宫里迷路是很常见的。	AI generated	elementary	\N	\N	\N
1655	I have a strong desire for a bag that fits on my hip.	desire	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.729046	2025-07-09 13:43:32.815112	我非常想要一个可以放在我屁股上的包包。	AI generated	elementary	\N	\N	\N
1657	I will write a note to attach to the bag on my hip.	write	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:33.729049	2025-07-09 13:43:32.815113	我要写一张纸条，贴在我屁股上的包包上。	AI generated	elementary	\N	\N	\N
1663	Please grab a tissue and clean the grease from the pan.	tissue	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.239367	2025-07-09 13:43:36.119536	请拿一张纸巾擦掉盘子上的油。	AI generated	elementary	\N	\N	\N
1665	Don't leave the hot pan on the stove unattended.	leave	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.239371	2025-07-09 13:43:36.119537	不要让热锅在炉子上无人看管。	AI generated	elementary	\N	\N	\N
1667	Can you use a fork to scrape the food off the pan?	fork	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.239374	2025-07-09 13:43:36.119537	你能用叉子把盘子里的食物刮掉吗？	AI generated	elementary	\N	\N	\N
1669	The chef needed a vast pan to cook for the entire party.	vast	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.239377	2025-07-09 13:43:36.119538	厨师需要一个很大的锅来为整个聚会做饭。	AI generated	elementary	\N	\N	\N
1671	Please allow me to explain every detail of my drawing to you.	allow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.58042	2025-07-09 13:43:36.119539	请允许我向你解释我画的每一处细节。	AI generated	elementary	\N	\N	\N
1673	I allow you to share your idea with the class.	allow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.583436	2025-07-09 13:43:36.119539	我允许你和全班同学分享你的想法。	AI generated	elementary	\N	\N	\N
1675	The pilot used radar to see the island near the big palm tree.	radar	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.585882	2025-07-09 13:43:36.11954	飞行员用雷达看到了大棕榈树附近的岛屿。	AI generated	elementary	\N	\N	\N
1677	My sister had a great idea for a new toy.	toy	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.59084	2025-07-09 13:43:36.11954	我姐姐有一个关于新玩具的好主意。	AI generated	elementary	\N	\N	\N
1679	Can you help me write down my idea?	help	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:34.590843	2025-07-09 13:43:39.31211	你能帮我写下我的想法吗？	AI generated	elementary	\N	\N	\N
1683	I will sweep the floor slowly after my snack.	sweep	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:35.05139	2025-07-09 13:43:39.312115	我吃完零食后会慢慢地扫地。	AI generated	elementary	\N	\N	\N
1685	Take this form and rest quietly until your name is called.	form	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:35.057666	2025-07-09 13:43:39.312115	拿着这张表格，安静地休息，直到叫到你的名字。	AI generated	elementary	\N	\N	\N
1687	Many people suffer if a bad storm takes form.	suffer	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:35.057669	2025-07-09 13:43:39.312116	如果形成一场糟糕的风暴，很多人会受苦。	AI generated	elementary	\N	\N	\N
1689	The police are investigating the theft of my grandma's tea set.	theft	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:35.057673	2025-07-09 13:43:39.312117	警察正在调查我奶奶的茶具被盗的事情。	AI generated	elementary	\N	\N	\N
1691	I saw a horse saddle left in the gym.	gym	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:35.057676	2025-07-09 13:43:39.312117	我看到一个马鞍被留在体育馆里。	AI generated	elementary	\N	\N	\N
1694	I would like some tea, indeed!	tea	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:35.060785	2025-07-09 13:43:39.312118	我确实想要一些茶！	AI generated	elementary	\N	\N	\N
1696	I can see the turtle is very slow.	slow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:36.971517	2025-07-09 13:43:39.312119	我能看到这只乌龟非常慢。	AI generated	elementary	\N	\N	\N
1700	Please shut the door if you walk too slow.	slow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:36.983296	2025-07-09 13:43:39.312119	如果你走得太慢，请关上门。	AI generated	elementary	\N	\N	\N
1702	We need to widen this small hole with a pin.	widen	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:36.9833	2025-07-09 13:43:39.31212	我们需要用别针把这个小洞弄大一点。	AI generated	elementary	\N	\N	\N
1704	Please shut the gate, master.	shut	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:36.991228	2025-07-09 13:43:42.302105	请关上大门，主人。	AI generated	elementary	\N	\N	\N
1706	I used a pin to fix the linen.	linen	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:36.991232	2025-07-09 13:43:42.30211	我用别针来固定亚麻布。	AI generated	elementary	\N	\N	\N
1708	We must build a strong firewall to protect against the computer virus.	build	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.728021	2025-07-09 13:43:42.30211	我们必须建立一个强大的防火墙来防止电脑病毒。	AI generated	elementary	\N	\N	\N
1710	The logic of the game is based on the mountain slope.	slope	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.733037	2025-07-09 13:43:42.302111	这个游戏的逻辑是基于山坡的。	AI generated	elementary	\N	\N	\N
1712	They will build a house on the slope of the hill.	build	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.733041	2025-07-09 13:43:42.302112	他们将在山坡上盖一栋房子。	AI generated	elementary	\N	\N	\N
1714	The path gets slippery on the slope inside the cave.	slope	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.733045	2025-07-09 13:43:42.302112	洞穴里的斜坡上，路变得很滑。	AI generated	elementary	\N	\N	\N
1716	At noon, we saw a duck swimming in the pond.	noon	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.733049	2025-07-09 13:43:42.302113	中午，我们看到一只鸭子在池塘里游泳。	AI generated	elementary	\N	\N	\N
1718	A little bird built a nest on the huge oak tree.	little	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.733052	2025-07-09 13:43:42.302114	一只小鸟在一棵巨大的橡树上筑了一个巢。	AI generated	elementary	\N	\N	\N
1720	The main thing I need is my old boot to go outside.	main	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.759859	2025-07-09 13:43:42.302114	我最需要的是我的旧靴子，这样才能出去。	AI generated	elementary	\N	\N	\N
1722	I doubt I can fit another rock in my heavy boot.	doubt	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.762695	2025-07-09 13:43:42.302115	我怀疑我还能不能在我的重靴子里再放一块石头了。	AI generated	elementary	\N	\N	\N
1724	The rotten fruit made the little boy very sad.	fruit	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.762698	2025-07-09 13:43:45.390152	坏掉的水果让小男孩非常伤心。	AI generated	elementary	\N	\N	\N
1726	The farmer has a cow and a strict policy about feeding it.	cow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.762702	2025-07-09 13:43:45.390157	农夫有一头奶牛，而且有喂养它的严格规定。	AI generated	elementary	\N	\N	\N
1728	The novel had a main character who lived in a small town.	novel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.762705	2025-07-09 13:43:45.390158	这本小说有个主角，他住在一个小镇上。	AI generated	elementary	\N	\N	\N
1730	I doubt that slow turtle will ever win the race.	doubt	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.762707	2025-07-09 13:43:45.390158	我怀疑那只慢吞吞的乌龟永远赢不了比赛。	AI generated	elementary	\N	\N	\N
1746	Given the clear evidence, the likelihood of a severe penalty for the infraction is substantial.	likelihood	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.720102	2025-07-09 13:43:49.752588	有了 确凿 的 证据， 这次 违规 行为 很 可能 会 受到 严厉 的 惩罚。	AI generated	intermediate	\N	\N	\N
1732	For just a moment, I forgot what degree I wanted to study.	moment	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.925403	2025-07-09 13:43:45.390159	就在那一瞬间，我忘记了我想学什么专业。	AI generated	elementary	\N	\N	\N
1748	The players enjoyed a spirited game of volleyball bathed in warm sunshine on the beach.	sunshine	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.720106	2025-07-09 13:43:49.752589	球员们 在 海滩上 沐浴 着 温暖 的 阳光， 尽情 地 打 排球。	AI generated	intermediate	\N	\N	\N
1734	The computer can print certificates for any degree program.	print	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.929164	2025-07-09 13:43:45.39016	电脑可以打印任何专业的证书。	AI generated	elementary	\N	\N	\N
1758	It was strange to consider the evolution of such a complex social structure from simple beginnings.	strange	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.819016	2025-07-09 13:43:49.752592	很难 想象 如此 复杂 的 社会 结构 是 从 简单 的 起源 发展 起来 的。	AI generated	intermediate	\N	\N	\N
1736	A good badminton strike needs a proper stroke.	strike	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.929168	2025-07-09 13:43:45.39016	打好羽毛球需要正确的击球动作。	AI generated	elementary	\N	\N	\N
1766	The cog railway, a remarkable invention, allows easy access to the top of the mountain.	mountain	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.827491	2025-07-09 13:43:52.97705	齿轨铁路，一个了不起的发明，让人可以轻松地到达山顶。	AI generated	intermediate	\N	\N	\N
1738	I will print a flyer about the ham bake sale.	print	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.929171	2025-07-09 13:43:45.390161	我要打印一张关于火腿义卖的海报。	AI generated	elementary	\N	\N	\N
1740	That loud music shows a low degree of respect.	loud	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.929174	2025-07-09 13:43:45.390161	那么吵的音乐说明很不尊重人。	AI generated	elementary	\N	\N	\N
1742	The worker will strike if they don't fix the rail soon.	rail	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:37:37.929177	2025-07-09 13:43:45.390162	如果他们不快点修理铁路，工人们就要罢工了。	AI generated	elementary	\N	\N	\N
1744	After the recurring nightmare, he attended therapy regularly to cope with the underlying anxiety.	regularly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.72009	2025-07-09 13:43:49.752583	在重复做噩梦后，他 নিয়মিত 去看医生， чтобы 解决 内心的 焦虑。	AI generated	elementary	\N	\N	\N
1750	Her recurring nightmare involved falling off a digital platform into an endless abyss.	nightmare	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.72011	2025-07-09 13:43:49.752589	她 反复 做 的 噩梦 是 从 一个 数字 平台 掉进 无尽 的 深渊。	AI generated	elementary	\N	\N	\N
1752	The referee assessed a penalty against the thirteen-year-old player for unsportsmanlike conduct.	thirteen	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.720114	2025-07-09 13:43:49.75259	裁判 因为 这位 十三 岁 球员 的 不 友好 行为 判罚 了 他。	AI generated	elementary	\N	\N	\N
1754	Thirteen friends received an invitation to celebrate the anniversary of their long-standing book club.	thirteen	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.720118	2025-07-09 13:43:49.752591	十三 个 朋友 收到 了 邀请， 一起 庆祝 他们 长期 书 友 会 的 周年纪念。	AI generated	elementary	\N	\N	\N
1756	The breathtaking scenery displayed the slow evolution of the landscape over millennia.	evolution	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.815571	2025-07-09 13:43:49.752591	令人 惊叹 的 风景 展示 了 数千年来 地貌 的 缓慢 演变。	AI generated	elementary	\N	\N	\N
1760	They watched silently, trying to restrain their excitement as the magician performed.	silently	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.819019	2025-07-09 13:43:49.752592	他们 静静 地 观看 着， 努力 抑制 住 魔术师 表演 时 的 兴奋。	AI generated	elementary	\N	\N	\N
1762	The quality of the light enhanced the beauty of the mountain scenery.	scenery	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.827484	2025-07-09 13:43:49.752593	光线 的 质量 增强 了 山景 的 美丽。	AI generated	elementary	\N	\N	\N
1764	From her small apartment, the ocean scenery was a constant source of inspiration.	scenery	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.827488	2025-07-09 13:43:52.977047	从她的小公寓里，海洋的景色总是给她带来灵感。	AI generated	elementary	\N	\N	\N
1804	The website's user profile suggested that someone had been altering her personal information without permission.	profile	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:24.07313	2025-07-09 13:43:59.722416	网站上的个人资料显示，有人未经允许修改了她的个人信息。	AI generated	intermediate	\N	\N	\N
1768	The security guard's crisp uniform distinguished him as a responsible citizen.	uniform	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.842692	2025-07-09 13:43:52.977051	保安干净整洁的制服让他看起来像一个负责任的市民。	AI generated	elementary	\N	\N	\N
1770	Their romantic getaway included watching the tennis tournament from their hotel balcony.	romantic	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.846411	2025-07-09 13:43:52.977051	他们的浪漫旅行包括在酒店阳台上观看网球比赛。	AI generated	elementary	\N	\N	\N
1772	Her tireless work earned her well-deserved recognition from the selection committee.	recognition	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.846414	2025-07-09 13:43:52.977052	她不知疲倦的工作为她赢得了评选委员会给予的应得的认可。	AI generated	elementary	\N	\N	\N
1774	The courageous knight won the jousting tournament, securing his kingdom's victory.	tournament	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.850988	2025-07-09 13:43:52.977052	勇敢的骑士赢得了长矛比武大赛，确保了他的王国的胜利。	AI generated	elementary	\N	\N	\N
1776	An intriguing advertisement hinted at a secret underground society meeting tonight.	underground	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.853971	2025-07-09 13:43:52.977053	一则有趣的广告暗示今晚将有一个秘密的地下社团聚会。	AI generated	elementary	\N	\N	\N
1778	A typical citizen follows the law and pays their taxes accordingly.	citizen	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.853974	2025-07-09 13:43:52.977053	一个普通的市民会遵守法律并按时交税。	AI generated	elementary	\N	\N	\N
1780	The small glass ornament shattered during the sudden movement of the shelf.	ornament	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.897766	2025-07-09 13:43:52.977053	在架子突然晃动时，小的玻璃装饰品摔碎了。	AI generated	elementary	\N	\N	\N
1782	The stage equipment was crafted from lightweight, durable material.	equipment	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.902786	2025-07-09 13:43:52.977054	舞台设备是用轻便耐用的材料制成的。	AI generated	elementary	\N	\N	\N
1784	This real estate investment offers significant potential for long-term growth.	potential	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.902789	2025-07-09 13:43:55.853612	这个房地产投资有很大的机会可以长期赚钱。	AI generated	elementary	\N	\N	\N
1786	Witnessing the entire incident spurred a powerful movement for change.	incident	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.902792	2025-07-09 13:43:55.853622	看到整个事情发生，激发了一场强大的改变运动。	AI generated	elementary	\N	\N	\N
1788	The bird's sudden movement startled her unexpectedly in the garden.	movement	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.902795	2025-07-09 13:43:55.853623	小鸟突然的动作让她在花园里吓了一跳。	AI generated	elementary	\N	\N	\N
1790	He is responsible for ensuring the proportion of ingredients is correct.	proportion	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.90608	2025-07-09 13:43:55.853624	他负责确保配料的比例是正确的。	AI generated	elementary	\N	\N	\N
1792	The next chapter clearly outlines the protagonist's motivations.	chapter	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.9177	2025-07-09 13:43:55.853624	下一章清楚地说明了主角为什么要这样做。	AI generated	elementary	\N	\N	\N
1794	Before I turned nineteen, I didn't travel anywhere exciting.	nineteen	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.92968	2025-07-09 13:43:55.853625	在我十九岁之前，我没有去过任何有趣的地方。	AI generated	elementary	\N	\N	\N
1796	Fortunately, the watermelon wasn't too ripe.	watermelon	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.929683	2025-07-09 13:43:55.853626	幸运的是，这个西瓜不太熟。	AI generated	elementary	\N	\N	\N
1798	The mayor's intention for the re-election campaign was obvious.	intention	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.929686	2025-07-09 13:43:55.853626	市长想要再次当选的想法很明显。	AI generated	elementary	\N	\N	\N
1800	His only justification for the objection was personal bias.	justification	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.929689	2025-07-09 13:43:55.853627	他反对的唯一理由是个人偏见。	AI generated	elementary	\N	\N	\N
1802	The lawyer addressed each objection raised in the trial's final chapter.	chapter	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:23.929691	2025-07-09 13:43:55.853627	律师在审判的最后一章里回应了每一个反对意见。	AI generated	elementary	\N	\N	\N
1806	The aging veteran showed incredible resistance to the proposed changes in his pension benefits.	resistance	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:24.086915	2025-07-09 13:43:59.72242	那位年老的退伍军人对养老金的改变表现出惊人的抵抗力。	AI generated	elementary	\N	\N	\N
1808	The spy needed to exchange his current profile for a completely new identity.	profile	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:24.086919	2025-07-09 13:43:59.722421	那个间谍需要用一个全新的身份来替换他现在的身份。	AI generated	elementary	\N	\N	\N
1814	The expert's analysis of the handwriting provided additional evidence in support of the document's authenticity.	handwriting	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:24.091719	2025-07-09 13:43:59.722423	专家对笔迹的分析为证明文件的真实性提供了更多证据。	AI generated	intermediate	\N	\N	\N
1810	Finally, someone understood the complexities of the algorithm and could fix the problem.	finally	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:24.091712	2025-07-09 13:43:59.722422	终于，有人理解了这个算法的复杂性，并且可以解决这个问题了。	AI generated	elementary	\N	\N	\N
1818	The company decided to replace the old machinery after his marriage to the CEO's daughter.	replace	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:27.934902	2025-07-09 13:43:59.722424	在他和CEO的女儿结婚后，公司决定更换旧机器。	AI generated	intermediate	\N	\N	\N
1812	New environmental regulation will provide cleaner air for the city's residents, which is great!	regulation	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:24.091715	2025-07-09 13:43:59.722423	新的环保规定将会为城市居民提供更清洁的空气，这太棒了！	AI generated	elementary	\N	\N	\N
1830	To understand the poem's meaning, you need to know the historical context of that mountain panorama.	context	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.004837	2025-07-09 13:44:02.716471	要理解这首诗的意思，你需要知道那座山的历史背景。	AI generated	intermediate	\N	\N	\N
1816	Her extensive knowledge compensated for her obvious weakness in practical application.	knowledge	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:27.934894	2025-07-09 13:43:59.722424	她渊博的知识弥补了她在实际应用方面的明显不足。	AI generated	elementary	\N	\N	\N
1820	Skilled negotiation can often turn a perceived weakness into a strategic advantage.	negotiation	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:27.934905	2025-07-09 13:43:59.722425	熟练的谈判常常可以将看起来的弱点变成战略优势。	AI generated	elementary	\N	\N	\N
1822	Breaking the cycle requires acknowledging the destructive pattern and making a sacrifice.	pattern	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:27.934909	2025-07-09 13:43:59.722426	打破这个循环需要承认这种破坏性的模式并做出牺牲。	AI generated	elementary	\N	\N	\N
1824	The eruption of the volcano disrupted the usual weather pattern in the region.	volcano	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:27.934912	2025-07-09 13:44:02.716459	火山爆发打乱了那个地方正常的天气。	AI generated	elementary	\N	\N	\N
1826	He knew exactly what he was giving up and was prepared to sacrifice everything.	exactly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:27.934916	2025-07-09 13:44:02.716465	他很清楚自己要放弃什么，并且准备好牺牲一切。	AI generated	elementary	\N	\N	\N
1828	The police worked to suppress illegal drug traffic in the city center.	suppress	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:27.999996	2025-07-09 13:44:02.71647	警察努力阻止市中心的非法毒品交易。	AI generated	elementary	\N	\N	\N
1832	The zookeeper's objective was to photograph the brilliant peacock displaying its feathers.	peacock	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.011321	2025-07-09 13:44:02.716472	动物园管理员的目标是拍下美丽的孔雀展示羽毛的照片。	AI generated	elementary	\N	\N	\N
1834	Unfortunate, but the truth is she sometimes feels isolated despite her popularity.	unfortunate	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.011325	2025-07-09 13:44:02.716472	很不幸，但事实是，尽管她很受欢迎，有时还是感到孤独。	AI generated	elementary	\N	\N	\N
1836	The father peacock proudly displayed his vibrant plumage to attract a mate.	peacock	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.011328	2025-07-09 13:44:02.716473	公孔雀骄傲地展示着鲜艳的羽毛，为了吸引伴侣。	AI generated	elementary	\N	\N	\N
1838	The chef admitted the terrible selection of ingredients resulted in a poor dish.	terrible	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.011331	2025-07-09 13:44:02.716474	厨师承认糟糕的食材选择导致了菜的味道不好。	AI generated	elementary	\N	\N	\N
1840	The town council hoped to gain insight into local concerns during the meeting.	council	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.045826	2025-07-09 13:44:02.716474	镇议会希望在会议中了解当地人关心的事情。	AI generated	elementary	\N	\N	\N
1842	In my opinion, the professor needs to explain the complex theory more clearly.	opinion	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.049294	2025-07-09 13:44:02.716475	我认为，教授需要更清楚地解释这个复杂的理论。	AI generated	elementary	\N	\N	\N
1844	From an ecological perspective, we can explain the rapid decline in bee populations.	perspective	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.058696	2025-07-09 13:44:05.553959	从生态的角度来看，我们可以解释蜜蜂数量为什么下降这么快。	AI generated	elementary	\N	\N	\N
1846	The student's payment was delayed due to a technical error at the university.	payment	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.058699	2025-07-09 13:44:05.553964	因为大学里的技术错误，学生的付款被推迟了。	AI generated	elementary	\N	\N	\N
1848	The university offered support services for students facing unexpected pregnancy.	pregnancy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.058702	2025-07-09 13:44:05.553964	大学为意外怀孕的学生提供帮助服务。	AI generated	elementary	\N	\N	\N
1850	Her opinion showed surprising insight into the motivations of the characters.	opinion	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.058705	2025-07-09 13:44:05.553965	她的看法让人惊讶地看透了角色的想法。	AI generated	elementary	\N	\N	\N
1852	Her purchase of art supplies fueled her passion for painting landscapes.	purchase	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.162555	2025-07-09 13:44:05.553966	她买了美术用品，这让她更喜欢画风景画了。	AI generated	elementary	\N	\N	\N
1854	Complete relaxation requires a warm bath and a pudding dessert.	relaxation	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.170965	2025-07-09 13:44:05.553966	想要完全放松，需要一个热水澡和一份布丁甜点。	AI generated	elementary	\N	\N	\N
1856	The factory whistles blew occasionally during the night shift.	factory	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.170969	2025-07-09 13:44:05.553967	晚上上班的时候，工厂的汽笛偶尔会响。	AI generated	elementary	\N	\N	\N
1858	That individual occasionally visits the local bookstore.	individual	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.176436	2025-07-09 13:44:05.553967	那个人偶尔会去当地的书店。	AI generated	elementary	\N	\N	\N
1860	Each individual at the factory received a safety manual.	individual	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.17644	2025-07-09 13:44:05.553968	工厂里的每个人都收到了一本安全手册。	AI generated	elementary	\N	\N	\N
1862	His imagination transformed the old factory into a vibrant art space.	imagination	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.176443	2025-07-09 13:44:05.553969	他的想象力把旧工厂变成了充满活力的艺术空间。	AI generated	elementary	\N	\N	\N
1864	Finding a viable solution requires immense motivation and persistent effort.	solution	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.205585	2025-07-09 13:44:08.991054	找到可行的办法需要很大的动力和坚持不懈的努力。	AI generated	elementary	\N	\N	\N
1866	I am incredibly grateful for the ergonomic keyboard that reduces strain on my wrists.	grateful	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.216309	2025-07-09 13:44:08.991058	我非常感谢这个符合人体工学的键盘，它减轻了我手腕的压力。	AI generated	elementary	\N	\N	\N
1868	After making various errors, he felt deeply ashamed of his performance.	various	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.222459	2025-07-09 13:44:08.991058	犯了很多错误后，他为自己的表现感到非常羞愧。	AI generated	elementary	\N	\N	\N
1870	We should encourage the reduction of single-use plastic to protect our environment.	encourage	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.226535	2025-07-09 13:44:08.991059	为了保护我们的环境，我们应该鼓励减少一次性塑料的使用。	AI generated	elementary	\N	\N	\N
1872	Lack of motivation made him realize his plan was utterly foolish.	motivation	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.226538	2025-07-09 13:44:08.991059	缺乏动力让他意识到他的计划非常愚蠢。	AI generated	elementary	\N	\N	\N
1874	The only medical help available was for patients who were unconscious.	available	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.226542	2025-07-09 13:44:08.99106	唯一能得到的医疗帮助是给那些失去知觉的病人。	AI generated	elementary	\N	\N	\N
1876	The missile launch was a wonderful sight, despite its inherent danger.	missile	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.241895	2025-07-09 13:44:08.99106	导弹发射是一个很棒的景象，尽管它本身很危险。	AI generated	elementary	\N	\N	\N
1878	The history of the company took a negative turn after the economic crash.	history	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.250525	2025-07-09 13:44:08.991061	经济崩溃后，公司的历史发生了不好的转变。	AI generated	elementary	\N	\N	\N
1880	My teacher preferred the latest version of the textbook for its clarity.	teacher	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.250528	2025-07-09 13:44:08.991061	我的老师更喜欢最新版本的教科书，因为它更清楚易懂。	AI generated	elementary	\N	\N	\N
1882	Waterboarding is considered torture and has a negative impact on mental health.	torture	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.250532	2025-07-09 13:44:08.991062	水刑被认为是酷刑，对心理健康有负面影响。	AI generated	elementary	\N	\N	\N
1884	The intercepted missile signal had a surprisingly negative reading, indicating malfunction.	negative	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.250535	2025-07-09 13:44:12.339968	被拦截的导弹信号显示出令人惊讶的负面读数，表明发生了故障。	AI generated	elementary	\N	\N	\N
1900	My purpose for joining the book club was to discover my preference for different genres.	purpose	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.111988	2025-07-09 13:44:12.339975	我加入读书会的目的是为了发现自己喜欢哪种类型的书。	AI generated	intermediate	\N	\N	\N
1886	Pollution is a serious problem threatening the future of mankind.	problem	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:28.250538	2025-07-09 13:44:12.339972	污染是一个严重的问题，威胁着人类的未来。	AI generated	elementary	\N	\N	\N
1888	The film's villain, despite being seventy years old, was surprisingly agile and menacing.	villain	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:31.875229	2025-07-09 13:44:12.339972	电影里的坏人，虽然七十岁了，但出人意料地敏捷和吓人。	AI generated	elementary	\N	\N	\N
1890	We enjoyed a transparent kayak tour over the weekend, observing marine life below.	weekend	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:31.875237	2025-07-09 13:44:12.339973	周末我们玩了透明皮划艇，观察了下面的海洋生物，玩得很开心。	AI generated	elementary	\N	\N	\N
1892	The artist's representation of the local community was celebrated for its authenticity.	representation	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:31.875241	2025-07-09 13:44:12.339973	艺术家对当地社区的描绘因其真实性而受到赞扬。	AI generated	elementary	\N	\N	\N
1894	Every Wednesday, the cafeteria serves steaming bowls of delicious noodles.	wednesday	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:31.875245	2025-07-09 13:44:12.339973	每个星期三，食堂都会供应热气腾腾的美味面条。	AI generated	elementary	\N	\N	\N
1896	The transparent ballot box will arrive on Wednesday, ensuring election integrity.	transparent	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:31.875249	2025-07-09 13:44:12.339974	透明的投票箱将于周三到达，以确保选举的公正性。	AI generated	elementary	\N	\N	\N
1898	Whereas a balanced diet is key, a vitamin supplement can sometimes be helpful.	whereas	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:31.875253	2025-07-09 13:44:12.339974	虽然均衡的饮食很重要，但维生素补充剂有时也会有帮助。	AI generated	elementary	\N	\N	\N
1902	The biologist's observation showed that plastic was everywhere in the marine ecosystem.	everywhere	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.119292	2025-07-09 13:44:12.339975	生物学家的观察表明，海洋生态系统中到处都是塑料。	AI generated	elementary	\N	\N	\N
1904	Seeing a leopard on our vacation in Africa was a breathtaking experience.	leopard	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.123045	2025-07-09 13:44:15.392245	在非洲度假时看到豹子，真是太让人激动了！	AI generated	elementary	\N	\N	\N
1906	The biggest difference on this year's family vacation was the improved weather.	difference	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.123049	2025-07-09 13:44:15.39225	今年家庭旅行最大的不同就是天气更好了。	AI generated	elementary	\N	\N	\N
1908	Breaking the daily routine was driven by a sudden surge of curiosity.	routine	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.123053	2025-07-09 13:44:15.392251	打破每天的常规是因为突然有了强烈的好奇心。	AI generated	elementary	\N	\N	\N
1910	Trash was seen everywhere during our beach vacation, which was disappointing.	everywhere	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.123056	2025-07-09 13:44:15.392252	海滩度假时到处都是垃圾，真让人失望。	AI generated	elementary	\N	\N	\N
1924	She remembered her grandmother's advice about investing to build a fortune, but only vaguely.	fortune	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.292707	2025-07-09 13:44:15.392253	她记得奶奶关于投资致富的建议，但记得不是很清楚。	AI generated	elementary	\N	\N	\N
1926	The police suspect the painter might have been involved in art forgery.	painter	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.300864	2025-07-09 13:44:15.392254	警察怀疑那个画家可能参与了伪造艺术品。	AI generated	elementary	\N	\N	\N
1928	Scientists hope to discover a new enzyme that can break down plastic pollution.	pollution	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.300867	2025-07-09 13:44:15.392255	科学家们希望发现一种新的酶，可以分解塑料污染。	AI generated	elementary	\N	\N	\N
1930	The seafood salad was garnished with a sweet strawberry vinaigrette.	seafood	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.303982	2025-07-09 13:44:15.392256	海鲜沙拉上装饰着甜甜的草莓醋汁。	AI generated	elementary	\N	\N	\N
1932	Investigators suspect they will discover evidence of tampering with the antique clock.	suspect	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.303984	2025-07-09 13:44:15.392256	调查人员怀疑他们会发现有人动过那个古董钟的证据。	AI generated	elementary	\N	\N	\N
1934	He felt the pressure to succeed, though he understood the risks vaguely.	vaguely	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.303987	2025-07-09 13:44:15.392257	他感到必须成功的压力，虽然他对风险只是大概了解。	AI generated	elementary	\N	\N	\N
1958	As a dedicated health supporter, she advocated for adding more mineral-rich foods to our diets.	supporter	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.68453	2025-07-09 13:44:18.882487	作为一名健康的支持者，她提倡在我们的饮食中增加更多富含矿物质的食物。	AI generated	intermediate	\N	\N	\N
1948	His first marathon was an incredible experience, filled with challenges and triumphs.	marathon	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.666368	2025-07-09 13:44:18.882482	他的第一次马拉松是一次很棒的经历，充满了挑战和成功。	AI generated	elementary	\N	\N	\N
1972	The forest floor, damp after the rain, sprouted a giant mushroom, drawing a persistent mosquito.	mushroom	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.423666	2025-07-09 13:44:22.601344	雨后的森林地面湿湿的，长出一个大蘑菇，引来了一只烦人的蚊子。	AI generated	intermediate	\N	\N	\N
1950	Growing up with a rural background, she dreamed of performing in a grand theatre.	background	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.67186	2025-07-09 13:44:18.882485	她在乡下长大，梦想着能在漂亮的剧院里表演。	AI generated	elementary	\N	\N	\N
1982	The film's box-office outcome hinged on positive reviews and word-of-mouth about the extra buttered popcorn.	popcorn	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.432271	2025-07-09 13:44:22.601346	这部电影的票房好不好，取决于好的评价和大家口口相传的加黄油爆米花。	AI generated	intermediate	\N	\N	\N
1952	Her popular photography blog showcased captivating portraits and landscapes from around the world.	popular	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.680146	2025-07-09 13:44:18.882485	她受欢迎的摄影博客展示了来自世界各地的迷人照片和风景。	AI generated	elementary	\N	\N	\N
1954	The travel experience greatly enhanced her photography, providing unique perspectives.	experience	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.682386	2025-07-09 13:44:18.882486	旅行经历大大提升了她的摄影水平，让她看到了独特的风景。	AI generated	elementary	\N	\N	\N
1956	Her devotion to wildlife photography was evident in every stunning image.	photography	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:32.68239	2025-07-09 13:44:18.882486	她对野生动物摄影的热爱，在每一张美丽的图片中都能看出来。	AI generated	elementary	\N	\N	\N
1960	I hope I somehow receive the package I ordered last week.	somehow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.331259	2025-07-09 13:44:18.882487	我希望我能收到上周订购的包裹。	AI generated	elementary	\N	\N	\N
1962	The Thanksgiving preparation included roasting the poultry until golden brown.	poultry	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.331266	2025-07-09 13:44:18.882487	感恩节的准备工作包括把家禽烤到金黄色。	AI generated	elementary	\N	\N	\N
1964	The tension in the room was precise and palpable before the announcement.	tension	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.33127	2025-07-09 13:44:18.882488	在宣布消息之前，房间里的气氛紧张而明显。	AI generated	elementary	\N	\N	\N
1966	The cracked and weathered sculpture served as a warning against hubris.	warning	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.331274	2025-07-09 13:44:18.882488	这个破裂而饱经风霜的雕塑，是对骄傲自大的一种警告。	AI generated	elementary	\N	\N	\N
1968	The health inspector issued a warning about the improperly stored poultry.	poultry	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.331278	2025-07-09 13:44:22.601341	健康检查员发出了警告，因为家禽储存不当。	AI generated	elementary	\N	\N	\N
1970	His pottery class focused on preparation of the clay before creating the sculpture.	sculpture	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.331282	2025-07-09 13:44:22.601344	他的陶艺课主要教大家在做雕塑前怎么准备黏土。	AI generated	elementary	\N	\N	\N
1974	Her splendid performance overcame initial prejudice, earning her the lead role.	prejudice	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.42979	2025-07-09 13:44:22.601345	她精彩的表演克服了最初的偏见，让她赢得了主角。	AI generated	elementary	\N	\N	\N
1976	Honestly, I need that report immediately to finalize the presentation.	honestly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.432262	2025-07-09 13:44:22.601345	说实话，我需要马上拿到那份报告才能完成演示。	AI generated	elementary	\N	\N	\N
1978	Seeing the vibrant ladybug surprisingly dissolved some of her deep-seated prejudice.	ladybug	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.432265	2025-07-09 13:44:22.601345	看到那只鲜艳的瓢虫，竟然让她的一些偏见消失了。	AI generated	elementary	\N	\N	\N
1980	I'll gladly support your fundraising efforts by donating a large bag of popcorn.	support	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:36.432268	2025-07-09 13:44:22.601346	我很乐意捐一大包爆米花来支持你的筹款活动。	AI generated	elementary	\N	\N	\N
1984	The identity of the unknown assailant remained a mystery, but the police believed he was a skilful martial artist.	unknown	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.156905	2025-07-09 13:44:22.601347	那个不知名的袭击者是谁仍然是个谜，但警察认为他是个厉害的武术家。	AI generated	intermediate	\N	\N	\N
1986	The company aimed to develop a new software platform that would approximately double their user base within a year.	develop	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.166488	2025-07-09 13:44:22.601347	这家公司想开发一个新的软件平台，目标是在一年内让用户数量大约翻一番。	AI generated	intermediate	\N	\N	\N
1988	Finding a suitable replacement for the unknown ingredient proved surprisingly challenging for the chef.	replacement	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.166492	2025-07-09 13:44:26.441629	厨师发现，要找到一种合适的替代品来代替那种未知的配料，出乎意料地困难。	AI generated	elementary	\N	\N	\N
1990	The government invested heavily to develop infrastructure in the region, hoping to attract wealthy investors.	develop	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.166496	2025-07-09 13:44:26.441633	政府投入了很多钱来发展这个地区的基础设施，希望吸引有钱的投资人。	AI generated	intermediate	\N	\N	\N
1994	Personally, I find little utility in appliances that perform functions I can do easily myself.	utility	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.166503	2025-07-09 13:44:26.441635	我个人觉得，那些我自己能轻松完成功能的电器没什么用。	AI generated	intermediate	\N	\N	\N
1992	The wealthy inventor's latest project was a sophisticated machine designed to clean the ocean.	machine	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.166499	2025-07-09 13:44:26.441634	这位有钱的发明家最新的项目是一台复杂的机器，用来清理海洋。	AI generated	elementary	\N	\N	\N
2016	During the heated argument, she noticed the glint of a single earring on the floor.	argument	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.223185	2025-07-09 13:44:30.109145	在激烈的争吵中，她注意到地板上有一只耳环闪着光。	AI generated	intermediate	\N	\N	\N
1996	The recipient listened intently to the speaker's final conclusion about the project.	recipient	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.181422	2025-07-09 13:44:26.441635	听众认真地听着演讲者关于这个项目的最终结论。	AI generated	elementary	\N	\N	\N
1998	The company's anniversary celebration included a presentation about its history and future goals.	celebration	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.188587	2025-07-09 13:44:26.441636	公司的周年庆典包括一个关于公司历史和未来目标的展示。	AI generated	elementary	\N	\N	\N
2000	His simple gesture of kindness helped improve the tense climate between them.	gesture	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.192776	2025-07-09 13:44:26.441637	他简单的善意举动帮助改善了他们之间紧张的气氛。	AI generated	elementary	\N	\N	\N
2002	The new railway station will have convenient parking for commuters.	railway	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.197639	2025-07-09 13:44:26.441637	新的火车站将为通勤者提供方便的停车位。	AI generated	elementary	\N	\N	\N
2004	The annual town celebration always includes games at the local playground.	playground	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.197642	2025-07-09 13:44:26.441638	一年一度的城镇庆祝活动总是包括在当地游乐场玩游戏。	AI generated	elementary	\N	\N	\N
2006	Her perfect performance demonstrated that she was a highly experienced musician.	perfect	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.197645	2025-07-09 13:44:26.441638	她完美的表演表明她是一位非常有经验的音乐家。	AI generated	elementary	\N	\N	\N
2008	Her chosen profession, writing novels, allowed her to create any setting she desired.	profession	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.2108	2025-07-09 13:44:30.10914	她选择的职业是写小说，这让她可以创造任何她想要的故事场景。	AI generated	elementary	\N	\N	\N
2010	The project manager appreciated the team's suggestion to implement a new agile workflow.	suggestion	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.219752	2025-07-09 13:44:30.109144	项目经理很感谢团队提出的采用新的敏捷工作流程的建议。	AI generated	elementary	\N	\N	\N
2012	The innocent girl stood on the balcony, enjoying the sunset.	innocent	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.223179	2025-07-09 13:44:30.109144	天真的小女孩站在阳台上，欣赏着日落。	AI generated	elementary	\N	\N	\N
2014	As a loyal companion, the dog followed the manager everywhere.	companion	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.223182	2025-07-09 13:44:30.109145	作为忠诚的伙伴，这只狗总是跟着经理。	AI generated	elementary	\N	\N	\N
2018	The revolution strengthened their friendship, forged in shared hardship.	revolution	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.223188	2025-07-09 13:44:30.109146	革命加强了他们的友谊，那是他们在共同的困难中建立起来的。	AI generated	elementary	\N	\N	\N
2020	The entire premise of their argument relies on the availability of a vital resource.	premise	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.244873	2025-07-09 13:44:30.109146	他们争论的整个前提都依赖于一种重要资源是否能获得。	AI generated	elementary	\N	\N	\N
2034	Words could not describe the breathtaking spectacle of the aurora borealis dancing across the night sky.	describe	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:40.919709	2025-07-09 13:44:33.547163	美丽的北极光在夜空中舞动，简直无法用语言来形容。	AI generated	intermediate	\N	\N	\N
2022	The basic premise is that the device will function flawlessly under pressure.	function	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.247756	2025-07-09 13:44:30.109147	基本前提是这个设备在压力下也能完美运行。	AI generated	elementary	\N	\N	\N
2040	He felt deeply disappointed by the revelation that his entire identity was based on a lie.	disappointed	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:40.919726	2025-07-09 13:44:33.547165	当他发现自己的人生竟然建立在一个谎言上时，他感到非常失望。	AI generated	intermediate	\N	\N	\N
2024	Seeing a giraffe next to a dinosaur skeleton in the museum was quite jarring.	giraffe	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.247759	2025-07-09 13:44:30.109148	在博物馆里看到长颈鹿和恐龙骨架放在一起，感觉很不协调。	AI generated	elementary	\N	\N	\N
2026	I need the original receipt to get my passport back from the embassy.	receipt	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.247762	2025-07-09 13:44:30.109148	我需要原始收据才能从大使馆拿回我的护照。	AI generated	elementary	\N	\N	\N
2028	The new software seems to function somewhat better than the older version.	somewhat	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.247765	2025-07-09 13:44:33.547158	新的软件好像比旧的版本好用一点。	AI generated	elementary	\N	\N	\N
2030	The baby giraffe seemed somewhat overwhelmed by the attention it was getting.	giraffe	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:37.247768	2025-07-09 13:44:33.547161	小长颈鹿看起来有点被大家的关注吓到了。	AI generated	elementary	\N	\N	\N
2032	The pedestrian looked utterly confused by the sudden change in traffic patterns.	pedestrian	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:40.919698	2025-07-09 13:44:33.547162	行人看起来完全搞不懂突然改变的交通规则。	AI generated	elementary	\N	\N	\N
2036	I was disappointed when my spiritual leader announced he was leaving the community.	disappointed	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:40.919714	2025-07-09 13:44:33.547163	当我的精神领袖宣布他要离开大家时，我很失望。	AI generated	elementary	\N	\N	\N
2038	She was disappointed to learn that the painting was not an original after all.	original	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:40.91972	2025-07-09 13:44:33.547164	得知那幅画原来不是真迹，她感到很失望。	AI generated	elementary	\N	\N	\N
2042	A fancy mirror was recovered from the pedestrian's wardrobe after the theft.	pedestrian	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:40.919731	2025-07-09 13:44:33.547165	盗窃案发生后，人们从那个行人的衣柜里找到了一面漂亮的镜子。	AI generated	elementary	\N	\N	\N
2044	You should wear your coat because there is snow outside today.	wear	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.032655	2025-07-09 13:44:33.547166	你应该穿上外套，因为今天外面下雪了。	AI generated	elementary	\N	\N	\N
2046	The studio needs a strong signal to record the music.	studio	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.043973	2025-07-09 13:44:33.547166	录音棚需要一个很强的信号才能录制音乐。	AI generated	elementary	\N	\N	\N
2048	For the last decade, people say 'hi' on the phone differently.	decade	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.043977	2025-07-09 13:44:37.566292	过去十年，人们在电话里说“你好”的方式不一样了。	AI generated	elementary	\N	\N	\N
2050	I like to swing there when the sun is out and warm.	swing	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.04398	2025-07-09 13:44:37.566296	太阳出来暖洋洋的时候，我喜欢在那里荡秋千。	AI generated	elementary	\N	\N	\N
2052	Let's swing by the studio later this afternoon, okay?	studio	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.043984	2025-07-09 13:44:37.566296	咱们今天下午晚点儿去一下工作室，好吗？	AI generated	elementary	\N	\N	\N
2054	I said 'hi' and offered him a cookie at the party.	hi	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.043987	2025-07-09 13:44:37.566297	我在聚会上说了“你好”，还给了他一块饼干。	AI generated	elementary	\N	\N	\N
2056	The scientist studied the nutritional content of each vegetable meticulously in her lab.	scientist	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.139403	2025-07-09 13:44:37.566298	科学家在她的实验室里仔细研究每种蔬菜的营养成分。	AI generated	elementary	\N	\N	\N
2058	He had a strange feeling that this semester would be different from all the others.	feeling	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.144509	2025-07-09 13:44:37.566298	他有一种奇怪的感觉，这个学期会和以前所有学期都不一样。	AI generated	intermediate	\N	\N	\N
2060	A balanced diet including a variety of vegetable options is a basic requirement for good health.	requirement	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.144513	2025-07-09 13:44:37.566299	均衡的饮食，包括各种各样的蔬菜，是身体健康的基本要求。	AI generated	intermediate	\N	\N	\N
2062	Overwhelmed by the project's requirement, she couldn't shake the feeling of inadequacy.	feeling	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.144516	2025-07-09 13:44:37.566299	她被项目的要求压得喘不过气，摆脱不了自己不够好的感觉。	AI generated	elementary	\N	\N	\N
2064	Careful reading of the instructions is a key requirement for completing the experiment successfully.	requirement	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.14452	2025-07-09 13:44:37.5663	仔细阅读说明书是成功完成实验的关键要求。	AI generated	elementary	\N	\N	\N
2066	This semester, the school garden will provide fresh vegetable options for the cafeteria.	semester	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.147605	2025-07-09 13:44:37.566301	这个学期，学校的花园将为食堂提供新鲜的蔬菜。	AI generated	elementary	\N	\N	\N
2068	The bird's nest was empty in the spring.	empty	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.225996	2025-07-09 13:44:40.433111	春天的时候，鸟窝是空的。	AI generated	elementary	\N	\N	\N
2070	I rarely see a shark when I swim in the ocean.	shark	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.24173	2025-07-09 13:44:40.433113	我在海里游泳的时候，很少看到鲨鱼。	AI generated	elementary	\N	\N	\N
2072	I like to eat cheese after washing with soap.	soap	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.241734	2025-07-09 13:44:40.433114	我喜欢用肥皂洗完东西后吃奶酪。	AI generated	elementary	\N	\N	\N
2074	I use the soap every day to wash my hands.	day	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.241737	2025-07-09 13:44:40.433114	我每天都用肥皂洗手。	AI generated	elementary	\N	\N	\N
2076	The mountain climb was difficult, but my lover helped me.	lover	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.24174	2025-07-09 13:44:40.433115	爬山很难，但是我的爱人帮助了我。	AI generated	elementary	\N	\N	\N
2078	The soap smelled like the ocean, and I fear a shark would like it.	shark	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.241744	2025-07-09 13:44:40.433115	肥皂闻起来像大海，我害怕鲨鱼会喜欢它。	AI generated	elementary	\N	\N	\N
2080	The manager made a last-minute appeal to copy the file again.	appeal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.261531	2025-07-09 13:44:40.433115	经理在最后一刻呼吁再次复制文件。	AI generated	elementary	\N	\N	\N
2084	I tend to think he is a good player.	tend	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.265386	2025-07-09 13:44:40.433116	我倾向于认为他是一个好球员。	AI generated	elementary	\N	\N	\N
2086	Take a deep breath and enjoy life more.	breath	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.269589	2025-07-09 13:44:40.433116	深呼吸，更好地享受生活。	AI generated	elementary	\N	\N	\N
2088	He had something in his eye, so he tried to spit it out.	eye	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.269593	2025-07-09 13:44:40.433117	他的眼睛里进了东西，所以他想把它吐出来。	AI generated	elementary	\N	\N	\N
2090	She took a deep breath, closing her eye.	breath	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.269596	2025-07-09 13:44:44.845624	她深吸一口气，闭上了眼睛。	AI generated	elementary	\N	\N	\N
2092	In the dark, I couldn't feel my pulse.	pulse	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.44193	2025-07-09 13:44:44.845628	在黑暗中，我感觉不到我的脉搏。	AI generated	elementary	\N	\N	\N
2094	He took a wide swing and landed a strong punch.	wide	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.457455	2025-07-09 13:44:44.845628	他用力挥了一下，狠狠地打了一拳。	AI generated	elementary	\N	\N	\N
2096	Don't worry; his quest is almost complete.	worry	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.457459	2025-07-09 13:44:44.845629	别担心，他的任务快要完成了。	AI generated	elementary	\N	\N	\N
2098	The thick soup made a big punch of flavor.	punch	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.457462	2025-07-09 13:44:44.845629	浓汤的味道非常浓郁。	AI generated	elementary	\N	\N	\N
2100	A sudden punch tore through the thin veil.	punch	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:41.457466	2025-07-09 13:44:44.84563	突然的一击穿透了薄薄的面纱。	AI generated	elementary	\N	\N	\N
2104	Can I borrow your toy weapon for my game, please?	borrow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.777342	2025-07-09 13:44:44.84563	我可以借你的玩具武器玩游戏吗？	AI generated	elementary	\N	\N	\N
2106	The angry crowd's demand was for the king to give up his weapon.	weapon	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.777377	2025-07-09 13:44:44.845631	愤怒的人群要求国王放弃他的武器。	AI generated	elementary	\N	\N	\N
2108	It was a silly puzzle to fight over, but they did anyway.	puzzle	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.777382	2025-07-09 13:44:44.845631	为一个傻傻的谜题争吵，但他们还是吵了。	AI generated	elementary	\N	\N	\N
2110	The teacher used a simple verse to explain the math puzzle.	puzzle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.777387	2025-07-09 13:44:44.845632	老师用一个简单的诗句来解释数学难题。	AI generated	elementary	\N	\N	\N
2112	I rub my knee after I fell off my bike.	rub	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.777391	2025-07-09 13:44:47.82132	我从自行车上摔下来后，揉了揉我的膝盖。	AI generated	elementary	\N	\N	\N
2114	The knights used a special verse and a sword to fight.	verse	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.777395	2025-07-09 13:44:47.821324	骑士们用特别的诗句和剑来战斗。	AI generated	elementary	\N	\N	\N
2116	The new app user must register as a voter first.	user	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.859803	2025-07-09 13:44:47.821325	新的应用程序用户必须先注册成为选民。	AI generated	elementary	\N	\N	\N
2118	Every voter hopes the new king will build a grand palace.	voter	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.862836	2025-07-09 13:44:47.821326	每个选民都希望新国王会建造一座宏伟的宫殿。	AI generated	elementary	\N	\N	\N
2120	After the long trip, I really tire of tone deaf singers.	tire	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.869992	2025-07-09 13:44:47.821326	经过长途旅行后，我真的厌倦了五音不全的歌手。	AI generated	elementary	\N	\N	\N
2122	She does not know how to say the prayer.	does	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.869995	2025-07-09 13:44:47.821327	她不知道该怎么念祷告词。	AI generated	elementary	\N	\N	\N
2124	The zebra does have a black and white stripe.	does	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.869999	2025-07-09 13:44:47.821327	斑马确实有黑白条纹。	AI generated	elementary	\N	\N	\N
2126	The movie script included a scene with a rhino.	script	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:44.870002	2025-07-09 13:44:47.821328	电影剧本包含一个有犀牛的场景。	AI generated	elementary	\N	\N	\N
2128	I don't want you to shake; you can trust me; it's easy!	shake	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.075977	2025-07-09 13:44:47.821329	我不想让你害怕；你可以相信我；这很简单！	AI generated	elementary	\N	\N	\N
2131	I saw a blind tiger in the zoo today.	blind	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.09347	2025-07-09 13:44:47.821329	今天我在动物园里看到了一只瞎了眼睛的老虎。	AI generated	elementary	\N	\N	\N
2133	The bride wanted to marry under the olive tree.	marry	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.093473	2025-07-09 13:44:50.888625	新娘想在橄榄树下结婚。	AI generated	elementary	\N	\N	\N
2135	Don't rush; the bag is made of strong nylon.	nylon	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.093477	2025-07-09 13:44:50.888629	别着急，这个包是用结实的尼龙做的。	AI generated	elementary	\N	\N	\N
2137	Planting a flower helps build trust with nature.	flower	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.09348	2025-07-09 13:44:50.88863	种一朵花可以帮助建立对自然的信任。	AI generated	elementary	\N	\N	\N
2139	The scared child started to shake when he saw the huge tiger.	shake	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.093484	2025-07-09 13:44:50.888631	那个害怕的孩子看到大老虎时开始发抖。	AI generated	elementary	\N	\N	\N
2141	The junior chef learned how to cook the soup today.	junior	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.215535	2025-07-09 13:44:50.888632	初级厨师今天学会了怎么做汤。	AI generated	elementary	\N	\N	\N
2144	She is the leader and will stitch the team together.	leader	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.231414	2025-07-09 13:44:50.888632	她是领导者，会把团队团结在一起。	AI generated	elementary	\N	\N	\N
2146	At the hostel, I learned how to cook a simple meal.	hostel	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.231417	2025-07-09 13:44:50.888633	在旅馆里，我学会了怎么做简单的饭菜。	AI generated	elementary	\N	\N	\N
2149	To what extent did you study for the exam?	extent	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.231423	2025-07-09 13:44:50.888634	你为考试复习了多少？	AI generated	elementary	\N	\N	\N
2151	Can you bring me the book, and tell me how to read it?	bring	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.231426	2025-07-09 13:44:50.888634	你能把书给我，并告诉我怎么读吗？	AI generated	elementary	\N	\N	\N
2153	The junior cook learned some new skills today.	junior	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.23143	2025-07-09 13:44:50.888635	初级厨师今天学到了一些新技能。	AI generated	elementary	\N	\N	\N
2155	The small shop owner had hope that the market would improve soon.	hope	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.572926	2025-07-09 13:44:53.450206	小商店的老板希望市场很快会变好。	AI generated	elementary	\N	\N	\N
2162	He offered a bag of round chips to his friend.	round	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.584902	2025-07-09 13:44:53.450209	他给他的朋友一袋圆圆的薯片。	AI generated	elementary	\N	\N	\N
2164	I need to pump air into the ball, but don't touch it yet!	pump	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.584906	2025-07-09 13:44:53.45021	我需要给球打气，但是先别碰它！	AI generated	elementary	\N	\N	\N
2166	We can pump water from the well, and I hope it works.	pump	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.584909	2025-07-09 13:44:53.45021	我们可以从井里抽水，我希望它能用。	AI generated	elementary	\N	\N	\N
2168	The mayor asked us to visit the new park.	mayor	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.641252	2025-07-09 13:44:53.450211	市长请我们去参观新的公园。	AI generated	elementary	\N	\N	\N
2170	The grey clouds reminded her of the past.	grey	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.654124	2025-07-09 13:44:53.450211	灰色的云让她想起了过去。	AI generated	elementary	\N	\N	\N
2172	The brave knight showed his sword to the mayor.	sword	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.654127	2025-07-09 13:44:53.450212	勇敢的骑士向市长展示了他的剑。	AI generated	elementary	\N	\N	\N
2174	I want to shoot photos of the past buildings.	shoot	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.654131	2025-07-09 13:44:53.450212	我想拍摄过去的建筑物。	AI generated	elementary	\N	\N	\N
2176	We walked up the hill, thinking about the past.	hill	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.654134	2025-07-09 13:44:53.450213	我们走上山坡，想着过去的事情。	AI generated	elementary	\N	\N	\N
2178	Can you jump over that small figure there?	figure	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:45.654138	2025-07-09 13:44:53.450213	你能跳过那边的那个小人吗？	AI generated	elementary	\N	\N	\N
2180	The quiet, narrow path led to a secret garden.	quiet	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:48.612395	2025-07-09 13:44:56.473831	安静、狭窄的小路通向一个秘密花园。	AI generated	elementary	\N	\N	\N
2182	The harvest moon made the event feel magical.	event	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:48.612403	2025-07-09 13:44:56.473836	收获的月亮让活动感觉很神奇。	AI generated	elementary	\N	\N	\N
2184	I swear the coin was made of real silver!	swear	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:48.612408	2025-07-09 13:44:56.473837	我发誓这枚硬币真的是用银做的！	AI generated	elementary	\N	\N	\N
2186	I swear I saw a strange symbol on the stone.	stone	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:48.612412	2025-07-09 13:44:56.473838	我发誓我看到石头上有一个奇怪的符号。	AI generated	elementary	\N	\N	\N
2188	I will post the cheque tomorrow morning.	post	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:48.612416	2025-07-09 13:44:56.473838	我明天早上会把支票寄出去。	AI generated	elementary	\N	\N	\N
2190	The event featured a beautiful silver trophy.	event	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:48.612421	2025-07-09 13:44:56.473839	活动有一个漂亮的银色奖杯。	AI generated	elementary	\N	\N	\N
2192	Being a smart student is good for your health.	smart	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.224181	2025-07-09 13:44:56.47384	做一个聪明的学生对你的健康有好处。	AI generated	elementary	\N	\N	\N
2194	The girl sat in the shade to read her book.	shade	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.236465	2025-07-09 13:44:56.47384	女孩坐在树荫下看书。	AI generated	elementary	\N	\N	\N
2196	Do not steal or smoke, it is wrong.	steal	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.236469	2025-07-09 13:44:56.473841	不要偷东西或吸烟，这是不对的。	AI generated	elementary	\N	\N	\N
2220	I like to fall asleep listening to my online class.	online	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.468015	2025-07-09 13:45:03.177319	我喜欢听着网课入睡。	AI generated	elementary	\N	\N	\N
2198	The tree's shade hid the rising smoke from the fire.	shade	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.236472	2025-07-09 13:44:56.473842	树荫挡住了火升起的烟。	AI generated	elementary	\N	\N	\N
2222	With age comes wisdom, and every state benefits from it.	wisdom	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.468019	2025-07-09 13:45:03.177325	年龄越大，智慧越多，每个地方都能从中受益。	AI generated	elementary	\N	\N	\N
2200	The boy hiked through the green valley.	boy	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.236476	2025-07-09 13:44:59.696608	男孩穿过绿色的山谷去远足。	AI generated	elementary	\N	\N	\N
2224	My grandma's wisdom is shown in her long grey hair.	wisdom	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.471885	2025-07-09 13:45:03.177325	我奶奶的智慧体现在她长长的灰头发上。	AI generated	elementary	\N	\N	\N
2202	The smart dog likes to chase the ball.	smart	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.240499	2025-07-09 13:44:59.696612	聪明的狗狗喜欢追球。	AI generated	elementary	\N	\N	\N
2226	The loss was a high stake for our neighborhood.	loss	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.471889	2025-07-09 13:45:03.177326	这次失败对我们社区来说损失很大。	AI generated	elementary	\N	\N	\N
2204	The short trip up the mountain helped me check the scale of the damage.	trip	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.256454	2025-07-09 13:44:59.696613	爬上这座山的短途旅行帮助我检查了损坏的程度。	AI generated	elementary	\N	\N	\N
2228	I woke up late, and thus I missed the bus to school.	thus	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.76096	2025-07-09 13:45:03.177327	我醒晚了，所以错过了去学校的公交车。	AI generated	elementary	\N	\N	\N
2206	The poem about bees tasted sweet like honey.	poem	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.259121	2025-07-09 13:44:59.696614	关于蜜蜂的诗歌尝起来像蜂蜜一样甜。	AI generated	elementary	\N	\N	\N
2230	The little mouse made a pile of crumbs by the table.	mouse	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.775047	2025-07-09 13:45:03.177327	小老鼠在桌子旁边堆了一小堆面包屑。	AI generated	elementary	\N	\N	\N
2208	I lost the cap to my drink, so I want a refund.	cap	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.26815	2025-07-09 13:44:59.696614	我的饮料盖子丢了，所以我想要退款。	AI generated	elementary	\N	\N	\N
2232	Let's play a game while we figure out the plot.	play	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.775051	2025-07-09 13:45:03.177328	我们一边玩游戏，一边想出故事的情节吧。	AI generated	elementary	\N	\N	\N
2210	This tube is full of raw paint pigment.	tube	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.268154	2025-07-09 13:44:59.696615	这个管子里装满了生的颜料。	AI generated	elementary	\N	\N	\N
2234	Our love is pure and bright like the sun.	pure	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.775054	2025-07-09 13:45:03.177328	我们的爱像太阳一样纯洁明亮。	AI generated	elementary	\N	\N	\N
2212	The media showed a picture of a bald eagle.	media	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.268156	2025-07-09 13:44:59.696615	媒体展示了一张秃鹰的照片。	AI generated	elementary	\N	\N	\N
2236	Can you lend me your book about the pirate plot?	plot	SVOO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.775058	2025-07-09 13:45:03.177329	你可以借给我你的那本关于海盗故事的书吗？	AI generated	elementary	\N	\N	\N
2214	The media said that local honey can help with coughs.	media	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.268159	2025-07-09 13:44:59.696616	媒体说本地蜂蜜可以帮助缓解咳嗽。	AI generated	elementary	\N	\N	\N
2238	There is a big pile of books on the floor.	pile	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.775061	2025-07-09 13:45:03.17733	地板上有一大堆书。	AI generated	elementary	\N	\N	\N
2240	Playing the piano after dinner is a good habit to have.	piano	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.842835	2025-07-09 13:45:07.322875	晚饭后弹钢琴是个好习惯。	AI generated	elementary	\N	\N	\N
2218	I don't know why you waste your time on things that don't matter.	why	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.468012	2025-07-09 13:44:59.696617	我不知道你为什么把时间浪费在不重要的事情上。	AI generated	elementary	\N	\N	\N
2216	I watched my new sweater shrink when it started to fall off the washing line.	shrink	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.4524	2025-07-09 13:44:59.696616	我看到我的新毛衣开始从晾衣绳上掉下来时缩水了。	AI generated	intermediate	\N	\N	\N
2242	The gang played basketball outside on a sunny afternoon.	gang	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.853143	2025-07-09 13:45:07.322879	在一个阳光明媚的下午，那群小伙伴在外面打篮球。	AI generated	elementary	\N	\N	\N
2244	My tooth feels a little loose today, I should see a dentist.	loose	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.853147	2025-07-09 13:45:07.32288	我今天觉得牙齿有点松，应该去看牙医。	AI generated	elementary	\N	\N	\N
2252	The long shadow of the tree made it hard to see the ruler on the grass.	shadow	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.648757	2025-07-09 13:45:07.322883	树的影子太长了，很难看到草地上的尺子。	AI generated	intermediate	\N	\N	\N
2246	She played the piano while he mashed the potato for dinner.	piano	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.85977	2025-07-09 13:45:07.322881	她弹钢琴，他捣土豆泥做晚饭。	AI generated	elementary	\N	\N	\N
2263	Be careful not to lose sight of the path when walking through the tree farm.	lose	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.6488	2025-07-09 13:45:10.841169	穿过树木农场时，小心不要看不到路了。	AI generated	intermediate	\N	\N	\N
2248	The piano lesson is scheduled for today at 3 PM.	piano	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.859774	2025-07-09 13:45:07.322882	钢琴课安排在今天下午3点。	AI generated	elementary	\N	\N	\N
2250	The gang leader was known to be an honest man.	gang	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:49.859778	2025-07-09 13:45:07.322882	那个团伙头目以诚实著称。	AI generated	elementary	\N	\N	\N
2255	The number of hours of labor needed to build the house was very high.	number	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.648783	2025-07-09 13:45:07.322884	建造这所房子需要花费很长时间。	AI generated	elementary	\N	\N	\N
2257	I will lose my place if I lose focus.	lose	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.648787	2025-07-09 13:45:07.322884	如果我不集中注意力，我会迷失方向。	AI generated	elementary	\N	\N	\N
2259	Please share your paper with your friend so they can finish their work.	paper	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.648792	2025-07-09 13:45:07.322885	请和你的朋友分享你的作业，这样他们才能完成他们的工作。	AI generated	elementary	\N	\N	\N
2261	I have a lot of yummy stuff in my lunch box today.	stuff	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.648796	2025-07-09 13:45:10.841166	我今天午餐盒里有很多好吃的东西。	AI generated	elementary	\N	\N	\N
2265	I fear to put my foot in the cold lake.	fear	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.950245	2025-07-09 13:45:10.84117	我害怕把脚放到冰冷的湖里。	AI generated	elementary	\N	\N	\N
2267	I wanted to escape, so I turned up the stereo.	stereo	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.953763	2025-07-09 13:45:10.841171	我想逃离，所以我把音响声音调大了。	AI generated	elementary	\N	\N	\N
2269	The range of flowers in her garden is very good.	range	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.953766	2025-07-09 13:45:10.841171	她花园里的花种类很多，非常好。	AI generated	elementary	\N	\N	\N
2271	The range of the signal does not matter to me.	range	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.95377	2025-07-09 13:45:10.841172	信号的范围对我来说不重要。	AI generated	elementary	\N	\N	\N
2273	I hope they find a cure and he can roll again.	cure	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.953773	2025-07-09 13:45:10.841173	我希望他们能找到治疗方法，让他能再次滚动（轮椅/滑板等）。	AI generated	elementary	\N	\N	\N
2275	Please cover the books before you tip them over.	cover	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.953776	2025-07-09 13:45:10.841173	请在把书弄倒之前，先盖好它们。	AI generated	elementary	\N	\N	\N
2277	The doctor gave her a pill for her headache, a scheme to get better.	pill	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.963676	2025-07-09 13:45:10.841174	医生给了她一颗治疗头痛的药丸，这是个变好的计划。	AI generated	elementary	\N	\N	\N
2279	I will take a pill if my head starts to hurt again.	pill	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.975778	2025-07-09 13:45:10.841174	如果我的头再次开始疼，我会吃一颗药丸。	AI generated	elementary	\N	\N	\N
2281	The priest is aware of the needs of his community.	priest	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.975781	2025-07-09 13:45:13.722909	牧师知道他的社区需要什么。	AI generated	elementary	\N	\N	\N
2283	The queen's dress was beautiful and tight around her waist.	queen	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.975784	2025-07-09 13:45:13.722913	王后的裙子很漂亮，而且腰部很紧。	AI generated	elementary	\N	\N	\N
2285	His scheme was to clean the toilet every day.	toilet	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.979759	2025-07-09 13:45:13.722914	他的计划是每天打扫厕所。	AI generated	elementary	\N	\N	\N
2325	The large sea extended right up to the grand hall where the party was held.	sea	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.429608	2025-07-09 13:45:19.923192	广阔的大海一直延伸到举行聚会的大厅。	AI generated	intermediate	\N	\N	\N
2287	The conductor made sure the luggage was tight before the train left.	train	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:52.979762	2025-07-09 13:45:13.722914	列车员确保火车开动前行李都放好了。	AI generated	elementary	\N	\N	\N
2289	After the long day, she gave a big yawn in her luxury hotel room.	luxury	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.276698	2025-07-09 13:45:13.722915	漫长的一天后，她在豪华的酒店房间里打了个大大的哈欠。	AI generated	elementary	\N	\N	\N
2291	The fox needed a new strap for his bag to carry his food.	fox	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.292692	2025-07-09 13:45:13.722915	狐狸需要一个新的带子来装食物。	AI generated	elementary	\N	\N	\N
2293	It was ninety degrees, so the lazy cat slept all day.	ninety	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.292696	2025-07-09 13:45:13.722916	天气是九十度，所以懒猫睡了一整天。	AI generated	elementary	\N	\N	\N
2295	He joined the workers' union to fight for better pay.	he	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.297381	2025-07-09 13:45:13.722916	他加入了工会，为了争取更好的工资。	AI generated	elementary	\N	\N	\N
2299	He needed a new strap for his backpack before the hike.	he	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.297389	2025-07-09 13:45:13.722917	在徒步旅行之前，他需要一个新的背包带。	AI generated	elementary	\N	\N	\N
2301	She warmly offered to feed the stray cat outside.	warmly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.736164	2025-07-09 13:45:13.722918	她热情地提出要喂外面的流浪猫。	AI generated	elementary	\N	\N	\N
2303	I will sample the cake, then feed the rest to the birds.	sample	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.743328	2025-07-09 13:45:17.102648	我会尝尝这个蛋糕，然后把剩下的喂给小鸟。	AI generated	elementary	\N	\N	\N
2305	I feed my plants with special root powder.	feed	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.743332	2025-07-09 13:45:17.10265	我用特别的根粉喂我的植物。	AI generated	elementary	\N	\N	\N
2307	I will wait for it here till you return.	it	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.754396	2025-07-09 13:45:17.102651	我会在这里等你，直到你回来。	AI generated	elementary	\N	\N	\N
2309	The fresh air felt good after an hour inside.	air	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.7544	2025-07-09 13:45:17.102651	在屋里待了一个小时后，新鲜空气感觉真好。	AI generated	elementary	\N	\N	\N
2311	Her sharp wit was like a magical powder to make people laugh.	wit	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.754403	2025-07-09 13:45:17.102652	她敏锐的智慧就像神奇的粉末，能让人发笑。	AI generated	elementary	\N	\N	\N
2313	I will never use that net again to catch fish.	never	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.805985	2025-07-09 13:45:17.102652	我再也不会用那个网去抓鱼了。	AI generated	elementary	\N	\N	\N
2315	The local newspaper gave her the title of best volunteer.	title	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.815429	2025-07-09 13:45:17.102652	当地报纸给了她“最佳志愿者”的称号。	AI generated	elementary	\N	\N	\N
2317	The story had an eight word title.	eight	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.818203	2025-07-09 13:45:17.102653	这个故事有一个八个字的名字。	AI generated	elementary	\N	\N	\N
2319	I have eight apples and will never share them.	eight	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.818207	2025-07-09 13:45:17.102653	我有八个苹果，永远不会分享。	AI generated	elementary	\N	\N	\N
2321	The map helped me get to sleep faster while camping.	map	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.81821	2025-07-09 13:45:17.102654	这张地图帮助我在露营时更快入睡。	AI generated	elementary	\N	\N	\N
2323	I live in the local town near the park.	live	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:53.818213	2025-07-09 13:45:19.923187	我住在公园附近的镇子上。	AI generated	elementary	\N	\N	\N
2327	It is my duty to stand in this long queue and wait my turn.	duty	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.429616	2025-07-09 13:45:19.923193	排队等候轮到我是我的责任。	AI generated	elementary	\N	\N	\N
2329	My favorite sport is football, and I am turning twenty soon.	sport	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.429621	2025-07-09 13:45:19.923194	我最喜欢的运动是足球，我快要二十岁了。	AI generated	elementary	\N	\N	\N
2331	His sole focus was on building his wealth and achieving success.	sole	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.429625	2025-07-09 13:45:19.923194	他只想着挣钱和获得成功。	AI generated	elementary	\N	\N	\N
2333	I put a cherry on top of my ice cream while I waited in the queue.	cherry	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.42963	2025-07-09 13:45:19.923195	我在排队的时候，在冰淇淋上放了一颗樱桃。	AI generated	intermediate	\N	\N	\N
2335	After the big sport event, everyone gathered in the hall to celebrate.	sport	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.429634	2025-07-09 13:45:19.923196	大型运动会结束后，大家都聚集在大厅里庆祝。	AI generated	elementary	\N	\N	\N
2337	The doctor used a needle, but she showed mercy and was very quick.	needle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.468902	2025-07-09 13:45:19.923196	医生用了针，但她很仁慈，动作很快。	AI generated	elementary	\N	\N	\N
2339	We were bored looking at the old ruins all day in the hot sun.	ruins	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.481194	2025-07-09 13:45:19.923197	我们一整天在炎热的太阳下看旧废墟，觉得很无聊。	AI generated	elementary	\N	\N	\N
2341	A new suit is perfect for the pool party on Saturday.	suit	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.481197	2025-07-09 13:45:19.923197	一套新西装非常适合星期六的泳池派对。	AI generated	elementary	\N	\N	\N
2343	This grape juice has a strange origin, I wonder where it is from.	grape	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.484259	2025-07-09 13:45:22.828362	这个葡萄汁的味道很奇怪，我想知道它是哪里来的。	AI generated	elementary	\N	\N	\N
2345	He got bored looking at the giant beanstalk, so he went home.	bored	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.484262	2025-07-09 13:45:22.828364	他看着巨大的豆茎觉得很无聊，所以他就回家了。	AI generated	elementary	\N	\N	\N
2347	The loud noise made me jump when the needle dropped on the record.	needle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:56.48968	2025-07-09 13:45:22.828365	唱片上的针掉下来的时候，很大的声音吓了我一跳。	AI generated	elementary	\N	\N	\N
2349	The guest was allergic to peanut butter, so we made a different dessert.	guest	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.276971	2025-07-09 13:45:22.828365	客人对花生酱过敏，所以我们做了另一种甜点。	AI generated	elementary	\N	\N	\N
2351	The brick house has a solar panel on the roof to save energy.	brick	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.283154	2025-07-09 13:45:22.828366	这栋砖房的屋顶上有太阳能板，可以节省能源。	AI generated	elementary	\N	\N	\N
2353	The life guard saw a big wave coming and blew his whistle.	wave	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.285604	2025-07-09 13:45:22.828366	救生员看到一个大浪来了，就吹响了他的哨子。	AI generated	elementary	\N	\N	\N
2355	Can we swap my sandwich for your cookie at the cafe?	swap	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.296126	2025-07-09 13:45:22.828367	我们可以在咖啡馆把我的三明治和你饼干交换吗？	AI generated	elementary	\N	\N	\N
2357	The park is near the cafe, so we can walk there after lunch.	near	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.29613	2025-07-09 13:45:22.828367	公园在咖啡馆附近，所以我们午饭后可以走过去。	AI generated	elementary	\N	\N	\N
2359	The ship arrived at the port thanks to its solar powered navigation system.	solar	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.296133	2025-07-09 13:45:22.828367	这艘船靠着太阳能导航系统到达了港口。	AI generated	elementary	\N	\N	\N
2361	I will save money to buy a new car one day.	save	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.330013	2025-07-09 13:45:22.828368	我要存钱，有一天买一辆新车。	AI generated	elementary	\N	\N	\N
2363	It is wrong to kill animals just for pride.	kill	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.335217	2025-07-09 13:45:26.472604	为了炫耀而杀害动物是错误的。	AI generated	elementary	\N	\N	\N
2365	Can you draw a spicy pepper for the recipe book?	draw	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.33522	2025-07-09 13:45:26.472607	你能在食谱书上画一个辣辣椒吗？	AI generated	elementary	\N	\N	\N
2367	I want to speak English on my tour to London.	tour	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.337547	2025-07-09 13:45:26.472608	我想在去伦敦旅行的时候说英语。	AI generated	elementary	\N	\N	\N
2369	I need three days to search for my lost keys.	three	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.33755	2025-07-09 13:45:26.472608	我需要三天时间来找我丢失的钥匙。	AI generated	elementary	\N	\N	\N
2371	His rage was fueled by his wounded pride.	rage	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.337553	2025-07-09 13:45:26.472609	他的愤怒是被他受伤的自尊心激发的。	AI generated	elementary	\N	\N	\N
2373	The remote worker hoped for a better wage this year.	remote	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.798819	2025-07-09 13:45:26.472609	这位远程工作者希望今年能有更高的工资。	AI generated	elementary	\N	\N	\N
2399	The sudden loud noise gave the little kid a scare and the dog jumped with joy.	joy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:00.179937	2025-07-09 13:45:30.1341	突然的巨响吓了那个小孩一跳，狗狗高兴地跳了起来。	AI generated	intermediate	\N	\N	\N
2375	The core of the bamboo forest is where you might see a panda.	core	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.807264	2025-07-09 13:45:26.47261	竹林的核心地带是你可能看到熊猫的地方。	AI generated	elementary	\N	\N	\N
2409	If you plant a flower, the beautiful leaves will stem from it if you obey the care instructions.	stem	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.117734	2025-07-09 13:45:34.205499	如果你种一朵花，如果你按照说明照顾它，就会长出漂亮的叶子。	AI generated	intermediate	\N	\N	\N
2377	Hello, is the remote control working yet?	hello	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.810283	2025-07-09 13:45:26.47261	你好，遥控器能用了吗？	AI generated	elementary	\N	\N	\N
2379	Please stir the soup slowly over low heat.	stir	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.810286	2025-07-09 13:45:26.472611	请用小火慢慢搅拌汤。	AI generated	elementary	\N	\N	\N
2381	Hello, I will bring the cookies on a tray.	tray	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.810289	2025-07-09 13:45:26.472612	你好，我会用托盘把饼干拿来。	AI generated	elementary	\N	\N	\N
2383	I left the remote on that red tray.	tray	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.810292	2025-07-09 13:45:30.134094	我把遥控器放在那个红色的托盘上了。	AI generated	elementary	\N	\N	\N
2385	The rain will freeze if it gets much colder tonight.	freeze	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.820957	2025-07-09 13:45:30.134097	如果今晚更冷的话，雨会结冰。	AI generated	elementary	\N	\N	\N
2387	The teacher said that 'run' is a verb, even when it rains.	verb	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.828607	2025-07-09 13:45:30.134097	老师说“跑”是一个动词，即使下雨的时候也是。	AI generated	elementary	\N	\N	\N
2389	We learned a new theory about how birds fly.	we	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.82861	2025-07-09 13:45:30.134098	我们学了一个关于鸟儿怎么飞的新理论。	AI generated	elementary	\N	\N	\N
2391	I left a note because I saw a threat on the door.	note	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.835669	2025-07-09 13:45:30.134098	我留了一张纸条，因为我看到门上有威胁。	AI generated	elementary	\N	\N	\N
2393	The scope of the cold weather will freeze the lake.	freeze	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.835672	2025-07-09 13:45:30.134099	寒冷天气的范围会把湖冻住。	AI generated	elementary	\N	\N	\N
2395	The design flaw was a threat to the building's safety.	design	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:42:57.835675	2025-07-09 13:45:30.134099	设计上的错误对建筑物的安全是个威胁。	AI generated	elementary	\N	\N	\N
2397	The muddy soil got all over me when I fell.	me	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:00.168375	2025-07-09 13:45:30.1341	我摔倒的时候，泥土弄得我全身都是。	AI generated	elementary	\N	\N	\N
2401	I heard a loud bang, and only then did I feel the scare.	then	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:00.185785	2025-07-09 13:45:30.134101	我听到一声巨响，然后才感到害怕。	AI generated	elementary	\N	\N	\N
2403	I bumped my wrist on the window sill.	window	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:00.185789	2025-07-09 13:45:34.205493	我的手腕撞到窗台上了。	AI generated	elementary	\N	\N	\N
2405	The plant will suck up water from the dry soil.	suck	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:00.185792	2025-07-09 13:45:34.205497	植物会从干燥的土壤里吸收水分。	AI generated	elementary	\N	\N	\N
2407	Please keep this toy with me!	me	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:00.185796	2025-07-09 13:45:34.205498	请把这个玩具和我放在一起！	AI generated	elementary	\N	\N	\N
2411	Only one wrong move made her feel panic.	one	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.130309	2025-07-09 13:45:34.205499	只是一个错误的举动就让她感到恐慌。	AI generated	elementary	\N	\N	\N
2413	The rose's stem broke under the mass of snow.	stem	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.13593	2025-07-09 13:45:34.2055	玫瑰的茎在积雪的重压下断了。	AI generated	elementary	\N	\N	\N
2415	The stem of the plant vibrated with the loud music.	stem	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.135934	2025-07-09 13:45:34.205501	植物的茎随着响亮的音乐震动。	AI generated	elementary	\N	\N	\N
2417	Their first date caused her immediate panic.	date	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.135938	2025-07-09 13:45:34.205501	他们的第一次约会让她立刻感到恐慌。	AI generated	elementary	\N	\N	\N
2419	The famous singer's clothes were very plain.	plain	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.135942	2025-07-09 13:45:34.205502	那位著名歌手的衣服很朴素。	AI generated	elementary	\N	\N	\N
2421	The bright red laser pointer made the cat upset and jump.	laser	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.153985	2025-07-09 13:45:34.205502	鲜红色的激光笔让猫咪心烦意乱，跳了起来。	AI generated	elementary	\N	\N	\N
2423	Please put the lid back on, and return the jar to the shelf.	lid	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.162196	2025-07-09 13:45:37.422937	请把盖子盖回去，然后把罐子放回架子上。	AI generated	elementary	\N	\N	\N
2425	I will play with my toys while my dad fixes the laser printer.	while	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.162199	2025-07-09 13:45:37.422941	爸爸修激光打印机的时候，我要玩我的玩具。	AI generated	elementary	\N	\N	\N
2427	I am happy, but I get upset when I drop my ice cream.	happy	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.162202	2025-07-09 13:45:37.422942	我很高兴，但是冰淇淋掉地上的时候我会难过。	AI generated	elementary	\N	\N	\N
2429	Let's mix the paint colors, then return the brushes to the jar.	mix	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.162205	2025-07-09 13:45:37.422942	我们来混合颜料，然后把刷子放回罐子里。	AI generated	elementary	\N	\N	\N
2431	The scary movie on the screen made the little boy upset.	screen	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.162208	2025-07-09 13:45:37.422943	屏幕上的恐怖电影让小男孩很难过。	AI generated	elementary	\N	\N	\N
2433	The little baby saw a green frog near the pond.	frog	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.176997	2025-07-09 13:45:37.422943	小宝宝在池塘边看到了一只绿色的青蛙。	AI generated	elementary	\N	\N	\N
2435	The frog must pay tax if he wants to buy the lily pad.	frog	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.180178	2025-07-09 13:45:37.422943	如果青蛙想买荷叶，它必须交税。	AI generated	elementary	\N	\N	\N
2437	The roller coaster thrill is not on my list today.	thrill	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.183435	2025-07-09 13:45:37.422944	今天我不想玩刺激的过山车。	AI generated	elementary	\N	\N	\N
2439	The truth is, the baby loves his mom.	truth	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.183438	2025-07-09 13:45:37.422944	事实是，宝宝爱他的妈妈。	AI generated	elementary	\N	\N	\N
2441	I made a list of fruits like peach and apple.	peach	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.183441	2025-07-09 13:45:37.422945	我列了一个水果清单，比如桃子和苹果。	AI generated	elementary	\N	\N	\N
2443	She felt the thrill end as she weakly stood up.	thrill	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.183444	2025-07-09 13:45:40.366698	她觉得兴奋结束了，因为她虚弱地站了起来。	AI generated	elementary	\N	\N	\N
2445	I like to spend time away from school.	spend	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.272029	2025-07-09 13:45:40.366703	我喜欢放学后玩。	AI generated	elementary	\N	\N	\N
2447	Please remind me to stretch my leg after running.	remind	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.285858	2025-07-09 13:45:40.366704	请提醒我跑步后要拉伸腿。	AI generated	elementary	\N	\N	\N
2449	I have a small toy car in my hand.	hand	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.285861	2025-07-09 13:45:40.366704	我手里有一个小玩具汽车。	AI generated	elementary	\N	\N	\N
2451	A buzzing insect landed near the tennis court.	tennis	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.285865	2025-07-09 13:45:40.366705	一只嗡嗡叫的虫子落在网球场附近。	AI generated	elementary	\N	\N	\N
2453	The tender plant grew fast according to the graph.	tender	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.285868	2025-07-09 13:45:40.366705	根据图表，这棵嫩嫩的植物长得很快。	AI generated	elementary	\N	\N	\N
2455	I claim I saw a big insect outside.	claim	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.285872	2025-07-09 13:45:40.366706	我说我看到外面有一只大虫子。	AI generated	elementary	\N	\N	\N
2457	The ripe apple won a medal at the fair.	ripe	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.907589	2025-07-09 13:45:40.366707	这个熟苹果在集市上得了一个奖牌。	AI generated	elementary	\N	\N	\N
2459	The rubber band has great value because it helps me.	rubber	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.91065	2025-07-09 13:45:40.366707	橡皮筋很有用，因为它能帮助我。	AI generated	elementary	\N	\N	\N
2461	A little seed blew down the street.	street	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.910654	2025-07-09 13:45:40.366708	一颗小小的种子被风吹到了街上。	AI generated	elementary	\N	\N	\N
2463	Her kind heart is a good trait, even after a cold shower.	shower	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.918949	2025-07-09 13:45:43.773854	她善良的心是一个优点，即使在洗完冷水澡后也是。	AI generated	elementary	\N	\N	\N
2473	I saw a dog with a short tail in the park after checking the menu.	park	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.395789	2025-07-09 13:45:43.773861	查看菜单后，我看到一只在公园里有一条短尾巴的狗。	AI generated	intermediate	\N	\N	\N
2465	A small bird hopped across the busy street.	bird	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.921131	2025-07-09 13:45:43.773858	一只小鸟跳过繁忙的街道。	AI generated	elementary	\N	\N	\N
2467	The ripe peach was cold like ice.	ripe	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:01.921135	2025-07-09 13:45:43.773859	成熟的桃子像冰一样冷。	AI generated	elementary	\N	\N	\N
2469	Helping someone is a worthy, mere act of kindness, but it matters a lot.	worthy	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.395776	2025-07-09 13:45:43.773859	帮助别人是值得的，只是一个小小的善举，但它很重要。	AI generated	elementary	\N	\N	\N
2471	The firm sent me a thank you card after the meeting.	card	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.395785	2025-07-09 13:45:43.77386	会议结束后，公司寄给我一张感谢卡。	AI generated	elementary	\N	\N	\N
2476	My mobile phone charger needs a volt or it won't work.	volt	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.395795	2025-07-09 13:45:43.773861	我的手机充电器需要电压，否则它无法工作。	AI generated	elementary	\N	\N	\N
2478	I need a volt battery for my car, it's an urgent matter.	urgent	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.3958	2025-07-09 13:45:43.773862	我的车需要一个伏特的电池，这是件紧急的事情。	AI generated	elementary	\N	\N	\N
2480	The firm hopes to gain more customers soon through new marketing.	firm	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.395804	2025-07-09 13:45:43.773863	公司希望通过新的营销方式尽快获得更多客户。	AI generated	elementary	\N	\N	\N
2482	It is worth the time to polish my shoes.	polish	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.813444	2025-07-09 13:45:43.773863	花时间擦亮我的鞋子是值得的。	AI generated	elementary	\N	\N	\N
2484	I made a mess when I tried to read in the kitchen.	mess	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.822044	2025-07-09 13:45:46.360212	我试着在厨房里看书，结果弄得一团糟。	AI generated	elementary	\N	\N	\N
2486	The scary wolf wanted to fill his belly.	wolf	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.822048	2025-07-09 13:45:46.360216	可怕的狼想要填饱肚子。	AI generated	elementary	\N	\N	\N
2488	I like to work and read poetry.	work	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.822052	2025-07-09 13:45:46.360217	我喜欢工作和读诗。	AI generated	elementary	\N	\N	\N
2491	I will try to settle this mess later.	mess	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.822057	2025-07-09 13:45:46.360217	我晚点会想办法收拾这个烂摊子。	AI generated	elementary	\N	\N	\N
2493	The little wolf made a big mess playing outside.	wolf	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:04.82206	2025-07-09 13:45:46.360218	小狼在外面玩，弄得非常乱。	AI generated	elementary	\N	\N	\N
2495	The bird's broken wing was found near the old farm.	wing	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.158547	2025-07-09 13:45:46.360218	人们在旧农场附近发现了小鸟折断的翅膀。	AI generated	elementary	\N	\N	\N
2497	The void felt poor because it had no color.	void	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.162145	2025-07-09 13:45:46.360219	虚空觉得很可怜，因为它没有颜色。	AI generated	elementary	\N	\N	\N
2499	Twelve birds sat in the front row.	twelve	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.162149	2025-07-09 13:45:46.360219	十二只小鸟坐在前排。	AI generated	elementary	\N	\N	\N
2501	I used a hook to buy food from the vendor.	hook	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.162153	2025-07-09 13:45:46.36022	我用钩子从小贩那里买食物。	AI generated	elementary	\N	\N	\N
2503	The police need an answer to the question.	answer	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.162156	2025-07-09 13:45:46.36022	警察需要这个问题的答案。	AI generated	elementary	\N	\N	\N
2505	They stood at the front when the music played.	front	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.16216	2025-07-09 13:45:49.802603	当音乐响起时，他们站在最前面。	AI generated	elementary	\N	\N	\N
2507	The old rag was used to clean while I listened to a happy song.	rag	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.385483	2025-07-09 13:45:49.802608	我听着快乐的歌，用旧布擦东西。	AI generated	elementary	\N	\N	\N
2509	My new shoes weigh a ton, but they are very nice.	shoes	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.396882	2025-07-09 13:45:49.802609	我的新鞋很重，但是它们很漂亮。	AI generated	elementary	\N	\N	\N
2511	My uncle gave me a pretty violet flower from his garden.	violet	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.398665	2025-07-09 13:45:49.802609	我的叔叔从他的花园里给了我一朵漂亮的紫罗兰花。	AI generated	elementary	\N	\N	\N
2513	I shave because I want to keep my heart young.	shave	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.398669	2025-07-09 13:45:49.80261	我刮胡子是因为我想保持年轻的心。	AI generated	elementary	\N	\N	\N
2515	Even if I am busy, I will call you back later.	even	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.400944	2025-07-09 13:45:49.802611	即使我很忙，我也会晚点给你回电话。	AI generated	elementary	\N	\N	\N
2517	The singer wrote a song about a shining jewel.	song	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.400947	2025-07-09 13:45:49.802611	这位歌手写了一首关于闪亮宝石的歌。	AI generated	elementary	\N	\N	\N
2519	The old king's tomb, once grand, is now covered in dust.	tomb	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.582019	2025-07-09 13:45:49.802612	老国王的坟墓，曾经很壮观，现在布满了灰尘。	AI generated	elementary	\N	\N	\N
2521	I had a dream I found a big rock shaped like a heart.	rock	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.593854	2025-07-09 13:45:49.802612	我做了一个梦，梦见我找到了一块像心一样的大石头。	AI generated	elementary	\N	\N	\N
2523	In spite of the noise, everything felt normal again.	spite	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.599149	2025-07-09 13:45:49.802613	尽管很吵闹，但一切又感觉恢复正常了。	AI generated	elementary	\N	\N	\N
2525	The rumour is that the queen is back on her throne.	rumour	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.599152	2025-07-09 13:45:52.501209	有传言说，女王又回到她的王位上了。	AI generated	elementary	\N	\N	\N
2527	My third time having that strange dream left me confused.	third	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.603013	2025-07-09 13:45:52.501212	我第三次做那个奇怪的梦，让我很困惑。	AI generated	elementary	\N	\N	\N
2529	She held the prize gently, careful not to break it.	prize	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:05.603016	2025-07-09 13:45:52.501213	她轻轻地拿着奖品，小心不要弄坏它。	AI generated	elementary	\N	\N	\N
2531	I wish I had a visa so I could travel the world.	wish	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:06.032088	2025-07-09 13:45:52.501213	我希望我有个签证，这样我就可以环游世界了。	AI generated	elementary	\N	\N	\N
2533	I deeply appreciate a glass of warm milk before bed.	deeply	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:06.040498	2025-07-09 13:45:52.501214	我非常喜欢睡前喝一杯热牛奶。	AI generated	elementary	\N	\N	\N
2535	I'll quote the embassy's visa requirements in my email.	quote	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:06.040501	2025-07-09 13:45:52.501214	我会在邮件里引用大使馆的签证要求。	AI generated	elementary	\N	\N	\N
2537	My neck feels stiff, so I will see a doctor.	stiff	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:06.044401	2025-07-09 13:45:52.501214	我的脖子感觉很僵硬，所以我要去看医生。	AI generated	elementary	\N	\N	\N
2539	I deeply hope I can catch the early train.	catch	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:06.051009	2025-07-09 13:45:52.501215	我非常希望我能赶上早班火车。	AI generated	elementary	\N	\N	\N
2541	I wish my rival would just play fair.	wish	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:06.051013	2025-07-09 13:45:52.501215	我希望我的对手能公平竞争。	AI generated	elementary	\N	\N	\N
2543	The royal family took a trip to the polar region.	royal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.464548	2025-07-09 13:45:52.501216	王室一家去了一趟极地地区。	AI generated	elementary	\N	\N	\N
2545	I enjoy trying to obtain new skills in art.	obtain	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.464556	2025-07-09 13:45:55.71606	我喜欢学习新的绘画技巧。	AI generated	elementary	\N	\N	\N
2547	Prior to the storm, the wind was quite cruel.	prior	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.46456	2025-07-09 13:45:55.716064	在暴风雨来之前，风刮得很厉害。	AI generated	elementary	\N	\N	\N
2549	The royal necklace fit perfectly around her neck.	royal	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.464563	2025-07-09 13:45:55.716065	那条王室项链戴在她脖子上正好。	AI generated	elementary	\N	\N	\N
2551	The lion watched the tourists pack their bags.	pack	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.464567	2025-07-09 13:45:55.716066	狮子看着游客们收拾行李。	AI generated	elementary	\N	\N	\N
2553	I want to obtain books on the theme of nature.	obtain	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.464571	2025-07-09 13:45:55.716066	我想得到一些关于大自然的书。	AI generated	elementary	\N	\N	\N
2555	It is my vision to see the world become a better place.	vision	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.888269	2025-07-09 13:45:55.716067	我的愿望是看到世界变得更美好。	AI generated	elementary	\N	\N	\N
2557	The root of the problem is at a basic level.	root	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.892239	2025-07-09 13:45:55.716068	问题的根源在于最基础的层面。	AI generated	elementary	\N	\N	\N
2559	The tree's root grew stronger each month.	root	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.894474	2025-07-09 13:45:55.716068	这棵树的根每个月都长得更壮。	AI generated	elementary	\N	\N	\N
2561	The old tree's root reached almost to the edge of the cliff.	edge	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.897098	2025-07-09 13:45:55.716069	这棵老树的根几乎长到了悬崖边上。	AI generated	elementary	\N	\N	\N
2563	The explorer had a vision of a hidden cave.	cave	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.897101	2025-07-09 13:45:55.71607	探险家梦到（或者想象到）一个隐藏的山洞。	AI generated	elementary	\N	\N	\N
2565	We found a dark cave near the edge of the forest.	edge	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:43:08.897104	2025-07-09 13:45:59.194908	我们在森林边上发现了一个黑黑的洞穴。	AI generated	elementary	\N	\N	\N
2567	I suppose the construction project will be delayed due to the weather.	suppose	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.45403	2025-07-09 13:45:59.194911	我觉得因为天气不好，盖东西的工程可能会晚一些。	AI generated	elementary	\N	\N	\N
2569	His occupation as a fisherman kept him close to the mainland.	occupation	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.454041	2025-07-09 13:45:59.194912	他是个渔夫，所以一直住在离陆地很近的地方。	AI generated	elementary	\N	\N	\N
2571	Completing the ambitious bridge project felt like a significant achievement.	project	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.454046	2025-07-09 13:45:59.194913	完成那个很大的桥梁工程，感觉像做成了一件很棒的事情。	AI generated	elementary	\N	\N	\N
2573	The failing business had little prospect of improving its damaged reputation.	prospect	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.45405	2025-07-09 13:45:59.194914	那个快要倒闭的生意，很难再让大家喜欢它了。	AI generated	elementary	\N	\N	\N
2575	Her greatest achievement was the surprising prospect of winning the award.	achievement	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.454054	2025-07-09 13:45:59.194914	她最棒的成就就是，竟然有可能赢得那个奖。	AI generated	elementary	\N	\N	\N
2577	Management needs to understand the culture of the company.	management	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.454058	2025-07-09 13:45:59.194915	管理人员需要了解公司的文化。	AI generated	elementary	\N	\N	\N
2579	The participant took notes in their notebook during the training session.	notebook	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.660908	2025-07-09 13:45:59.194915	参加者在培训的时候，在笔记本上记笔记。	AI generated	elementary	\N	\N	\N
2581	He lost control and drove to the store wearing pajamas.	control	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.663254	2025-07-09 13:45:59.194916	他没控制好，穿着睡衣就开车去商店了。	AI generated	elementary	\N	\N	\N
2583	The doctor's residence was conveniently located above his medicine practice.	residence	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.667699	2025-07-09 13:45:59.194917	医生住的地方就在他看病的地方楼上，很方便。	AI generated	elementary	\N	\N	\N
2585	They were forced to surrender control of the project after the scandal.	surrender	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.671304	2025-07-09 13:46:04.721999	丑闻发生后，他们不得不放弃对这个项目的控制权。	AI generated	elementary	\N	\N	\N
2587	She felt comfortable enough at her childhood residence to wear her old pajamas.	residence	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.671308	2025-07-09 13:46:04.722003	在她小时候住的地方，她觉得很舒服，可以穿旧睡衣。	AI generated	elementary	\N	\N	\N
2589	Scientists studied the offspring in the laboratory to observe genetic traits.	offspring	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.671311	2025-07-09 13:46:04.722003	科学家在实验室里研究小宝宝，观察他们有哪些遗传特点。	AI generated	elementary	\N	\N	\N
2591	Standing at the crossroads, my main concern is which path offers the best opportunities.	crossroads	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.755222	2025-07-09 13:46:04.722004	站在十字路口，我最关心的是哪条路能给我最好的机会。	AI generated	elementary	\N	\N	\N
2593	The research program aims to develop sustainable energy sources for the future.	research	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.759584	2025-07-09 13:46:04.722004	这个研究项目想要为未来开发可以一直用的能源。	AI generated	elementary	\N	\N	\N
2595	Nutrition and regular exercise are important for maintaining good health.	nutrition	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.759588	2025-07-09 13:46:04.722005	好的营养和经常运动对保持健康很重要。	AI generated	elementary	\N	\N	\N
2601	New research suggests the atmosphere on Mars might once have supported life.	research	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.759598	2025-07-09 13:46:04.722006	新的研究表明，火星上的空气可能以前适合生物生存。	AI generated	elementary	\N	\N	\N
2598	After a long day of housework, frankly I am in need of some physical rest.	housework	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.759593	2025-07-09 13:46:04.722005	忙了一整天家务后，说实话，我需要好好休息一下。	AI generated	intermediate	\N	\N	\N
2606	A lack of proper education following the disaster led to long-term societal problems.	education	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.976986	2025-07-09 13:46:04.722007	灾难过后，因为缺少好的教育，导致了很多长期的社会问题。	AI generated	elementary	\N	\N	\N
2603	After winning the lottery, they hired help and moved out of their small apartment for a mansion, so housework was no longer her concern.	housework	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.759602	2025-07-09 13:46:04.722006	中了彩票后，他们请了人帮忙，搬出了小公寓，住进了大房子，所以她不再需要担心做家务了。	AI generated	intermediate	\N	\N	\N
2608	We will undertake further education to improve our skills.	education	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.980059	2025-07-09 13:46:08.574823	我们将继续学习，提高我们的技能。	AI generated	elementary	\N	\N	\N
2610	The company must undertake changes to avoid consumer rejection.	rejection	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.987512	2025-07-09 13:46:08.574826	公司必须做出改变，避免消费者不喜欢。	AI generated	elementary	\N	\N	\N
2612	At eighteen, she received a telephone call offering her a scholarship.	eighteen	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.987516	2025-07-09 13:46:08.574826	十八岁时，她接到一个电话，告诉她获得了奖学金。	AI generated	elementary	\N	\N	\N
2614	Meditation can improve consciousness and enhance the education experience.	education	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.987519	2025-07-09 13:46:08.574827	冥想可以提高意识，让学习体验更好。	AI generated	elementary	\N	\N	\N
2616	The surgeon used the pyramid model to explain the complex procedure.	surgeon	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:03.987522	2025-07-09 13:46:08.574827	外科医生用金字塔模型来解释复杂的手术过程。	AI generated	elementary	\N	\N	\N
2618	The CEO will announce the updated energy-efficient models for the refrigerator line tomorrow.	announce	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.177522	2025-07-09 13:46:08.574828	首席执行官明天将宣布冰箱系列的新款节能型号。	AI generated	elementary	\N	\N	\N
2620	I brought my floral umbrella to the gardeners' convention in case of rain.	umbrella	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.19431	2025-07-09 13:46:08.574828	我带着我的花雨伞去参加园丁大会，以防下雨。	AI generated	elementary	\N	\N	\N
2622	They will announce the parade route, so don't forget your umbrella.	announce	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.194314	2025-07-09 13:46:08.574828	他们会宣布游行路线，所以别忘了你的雨伞。	AI generated	elementary	\N	\N	\N
2624	Achieving inner happiness is my top priority this year.	happiness	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.194318	2025-07-09 13:46:08.574829	今年我最重要的事情是获得内心的快乐。	AI generated	elementary	\N	\N	\N
2626	Can I get your signature; I think I lost something.	signature	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.194321	2025-07-09 13:46:08.574829	我能要你的签名吗？我觉得我丢了东西。	AI generated	elementary	\N	\N	\N
2628	The delicious treats at the baking convention were beyond compare.	delicious	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.194325	2025-07-09 13:46:13.075257	烘焙大会上的美味点心真是太棒了，没法比。	AI generated	elementary	\N	\N	\N
2630	The kingdom relied on its efficient supermarket distribution network to feed its people.	kingdom	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.358599	2025-07-09 13:46:13.075262	这个国家靠着高效的超市送货系统来养活大家。	AI generated	elementary	\N	\N	\N
2632	Literacy programs relying on volunteer tutors drastically improved community education levels.	literacy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.368443	2025-07-09 13:46:13.075263	靠志愿者老师的识字项目大大提高了社区的教育水平。	AI generated	elementary	\N	\N	\N
2634	The young prince's rebellious nature caused his father, the king, considerable trouble within the kingdom.	kingdom	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.373081	2025-07-09 13:46:13.075264	年轻的王子很叛逆，这让他的国王爸爸在国家里很头疼。	AI generated	intermediate	\N	\N	\N
2642	Sarah felt anxious before her interview, hoping to make a good impression on the hiring manager.	anxious	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.342814	2025-07-09 13:46:13.075266	莎拉在面试前感到很紧张，希望给招聘经理留下好印象。	AI generated	intermediate	\N	\N	\N
2636	She was determined to improve her literacy skills, attending night classes diligently.	literacy	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.377527	2025-07-09 13:46:13.075264	她决心提高自己的识字能力，努力去上夜校。	AI generated	elementary	\N	\N	\N
2644	The chef decided to sprinkle a bit of sea salt on the fish skeleton for added flavor before serving.	skeleton	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.342821	2025-07-09 13:46:13.075267	厨师决定在鱼骨上撒一点海盐，这样上菜的时候会更香。	AI generated	intermediate	\N	\N	\N
2638	The student approached the final revision with renewed enthusiasm after a helpful study group.	revision	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.377531	2025-07-09 13:46:13.075265	在有帮助的学习小组之后，学生以新的热情对待最后的复习。	AI generated	elementary	\N	\N	\N
2648	Bringing a pineapple to the potluck was my obligation, as I had volunteered to provide dessert.	obligation	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.342827	2025-07-09 13:46:17.806457	我答应带菠萝去聚餐当甜点，所以这是我的责任。	AI generated	intermediate	\N	\N	\N
2640	The monarch visited the local supermarket, surprising shoppers with her unexpected appearance.	supermarket	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:04.377535	2025-07-09 13:46:13.075266	国王/女王去了当地的超市，她的突然出现让顾客们很惊讶。	AI generated	elementary	\N	\N	\N
2658	The announcement of the winner filled the room with excitement, and I felt suddenly relaxed.	relaxed	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.438718	2025-07-09 13:46:17.806465	宣布谁是赢家的时候，房间里充满了兴奋，我突然觉得放松了。	AI generated	intermediate	\N	\N	\N
2646	After recovering at the hospital, the patient cherished their newfound freedom to walk outside.	hospital	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.342824	2025-07-09 13:46:13.075268	在医院康复后，病人很珍惜现在能出去散步的自由。	AI generated	elementary	\N	\N	\N
2650	The politician's statement downplayed the tragedy, causing public outrage and disbelief.	statement	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.34283	2025-07-09 13:46:17.806462	那位政治家说的话让大家觉得他没把悲剧当回事，这让大家很生气，也不敢相信。	AI generated	elementary	\N	\N	\N
2652	Trees with moderate foliage surround the old house, sheltering it from the harsh winds.	moderate	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.342833	2025-07-09 13:46:17.806463	老房子周围有很多树，树叶不多不少，正好可以挡住大风。	AI generated	elementary	\N	\N	\N
2654	The hotel reception offered us a complimentary biscuit upon arrival.	biscuit	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.425513	2025-07-09 13:46:17.806464	我们到酒店的时候，前台送了我们一块免费的小饼干。	AI generated	elementary	\N	\N	\N
2656	She felt utterly satisfied upon realizing she had won the lottery.	satisfied	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.433575	2025-07-09 13:46:17.806464	当她发现自己中了彩票的时候，她觉得非常非常满足。	AI generated	elementary	\N	\N	\N
2660	His pursuit of a deeper understanding of physics consumed his every waking moment.	pursuit	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.446993	2025-07-09 13:46:17.806465	他想更深入地了解物理，所以他醒着的每一分钟都在研究它。	AI generated	elementary	\N	\N	\N
2662	He was a regular tennis opponent, always bringing a challenging game.	regular	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.446997	2025-07-09 13:46:17.806466	他经常和我打网球，而且他总是打得很好，很有挑战性。	AI generated	elementary	\N	\N	\N
2664	I need to transfer the ownership document before the end of the week.	transfer	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:07.447	2025-07-09 13:46:17.806467	我需要在周末之前把房子的所有权文件转让出去。	AI generated	elementary	\N	\N	\N
2666	To obtain a pilot's license, a demanding qualification like perfect vision is crucial.	license	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.056597	2025-07-09 13:46:17.806467	想要拿到飞行员执照，需要像完美的视力这样很高的条件。	AI generated	elementary	\N	\N	\N
2668	Their business partnership thrived by focusing on community recreation programs.	recreation	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.066054	2025-07-09 13:46:23.044381	他们的商业合作通过关注社区娱乐项目而变得很成功。	AI generated	elementary	\N	\N	\N
2670	I sincerely believe that promoting understanding of any religion is important.	sincerely	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.069817	2025-07-09 13:46:23.044383	我真心觉得，增进对任何宗教的理解都很重要。	AI generated	elementary	\N	\N	\N
2672	Her powerful insights into human behavior showcased her deep understanding of psychology.	psychology	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.06982	2025-07-09 13:46:23.044384	她对人类行为的深刻见解，展现了她对心理学的深入了解。	AI generated	elementary	\N	\N	\N
2694	The two proposals were similar in nature, yet sparked a significant conflict within the committee.	similar	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.422467	2025-07-09 13:46:26.920296	这两个提议本质上很相似，但却在委员会内部引发了很大的冲突。	AI generated	intermediate	\N	\N	\N
2674	His unwavering loyalty was a good measure of his dedication to the company.	loyalty	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.069824	2025-07-09 13:46:23.044384	他坚定不移的忠诚，很好地衡量了他对公司的奉献。	AI generated	elementary	\N	\N	\N
2698	We extend our deepest sympathy to the shepherd whose flock was attacked by a monster.	sympathy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.43017	2025-07-09 13:46:26.920297	我们向牧羊人表示最深切的同情，他的羊群受到了怪物的袭击。	AI generated	intermediate	\N	\N	\N
2676	Stress can be a clear indication of underlying issues addressed by psychology.	psychology	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.075442	2025-07-09 13:46:23.044385	压力可能是心理学要解决的潜在问题的明显信号。	AI generated	elementary	\N	\N	\N
2703	The training course is virtually the same as the procedure outlined for his position, making the promotion a sincere fit.	virtually	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.430179	2025-07-09 13:46:26.920298	这个培训课程几乎和他职位的流程一样，所以这次晋升非常合适。	AI generated	intermediate	\N	\N	\N
2678	The sudden thunder outside did little to disturb his content reading of the novel.	thunder	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.137223	2025-07-09 13:46:23.044385	外面突然的雷声并没有打扰他安静地读书。	AI generated	elementary	\N	\N	\N
2680	Wearing a cozy sweater, the friendly librarian helped me find a rare text.	sweater	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.14567	2025-07-09 13:46:23.044385	穿着舒适的毛衣，友好的图书管理员帮我找到了一本稀有的书。	AI generated	elementary	\N	\N	\N
2682	He was unwilling to return the soft sweater, despite it not being his.	unwilling	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.145673	2025-07-09 13:46:23.044386	他不愿意归还那件柔软的毛衣，即使它不是他的。	AI generated	elementary	\N	\N	\N
2684	The lost ring turned up nowhere at the wedding, creating a minor panic.	wedding	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.145676	2025-07-09 13:46:23.044386	在婚礼上，丢失的戒指哪里都没找到，引起了一点小恐慌。	AI generated	elementary	\N	\N	\N
2686	A key feature of the app is its user-friendly interface and engaging content.	feature	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.145684	2025-07-09 13:46:23.044387	这个应用程序的一个主要特点是它友好的界面和吸引人的内容。	AI generated	elementary	\N	\N	\N
2688	The witness's description of the suspect was vague, but she seemed friendly during questioning.	description	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.145689	2025-07-09 13:46:26.920292	证人对嫌疑人的描述很模糊，但在问话时她看起来很友善。	AI generated	elementary	\N	\N	\N
2690	His sudden appearance at the peace festival intensified the political conflict, making everyone suspicious.	appearance	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.418606	2025-07-09 13:46:26.920295	他在和平节上的突然出现加剧了政治冲突，让每个人都感到怀疑。	AI generated	elementary	\N	\N	\N
2696	This celestial occasion provides a rare opportunity to view distant planets through the telescope.	occasion	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.42247	2025-07-09 13:46:26.920296	这个特别的天文事件提供了一个难得的机会，可以通过望远镜观察遥远的行星。	AI generated	elementary	\N	\N	\N
2701	The two funeral services were remarkably similar, reflecting the community's shared grief.	funeral	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.430175	2025-07-09 13:46:26.920297	这两个葬礼仪式非常相似，反映了社区共同的悲伤。	AI generated	elementary	\N	\N	\N
2708	The kind baker left a sweet cupcake with a heartfelt message for the birthday girl.	cupcake	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.954207	2025-07-09 13:46:26.920298	善良的面包师留下了一个甜蜜的纸杯蛋糕，上面写着给生日女孩的衷心祝福。	AI generated	intermediate	\N	\N	\N
2710	The majority of students paid close attention during the engaging lecture.	attention	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.957364	2025-07-09 13:46:26.920299	大多数学生在有趣的讲座中都认真听讲。	AI generated	elementary	\N	\N	\N
2712	The reporter's questions demanded the politician's full attention during the press conference.	attention	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.961424	2025-07-09 13:46:26.920299	记者的问题要求政治家在新闻发布会上全神贯注。	AI generated	elementary	\N	\N	\N
2714	The negotiation went smoothly, allowing the involved parties to separate on good terms.	smoothly	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.96536	2025-07-09 13:46:30.307183	谈判进行得很顺利，让参与的各方友好地分开了。	AI generated	elementary	\N	\N	\N
2716	The frightening story used to terrify me, but now I barely remember it.	terrify	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.972359	2025-07-09 13:46:30.307188	这个可怕的故事曾经吓坏我了，但现在我几乎不记得了。	AI generated	elementary	\N	\N	\N
2718	The reporter delivered a crucial message from the president this morning.	message	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:08.974081	2025-07-09 13:46:30.307188	记者今天早上带来了总统的重要消息。	AI generated	elementary	\N	\N	\N
2720	It is possibly best to complete the assignment before the deadline.	possibly	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:10.966725	2025-07-09 13:46:30.307189	最好可能是在截止日期前完成作业。	AI generated	elementary	\N	\N	\N
2722	He cleaned his teeth roughly with his toothbrush after the meal.	toothbrush	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:10.977817	2025-07-09 13:46:30.30719	饭后，他用牙刷粗略地刷了牙。	AI generated	elementary	\N	\N	\N
2724	The successful professor wrote equations on the blackboard.	successful	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:10.981578	2025-07-09 13:46:30.30719	那位成功的教授在黑板上写公式。	AI generated	elementary	\N	\N	\N
2726	She roughly estimated the time needed to complete the task.	complete	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:10.981582	2025-07-09 13:46:30.307191	她粗略地估计了完成任务所需的时间。	AI generated	elementary	\N	\N	\N
2728	Careful consideration is needed to complete the project successfully.	consideration	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:10.981586	2025-07-09 13:46:30.307192	要成功完成这个项目，需要仔细考虑。	AI generated	elementary	\N	\N	\N
2730	The zoo increased its capacity to house a new penguin exhibit.	penguin	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:10.98159	2025-07-09 13:46:30.307193	动物园增加了容量，以便容纳新的企鹅展览。	AI generated	elementary	\N	\N	\N
2732	The worker is truly happy with their job.	truly	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.498018	2025-07-09 13:46:30.307194	这位工人对他们的工作非常满意。	AI generated	elementary	\N	\N	\N
2734	The ugly float ruined the parade.	ugly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.50455	2025-07-09 13:46:33.079963	丑陋的花车毁了游行。	AI generated	elementary	\N	\N	\N
2737	That person is the winner of the race.	person	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.508346	2025-07-09 13:46:33.079968	那个人是赛跑的赢家。	AI generated	elementary	\N	\N	\N
2739	The brave knight made a big effort.	brave	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.508349	2025-07-09 13:46:33.079968	勇敢的骑士付出了很大的努力。	AI generated	elementary	\N	\N	\N
2741	He kept a bitter feeling a secret.	bitter	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.508353	2025-07-09 13:46:33.079969	他把痛苦的感觉藏了起来。	AI generated	elementary	\N	\N	\N
2743	The ugly weather will be gone soon.	ugly	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.51126	2025-07-09 13:46:33.079969	糟糕的天气很快就会过去。	AI generated	elementary	\N	\N	\N
2745	I can shine the string of beads so it looks new again.	shine	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.779605	2025-07-09 13:46:33.079969	我可以把珠子项链擦亮，让它看起来像新的一样。	AI generated	elementary	\N	\N	\N
2747	If we shine the light on the plants, they will yield more fruit.	yield	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.78355	2025-07-09 13:46:33.07997	如果我们用光照植物，它们会结出更多的果实。	AI generated	elementary	\N	\N	\N
2769	The little dog ran off the path and stood by the side of the road.	path	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:13.554538	2025-07-09 13:46:36.564448	小狗跑出了小路，站在路边。	AI generated	intermediate	\N	\N	\N
2749	I will need a stool if I travel by train.	stool	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.783554	2025-07-09 13:46:33.07997	如果我坐火车，我需要一个小凳子。	AI generated	elementary	\N	\N	\N
2781	Please stay here for the first part of the game so you care for which animal will win.	stay	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.029761	2025-07-09 13:46:39.977257	请你待在这里看游戏的前半部分，这样你就能关心哪个动物会赢。	AI generated	intermediate	\N	\N	\N
2751	The pupil saw a tiny grain of sand under the microscope.	pupil	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.790132	2025-07-09 13:46:33.079971	学生在显微镜下看到了一粒细小的沙子。	AI generated	elementary	\N	\N	\N
2786	Which sugar ribbon is in the corner of the box you want, can you guess.	which	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.043787	2025-07-09 13:46:39.977257	你想要哪个盒子角落里的糖带，你能猜到吗？	AI generated	intermediate	\N	\N	\N
2753	Who knows what treasures the garden will yield this year?	who	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.790136	2025-07-09 13:46:33.079971	谁知道今年花园会产出什么宝贝呢？	AI generated	elementary	\N	\N	\N
2755	We can get home safely if we yield to the other car.	yield	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.79014	2025-07-09 13:46:36.564439	如果我们让着另一辆车，我们就能安全到家。	AI generated	elementary	\N	\N	\N
2757	The sick child started to vomit, changing the balloon animal's shape.	vomit	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.809742	2025-07-09 13:46:36.564444	生病的小孩开始呕吐，把气球动物的形状都弄变了。	AI generated	elementary	\N	\N	\N
2759	I hear the famous singer on the radio every day.	hear	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.813269	2025-07-09 13:46:36.564444	我每天在收音机里都能听到那位有名的歌手。	AI generated	elementary	\N	\N	\N
2761	Don't screw up; if you're nervous you might vomit!	screw	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.813273	2025-07-09 13:46:36.564445	别搞砸了；如果你紧张，你可能会吐！	AI generated	elementary	\N	\N	\N
2763	He had to carry a ten pound load of books.	ten	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.81547	2025-07-09 13:46:36.564446	他不得不搬运十磅重的书。	AI generated	elementary	\N	\N	\N
2765	Do you mind if I permit myself to have a slice?	mind	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.817307	2025-07-09 13:46:36.564446	你介意我允许自己吃一片吗？	AI generated	elementary	\N	\N	\N
2767	I have a notion that this is too heavy a load for you.	notion	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:11.81731	2025-07-09 13:46:36.564447	我感觉这东西对你来说太重了。	AI generated	elementary	\N	\N	\N
2771	The big whale used a lot of energy to swim in the ocean.	whale	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:13.556686	2025-07-09 13:46:36.564449	大鲸鱼在海里游泳用了好多力气。	AI generated	elementary	\N	\N	\N
2773	I will seize the moment and take a photo of the sunset.	seize	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:13.561822	2025-07-09 13:46:36.56445	我要抓住机会，拍一张日落的照片。	AI generated	elementary	\N	\N	\N
2775	Dad cooked a tasty steak, and Mom took a photo of it.	steak	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:13.568008	2025-07-09 13:46:39.97725	爸爸做了一块好吃的牛排，妈妈给它拍了照片。	AI generated	elementary	\N	\N	\N
2777	The loud engine noise made me feel a lot of grief.	engine	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:13.568027	2025-07-09 13:46:39.977255	发动机的巨大噪音让我感到很难过。	AI generated	elementary	\N	\N	\N
2779	The troop stood at the side of the road waiting for the bus.	side	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:13.569868	2025-07-09 13:46:39.977256	队伍站在路边等公共汽车。	AI generated	elementary	\N	\N	\N
2833	Lord, I want to see the beautiful sunset.	lord	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:15.258793	2025-07-09 13:46:39.97726	上帝啊，我想看美丽的日落。	AI generated	elementary	\N	\N	\N
2792	The zebra ran toward the mud and I could hide or run with love.	zebra	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.046026	2025-07-09 13:46:39.977258	斑马朝着泥地跑去，我可以躲起来或者充满爱地一起跑。	AI generated	elementary	\N	\N	\N
2802	He felt relief as he walked toward the high corner, which was the best thing.	relief	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.049018	2025-07-09 13:46:39.977259	当他走向高高的角落时，他感到放松，那是最好的事情。	AI generated	intermediate	\N	\N	\N
2797	I love to hide from my dad; you will hide it if you care.	love	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.049012	2025-07-09 13:46:39.977258	我喜欢躲着我爸爸；如果你关心，你也会躲起来的。	AI generated	elementary	\N	\N	\N
2815	The winner received a kind letter from the mayor.	winner	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.825334	2025-07-09 13:46:42.85387	获胜者收到了一封市长写的友善的信。	AI generated	elementary	\N	\N	\N
2807	The ribbon fell in the corner, and hourly I start to get relief from sugar and mud layer.	ribbon	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.049024	2025-07-09 13:46:39.97726	带子掉在角落里了，每小时我都开始从糖和泥土层中得到放松。	AI generated	intermediate	\N	\N	\N
2817	Each stamp is equal in value when you mail things.	stamp	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.834672	2025-07-09 13:46:42.853876	当你寄东西时，每张邮票的价值都是一样的。	AI generated	elementary	\N	\N	\N
2819	Our aim is to help the new colony thrive.	aim	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.836972	2025-07-09 13:46:42.853876	我们的目标是帮助新的家园变得更好。	AI generated	elementary	\N	\N	\N
2821	Please stand on the upper step for the picture.	stand	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.836976	2025-07-09 13:46:42.853877	请站在更高的台阶上照相。	AI generated	elementary	\N	\N	\N
2823	The poet had a gentle way with words and feelings.	poet	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.83698	2025-07-09 13:46:42.853878	这位诗人用温柔的方式表达文字和情感。	AI generated	elementary	\N	\N	\N
2825	She got a thank you letter for the lovely skirt.	skirt	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:14.839729	2025-07-09 13:46:42.853878	她收到了一封感谢信，因为那条漂亮的裙子。	AI generated	elementary	\N	\N	\N
2827	I chopped the onion up for the salad.	up	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:15.242752	2025-07-09 13:46:42.853879	我把洋葱切碎做沙拉。	AI generated	elementary	\N	\N	\N
2829	To fix up the bike will cost a lot.	up	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:15.25348	2025-07-09 13:46:42.853879	修理这辆自行车要花很多钱。	AI generated	elementary	\N	\N	\N
2831	The phone's light shows a new mode is active.	mode	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:15.256594	2025-07-09 13:46:42.85388	手机上的灯显示有一个新的模式正在运行。	AI generated	elementary	\N	\N	\N
2835	The new game mode will cost five dollars.	cost	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:15.258797	2025-07-09 13:46:42.853881	新的游戏模式要花五美元。	AI generated	elementary	\N	\N	\N
2839	The shy girl blushed, so I will rate her a 9 out of 10 for cuteness.	shy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.363164	2025-07-09 13:46:46.562295	那个害羞的女孩脸红了，我觉得她可爱极了，给她打9分（满分10分）。	AI generated	intermediate	\N	\N	\N
2837	The spider changed its web mode at night.	spider	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:15.2588	2025-07-09 13:46:46.562289	蜘蛛晚上改变了它的网的形状。	AI generated	elementary	\N	\N	\N
2849	My house is on the border, about an eighth of a mile from the park.	border	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.386133	2025-07-09 13:46:46.562298	我的房子在边界上，离公园大约有八分之一英里。	AI generated	intermediate	\N	\N	\N
2851	I used a lot of blue paint to cover the wall; I think it took almost sixty minutes.	paint	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.396232	2025-07-09 13:46:46.562299	我用了好多蓝色颜料来涂墙，我想我花了差不多六十分钟。	AI generated	intermediate	\N	\N	\N
2841	I haven't crossed the border since the last time I visited my grandmother.	since	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.370575	2025-07-09 13:46:46.562296	自从上次看奶奶后，我就没有过边境了。	AI generated	elementary	\N	\N	\N
2855	We saw a funny fish riding on a camel in my silly dream last night.	fish	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.40169	2025-07-09 13:46:46.5623	昨晚我做了一个傻傻的梦，梦见一条有趣的鱼骑在骆驼上。	AI generated	intermediate	\N	\N	\N
2843	I heard a loud knock right at the border of the property.	border	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.376752	2025-07-09 13:46:46.562296	我听到有人在房子边界的地方大声敲门。	AI generated	elementary	\N	\N	\N
2875	I asked him a question, but I did not get a reply, so I drank from my straw.	reply	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.389326	2025-07-09 13:46:51.153188	我问了他一个问题，但是我没有得到回复，所以我用吸管喝东西。	AI generated	intermediate	\N	\N	\N
2845	The teacher gave a hint about the correct input for the computer.	hint	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.380132	2025-07-09 13:46:46.562297	老师提示了一下电脑的正确输入方法。	AI generated	elementary	\N	\N	\N
2847	The shy boy brought a sandwich for his meal at school.	shy	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.38613	2025-07-09 13:46:46.562298	那个害羞的男孩带了一个三明治当午饭。	AI generated	elementary	\N	\N	\N
2853	We should reduce pollution to protect nature and keep our planet healthy.	nature	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.399578	2025-07-09 13:46:46.562299	我们应该减少污染，保护大自然，让我们的地球保持健康。	AI generated	elementary	\N	\N	\N
2857	Yes, I will paint a picture of you if you like.	paint	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.404479	2025-07-09 13:46:51.153177	好的，如果你喜欢，我可以给你画一张画。	AI generated	elementary	\N	\N	\N
2859	I have sixty apples, and I can prove it if you want to count.	sixty	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.409421	2025-07-09 13:46:51.153182	我有六十个苹果，如果你想数，我可以证明给你看。	AI generated	elementary	\N	\N	\N
2861	I will seek help from my teacher to prove my answer is correct.	seek	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:16.414056	2025-07-09 13:46:51.153183	我会向我的老师寻求帮助，来证明我的答案是正确的。	AI generated	elementary	\N	\N	\N
2863	The parrot squawked, as I was late for the party, sadly.	parrot	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.16091	2025-07-09 13:46:51.153184	鹦鹉尖叫着，因为我参加聚会迟到了，真难过。	AI generated	elementary	\N	\N	\N
2865	The bright, fresh flowers made the room feel happy and new.	bright	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.168181	2025-07-09 13:46:51.153185	那些鲜艳的新鲜花朵让房间感觉快乐和焕然一新。	AI generated	elementary	\N	\N	\N
2867	Whose book is this? The reader left it on the table.	whose	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.170335	2025-07-09 13:46:51.153185	这是谁的书？读者把它忘在桌子上了。	AI generated	elementary	\N	\N	\N
2869	A loyal dog is a good friend for any reader of books.	loyal	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.173968	2025-07-09 13:46:51.153186	一条忠诚的狗是所有读书人的好朋友。	AI generated	elementary	\N	\N	\N
2871	The colorful parrot sat in the vacant birdcage all day.	parrot	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.173971	2025-07-09 13:46:51.153187	那只色彩鲜艳的鹦鹉整天都呆在空空的鸟笼里。	AI generated	elementary	\N	\N	\N
2873	The subway was crowded, so the reader couldn't find a seat.	subway	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.173974	2025-07-09 13:46:51.153187	地铁太拥挤了，所以读者找不到座位。	AI generated	elementary	\N	\N	\N
2879	I sent a message with a question, but I didn't get a reply about the noodle recipe.	reply	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.406227	2025-07-09 13:46:54.642507	我发了一个带问题的消息，但是没有收到关于面条食谱的回复。	AI generated	intermediate	\N	\N	\N
2877	I found a fallen noodle on the grass after the picnic.	noodle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.397967	2025-07-09 13:46:54.642502	野餐后，我在草地上发现了一根掉落的面条。	AI generated	elementary	\N	\N	\N
2881	The pen fell from my hand and landed in the green grass.	pen	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.406231	2025-07-09 13:46:54.642508	笔从我的手里掉了下来，落在了绿色的草地上。	AI generated	elementary	\N	\N	\N
2883	It feels wrong to step on the grass when there's a path.	wrong	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.406234	2025-07-09 13:46:54.642508	当有路的时候，踩在草地上感觉不对。	AI generated	elementary	\N	\N	\N
2885	We need to check our safety gear before walking on the grass.	safety	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.406238	2025-07-09 13:46:54.642509	在草地上行走之前，我们需要检查我们的安全装备。	AI generated	elementary	\N	\N	\N
2887	I didn't notice him carry the heavy bag inside.	notice	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.70007	2025-07-09 13:46:54.64251	我没有注意到他把那个沉重的袋子拿进去了。	AI generated	elementary	\N	\N	\N
2890	There were a lot of sparks when the rocket went down.	rocket	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.710801	2025-07-09 13:46:54.64251	火箭坠落时，有很多火花。	AI generated	elementary	\N	\N	\N
2893	The sunset painted a beautiful picture with a lot of colors.	sunset	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.710806	2025-07-09 13:46:54.642511	日落用很多颜色画出了一幅美丽的图画。	AI generated	elementary	\N	\N	\N
2895	We watched the toy rocket dance in the sky.	dance	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.71081	2025-07-09 13:46:54.642511	我们看着玩具火箭在天空中跳舞。	AI generated	elementary	\N	\N	\N
2897	He let out a sigh, the heart symbol of his tiredness.	symbol	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.710814	2025-07-09 13:46:54.642512	他叹了口气，那是他疲惫的心形符号。	AI generated	elementary	\N	\N	\N
2899	Birds carry small twigs and fly to build their nests.	carry	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:18.710817	2025-07-09 13:46:58.580277	鸟儿带着小树枝飞来飞去，为了建造它们的窝。	AI generated	elementary	\N	\N	\N
2901	We can sail our little boat easily on the lake.	sail	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.260913	2025-07-09 13:46:58.580283	我们可以在湖上轻松地开我们的小船。	AI generated	elementary	\N	\N	\N
2903	The computer's output made us laugh with surprise.	output	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.271507	2025-07-09 13:46:58.580283	电脑的输出结果让我们惊讶地笑了。	AI generated	elementary	\N	\N	\N
2905	Please wipe up the spilled wine with this cloth.	wine	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.271511	2025-07-09 13:46:58.580284	请用这块布擦掉洒出来的葡萄酒。	AI generated	elementary	\N	\N	\N
2907	The runners got on the track, ready to start.	track	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.27613	2025-07-09 13:46:58.580285	跑步运动员们站到跑道上，准备开始。	AI generated	elementary	\N	\N	\N
2909	After playing outside, I wipe the mud off the track shoes.	track	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.276134	2025-07-09 13:46:58.580285	在外面玩耍后，我擦掉跑鞋上的泥巴。	AI generated	elementary	\N	\N	\N
2911	She arrived home easily on the train.	easily	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.276138	2025-07-09 13:46:58.580286	她坐火车很容易就到家了。	AI generated	elementary	\N	\N	\N
2913	I hunt for berries, but I seldom find any.	hunt	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.489989	2025-07-09 13:46:58.580287	我寻找浆果，但我很少找到。	AI generated	elementary	\N	\N	\N
2915	I saw a spot of rust on the old tank.	spot	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.501626	2025-07-09 13:46:58.580287	我在旧水箱上看到了一点锈迹。	AI generated	elementary	\N	\N	\N
2917	He wore a bright orange vest to the mountain summit.	summit	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.50163	2025-07-09 13:46:58.580288	他穿着一件鲜艳的橙色背心去爬山顶。	AI generated	elementary	\N	\N	\N
2919	The long walk put a strain on me in the hot zone.	strain	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.501634	2025-07-09 13:47:02.745784	长长的路在炎热的地方让我觉得很累。	AI generated	elementary	\N	\N	\N
2930	I think it's a shame to cut down that old tree, it would be hard.	think	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.798444	2025-07-09 13:47:02.74579	我觉得砍掉那棵老树太可惜了，砍起来也会很困难。	AI generated	intermediate	\N	\N	\N
2921	For safety, I always wear a reflective vest in the construction zone.	vest	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.501637	2025-07-09 13:47:02.745788	为了安全，我总是在工地穿反光背心。	AI generated	elementary	\N	\N	\N
2937	I need a clean sheet of paper too, so I can cheer everyone up after the damage.	sheet	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.798457	2025-07-09 13:47:02.745791	我也需要一张干净的纸，这样我才能在损坏发生后让大家开心起来。	AI generated	intermediate	\N	\N	\N
2923	We seldom use the water tank because it is old.	tank	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.501641	2025-07-09 13:47:02.745789	我们很少用水箱里的水，因为它太旧了。	AI generated	elementary	\N	\N	\N
2941	Did you turn off the lights because the wind can be really hard on the recent damage near the ocean?	turn	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.798464	2025-07-09 13:47:02.745791	你关灯了吗？因为海边最近的损坏处风很大。	AI generated	intermediate	\N	\N	\N
2925	It's a real shame I can't repair my bike myself; I'll ask my dad.	repair	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.783721	2025-07-09 13:47:02.745789	真可惜我自己不会修自行车，我要问问我爸爸。	AI generated	elementary	\N	\N	\N
2928	The pigeon gained status when it landed on the statue.	pigeon	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.794821	2025-07-09 13:47:02.74579	鸽子落在雕像上后，好像变得更厉害了。	AI generated	elementary	\N	\N	\N
2934	The old saint helped split the wood even though his lung hurt.	split	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:20.798452	2025-07-09 13:47:02.745791	老圣人帮忙劈柴，即使他的肺很疼。	AI generated	elementary	\N	\N	\N
2947	I want to sell my old rug because it's too small for my room.	sell	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.316796	2025-07-09 13:47:02.745792	我想卖掉我的旧地毯，因为它对我的房间来说太小了。	AI generated	elementary	\N	\N	\N
2949	Be careful! A snake might be hiding near the sink in the garden.	sink	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.32553	2025-07-09 13:47:06.376606	小心！花园水槽附近可能有蛇藏着。	AI generated	elementary	\N	\N	\N
2951	I got a good grade and saved every cent I could.	grade	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.330934	2025-07-09 13:47:06.376609	我考了个好成绩，还省下了每一分钱。	AI generated	elementary	\N	\N	\N
2953	The farm sector has problems with the snake population.	sector	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.330938	2025-07-09 13:47:06.37661	农场里蛇太多，是个问题。	AI generated	elementary	\N	\N	\N
2955	My dad got a great new TV for the living room.	tv	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.330941	2025-07-09 13:47:06.376611	我爸爸给客厅买了个很棒的新电视。	AI generated	elementary	\N	\N	\N
2957	After the workout, I need a strong and cold drink.	strong	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.334821	2025-07-09 13:47:06.376611	锻炼完后，我需要一杯冰凉又提神的饮料。	AI generated	elementary	\N	\N	\N
2959	The car wheel spun fast until it fell off.	wheel	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.484578	2025-07-09 13:47:06.376612	汽车轮子转得飞快，然后就掉了。	AI generated	elementary	\N	\N	\N
2961	She has a real talent for video editing.	talent	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.49429	2025-07-09 13:47:06.376612	她很擅长剪辑视频。	AI generated	elementary	\N	\N	\N
2963	We share this earth with many animals.	earth	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.502848	2025-07-09 13:47:06.376612	我们和很多动物一起生活在这个地球上。	AI generated	elementary	\N	\N	\N
2965	He put a new tire on his bicycle wheel.	wheel	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.502851	2025-07-09 13:47:06.376613	他给自行车的轮子换了个新轮胎。	AI generated	elementary	\N	\N	\N
2967	The kid wants a job at the store.	kid	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.502855	2025-07-09 13:47:06.376614	这个小孩想在这家商店找份工作。	AI generated	elementary	\N	\N	\N
2969	He wore a warm jacket to the race.	race	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:22.502858	2025-07-09 13:47:09.888466	他穿着一件暖和的夹克去赛跑。	AI generated	elementary	\N	\N	\N
2971	The main effect of practicing every day is to reach my goal.	effect	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:23.151312	2025-07-09 13:47:09.88847	每天练习的主要作用是达到我的目标。	AI generated	elementary	\N	\N	\N
2973	We walked one mile on the forest trail today.	mile	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:23.158273	2025-07-09 13:47:09.888471	今天我们在森林小路上走了一英里。	AI generated	elementary	\N	\N	\N
2975	I can't make my point because I lost my wallet.	point	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:23.158277	2025-07-09 13:47:09.888472	我没法说清楚我的想法，因为我丢了钱包。	AI generated	elementary	\N	\N	\N
2977	I want my plant to grow, so I will tie it to the stake.	tie	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:23.15828	2025-07-09 13:47:09.888472	我想让我的植物长大，所以我要把它绑在木桩上。	AI generated	elementary	\N	\N	\N
2979	He found a dollar mile away from his wallet.	mile	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:23.158284	2025-07-09 13:47:09.888473	他发现了一美元，离他的钱包有一英里远。	AI generated	elementary	\N	\N	\N
2981	The length of the rope is not enough to tie the boat.	length	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:23.158288	2025-07-09 13:47:09.888474	绳子的长度不够用来绑船。	AI generated	elementary	\N	\N	\N
2983	Looking in the mirror, the moon's phase seemed very bright tonight.	mirror	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.256586	2025-07-09 13:47:09.888474	看着镜子，今晚月亮的形状看起来非常明亮。	AI generated	elementary	\N	\N	\N
2985	My spouse and I want to buy a new house soon.	spouse	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.26622	2025-07-09 13:47:09.888475	我和我的配偶想尽快买一栋新房子。	AI generated	elementary	\N	\N	\N
2987	This nation needs more bread for the hungry people.	nation	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.269359	2025-07-09 13:47:09.888476	这个国家需要更多的面包给饥饿的人们。	AI generated	elementary	\N	\N	\N
2989	I need a ticket and a mirror to fix my hair on the train.	ticket	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.273283	2025-07-09 13:47:12.815048	我需要一张票和一个镜子，在火车上整理我的头发。	AI generated	elementary	\N	\N	\N
2991	Sir, I would like some meat and potatoes, please.	sir	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.273287	2025-07-09 13:47:12.815053	先生，我想要一些肉和土豆，请。	AI generated	elementary	\N	\N	\N
2993	This phase of cooking the meat takes about an hour.	phase	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.273291	2025-07-09 13:47:12.815053	烹饪肉的这个阶段大约需要一个小时。	AI generated	elementary	\N	\N	\N
2995	The modern ticket is valid for one day only.	modern	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.683735	2025-07-09 13:47:12.815054	现在的票只能用一天。	AI generated	elementary	\N	\N	\N
2997	Mostly, I object to cleaning my room!	mostly	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.695291	2025-07-09 13:47:12.815055	我最不喜欢的就是打扫我的房间！	AI generated	elementary	\N	\N	\N
3000	Birds use string to build their nest and raise their family's income.	income	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.698293	2025-07-09 13:47:12.815055	鸟儿用绳子筑巢，并增加家庭的收入。	AI generated	elementary	\N	\N	\N
3002	I bought apples for one pound in the west market.	pound	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.698296	2025-07-09 13:47:12.815056	我在西边的市场用一英镑买了苹果。	AI generated	elementary	\N	\N	\N
3004	You can count on me because my ideas are always valid.	count	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.6983	2025-07-09 13:47:12.815056	你可以相信我，因为我的想法总是对的。	AI generated	elementary	\N	\N	\N
3006	It feels unfair when I cannot vote because I am too young.	unfair	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.698304	2025-07-09 13:47:12.815057	因为我太小不能投票，这感觉不公平。	AI generated	elementary	\N	\N	\N
3008	I want to join the club, but I don't know what to do.	join	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.762559	2025-07-09 13:47:12.815058	我想加入俱乐部，但我不知道该怎么做。	AI generated	elementary	\N	\N	\N
3010	The sweat dripped into the hole in my old shoe.	sweat	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.770692	2025-07-09 13:47:15.993724	汗水滴进了我旧鞋子上的洞里。	AI generated	elementary	\N	\N	\N
3012	Be quick to take the bus so you are not late.	quick	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.770696	2025-07-09 13:47:15.993727	快点去赶公交车，这样你就不会迟到了。	AI generated	elementary	\N	\N	\N
3014	On my sixth birthday, I will join the soccer team.	sixth	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.7707	2025-07-09 13:47:15.993728	在我六岁生日那天，我会加入足球队。	AI generated	elementary	\N	\N	\N
3016	The teacher gave a candy as a reward for filling the hole.	reward	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.770703	2025-07-09 13:47:15.993729	老师给了一颗糖，作为填补洞的奖励。	AI generated	elementary	\N	\N	\N
3018	I can weave a basket if you pull the yarn for me.	weave	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:24.770707	2025-07-09 13:47:15.99373	如果你帮我拉线，我就可以编一个篮子。	AI generated	elementary	\N	\N	\N
3020	I felt guilty when I saw the sad news in the press.	guilty	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:26.510043	2025-07-09 13:47:15.99373	当我在报纸上看到这个悲伤的消息时，我感到内疚。	AI generated	elementary	\N	\N	\N
3022	Let's learn how to make a pizza for dinner tonight!	pizza	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:26.518448	2025-07-09 13:47:15.993731	今晚我们来学做披萨当晚餐吧！	AI generated	elementary	\N	\N	\N
3024	His guilty conscience weighed heavily on his spirit.	guilty	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:26.518452	2025-07-09 13:47:15.993731	他内疚的心情沉重地压在他的心上。	AI generated	elementary	\N	\N	\N
3026	Please press gently if your toe hurts.	toe	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:26.518456	2025-07-09 13:47:15.993732	如果你的脚趾疼，请轻轻地按压。	AI generated	elementary	\N	\N	\N
3028	She wore a warm scarf as she walked through the dark tunnel.	scarf	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:26.518459	2025-07-09 13:47:15.993733	她戴着一条温暖的围巾，走过黑暗的隧道。	AI generated	elementary	\N	\N	\N
3030	I feel too weak to eat the whole pizza myself.	pizza	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:26.518463	2025-07-09 13:47:19.585456	我觉得太没力气了，自己吃不完整个披萨。	AI generated	elementary	\N	\N	\N
3032	The cat sat on my lap and purred while I drank from my mug.	lap	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.508856	2025-07-09 13:47:19.585461	猫咪坐在我的腿上，咕噜咕噜地叫，我一边喝杯子里的东西。	AI generated	elementary	\N	\N	\N
3034	This unit is very important for learning math.	unit	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.508867	2025-07-09 13:47:19.585462	这个单元对学习数学非常重要。	AI generated	elementary	\N	\N	\N
3036	A little robin sat on the mug handle and chirped.	robin	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.508871	2025-07-09 13:47:19.585463	一只小知更鸟停在杯子把手上，叽叽喳喳地叫。	AI generated	elementary	\N	\N	\N
3038	The wind blew softly across the old scar on the tree.	scar	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.508875	2025-07-09 13:47:19.585463	风轻轻地吹过树上那道旧伤疤。	AI generated	elementary	\N	\N	\N
3040	This place is very sacred to my family.	very	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.508879	2025-07-09 13:47:19.585464	这个地方对我的家人来说非常神圣。	AI generated	elementary	\N	\N	\N
3042	He has a scar on his arm, a sacred reminder of his past.	scar	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.508883	2025-07-09 13:47:19.585464	他的胳膊上有一道伤疤，那是他过去的神圣回忆。	AI generated	elementary	\N	\N	\N
3044	The cake will bake well in the oven in this age of technology.	oven	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.741461	2025-07-09 13:47:19.585465	在这个科技时代，蛋糕在烤箱里会烤得很好。	AI generated	elementary	\N	\N	\N
3046	Eleven squirrels ran away into the forest near my house.	eleven	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.756102	2025-07-09 13:47:19.585466	十一只松鼠跑进了我家附近的森林里。	AI generated	elementary	\N	\N	\N
3048	The lonely princess lived in a big castle by the sea.	lonely	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.759075	2025-07-09 13:47:19.585466	孤独的公主住在海边的一座大城堡里。	AI generated	elementary	\N	\N	\N
3050	I added a pinch of salt and checked the score of the game.	salt	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.759079	2025-07-09 13:47:23.344137	我加了一点点盐，然后看了比赛的比分。	AI generated	elementary	\N	\N	\N
3052	I hope to meet new friends at the park tomorrow.	meet	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.759082	2025-07-09 13:47:23.34414	我希望明天在公园认识新朋友。	AI generated	elementary	\N	\N	\N
3054	Eleven birds flew around the tall tower near the church.	tower	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.762987	2025-07-09 13:47:23.344141	十一只小鸟绕着教堂附近的高塔飞。	AI generated	elementary	\N	\N	\N
3056	The pop star's biggest fan started a riot outside the concert venue.	fan	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.777409	2025-07-09 13:47:23.344141	那个流行歌星最大的粉丝在演唱会场馆外面闹事了。	AI generated	elementary	\N	\N	\N
3058	The judge said the athlete was declared unfit to play, wow what a shock.	unfit	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.789546	2025-07-09 13:47:23.344142	法官说那个运动员被宣布不适合比赛，哇，真让人震惊。	AI generated	elementary	\N	\N	\N
3060	I can earn extra money during the summer span.	earn	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.792952	2025-07-09 13:47:23.344142	我可以在夏天的时候赚额外的钱。	AI generated	elementary	\N	\N	\N
3062	He is simply an active member of the sports club.	simply	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.792955	2025-07-09 13:47:23.344143	他只是体育俱乐部里一个很活跃的成员。	AI generated	elementary	\N	\N	\N
3064	Showing kindness to strangers has merit and makes sense.	merit	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.792958	2025-07-09 13:47:23.344143	对陌生人友善是有好处的，而且很有道理。	AI generated	elementary	\N	\N	\N
3066	The spider's web had a large span across the window.	web	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.79296	2025-07-09 13:47:23.344143	蜘蛛网在窗户上拉得很长。	AI generated	elementary	\N	\N	\N
3068	I ate some cookies on the fourth of July.	some	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.857919	2025-07-09 13:47:23.344144	我在七月四号吃了一些饼干。	AI generated	elementary	\N	\N	\N
3070	I need some paper on my writing pad to draw.	some	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.870262	2025-07-09 13:47:26.741532	我需要在我的写字板上放些纸来画画。	AI generated	elementary	\N	\N	\N
3072	I had a tough choice and could hardly decide.	choice	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.870265	2025-07-09 13:47:26.741537	我面临一个很难的选择，很难决定。	AI generated	elementary	\N	\N	\N
3074	I would gaze at the big moon every night.	gaze	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.870269	2025-07-09 13:47:26.741538	我每天晚上都会凝视着大大的月亮。	AI generated	elementary	\N	\N	\N
3076	Please hold my hand during the lively parade.	hold	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.870272	2025-07-09 13:47:26.741538	在热闹的游行队伍中，请握住我的手。	AI generated	elementary	\N	\N	\N
3078	I bought some soft wool to knit a scarf.	some	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:38.87501	2025-07-09 13:47:26.741539	我买了一些柔软的羊毛来织围巾。	AI generated	elementary	\N	\N	\N
3080	I often trip on the stair because I don't look where I'm going.	stair	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.103854	2025-07-09 13:47:26.741539	我经常在楼梯上绊倒，因为我没有看路。	AI generated	elementary	\N	\N	\N
3083	The sun will still appear even after the storm.	still	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.118646	2025-07-09 13:47:26.74154	即使在暴风雨过后，太阳仍然会出现。	AI generated	elementary	\N	\N	\N
3085	The index finger touched the hand of the young prince with grace.	index	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.121437	2025-07-09 13:47:26.741541	食指优雅地碰触了年轻王子的手。	AI generated	elementary	\N	\N	\N
3088	The falling leaf signaled a new crisis for the worried squirrel.	leaf	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.121442	2025-07-09 13:47:26.741541	落叶预示着这只担心的松鼠将面临新的危机。	AI generated	elementary	\N	\N	\N
3090	The brown leaf was the final one to fall from the tree.	leaf	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.124324	2025-07-09 13:47:26.741542	这片棕色的叶子是最后一片从树上掉下来的叶子。	AI generated	elementary	\N	\N	\N
3092	The prince helped ease the crisis where he could, after the wound.	prince	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.124327	2025-07-09 13:47:31.195495	王子受伤后，尽力帮助缓解危机。	AI generated	elementary	\N	\N	\N
3109	The warm steam coming from the tea was a nice gift on the cold day.	steam	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.529397	2025-07-09 13:47:31.195501	寒冷的一天，茶里冒出的热气是个很好的礼物。	AI generated	intermediate	\N	\N	\N
3096	The pace of the storm was slow, but it was powerful.	pace	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.410789	2025-07-09 13:47:31.195498	暴风雨的速度很慢，但是威力很大。	AI generated	elementary	\N	\N	\N
3100	Can you send the letter in my pocket, please?	pocket	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.427059	2025-07-09 13:47:31.195499	请你帮我把口袋里的信寄出去好吗？	AI generated	elementary	\N	\N	\N
3103	I'll write a review about the small green lizard I saw.	review	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.427065	2025-07-09 13:47:31.1955	我要写一篇关于我看到的小绿蜥蜴的评论。	AI generated	elementary	\N	\N	\N
3105	I need a remedy for the bite from the little lizard.	remedy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.427068	2025-07-09 13:47:31.1955	我需要一种药来治疗被小蜥蜴咬的伤口。	AI generated	elementary	\N	\N	\N
3107	The young boy is very handy with tools.	young	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:39.427072	2025-07-09 13:47:31.195501	那个小男孩很会用工具。	AI generated	elementary	\N	\N	\N
3111	There isn't enough oxygen to breathe because of the bad traffic jam.	jam	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.529405	2025-07-09 13:47:31.195502	因为严重的交通堵塞，没有足够的氧气呼吸。	AI generated	elementary	\N	\N	\N
3113	My mom will praise me if I invite my friend over to play.	praise	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.52941	2025-07-09 13:47:31.195502	如果我邀请朋友来玩，我妈妈会表扬我。	AI generated	elementary	\N	\N	\N
3115	The detective did not praise the murder suspect.	praise	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.529414	2025-07-09 13:47:31.195503	侦探没有表扬那个杀人嫌疑犯。	AI generated	elementary	\N	\N	\N
3117	My thesis is about how important oxygen is for plants.	thesis	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.529418	2025-07-09 13:47:34.83752	我的论文是关于氧气对植物有多重要。	AI generated	elementary	\N	\N	\N
3119	I will invite you to my party, but please don't make a messy room.	messy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.529422	2025-07-09 13:47:34.837525	我会邀请你来我的派对，但是请不要把房间弄乱。	AI generated	elementary	\N	\N	\N
3121	The desert sun offered a dry warmth.	desert	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.579419	2025-07-09 13:47:34.837526	沙漠的阳光带来干燥的温暖。	AI generated	elementary	\N	\N	\N
3123	A hut provided vital shelter from the storm.	hut	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.583713	2025-07-09 13:47:34.837526	一个小屋在暴风雨中提供了重要的庇护。	AI generated	elementary	\N	\N	\N
3125	Clean water is vital and white in the glass.	white	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.583717	2025-07-09 13:47:34.837527	干净的水很重要，而且在杯子里是白色的。	AI generated	elementary	\N	\N	\N
3127	Don't cross the street if you have a rash.	cross	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.58372	2025-07-09 13:47:34.837527	如果你身上有疹子，不要过马路。	AI generated	elementary	\N	\N	\N
3129	A rare bird can wake you up.	rare	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.583724	2025-07-09 13:47:34.837528	一只稀有的鸟可以把你叫醒。	AI generated	elementary	\N	\N	\N
3131	A rare sunny day is perfect for a picnic.	rare	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.583727	2025-07-09 13:47:34.837528	难得的晴天非常适合野餐。	AI generated	elementary	\N	\N	\N
3133	The tall tree in the yard blocked our view of the mountain peak.	yard	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.598238	2025-07-09 13:47:34.837529	院子里高高的树挡住了我们看山顶的视线。	AI generated	elementary	\N	\N	\N
3135	We need to make it to the mountain peak before sunset.	make	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.60744	2025-07-09 13:47:34.837529	我们需要在日落前到达山顶。	AI generated	elementary	\N	\N	\N
3137	I can trace a line in the dirt in the yard with my finger.	trace	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.607443	2025-07-09 13:47:37.914801	我可以用手指在院子里的泥土上画一条线。	AI generated	elementary	\N	\N	\N
3139	I sing a loud song to forget my bad day.	sing	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.607447	2025-07-09 13:47:37.914805	我唱一首大声的歌来忘记糟糕的一天。	AI generated	elementary	\N	\N	\N
3141	I pay the worker, but he is still angry about the mistake.	pay	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.60745	2025-07-09 13:47:37.914805	我付了钱给工人，但他仍然对那个错误很生气。	AI generated	elementary	\N	\N	\N
3143	I will pay extra to reach the peak faster.	pay	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:42.607453	2025-07-09 13:47:37.914806	我会付额外的钱，更快地到达山顶。	AI generated	elementary	\N	\N	\N
3145	The lost dog wandered towards the familiar neighborhood, hoping to find its way home.	towards	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.024947	2025-07-09 13:47:37.914806	迷路的狗朝着熟悉的街区走去，希望能找到回家的路。	AI generated	elementary	\N	\N	\N
3147	The probability of rain didn't deter their worship service held outdoors.	probability	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.03176	2025-07-09 13:47:37.914807	下雨的可能性并没有阻止他们在户外进行礼拜。	AI generated	elementary	\N	\N	\N
3149	Her stamp collection celebrated nations achieving independence.	collection	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.031763	2025-07-09 13:47:37.914807	她的邮票收藏是为了庆祝各个国家获得独立。	AI generated	elementary	\N	\N	\N
3151	The library served as a cornerstone of the thriving neighborhood.	library	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.031765	2025-07-09 13:47:37.914808	图书馆是繁荣社区的基石。	AI generated	elementary	\N	\N	\N
3153	Patience is key while improving the safety of our neighborhood.	patience	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.031767	2025-07-09 13:47:37.914808	在改善我们社区安全的同时，耐心是关键。	AI generated	elementary	\N	\N	\N
3155	Patience is a critical element for success in any scientific endeavor.	patience	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.03177	2025-07-09 13:47:37.914809	耐心是任何科学事业成功的关键因素。	AI generated	elementary	\N	\N	\N
3157	The shop can supply shirts in any size you need.	supply	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.344617	2025-07-09 13:47:41.486659	这家商店可以提供任何你需要的尺寸的衬衫。	AI generated	elementary	\N	\N	\N
3159	The little boy was eager to try the new size of ice cream.	eager	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.348261	2025-07-09 13:47:41.486663	那个小男孩很想尝尝新尺寸的冰淇淋。	AI generated	elementary	\N	\N	\N
3161	The prince is the heir, so we watch him carefully.	heir	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.348264	2025-07-09 13:47:41.486664	王子是继承人，所以我们仔细地看着他。	AI generated	elementary	\N	\N	\N
3163	They had a long debate about the depth of the pool.	depth	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.348266	2025-07-09 13:47:41.486665	他们就游泳池的深度进行了长时间的讨论。	AI generated	elementary	\N	\N	\N
3165	The dentist said my tooth looks healthy for this planet.	tooth	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.348269	2025-07-09 13:47:41.486666	牙医说我的牙齿在这个星球上看起来很健康。	AI generated	elementary	\N	\N	\N
3167	I like to drink my coffee while looking at the faraway planet.	coffee	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.350478	2025-07-09 13:47:41.486666	我喜欢一边喝咖啡，一边看着遥远的星球。	AI generated	elementary	\N	\N	\N
3169	The unlikely event required a detailed explanation, which no one believed.	unlikely	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.35801	2025-07-09 13:47:41.486667	这个不太可能发生的事情需要详细的解释，但没人相信。	AI generated	elementary	\N	\N	\N
3171	Widespread use of this new software lets us monitor network traffic efficiently.	widespread	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.365354	2025-07-09 13:47:41.486668	广泛使用这个新软件让我们能有效地监控网络流量。	AI generated	elementary	\N	\N	\N
3173	He had a struggle writing the final paragraph of his essay.	struggle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.370379	2025-07-09 13:47:41.486668	他很费劲地写他文章的最后一段。	AI generated	elementary	\N	\N	\N
3175	Especially after the hard landing, the pilot needed some time to recuperate.	especially	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.370382	2025-07-09 13:47:41.486669	特别是在硬着陆之后，飞行员需要一些时间来恢复。	AI generated	elementary	\N	\N	\N
3177	His performance was so miserable that he lost the competition.	performance	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.370385	2025-07-09 13:47:44.662312	他的表现太糟糕了，所以输了比赛。	AI generated	elementary	\N	\N	\N
3179	The satellite launching will be broadcast on television sometime next week.	satellite	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:43.370387	2025-07-09 13:47:44.662316	卫星发射将在下周某个时候在电视上播出。	AI generated	elementary	\N	\N	\N
3183	The inspiring speaker spoke so naturally that every listener felt connected to his story.	naturally	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.481296	2025-07-09 13:47:44.662316	这位鼓舞人心的演讲者说得非常自然，让每个听众都感觉与他的故事息息相关。	AI generated	elementary	\N	\N	\N
3185	The discount enticed the listener to finally subscribe to the premium podcast service.	discount	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.481303	2025-07-09 13:47:44.662317	折扣吸引了听众，最终订阅了高级播客服务。	AI generated	elementary	\N	\N	\N
3207	The patient’s upset stomach was likely a reaction to changes in his constitution after surgery.	stomach	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.006394	2025-07-09 13:47:48.65604	病人肚子不舒服可能是手术后身体变化引起的。	AI generated	intermediate	\N	\N	\N
3187	Feeling unhappy with their progress, the team had to prepare a revised plan.	unhappy	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.481306	2025-07-09 13:47:44.662318	因为对他们的进展不满意，团队不得不准备一份修改后的计划。	AI generated	elementary	\N	\N	\N
3214	His immediate reaction to the complex equation was frustration, seeing it as an insurmountable obstacle.	reaction	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.023124	2025-07-09 13:47:48.656042	他对复杂方程式的直接反应是沮丧，觉得它是一个无法克服的障碍。	AI generated	intermediate	\N	\N	\N
3189	The company was unhappy with the consistently low sales figures this quarter.	company	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.481309	2025-07-09 13:47:44.662318	公司对本季度持续低迷的销售额感到不满意。	AI generated	elementary	\N	\N	\N
3191	The safety mechanism activated voluntarily, preventing a potentially dangerous situation.	mechanism	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.481312	2025-07-09 13:47:44.662319	安全装置自动启动，避免了潜在的危险情况。	AI generated	elementary	\N	\N	\N
3193	It was difficult to find participants who would help voluntarily with the study.	difficult	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.481315	2025-07-09 13:47:44.662319	很难找到愿意自愿帮助进行这项研究的参与者。	AI generated	elementary	\N	\N	\N
3195	The small business struggled with the transmission failure, halting operations for a week.	transmission	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.747698	2025-07-09 13:47:44.66232	这家小公司遇到了传输故障，导致运营中断了一周。	AI generated	elementary	\N	\N	\N
3197	The mixture of emotions left her surprised and speechless.	mixture	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.755845	2025-07-09 13:47:44.66232	各种各样的情绪让她感到惊讶和说不出话来。	AI generated	elementary	\N	\N	\N
3199	Please specify what kind of furniture you want for the living room.	furniture	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.755848	2025-07-09 13:47:48.656033	请说清楚你想要什么样的客厅家具。	AI generated	elementary	\N	\N	\N
3201	Her tolerance for rude behavior was tested by the harsh reality of the situation.	tolerance	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.755851	2025-07-09 13:47:48.656038	她对粗鲁行为的忍耐度受到了严峻现实的考验。	AI generated	elementary	\N	\N	\N
3203	The director didn't specify which episode would be the season finale.	specify	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.758575	2025-07-09 13:47:48.656039	导演没有说清楚哪一集会是本季的最后一集。	AI generated	elementary	\N	\N	\N
3205	I am willing to assist with the transmission of important documents immediately.	willing	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:46.764184	2025-07-09 13:47:48.65604	我愿意立即帮助传送重要的文件。	AI generated	elementary	\N	\N	\N
3210	The primary goal of this antenna is to transmit high-quality data wirelessly.	transmit	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.019179	2025-07-09 13:47:48.656041	这个天线的主要目的是无线传输高质量的数据。	AI generated	elementary	\N	\N	\N
3212	Each generation applies the paint more lightly to avoid damaging the antique furniture.	generation	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.019183	2025-07-09 13:47:48.656042	每一代人都轻轻地涂漆，以避免损坏古董家具。	AI generated	elementary	\N	\N	\N
3220	While the project showed some progress, a realistic assessment indicated further delays were likely.	progress	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.202136	2025-07-09 13:47:48.656043	虽然这个项目取得了一些进展，但实际评估表明可能会有进一步的延误。	AI generated	elementary	\N	\N	\N
3222	The outdoor concert, focused on preserving the endangered species' habitat, was a huge success.	concert	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.206043	2025-07-09 13:47:48.656044	以保护濒危物种栖息地为主题的户外音乐会取得了巨大的成功。	AI generated	elementary	\N	\N	\N
3226	Economic progress in the new republic was slow but steady, despite early challenges.	progress	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.217605	2025-07-09 13:47:51.783977	新共和国的经济进步虽然慢，但很稳定，尽管一开始有很多困难。	AI generated	elementary	\N	\N	\N
3234	A surprisingly small quantity of pollution can have a visible effect on the air quality.	quantity	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.33393	2025-07-09 13:47:51.783985	很少的污染也会对空气质量产生明显的影响。	AI generated	intermediate	\N	\N	\N
3228	The significance of her discovery had a positive impact on the entire scientific community.	significance	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.220073	2025-07-09 13:47:51.783982	她的发现很重要，对整个科学界都有好的影响。	AI generated	elementary	\N	\N	\N
3238	Even a small, gradual increase in the quantity of exercise you do can have a positive impact.	quantity	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.333936	2025-07-09 13:47:51.783986	即使你做的运动量一点点地增加，也会有好的影响。	AI generated	intermediate	\N	\N	\N
3230	She understood the significance of the stranger's warning, although she did not trust him.	significance	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.223578	2025-07-09 13:47:51.783983	她明白陌生人警告的重要性，虽然她不信任他。	AI generated	elementary	\N	\N	\N
3242	Depending on the quantity of items, you can check yourself out at the express lane.	yourself	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.333942	2025-07-09 13:47:51.783987	根据东西的数量，你可以在快速通道自己结账。	AI generated	intermediate	\N	\N	\N
3232	Knowing how to manage your time is a valuable, but sometimes visible, asset.	valuable	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.328621	2025-07-09 13:47:51.783984	知道如何管理你的时间很有用，而且有时候能看出来。	AI generated	elementary	\N	\N	\N
3236	The situation demanded a gradual and carefully considered response from the authorities.	situation	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.333933	2025-07-09 13:47:51.783985	这种情况需要有关部门慢慢地、仔细地做出反应。	AI generated	elementary	\N	\N	\N
3240	The gradual thawing of the ice made the shoreline more visible each day.	gradual	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:46:47.333939	2025-07-09 13:47:51.783987	冰慢慢融化，海岸线每天都变得更清楚可见。	AI generated	elementary	\N	\N	\N
3244	I put some pepper on my eggs, and then I ate seven of them!	pepper	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.025532	2025-07-09 13:47:51.783988	我在鸡蛋上撒了些胡椒粉，然后我吃了七个！	AI generated	elementary	\N	\N	\N
3246	I wonder where all my money went after I bought the candy.	money	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.025544	2025-07-09 13:47:55.414429	我买了糖之后，我的钱都去哪儿了呢？	AI generated	elementary	\N	\N	\N
3248	The toy car was on the top shelf, made of soft cotton.	top	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.025548	2025-07-09 13:47:55.414432	玩具车在最高的架子上，是用软软的棉花做的。	AI generated	elementary	\N	\N	\N
3250	I wonder if the little pig likes to play in the mud.	pig	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.025552	2025-07-09 13:47:55.414433	我想知道小猪是不是喜欢在泥巴里玩。	AI generated	elementary	\N	\N	\N
3252	The top of the cake has cream and sprinkles.	top	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.025556	2025-07-09 13:47:55.414433	蛋糕的顶上有很多奶油和彩色糖粒。	AI generated	elementary	\N	\N	\N
3254	I wonder if I will see a bomb in a movie today.	wonder	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.02556	2025-07-09 13:47:55.414434	我想知道今天看电影会不会看到炸弹。	AI generated	elementary	\N	\N	\N
3256	To sow seeds, use a soft touch so you don't damage them.	sow	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.234661	2025-07-09 13:47:55.414434	播种的时候，要轻轻地，别弄坏了种子。	AI generated	elementary	\N	\N	\N
3258	The boat had a special sauce for the fish we caught.	boat	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.247011	2025-07-09 13:47:55.414435	船上有特别的酱汁，用来配我们抓到的鱼。	AI generated	elementary	\N	\N	\N
3260	The swirling leaves showed the wind's motion in the little league game.	motion	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.247014	2025-07-09 13:47:55.414435	旋转的树叶在少儿棒球比赛中显示了风的运动。	AI generated	elementary	\N	\N	\N
3262	The little boat was soft and quiet in the still water.	boat	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.250165	2025-07-09 13:47:55.414436	小船在平静的水面上，软软的，很安静。	AI generated	elementary	\N	\N	\N
3264	There is lots of space on the boat for everyone to sit.	space	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.250168	2025-07-09 13:47:55.414436	船上有很多地方，够每个人坐。	AI generated	elementary	\N	\N	\N
3266	Grab a stick, and say hello to the dog to make friends.	stick	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.250172	2025-07-09 13:47:58.853065	捡起一根小棍，跟小狗打个招呼，和它交朋友。	AI generated	elementary	\N	\N	\N
3268	After sitting at the computer all day, I needed a good stretch.	computer	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.272453	2025-07-09 13:47:58.853069	整天坐在电脑前，我需要好好伸展一下身体。	AI generated	elementary	\N	\N	\N
3270	The mystery surrounding his sudden disappearance deepened after his social club membership was revoked.	mystery	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.281078	2025-07-09 13:47:58.853069	在他被取消了社交俱乐部的会员资格后，他突然失踪的谜团变得更深了。	AI generated	elementary	\N	\N	\N
3272	The winning combination for the raffle will be announced this afternoon.	combination	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.281082	2025-07-09 13:47:58.85307	今天下午会公布抽奖的中奖号码。	AI generated	elementary	\N	\N	\N
3274	It was obvious that their ultimate destination was a tropical island.	obvious	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.281085	2025-07-09 13:47:58.85307	很明显，他们最终要去的地方是一个热带岛屿。	AI generated	elementary	\N	\N	\N
3276	Our final destination was a small town famous for its local sausage.	destination	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.28979	2025-07-09 13:47:58.853071	我们最终的目的地是一个以当地香肠闻名的小镇。	AI generated	elementary	\N	\N	\N
3278	The athlete had to stretch before the athletic gear manufacture competition began.	stretch	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.293086	2025-07-09 13:47:58.853071	运动员必须在运动装备制造比赛开始前做伸展运动。	AI generated	elementary	\N	\N	\N
3280	Their risky new venture proved financially dishonest, causing many investors to lose heavily.	venture	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.441409	2025-07-09 13:47:58.853072	他们冒险的新生意被证明在财务上不诚实，导致许多投资者损失惨重。	AI generated	elementary	\N	\N	\N
3282	The documentary offered a fantastic overview of the delicate ecology of the Amazon rainforest.	fantastic	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.448414	2025-07-09 13:47:58.853072	这部纪录片精彩地介绍了亚马逊雨林脆弱的生态环境。	AI generated	elementary	\N	\N	\N
3284	Protection of our planet's fragile ecology requires global cooperation and immediate action.	protection	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.448418	2025-07-09 13:47:58.853073	保护我们星球脆弱的生态环境需要全球合作和立即行动。	AI generated	elementary	\N	\N	\N
3286	The dishonest salesman tried to squeeze every last penny from his vulnerable customers.	dishonest	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.448421	2025-07-09 13:48:02.482036	那个不诚实的售货员想从容易上当的顾客身上榨取最后一分钱。	AI generated	elementary	\N	\N	\N
3288	The school principal announced a new policy regarding the use of the school vehicle.	vehicle	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.452311	2025-07-09 13:48:02.48204	学校校长宣布了一项关于使用学校车辆的新规定。	AI generated	elementary	\N	\N	\N
3290	I needed to persuade him that the main ingredient was not optional, but vital.	persuade	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.452315	2025-07-09 13:48:02.482041	我需要说服他，主要的配料不是可有可无的，而是非常重要的。	AI generated	elementary	\N	\N	\N
3292	The tide was high, so we decided to lounge on the beach all day.	tide	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.742477	2025-07-09 13:48:02.482042	潮水很高，所以我们决定在沙滩上放松一整天。	AI generated	elementary	\N	\N	\N
3294	The taste of the delicious dinner made me very happy.	taste	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.751814	2025-07-09 13:48:02.482043	美味晚餐的味道让我非常开心。	AI generated	elementary	\N	\N	\N
3296	He wore a helmet because he saw a sleepy koala in the tree.	helmet	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.751818	2025-07-09 13:48:02.482044	他戴着头盔，因为他看到树上有一只昏昏欲睡的考拉。	AI generated	elementary	\N	\N	\N
3298	The beautiful rose was his favorite flower in the garden.	rose	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.751822	2025-07-09 13:48:02.482044	美丽的玫瑰花是他花园里最喜欢的花。	AI generated	elementary	\N	\N	\N
3300	We had to pause the video of the cute baby koala.	koala	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.754875	2025-07-09 13:48:02.482045	我们不得不暂停播放那个可爱的考拉宝宝的视频。	AI generated	elementary	\N	\N	\N
3302	I will call you after dinner on my new phone.	dinner	SVA	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:33.757241	2025-07-09 13:48:02.482046	晚饭后我会用我的新手机给你打电话。	AI generated	elementary	\N	\N	\N
3304	The variable sweetness of the pumpkin pie depends greatly on the specific variety used.	variable	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:34.323903	2025-07-09 13:48:02.482046	南瓜派的甜度变化很大，这主要取决于使用的南瓜品种。	AI generated	elementary	\N	\N	\N
3310	Recognizing the variable nature of life, she expressed profound gratitude for every small joy.	variable	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:34.33944	2025-07-09 13:48:05.758263	因为明白生活总是变化的，她对每一个小小的快乐都充满感激。	AI generated	elementary	\N	\N	\N
3312	Only a small percent of the pumpkin crop was unaffected by the early frost.	pumpkin	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:34.339443	2025-07-09 13:48:05.758264	只有一小部分的南瓜没有受到早霜的影响。	AI generated	elementary	\N	\N	\N
3314	The sociologist's lecture examined the evolving values within our modern society.	society	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:34.339446	2025-07-09 13:48:05.758264	社会学家的讲座研究了我们现代社会不断变化的价值观。	AI generated	elementary	\N	\N	\N
3316	The farmer saw the fluffy sheep get hit by a falling branch.	sheep	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:36.686512	2025-07-09 13:48:05.758265	农夫看到毛茸茸的绵羊被掉落的树枝砸到了。	AI generated	elementary	\N	\N	\N
3318	The construction worker used the spade to hit the hard ground.	hit	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:36.695214	2025-07-09 13:48:05.758265	建筑工人用铲子敲打坚硬的地面。	AI generated	elementary	\N	\N	\N
3320	The lifeguard used his shield to protect himself from the rough shore.	shield	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:36.700204	2025-07-09 13:48:05.758266	救生员用他的盾牌保护自己免受海浪的冲击。	AI generated	elementary	\N	\N	\N
3322	He was proud to show off his new spade to his friends.	spade	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:36.702755	2025-07-09 13:48:05.758266	他很自豪地向朋友们炫耀他的新铲子。	AI generated	elementary	\N	\N	\N
3324	The wet sand stuck to the spade after digging.	wet	SV	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:36.706244	2025-07-09 13:48:05.758267	挖完东西后，湿沙子粘在了铲子上。	AI generated	elementary	\N	\N	\N
3326	He knew that his shield would keep him safe.	that	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:36.706248	2025-07-09 13:48:07.803274	他知道他的盾牌会保护他的安全。	AI generated	elementary	\N	\N	\N
3328	The new law helps to secure our community.	law	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:37.167851	2025-07-09 13:48:07.803278	新的法律帮助保护我们的社区。	AI generated	elementary	\N	\N	\N
3306	The judge asked the courtroom to include a moment of silence for the victim's family.	silence	SVO	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:34.329457	2025-07-09 13:48:05.758258	法官请法庭为受害者的家人默哀片刻。	AI generated	intermediate	\N	\N	\N
3308	Although unusual, a pumpkin carving contest became a symbol for justice in the small town.	pumpkin	SVC	0.95	0.95	0	0	0	f	\N	PENDING	\N	\N	0	\N	2025-07-09 04:52:34.332431	2025-07-09 13:48:05.758262	虽然不常见，但南瓜雕刻比赛成了小镇正义的象征。	AI generated	intermediate	\N	\N	\N
\.


--
-- Data for Name: sentences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sentences (id, text, difficulty, grade_level, topic, source, audio_url, created_at, updated_at) FROM stdin;
1	The cat is sleeping on the bed.	1	2	animals	manual	/static/audio_cache/047d28f25e64cad5eca8277f815b1f41.mp3	2025-07-06 07:44:43.848871	2025-07-10 12:29:35.398598
2	I have a red apple for lunch.	1	2	food	manual	/static/audio_cache/b0c3929384c7192caf2a93fc017e33dc.mp3	2025-07-06 07:44:43.848874	2025-07-10 12:29:35.398602
3	My mother likes blue flowers.	2	3	family	manual	/static/audio_cache/71deacba269667eb30711a486e000765.mp3	2025-07-06 07:44:43.848875	2025-07-10 12:29:35.398603
4	The elephant is very big and gray.	2	3	animals	manual	/static/audio_cache/5ad1778f427f83cf54f34cf98631d0f6.mp3	2025-07-06 07:44:43.848876	2025-07-10 12:29:35.398604
5	My grandmother makes delicious sandwiches.	3	4	family	manual	/static/audio_cache/5d4f8d7664ae8f4e808f2d066e113812.mp3	2025-07-06 07:44:43.848877	2025-07-10 12:29:35.398607
\.


--
-- Data for Name: vocabulary_libraries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vocabulary_libraries (id, library_id, name, description, library_type, grade_level, total_words, core_words, difficulty_min, difficulty_max, categories, tags, is_active, is_public, is_system_library, version, last_updated_by, created_at, updated_at) FROM stdin;
8	middle_school_all	初中阶段所有单词	初中1-3年级所有必学单词合集	GRADE_BASED	9	0	0	1	5	["\\u8fdb\\u9636\\u8bcd\\u6c47", "\\u5b66\\u79d1\\u8bcd\\u6c47", "\\u793e\\u4f1a\\u6587\\u5316"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.254639	2025-07-10 07:46:56.25464
9	grade_7	初中一年级单词	初中一年级（七年级）上下学期必学单词	GRADE_BASED	7	0	0	1	5	["\\u5b66\\u79d1\\u8bcd\\u6c47", "\\u751f\\u6d3b\\u6280\\u80fd", "\\u79d1\\u6280"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.256108	2025-07-10 07:46:56.256109
10	grade_8	初中二年级单词	初中二年级（八年级）上下学期必学单词	GRADE_BASED	8	0	0	1	5	["\\u73af\\u5883", "\\u5386\\u53f2", "\\u6587\\u5b66", "\\u827a\\u672f"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.257577	2025-07-10 07:46:56.257578
11	grade_9	初中三年级单词	初中三年级（九年级）上下学期必学单词	GRADE_BASED	9	0	0	1	5	["\\u9ad8\\u7ea7\\u8bcd\\u6c47", "\\u5b66\\u672f\\u8bcd\\u6c47", "\\u793e\\u4f1a\\u8bae\\u9898"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.259015	2025-07-10 07:46:56.259017
14	family_friends	家庭与朋友词库	包含家庭成员、朋友关系、社交等单词	THEMATIC	\N	0	0	1	5	["\\u5bb6\\u5ead", "\\u670b\\u53cb", "\\u5173\\u7cfb", "\\u793e\\u4ea4"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.263031	2025-07-10 07:46:56.263033
15	school_subjects	学校与学科词库	包含学校设施、学科名称、学习用品等单词	THEMATIC	\N	0	0	1	5	["\\u5b66\\u6821", "\\u5b66\\u79d1", "\\u5b66\\u4e60\\u7528\\u54c1", "\\u6559\\u80b2"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.264594	2025-07-10 07:46:56.264595
16	sports_hobbies	运动与爱好词库	包含各类运动、爱好、娱乐活动等单词	THEMATIC	\N	0	0	1	5	["\\u8fd0\\u52a8", "\\u7231\\u597d", "\\u5a31\\u4e50", "\\u6e38\\u620f"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.265773	2025-07-10 07:46:56.265775
3	grade_2	小学二年级单词	小学二年级上下学期必学单词	grade_based	2	456	456	1	5	["\\u65e5\\u5e38\\u7528\\u54c1", "\\u98df\\u7269", "\\u8eab\\u4f53\\u90e8\\u4f4d", "\\u6570\\u5b57"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.246196	2025-07-13 02:28:02.087926
4	grade_3	小学三年级单词	小学三年级上下学期必学单词	grade_based	3	940	940	1	5	["\\u5b66\\u6821\\u7528\\u54c1", "\\u8fd0\\u52a8", "\\u5929\\u6c14", "\\u65f6\\u95f4"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.248285	2025-07-13 02:28:03.061639
13	food_drinks	食物与饮品词库	包含各类食物、饮品、餐具等相关单词	thematic	\N	0	0	1	5	["\\u98df\\u7269", "\\u996e\\u54c1", "\\u9910\\u5177", "\\u70f9\\u996a"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.261692	2025-07-10 08:02:34.08467
5	grade_4	小学四年级单词	小学四年级上下学期必学单词	GRADE_BASED	4	615	615	1	5	["\\u804c\\u4e1a", "\\u4ea4\\u901a", "\\u8282\\u65e5", "\\u670d\\u88c5"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.250259	2025-07-13 02:28:03.726311
6	grade_5	小学五年级单词	小学五年级上下学期必学单词	GRADE_BASED	5	282	282	1	5	["\\u79d1\\u76ee", "\\u5730\\u7406", "\\u81ea\\u7136", "\\u60c5\\u611f"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.251637	2025-07-13 02:28:04.032324
12	animals_nature	动物与自然词库	包含动物、植物、自然现象等主题单词	thematic	\N	1	1	1	5	["\\u52a8\\u7269", "\\u690d\\u7269", "\\u81ea\\u7136\\u73b0\\u8c61", "\\u73af\\u5883"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.260328	2025-07-10 08:02:34.145799
2	grade_1	小学一年级单词	小学一年级上下学期必学单词	grade_based	1	254	254	1	5	["\\u57fa\\u7840\\u8bcd\\u6c47", "\\u5bb6\\u5ead", "\\u52a8\\u7269", "\\u989c\\u8272"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.244051	2025-07-13 02:28:01.593858
7	grade_6	小学六年级单词	小学六年级上下学期必学单词	GRADE_BASED	6	102	102	1	5	["\\u8fdb\\u9636\\u8bcd\\u6c47", "\\u62bd\\u8c61\\u6982\\u5ff5", "\\u793e\\u4f1a\\u751f\\u6d3b"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.253157	2025-07-13 02:28:04.146561
1	elementary_all	小学阶段所有单词	小学1-6年级所有必学单词合集	grade_based	6	2649	2649	1	5	["\\u57fa\\u7840\\u8bcd\\u6c47", "\\u65e5\\u5e38\\u7528\\u8bed", "\\u5b66\\u6821\\u751f\\u6d3b"]	\N	t	t	t	1.0	\N	2025-07-10 07:46:56.241158	2025-07-13 02:28:07.021685
17	小学五年级单词（外研社一年级起点）	小学五年级单词（外研社一年级起点）		custom	5	155	155	1	5	["imported"]	\N	t	t	t	1.0	3	2025-07-13 00:38:57.914854	2025-07-13 03:17:13.329037
\.


--
-- Data for Name: words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.words (id, word, phonetic, definition, part_of_speech, grade_level, frequency, difficulty, created_at, updated_at, pronunciation, chinese_meaning, difficulty_level, audio_url, image_url, example_sentence, example_chinese, etymology, synonyms, antonyms, related_words, irregular_forms, usage_notes, common_mistakes, source, is_active, is_core_vocabulary, created_by) FROM stdin;
140	book	/bʊk/	A set of printed pages that are fastened inside a cover	noun	1	0	1	2025-07-06 15:11:44.381168	2025-07-10 07:53:04.197137	BOOK	书	easy	\N	\N	Please open your book.	请打开你的书。	\N	\N	\N	\N	\N	\N	\N	system	t	t	\N
1693	run	/rʌn/	To move quickly using your legs	verb	1	0	1	2025-07-06 15:11:47.783364	2025-07-10 07:53:04.204146	RUN	跑	easy	\N	\N	I like to run in the park.	我喜欢在公园里跑步。	\N	\N	\N	\N	\N	\N	\N	system	t	t	\N
171	cake	\N	\N	noun	2	0	2	2025-07-06 15:11:44.445179	2025-07-13 01:22:27.563371	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/7a8921f8a333e830dc9d2521c5ac7c9a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
93	away	\N	\N	noun	2	0	2	2025-07-06 15:11:44.2747	2025-07-13 01:30:25.656491	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2512adf2f04f3cb17183a51297f290cd.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
405	down	\N	\N	preposition	1	0	2	2025-07-06 15:11:44.951641	2025-07-13 01:31:19.446874	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/ea778da9986d17a896ed7987c74ef8cb.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
2200	the	\N	\N	noun	1	0	1	2025-07-06 15:11:48.921279	2025-07-13 01:35:29.420687	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2daabf7cc1c14506a441a7b59a1471de.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
2151	take	\N	\N	noun	2	0	2	2025-07-06 15:11:48.816204	2025-07-13 01:35:35.51949	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b68e9f06bc1837fbe5ecc2f9e41ad5e3.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
1991	square	\N	\N	noun	3	0	3	2025-07-06 15:11:48.455191	2025-07-13 01:35:44.292459	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/59c159b91b6d5a5d1fd98695fe81f1a5.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
2241	tidy	\N	\N	noun	2	0	2	2025-07-06 15:11:49.016023	2025-07-13 01:36:31.120447	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b0410bdf6d9ef0afee8c46a53c50e96d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
2635	much			\N	1	0	1	2025-07-13 00:38:58.042688	2025-07-13 01:37:36.120872	\N	多	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6811ff413bc8a376585d6214202f7df7.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	f	f	3
190	carry	/ˈkæri/	\N	noun	5	0	2	2025-07-06 15:11:44.484562	2025-07-13 03:17:14.842331	\N	携带	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/1c53e83d1b960e78e9cd67d529552ea5.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2646	ceremony			\N	1	0	1	2025-07-13 00:38:58.281555	2025-07-13 01:21:56.27716	\N	典礼	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/adb8ecf7ddc5f564d4edfee540e0603d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	f	f	3
531	fish	\N	\N	noun	2	0	2	2025-07-06 15:11:45.225396	2025-07-13 01:22:44.900035	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6088685cc3699f5f27b5261e533ee1fd.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
725	how	\N	\N	noun	1	0	1	2025-07-06 15:11:45.645218	2025-07-13 01:33:10.212153	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/3b660fb8ef13fa5192252768622a4c63.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
2392	up	\N	\N	preposition	1	0	1	2025-07-06 15:11:49.360678	2025-07-13 01:36:22.394981	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/f06e8b448077ab24f98f664a627c9cc3.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
1057	moon	\N	\N	noun	2	0	2	2025-07-06 15:11:46.376428	2025-07-13 01:37:30.220737	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/ff942f02bf934fbbdebcaa869c1384ca.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
163	build	/bɪld/	\N	noun	5	0	2	2025-07-06 15:11:44.42801	2025-07-13 03:17:15.908926	\N	建造	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6238e88215dd56d4c5c220ca3d1c0f2c.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2657	double			\N	1	0	1	2025-07-13 00:38:58.459277	2025-07-13 01:31:49.065559	\N	双	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/360d0993c2aabfc01db378eed34864ae.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	f	f	3
1169	ok	\N	\N	noun	1	0	1	2025-07-06 15:11:46.623632	2025-07-13 01:34:06.327742	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/0df22586d03c57dd38247e3b218245fd.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
2254	to	\N	\N	preposition	1	0	1	2025-07-06 15:11:49.044998	2025-07-13 01:35:20.582752	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/bae38b13f29a6fbe5a6a8967f969f7c9.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
95	back	/bæk/	\N	noun	5	0	2	2025-07-06 15:11:44.278747	2025-07-13 03:17:16.996553	\N	背	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/1d9648a6809f54ad4890ba61244968ee.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
608	go	\N	\N	noun	1	0	1	2025-07-06 15:11:45.390276	2025-07-13 01:23:06.038233	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/814a3eccb5f159a36a3dfc604f3cc89a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
2663	nineth			\N	1	0	1	2025-07-13 00:38:58.545868	2025-07-13 01:33:45.491622	\N	第九	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/c1ec88eddf2dda81d02232e365462407.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	f	f	3
2668	assistant			\N	1	0	1	2025-07-13 00:38:58.587653	2025-07-13 01:41:42.073719	\N	助理	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a8f0878f9403a12b237c97132d561daa.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	f	f	3
135	blind	/blaɪnd/	\N	noun	5	0	2	2025-07-06 15:11:44.370246	2025-07-13 03:17:18.288692	\N	瞎	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2abb181762b8a05db651e10ed9c63880.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
669	have	\N	\N	noun	1	0	2	2025-07-06 15:11:45.52468	2025-07-13 01:23:30.867081	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/aaa1b2fe701a325af2cfb27fd5b46bff.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
412	drive	/draɪv/	\N	adjective	5	0	2	2025-07-06 15:11:44.968254	2025-07-13 03:17:19.441739	\N	驾驶	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/756cb9d566961a5913291221ab37b27b.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
437	eighty	/ˈeɪti/	\N	noun	5	0	4	2025-07-06 15:11:45.025747	2025-07-13 03:17:20.550898	\N	八十	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/05109858522f53c9fb0f920011f20ae8.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
808	joke	/dʒoʊk/	\N	noun	5	0	2	2025-07-06 15:11:45.818053	2025-07-13 03:17:21.548607	\N	笑话	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/7f51b642c1829d8f0fbab0595a1845dc.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1029	mine	/maɪn/	\N	noun	5	0	2	2025-07-06 15:11:46.314657	2025-07-13 03:17:22.763186	\N	我的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/c94ac473617a827bea9e736ba5236683.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1841	show	/ʃoʊ/	\N	noun	5	0	2	2025-07-06 15:11:48.113762	2025-07-13 03:17:23.901969	\N	展示	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6db43a9396596f6bbe1f7e86c08b1afe.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2029	still	/stɪl/	\N	noun	5	0	2	2025-07-06 15:11:48.555399	2025-07-13 03:17:24.919688	\N	仍然	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/5dfd88c68eba2f6411e5076a64cc62c2.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2673	actor	/ˈæktɚ/		\N	5	0	1	2025-07-13 00:38:58.678797	2025-07-13 03:17:25.945125	\N	演员	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/f4d23181c5681f658c8116d953d76a0f.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
110	bed	\N	\N	noun	1	0	1	2025-07-06 15:11:44.310281	2025-07-13 01:16:49.729249	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/0ffc9d65a10cd6a3cb78c093a2542b69.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
51	and	\N	\N	conjunction	1	0	1	2025-07-06 15:11:44.181728	2025-07-13 01:20:54.019834	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/5c5631a984a40f5a94e1e0c8f5a0eca3.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
216	chips	\N	\N	noun	3	0	2	2025-07-06 15:11:44.542071	2025-07-13 01:21:50.303245	\N	待翻译	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/8bfef9324570fe8b9f198d618083cdd0.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	f	f	\N
2650	fun			\N	1	0	1	2025-07-13 00:38:58.337026	2025-07-13 01:22:38.623899	\N	乐趣	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a031c955dce24f6deb055bf484326fb1.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	f	f	3
2680	the mid-autumn festival	/ðə ˌmɪd ˈɔtəm ˈfɛstəvəl/		\N	5	0	1	2025-07-13 02:32:35.26509	2025-07-13 03:17:35.454703	\N	中秋节	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/1c7f4ff40c88d16e90a0396290716b69.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2681	tian'anmen square	/tiˌænˈɑnˌmɛn ˈskwɛr/		\N	5	0	1	2025-07-13 02:32:35.268419	2025-07-13 03:17:36.698811	\N	天安门广场	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/ec5df452255dd95c93b9a719c8af7de6.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2682	tidy up	/ˌtaɪdi ˈʌp/		\N	5	0	1	2025-07-13 02:32:35.271566	2025-07-13 03:17:38.028609	\N	整理	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a94c894946e0fb7ff408fd8cbed125eb.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2683	fish and chips	/ˈfɪʃ ən ˈtʃɪps/		\N	5	0	1	2025-07-13 02:32:35.274957	2025-07-13 03:17:39.233038	\N	炸鱼薯条	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/707115bb8a5987eecd8ed45ac573949e.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2684	how much	/haʊ ˈmʌtʃ/		\N	5	0	1	2025-07-13 02:32:35.278219	2025-07-13 03:17:40.544856	\N	多少	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/e36e71b640a5e83e5f73725edf886ba4.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2685	sales assistant	/ˈseɪlz əˌsɪstənt/		\N	5	0	1	2025-07-13 02:32:35.281498	2025-07-13 03:17:41.555422	\N	销售助理	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/edd8bbe13a0f7657efeab9f58c189281.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2674	flag-rasing ceremony	/ˈflæɡˌreɪzɪŋ ˈsɛrəˌmoʊni/		\N	5	0	1	2025-07-13 02:32:35.242781	2025-07-13 03:17:27.241182	\N	升旗仪式	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/496cb9e8add79fac3589fa20e163c8db.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2675	go to bed	/ɡoʊ tə bɛd/		\N	5	0	1	2025-07-13 02:32:35.248434	2025-07-13 03:17:28.594979	\N	睡觉	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/0aad7f9b45b9bc6f6c8421347f8b3e6e.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2676	moon cake	/ˈmun ˌkeɪk/		\N	5	0	1	2025-07-13 02:32:35.252018	2025-07-13 03:17:29.994869	\N	月饼	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a661f8cce210e703f7fb98c74aad045c.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2677	take away	/ˌteɪk əˈweɪ/		\N	5	0	1	2025-07-13 02:32:35.255355	2025-07-13 03:17:31.385388	\N	外卖	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/22bfc524f5b83482fbb4a4505e047c9d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2678	take down	/ˌteɪk ˈdaʊn/		\N	5	0	1	2025-07-13 02:32:35.258599	2025-07-13 03:17:32.810018	\N	拿下	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2fe27af2aa38c1ea3f1e815bab12199d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2679	the double nineth festival	/ðə ˈdʌbəl ˈnaɪnθ ˈfɛstəvəl/		\N	5	0	1	2025-07-13 02:32:35.261854	2025-07-13 03:17:34.097262	\N	重阳节	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/4ad82a9bd416a06e22abaa60fbe79f9d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2664	could	/kʊd/		\N	5	0	1	2025-07-13 00:38:58.551153	2025-07-13 03:17:42.890513	\N	可以	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/7c93506d88b40fb734ebe3e1500d2504.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2665	half	/hæf/		\N	5	0	1	2025-07-13 00:38:58.559452	2025-07-13 03:17:44.065288	\N	一半	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/82ad46b368000e5bead21532fbbc2f2f.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2666	neighbour	/ˈneɪbɚ/		\N	5	0	1	2025-07-13 00:38:58.563367	2025-07-13 03:17:45.114648	\N	邻居	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/66b41e4fe259d9a97e8f1bbf6560a416.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2667	drank	/dræŋk/		\N	5	0	1	2025-07-13 00:38:58.568026	2025-07-13 03:17:46.31945	\N	喝了	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a500da9087712793cc8b61675ab826c2.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2669	bench	/bɛntʃ/		\N	5	0	1	2025-07-13 00:38:58.591377	2025-07-13 03:17:47.407193	\N	长椅	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/65368871de8b5a96779c6906ddb1d77d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2670	made	/meɪd/		\N	5	0	1	2025-07-13 00:38:58.598633	2025-07-13 03:17:48.98015	\N	做的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/8c04173f118e8382ffddfe5efb3ed1e8.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2671	librarian	/laɪˈbrɛriən/		\N	5	0	1	2025-07-13 00:38:58.619828	2025-07-13 03:17:50.774485	\N	图书管理员	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/5fc3714216c8f42dfabe4ea8d607b860.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2672	men	/mɛn/		\N	5	0	1	2025-07-13 00:38:58.630226	2025-07-13 03:17:51.777908	\N	男人们	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/1217d2ed8eecd374e18f60eb61bbab8b.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
145	borrow	/ˈbɑroʊ/	\N	noun	5	0	3	2025-07-06 15:11:44.390997	2025-07-13 03:17:53.056717	\N	借	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2497f5a9656d513da34e58074e7a2140.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
153	break	/breɪk/	\N	noun	5	0	2	2025-07-06 15:11:44.407715	2025-07-13 03:17:54.01355	\N	休息	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/0e3c2a1301dd3968f361d107c7fec354.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
166	busy	/ˈbɪzi/	\N	noun	5	0	2	2025-07-06 15:11:44.434569	2025-07-13 03:17:55.018448	\N	忙	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/5fe080d558a010b8d47fc005b1d577a4.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
196	celebrate	/ˈsɛləˌbreɪt/	\N	noun	5	0	4	2025-07-06 15:11:44.497622	2025-07-13 03:17:56.156755	\N	庆祝	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/42953e30a7d101ee19083ad3c0c2b7c2.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
214	chicken	/ˈtʃɪkən/	\N	noun	5	0	3	2025-07-06 15:11:44.536438	2025-07-13 03:17:57.255304	\N	鸡	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/33d2754862ce4b133080826e87e66337.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
217	chocolate	/ˈtʃɔklət/	\N	noun	5	0	4	2025-07-06 15:11:44.544689	2025-07-13 03:17:58.300097	\N	巧克力	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2d885fab63334c605833655170bdc01c.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
226	clean	/klin/	\N	noun	5	0	2	2025-07-06 15:11:44.563641	2025-07-13 03:17:59.24943	\N	干净	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6ecce1c99567f1bc8347c91c3ed641eb.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
350	delicious	/dɪˈlɪʃəs/	\N	adjective	5	0	4	2025-07-06 15:11:44.828519	2025-07-13 03:18:00.311191	\N	美味的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a08aac97dd16583aa1d3518fbbf6f762.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
374	different	/ˈdɪfərənt/	\N	noun	5	0	4	2025-07-06 15:11:44.883557	2025-07-13 03:18:01.544811	\N	不同	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b2ab01ec6af97d0abd8a2afbfae76e07.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
390	dish	/dɪʃ/	\N	noun	5	0	2	2025-07-06 15:11:44.919426	2025-07-13 03:18:03.071437	\N	菜	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a22b0ff65d2ebe6408cc44c111361676.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
460	evening	/ˈivnɪŋ/	\N	verb	5	0	3	2025-07-06 15:11:45.074402	2025-07-13 03:18:04.168979	\N	晚上	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/4b34febe28c3b8f130169b1fe624144b.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
498	fan	/fæn/	\N	noun	5	0	1	2025-07-06 15:11:45.151584	2025-07-13 03:18:05.56483	\N	风扇	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/dcfd8f3fa221aa85f7d31ef4665de2fa.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
512	festival	/ˈfɛstəvəl/	\N	noun	5	0	4	2025-07-06 15:11:45.180141	2025-07-13 03:18:07.207722	\N	节日	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/eee099521902d3221380d0393ed0e85e.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
528	fire	/ˈfaɪɚ/	\N	noun	5	0	2	2025-07-06 15:11:45.21836	2025-07-13 03:18:08.410272	\N	火	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/d74072bd33e167054915b458ae40992a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
575	funny	/ˈfʌni/	\N	noun	5	0	2	2025-07-06 15:11:45.323656	2025-07-13 03:18:09.367644	\N	好笑	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/bdbf47ea3def5a1d978298a782d58aa4.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
597	get	/ɡɛt/	\N	noun	5	0	1	2025-07-06 15:11:45.367796	2025-07-13 03:18:11.404815	\N	得到	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/06845025cba8053329c7fa9ac0b89993.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
603	give	/ɡɪv/	\N	adjective	5	0	2	2025-07-06 15:11:45.380109	2025-07-13 03:18:12.564932	\N	给	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/c03ba823c36ab27498efc2e07bbca820.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
692	high	/haɪ/	\N	noun	5	0	2	2025-07-06 15:11:45.572688	2025-07-13 03:18:13.675671	\N	高	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/ff96004e009bb35202c76172bcd02afa.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
701	history	/ˈhɪstəri/	\N	noun	5	0	3	2025-07-06 15:11:45.59061	2025-07-13 03:18:14.930831	\N	历史	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/863dbccec47f4e4d9d45a6c9d9369774.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
713	hope	/hoʊp/	\N	noun	5	0	2	2025-07-06 15:11:45.615921	2025-07-13 03:18:15.992214	\N	希望	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a3410948b9c4586b93cf8b3fec9129fa.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
721	hour	/ˈaʊɚ/	\N	noun	5	0	2	2025-07-06 15:11:45.636058	2025-07-13 03:18:17.044818	\N	小时	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/9ebc387055947baebd3ab7f476119455.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
768	inside	/ɪnˈsaɪd/	\N	noun	5	0	3	2025-07-06 15:11:45.736887	2025-07-13 03:18:18.166348	\N	里面	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/f5ed5e65085ca0df1414c670a74b29e6.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
781	interesting	/ˈɪntrəstɪŋ/	\N	verb	5	0	5	2025-07-06 15:11:45.762802	2025-07-13 03:18:19.487652	\N	有趣的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/171dc382c7799a457c2b87dbcb819495.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
789	invitation	/ˌɪnvəˈteɪʃən/	\N	noun	5	0	4	2025-07-06 15:11:45.778656	2025-07-13 03:18:20.699911	\N	邀请	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/f2f357ebfb149bba7186f673e39f00aa.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
827	kind	/kaɪnd/	\N	noun	5	0	2	2025-07-06 15:11:45.862266	2025-07-13 03:18:22.273334	\N	善良	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2fde6c3018c92a092dbdb603d3ff2d94.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
871	leave	/liv/	\N	noun	5	0	2	2025-07-06 15:11:45.952993	2025-07-13 03:18:23.214841	\N	离开	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/3d5f4fe17733145cd65f49c9f47639c1.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
884	let	/lɛt/	\N	noun	5	0	1	2025-07-06 15:11:45.981184	2025-07-13 03:18:24.140567	\N	让	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a758599900909d91e68f09a050204cc4.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
892	light	/laɪt/	\N	noun	5	0	4	2025-07-06 15:11:45.998437	2025-07-13 03:18:25.505639	\N	光	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a726141328231816afc10818c743f892.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
899	line	/laɪn/	\N	noun	5	0	2	2025-07-06 15:11:46.013266	2025-07-13 03:18:26.564447	\N	线	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/4e432f8f2fddacc918a4cd9f91130ef3.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
980	mask	/mæsk/	\N	noun	5	0	2	2025-07-06 15:11:46.199407	2025-07-13 03:18:27.587298	\N	面具	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/c41eb5c022447b53dcc29e7a06ca837d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1035	miss	/mɪs/	\N	noun	5	0	2	2025-07-06 15:11:46.327584	2025-07-13 03:18:28.607498	\N	想念	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/1e369f8edc3edae75760b7d5c8212438.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1114	night	/naɪt/	\N	noun	5	0	4	2025-07-06 15:11:46.499016	2025-07-13 03:18:29.607546	\N	夜晚	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/90e79fe2ab1a35561c99c94f26d382f7.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1134	nothing	/ˈnʌθɪŋ/	\N	verb	5	0	3	2025-07-06 15:11:46.546717	2025-07-13 03:18:30.655269	\N	没有	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/98dd0e80d0c86a07a965671c0f7866ae.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1163	office	/ˈɔfɪs/	\N	noun	5	0	3	2025-07-06 15:11:46.61101	2025-07-13 03:18:35.67282	\N	办公室	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/ca6a92f0213647fc7bfe09f974a129a0.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1167	often	/ˈɔfən/	\N	noun	5	0	2	2025-07-06 15:11:46.619452	2025-07-13 03:18:36.720458	\N	经常	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/c798344de98280f55f33071cc88efd4a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1177	open	/ˈoʊpən/	\N	noun	5	0	2	2025-07-06 15:11:46.641226	2025-07-13 03:18:37.754279	\N	打开	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/57ac7121a6fd1bd1a102907245f739af.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1249	passport	/ˈpæspɔrt/	\N	noun	5	0	4	2025-07-06 15:11:46.80075	2025-07-13 03:18:38.849768	\N	护照	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2022dad26b6200a1d165739a2ec17589.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1250	past	/pæst/	\N	noun	5	0	2	2025-07-06 15:11:46.803101	2025-07-13 03:18:39.989219	\N	过去	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6d516ad87df48cd15b2eceae73886190.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1308	piece	/pis/	\N	noun	5	0	2	2025-07-06 15:11:46.928489	2025-07-13 03:18:40.967747	\N	块	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/7ae7b0d3508e9ceff841f95f02979dbd.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1326	place	/pleɪs/	\N	noun	5	0	2	2025-07-06 15:11:46.971848	2025-07-13 03:18:42.101607	\N	地方	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6789f67e606627901c7a8fb8478dd841.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1337	player	/ˈpleɪɚ/	\N	adjective	5	0	3	2025-07-06 15:11:46.996709	2025-07-13 03:18:43.182045	\N	玩家	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/47af55b67f6f687c474bb9e8b0ab264a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1338	playground	/ˈpleɪˌɡraʊnd/	\N	noun	5	0	5	2025-07-06 15:11:46.998808	2025-07-13 03:18:44.483516	\N	操场	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/feca40235217e8d0663252c2802f4ac5.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1350	point	/pɔɪnt/	\N	noun	5	0	2	2025-07-06 15:11:47.025262	2025-07-13 03:18:45.506808	\N	点	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a3d018e66bcf601bdde811b19becfeca.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1384	pound	/paʊnd/	\N	noun	5	0	2	2025-07-06 15:11:47.09993	2025-07-13 03:18:46.410023	\N	磅	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/55da8bc4fe73715e50e3a44d53f0f01a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1482	put	/pʊt/	\N	noun	5	0	1	2025-07-06 15:11:47.32298	2025-07-13 03:18:48.105084	\N	放	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/df92e42cba0da6b6857f57e6a03e7844.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1489	quarter	/ˈkwɔrtɚ/	\N	adjective	5	0	3	2025-07-06 15:11:47.338008	2025-07-13 03:18:49.633533	\N	四分之一	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/1d0d6079e18c9c219d43b373a64ee0ab.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1528	read	/rid/	\N	noun	5	0	2	2025-07-06 15:11:47.425652	2025-07-13 03:18:50.720616	\N	读	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/085cd6fc180d4a6f94b5f5a3b838eb77.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1599	reply	/rɪˈplaɪ/	\N	adverb	5	0	2	2025-07-06 15:11:47.575487	2025-07-13 03:18:51.847461	\N	回复	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/fb6ed3c97e6fe8e50406e0e75189ae8e.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1690	rule	/rul/	\N	noun	5	0	2	2025-07-06 15:11:47.777044	2025-07-13 03:18:52.982851	\N	规则	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/99cfebf946e03143d6a9e8dc6cd3444f.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1723	sausage	/ˈsɔsɪdʒ/	\N	noun	5	0	3	2025-07-06 15:11:47.85243	2025-07-13 03:18:54.044372	\N	香肠	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a65d91258ee66df956929c73ed2027e8.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1744	scissors	/ˈsɪzɚz/	\N	noun	5	0	4	2025-07-06 15:11:47.901629	2025-07-13 03:18:58.653885	\N	剪刀	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/1467af918de954a0320bc4506856b750.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1759	season	/ˈsizən/	\N	noun	5	0	3	2025-07-06 15:11:47.932672	2025-07-13 03:19:00.120532	\N	季节	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/3b706de9639b5f09ab3b6d12eb088899.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1777	sell	/sɛl/	\N	noun	5	0	2	2025-07-06 15:11:47.971877	2025-07-13 03:19:01.39999	\N	卖	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/c45e2a4114932ceca64a48878933f5f4.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1800	seventy	/ˈsɛvənti/	\N	noun	5	0	3	2025-07-06 15:11:48.022457	2025-07-13 03:19:02.676064	\N	七十	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/231134c7270d875310d32d8b04d34c8b.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1834	short	/ʃɔrt/	\N	noun	5	0	2	2025-07-06 15:11:48.098441	2025-07-13 03:19:03.914562	\N	短	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/277c07c352660a9d636c823d5478c646.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1838	should	/ʃʊd/	\N	noun	5	0	3	2025-07-06 15:11:48.107281	2025-07-13 03:19:05.01004	\N	应该	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/e3d3f4bfde40e1f83218fdcc2eb65710.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1839	shoulder	/ˈʃoʊldɚ/	\N	adjective	5	0	4	2025-07-06 15:11:48.109394	2025-07-13 03:19:06.149282	\N	肩膀	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b8ae01f35c443f096f67cdc0cb6c5baa.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1881	sixty	/ˈsɪksti/	\N	noun	5	0	2	2025-07-06 15:11:48.202911	2025-07-13 03:19:07.175098	\N	六十	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/17ade74927b2e0d23238ea0d66d00437.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1913	snow	/snoʊ/	\N	noun	5	0	2	2025-07-06 15:11:48.276109	2025-07-13 03:19:08.292078	\N	雪	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6ceb4ef17d5d7d73966600a57e860680.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1914	so	/soʊ/	\N	conjunction	5	0	1	2025-07-06 15:11:48.278225	2025-07-13 03:19:09.287955	\N	所以	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/29afbadbeede15321afeeea0bc07d7ba.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1937	sometimes	/ˈsʌmˌtaɪmz/	\N	noun	5	0	4	2025-07-06 15:11:48.33486	2025-07-13 03:19:10.312877	\N	有时	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/ea1a8b540f101acefca15661587d3f89.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1957	speak	/spik/	\N	noun	5	0	2	2025-07-06 15:11:48.380463	2025-07-13 03:19:11.370374	\N	说	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/e8681cf0de42652268f4e8c91238694b.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1968	spend	/spɛnd/	\N	noun	5	0	2	2025-07-06 15:11:48.405105	2025-07-13 03:19:12.544634	\N	花费	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2cc1a342ee45610b6de97ee28c2b7735.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2007	start	/stɑrt/	\N	noun	5	0	2	2025-07-06 15:11:48.494219	2025-07-13 03:19:13.666465	\N	开始	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/feef31e508fa161bc83f5d8a696257a7.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2026	stick	/stɪk/	\N	noun	5	0	2	2025-07-06 15:11:48.549105	2025-07-13 03:19:14.997347	\N	棍子	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b23b8f846c8bad03696926acc2ddce50.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2060	string	/strɪŋ/	\N	verb	5	0	3	2025-07-06 15:11:48.621962	2025-07-13 03:19:16.046562	\N	字符串	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/3f33e12ee66bcd1332387d34ef4cb96e.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2069	study	/ˈstʌdi/	\N	noun	5	0	2	2025-07-06 15:11:48.641559	2025-07-13 03:19:17.250864	\N	学习	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b7c278fcdc010c52de473dd497f13d61.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2073	subject	/ˈsʌbdʒɛkt/	\N	noun	5	0	3	2025-07-06 15:11:48.649705	2025-07-13 03:19:18.566992	\N	主题	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/0ea524bd797be973017ed31d52b2fc8a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2201	theatre	/ˈθiətɚ/	\N	noun	5	0	3	2025-07-06 15:11:48.923824	2025-07-13 03:19:19.585264	\N	剧院	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6ee1daa6833be20e7d578bc7d641929d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2206	then	/ðɛn/	\N	noun	5	0	2	2025-07-06 15:11:48.936113	2025-07-13 03:19:20.730948	\N	然后	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/d2123342668fa0a61ea937d6575b126f.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2218	think	/θɪŋk/	\N	noun	5	0	2	2025-07-06 15:11:48.966262	2025-07-13 03:19:21.856971	\N	想	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/93fdd33a8300855ed0b6e5c484b2459e.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2228	thousand	/ˈθaʊzənd/	\N	noun	5	0	4	2025-07-06 15:11:48.988799	2025-07-13 03:19:22.969771	\N	千	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/3dac2ea0d299450c3c53d43d0feda308.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2239	ticket	/ˈtɪkɪt/	\N	noun	5	0	3	2025-07-06 15:11:49.011952	2025-07-13 03:19:24.184602	\N	票	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6f6abc1894c613527fffaadab272cdb5.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2294	traditional	/trəˈdɪʃənəl/	\N	noun	5	0	4	2025-07-06 15:11:49.146574	2025-07-13 03:19:25.644653	\N	传统的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/3d6ed74df64262e677b3ee1ddc9f908a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2333	true	/tru/	\N	noun	5	0	2	2025-07-06 15:11:49.232593	2025-07-13 03:19:26.88904	\N	真的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/e82eea1534cc43fa4f24b0c5a17d4706.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2400	useful	/ˈjusfəl/	\N	adjective	5	0	3	2025-07-06 15:11:49.377902	2025-07-13 03:19:28.43799	\N	有用的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/63aa34416592d6bc814cd8d88dcde6b3.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2485	wall	/wɔl/	\N	noun	5	0	2	2025-07-06 15:11:49.571753	2025-07-13 03:19:29.5882	\N	墙	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/61c32c575209bd3fe1946b43ae9686d7.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2527	well	/wɛl/	\N	noun	5	0	2	2025-07-06 15:11:49.663672	2025-07-13 03:19:30.990319	\N	井	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/65b817fc7ff3111ce60ab3665a8c683b.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2530	wet	/wɛt/	\N	noun	5	0	1	2025-07-06 15:11:49.6702	2025-07-13 03:19:32.099621	\N	湿	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/f7f792a21b3c47146bf6d3962464c262.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2551	whose	/huz/	\N	noun	5	0	2	2025-07-06 15:11:49.715255	2025-07-13 03:19:33.38215	\N	谁的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b123374cd7f31ebc6d12dd03c161e5af.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2630	women	/ˈwɪmɪn/		\N	5	0	1	2025-07-13 00:38:57.921814	2025-07-13 03:19:34.657642	\N	女性	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/afcf25f07dd01c756239d7d57b92f112.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2631	hers	/hɝz/		\N	5	0	1	2025-07-13 00:38:57.964327	2025-07-13 03:19:35.861853	\N	她的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b32478b10b10cb48c1ee08c87452722d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2632	sent	/sɛnt/		\N	5	0	1	2025-07-13 00:38:57.977024	2025-07-13 03:19:36.880444	\N	发送	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/e099caa01ae8eaeb19598433ba3e0609.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2633	sales	/seɪlz/		\N	5	0	1	2025-07-13 00:38:58.019821	2025-07-13 03:19:38.038309	\N	销售	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/0650c5962b70fe236100a1c8eb293d9f.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2634	drew	/dru/		\N	5	0	1	2025-07-13 00:38:58.027903	2025-07-13 03:19:39.405093	\N	画了	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/da414385c0919f0c1fdd25700ae07e40.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2636	presenter	/prɪˈzɛntɚ/		\N	5	0	1	2025-07-13 00:38:58.052317	2025-07-13 03:19:41.547483	\N	主持人	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/8331f298fe661643626b8afcfede33c9.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2637	yours	/jʊrz/		\N	5	0	1	2025-07-13 00:38:58.05604	2025-07-13 03:19:42.608351	\N	你的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/874d130a05d96c7bd588a959cefb231d.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2638	stories	/ˈstɔriz/		\N	5	0	1	2025-07-13 00:38:58.089678	2025-07-13 03:19:43.821572	\N	故事	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/587b4b060cc26e9841a7316695ccb52c.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2639	met	/mɛt/		\N	5	0	1	2025-07-13 00:38:58.130961	2025-07-13 03:19:44.817451	\N	遇见	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/40b39872a72c483811fef92d50fa9ac3.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2640	firefighter	/ˈfaɪɚˌfaɪtɚ/		\N	5	0	1	2025-07-13 00:38:58.170518	2025-07-13 03:19:46.248575	\N	消防员	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/cdf9cd7108a51973ca13e37adbed85dd.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2641	over	/ˈoʊvɚ/		\N	5	0	1	2025-07-13 00:38:58.176232	2025-07-13 03:19:47.484308	\N	结束	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/a32a0759529505e4399110532a458040.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2642	tied	/taɪd/		\N	5	0	1	2025-07-13 00:38:58.187159	2025-07-13 03:19:48.501361	\N	领带	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/ea8b7d4b79d39738ba66001f415fb090.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2643	got	/ɡɑt/		\N	5	0	1	2025-07-13 00:38:58.243971	2025-07-13 03:19:49.634595	\N	得到	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/52402bf8b39c4ef298db418e95bce556.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2644	around	/əˈraʊnd/		\N	5	0	1	2025-07-13 00:38:58.250475	2025-07-13 03:19:50.748574	\N	周围	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/6c8134a03b2f5e0513253692beb89744.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2645	both	/boʊθ/		\N	5	0	1	2025-07-13 00:38:58.275514	2025-07-13 03:19:51.872262	\N	两者都	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/f71349c436b39a039072f601e2233bac.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2647	outdoor	/ˈaʊtˌdɔr/		\N	5	0	1	2025-07-13 00:38:58.299393	2025-07-13 03:19:52.980016	\N	户外	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/e6e5b876cd0239032b16100c9c34bc60.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2648	classmate	/ˈklæsˌmeɪt/		\N	5	0	1	2025-07-13 00:38:58.316939	2025-07-13 03:19:54.004203	\N	同学	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/48a7abb24bb397cea125e92d798ffab8.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2649	drove	/droʊv/		\N	5	0	1	2025-07-13 00:38:58.320918	2025-07-13 03:19:55.345366	\N	驾驶	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/b12925492d58c7bf0ee1f75d9eca26e2.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2651	helicopter	/ˈhɛlɪˌkɑptɚ/		\N	5	0	1	2025-07-13 00:38:58.352598	2025-07-13 03:19:56.881773	\N	直升机	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/c0657d2785a7d7cdaba7fc1c80f39b11.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2652	painted	/ˈpeɪntɪd/		\N	5	0	1	2025-07-13 00:38:58.356554	2025-07-13 03:19:57.974196	\N	涂漆的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/fdd930c904625ac7679cae3da71297f8.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2653	circle	/ˈsɝkəl/		\N	5	0	1	2025-07-13 00:38:58.37971	2025-07-13 03:19:59.043604	\N	圆圈	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/5f549ec73d04619b668563e3f1253c12.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2654	scary	/ˈskɛri/		\N	5	0	1	2025-07-13 00:38:58.396309	2025-07-13 03:20:00.243793	\N	可怕的	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/03807eca0f5090aea6e9f5497a203c46.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2655	chinese	/ˌtʃaɪˈniz/		\N	5	0	1	2025-07-13 00:38:58.412497	2025-07-13 03:20:01.736652	\N	中文	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/ec8e4a09854fb5c53bae48260911897f.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2656	heavy	/ˈhɛvi/		\N	5	0	1	2025-07-13 00:38:58.426537	2025-07-13 03:20:02.864824	\N	重	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/d78861fcabf70ae7293e35fb0f2a3864.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2658	told	/toʊld/		\N	5	0	1	2025-07-13 00:38:58.467726	2025-07-13 03:20:04.175072	\N	告诉	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/f059e4acdf39dd8ee15721ac9806af3a.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2659	halloween	/ˌhæləˈwin/		\N	5	0	1	2025-07-13 00:38:58.480206	2025-07-13 03:20:05.342797	\N	万圣节	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/c03dbb2581bbec5d8cee1da868bec492.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2660	november	/noʊˈvɛmbɚ/		\N	5	0	1	2025-07-13 00:38:58.490652	2025-07-13 03:20:07.089309	\N	十一月	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/cca795e40f2d722fd9a65b7a884ffdef.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2661	july	/dʒuˈlaɪ/		\N	5	0	1	2025-07-13 00:38:58.530835	2025-07-13 03:20:08.276691	\N	七月	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/371842d65ee4ce5a25b01c8ed28116b3.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2662	october	/ɑkˈtoʊbɚ/		\N	5	0	1	2025-07-13 00:38:58.540689	2025-07-13 03:20:09.560046	\N	十月	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/5817852b4e5c81267cba736eb318076e.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	imported_with_audio	t	f	3
2686	food	/fuːd/	人和动物吃的东西	noun	1	647	1	2025-07-13 09:49:20.442094	2025-07-13 09:49:20.442096	\N	人和动物吃的东西	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	\N
2687	development	/dɪˈveləpmənt/	发展，开发	noun	6	2512	6	2025-07-13 09:49:20.45354	2025-07-13 09:49:20.453543	\N	发展，开发	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	\N
2688	creativity	/ˌkriːeɪˈtɪvəti/	创造力，创新能力	noun	8	8284	8	2025-07-13 09:49:20.458817	2025-07-13 09:49:20.458819	\N	创造力，创新能力	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	\N
2689	determination	/dɪˌtɜːrmɪˈneɪʃn/	决心，坚定	noun	8	951	8	2025-07-13 09:49:20.461215	2025-07-13 09:49:20.461217	\N	决心，坚定	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	\N
2690	sustainability	/səˌsteɪnəˈbɪləti/	可持续性，持续发展	noun	9	5355	9	2025-07-13 09:49:20.463687	2025-07-13 09:49:20.463688	\N	可持续性，持续发展	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	\N
2691	philosophical	/ˌfɪləˈsɑːfɪkl/	哲学的，哲理的	noun	9	259	9	2025-07-13 09:49:20.467044	2025-07-13 09:49:20.467046	\N	哲学的，哲理的	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	\N
2692	extraordinary	/ɪkˈstrɔːrdneri/	非凡的，特别的	noun	9	8339	9	2025-07-13 09:49:20.468961	2025-07-13 09:49:20.468963	\N	非凡的，特别的	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	\N
8	apple	/ˈæpl/	A round fruit with red or green skin and white flesh	noun	1	800	1	2025-07-06 07:44:43.844458	2025-07-10 07:53:04.19426	AP-ul	苹果	easy	\N	\N	I like to eat apples.	我喜欢吃苹果。	\N	\N	\N	\N	\N	\N	\N	system	t	t	\N
1	cat	/kæt/	A small animal with fur, four legs, and a tail that is kept as a pet	noun	1	1000	1	2025-07-06 07:44:43.844448	2025-07-10 07:53:04.199817	KAT	猫	easy	\N	\N	The cat is sleeping.	猫在睡觉。	\N	\N	\N	\N	\N	\N	\N	system	t	t	\N
5	red	/red/	Having the color of blood or fire	adjective	1	2000	1	2025-07-06 07:44:43.844455	2025-07-10 07:53:04.201665	RED	红色的	easy	\N	\N	The apple is red.	苹果是红色的。	\N	\N	\N	\N	\N	\N	\N	system	t	t	\N
10	sandwich	/ˈsænwɪtʃ/	Food made with two pieces of bread	noun	5	400	2	2025-07-06 07:44:43.844462	2025-07-13 03:14:33.011578	\N	三明治	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/2493366f697ba7e8375eb794023f74a7.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
25	activity	/ækˈtɪvəti/	\N	noun	5	0	4	2025-07-06 15:11:44.125203	2025-07-13 03:20:11.2162	\N	活动	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/34eb3c772dc0d4b012252a3b08d3abba.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2	dog	/dɔːɡ/	A domesticated carnivorous mammal	noun	1	1200	1	2025-07-06 07:44:43.844452	2025-07-06 07:44:43.844453	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
3	elephant	/ˈeləfənt/	A very large mammal with a trunk	noun	2	500	2	2025-07-06 07:44:43.844453	2025-07-06 07:44:43.844454	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
4	butterfly	/ˈbʌtərflaɪ/	A flying insect with colorful wings	noun	3	300	3	2025-07-06 07:44:43.844454	2025-07-06 07:44:43.844455	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
6	blue	/bluː/	The color of the sky	adjective	1	1800	1	2025-07-06 07:44:43.844456	2025-07-06 07:44:43.844456	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
7	green	/ɡriːn/	The color of grass	adjective	1	1500	1	2025-07-06 07:44:43.844457	2025-07-06 07:44:43.844457	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
9	banana	/bəˈnænə/	A long yellow fruit	noun	2	600	2	2025-07-06 07:44:43.844461	2025-07-06 07:44:43.844462	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
11	mother	/ˈmʌðər/	A female parent	noun	1	3000	1	2025-07-06 07:44:43.844463	2025-07-06 07:44:43.844464	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
12	father	/ˈfɑːðər/	A male parent	noun	1	2800	1	2025-07-06 07:44:43.844464	2025-07-06 07:44:43.844465	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
13	sister	/ˈsɪstər/	A female sibling	noun	2	1000	1	2025-07-06 07:44:43.844465	2025-07-06 07:44:43.844465	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
14	brother	/ˈbrʌðər/	A male sibling	noun	2	1100	1	2025-07-06 07:44:43.844466	2025-07-06 07:44:43.844466	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
15	grandmother	/ˈɡrænmʌðər/	Mother of one's parent	noun	3	500	3	2025-07-06 07:44:43.844467	2025-07-06 07:44:43.844467	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
16	a	\N	\N	noun	1	0	1	2025-07-06 15:11:44.100504	2025-07-06 15:11:44.100506	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
17	ability	\N	\N	noun	4	0	3	2025-07-06 15:11:44.104925	2025-07-06 15:11:44.104928	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
18	abroad	\N	\N	noun	3	0	3	2025-07-06 15:11:44.108032	2025-07-06 15:11:44.108033	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
19	absence	\N	\N	noun	4	0	3	2025-07-06 15:11:44.111125	2025-07-06 15:11:44.111127	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
20	access	\N	\N	noun	3	0	3	2025-07-06 15:11:44.113388	2025-07-06 15:11:44.11339	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
21	accident	\N	\N	noun	4	0	4	2025-07-06 15:11:44.115989	2025-07-06 15:11:44.115991	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
22	achievement	\N	\N	noun	6	0	5	2025-07-06 15:11:44.118341	2025-07-06 15:11:44.118343	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
23	act	\N	\N	noun	1	0	1	2025-07-06 15:11:44.121194	2025-07-06 15:11:44.121196	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
24	active	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.123244	2025-07-06 15:11:44.123246	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
26	admire	\N	\N	noun	3	0	3	2025-07-06 15:11:44.127154	2025-07-06 15:11:44.127156	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
27	advantage	\N	\N	noun	5	0	4	2025-07-06 15:11:44.129132	2025-07-06 15:11:44.129134	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
28	adventure	\N	\N	noun	5	0	4	2025-07-06 15:11:44.131787	2025-07-06 15:11:44.131789	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
29	advertisement	\N	\N	noun	6	0	5	2025-07-06 15:11:44.133878	2025-07-06 15:11:44.13388	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
30	advice	\N	\N	noun	3	0	3	2025-07-06 15:11:44.135818	2025-07-06 15:11:44.13582	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
31	afraid	\N	\N	noun	3	0	3	2025-07-06 15:11:44.137694	2025-07-06 15:11:44.137695	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
32	afternoon	\N	\N	noun	5	0	4	2025-07-06 15:11:44.139784	2025-07-06 15:11:44.139786	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
33	age	\N	\N	noun	1	0	1	2025-07-06 15:11:44.141932	2025-07-06 15:11:44.141934	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
34	agree	\N	\N	noun	3	0	2	2025-07-06 15:11:44.144011	2025-07-06 15:11:44.144013	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
35	agreement	\N	\N	noun	5	0	4	2025-07-06 15:11:44.146141	2025-07-06 15:11:44.146143	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
36	aim	\N	\N	noun	1	0	1	2025-07-06 15:11:44.148199	2025-07-06 15:11:44.148201	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
37	air	\N	\N	noun	1	0	1	2025-07-06 15:11:44.150815	2025-07-06 15:11:44.150817	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
38	airport	\N	\N	noun	4	0	3	2025-07-06 15:11:44.153507	2025-07-06 15:11:44.153509	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
39	alike	\N	\N	noun	3	0	2	2025-07-06 15:11:44.156129	2025-07-06 15:11:44.156131	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
40	alive	\N	\N	adjective	3	0	2	2025-07-06 15:11:44.158298	2025-07-06 15:11:44.1583	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
41	allow	\N	\N	noun	3	0	2	2025-07-06 15:11:44.160277	2025-07-06 15:11:44.160279	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
42	almost	\N	\N	noun	3	0	3	2025-07-06 15:11:44.162301	2025-07-06 15:11:44.162303	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
43	alone	\N	\N	noun	3	0	2	2025-07-06 15:11:44.164392	2025-07-06 15:11:44.164394	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
44	already	\N	\N	noun	4	0	3	2025-07-06 15:11:44.166644	2025-07-06 15:11:44.166646	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
45	always	\N	\N	noun	3	0	3	2025-07-06 15:11:44.168663	2025-07-06 15:11:44.168665	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
46	am	\N	\N	noun	1	0	1	2025-07-06 15:11:44.170826	2025-07-06 15:11:44.170828	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
47	amazing	\N	\N	verb	4	0	3	2025-07-06 15:11:44.172844	2025-07-06 15:11:44.172846	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
48	amount	\N	\N	noun	3	0	3	2025-07-06 15:11:44.174869	2025-07-06 15:11:44.174871	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
49	an	\N	\N	noun	1	0	1	2025-07-06 15:11:44.17707	2025-07-06 15:11:44.177072	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
50	analysis	\N	\N	noun	4	0	4	2025-07-06 15:11:44.179327	2025-07-06 15:11:44.179329	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
52	angrily	\N	\N	adverb	4	0	3	2025-07-06 15:11:44.184056	2025-07-06 15:11:44.184074	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
53	angry	\N	\N	noun	3	0	2	2025-07-06 15:11:44.186221	2025-07-06 15:11:44.186223	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
54	anniversary	\N	\N	noun	6	0	5	2025-07-06 15:11:44.188611	2025-07-06 15:11:44.188631	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
55	announce	\N	\N	noun	4	0	4	2025-07-06 15:11:44.191224	2025-07-06 15:11:44.191226	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
56	answer	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.193191	2025-07-06 15:11:44.193193	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
57	ant	\N	\N	noun	1	0	1	2025-07-06 15:11:44.195108	2025-07-06 15:11:44.19511	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
58	anxiety	\N	\N	noun	4	0	3	2025-07-06 15:11:44.197142	2025-07-06 15:11:44.197144	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
59	anxious	\N	\N	adjective	4	0	3	2025-07-06 15:11:44.199297	2025-07-06 15:11:44.199299	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
60	anywhere	\N	\N	noun	4	0	4	2025-07-06 15:11:44.201386	2025-07-06 15:11:44.201388	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
61	apart	\N	\N	noun	3	0	2	2025-07-06 15:11:44.203394	2025-07-06 15:11:44.203396	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
62	apartment	\N	\N	noun	5	0	4	2025-07-06 15:11:44.205378	2025-07-06 15:11:44.20538	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
63	apology	\N	\N	noun	4	0	3	2025-07-06 15:11:44.207736	2025-07-06 15:11:44.207737	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
64	appeal	\N	\N	noun	3	0	3	2025-07-06 15:11:44.209877	2025-07-06 15:11:44.209878	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
65	appear	\N	\N	noun	3	0	3	2025-07-06 15:11:44.211924	2025-07-06 15:11:44.211926	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
66	appearance	\N	\N	noun	5	0	5	2025-07-06 15:11:44.214328	2025-07-06 15:11:44.21433	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
67	appreciation	\N	\N	noun	6	0	4	2025-07-06 15:11:44.21728	2025-07-06 15:11:44.217282	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
68	approach	\N	\N	noun	4	0	4	2025-07-06 15:11:44.219322	2025-07-06 15:11:44.219324	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
69	approximately	\N	\N	adverb	6	0	5	2025-07-06 15:11:44.22155	2025-07-06 15:11:44.221552	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
70	are	\N	\N	noun	1	0	1	2025-07-06 15:11:44.223557	2025-07-06 15:11:44.223559	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
71	argument	\N	\N	noun	4	0	4	2025-07-06 15:11:44.225659	2025-07-06 15:11:44.225661	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
72	arm	\N	\N	noun	1	0	1	2025-07-06 15:11:44.227909	2025-07-06 15:11:44.227911	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
73	arrange	\N	\N	noun	4	0	3	2025-07-06 15:11:44.230137	2025-07-06 15:11:44.230139	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
74	arrangement	\N	\N	noun	6	0	5	2025-07-06 15:11:44.232324	2025-07-06 15:11:44.232326	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
75	arrive	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.234501	2025-07-06 15:11:44.234503	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
76	art	\N	\N	noun	1	0	1	2025-07-06 15:11:44.23654	2025-07-06 15:11:44.236543	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
77	article	\N	\N	noun	4	0	3	2025-07-06 15:11:44.238838	2025-07-06 15:11:44.238841	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
78	ashamed	\N	\N	verb	4	0	3	2025-07-06 15:11:44.24103	2025-07-06 15:11:44.241047	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
79	ask	\N	\N	noun	1	0	1	2025-07-06 15:11:44.24324	2025-07-06 15:11:44.243242	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
80	athletic	\N	\N	noun	4	0	4	2025-07-06 15:11:44.245399	2025-07-06 15:11:44.245401	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
81	atmosphere	\N	\N	noun	5	0	5	2025-07-06 15:11:44.247641	2025-07-06 15:11:44.247643	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
82	attack	\N	\N	noun	3	0	3	2025-07-06 15:11:44.249892	2025-07-06 15:11:44.249894	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
83	attempt	\N	\N	noun	4	0	3	2025-07-06 15:11:44.25208	2025-07-06 15:11:44.252082	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
84	attention	\N	\N	noun	5	0	4	2025-07-06 15:11:44.254618	2025-07-06 15:11:44.25462	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
85	attitude	\N	\N	noun	4	0	4	2025-07-06 15:11:44.256696	2025-07-06 15:11:44.256698	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
86	attractive	\N	\N	adjective	5	0	5	2025-07-06 15:11:44.258664	2025-07-06 15:11:44.258666	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
87	audience	\N	\N	noun	4	0	4	2025-07-06 15:11:44.260725	2025-07-06 15:11:44.260742	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
88	aunt	\N	\N	noun	2	0	2	2025-07-06 15:11:44.262983	2025-07-06 15:11:44.262985	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
89	available	\N	\N	adjective	5	0	4	2025-07-06 15:11:44.265228	2025-07-06 15:11:44.26523	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
90	average	\N	\N	noun	4	0	3	2025-07-06 15:11:44.267318	2025-07-06 15:11:44.26732	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
91	awake	\N	\N	noun	3	0	2	2025-07-06 15:11:44.269323	2025-07-06 15:11:44.269325	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
92	aware	\N	\N	noun	3	0	2	2025-07-06 15:11:44.272497	2025-07-06 15:11:44.272501	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
94	baby	\N	\N	noun	2	0	2	2025-07-06 15:11:44.276859	2025-07-06 15:11:44.276861	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
96	background	\N	\N	noun	5	0	5	2025-07-06 15:11:44.280691	2025-07-06 15:11:44.280693	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
97	bad	\N	\N	noun	1	0	1	2025-07-06 15:11:44.282679	2025-07-06 15:11:44.282682	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
98	badly	\N	\N	adverb	3	0	2	2025-07-06 15:11:44.284738	2025-07-06 15:11:44.28474	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
99	bag	\N	\N	noun	1	0	1	2025-07-06 15:11:44.286807	2025-07-06 15:11:44.286808	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
100	balance	\N	\N	noun	4	0	3	2025-07-06 15:11:44.288868	2025-07-06 15:11:44.28887	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
101	balcony	\N	\N	noun	4	0	3	2025-07-06 15:11:44.290885	2025-07-06 15:11:44.290887	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
102	ball	\N	\N	noun	2	0	2	2025-07-06 15:11:44.292981	2025-07-06 15:11:44.292983	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
103	bank	\N	\N	noun	2	0	2	2025-07-06 15:11:44.295463	2025-07-06 15:11:44.295465	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
104	basement	\N	\N	noun	4	0	4	2025-07-06 15:11:44.297536	2025-07-06 15:11:44.297538	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
105	basic	\N	\N	noun	3	0	2	2025-07-06 15:11:44.29965	2025-07-06 15:11:44.299652	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
106	bathroom	\N	\N	noun	4	0	4	2025-07-06 15:11:44.301593	2025-07-06 15:11:44.301595	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
107	beach	\N	\N	noun	3	0	2	2025-07-06 15:11:44.303894	2025-07-06 15:11:44.303896	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
108	bear	\N	\N	noun	2	0	2	2025-07-06 15:11:44.30604	2025-07-06 15:11:44.306042	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
109	beautiful	\N	\N	adjective	5	0	4	2025-07-06 15:11:44.308067	2025-07-06 15:11:44.308069	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
111	bedroom	\N	\N	noun	4	0	3	2025-07-06 15:11:44.312219	2025-07-06 15:11:44.312221	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
112	bee	\N	\N	noun	1	0	1	2025-07-06 15:11:44.314533	2025-07-06 15:11:44.314535	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
113	beef	\N	\N	noun	2	0	2	2025-07-06 15:11:44.316987	2025-07-06 15:11:44.316989	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
114	begin	\N	\N	noun	3	0	2	2025-07-06 15:11:44.319015	2025-07-06 15:11:44.319017	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
115	beginning	\N	\N	verb	5	0	4	2025-07-06 15:11:44.320832	2025-07-06 15:11:44.320834	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
116	behind	\N	\N	noun	3	0	3	2025-07-06 15:11:44.326664	2025-07-06 15:11:44.326666	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
117	belief	\N	\N	noun	3	0	3	2025-07-06 15:11:44.329458	2025-07-06 15:11:44.32946	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
118	believe	\N	\N	noun	4	0	3	2025-07-06 15:11:44.331649	2025-07-06 15:11:44.331651	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
119	belong	\N	\N	noun	3	0	3	2025-07-06 15:11:44.334281	2025-07-06 15:11:44.334283	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
120	belt	\N	\N	noun	2	0	2	2025-07-06 15:11:44.33659	2025-07-06 15:11:44.336592	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
121	benefit	\N	\N	noun	4	0	3	2025-07-06 15:11:44.339169	2025-07-06 15:11:44.339171	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
122	beside	\N	\N	noun	3	0	3	2025-07-06 15:11:44.34117	2025-07-06 15:11:44.341172	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
123	big	\N	\N	noun	1	0	1	2025-07-06 15:11:44.343362	2025-07-06 15:11:44.343364	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
124	bike	\N	\N	noun	2	0	2	2025-07-06 15:11:44.345337	2025-07-06 15:11:44.345339	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
125	bird	\N	\N	noun	2	0	2	2025-07-06 15:11:44.347257	2025-07-06 15:11:44.347258	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
126	birthday	\N	\N	noun	4	0	4	2025-07-06 15:11:44.349211	2025-07-06 15:11:44.349213	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
127	birthplace	\N	\N	noun	5	0	5	2025-07-06 15:11:44.351113	2025-07-06 15:11:44.351115	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
128	biscuit	\N	\N	noun	4	0	3	2025-07-06 15:11:44.353657	2025-07-06 15:11:44.353675	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
129	bitter	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.355549	2025-07-06 15:11:44.355551	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
130	black	\N	\N	noun	3	0	2	2025-07-06 15:11:44.358066	2025-07-06 15:11:44.358068	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
131	blackboard	\N	\N	noun	5	0	5	2025-07-06 15:11:44.360622	2025-07-06 15:11:44.360625	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
132	blank	\N	\N	noun	3	0	2	2025-07-06 15:11:44.363142	2025-07-06 15:11:44.363145	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
133	blanket	\N	\N	noun	4	0	3	2025-07-06 15:11:44.36545	2025-07-06 15:11:44.365452	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
134	blessing	\N	\N	verb	4	0	4	2025-07-06 15:11:44.368005	2025-07-06 15:11:44.368007	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
136	blood	\N	\N	noun	3	0	2	2025-07-06 15:11:44.372402	2025-07-06 15:11:44.372404	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
137	boat	\N	\N	noun	2	0	2	2025-07-06 15:11:44.375148	2025-07-06 15:11:44.37515	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
138	bold	\N	\N	noun	2	0	2	2025-07-06 15:11:44.377222	2025-07-06 15:11:44.377224	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
139	bomb	\N	\N	noun	2	0	2	2025-07-06 15:11:44.379174	2025-07-06 15:11:44.379176	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
141	boot	\N	\N	noun	2	0	2	2025-07-06 15:11:44.383172	2025-07-06 15:11:44.383174	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
142	border	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.385083	2025-07-06 15:11:44.385085	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
143	bored	\N	\N	verb	3	0	2	2025-07-06 15:11:44.387173	2025-07-06 15:11:44.387175	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
144	boring	\N	\N	verb	3	0	3	2025-07-06 15:11:44.389074	2025-07-06 15:11:44.389076	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
146	bottom	\N	\N	noun	3	0	3	2025-07-06 15:11:44.392834	2025-07-06 15:11:44.392836	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
147	boy	\N	\N	noun	1	0	1	2025-07-06 15:11:44.394763	2025-07-06 15:11:44.394765	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
148	brain	\N	\N	noun	3	0	2	2025-07-06 15:11:44.397093	2025-07-06 15:11:44.397095	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
149	brand	\N	\N	noun	3	0	2	2025-07-06 15:11:44.399537	2025-07-06 15:11:44.39954	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
150	brave	\N	\N	noun	3	0	2	2025-07-06 15:11:44.401766	2025-07-06 15:11:44.401768	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
151	bravely	\N	\N	adverb	4	0	3	2025-07-06 15:11:44.403612	2025-07-06 15:11:44.403614	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
152	bread	\N	\N	noun	3	0	2	2025-07-06 15:11:44.405655	2025-07-06 15:11:44.405657	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
154	breath	\N	\N	noun	3	0	3	2025-07-06 15:11:44.409651	2025-07-06 15:11:44.409653	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
155	brick	\N	\N	noun	3	0	2	2025-07-06 15:11:44.411548	2025-07-06 15:11:44.41155	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
156	bridge	\N	\N	noun	3	0	3	2025-07-06 15:11:44.41354	2025-07-06 15:11:44.413542	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
157	bright	\N	\N	noun	3	0	4	2025-07-06 15:11:44.415551	2025-07-06 15:11:44.415553	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
158	brilliant	\N	\N	noun	5	0	4	2025-07-06 15:11:44.417595	2025-07-06 15:11:44.417597	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
159	bring	\N	\N	verb	3	0	2	2025-07-06 15:11:44.419677	2025-07-06 15:11:44.419679	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
160	brown	\N	\N	noun	3	0	2	2025-07-06 15:11:44.422232	2025-07-06 15:11:44.422234	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
161	brush	\N	\N	noun	3	0	2	2025-07-06 15:11:44.424133	2025-07-06 15:11:44.424134	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
162	budget	\N	\N	noun	3	0	3	2025-07-06 15:11:44.426057	2025-07-06 15:11:44.426059	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
164	bus	\N	\N	noun	1	0	1	2025-07-06 15:11:44.43055	2025-07-06 15:11:44.430552	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
165	business	\N	\N	noun	4	0	4	2025-07-06 15:11:44.432649	2025-07-06 15:11:44.432651	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
167	but	\N	\N	conjunction	1	0	1	2025-07-06 15:11:44.436465	2025-07-06 15:11:44.436466	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
168	butter	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.438374	2025-07-06 15:11:44.438376	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
169	buy	\N	\N	noun	1	0	1	2025-07-06 15:11:44.44087	2025-07-06 15:11:44.440872	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
170	cafe	\N	\N	noun	2	0	2	2025-07-06 15:11:44.442904	2025-07-06 15:11:44.442905	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
172	call	\N	\N	noun	1	0	2	2025-07-06 15:11:44.447113	2025-07-06 15:11:44.447115	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
173	calm	\N	\N	noun	2	0	2	2025-07-06 15:11:44.449081	2025-07-06 15:11:44.449083	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
174	camel	\N	\N	noun	3	0	2	2025-07-06 15:11:44.451065	2025-07-06 15:11:44.451067	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
175	camera	\N	\N	noun	3	0	3	2025-07-06 15:11:44.453391	2025-07-06 15:11:44.453393	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
176	camp	\N	\N	noun	2	0	2	2025-07-06 15:11:44.455406	2025-07-06 15:11:44.455407	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
177	campaign	\N	\N	noun	4	0	4	2025-07-06 15:11:44.457438	2025-07-06 15:11:44.45744	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
178	can	\N	\N	noun	1	0	1	2025-07-06 15:11:44.459562	2025-07-06 15:11:44.459564	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
179	candy	\N	\N	noun	3	0	2	2025-07-06 15:11:44.461511	2025-07-06 15:11:44.461513	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
180	cap	\N	\N	noun	1	0	1	2025-07-06 15:11:44.463452	2025-07-06 15:11:44.463454	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
181	capacity	\N	\N	noun	4	0	4	2025-07-06 15:11:44.465558	2025-07-06 15:11:44.465559	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
182	capital	\N	\N	noun	4	0	3	2025-07-06 15:11:44.467873	2025-07-06 15:11:44.467875	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
183	car	\N	\N	noun	1	0	1	2025-07-06 15:11:44.469817	2025-07-06 15:11:44.469818	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
184	card	\N	\N	noun	2	0	2	2025-07-06 15:11:44.47169	2025-07-06 15:11:44.471692	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
185	care	\N	\N	noun	2	0	2	2025-07-06 15:11:44.473752	2025-07-06 15:11:44.473754	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
186	career	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.476104	2025-07-06 15:11:44.476106	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
187	careful	\N	\N	adjective	4	0	3	2025-07-06 15:11:44.47812	2025-07-06 15:11:44.478123	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
188	carefully	\N	\N	adverb	5	0	4	2025-07-06 15:11:44.480263	2025-07-06 15:11:44.480265	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
189	carrot	\N	\N	noun	3	0	3	2025-07-06 15:11:44.482423	2025-07-06 15:11:44.482425	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
191	case	\N	\N	noun	2	0	2	2025-07-06 15:11:44.486589	2025-07-06 15:11:44.486591	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
192	castle	\N	\N	noun	3	0	3	2025-07-06 15:11:44.488621	2025-07-06 15:11:44.488622	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
193	catch	\N	\N	noun	3	0	2	2025-07-06 15:11:44.491199	2025-07-06 15:11:44.491201	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
194	cave	\N	\N	noun	2	0	2	2025-07-06 15:11:44.493243	2025-07-06 15:11:44.49326	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
195	ceiling	\N	\N	verb	4	0	3	2025-07-06 15:11:44.495392	2025-07-06 15:11:44.495394	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
197	celebration	\N	\N	noun	6	0	4	2025-07-06 15:11:44.499988	2025-07-06 15:11:44.49999	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
198	cent	\N	\N	noun	2	0	2	2025-07-06 15:11:44.503325	2025-07-06 15:11:44.503327	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
199	certainly	\N	\N	adverb	5	0	4	2025-07-06 15:11:44.505242	2025-07-06 15:11:44.505243	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
200	chair	\N	\N	noun	3	0	2	2025-07-06 15:11:44.507221	2025-07-06 15:11:44.507223	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
201	challenge	\N	\N	noun	5	0	4	2025-07-06 15:11:44.509107	2025-07-06 15:11:44.509109	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
202	change	\N	\N	noun	3	0	3	2025-07-06 15:11:44.511041	2025-07-06 15:11:44.511042	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
203	channel	\N	\N	noun	4	0	3	2025-07-06 15:11:44.512834	2025-07-06 15:11:44.512836	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
204	chapter	\N	\N	adjective	4	0	3	2025-07-06 15:11:44.514823	2025-07-06 15:11:44.514825	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
205	character	\N	\N	adjective	5	0	4	2025-07-06 15:11:44.516975	2025-07-06 15:11:44.516978	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
206	charity	\N	\N	noun	4	0	3	2025-07-06 15:11:44.519192	2025-07-06 15:11:44.519194	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
207	charm	\N	\N	noun	3	0	2	2025-07-06 15:11:44.52126	2025-07-06 15:11:44.521262	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
208	chase	\N	\N	noun	3	0	2	2025-07-06 15:11:44.523668	2025-07-06 15:11:44.52367	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
209	cheer	\N	\N	adjective	3	0	2	2025-07-06 15:11:44.525779	2025-07-06 15:11:44.525781	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
210	cheerful	\N	\N	adjective	4	0	4	2025-07-06 15:11:44.527827	2025-07-06 15:11:44.527829	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
211	cheese	\N	\N	noun	3	0	3	2025-07-06 15:11:44.529896	2025-07-06 15:11:44.529898	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
212	cheque	\N	\N	noun	3	0	3	2025-07-06 15:11:44.531897	2025-07-06 15:11:44.531899	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
213	cherry	\N	\N	noun	3	0	3	2025-07-06 15:11:44.533958	2025-07-06 15:11:44.53396	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
215	childhood	\N	\N	noun	5	0	4	2025-07-06 15:11:44.538549	2025-07-06 15:11:44.538551	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
218	choice	\N	\N	noun	3	0	3	2025-07-06 15:11:44.547294	2025-07-06 15:11:44.547296	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
219	choose	\N	\N	noun	3	0	3	2025-07-06 15:11:44.549229	2025-07-06 15:11:44.549231	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
220	church	\N	\N	noun	3	0	3	2025-07-06 15:11:44.551165	2025-07-06 15:11:44.551167	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
221	cinema	\N	\N	noun	3	0	3	2025-07-06 15:11:44.553021	2025-07-06 15:11:44.553023	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
222	citizen	\N	\N	noun	4	0	3	2025-07-06 15:11:44.554891	2025-07-06 15:11:44.554893	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
223	city	\N	\N	noun	2	0	2	2025-07-06 15:11:44.557366	2025-07-06 15:11:44.557368	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
224	claim	\N	\N	noun	3	0	2	2025-07-06 15:11:44.559814	2025-07-06 15:11:44.559816	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
225	class	\N	\N	noun	3	0	2	2025-07-06 15:11:44.561737	2025-07-06 15:11:44.561739	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
227	clearly	\N	\N	adverb	4	0	3	2025-07-06 15:11:44.565711	2025-07-06 15:11:44.565713	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
228	clever	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.567762	2025-07-06 15:11:44.567764	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
229	climate	\N	\N	noun	4	0	3	2025-07-06 15:11:44.569676	2025-07-06 15:11:44.569678	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
230	climb	\N	\N	noun	3	0	2	2025-07-06 15:11:44.571524	2025-07-06 15:11:44.571525	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
231	clinic	\N	\N	noun	3	0	3	2025-07-06 15:11:44.573578	2025-07-06 15:11:44.573579	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
232	clock	\N	\N	noun	3	0	2	2025-07-06 15:11:44.575548	2025-07-06 15:11:44.575549	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
233	close	\N	\N	noun	3	0	2	2025-07-06 15:11:44.57751	2025-07-06 15:11:44.577512	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
234	cloth	\N	\N	noun	3	0	2	2025-07-06 15:11:44.579394	2025-07-06 15:11:44.579396	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
235	clothes	\N	\N	noun	4	0	3	2025-07-06 15:11:44.581646	2025-07-06 15:11:44.581648	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
236	coach	\N	\N	noun	3	0	2	2025-07-06 15:11:44.583677	2025-07-06 15:11:44.583679	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
237	coat	\N	\N	noun	2	0	2	2025-07-06 15:11:44.585656	2025-07-06 15:11:44.585658	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
238	coconut	\N	\N	noun	4	0	3	2025-07-06 15:11:44.587637	2025-07-06 15:11:44.587639	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
239	coffee	\N	\N	noun	3	0	3	2025-07-06 15:11:44.589666	2025-07-06 15:11:44.589668	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
240	cola	\N	\N	noun	2	0	2	2025-07-06 15:11:44.591592	2025-07-06 15:11:44.591594	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
241	cold	\N	\N	noun	2	0	2	2025-07-06 15:11:44.5934	2025-07-06 15:11:44.593402	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
242	collect	\N	\N	noun	4	0	3	2025-07-06 15:11:44.595375	2025-07-06 15:11:44.595377	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
243	collection	\N	\N	noun	5	0	4	2025-07-06 15:11:44.597309	2025-07-06 15:11:44.597311	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
244	colony	\N	\N	noun	3	0	3	2025-07-06 15:11:44.599315	2025-07-06 15:11:44.599317	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
245	comb	\N	\N	noun	2	0	2	2025-07-06 15:11:44.601739	2025-07-06 15:11:44.601741	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
246	combination	\N	\N	noun	6	0	4	2025-07-06 15:11:44.603785	2025-07-06 15:11:44.603787	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
247	come	\N	\N	noun	1	0	2	2025-07-06 15:11:44.606308	2025-07-06 15:11:44.60631	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
248	comfort	\N	\N	noun	4	0	3	2025-07-06 15:11:44.608313	2025-07-06 15:11:44.608315	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
249	comfortable	\N	\N	adjective	6	0	5	2025-07-06 15:11:44.610322	2025-07-06 15:11:44.610324	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
250	command	\N	\N	noun	4	0	3	2025-07-06 15:11:44.61257	2025-07-06 15:11:44.612572	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
251	committee	\N	\N	noun	5	0	4	2025-07-06 15:11:44.614806	2025-07-06 15:11:44.614808	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
252	communication	\N	\N	noun	6	0	4	2025-07-06 15:11:44.617162	2025-07-06 15:11:44.617164	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
253	community	\N	\N	noun	5	0	4	2025-07-06 15:11:44.619277	2025-07-06 15:11:44.619278	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
254	companion	\N	\N	noun	5	0	4	2025-07-06 15:11:44.62123	2025-07-06 15:11:44.621232	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
255	company	\N	\N	noun	4	0	3	2025-07-06 15:11:44.623116	2025-07-06 15:11:44.623118	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
256	comparison	\N	\N	noun	5	0	5	2025-07-06 15:11:44.625108	2025-07-06 15:11:44.62511	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
257	competition	\N	\N	noun	6	0	4	2025-07-06 15:11:44.627221	2025-07-06 15:11:44.627223	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
258	complain	\N	\N	noun	4	0	4	2025-07-06 15:11:44.629632	2025-07-06 15:11:44.629634	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
259	complete	\N	\N	noun	4	0	4	2025-07-06 15:11:44.631684	2025-07-06 15:11:44.631685	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
260	computer	\N	\N	adjective	4	0	4	2025-07-06 15:11:44.633793	2025-07-06 15:11:44.633795	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
261	concept	\N	\N	noun	4	0	3	2025-07-06 15:11:44.635792	2025-07-06 15:11:44.635794	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
262	concern	\N	\N	noun	4	0	3	2025-07-06 15:11:44.637911	2025-07-06 15:11:44.637913	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
263	concert	\N	\N	noun	4	0	3	2025-07-06 15:11:44.640078	2025-07-06 15:11:44.640079	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
264	conclusion	\N	\N	noun	5	0	4	2025-07-06 15:11:44.642227	2025-07-06 15:11:44.642228	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
265	condition	\N	\N	noun	5	0	4	2025-07-06 15:11:44.644055	2025-07-06 15:11:44.644057	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
266	conduct	\N	\N	noun	4	0	3	2025-07-06 15:11:44.646122	2025-07-06 15:11:44.646123	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
267	conference	\N	\N	noun	5	0	5	2025-07-06 15:11:44.64825	2025-07-06 15:11:44.648252	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
268	confidence	\N	\N	noun	5	0	5	2025-07-06 15:11:44.65063	2025-07-06 15:11:44.650632	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
269	confident	\N	\N	noun	5	0	4	2025-07-06 15:11:44.652534	2025-07-06 15:11:44.652536	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
270	conflict	\N	\N	noun	4	0	4	2025-07-06 15:11:44.654518	2025-07-06 15:11:44.65452	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
271	confused	\N	\N	verb	4	0	4	2025-07-06 15:11:44.656863	2025-07-06 15:11:44.656865	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
272	confusion	\N	\N	noun	5	0	4	2025-07-06 15:11:44.659342	2025-07-06 15:11:44.659344	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
273	connection	\N	\N	noun	5	0	4	2025-07-06 15:11:44.661611	2025-07-06 15:11:44.661613	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
274	consciousness	\N	\N	noun	6	0	5	2025-07-06 15:11:44.663612	2025-07-06 15:11:44.663614	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
275	consideration	\N	\N	noun	6	0	4	2025-07-06 15:11:44.6656	2025-07-06 15:11:44.665603	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
276	constitution	\N	\N	noun	6	0	4	2025-07-06 15:11:44.667541	2025-07-06 15:11:44.667543	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
277	construction	\N	\N	noun	6	0	4	2025-07-06 15:11:44.669695	2025-07-06 15:11:44.669697	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
278	contact	\N	\N	noun	4	0	3	2025-07-06 15:11:44.671752	2025-07-06 15:11:44.671754	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
279	content	\N	\N	noun	4	0	3	2025-07-06 15:11:44.673902	2025-07-06 15:11:44.673903	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
280	context	\N	\N	noun	4	0	3	2025-07-06 15:11:44.676072	2025-07-06 15:11:44.676074	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
281	continue	\N	\N	noun	4	0	4	2025-07-06 15:11:44.678113	2025-07-06 15:11:44.678115	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
282	contract	\N	\N	noun	4	0	4	2025-07-06 15:11:44.680332	2025-07-06 15:11:44.680334	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
283	contribution	\N	\N	noun	6	0	4	2025-07-06 15:11:44.682327	2025-07-06 15:11:44.682329	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
284	control	\N	\N	noun	4	0	3	2025-07-06 15:11:44.684276	2025-07-06 15:11:44.684278	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
285	convenience	\N	\N	noun	6	0	5	2025-07-06 15:11:44.686198	2025-07-06 15:11:44.686199	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
286	convenient	\N	\N	noun	5	0	5	2025-07-06 15:11:44.688362	2025-07-06 15:11:44.688364	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
287	convention	\N	\N	noun	5	0	4	2025-07-06 15:11:44.690526	2025-07-06 15:11:44.690528	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
288	conversation	\N	\N	noun	6	0	4	2025-07-06 15:11:44.692587	2025-07-06 15:11:44.692589	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
289	cook	\N	\N	noun	2	0	2	2025-07-06 15:11:44.694639	2025-07-06 15:11:44.694641	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
290	cookie	\N	\N	noun	3	0	3	2025-07-06 15:11:44.696566	2025-07-06 15:11:44.696568	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
291	cool	\N	\N	noun	2	0	2	2025-07-06 15:11:44.698555	2025-07-06 15:11:44.698557	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
292	cooperation	\N	\N	noun	6	0	4	2025-07-06 15:11:44.70113	2025-07-06 15:11:44.701132	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
293	copy	\N	\N	noun	2	0	2	2025-07-06 15:11:44.70321	2025-07-06 15:11:44.703212	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
294	core	\N	\N	noun	2	0	2	2025-07-06 15:11:44.705189	2025-07-06 15:11:44.705191	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
295	corn	\N	\N	noun	2	0	2	2025-07-06 15:11:44.707073	2025-07-06 15:11:44.707075	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
296	corner	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.709099	2025-07-06 15:11:44.709101	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
297	correct	\N	\N	noun	4	0	3	2025-07-06 15:11:44.711049	2025-07-06 15:11:44.711051	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
298	cost	\N	\N	noun	2	0	2	2025-07-06 15:11:44.712912	2025-07-06 15:11:44.712914	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
299	cotton	\N	\N	noun	3	0	3	2025-07-06 15:11:44.714947	2025-07-06 15:11:44.714949	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
300	council	\N	\N	noun	4	0	3	2025-07-06 15:11:44.716896	2025-07-06 15:11:44.716898	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
301	count	\N	\N	noun	3	0	2	2025-07-06 15:11:44.71886	2025-07-06 15:11:44.718862	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
302	country	\N	\N	noun	4	0	3	2025-07-06 15:11:44.72083	2025-07-06 15:11:44.720832	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
303	courage	\N	\N	noun	4	0	3	2025-07-06 15:11:44.722757	2025-07-06 15:11:44.722759	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
304	courageous	\N	\N	adjective	5	0	5	2025-07-06 15:11:44.72544	2025-07-06 15:11:44.725443	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
305	course	\N	\N	noun	3	0	3	2025-07-06 15:11:44.7279	2025-07-06 15:11:44.727902	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
306	courtesy	\N	\N	noun	4	0	4	2025-07-06 15:11:44.730145	2025-07-06 15:11:44.730147	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
307	cousin	\N	\N	noun	3	0	3	2025-07-06 15:11:44.732079	2025-07-06 15:11:44.732081	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
308	cover	\N	\N	adjective	3	0	2	2025-07-06 15:11:44.734231	2025-07-06 15:11:44.734233	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
309	cow	\N	\N	noun	1	0	1	2025-07-06 15:11:44.736165	2025-07-06 15:11:44.736167	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
310	crab	\N	\N	noun	2	0	2	2025-07-06 15:11:44.738183	2025-07-06 15:11:44.738201	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
311	crayon	\N	\N	noun	3	0	3	2025-07-06 15:11:44.740142	2025-07-06 15:11:44.740144	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
312	cream	\N	\N	noun	3	0	2	2025-07-06 15:11:44.742079	2025-07-06 15:11:44.742082	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
313	create	\N	\N	noun	3	0	3	2025-07-06 15:11:44.744266	2025-07-06 15:11:44.744268	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
314	crisis	\N	\N	noun	3	0	3	2025-07-06 15:11:44.74617	2025-07-06 15:11:44.746172	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
315	cross	\N	\N	noun	3	0	2	2025-07-06 15:11:44.748036	2025-07-06 15:11:44.748038	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
316	crossroads	\N	\N	noun	5	0	5	2025-07-06 15:11:44.752407	2025-07-06 15:11:44.75241	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
317	crow	\N	\N	noun	2	0	2	2025-07-06 15:11:44.755354	2025-07-06 15:11:44.755356	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
318	crowd	\N	\N	noun	3	0	2	2025-07-06 15:11:44.758129	2025-07-06 15:11:44.758131	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
319	cruel	\N	\N	noun	3	0	2	2025-07-06 15:11:44.761228	2025-07-06 15:11:44.76123	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
320	cry	\N	\N	noun	1	0	1	2025-07-06 15:11:44.76325	2025-07-06 15:11:44.763252	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
321	culture	\N	\N	noun	4	0	3	2025-07-06 15:11:44.765244	2025-07-06 15:11:44.765246	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
322	cup	\N	\N	noun	1	0	1	2025-07-06 15:11:44.768207	2025-07-06 15:11:44.768209	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
323	cupcake	\N	\N	noun	4	0	3	2025-07-06 15:11:44.770361	2025-07-06 15:11:44.770364	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
324	cure	\N	\N	noun	2	0	2	2025-07-06 15:11:44.772538	2025-07-06 15:11:44.772539	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
325	curiosity	\N	\N	noun	5	0	4	2025-07-06 15:11:44.774651	2025-07-06 15:11:44.774652	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
326	curious	\N	\N	adjective	4	0	3	2025-07-06 15:11:44.77671	2025-07-06 15:11:44.776712	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
327	currency	\N	\N	noun	4	0	4	2025-07-06 15:11:44.778609	2025-07-06 15:11:44.778611	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
328	curtain	\N	\N	noun	4	0	3	2025-07-06 15:11:44.78066	2025-07-06 15:11:44.780677	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
329	customer	\N	\N	adjective	4	0	4	2025-07-06 15:11:44.782966	2025-07-06 15:11:44.782968	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
330	cut	\N	\N	noun	1	0	1	2025-07-06 15:11:44.785144	2025-07-06 15:11:44.785146	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
331	dad	\N	\N	noun	1	0	1	2025-07-06 15:11:44.787657	2025-07-06 15:11:44.787659	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
332	damage	\N	\N	noun	3	0	3	2025-07-06 15:11:44.790017	2025-07-06 15:11:44.790019	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
333	dance	\N	\N	noun	3	0	2	2025-07-06 15:11:44.792323	2025-07-06 15:11:44.792325	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
334	danger	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.794515	2025-07-06 15:11:44.794517	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
335	dark	\N	\N	noun	2	0	2	2025-07-06 15:11:44.796416	2025-07-06 15:11:44.796418	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
336	data	\N	\N	noun	2	0	2	2025-07-06 15:11:44.798379	2025-07-06 15:11:44.798381	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
337	date	\N	\N	noun	2	0	2	2025-07-06 15:11:44.800635	2025-07-06 15:11:44.800637	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
338	day	\N	\N	noun	1	0	1	2025-07-06 15:11:44.802707	2025-07-06 15:11:44.802708	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
339	deaf	\N	\N	noun	2	0	2	2025-07-06 15:11:44.804882	2025-07-06 15:11:44.804899	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
340	debate	\N	\N	noun	3	0	3	2025-07-06 15:11:44.80706	2025-07-06 15:11:44.807062	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
341	debt	\N	\N	noun	2	0	2	2025-07-06 15:11:44.809354	2025-07-06 15:11:44.809356	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
342	decade	\N	\N	noun	3	0	3	2025-07-06 15:11:44.811243	2025-07-06 15:11:44.811245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
343	decide	\N	\N	noun	3	0	3	2025-07-06 15:11:44.813259	2025-07-06 15:11:44.813261	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
344	decision	\N	\N	noun	4	0	4	2025-07-06 15:11:44.815511	2025-07-06 15:11:44.815513	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
345	decoration	\N	\N	noun	5	0	4	2025-07-06 15:11:44.817597	2025-07-06 15:11:44.817599	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
346	deeply	\N	\N	adverb	3	0	3	2025-07-06 15:11:44.819734	2025-07-06 15:11:44.819736	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
347	deer	\N	\N	adjective	2	0	2	2025-07-06 15:11:44.821891	2025-07-06 15:11:44.821893	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
348	definition	\N	\N	noun	5	0	4	2025-07-06 15:11:44.824043	2025-07-06 15:11:44.824045	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
349	degree	\N	\N	noun	3	0	3	2025-07-06 15:11:44.826185	2025-07-06 15:11:44.826187	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
351	deliver	\N	\N	adjective	4	0	3	2025-07-06 15:11:44.830776	2025-07-06 15:11:44.830778	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
352	demand	\N	\N	noun	3	0	3	2025-07-06 15:11:44.83328	2025-07-06 15:11:44.833282	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
353	democracy	\N	\N	noun	5	0	4	2025-07-06 15:11:44.836309	2025-07-06 15:11:44.836311	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
354	departure	\N	\N	noun	5	0	4	2025-07-06 15:11:44.839044	2025-07-06 15:11:44.839046	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
355	depressed	\N	\N	verb	5	0	4	2025-07-06 15:11:44.841594	2025-07-06 15:11:44.841595	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
356	depth	\N	\N	noun	3	0	2	2025-07-06 15:11:44.843659	2025-07-06 15:11:44.843661	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
357	describe	\N	\N	noun	4	0	4	2025-07-06 15:11:44.846055	2025-07-06 15:11:44.846057	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
358	description	\N	\N	noun	6	0	4	2025-07-06 15:11:44.848308	2025-07-06 15:11:44.84831	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
359	desert	\N	\N	noun	3	0	3	2025-07-06 15:11:44.851143	2025-07-06 15:11:44.851145	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
360	design	\N	\N	noun	3	0	3	2025-07-06 15:11:44.853428	2025-07-06 15:11:44.85343	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
361	desire	\N	\N	noun	3	0	3	2025-07-06 15:11:44.85563	2025-07-06 15:11:44.855632	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
362	desk	\N	\N	noun	2	0	2	2025-07-06 15:11:44.857659	2025-07-06 15:11:44.857661	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
363	destination	\N	\N	noun	6	0	4	2025-07-06 15:11:44.859716	2025-07-06 15:11:44.859717	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
364	detail	\N	\N	noun	3	0	3	2025-07-06 15:11:44.861789	2025-07-06 15:11:44.861791	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
365	detection	\N	\N	noun	5	0	4	2025-07-06 15:11:44.863834	2025-07-06 15:11:44.863836	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
366	determined	\N	\N	verb	5	0	5	2025-07-06 15:11:44.866001	2025-07-06 15:11:44.866003	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
367	develop	\N	\N	noun	4	0	3	2025-07-06 15:11:44.868123	2025-07-06 15:11:44.868125	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
368	device	\N	\N	noun	3	0	3	2025-07-06 15:11:44.870977	2025-07-06 15:11:44.870979	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
369	devotion	\N	\N	noun	4	0	4	2025-07-06 15:11:44.872919	2025-07-06 15:11:44.872921	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
370	diamond	\N	\N	noun	4	0	3	2025-07-06 15:11:44.874886	2025-07-06 15:11:44.874888	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
371	diary	\N	\N	noun	3	0	2	2025-07-06 15:11:44.876971	2025-07-06 15:11:44.876973	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
372	dictionary	\N	\N	noun	5	0	4	2025-07-06 15:11:44.879085	2025-07-06 15:11:44.879087	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
373	difference	\N	\N	noun	5	0	5	2025-07-06 15:11:44.881169	2025-07-06 15:11:44.881171	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
375	difficult	\N	\N	noun	5	0	4	2025-07-06 15:11:44.885562	2025-07-06 15:11:44.885565	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
376	difficulty	\N	\N	noun	5	0	5	2025-07-06 15:11:44.887631	2025-07-06 15:11:44.887633	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
377	dimension	\N	\N	noun	5	0	4	2025-07-06 15:11:44.88983	2025-07-06 15:11:44.889833	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
378	dinner	\N	\N	adjective	3	0	3	2025-07-06 15:11:44.891924	2025-07-06 15:11:44.891926	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
379	dinosaur	\N	\N	noun	4	0	4	2025-07-06 15:11:44.893879	2025-07-06 15:11:44.893881	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
380	direction	\N	\N	noun	5	0	4	2025-07-06 15:11:44.896299	2025-07-06 15:11:44.896301	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
381	directly	\N	\N	adverb	4	0	4	2025-07-06 15:11:44.898732	2025-07-06 15:11:44.898734	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
382	dirty	\N	\N	noun	3	0	2	2025-07-06 15:11:44.901465	2025-07-06 15:11:44.901468	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
383	disappointed	\N	\N	verb	6	0	5	2025-07-06 15:11:44.903845	2025-07-06 15:11:44.903847	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
384	disaster	\N	\N	adjective	4	0	4	2025-07-06 15:11:44.906243	2025-07-06 15:11:44.906245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
385	discount	\N	\N	noun	4	0	4	2025-07-06 15:11:44.908355	2025-07-06 15:11:44.908357	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
386	discover	\N	\N	adjective	4	0	4	2025-07-06 15:11:44.910869	2025-07-06 15:11:44.910871	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
387	discovery	\N	\N	noun	5	0	4	2025-07-06 15:11:44.912927	2025-07-06 15:11:44.912929	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
388	discussion	\N	\N	noun	5	0	4	2025-07-06 15:11:44.915187	2025-07-06 15:11:44.915189	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
389	disease	\N	\N	noun	4	0	3	2025-07-06 15:11:44.917286	2025-07-06 15:11:44.917288	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
391	dishonest	\N	\N	adjective	5	0	4	2025-07-06 15:11:44.921953	2025-07-06 15:11:44.921955	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
392	dislike	\N	\N	noun	4	0	3	2025-07-06 15:11:44.923975	2025-07-06 15:11:44.923977	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
393	district	\N	\N	noun	4	0	4	2025-07-06 15:11:44.926	2025-07-06 15:11:44.926002	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
394	divorce	\N	\N	noun	4	0	3	2025-07-06 15:11:44.928103	2025-07-06 15:11:44.928105	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
395	dizzy	\N	\N	noun	3	0	2	2025-07-06 15:11:44.930235	2025-07-06 15:11:44.930237	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
396	do	\N	\N	noun	1	0	1	2025-07-06 15:11:44.932334	2025-07-06 15:11:44.932336	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
397	doctor	\N	\N	noun	3	0	3	2025-07-06 15:11:44.934293	2025-07-06 15:11:44.934295	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
398	document	\N	\N	noun	4	0	4	2025-07-06 15:11:44.936322	2025-07-06 15:11:44.936324	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
399	does	\N	\N	noun	2	0	2	2025-07-06 15:11:44.938251	2025-07-06 15:11:44.938253	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
400	dolphin	\N	\N	noun	4	0	3	2025-07-06 15:11:44.940833	2025-07-06 15:11:44.940835	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
401	donkey	\N	\N	noun	3	0	3	2025-07-06 15:11:44.942938	2025-07-06 15:11:44.94294	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
402	door	\N	\N	noun	2	0	2	2025-07-06 15:11:44.945062	2025-07-06 15:11:44.945064	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
403	doubt	\N	\N	noun	3	0	2	2025-07-06 15:11:44.947242	2025-07-06 15:11:44.94726	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
404	doughnut	\N	\N	noun	4	0	4	2025-07-06 15:11:44.949483	2025-07-06 15:11:44.949485	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
406	downtown	\N	\N	noun	4	0	4	2025-07-06 15:11:44.954275	2025-07-06 15:11:44.954276	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
407	drama	\N	\N	noun	3	0	2	2025-07-06 15:11:44.956727	2025-07-06 15:11:44.956744	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
408	draw	\N	\N	noun	2	0	2	2025-07-06 15:11:44.958984	2025-07-06 15:11:44.958986	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
409	dream	\N	\N	noun	3	0	2	2025-07-06 15:11:44.961333	2025-07-06 15:11:44.961351	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
410	dress	\N	\N	noun	3	0	2	2025-07-06 15:11:44.96346	2025-07-06 15:11:44.963462	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
411	drink	\N	\N	noun	3	0	2	2025-07-06 15:11:44.96562	2025-07-06 15:11:44.965622	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
413	duck	\N	\N	noun	2	0	2	2025-07-06 15:11:44.9706	2025-07-06 15:11:44.970602	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
414	dull	\N	\N	noun	2	0	2	2025-07-06 15:11:44.972646	2025-07-06 15:11:44.972665	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
415	dumpling	\N	\N	verb	4	0	4	2025-07-06 15:11:44.974541	2025-07-06 15:11:44.974543	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
416	duty	\N	\N	noun	2	0	2	2025-07-06 15:11:44.978194	2025-07-06 15:11:44.978196	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
417	eager	\N	\N	adjective	3	0	2	2025-07-06 15:11:44.981022	2025-07-06 15:11:44.981024	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
418	eagerly	\N	\N	adverb	4	0	3	2025-07-06 15:11:44.98419	2025-07-06 15:11:44.984192	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
419	eagle	\N	\N	noun	3	0	2	2025-07-06 15:11:44.986931	2025-07-06 15:11:44.986933	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
420	ear	\N	\N	noun	1	0	1	2025-07-06 15:11:44.989144	2025-07-06 15:11:44.989146	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
421	early	\N	\N	adverb	3	0	2	2025-07-06 15:11:44.991299	2025-07-06 15:11:44.991301	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
422	earn	\N	\N	noun	2	0	2	2025-07-06 15:11:44.993313	2025-07-06 15:11:44.993315	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
423	earring	\N	\N	verb	4	0	3	2025-07-06 15:11:44.995306	2025-07-06 15:11:44.995308	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
424	earth	\N	\N	noun	3	0	2	2025-07-06 15:11:44.997682	2025-07-06 15:11:44.997684	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
425	easily	\N	\N	adverb	3	0	3	2025-07-06 15:11:45.000052	2025-07-06 15:11:45.000054	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
426	easy	\N	\N	noun	2	0	2	2025-07-06 15:11:45.002265	2025-07-06 15:11:45.002283	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
427	eat	\N	\N	noun	1	0	1	2025-07-06 15:11:45.004346	2025-07-06 15:11:45.004348	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
428	ecology	\N	\N	noun	4	0	3	2025-07-06 15:11:45.006787	2025-07-06 15:11:45.006789	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
429	edge	\N	\N	noun	2	0	2	2025-07-06 15:11:45.008906	2025-07-06 15:11:45.008908	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
430	education	\N	\N	noun	5	0	4	2025-07-06 15:11:45.010829	2025-07-06 15:11:45.010831	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
431	effect	\N	\N	noun	3	0	3	2025-07-06 15:11:45.013422	2025-07-06 15:11:45.013424	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
432	effort	\N	\N	noun	3	0	3	2025-07-06 15:11:45.015581	2025-07-06 15:11:45.015583	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
433	egg	\N	\N	noun	1	0	1	2025-07-06 15:11:45.017564	2025-07-06 15:11:45.017566	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
434	eight	\N	\N	noun	3	0	4	2025-07-06 15:11:45.019648	2025-07-06 15:11:45.019649	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
435	eighteen	\N	\N	noun	4	0	4	2025-07-06 15:11:45.021857	2025-07-06 15:11:45.021859	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
436	eighth	\N	\N	noun	3	0	4	2025-07-06 15:11:45.023837	2025-07-06 15:11:45.023839	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
438	elderly	\N	\N	adverb	4	0	3	2025-07-06 15:11:45.027564	2025-07-06 15:11:45.027565	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
439	element	\N	\N	noun	4	0	3	2025-07-06 15:11:45.029618	2025-07-06 15:11:45.02962	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
440	eleven	\N	\N	noun	3	0	3	2025-07-06 15:11:45.032394	2025-07-06 15:11:45.032396	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
441	embassy	\N	\N	noun	4	0	3	2025-07-06 15:11:45.034373	2025-07-06 15:11:45.034375	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
442	emotion	\N	\N	noun	4	0	4	2025-07-06 15:11:45.036253	2025-07-06 15:11:45.036254	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
443	emphasis	\N	\N	noun	4	0	4	2025-07-06 15:11:45.038145	2025-07-06 15:11:45.038147	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
444	employment	\N	\N	noun	5	0	5	2025-07-06 15:11:45.040077	2025-07-06 15:11:45.040079	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
445	empty	\N	\N	noun	3	0	2	2025-07-06 15:11:45.04206	2025-07-06 15:11:45.042062	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
446	encourage	\N	\N	noun	5	0	4	2025-07-06 15:11:45.044226	2025-07-06 15:11:45.044228	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
447	energy	\N	\N	noun	3	0	3	2025-07-06 15:11:45.046378	2025-07-06 15:11:45.04638	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
448	engine	\N	\N	noun	3	0	3	2025-07-06 15:11:45.048317	2025-07-06 15:11:45.048318	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
449	enjoy	\N	\N	noun	3	0	2	2025-07-06 15:11:45.050626	2025-07-06 15:11:45.050628	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
450	entertainment	\N	\N	noun	6	0	5	2025-07-06 15:11:45.052542	2025-07-06 15:11:45.052544	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
451	enthusiasm	\N	\N	noun	5	0	5	2025-07-06 15:11:45.055114	2025-07-06 15:11:45.055115	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
452	environment	\N	\N	noun	6	0	5	2025-07-06 15:11:45.057056	2025-07-06 15:11:45.057057	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
453	episode	\N	\N	noun	4	0	3	2025-07-06 15:11:45.05891	2025-07-06 15:11:45.058911	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
454	equal	\N	\N	noun	3	0	2	2025-07-06 15:11:45.060798	2025-07-06 15:11:45.0608	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
455	equipment	\N	\N	noun	5	0	4	2025-07-06 15:11:45.06265	2025-07-06 15:11:45.062652	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
456	eraser	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.064569	2025-07-06 15:11:45.064571	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
457	escape	\N	\N	noun	3	0	3	2025-07-06 15:11:45.06744	2025-07-06 15:11:45.067442	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
458	especially	\N	\N	adverb	5	0	5	2025-07-06 15:11:45.070081	2025-07-06 15:11:45.070083	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
459	even	\N	\N	noun	2	0	2	2025-07-06 15:11:45.072382	2025-07-06 15:11:45.072384	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
461	event	\N	\N	noun	3	0	2	2025-07-06 15:11:45.076499	2025-07-06 15:11:45.076501	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
462	everywhere	\N	\N	noun	5	0	5	2025-07-06 15:11:45.078598	2025-07-06 15:11:45.0786	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
463	evidence	\N	\N	noun	4	0	4	2025-07-06 15:11:45.080705	2025-07-06 15:11:45.080707	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
464	evolution	\N	\N	noun	5	0	4	2025-07-06 15:11:45.082758	2025-07-06 15:11:45.08276	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
465	exactly	\N	\N	adverb	4	0	3	2025-07-06 15:11:45.08467	2025-07-06 15:11:45.084671	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
466	exam	\N	\N	noun	2	0	2	2025-07-06 15:11:45.086877	2025-07-06 15:11:45.086879	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
467	excellent	\N	\N	noun	5	0	4	2025-07-06 15:11:45.088823	2025-07-06 15:11:45.088825	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
468	exception	\N	\N	noun	5	0	4	2025-07-06 15:11:45.091092	2025-07-06 15:11:45.091094	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
469	exchange	\N	\N	noun	4	0	4	2025-07-06 15:11:45.093063	2025-07-06 15:11:45.093065	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
470	excited	\N	\N	verb	4	0	3	2025-07-06 15:11:45.095104	2025-07-06 15:11:45.095106	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
471	excitement	\N	\N	noun	5	0	5	2025-07-06 15:11:45.097029	2025-07-06 15:11:45.097031	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
472	excuse	\N	\N	noun	3	0	3	2025-07-06 15:11:45.099082	2025-07-06 15:11:45.0991	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
473	exercise	\N	\N	noun	4	0	4	2025-07-06 15:11:45.101144	2025-07-06 15:11:45.101146	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
474	expectation	\N	\N	noun	6	0	4	2025-07-06 15:11:45.103122	2025-07-06 15:11:45.103124	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
475	experience	\N	\N	noun	5	0	5	2025-07-06 15:11:45.105039	2025-07-06 15:11:45.105041	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
476	experienced	\N	\N	verb	6	0	5	2025-07-06 15:11:45.106989	2025-07-06 15:11:45.106991	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
477	experiment	\N	\N	noun	5	0	5	2025-07-06 15:11:45.108779	2025-07-06 15:11:45.108781	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
478	expert	\N	\N	noun	3	0	3	2025-07-06 15:11:45.110527	2025-07-06 15:11:45.110529	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
479	explain	\N	\N	noun	4	0	3	2025-07-06 15:11:45.112431	2025-07-06 15:11:45.112433	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
480	explanation	\N	\N	noun	6	0	4	2025-07-06 15:11:45.114227	2025-07-06 15:11:45.114229	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
481	expression	\N	\N	noun	5	0	4	2025-07-06 15:11:45.116278	2025-07-06 15:11:45.11628	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
482	extension	\N	\N	noun	5	0	4	2025-07-06 15:11:45.118682	2025-07-06 15:11:45.118685	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
483	extent	\N	\N	noun	3	0	3	2025-07-06 15:11:45.120963	2025-07-06 15:11:45.120965	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
484	eye	\N	\N	noun	1	0	1	2025-07-06 15:11:45.123113	2025-07-06 15:11:45.123116	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
485	face	\N	\N	noun	2	0	2	2025-07-06 15:11:45.125255	2025-07-06 15:11:45.125257	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
486	fact	\N	\N	noun	2	0	2	2025-07-06 15:11:45.12717	2025-07-06 15:11:45.127172	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
487	factor	\N	\N	noun	3	0	3	2025-07-06 15:11:45.129834	2025-07-06 15:11:45.129836	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
488	factory	\N	\N	noun	4	0	3	2025-07-06 15:11:45.13216	2025-07-06 15:11:45.132162	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
489	fail	\N	\N	noun	2	0	2	2025-07-06 15:11:45.134083	2025-07-06 15:11:45.134085	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
490	failure	\N	\N	noun	4	0	3	2025-07-06 15:11:45.136049	2025-07-06 15:11:45.13605	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
491	fair	\N	\N	noun	2	0	2	2025-07-06 15:11:45.137861	2025-07-06 15:11:45.137863	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
492	faith	\N	\N	noun	3	0	2	2025-07-06 15:11:45.139951	2025-07-06 15:11:45.139953	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
493	fall	\N	\N	noun	2	0	2	2025-07-06 15:11:45.141983	2025-07-06 15:11:45.141985	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
494	false	\N	\N	noun	3	0	2	2025-07-06 15:11:45.143904	2025-07-06 15:11:45.143906	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
495	fame	\N	\N	noun	2	0	2	2025-07-06 15:11:45.14584	2025-07-06 15:11:45.145842	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
496	familiar	\N	\N	noun	4	0	4	2025-07-06 15:11:45.147593	2025-07-06 15:11:45.147595	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
497	famous	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.149609	2025-07-06 15:11:45.149611	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
499	fantastic	\N	\N	noun	5	0	4	2025-07-06 15:11:45.153628	2025-07-06 15:11:45.15363	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
500	farm	\N	\N	noun	2	0	2	2025-07-06 15:11:45.156107	2025-07-06 15:11:45.156126	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
501	fashion	\N	\N	noun	4	0	3	2025-07-06 15:11:45.158121	2025-07-06 15:11:45.158123	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
502	fashionable	\N	\N	adjective	6	0	5	2025-07-06 15:11:45.160048	2025-07-06 15:11:45.16005	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
503	fast	\N	\N	noun	2	0	2	2025-07-06 15:11:45.16196	2025-07-06 15:11:45.161962	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
504	fat	\N	\N	noun	1	0	1	2025-07-06 15:11:45.163877	2025-07-06 15:11:45.163879	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
505	fault	\N	\N	noun	3	0	2	2025-07-06 15:11:45.166591	2025-07-06 15:11:45.166593	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
506	fear	\N	\N	noun	2	0	2	2025-07-06 15:11:45.168655	2025-07-06 15:11:45.168657	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
507	feature	\N	\N	noun	4	0	3	2025-07-06 15:11:45.17058	2025-07-06 15:11:45.170582	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
508	fee	\N	\N	noun	1	0	1	2025-07-06 15:11:45.172396	2025-07-06 15:11:45.172398	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
509	feed	\N	\N	noun	2	0	2	2025-07-06 15:11:45.174287	2025-07-06 15:11:45.174289	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
510	feel	\N	\N	noun	2	0	2	2025-07-06 15:11:45.176193	2025-07-06 15:11:45.176195	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
511	feeling	\N	\N	verb	4	0	3	2025-07-06 15:11:45.178312	2025-07-06 15:11:45.178313	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
513	fierce	\N	\N	noun	3	0	3	2025-07-06 15:11:45.182031	2025-07-06 15:11:45.182033	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
514	fifteen	\N	\N	noun	4	0	3	2025-07-06 15:11:45.18419	2025-07-06 15:11:45.184192	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
515	fifth	\N	\N	noun	3	0	2	2025-07-06 15:11:45.186075	2025-07-06 15:11:45.186077	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
516	fifty	\N	\N	noun	3	0	2	2025-07-06 15:11:45.189948	2025-07-06 15:11:45.18995	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
517	fight	\N	\N	noun	3	0	4	2025-07-06 15:11:45.193074	2025-07-06 15:11:45.193076	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
518	figure	\N	\N	noun	3	0	3	2025-07-06 15:11:45.195236	2025-07-06 15:11:45.195238	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
519	fill	\N	\N	noun	2	0	2	2025-07-06 15:11:45.197313	2025-07-06 15:11:45.197316	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
520	film	\N	\N	noun	2	0	2	2025-07-06 15:11:45.200347	2025-07-06 15:11:45.200349	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
521	final	\N	\N	noun	3	0	2	2025-07-06 15:11:45.202862	2025-07-06 15:11:45.202865	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
522	finally	\N	\N	adverb	4	0	3	2025-07-06 15:11:45.205191	2025-07-06 15:11:45.205194	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
523	finance	\N	\N	noun	4	0	3	2025-07-06 15:11:45.207814	2025-07-06 15:11:45.207816	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
524	find	\N	\N	noun	1	0	2	2025-07-06 15:11:45.209781	2025-07-06 15:11:45.209783	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
525	fine	\N	\N	noun	2	0	2	2025-07-06 15:11:45.211887	2025-07-06 15:11:45.211889	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
526	finger	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.213861	2025-07-06 15:11:45.213863	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
527	finish	\N	\N	noun	3	0	3	2025-07-06 15:11:45.215915	2025-07-06 15:11:45.215917	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
529	firm	\N	\N	noun	2	0	2	2025-07-06 15:11:45.220687	2025-07-06 15:11:45.22069	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
530	first	\N	\N	noun	1	0	2	2025-07-06 15:11:45.22286	2025-07-06 15:11:45.222862	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
532	five	\N	\N	adjective	2	0	2	2025-07-06 15:11:45.227484	2025-07-06 15:11:45.227485	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
533	flood	\N	\N	noun	3	0	2	2025-07-06 15:11:45.229595	2025-07-06 15:11:45.229597	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
534	floor	\N	\N	noun	3	0	2	2025-07-06 15:11:45.231559	2025-07-06 15:11:45.231561	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
535	flow	\N	\N	noun	2	0	2	2025-07-06 15:11:45.233708	2025-07-06 15:11:45.23371	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
536	flower	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.235739	2025-07-06 15:11:45.235741	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
537	fly	\N	\N	adverb	1	0	1	2025-07-06 15:11:45.237634	2025-07-06 15:11:45.237636	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
538	focus	\N	\N	noun	3	0	2	2025-07-06 15:11:45.239719	2025-07-06 15:11:45.239721	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
539	fog	\N	\N	noun	1	0	1	2025-07-06 15:11:45.241801	2025-07-06 15:11:45.241803	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
540	follow	\N	\N	noun	3	0	3	2025-07-06 15:11:45.244081	2025-07-06 15:11:45.244099	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
541	foolish	\N	\N	noun	4	0	3	2025-07-06 15:11:45.246011	2025-07-06 15:11:45.246013	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
542	foot	\N	\N	noun	2	0	2	2025-07-06 15:11:45.247942	2025-07-06 15:11:45.247943	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
543	force	\N	\N	noun	3	0	2	2025-07-06 15:11:45.249958	2025-07-06 15:11:45.249976	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
544	forest	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.251869	2025-07-06 15:11:45.251871	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
545	forget	\N	\N	noun	3	0	3	2025-07-06 15:11:45.253912	2025-07-06 15:11:45.253913	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
546	forgive	\N	\N	adjective	4	0	3	2025-07-06 15:11:45.256084	2025-07-06 15:11:45.256086	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
547	fork	\N	\N	noun	2	0	2	2025-07-06 15:11:45.258879	2025-07-06 15:11:45.258882	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
548	form	\N	\N	noun	2	0	2	2025-07-06 15:11:45.261202	2025-07-06 15:11:45.261204	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
549	fortunate	\N	\N	noun	5	0	4	2025-07-06 15:11:45.263264	2025-07-06 15:11:45.263266	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
550	fortunately	\N	\N	adverb	6	0	5	2025-07-06 15:11:45.265917	2025-07-06 15:11:45.265919	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
551	fortune	\N	\N	noun	4	0	3	2025-07-06 15:11:45.268829	2025-07-06 15:11:45.268831	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
552	forty	\N	\N	noun	3	0	2	2025-07-06 15:11:45.270956	2025-07-06 15:11:45.270958	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
553	foundation	\N	\N	noun	5	0	4	2025-07-06 15:11:45.273322	2025-07-06 15:11:45.273324	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
554	four	\N	\N	noun	2	0	2	2025-07-06 15:11:45.275673	2025-07-06 15:11:45.275675	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
555	fourteen	\N	\N	noun	4	0	4	2025-07-06 15:11:45.278053	2025-07-06 15:11:45.278056	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
556	fourth	\N	\N	noun	3	0	3	2025-07-06 15:11:45.280449	2025-07-06 15:11:45.280452	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
557	fox	\N	\N	noun	1	0	1	2025-07-06 15:11:45.283282	2025-07-06 15:11:45.283286	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
558	frankly	\N	\N	adverb	4	0	3	2025-07-06 15:11:45.285663	2025-07-06 15:11:45.285665	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
559	free	\N	\N	noun	2	0	2	2025-07-06 15:11:45.287685	2025-07-06 15:11:45.287687	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
560	freedom	\N	\N	noun	4	0	3	2025-07-06 15:11:45.289864	2025-07-06 15:11:45.289866	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
561	freeze	\N	\N	noun	3	0	3	2025-07-06 15:11:45.29211	2025-07-06 15:11:45.292112	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
562	frequently	\N	\N	adverb	5	0	5	2025-07-06 15:11:45.2944	2025-07-06 15:11:45.294403	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
563	fresh	\N	\N	noun	3	0	2	2025-07-06 15:11:45.296729	2025-07-06 15:11:45.296731	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
564	friend	\N	\N	noun	3	0	3	2025-07-06 15:11:45.299047	2025-07-06 15:11:45.29905	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
565	friendly	\N	\N	adverb	4	0	4	2025-07-06 15:11:45.301281	2025-07-06 15:11:45.301283	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
566	friendship	\N	\N	noun	5	0	5	2025-07-06 15:11:45.303808	2025-07-06 15:11:45.30381	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
567	frog	\N	\N	noun	2	0	2	2025-07-06 15:11:45.3061	2025-07-06 15:11:45.306102	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
568	from	\N	\N	preposition	1	0	2	2025-07-06 15:11:45.308493	2025-07-06 15:11:45.308496	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
569	front	\N	\N	noun	3	0	2	2025-07-06 15:11:45.310716	2025-07-06 15:11:45.310719	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
570	frozen	\N	\N	noun	3	0	3	2025-07-06 15:11:45.31283	2025-07-06 15:11:45.312832	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
571	fruit	\N	\N	noun	3	0	2	2025-07-06 15:11:45.315047	2025-07-06 15:11:45.315049	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
572	function	\N	\N	noun	4	0	4	2025-07-06 15:11:45.317363	2025-07-06 15:11:45.317365	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
573	fund	\N	\N	noun	2	0	2	2025-07-06 15:11:45.319484	2025-07-06 15:11:45.319486	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
574	funeral	\N	\N	noun	4	0	3	2025-07-06 15:11:45.321643	2025-07-06 15:11:45.321645	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
576	furniture	\N	\N	noun	5	0	4	2025-07-06 15:11:45.325593	2025-07-06 15:11:45.325595	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
577	future	\N	\N	noun	3	0	3	2025-07-06 15:11:45.327478	2025-07-06 15:11:45.32748	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
578	gain	\N	\N	noun	2	0	2	2025-07-06 15:11:45.32934	2025-07-06 15:11:45.329342	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
579	gallery	\N	\N	noun	4	0	3	2025-07-06 15:11:45.331164	2025-07-06 15:11:45.331166	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
580	game	\N	\N	noun	2	0	2	2025-07-06 15:11:45.333249	2025-07-06 15:11:45.333251	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
581	gang	\N	\N	noun	2	0	2	2025-07-06 15:11:45.335052	2025-07-06 15:11:45.335054	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
582	gap	\N	\N	noun	1	0	1	2025-07-06 15:11:45.337119	2025-07-06 15:11:45.337121	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
583	garage	\N	\N	noun	3	0	3	2025-07-06 15:11:45.338992	2025-07-06 15:11:45.338994	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
584	garbage	\N	\N	noun	4	0	3	2025-07-06 15:11:45.340843	2025-07-06 15:11:45.340861	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
585	garden	\N	\N	noun	3	0	3	2025-07-06 15:11:45.342755	2025-07-06 15:11:45.342757	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
586	gas	\N	\N	noun	1	0	1	2025-07-06 15:11:45.344732	2025-07-06 15:11:45.344734	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
587	gaze	\N	\N	noun	2	0	2	2025-07-06 15:11:45.346614	2025-07-06 15:11:45.346615	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
588	gender	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.348618	2025-07-06 15:11:45.34862	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
589	general	\N	\N	noun	4	0	3	2025-07-06 15:11:45.350631	2025-07-06 15:11:45.350633	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
590	generally	\N	\N	adverb	5	0	4	2025-07-06 15:11:45.352699	2025-07-06 15:11:45.352701	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
591	generation	\N	\N	noun	5	0	4	2025-07-06 15:11:45.355002	2025-07-06 15:11:45.355005	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
592	generosity	\N	\N	noun	5	0	5	2025-07-06 15:11:45.357061	2025-07-06 15:11:45.357063	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
593	genius	\N	\N	noun	3	0	3	2025-07-06 15:11:45.359184	2025-07-06 15:11:45.359202	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
594	gentle	\N	\N	noun	3	0	3	2025-07-06 15:11:45.361208	2025-07-06 15:11:45.36121	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
595	gently	\N	\N	adverb	3	0	3	2025-07-06 15:11:45.36319	2025-07-06 15:11:45.363192	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
596	gesture	\N	\N	noun	4	0	3	2025-07-06 15:11:45.365513	2025-07-06 15:11:45.365515	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
598	ghost	\N	\N	noun	3	0	2	2025-07-06 15:11:45.369867	2025-07-06 15:11:45.369884	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
599	giant	\N	\N	noun	3	0	2	2025-07-06 15:11:45.371905	2025-07-06 15:11:45.371907	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
600	gift	\N	\N	noun	2	0	2	2025-07-06 15:11:45.37374	2025-07-06 15:11:45.373742	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
601	giraffe	\N	\N	noun	4	0	3	2025-07-06 15:11:45.376072	2025-07-06 15:11:45.376074	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
602	girl	\N	\N	noun	2	0	2	2025-07-06 15:11:45.378139	2025-07-06 15:11:45.378141	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
604	glass	\N	\N	noun	3	0	2	2025-07-06 15:11:45.382156	2025-07-06 15:11:45.382157	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
605	global	\N	\N	noun	3	0	3	2025-07-06 15:11:45.384125	2025-07-06 15:11:45.384142	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
606	glory	\N	\N	noun	3	0	2	2025-07-06 15:11:45.386108	2025-07-06 15:11:45.38611	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
607	gloves	\N	\N	noun	3	0	3	2025-07-06 15:11:45.388112	2025-07-06 15:11:45.388114	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
609	goal	\N	\N	noun	2	0	2	2025-07-06 15:11:45.392533	2025-07-06 15:11:45.392535	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
610	goat	\N	\N	noun	2	0	2	2025-07-06 15:11:45.394832	2025-07-06 15:11:45.394834	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
611	god	\N	\N	noun	1	0	1	2025-07-06 15:11:45.396747	2025-07-06 15:11:45.396749	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
612	golden	\N	\N	noun	3	0	3	2025-07-06 15:11:45.39872	2025-07-06 15:11:45.398722	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
613	good	\N	\N	noun	2	0	2	2025-07-06 15:11:45.401217	2025-07-06 15:11:45.401219	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
614	goodbye	\N	\N	noun	4	0	3	2025-07-06 15:11:45.403693	2025-07-06 15:11:45.403695	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
615	goodness	\N	\N	noun	4	0	4	2025-07-06 15:11:45.405867	2025-07-06 15:11:45.405869	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
616	gossip	\N	\N	noun	3	0	3	2025-07-06 15:11:45.409926	2025-07-06 15:11:45.409929	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
617	government	\N	\N	noun	5	0	5	2025-07-06 15:11:45.412668	2025-07-06 15:11:45.41267	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
618	grace	\N	\N	noun	3	0	2	2025-07-06 15:11:45.415152	2025-07-06 15:11:45.415154	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
619	grade	\N	\N	noun	3	0	2	2025-07-06 15:11:45.417515	2025-07-06 15:11:45.417517	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
620	gradual	\N	\N	noun	4	0	3	2025-07-06 15:11:45.419752	2025-07-06 15:11:45.419754	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
621	grain	\N	\N	noun	3	0	2	2025-07-06 15:11:45.422285	2025-07-06 15:11:45.422287	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
622	grand	\N	\N	noun	3	0	2	2025-07-06 15:11:45.424502	2025-07-06 15:11:45.424504	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
623	grandma	\N	\N	noun	4	0	3	2025-07-06 15:11:45.426538	2025-07-06 15:11:45.42654	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
624	grandpa	\N	\N	noun	4	0	3	2025-07-06 15:11:45.428647	2025-07-06 15:11:45.428649	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
625	grant	\N	\N	noun	3	0	2	2025-07-06 15:11:45.430641	2025-07-06 15:11:45.430643	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
626	grape	\N	\N	noun	3	0	2	2025-07-06 15:11:45.432841	2025-07-06 15:11:45.432843	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
627	grapes	\N	\N	noun	3	0	3	2025-07-06 15:11:45.434777	2025-07-06 15:11:45.434779	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
628	graph	\N	\N	noun	3	0	2	2025-07-06 15:11:45.436698	2025-07-06 15:11:45.4367	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
629	grass	\N	\N	noun	3	0	2	2025-07-06 15:11:45.438573	2025-07-06 15:11:45.438574	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
630	grateful	\N	\N	adjective	4	0	4	2025-07-06 15:11:45.440556	2025-07-06 15:11:45.440558	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
631	gratitude	\N	\N	noun	5	0	4	2025-07-06 15:11:45.442642	2025-07-06 15:11:45.442644	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
632	gravity	\N	\N	noun	4	0	3	2025-07-06 15:11:45.444663	2025-07-06 15:11:45.444665	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
633	great	\N	\N	noun	3	0	2	2025-07-06 15:11:45.446516	2025-07-06 15:11:45.446518	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
634	greedy	\N	\N	noun	3	0	3	2025-07-06 15:11:45.448551	2025-07-06 15:11:45.448552	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
635	grey	\N	\N	noun	2	0	2	2025-07-06 15:11:45.451251	2025-07-06 15:11:45.451253	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
636	grief	\N	\N	noun	3	0	2	2025-07-06 15:11:45.45382	2025-07-06 15:11:45.453822	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
637	ground	\N	\N	noun	3	0	3	2025-07-06 15:11:45.455721	2025-07-06 15:11:45.455722	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
638	group	\N	\N	noun	3	0	2	2025-07-06 15:11:45.457549	2025-07-06 15:11:45.457551	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
639	grow	\N	\N	noun	2	0	2	2025-07-06 15:11:45.45953	2025-07-06 15:11:45.459531	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
640	growth	\N	\N	noun	3	0	3	2025-07-06 15:11:45.461619	2025-07-06 15:11:45.461621	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
641	guarantee	\N	\N	noun	5	0	4	2025-07-06 15:11:45.463524	2025-07-06 15:11:45.463526	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
642	guard	\N	\N	noun	3	0	2	2025-07-06 15:11:45.465534	2025-07-06 15:11:45.465536	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
643	guess	\N	\N	noun	3	0	2	2025-07-06 15:11:45.467545	2025-07-06 15:11:45.467547	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
644	guest	\N	\N	adjective	3	0	2	2025-07-06 15:11:45.469549	2025-07-06 15:11:45.469551	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
645	guidance	\N	\N	noun	4	0	4	2025-07-06 15:11:45.471544	2025-07-06 15:11:45.471546	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
646	guilt	\N	\N	noun	3	0	2	2025-07-06 15:11:45.473612	2025-07-06 15:11:45.473614	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
647	guilty	\N	\N	noun	3	0	3	2025-07-06 15:11:45.47556	2025-07-06 15:11:45.475562	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
648	guitar	\N	\N	noun	3	0	3	2025-07-06 15:11:45.477624	2025-07-06 15:11:45.477626	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
649	gym	\N	\N	noun	1	0	1	2025-07-06 15:11:45.479867	2025-07-06 15:11:45.479869	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
650	habit	\N	\N	noun	3	0	2	2025-07-06 15:11:45.482197	2025-07-06 15:11:45.482199	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
651	hair	\N	\N	noun	2	0	2	2025-07-06 15:11:45.484514	2025-07-06 15:11:45.484516	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
652	hall	\N	\N	noun	2	0	2	2025-07-06 15:11:45.486691	2025-07-06 15:11:45.486693	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
653	ham	\N	\N	noun	1	0	1	2025-07-06 15:11:45.489285	2025-07-06 15:11:45.489287	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
654	hamburger	\N	\N	adjective	5	0	4	2025-07-06 15:11:45.491702	2025-07-06 15:11:45.491704	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
655	hand	\N	\N	noun	2	0	2	2025-07-06 15:11:45.494248	2025-07-06 15:11:45.49425	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
656	handbag	\N	\N	noun	4	0	3	2025-07-06 15:11:45.496515	2025-07-06 15:11:45.496517	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
657	handwriting	\N	\N	verb	6	0	5	2025-07-06 15:11:45.498665	2025-07-06 15:11:45.498667	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
658	handy	\N	\N	noun	3	0	2	2025-07-06 15:11:45.50125	2025-07-06 15:11:45.501252	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
659	happily	\N	\N	adverb	4	0	3	2025-07-06 15:11:45.503155	2025-07-06 15:11:45.503157	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
660	happiness	\N	\N	noun	5	0	4	2025-07-06 15:11:45.505243	2025-07-06 15:11:45.505245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
661	happy	\N	\N	noun	3	0	2	2025-07-06 15:11:45.507239	2025-07-06 15:11:45.507241	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
662	harbor	\N	\N	noun	3	0	3	2025-07-06 15:11:45.509116	2025-07-06 15:11:45.509118	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
663	hard	\N	\N	noun	2	0	2	2025-07-06 15:11:45.511192	2025-07-06 15:11:45.511193	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
664	hardly	\N	\N	adverb	3	0	3	2025-07-06 15:11:45.513457	2025-07-06 15:11:45.513459	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
665	harmless	\N	\N	adjective	4	0	4	2025-07-06 15:11:45.515646	2025-07-06 15:11:45.515647	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
666	harvest	\N	\N	adjective	4	0	3	2025-07-06 15:11:45.518116	2025-07-06 15:11:45.518118	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
667	hat	\N	\N	noun	1	0	1	2025-07-06 15:11:45.52041	2025-07-06 15:11:45.520412	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
668	hate	\N	\N	noun	2	0	2	2025-07-06 15:11:45.522541	2025-07-06 15:11:45.522542	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
670	he	\N	\N	pronoun	1	0	1	2025-07-06 15:11:45.526668	2025-07-06 15:11:45.52667	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
671	head	\N	\N	noun	2	0	2	2025-07-06 15:11:45.528907	2025-07-06 15:11:45.528909	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
672	headline	\N	\N	noun	4	0	4	2025-07-06 15:11:45.531091	2025-07-06 15:11:45.531093	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
673	headquarters	\N	\N	noun	6	0	5	2025-07-06 15:11:45.533243	2025-07-06 15:11:45.533245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
674	health	\N	\N	noun	3	0	3	2025-07-06 15:11:45.535303	2025-07-06 15:11:45.535305	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
675	healthy	\N	\N	noun	4	0	3	2025-07-06 15:11:45.537286	2025-07-06 15:11:45.537288	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
676	hear	\N	\N	noun	2	0	2	2025-07-06 15:11:45.53912	2025-07-06 15:11:45.539122	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
677	hearing	\N	\N	verb	4	0	3	2025-07-06 15:11:45.541084	2025-07-06 15:11:45.541086	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
678	heart	\N	\N	noun	3	0	2	2025-07-06 15:11:45.543153	2025-07-06 15:11:45.543155	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
679	heat	\N	\N	noun	2	0	2	2025-07-06 15:11:45.545046	2025-07-06 15:11:45.545048	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
680	heaven	\N	\N	noun	3	0	3	2025-07-06 15:11:45.54687	2025-07-06 15:11:45.546871	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
681	height	\N	\N	noun	3	0	4	2025-07-06 15:11:45.548678	2025-07-06 15:11:45.54868	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
682	heir	\N	\N	noun	2	0	2	2025-07-06 15:11:45.55095	2025-07-06 15:11:45.550952	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
683	hello	\N	\N	noun	3	0	2	2025-07-06 15:11:45.552862	2025-07-06 15:11:45.552864	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
684	helmet	\N	\N	noun	3	0	3	2025-07-06 15:11:45.55484	2025-07-06 15:11:45.554841	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
685	help	\N	\N	noun	2	0	2	2025-07-06 15:11:45.556886	2025-07-06 15:11:45.556888	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
686	helpful	\N	\N	adjective	4	0	3	2025-07-06 15:11:45.559254	2025-07-06 15:11:45.559257	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
687	her	\N	\N	adjective	1	0	1	2025-07-06 15:11:45.561763	2025-07-06 15:11:45.561766	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
688	here	\N	\N	noun	2	0	2	2025-07-06 15:11:45.563993	2025-07-06 15:11:45.563995	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
689	hero	\N	\N	noun	2	0	2	2025-07-06 15:11:45.565992	2025-07-06 15:11:45.565994	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
690	hi	\N	\N	noun	1	0	1	2025-07-06 15:11:45.568436	2025-07-06 15:11:45.568439	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
691	hide	\N	\N	noun	2	0	2	2025-07-06 15:11:45.570747	2025-07-06 15:11:45.570749	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
693	highly	\N	\N	adverb	3	0	3	2025-07-06 15:11:45.574872	2025-07-06 15:11:45.574873	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
694	highway	\N	\N	noun	4	0	3	2025-07-06 15:11:45.576815	2025-07-06 15:11:45.576817	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
695	hill	\N	\N	noun	2	0	2	2025-07-06 15:11:45.57868	2025-07-06 15:11:45.578682	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
696	him	\N	\N	pronoun	1	0	1	2025-07-06 15:11:45.580597	2025-07-06 15:11:45.580599	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
697	hint	\N	\N	noun	2	0	2	2025-07-06 15:11:45.582664	2025-07-06 15:11:45.582666	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
698	hip	\N	\N	noun	1	0	1	2025-07-06 15:11:45.584615	2025-07-06 15:11:45.584617	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
699	hippo	\N	\N	noun	3	0	2	2025-07-06 15:11:45.586651	2025-07-06 15:11:45.586652	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
700	his	\N	\N	pronoun	1	0	1	2025-07-06 15:11:45.588592	2025-07-06 15:11:45.588594	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
702	hit	\N	\N	noun	1	0	1	2025-07-06 15:11:45.592584	2025-07-06 15:11:45.592586	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
703	hobby	\N	\N	noun	3	0	2	2025-07-06 15:11:45.594593	2025-07-06 15:11:45.594595	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
704	hold	\N	\N	noun	2	0	2	2025-07-06 15:11:45.596644	2025-07-06 15:11:45.596646	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
705	hole	\N	\N	noun	2	0	2	2025-07-06 15:11:45.598743	2025-07-06 15:11:45.598745	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
706	holiday	\N	\N	noun	4	0	3	2025-07-06 15:11:45.600747	2025-07-06 15:11:45.600749	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
707	home	\N	\N	noun	2	0	2	2025-07-06 15:11:45.603207	2025-07-06 15:11:45.603209	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
708	honest	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.605338	2025-07-06 15:11:45.60534	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
709	honestly	\N	\N	adverb	4	0	4	2025-07-06 15:11:45.607416	2025-07-06 15:11:45.607418	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
710	honey	\N	\N	noun	3	0	2	2025-07-06 15:11:45.609642	2025-07-06 15:11:45.609644	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
711	honor	\N	\N	noun	3	0	2	2025-07-06 15:11:45.611742	2025-07-06 15:11:45.611744	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
712	hook	\N	\N	noun	2	0	2	2025-07-06 15:11:45.613599	2025-07-06 15:11:45.6136	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
714	hopefully	\N	\N	adverb	5	0	4	2025-07-06 15:11:45.61818	2025-07-06 15:11:45.618182	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
715	horizon	\N	\N	noun	4	0	3	2025-07-06 15:11:45.620559	2025-07-06 15:11:45.620561	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
716	horse	\N	\N	noun	3	0	2	2025-07-06 15:11:45.624286	2025-07-06 15:11:45.624288	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
717	hospital	\N	\N	noun	4	0	4	2025-07-06 15:11:45.627004	2025-07-06 15:11:45.627006	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
718	host	\N	\N	noun	2	0	2	2025-07-06 15:11:45.62964	2025-07-06 15:11:45.629641	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
719	hostel	\N	\N	noun	3	0	3	2025-07-06 15:11:45.632264	2025-07-06 15:11:45.632266	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
720	hot	\N	\N	noun	1	0	1	2025-07-06 15:11:45.634181	2025-07-06 15:11:45.634183	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
722	hourly	\N	\N	adverb	3	0	3	2025-07-06 15:11:45.638395	2025-07-06 15:11:45.638397	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
723	house	\N	\N	noun	3	0	2	2025-07-06 15:11:45.640411	2025-07-06 15:11:45.640413	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
724	housework	\N	\N	noun	5	0	4	2025-07-06 15:11:45.642531	2025-07-06 15:11:45.642533	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
726	however	\N	\N	adjective	4	0	3	2025-07-06 15:11:45.64732	2025-07-06 15:11:45.647338	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
727	huge	\N	\N	noun	2	0	2	2025-07-06 15:11:45.649551	2025-07-06 15:11:45.649553	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
728	humanity	\N	\N	noun	4	0	4	2025-07-06 15:11:45.651647	2025-07-06 15:11:45.651649	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
729	hundred	\N	\N	verb	4	0	3	2025-07-06 15:11:45.653592	2025-07-06 15:11:45.653594	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
730	hunger	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.655582	2025-07-06 15:11:45.655584	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
731	hungry	\N	\N	noun	3	0	3	2025-07-06 15:11:45.657774	2025-07-06 15:11:45.657776	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
732	hunt	\N	\N	noun	2	0	2	2025-07-06 15:11:45.660311	2025-07-06 15:11:45.660313	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
733	hurry	\N	\N	noun	3	0	2	2025-07-06 15:11:45.662497	2025-07-06 15:11:45.662499	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
734	husband	\N	\N	noun	4	0	3	2025-07-06 15:11:45.664556	2025-07-06 15:11:45.664557	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
735	hut	\N	\N	noun	1	0	1	2025-07-06 15:11:45.666857	2025-07-06 15:11:45.666859	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
736	i	\N	\N	pronoun	1	0	1	2025-07-06 15:11:45.668792	2025-07-06 15:11:45.668793	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
737	ice	\N	\N	noun	1	0	1	2025-07-06 15:11:45.670651	2025-07-06 15:11:45.670669	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
738	idea	\N	\N	noun	2	0	2	2025-07-06 15:11:45.672622	2025-07-06 15:11:45.672624	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
739	ideal	\N	\N	noun	3	0	2	2025-07-06 15:11:45.674668	2025-07-06 15:11:45.67467	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
740	identity	\N	\N	noun	4	0	4	2025-07-06 15:11:45.676661	2025-07-06 15:11:45.676663	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
741	image	\N	\N	noun	3	0	2	2025-07-06 15:11:45.678818	2025-07-06 15:11:45.678836	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
742	imagination	\N	\N	noun	6	0	4	2025-07-06 15:11:45.680873	2025-07-06 15:11:45.680875	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
743	imagine	\N	\N	noun	4	0	3	2025-07-06 15:11:45.684115	2025-07-06 15:11:45.684118	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
744	immediately	\N	\N	adverb	6	0	5	2025-07-06 15:11:45.68621	2025-07-06 15:11:45.686212	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
745	impact	\N	\N	noun	3	0	3	2025-07-06 15:11:45.688086	2025-07-06 15:11:45.688088	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
746	importance	\N	\N	noun	5	0	5	2025-07-06 15:11:45.690103	2025-07-06 15:11:45.690105	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
747	important	\N	\N	noun	5	0	4	2025-07-06 15:11:45.69204	2025-07-06 15:11:45.692042	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
748	impress	\N	\N	noun	4	0	3	2025-07-06 15:11:45.693904	2025-07-06 15:11:45.693906	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
749	impression	\N	\N	noun	5	0	4	2025-07-06 15:11:45.695862	2025-07-06 15:11:45.695864	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
750	improvement	\N	\N	noun	6	0	5	2025-07-06 15:11:45.697874	2025-07-06 15:11:45.697875	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
751	in	\N	\N	preposition	1	0	1	2025-07-06 15:11:45.700046	2025-07-06 15:11:45.700048	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
752	incident	\N	\N	noun	4	0	4	2025-07-06 15:11:45.702146	2025-07-06 15:11:45.702148	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
753	include	\N	\N	noun	4	0	3	2025-07-06 15:11:45.704103	2025-07-06 15:11:45.704105	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
754	income	\N	\N	noun	3	0	3	2025-07-06 15:11:45.706053	2025-07-06 15:11:45.706055	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
755	indeed	\N	\N	verb	3	0	3	2025-07-06 15:11:45.708102	2025-07-06 15:11:45.708103	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
756	independence	\N	\N	noun	6	0	5	2025-07-06 15:11:45.710078	2025-07-06 15:11:45.71008	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
757	index	\N	\N	noun	3	0	2	2025-07-06 15:11:45.71215	2025-07-06 15:11:45.712152	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
758	indication	\N	\N	noun	5	0	4	2025-07-06 15:11:45.714319	2025-07-06 15:11:45.714321	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
759	individual	\N	\N	noun	5	0	5	2025-07-06 15:11:45.716716	2025-07-06 15:11:45.716718	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
760	industry	\N	\N	noun	4	0	4	2025-07-06 15:11:45.719249	2025-07-06 15:11:45.719252	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
761	influence	\N	\N	noun	5	0	4	2025-07-06 15:11:45.721814	2025-07-06 15:11:45.721816	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
762	information	\N	\N	noun	6	0	4	2025-07-06 15:11:45.724393	2025-07-06 15:11:45.724395	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
763	ingredient	\N	\N	noun	5	0	5	2025-07-06 15:11:45.726705	2025-07-06 15:11:45.726708	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
764	injury	\N	\N	noun	3	0	3	2025-07-06 15:11:45.728877	2025-07-06 15:11:45.728879	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
765	innocent	\N	\N	noun	4	0	4	2025-07-06 15:11:45.730814	2025-07-06 15:11:45.730816	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
766	input	\N	\N	noun	3	0	2	2025-07-06 15:11:45.732849	2025-07-06 15:11:45.732851	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
767	insect	\N	\N	noun	3	0	3	2025-07-06 15:11:45.734865	2025-07-06 15:11:45.734883	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
769	insight	\N	\N	noun	4	0	4	2025-07-06 15:11:45.738869	2025-07-06 15:11:45.738871	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
770	inspiration	\N	\N	noun	6	0	4	2025-07-06 15:11:45.740759	2025-07-06 15:11:45.740761	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
771	instantly	\N	\N	adverb	5	0	4	2025-07-06 15:11:45.742601	2025-07-06 15:11:45.742602	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
772	instead	\N	\N	noun	4	0	3	2025-07-06 15:11:45.74458	2025-07-06 15:11:45.744581	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
773	instruction	\N	\N	noun	6	0	4	2025-07-06 15:11:45.746526	2025-07-06 15:11:45.746528	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
774	instrument	\N	\N	noun	5	0	5	2025-07-06 15:11:45.748469	2025-07-06 15:11:45.748471	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
775	insult	\N	\N	noun	3	0	3	2025-07-06 15:11:45.750956	2025-07-06 15:11:45.750958	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
776	insurance	\N	\N	noun	5	0	4	2025-07-06 15:11:45.753104	2025-07-06 15:11:45.753106	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
777	intelligence	\N	\N	noun	6	0	5	2025-07-06 15:11:45.755156	2025-07-06 15:11:45.755158	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
778	intelligent	\N	\N	noun	6	0	5	2025-07-06 15:11:45.757098	2025-07-06 15:11:45.7571	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
779	intention	\N	\N	noun	5	0	4	2025-07-06 15:11:45.759089	2025-07-06 15:11:45.75909	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
780	interest	\N	\N	adjective	4	0	4	2025-07-06 15:11:45.76096	2025-07-06 15:11:45.760962	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
782	interference	\N	\N	noun	6	0	5	2025-07-06 15:11:45.764633	2025-07-06 15:11:45.764635	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
783	interior	\N	\N	noun	4	0	4	2025-07-06 15:11:45.766603	2025-07-06 15:11:45.766605	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
784	introduction	\N	\N	noun	6	0	4	2025-07-06 15:11:45.768638	2025-07-06 15:11:45.76864	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
785	invent	\N	\N	noun	3	0	3	2025-07-06 15:11:45.770705	2025-07-06 15:11:45.770707	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
786	invention	\N	\N	noun	5	0	4	2025-07-06 15:11:45.772744	2025-07-06 15:11:45.772746	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
787	investigation	\N	\N	noun	6	0	4	2025-07-06 15:11:45.774664	2025-07-06 15:11:45.774666	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
788	investment	\N	\N	noun	5	0	5	2025-07-06 15:11:45.776653	2025-07-06 15:11:45.776654	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
790	invite	\N	\N	noun	3	0	3	2025-07-06 15:11:45.780577	2025-07-06 15:11:45.780578	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
791	is	\N	\N	noun	1	0	1	2025-07-06 15:11:45.782656	2025-07-06 15:11:45.782658	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
792	island	\N	\N	noun	3	0	3	2025-07-06 15:11:45.784894	2025-07-06 15:11:45.784896	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
793	issue	\N	\N	noun	3	0	2	2025-07-06 15:11:45.786774	2025-07-06 15:11:45.786776	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
794	it	\N	\N	pronoun	1	0	1	2025-07-06 15:11:45.789023	2025-07-06 15:11:45.789025	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
795	item	\N	\N	noun	2	0	2	2025-07-06 15:11:45.791301	2025-07-06 15:11:45.791303	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
796	its	\N	\N	pronoun	1	0	1	2025-07-06 15:11:45.793311	2025-07-06 15:11:45.793313	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
797	jacket	\N	\N	noun	3	0	3	2025-07-06 15:11:45.795237	2025-07-06 15:11:45.795239	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
798	jam	\N	\N	noun	1	0	1	2025-07-06 15:11:45.797454	2025-07-06 15:11:45.797456	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
799	jar	\N	\N	noun	1	0	1	2025-07-06 15:11:45.799669	2025-07-06 15:11:45.799671	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
800	jaw	\N	\N	noun	1	0	1	2025-07-06 15:11:45.80184	2025-07-06 15:11:45.801842	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
801	jazz	\N	\N	noun	2	0	2	2025-07-06 15:11:45.804093	2025-07-06 15:11:45.804095	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
802	jeans	\N	\N	noun	3	0	2	2025-07-06 15:11:45.806147	2025-07-06 15:11:45.806148	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
803	jelly	\N	\N	adverb	3	0	2	2025-07-06 15:11:45.80816	2025-07-06 15:11:45.808162	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
804	jewel	\N	\N	noun	3	0	2	2025-07-06 15:11:45.810066	2025-07-06 15:11:45.810068	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
805	job	\N	\N	noun	1	0	1	2025-07-06 15:11:45.811956	2025-07-06 15:11:45.811957	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
806	join	\N	\N	noun	2	0	2	2025-07-06 15:11:45.814048	2025-07-06 15:11:45.814049	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
807	joint	\N	\N	noun	3	0	2	2025-07-06 15:11:45.815989	2025-07-06 15:11:45.815991	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
809	journey	\N	\N	noun	4	0	3	2025-07-06 15:11:45.820218	2025-07-06 15:11:45.82022	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
810	joy	\N	\N	noun	1	0	1	2025-07-06 15:11:45.822214	2025-07-06 15:11:45.822232	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
811	judge	\N	\N	noun	3	0	2	2025-07-06 15:11:45.824307	2025-07-06 15:11:45.824309	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
812	judgment	\N	\N	noun	4	0	4	2025-07-06 15:11:45.826232	2025-07-06 15:11:45.826234	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
813	juice	\N	\N	noun	3	0	2	2025-07-06 15:11:45.82844	2025-07-06 15:11:45.828442	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
814	jump	\N	\N	noun	2	0	2	2025-07-06 15:11:45.830683	2025-07-06 15:11:45.830685	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
815	junction	\N	\N	noun	4	0	4	2025-07-06 15:11:45.832792	2025-07-06 15:11:45.832794	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
816	junior	\N	\N	noun	3	0	3	2025-07-06 15:11:45.837006	2025-07-06 15:11:45.837008	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
817	justice	\N	\N	noun	4	0	3	2025-07-06 15:11:45.839895	2025-07-06 15:11:45.839897	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
818	justification	\N	\N	noun	6	0	4	2025-07-06 15:11:45.842795	2025-07-06 15:11:45.842797	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
819	kangaroo	\N	\N	noun	4	0	4	2025-07-06 15:11:45.84533	2025-07-06 15:11:45.845332	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
820	keen	\N	\N	noun	2	0	2	2025-07-06 15:11:45.847384	2025-07-06 15:11:45.847386	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
821	keep	\N	\N	noun	2	0	2	2025-07-06 15:11:45.850048	2025-07-06 15:11:45.85005	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
822	key	\N	\N	noun	1	0	1	2025-07-06 15:11:45.852112	2025-07-06 15:11:45.852114	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
823	keyboard	\N	\N	noun	4	0	4	2025-07-06 15:11:45.853934	2025-07-06 15:11:45.853936	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
824	kick	\N	\N	noun	2	0	2	2025-07-06 15:11:45.85595	2025-07-06 15:11:45.855952	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
825	kid	\N	\N	noun	1	0	1	2025-07-06 15:11:45.85813	2025-07-06 15:11:45.858132	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
826	kill	\N	\N	noun	2	0	2	2025-07-06 15:11:45.860268	2025-07-06 15:11:45.860269	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
828	kingdom	\N	\N	noun	4	0	3	2025-07-06 15:11:45.864075	2025-07-06 15:11:45.864077	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
829	kiss	\N	\N	noun	2	0	2	2025-07-06 15:11:45.866017	2025-07-06 15:11:45.866019	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
830	kitchen	\N	\N	noun	4	0	3	2025-07-06 15:11:45.868187	2025-07-06 15:11:45.868189	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
831	kite	\N	\N	noun	2	0	2	2025-07-06 15:11:45.870257	2025-07-06 15:11:45.870259	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
832	knee	\N	\N	noun	2	0	2	2025-07-06 15:11:45.872222	2025-07-06 15:11:45.872224	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
833	knife	\N	\N	noun	3	0	2	2025-07-06 15:11:45.874094	2025-07-06 15:11:45.874096	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
834	knock	\N	\N	noun	3	0	2	2025-07-06 15:11:45.876022	2025-07-06 15:11:45.876024	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
835	know	\N	\N	noun	2	0	2	2025-07-06 15:11:45.878102	2025-07-06 15:11:45.878104	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
836	knowledge	\N	\N	noun	5	0	4	2025-07-06 15:11:45.880326	2025-07-06 15:11:45.880328	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
837	known	\N	\N	noun	3	0	2	2025-07-06 15:11:45.883039	2025-07-06 15:11:45.88304	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
838	koala	\N	\N	noun	3	0	2	2025-07-06 15:11:45.885214	2025-07-06 15:11:45.885216	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
839	label	\N	\N	noun	3	0	2	2025-07-06 15:11:45.887174	2025-07-06 15:11:45.887176	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
840	labor	\N	\N	noun	3	0	2	2025-07-06 15:11:45.889014	2025-07-06 15:11:45.889016	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
841	laboratory	\N	\N	noun	5	0	5	2025-07-06 15:11:45.891154	2025-07-06 15:11:45.891156	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
842	lace	\N	\N	noun	2	0	2	2025-07-06 15:11:45.893125	2025-07-06 15:11:45.893127	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
843	lack	\N	\N	noun	2	0	2	2025-07-06 15:11:45.895081	2025-07-06 15:11:45.895083	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
844	lady	\N	\N	noun	2	0	2	2025-07-06 15:11:45.897022	2025-07-06 15:11:45.897023	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
845	ladybug	\N	\N	noun	4	0	3	2025-07-06 15:11:45.899126	2025-07-06 15:11:45.899128	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
846	lake	\N	\N	noun	2	0	2	2025-07-06 15:11:45.901225	2025-07-06 15:11:45.901227	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
847	lamp	\N	\N	noun	2	0	2	2025-07-06 15:11:45.903128	2025-07-06 15:11:45.90313	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
848	land	\N	\N	noun	2	0	2	2025-07-06 15:11:45.905089	2025-07-06 15:11:45.905091	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
849	landing	\N	\N	verb	4	0	3	2025-07-06 15:11:45.906952	2025-07-06 15:11:45.906954	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
850	lane	\N	\N	noun	2	0	2	2025-07-06 15:11:45.9089	2025-07-06 15:11:45.908902	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
851	language	\N	\N	noun	4	0	4	2025-07-06 15:11:45.91079	2025-07-06 15:11:45.910792	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
852	lap	\N	\N	noun	1	0	1	2025-07-06 15:11:45.912633	2025-07-06 15:11:45.912635	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
853	large	\N	\N	noun	3	0	2	2025-07-06 15:11:45.914829	2025-07-06 15:11:45.914831	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
854	laser	\N	\N	adjective	3	0	2	2025-07-06 15:11:45.917062	2025-07-06 15:11:45.917064	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
855	late	\N	\N	noun	2	0	2	2025-07-06 15:11:45.919076	2025-07-06 15:11:45.919078	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
856	lately	\N	\N	adverb	3	0	3	2025-07-06 15:11:45.921156	2025-07-06 15:11:45.921157	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
857	laugh	\N	\N	noun	3	0	4	2025-07-06 15:11:45.923255	2025-07-06 15:11:45.923257	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
858	launching	\N	\N	verb	5	0	4	2025-07-06 15:11:45.925221	2025-07-06 15:11:45.925222	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
859	law	\N	\N	noun	1	0	1	2025-07-06 15:11:45.92729	2025-07-06 15:11:45.927292	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
860	lawn	\N	\N	noun	2	0	2	2025-07-06 15:11:45.929192	2025-07-06 15:11:45.929194	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
861	lawyer	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.931616	2025-07-06 15:11:45.931618	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
862	layer	\N	\N	adjective	3	0	2	2025-07-06 15:11:45.933878	2025-07-06 15:11:45.933879	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
863	lazy	\N	\N	noun	2	0	2	2025-07-06 15:11:45.935961	2025-07-06 15:11:45.935963	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
864	leader	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.938066	2025-07-06 15:11:45.938068	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
865	leadership	\N	\N	noun	5	0	5	2025-07-06 15:11:45.940082	2025-07-06 15:11:45.940084	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
866	leaf	\N	\N	noun	2	0	2	2025-07-06 15:11:45.942146	2025-07-06 15:11:45.942148	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
867	league	\N	\N	noun	3	0	3	2025-07-06 15:11:45.944119	2025-07-06 15:11:45.944121	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
868	learn	\N	\N	noun	3	0	2	2025-07-06 15:11:45.946233	2025-07-06 15:11:45.946235	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
869	learning	\N	\N	verb	4	0	4	2025-07-06 15:11:45.948203	2025-07-06 15:11:45.948205	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
870	leather	\N	\N	adjective	4	0	3	2025-07-06 15:11:45.95068	2025-07-06 15:11:45.950683	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
872	lecture	\N	\N	noun	4	0	3	2025-07-06 15:11:45.955212	2025-07-06 15:11:45.955214	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
873	left	\N	\N	noun	2	0	2	2025-07-06 15:11:45.957589	2025-07-06 15:11:45.957592	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
874	leg	\N	\N	noun	1	0	1	2025-07-06 15:11:45.959932	2025-07-06 15:11:45.959934	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
875	legal	\N	\N	noun	3	0	2	2025-07-06 15:11:45.962032	2025-07-06 15:11:45.962034	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
876	legend	\N	\N	noun	3	0	3	2025-07-06 15:11:45.9647	2025-07-06 15:11:45.964702	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
877	leisure	\N	\N	noun	4	0	3	2025-07-06 15:11:45.967111	2025-07-06 15:11:45.967114	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
878	lemon	\N	\N	noun	3	0	2	2025-07-06 15:11:45.969276	2025-07-06 15:11:45.969278	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
879	lend	\N	\N	noun	2	0	2	2025-07-06 15:11:45.971484	2025-07-06 15:11:45.971486	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
880	length	\N	\N	noun	3	0	3	2025-07-06 15:11:45.973466	2025-07-06 15:11:45.973468	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
881	lens	\N	\N	noun	2	0	2	2025-07-06 15:11:45.975464	2025-07-06 15:11:45.975466	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
882	leopard	\N	\N	noun	4	0	3	2025-07-06 15:11:45.977359	2025-07-06 15:11:45.977361	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
883	lesson	\N	\N	noun	3	0	3	2025-07-06 15:11:45.97921	2025-07-06 15:11:45.979212	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
885	letter	\N	\N	adjective	3	0	3	2025-07-06 15:11:45.983107	2025-07-06 15:11:45.983108	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
886	level	\N	\N	noun	3	0	2	2025-07-06 15:11:45.985326	2025-07-06 15:11:45.985328	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
887	library	\N	\N	noun	4	0	3	2025-07-06 15:11:45.987472	2025-07-06 15:11:45.987474	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
888	license	\N	\N	noun	4	0	3	2025-07-06 15:11:45.989393	2025-07-06 15:11:45.989395	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
889	lid	\N	\N	noun	1	0	1	2025-07-06 15:11:45.991343	2025-07-06 15:11:45.991345	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
890	life	\N	\N	noun	2	0	2	2025-07-06 15:11:45.99365	2025-07-06 15:11:45.993653	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
891	lifetime	\N	\N	noun	4	0	4	2025-07-06 15:11:45.996097	2025-07-06 15:11:45.996099	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
893	lightly	\N	\N	adverb	4	0	4	2025-07-06 15:11:46.000815	2025-07-06 15:11:46.000817	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
894	lightning	\N	\N	verb	5	0	4	2025-07-06 15:11:46.002929	2025-07-06 15:11:46.00293	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
895	like	\N	\N	noun	1	0	2	2025-07-06 15:11:46.004999	2025-07-06 15:11:46.005001	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
896	likelihood	\N	\N	noun	5	0	5	2025-07-06 15:11:46.00722	2025-07-06 15:11:46.007222	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
897	likely	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.009253	2025-07-06 15:11:46.009255	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
898	limit	\N	\N	noun	3	0	2	2025-07-06 15:11:46.01132	2025-07-06 15:11:46.011321	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
900	linen	\N	\N	noun	3	0	2	2025-07-06 15:11:46.015359	2025-07-06 15:11:46.015361	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
901	link	\N	\N	noun	2	0	2	2025-07-06 15:11:46.017538	2025-07-06 15:11:46.01754	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
902	lion	\N	\N	noun	2	0	2	2025-07-06 15:11:46.019778	2025-07-06 15:11:46.01978	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
903	lip	\N	\N	noun	1	0	1	2025-07-06 15:11:46.021939	2025-07-06 15:11:46.021941	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
904	liquid	\N	\N	noun	3	0	3	2025-07-06 15:11:46.023734	2025-07-06 15:11:46.023736	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
905	list	\N	\N	noun	2	0	2	2025-07-06 15:11:46.025691	2025-07-06 15:11:46.025693	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
906	listen	\N	\N	noun	3	0	3	2025-07-06 15:11:46.027723	2025-07-06 15:11:46.027725	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
907	listener	\N	\N	adjective	4	0	4	2025-07-06 15:11:46.029853	2025-07-06 15:11:46.029854	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
908	literacy	\N	\N	noun	4	0	4	2025-07-06 15:11:46.03278	2025-07-06 15:11:46.032782	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
909	literature	\N	\N	noun	5	0	5	2025-07-06 15:11:46.034996	2025-07-06 15:11:46.034998	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
910	little	\N	\N	noun	3	0	3	2025-07-06 15:11:46.036943	2025-07-06 15:11:46.036945	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
911	live	\N	\N	adjective	2	0	2	2025-07-06 15:11:46.038872	2025-07-06 15:11:46.038874	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
912	lively	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.040772	2025-07-06 15:11:46.040774	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
913	living	\N	\N	verb	3	0	3	2025-07-06 15:11:46.042669	2025-07-06 15:11:46.042671	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
914	lizard	\N	\N	noun	3	0	3	2025-07-06 15:11:46.044852	2025-07-06 15:11:46.044854	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
915	load	\N	\N	noun	2	0	2	2025-07-06 15:11:46.046642	2025-07-06 15:11:46.046644	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
916	loan	\N	\N	noun	2	0	2	2025-07-06 15:11:46.050204	2025-07-06 15:11:46.050206	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
917	local	\N	\N	noun	3	0	2	2025-07-06 15:11:46.053404	2025-07-06 15:11:46.053406	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
918	location	\N	\N	noun	4	0	4	2025-07-06 15:11:46.05611	2025-07-06 15:11:46.056112	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
919	lock	\N	\N	noun	2	0	2	2025-07-06 15:11:46.058684	2025-07-06 15:11:46.058686	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
920	log	\N	\N	noun	1	0	1	2025-07-06 15:11:46.060649	2025-07-06 15:11:46.060651	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
921	logic	\N	\N	noun	3	0	2	2025-07-06 15:11:46.062567	2025-07-06 15:11:46.062569	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
922	lollipop	\N	\N	noun	4	0	4	2025-07-06 15:11:46.064525	2025-07-06 15:11:46.064527	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
923	loneliness	\N	\N	noun	5	0	5	2025-07-06 15:11:46.066475	2025-07-06 15:11:46.066477	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
924	lonely	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.06915	2025-07-06 15:11:46.069152	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
925	long	\N	\N	noun	1	0	2	2025-07-06 15:11:46.071205	2025-07-06 15:11:46.071207	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
926	look	\N	\N	noun	2	0	2	2025-07-06 15:11:46.073291	2025-07-06 15:11:46.073293	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
927	loose	\N	\N	noun	3	0	2	2025-07-06 15:11:46.075403	2025-07-06 15:11:46.075406	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
928	lord	\N	\N	noun	2	0	2	2025-07-06 15:11:46.077496	2025-07-06 15:11:46.077498	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
929	lose	\N	\N	noun	2	0	2	2025-07-06 15:11:46.079703	2025-07-06 15:11:46.079706	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
930	loss	\N	\N	noun	2	0	2	2025-07-06 15:11:46.082011	2025-07-06 15:11:46.082013	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
931	lot	\N	\N	noun	1	0	1	2025-07-06 15:11:46.084823	2025-07-06 15:11:46.084826	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
932	lotion	\N	\N	noun	3	0	4	2025-07-06 15:11:46.087613	2025-07-06 15:11:46.087616	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
933	lottery	\N	\N	noun	4	0	3	2025-07-06 15:11:46.090316	2025-07-06 15:11:46.09032	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
934	loud	\N	\N	noun	2	0	2	2025-07-06 15:11:46.092815	2025-07-06 15:11:46.092818	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
935	loudly	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.095135	2025-07-06 15:11:46.095137	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
936	lounge	\N	\N	noun	3	0	3	2025-07-06 15:11:46.097491	2025-07-06 15:11:46.097493	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
937	love	\N	\N	noun	2	0	2	2025-07-06 15:11:46.099825	2025-07-06 15:11:46.099827	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
938	lovely	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.102307	2025-07-06 15:11:46.102309	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
939	lover	\N	\N	adjective	3	0	2	2025-07-06 15:11:46.104542	2025-07-06 15:11:46.104544	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
940	low	\N	\N	noun	1	0	1	2025-07-06 15:11:46.106804	2025-07-06 15:11:46.106806	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
941	loyal	\N	\N	noun	3	0	2	2025-07-06 15:11:46.109093	2025-07-06 15:11:46.109095	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
942	loyalty	\N	\N	noun	4	0	3	2025-07-06 15:11:46.111348	2025-07-06 15:11:46.11135	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
943	luck	\N	\N	noun	2	0	2	2025-07-06 15:11:46.11358	2025-07-06 15:11:46.113582	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
944	luckily	\N	\N	adverb	4	0	3	2025-07-06 15:11:46.115812	2025-07-06 15:11:46.115813	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
945	lucky	\N	\N	noun	3	0	2	2025-07-06 15:11:46.118357	2025-07-06 15:11:46.118359	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
946	luggage	\N	\N	noun	4	0	3	2025-07-06 15:11:46.121024	2025-07-06 15:11:46.121026	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
947	lunch	\N	\N	noun	3	0	2	2025-07-06 15:11:46.123248	2025-07-06 15:11:46.12325	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
948	lung	\N	\N	noun	2	0	2	2025-07-06 15:11:46.125724	2025-07-06 15:11:46.125726	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
949	luxury	\N	\N	noun	3	0	3	2025-07-06 15:11:46.128483	2025-07-06 15:11:46.128485	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
950	machine	\N	\N	noun	4	0	3	2025-07-06 15:11:46.131029	2025-07-06 15:11:46.131031	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
951	machinery	\N	\N	noun	5	0	4	2025-07-06 15:11:46.134194	2025-07-06 15:11:46.134197	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
952	magazine	\N	\N	noun	4	0	4	2025-07-06 15:11:46.136595	2025-07-06 15:11:46.136598	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
953	magic	\N	\N	noun	3	0	2	2025-07-06 15:11:46.138915	2025-07-06 15:11:46.138917	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
954	mail	\N	\N	noun	2	0	2	2025-07-06 15:11:46.141328	2025-07-06 15:11:46.14133	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
955	main	\N	\N	noun	2	0	2	2025-07-06 15:11:46.143569	2025-07-06 15:11:46.143571	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
956	mainland	\N	\N	noun	4	0	4	2025-07-06 15:11:46.145841	2025-07-06 15:11:46.145843	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
957	mainly	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.148129	2025-07-06 15:11:46.148131	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
958	majority	\N	\N	noun	4	0	4	2025-07-06 15:11:46.150466	2025-07-06 15:11:46.150468	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
959	make	\N	\N	noun	1	0	2	2025-07-06 15:11:46.153185	2025-07-06 15:11:46.153187	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
960	mall	\N	\N	noun	2	0	2	2025-07-06 15:11:46.155545	2025-07-06 15:11:46.155567	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
961	man	\N	\N	noun	1	0	1	2025-07-06 15:11:46.15789	2025-07-06 15:11:46.157892	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
962	manage	\N	\N	noun	3	0	3	2025-07-06 15:11:46.160039	2025-07-06 15:11:46.16004	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
963	management	\N	\N	noun	5	0	5	2025-07-06 15:11:46.162384	2025-07-06 15:11:46.162386	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
964	manager	\N	\N	adjective	4	0	3	2025-07-06 15:11:46.164753	2025-07-06 15:11:46.164755	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
965	mango	\N	\N	noun	3	0	2	2025-07-06 15:11:46.167276	2025-07-06 15:11:46.167278	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
966	mankind	\N	\N	noun	4	0	3	2025-07-06 15:11:46.169399	2025-07-06 15:11:46.169401	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
967	manner	\N	\N	adjective	3	0	3	2025-07-06 15:11:46.171485	2025-07-06 15:11:46.171487	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
968	mansion	\N	\N	noun	4	0	4	2025-07-06 15:11:46.173628	2025-07-06 15:11:46.17363	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
969	manual	\N	\N	noun	3	0	3	2025-07-06 15:11:46.175847	2025-07-06 15:11:46.175849	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
970	manufacture	\N	\N	noun	6	0	5	2025-07-06 15:11:46.177824	2025-07-06 15:11:46.177826	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
971	map	\N	\N	noun	1	0	1	2025-07-06 15:11:46.180595	2025-07-06 15:11:46.180597	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
972	marathon	\N	\N	noun	4	0	4	2025-07-06 15:11:46.182699	2025-07-06 15:11:46.182701	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
973	marble	\N	\N	noun	3	0	3	2025-07-06 15:11:46.184762	2025-07-06 15:11:46.184764	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
974	march	\N	\N	noun	3	0	2	2025-07-06 15:11:46.186823	2025-07-06 15:11:46.186824	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
975	mark	\N	\N	noun	2	0	2	2025-07-06 15:11:46.18888	2025-07-06 15:11:46.188881	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
976	market	\N	\N	noun	3	0	3	2025-07-06 15:11:46.191146	2025-07-06 15:11:46.191148	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
977	marketing	\N	\N	verb	5	0	4	2025-07-06 15:11:46.193108	2025-07-06 15:11:46.193109	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
978	marriage	\N	\N	noun	4	0	4	2025-07-06 15:11:46.195088	2025-07-06 15:11:46.19509	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
979	marry	\N	\N	noun	3	0	2	2025-07-06 15:11:46.197183	2025-07-06 15:11:46.197185	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
981	mass	\N	\N	noun	2	0	2	2025-07-06 15:11:46.202045	2025-07-06 15:11:46.202047	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
982	master	\N	\N	adjective	3	0	3	2025-07-06 15:11:46.204468	2025-07-06 15:11:46.20447	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
983	match	\N	\N	noun	3	0	2	2025-07-06 15:11:46.206841	2025-07-06 15:11:46.206844	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
984	material	\N	\N	noun	4	0	4	2025-07-06 15:11:46.209658	2025-07-06 15:11:46.209661	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
985	math	\N	\N	noun	2	0	2	2025-07-06 15:11:46.211887	2025-07-06 15:11:46.211889	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
986	matter	\N	\N	adjective	3	0	3	2025-07-06 15:11:46.214241	2025-07-06 15:11:46.214243	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
987	mature	\N	\N	noun	3	0	3	2025-07-06 15:11:46.216687	2025-07-06 15:11:46.216689	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
988	maximum	\N	\N	noun	4	0	3	2025-07-06 15:11:46.219344	2025-07-06 15:11:46.219346	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
989	mayor	\N	\N	noun	3	0	2	2025-07-06 15:11:46.221523	2025-07-06 15:11:46.221526	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
990	maze	\N	\N	noun	2	0	2	2025-07-06 15:11:46.224095	2025-07-06 15:11:46.224097	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
991	me	\N	\N	pronoun	1	0	1	2025-07-06 15:11:46.226332	2025-07-06 15:11:46.226334	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
992	meadow	\N	\N	noun	3	0	3	2025-07-06 15:11:46.22834	2025-07-06 15:11:46.228341	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
993	meal	\N	\N	noun	2	0	2	2025-07-06 15:11:46.230646	2025-07-06 15:11:46.230648	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
994	mean	\N	\N	noun	2	0	2	2025-07-06 15:11:46.232771	2025-07-06 15:11:46.232773	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
995	meaning	\N	\N	verb	4	0	3	2025-07-06 15:11:46.235326	2025-07-06 15:11:46.235328	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
996	measure	\N	\N	noun	4	0	3	2025-07-06 15:11:46.237419	2025-07-06 15:11:46.237421	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
997	meat	\N	\N	noun	2	0	2	2025-07-06 15:11:46.239579	2025-07-06 15:11:46.239581	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
998	mechanism	\N	\N	noun	5	0	4	2025-07-06 15:11:46.241697	2025-07-06 15:11:46.241699	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
999	medal	\N	\N	noun	3	0	2	2025-07-06 15:11:46.243776	2025-07-06 15:11:46.243778	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1000	media	\N	\N	noun	3	0	2	2025-07-06 15:11:46.245924	2025-07-06 15:11:46.245926	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1001	medical	\N	\N	noun	4	0	3	2025-07-06 15:11:46.247954	2025-07-06 15:11:46.247956	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1002	medicine	\N	\N	noun	4	0	4	2025-07-06 15:11:46.250247	2025-07-06 15:11:46.250249	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1003	medium	\N	\N	noun	3	0	3	2025-07-06 15:11:46.252432	2025-07-06 15:11:46.252434	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1004	meet	\N	\N	noun	2	0	2	2025-07-06 15:11:46.25484	2025-07-06 15:11:46.254843	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1005	meeting	\N	\N	verb	4	0	3	2025-07-06 15:11:46.257352	2025-07-06 15:11:46.257354	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1006	melody	\N	\N	noun	3	0	3	2025-07-06 15:11:46.259528	2025-07-06 15:11:46.25953	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1007	member	\N	\N	adjective	3	0	3	2025-07-06 15:11:46.261766	2025-07-06 15:11:46.261768	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1008	membership	\N	\N	noun	5	0	5	2025-07-06 15:11:46.263999	2025-07-06 15:11:46.264001	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1009	memory	\N	\N	noun	3	0	3	2025-07-06 15:11:46.266134	2025-07-06 15:11:46.266136	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1010	mend	\N	\N	noun	2	0	2	2025-07-06 15:11:46.268233	2025-07-06 15:11:46.268235	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1011	mental	\N	\N	noun	3	0	3	2025-07-06 15:11:46.270788	2025-07-06 15:11:46.27079	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1012	mention	\N	\N	noun	4	0	4	2025-07-06 15:11:46.272911	2025-07-06 15:11:46.272913	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1013	menu	\N	\N	noun	2	0	2	2025-07-06 15:11:46.275067	2025-07-06 15:11:46.275069	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1014	mercy	\N	\N	noun	3	0	2	2025-07-06 15:11:46.27731	2025-07-06 15:11:46.277312	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1015	mere	\N	\N	noun	2	0	2	2025-07-06 15:11:46.279518	2025-07-06 15:11:46.27952	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1016	merely	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.283837	2025-07-06 15:11:46.283839	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1017	merit	\N	\N	noun	3	0	2	2025-07-06 15:11:46.286918	2025-07-06 15:11:46.28692	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1018	mess	\N	\N	noun	2	0	2	2025-07-06 15:11:46.289256	2025-07-06 15:11:46.289258	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1019	message	\N	\N	noun	4	0	3	2025-07-06 15:11:46.292777	2025-07-06 15:11:46.292779	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1020	messy	\N	\N	noun	3	0	2	2025-07-06 15:11:46.295903	2025-07-06 15:11:46.295905	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1021	metal	\N	\N	noun	3	0	2	2025-07-06 15:11:46.297925	2025-07-06 15:11:46.297926	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1022	method	\N	\N	noun	3	0	3	2025-07-06 15:11:46.299906	2025-07-06 15:11:46.299908	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1023	mild	\N	\N	noun	2	0	2	2025-07-06 15:11:46.302277	2025-07-06 15:11:46.302279	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1024	mile	\N	\N	noun	2	0	2	2025-07-06 15:11:46.304376	2025-07-06 15:11:46.304378	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1025	military	\N	\N	noun	4	0	4	2025-07-06 15:11:46.306339	2025-07-06 15:11:46.30634	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1026	milk	\N	\N	noun	2	0	2	2025-07-06 15:11:46.308297	2025-07-06 15:11:46.308299	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1027	million	\N	\N	noun	4	0	3	2025-07-06 15:11:46.310327	2025-07-06 15:11:46.310328	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1028	mind	\N	\N	noun	2	0	2	2025-07-06 15:11:46.312512	2025-07-06 15:11:46.312514	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1030	mineral	\N	\N	noun	4	0	3	2025-07-06 15:11:46.316813	2025-07-06 15:11:46.316815	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1031	minister	\N	\N	adjective	4	0	4	2025-07-06 15:11:46.318923	2025-07-06 15:11:46.318925	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1032	minority	\N	\N	noun	4	0	4	2025-07-06 15:11:46.320866	2025-07-06 15:11:46.320868	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1033	mirror	\N	\N	noun	3	0	3	2025-07-06 15:11:46.322915	2025-07-06 15:11:46.322917	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1034	miserable	\N	\N	adjective	5	0	4	2025-07-06 15:11:46.324875	2025-07-06 15:11:46.324877	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1036	missile	\N	\N	noun	4	0	3	2025-07-06 15:11:46.329848	2025-07-06 15:11:46.32985	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1037	mission	\N	\N	noun	4	0	4	2025-07-06 15:11:46.331916	2025-07-06 15:11:46.331917	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1038	mistake	\N	\N	noun	4	0	3	2025-07-06 15:11:46.334123	2025-07-06 15:11:46.334125	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1039	mix	\N	\N	noun	1	0	1	2025-07-06 15:11:46.336583	2025-07-06 15:11:46.336584	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1040	mixture	\N	\N	noun	4	0	3	2025-07-06 15:11:46.339132	2025-07-06 15:11:46.339134	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1041	mobile	\N	\N	noun	3	0	3	2025-07-06 15:11:46.341292	2025-07-06 15:11:46.341294	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1042	mode	\N	\N	noun	2	0	2	2025-07-06 15:11:46.343378	2025-07-06 15:11:46.343379	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1043	model	\N	\N	noun	3	0	2	2025-07-06 15:11:46.345455	2025-07-06 15:11:46.345457	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1044	moderate	\N	\N	noun	4	0	4	2025-07-06 15:11:46.347614	2025-07-06 15:11:46.347616	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1045	modern	\N	\N	noun	3	0	3	2025-07-06 15:11:46.349853	2025-07-06 15:11:46.349855	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1046	modification	\N	\N	noun	6	0	4	2025-07-06 15:11:46.352228	2025-07-06 15:11:46.352229	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1047	mom	\N	\N	noun	1	0	1	2025-07-06 15:11:46.355177	2025-07-06 15:11:46.355179	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1048	moment	\N	\N	noun	3	0	3	2025-07-06 15:11:46.357603	2025-07-06 15:11:46.357605	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1049	monarch	\N	\N	noun	4	0	3	2025-07-06 15:11:46.359752	2025-07-06 15:11:46.359754	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1050	money	\N	\N	noun	3	0	2	2025-07-06 15:11:46.361674	2025-07-06 15:11:46.361676	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1051	monitor	\N	\N	noun	4	0	3	2025-07-06 15:11:46.363799	2025-07-06 15:11:46.3638	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1052	monkey	\N	\N	noun	3	0	3	2025-07-06 15:11:46.365792	2025-07-06 15:11:46.365794	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1053	monster	\N	\N	adjective	4	0	3	2025-07-06 15:11:46.368153	2025-07-06 15:11:46.368155	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1054	month	\N	\N	noun	3	0	2	2025-07-06 15:11:46.370195	2025-07-06 15:11:46.370197	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1055	monument	\N	\N	noun	4	0	4	2025-07-06 15:11:46.372225	2025-07-06 15:11:46.372227	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1056	mood	\N	\N	noun	2	0	2	2025-07-06 15:11:46.374198	2025-07-06 15:11:46.3742	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1058	moral	\N	\N	noun	3	0	2	2025-07-06 15:11:46.378548	2025-07-06 15:11:46.37855	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1059	morning	\N	\N	verb	4	0	3	2025-07-06 15:11:46.380665	2025-07-06 15:11:46.380667	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1060	mortgage	\N	\N	noun	4	0	4	2025-07-06 15:11:46.38269	2025-07-06 15:11:46.382692	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1061	mosquito	\N	\N	noun	4	0	4	2025-07-06 15:11:46.384746	2025-07-06 15:11:46.384748	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1062	mostly	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.386862	2025-07-06 15:11:46.386864	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1063	motion	\N	\N	noun	3	0	4	2025-07-06 15:11:46.389978	2025-07-06 15:11:46.38998	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1064	motivation	\N	\N	noun	5	0	4	2025-07-06 15:11:46.392179	2025-07-06 15:11:46.392181	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1065	motor	\N	\N	noun	3	0	2	2025-07-06 15:11:46.394126	2025-07-06 15:11:46.394128	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1066	motorcycle	\N	\N	noun	5	0	5	2025-07-06 15:11:46.396117	2025-07-06 15:11:46.396119	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1067	mountain	\N	\N	noun	4	0	4	2025-07-06 15:11:46.398264	2025-07-06 15:11:46.398266	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1068	mouse	\N	\N	noun	3	0	2	2025-07-06 15:11:46.400847	2025-07-06 15:11:46.400849	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1069	mouth	\N	\N	noun	3	0	2	2025-07-06 15:11:46.402906	2025-07-06 15:11:46.402908	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1070	move	\N	\N	noun	2	0	2	2025-07-06 15:11:46.405078	2025-07-06 15:11:46.40508	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1071	movement	\N	\N	noun	4	0	4	2025-07-06 15:11:46.407209	2025-07-06 15:11:46.407211	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1072	movie	\N	\N	noun	3	0	2	2025-07-06 15:11:46.409255	2025-07-06 15:11:46.409257	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1073	mud	\N	\N	noun	1	0	1	2025-07-06 15:11:46.41136	2025-07-06 15:11:46.411362	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1074	mug	\N	\N	noun	1	0	1	2025-07-06 15:11:46.413328	2025-07-06 15:11:46.41333	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1075	multiple	\N	\N	noun	4	0	4	2025-07-06 15:11:46.415348	2025-07-06 15:11:46.41535	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1076	murder	\N	\N	adjective	3	0	3	2025-07-06 15:11:46.417381	2025-07-06 15:11:46.417383	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1077	muscle	\N	\N	noun	3	0	3	2025-07-06 15:11:46.419504	2025-07-06 15:11:46.419506	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1078	museum	\N	\N	noun	3	0	3	2025-07-06 15:11:46.421709	2025-07-06 15:11:46.421711	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1079	mushroom	\N	\N	noun	4	0	4	2025-07-06 15:11:46.423712	2025-07-06 15:11:46.423714	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1080	music	\N	\N	noun	3	0	2	2025-07-06 15:11:46.425912	2025-07-06 15:11:46.425914	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1081	musician	\N	\N	noun	4	0	4	2025-07-06 15:11:46.427936	2025-07-06 15:11:46.427938	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1082	my	\N	\N	pronoun	1	0	1	2025-07-06 15:11:46.43007	2025-07-06 15:11:46.430071	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1083	mystery	\N	\N	noun	4	0	3	2025-07-06 15:11:46.432168	2025-07-06 15:11:46.432169	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1084	nail	\N	\N	noun	2	0	2	2025-07-06 15:11:46.434266	2025-07-06 15:11:46.434267	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1085	name	\N	\N	noun	2	0	2	2025-07-06 15:11:46.436338	2025-07-06 15:11:46.43634	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1086	narrow	\N	\N	noun	3	0	3	2025-07-06 15:11:46.438525	2025-07-06 15:11:46.438526	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1087	nation	\N	\N	noun	3	0	4	2025-07-06 15:11:46.440656	2025-07-06 15:11:46.440657	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1088	national	\N	\N	noun	4	0	4	2025-07-06 15:11:46.443065	2025-07-06 15:11:46.443067	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1089	native	\N	\N	adjective	3	0	3	2025-07-06 15:11:46.445232	2025-07-06 15:11:46.445233	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1090	naturally	\N	\N	adverb	5	0	4	2025-07-06 15:11:46.447146	2025-07-06 15:11:46.447147	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1091	nature	\N	\N	noun	3	0	3	2025-07-06 15:11:46.449133	2025-07-06 15:11:46.449135	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1092	navigation	\N	\N	noun	5	0	4	2025-07-06 15:11:46.451734	2025-07-06 15:11:46.451736	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1093	navy	\N	\N	noun	2	0	2	2025-07-06 15:11:46.454003	2025-07-06 15:11:46.454005	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1094	near	\N	\N	noun	2	0	2	2025-07-06 15:11:46.456288	2025-07-06 15:11:46.45629	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1095	nearly	\N	\N	adverb	3	0	3	2025-07-06 15:11:46.458483	2025-07-06 15:11:46.4585	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1096	neat	\N	\N	noun	2	0	2	2025-07-06 15:11:46.460885	2025-07-06 15:11:46.460887	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1097	necessity	\N	\N	noun	5	0	4	2025-07-06 15:11:46.462879	2025-07-06 15:11:46.462881	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1098	neck	\N	\N	noun	2	0	2	2025-07-06 15:11:46.464927	2025-07-06 15:11:46.464929	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1099	needle	\N	\N	noun	3	0	3	2025-07-06 15:11:46.467072	2025-07-06 15:11:46.467074	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1100	negative	\N	\N	adjective	4	0	4	2025-07-06 15:11:46.469135	2025-07-06 15:11:46.469137	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1101	negotiation	\N	\N	noun	6	0	4	2025-07-06 15:11:46.471142	2025-07-06 15:11:46.471144	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1102	neighborhood	\N	\N	noun	6	0	4	2025-07-06 15:11:46.473326	2025-07-06 15:11:46.473328	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1103	nerve	\N	\N	noun	3	0	2	2025-07-06 15:11:46.47541	2025-07-06 15:11:46.475411	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1104	nervous	\N	\N	adjective	4	0	3	2025-07-06 15:11:46.477413	2025-07-06 15:11:46.477415	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1105	nervously	\N	\N	adverb	5	0	4	2025-07-06 15:11:46.479486	2025-07-06 15:11:46.479487	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1106	nest	\N	\N	adjective	2	0	2	2025-07-06 15:11:46.481734	2025-07-06 15:11:46.481751	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1107	net	\N	\N	noun	1	0	1	2025-07-06 15:11:46.483723	2025-07-06 15:11:46.483725	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1108	network	\N	\N	noun	4	0	3	2025-07-06 15:11:46.48585	2025-07-06 15:11:46.485851	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1109	never	\N	\N	adjective	3	0	2	2025-07-06 15:11:46.488158	2025-07-06 15:11:46.48816	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1110	new	\N	\N	noun	1	0	1	2025-07-06 15:11:46.490389	2025-07-06 15:11:46.490391	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1111	news	\N	\N	noun	2	0	2	2025-07-06 15:11:46.49268	2025-07-06 15:11:46.492698	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1112	newspaper	\N	\N	adjective	5	0	4	2025-07-06 15:11:46.494691	2025-07-06 15:11:46.494692	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1113	nice	\N	\N	noun	2	0	2	2025-07-06 15:11:46.496854	2025-07-06 15:11:46.496856	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1115	nightmare	\N	\N	noun	5	0	4	2025-07-06 15:11:46.50114	2025-07-06 15:11:46.501142	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1116	nine	\N	\N	noun	2	0	2	2025-07-06 15:11:46.505203	2025-07-06 15:11:46.505205	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1117	nineteen	\N	\N	noun	4	0	4	2025-07-06 15:11:46.508169	2025-07-06 15:11:46.508171	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1118	ninety	\N	\N	noun	3	0	3	2025-07-06 15:11:46.510874	2025-07-06 15:11:46.510876	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1119	ninth	\N	\N	noun	3	0	2	2025-07-06 15:11:46.513754	2025-07-06 15:11:46.513756	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1120	no	\N	\N	noun	1	0	1	2025-07-06 15:11:46.515813	2025-07-06 15:11:46.515815	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1121	noble	\N	\N	noun	3	0	2	2025-07-06 15:11:46.518104	2025-07-06 15:11:46.518123	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1122	noise	\N	\N	noun	3	0	2	2025-07-06 15:11:46.520484	2025-07-06 15:11:46.520486	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1123	noisy	\N	\N	noun	3	0	2	2025-07-06 15:11:46.522733	2025-07-06 15:11:46.522735	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1124	nomination	\N	\N	noun	5	0	4	2025-07-06 15:11:46.524903	2025-07-06 15:11:46.524905	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1125	noodle	\N	\N	noun	3	0	3	2025-07-06 15:11:46.52759	2025-07-06 15:11:46.527592	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1126	noodles	\N	\N	noun	4	0	3	2025-07-06 15:11:46.529698	2025-07-06 15:11:46.5297	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1127	noon	\N	\N	noun	2	0	2	2025-07-06 15:11:46.531836	2025-07-06 15:11:46.531838	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1128	norm	\N	\N	noun	2	0	2	2025-07-06 15:11:46.533985	2025-07-06 15:11:46.533987	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1129	normal	\N	\N	noun	3	0	3	2025-07-06 15:11:46.536165	2025-07-06 15:11:46.536167	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1130	north	\N	\N	noun	3	0	2	2025-07-06 15:11:46.538186	2025-07-06 15:11:46.538188	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1131	nose	\N	\N	noun	2	0	2	2025-07-06 15:11:46.540473	2025-07-06 15:11:46.540474	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1132	note	\N	\N	noun	2	0	2	2025-07-06 15:11:46.542622	2025-07-06 15:11:46.542624	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1133	notebook	\N	\N	noun	4	0	4	2025-07-06 15:11:46.544605	2025-07-06 15:11:46.544607	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1135	notice	\N	\N	noun	3	0	3	2025-07-06 15:11:46.548828	2025-07-06 15:11:46.54883	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1136	notion	\N	\N	noun	3	0	4	2025-07-06 15:11:46.551159	2025-07-06 15:11:46.551161	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1137	novel	\N	\N	noun	3	0	2	2025-07-06 15:11:46.553474	2025-07-06 15:11:46.553476	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1138	now	\N	\N	noun	1	0	1	2025-07-06 15:11:46.555696	2025-07-06 15:11:46.555698	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1139	nowhere	\N	\N	noun	4	0	3	2025-07-06 15:11:46.558149	2025-07-06 15:11:46.558151	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1140	number	\N	\N	adjective	3	0	3	2025-07-06 15:11:46.560337	2025-07-06 15:11:46.560339	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1141	nurse	\N	\N	noun	3	0	2	2025-07-06 15:11:46.56264	2025-07-06 15:11:46.562642	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1142	nut	\N	\N	noun	1	0	1	2025-07-06 15:11:46.564697	2025-07-06 15:11:46.564698	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1143	nutrition	\N	\N	noun	5	0	4	2025-07-06 15:11:46.566816	2025-07-06 15:11:46.566818	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1144	nuts	\N	\N	noun	2	0	2	2025-07-06 15:11:46.568961	2025-07-06 15:11:46.568963	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1145	nylon	\N	\N	noun	3	0	2	2025-07-06 15:11:46.570976	2025-07-06 15:11:46.570977	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1146	oak	\N	\N	noun	1	0	1	2025-07-06 15:11:46.573085	2025-07-06 15:11:46.573087	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1147	obey	\N	\N	noun	2	0	2	2025-07-06 15:11:46.575384	2025-07-06 15:11:46.575401	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1148	object	\N	\N	noun	3	0	3	2025-07-06 15:11:46.577644	2025-07-06 15:11:46.577645	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1149	objection	\N	\N	noun	5	0	4	2025-07-06 15:11:46.579634	2025-07-06 15:11:46.579635	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1150	objective	\N	\N	adjective	5	0	4	2025-07-06 15:11:46.581631	2025-07-06 15:11:46.581633	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1151	obligation	\N	\N	noun	5	0	4	2025-07-06 15:11:46.583894	2025-07-06 15:11:46.583896	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1152	observation	\N	\N	noun	6	0	4	2025-07-06 15:11:46.586163	2025-07-06 15:11:46.586164	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1153	observer	\N	\N	adjective	4	0	4	2025-07-06 15:11:46.588901	2025-07-06 15:11:46.588903	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1154	obstacle	\N	\N	noun	4	0	4	2025-07-06 15:11:46.591144	2025-07-06 15:11:46.591146	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1155	obtain	\N	\N	noun	3	0	3	2025-07-06 15:11:46.593844	2025-07-06 15:11:46.593847	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1156	obvious	\N	\N	adjective	4	0	3	2025-07-06 15:11:46.596169	2025-07-06 15:11:46.596171	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1157	occasion	\N	\N	noun	4	0	4	2025-07-06 15:11:46.598193	2025-07-06 15:11:46.598195	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1158	occasionally	\N	\N	adverb	6	0	4	2025-07-06 15:11:46.600197	2025-07-06 15:11:46.600199	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1159	occupation	\N	\N	noun	5	0	4	2025-07-06 15:11:46.60224	2025-07-06 15:11:46.602242	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1160	ocean	\N	\N	noun	3	0	2	2025-07-06 15:11:46.604255	2025-07-06 15:11:46.604256	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1161	of	\N	\N	preposition	1	0	1	2025-07-06 15:11:46.606222	2025-07-06 15:11:46.606224	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1162	offer	\N	\N	adjective	3	0	2	2025-07-06 15:11:46.608586	2025-07-06 15:11:46.608589	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1164	officer	\N	\N	adjective	4	0	3	2025-07-06 15:11:46.612954	2025-07-06 15:11:46.612956	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1165	official	\N	\N	noun	4	0	4	2025-07-06 15:11:46.615058	2025-07-06 15:11:46.61506	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1166	offspring	\N	\N	verb	5	0	4	2025-07-06 15:11:46.617118	2025-07-06 15:11:46.61712	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1168	oil	\N	\N	noun	1	0	1	2025-07-06 15:11:46.621621	2025-07-06 15:11:46.621623	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1170	old	\N	\N	noun	1	0	1	2025-07-06 15:11:46.625673	2025-07-06 15:11:46.625675	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1171	olive	\N	\N	adjective	3	0	2	2025-07-06 15:11:46.627673	2025-07-06 15:11:46.627675	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1172	on	\N	\N	preposition	1	0	1	2025-07-06 15:11:46.629964	2025-07-06 15:11:46.629966	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1173	once	\N	\N	noun	2	0	2	2025-07-06 15:11:46.632027	2025-07-06 15:11:46.632029	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1174	one	\N	\N	noun	1	0	1	2025-07-06 15:11:46.63432	2025-07-06 15:11:46.634322	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1175	onion	\N	\N	noun	3	0	2	2025-07-06 15:11:46.636939	2025-07-06 15:11:46.636941	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1176	online	\N	\N	noun	3	0	3	2025-07-06 15:11:46.639152	2025-07-06 15:11:46.639154	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1178	opening	\N	\N	verb	4	0	3	2025-07-06 15:11:46.643292	2025-07-06 15:11:46.643294	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1179	operation	\N	\N	noun	5	0	4	2025-07-06 15:11:46.645415	2025-07-06 15:11:46.645416	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1180	opinion	\N	\N	noun	4	0	3	2025-07-06 15:11:46.647601	2025-07-06 15:11:46.647603	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1181	opponent	\N	\N	noun	4	0	4	2025-07-06 15:11:46.649647	2025-07-06 15:11:46.649649	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1182	opportunity	\N	\N	noun	6	0	5	2025-07-06 15:11:46.651715	2025-07-06 15:11:46.651716	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1183	opposition	\N	\N	noun	5	0	4	2025-07-06 15:11:46.653766	2025-07-06 15:11:46.653768	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1184	option	\N	\N	noun	3	0	4	2025-07-06 15:11:46.656372	2025-07-06 15:11:46.656374	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1185	or	\N	\N	conjunction	1	0	1	2025-07-06 15:11:46.658832	2025-07-06 15:11:46.658834	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1186	oral	\N	\N	noun	2	0	2	2025-07-06 15:11:46.661117	2025-07-06 15:11:46.661119	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1187	orange	\N	\N	noun	3	0	3	2025-07-06 15:11:46.663376	2025-07-06 15:11:46.663378	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1188	orbit	\N	\N	noun	3	0	2	2025-07-06 15:11:46.665567	2025-07-06 15:11:46.665569	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1189	order	\N	\N	adjective	3	0	2	2025-07-06 15:11:46.667833	2025-07-06 15:11:46.667835	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1190	ordinary	\N	\N	noun	4	0	4	2025-07-06 15:11:46.669892	2025-07-06 15:11:46.669897	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1191	organization	\N	\N	noun	6	0	4	2025-07-06 15:11:46.672043	2025-07-06 15:11:46.672045	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1192	origin	\N	\N	noun	3	0	3	2025-07-06 15:11:46.674184	2025-07-06 15:11:46.674186	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1193	original	\N	\N	noun	4	0	4	2025-07-06 15:11:46.676409	2025-07-06 15:11:46.676427	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1194	ornament	\N	\N	noun	4	0	4	2025-07-06 15:11:46.678495	2025-07-06 15:11:46.678497	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1195	otherwise	\N	\N	noun	5	0	4	2025-07-06 15:11:46.68083	2025-07-06 15:11:46.680832	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1196	our	\N	\N	pronoun	1	0	1	2025-07-06 15:11:46.68315	2025-07-06 15:11:46.683152	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1197	outcome	\N	\N	noun	4	0	3	2025-07-06 15:11:46.685218	2025-07-06 15:11:46.68522	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1198	output	\N	\N	noun	3	0	3	2025-07-06 15:11:46.687513	2025-07-06 15:11:46.687515	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1199	outside	\N	\N	noun	4	0	3	2025-07-06 15:11:46.690042	2025-07-06 15:11:46.690044	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1200	oven	\N	\N	noun	2	0	2	2025-07-06 15:11:46.692741	2025-07-06 15:11:46.692743	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1201	owe	\N	\N	noun	1	0	1	2025-07-06 15:11:46.69477	2025-07-06 15:11:46.694772	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1202	owl	\N	\N	noun	1	0	1	2025-07-06 15:11:46.697239	2025-07-06 15:11:46.69724	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1203	own	\N	\N	noun	1	0	1	2025-07-06 15:11:46.699486	2025-07-06 15:11:46.699503	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1204	owner	\N	\N	adjective	3	0	2	2025-07-06 15:11:46.701825	2025-07-06 15:11:46.701827	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1205	ownership	\N	\N	noun	5	0	4	2025-07-06 15:11:46.703919	2025-07-06 15:11:46.703921	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1206	oxygen	\N	\N	noun	3	0	3	2025-07-06 15:11:46.706221	2025-07-06 15:11:46.706223	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1207	pace	\N	\N	noun	2	0	2	2025-07-06 15:11:46.708273	2025-07-06 15:11:46.708275	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1208	pack	\N	\N	noun	2	0	2	2025-07-06 15:11:46.710355	2025-07-06 15:11:46.710356	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1209	package	\N	\N	noun	4	0	3	2025-07-06 15:11:46.712433	2025-07-06 15:11:46.712435	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1210	pad	\N	\N	noun	1	0	1	2025-07-06 15:11:46.714385	2025-07-06 15:11:46.714387	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1211	page	\N	\N	noun	2	0	2	2025-07-06 15:11:46.716444	2025-07-06 15:11:46.716446	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1212	pain	\N	\N	noun	2	0	2	2025-07-06 15:11:46.718785	2025-07-06 15:11:46.718787	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1213	paint	\N	\N	noun	3	0	2	2025-07-06 15:11:46.720885	2025-07-06 15:11:46.720887	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1214	painter	\N	\N	adjective	4	0	3	2025-07-06 15:11:46.722847	2025-07-06 15:11:46.722849	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1215	painting	\N	\N	verb	4	0	4	2025-07-06 15:11:46.724764	2025-07-06 15:11:46.724766	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1216	pair	\N	\N	noun	2	0	2	2025-07-06 15:11:46.728189	2025-07-06 15:11:46.728208	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1217	pajamas	\N	\N	noun	4	0	3	2025-07-06 15:11:46.731064	2025-07-06 15:11:46.731066	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1218	palace	\N	\N	noun	3	0	3	2025-07-06 15:11:46.733751	2025-07-06 15:11:46.733753	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1219	pale	\N	\N	noun	2	0	2	2025-07-06 15:11:46.736656	2025-07-06 15:11:46.736658	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1220	palm	\N	\N	noun	2	0	2	2025-07-06 15:11:46.738716	2025-07-06 15:11:46.738718	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1221	pamphlet	\N	\N	noun	4	0	4	2025-07-06 15:11:46.740876	2025-07-06 15:11:46.740877	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1222	pan	\N	\N	noun	1	0	1	2025-07-06 15:11:46.742929	2025-07-06 15:11:46.742931	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1223	pancake	\N	\N	noun	4	0	3	2025-07-06 15:11:46.745013	2025-07-06 15:11:46.745015	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1224	panda	\N	\N	noun	3	0	2	2025-07-06 15:11:46.747011	2025-07-06 15:11:46.747013	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1225	panel	\N	\N	noun	3	0	2	2025-07-06 15:11:46.74908	2025-07-06 15:11:46.749082	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1226	panic	\N	\N	noun	3	0	2	2025-07-06 15:11:46.75131	2025-07-06 15:11:46.751312	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1227	panorama	\N	\N	noun	4	0	4	2025-07-06 15:11:46.753371	2025-07-06 15:11:46.753373	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1228	paper	\N	\N	adjective	3	0	2	2025-07-06 15:11:46.755441	2025-07-06 15:11:46.755443	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1229	parade	\N	\N	noun	3	0	3	2025-07-06 15:11:46.757677	2025-07-06 15:11:46.757679	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1230	paradise	\N	\N	noun	4	0	4	2025-07-06 15:11:46.759765	2025-07-06 15:11:46.759767	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1231	paragraph	\N	\N	noun	5	0	4	2025-07-06 15:11:46.761704	2025-07-06 15:11:46.761705	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1232	parallel	\N	\N	noun	4	0	4	2025-07-06 15:11:46.764497	2025-07-06 15:11:46.764499	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1233	parent	\N	\N	noun	3	0	3	2025-07-06 15:11:46.766804	2025-07-06 15:11:46.766806	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1234	park	\N	\N	noun	2	0	2	2025-07-06 15:11:46.768951	2025-07-06 15:11:46.768953	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1235	parking	\N	\N	verb	4	0	3	2025-07-06 15:11:46.771112	2025-07-06 15:11:46.771114	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1236	parliament	\N	\N	noun	5	0	5	2025-07-06 15:11:46.773311	2025-07-06 15:11:46.773313	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1237	parrot	\N	\N	noun	3	0	3	2025-07-06 15:11:46.775275	2025-07-06 15:11:46.775276	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1238	part	\N	\N	noun	1	0	2	2025-07-06 15:11:46.777174	2025-07-06 15:11:46.777176	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1239	participant	\N	\N	noun	6	0	5	2025-07-06 15:11:46.779073	2025-07-06 15:11:46.779075	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1240	particle	\N	\N	noun	4	0	4	2025-07-06 15:11:46.78173	2025-07-06 15:11:46.781732	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1241	particular	\N	\N	noun	5	0	5	2025-07-06 15:11:46.78386	2025-07-06 15:11:46.783862	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1242	partner	\N	\N	adjective	4	0	3	2025-07-06 15:11:46.786038	2025-07-06 15:11:46.78604	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1243	partnership	\N	\N	noun	6	0	5	2025-07-06 15:11:46.788036	2025-07-06 15:11:46.788037	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1244	party	\N	\N	noun	3	0	2	2025-07-06 15:11:46.790238	2025-07-06 15:11:46.79024	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1245	pass	\N	\N	noun	2	0	2	2025-07-06 15:11:46.792271	2025-07-06 15:11:46.792273	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1246	passage	\N	\N	noun	4	0	3	2025-07-06 15:11:46.794258	2025-07-06 15:11:46.79426	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1247	passenger	\N	\N	adjective	5	0	4	2025-07-06 15:11:46.796216	2025-07-06 15:11:46.796217	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1248	passion	\N	\N	noun	4	0	4	2025-07-06 15:11:46.798325	2025-07-06 15:11:46.798327	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1251	path	\N	\N	noun	2	0	2	2025-07-06 15:11:46.805387	2025-07-06 15:11:46.805389	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1252	patience	\N	\N	noun	4	0	4	2025-07-06 15:11:46.807631	2025-07-06 15:11:46.807633	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1253	patient	\N	\N	noun	4	0	3	2025-07-06 15:11:46.809822	2025-07-06 15:11:46.809825	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1254	pattern	\N	\N	noun	4	0	3	2025-07-06 15:11:46.811795	2025-07-06 15:11:46.811797	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1255	pause	\N	\N	noun	3	0	2	2025-07-06 15:11:46.813784	2025-07-06 15:11:46.813786	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1256	paw	\N	\N	noun	1	0	1	2025-07-06 15:11:46.815816	2025-07-06 15:11:46.815818	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1257	pay	\N	\N	noun	1	0	1	2025-07-06 15:11:46.817942	2025-07-06 15:11:46.817944	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1258	payment	\N	\N	noun	4	0	3	2025-07-06 15:11:46.819962	2025-07-06 15:11:46.819964	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1259	peace	\N	\N	noun	3	0	2	2025-07-06 15:11:46.821977	2025-07-06 15:11:46.821978	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1260	peaceful	\N	\N	adjective	4	0	4	2025-07-06 15:11:46.823938	2025-07-06 15:11:46.82394	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1261	peach	\N	\N	noun	3	0	2	2025-07-06 15:11:46.825882	2025-07-06 15:11:46.825884	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1262	peacock	\N	\N	noun	4	0	3	2025-07-06 15:11:46.827908	2025-07-06 15:11:46.82791	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1263	peak	\N	\N	noun	2	0	2	2025-07-06 15:11:46.830138	2025-07-06 15:11:46.83014	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1264	peanut	\N	\N	noun	3	0	3	2025-07-06 15:11:46.832209	2025-07-06 15:11:46.832211	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1265	pear	\N	\N	noun	2	0	2	2025-07-06 15:11:46.83451	2025-07-06 15:11:46.834512	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1266	peasant	\N	\N	noun	4	0	3	2025-07-06 15:11:46.836603	2025-07-06 15:11:46.836605	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1267	pedestrian	\N	\N	noun	5	0	5	2025-07-06 15:11:46.838974	2025-07-06 15:11:46.838976	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1268	pen	\N	\N	noun	1	0	1	2025-07-06 15:11:46.841765	2025-07-06 15:11:46.841767	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1269	penalty	\N	\N	noun	4	0	3	2025-07-06 15:11:46.843847	2025-07-06 15:11:46.843849	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1270	pencil	\N	\N	noun	3	0	3	2025-07-06 15:11:46.846001	2025-07-06 15:11:46.846002	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1271	penguin	\N	\N	noun	4	0	3	2025-07-06 15:11:46.848049	2025-07-06 15:11:46.848067	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1272	pension	\N	\N	noun	4	0	4	2025-07-06 15:11:46.85015	2025-07-06 15:11:46.850152	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1273	people	\N	\N	noun	3	0	3	2025-07-06 15:11:46.852126	2025-07-06 15:11:46.852127	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1274	pepper	\N	\N	adjective	3	0	3	2025-07-06 15:11:46.854131	2025-07-06 15:11:46.854132	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1275	percent	\N	\N	noun	4	0	3	2025-07-06 15:11:46.856073	2025-07-06 15:11:46.856075	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1276	perception	\N	\N	noun	5	0	4	2025-07-06 15:11:46.858203	2025-07-06 15:11:46.858205	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1277	perfect	\N	\N	noun	4	0	3	2025-07-06 15:11:46.860198	2025-07-06 15:11:46.8602	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1278	perfectly	\N	\N	adverb	5	0	4	2025-07-06 15:11:46.862164	2025-07-06 15:11:46.862166	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1279	perform	\N	\N	noun	4	0	3	2025-07-06 15:11:46.864226	2025-07-06 15:11:46.864228	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1280	performance	\N	\N	noun	6	0	5	2025-07-06 15:11:46.866365	2025-07-06 15:11:46.866367	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1281	perhaps	\N	\N	noun	4	0	3	2025-07-06 15:11:46.868793	2025-07-06 15:11:46.868796	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1282	period	\N	\N	noun	3	0	3	2025-07-06 15:11:46.871094	2025-07-06 15:11:46.871096	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1283	permission	\N	\N	noun	5	0	4	2025-07-06 15:11:46.873304	2025-07-06 15:11:46.873306	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1284	permit	\N	\N	noun	3	0	3	2025-07-06 15:11:46.875349	2025-07-06 15:11:46.875351	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1285	person	\N	\N	noun	3	0	3	2025-07-06 15:11:46.877357	2025-07-06 15:11:46.877359	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1286	personal	\N	\N	noun	4	0	4	2025-07-06 15:11:46.879391	2025-07-06 15:11:46.879393	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1287	personality	\N	\N	noun	6	0	5	2025-07-06 15:11:46.881447	2025-07-06 15:11:46.881449	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1288	personally	\N	\N	adverb	5	0	5	2025-07-06 15:11:46.883715	2025-07-06 15:11:46.883717	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1289	personnel	\N	\N	noun	5	0	4	2025-07-06 15:11:46.886081	2025-07-06 15:11:46.886084	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1290	perspective	\N	\N	adjective	6	0	5	2025-07-06 15:11:46.888285	2025-07-06 15:11:46.888286	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1291	persuade	\N	\N	noun	4	0	4	2025-07-06 15:11:46.890846	2025-07-06 15:11:46.890848	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1292	phase	\N	\N	noun	3	0	2	2025-07-06 15:11:46.893059	2025-07-06 15:11:46.893061	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1293	phenomenon	\N	\N	noun	5	0	5	2025-07-06 15:11:46.895237	2025-07-06 15:11:46.895239	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1294	philosophy	\N	\N	noun	5	0	5	2025-07-06 15:11:46.897446	2025-07-06 15:11:46.897448	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1295	phone	\N	\N	noun	3	0	2	2025-07-06 15:11:46.899413	2025-07-06 15:11:46.899415	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1296	photo	\N	\N	noun	3	0	2	2025-07-06 15:11:46.901578	2025-07-06 15:11:46.90158	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1297	photograph	\N	\N	noun	5	0	5	2025-07-06 15:11:46.903688	2025-07-06 15:11:46.90369	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1298	photographer	\N	\N	adjective	6	0	5	2025-07-06 15:11:46.905807	2025-07-06 15:11:46.905809	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1299	photography	\N	\N	noun	6	0	5	2025-07-06 15:11:46.907942	2025-07-06 15:11:46.907944	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1300	phrase	\N	\N	noun	3	0	3	2025-07-06 15:11:46.909883	2025-07-06 15:11:46.909885	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1301	physical	\N	\N	noun	4	0	4	2025-07-06 15:11:46.912002	2025-07-06 15:11:46.912004	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1302	physician	\N	\N	noun	5	0	4	2025-07-06 15:11:46.914158	2025-07-06 15:11:46.914159	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1303	physics	\N	\N	noun	4	0	3	2025-07-06 15:11:46.916505	2025-07-06 15:11:46.916508	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1304	piano	\N	\N	noun	3	0	2	2025-07-06 15:11:46.91908	2025-07-06 15:11:46.919098	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1305	pick	\N	\N	noun	2	0	2	2025-07-06 15:11:46.921581	2025-07-06 15:11:46.921583	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1306	picnic	\N	\N	noun	3	0	3	2025-07-06 15:11:46.923896	2025-07-06 15:11:46.923898	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1307	picture	\N	\N	noun	4	0	3	2025-07-06 15:11:46.926182	2025-07-06 15:11:46.926184	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1309	pig	\N	\N	noun	1	0	1	2025-07-06 15:11:46.93059	2025-07-06 15:11:46.930592	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1310	pigeon	\N	\N	noun	3	0	3	2025-07-06 15:11:46.93284	2025-07-06 15:11:46.932842	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1311	pile	\N	\N	noun	2	0	2	2025-07-06 15:11:46.935039	2025-07-06 15:11:46.935041	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1312	pill	\N	\N	noun	2	0	2	2025-07-06 15:11:46.937292	2025-07-06 15:11:46.937294	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1313	pilot	\N	\N	noun	3	0	2	2025-07-06 15:11:46.939453	2025-07-06 15:11:46.939471	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1314	pin	\N	\N	noun	1	0	1	2025-07-06 15:11:46.941663	2025-07-06 15:11:46.941665	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1315	pinch	\N	\N	noun	3	0	2	2025-07-06 15:11:46.944042	2025-07-06 15:11:46.944044	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1316	pine	\N	\N	noun	2	0	2	2025-07-06 15:11:46.947658	2025-07-06 15:11:46.94766	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1317	pineapple	\N	\N	noun	5	0	4	2025-07-06 15:11:46.950554	2025-07-06 15:11:46.950556	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1318	pink	\N	\N	noun	2	0	2	2025-07-06 15:11:46.953539	2025-07-06 15:11:46.953541	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1319	pint	\N	\N	noun	2	0	2	2025-07-06 15:11:46.955676	2025-07-06 15:11:46.955678	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1320	pipe	\N	\N	noun	2	0	2	2025-07-06 15:11:46.957705	2025-07-06 15:11:46.957707	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1321	pirate	\N	\N	noun	3	0	3	2025-07-06 15:11:46.959723	2025-07-06 15:11:46.959724	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1322	pistol	\N	\N	noun	3	0	3	2025-07-06 15:11:46.962381	2025-07-06 15:11:46.962383	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1323	pitch	\N	\N	noun	3	0	2	2025-07-06 15:11:46.964453	2025-07-06 15:11:46.964455	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1324	pity	\N	\N	noun	2	0	2	2025-07-06 15:11:46.966858	2025-07-06 15:11:46.96686	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1325	pizza	\N	\N	noun	3	0	2	2025-07-06 15:11:46.969571	2025-07-06 15:11:46.969573	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1327	plain	\N	\N	noun	3	0	2	2025-07-06 15:11:46.974024	2025-07-06 15:11:46.974041	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1328	plan	\N	\N	noun	2	0	2	2025-07-06 15:11:46.976322	2025-07-06 15:11:46.976324	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1329	plane	\N	\N	noun	3	0	2	2025-07-06 15:11:46.978557	2025-07-06 15:11:46.978559	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1330	planet	\N	\N	noun	3	0	3	2025-07-06 15:11:46.980665	2025-07-06 15:11:46.980667	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1331	plank	\N	\N	noun	3	0	2	2025-07-06 15:11:46.982774	2025-07-06 15:11:46.982776	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1332	plant	\N	\N	noun	3	0	2	2025-07-06 15:11:46.985022	2025-07-06 15:11:46.985025	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1333	plastic	\N	\N	noun	4	0	3	2025-07-06 15:11:46.987235	2025-07-06 15:11:46.987237	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1334	plate	\N	\N	noun	3	0	2	2025-07-06 15:11:46.989908	2025-07-06 15:11:46.98991	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1335	platform	\N	\N	noun	4	0	4	2025-07-06 15:11:46.992491	2025-07-06 15:11:46.992493	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1336	play	\N	\N	noun	2	0	2	2025-07-06 15:11:46.99463	2025-07-06 15:11:46.994632	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1339	pleasant	\N	\N	noun	4	0	4	2025-07-06 15:11:47.000955	2025-07-06 15:11:47.000957	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1340	please	\N	\N	noun	3	0	3	2025-07-06 15:11:47.003325	2025-07-06 15:11:47.003326	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1341	pleasure	\N	\N	noun	4	0	4	2025-07-06 15:11:47.005508	2025-07-06 15:11:47.00551	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1342	plot	\N	\N	noun	2	0	2	2025-07-06 15:11:47.007782	2025-07-06 15:11:47.007784	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1343	plug	\N	\N	noun	2	0	2	2025-07-06 15:11:47.010256	2025-07-06 15:11:47.010258	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1344	plum	\N	\N	noun	2	0	2	2025-07-06 15:11:47.012441	2025-07-06 15:11:47.012458	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1345	plural	\N	\N	noun	3	0	3	2025-07-06 15:11:47.014491	2025-07-06 15:11:47.014492	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1346	pocket	\N	\N	noun	3	0	3	2025-07-06 15:11:47.016755	2025-07-06 15:11:47.016757	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1347	poem	\N	\N	noun	2	0	2	2025-07-06 15:11:47.018966	2025-07-06 15:11:47.018968	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1348	poet	\N	\N	noun	2	0	2	2025-07-06 15:11:47.021106	2025-07-06 15:11:47.021124	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1349	poetry	\N	\N	noun	3	0	3	2025-07-06 15:11:47.023214	2025-07-06 15:11:47.023216	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1351	polar	\N	\N	noun	3	0	2	2025-07-06 15:11:47.027303	2025-07-06 15:11:47.027305	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1352	pole	\N	\N	noun	2	0	2	2025-07-06 15:11:47.029353	2025-07-06 15:11:47.029355	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1353	police	\N	\N	noun	3	0	3	2025-07-06 15:11:47.03149	2025-07-06 15:11:47.031492	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1354	policy	\N	\N	noun	3	0	3	2025-07-06 15:11:47.033643	2025-07-06 15:11:47.033645	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1355	polish	\N	\N	noun	3	0	3	2025-07-06 15:11:47.035904	2025-07-06 15:11:47.035906	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1356	polite	\N	\N	noun	3	0	3	2025-07-06 15:11:47.037896	2025-07-06 15:11:47.037898	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1357	politely	\N	\N	adverb	4	0	4	2025-07-06 15:11:47.039948	2025-07-06 15:11:47.03995	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1358	political	\N	\N	noun	5	0	4	2025-07-06 15:11:47.042214	2025-07-06 15:11:47.042215	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1359	politician	\N	\N	noun	5	0	5	2025-07-06 15:11:47.04464	2025-07-06 15:11:47.044642	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1360	politics	\N	\N	noun	4	0	4	2025-07-06 15:11:47.047008	2025-07-06 15:11:47.04701	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1361	pollution	\N	\N	noun	5	0	4	2025-07-06 15:11:47.049309	2025-07-06 15:11:47.049311	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1362	pond	\N	\N	noun	2	0	2	2025-07-06 15:11:47.051673	2025-07-06 15:11:47.051675	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1363	pool	\N	\N	noun	2	0	2	2025-07-06 15:11:47.053774	2025-07-06 15:11:47.053776	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1364	poor	\N	\N	noun	2	0	2	2025-07-06 15:11:47.055819	2025-07-06 15:11:47.055821	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1365	pop	\N	\N	noun	1	0	1	2025-07-06 15:11:47.057838	2025-07-06 15:11:47.05784	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1366	popcorn	\N	\N	noun	4	0	3	2025-07-06 15:11:47.059987	2025-07-06 15:11:47.059989	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1367	popular	\N	\N	noun	4	0	3	2025-07-06 15:11:47.062188	2025-07-06 15:11:47.062206	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1368	population	\N	\N	noun	5	0	4	2025-07-06 15:11:47.064237	2025-07-06 15:11:47.064239	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1369	port	\N	\N	noun	2	0	2	2025-07-06 15:11:47.066733	2025-07-06 15:11:47.066736	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1370	portion	\N	\N	noun	4	0	4	2025-07-06 15:11:47.069103	2025-07-06 15:11:47.069105	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1371	portrait	\N	\N	noun	4	0	4	2025-07-06 15:11:47.071156	2025-07-06 15:11:47.071158	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1372	position	\N	\N	noun	4	0	4	2025-07-06 15:11:47.073428	2025-07-06 15:11:47.07343	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1373	positive	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.07543	2025-07-06 15:11:47.075432	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1374	possession	\N	\N	noun	5	0	4	2025-07-06 15:11:47.077495	2025-07-06 15:11:47.077497	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1375	possibility	\N	\N	noun	6	0	5	2025-07-06 15:11:47.079737	2025-07-06 15:11:47.079754	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1376	possibly	\N	\N	adverb	4	0	4	2025-07-06 15:11:47.08265	2025-07-06 15:11:47.082652	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1377	post	\N	\N	noun	2	0	2	2025-07-06 15:11:47.084926	2025-07-06 15:11:47.084928	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1378	postage	\N	\N	noun	4	0	3	2025-07-06 15:11:47.0871	2025-07-06 15:11:47.087102	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1379	poster	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.089164	2025-07-06 15:11:47.089166	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1380	pot	\N	\N	noun	1	0	1	2025-07-06 15:11:47.09122	2025-07-06 15:11:47.091222	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1381	potato	\N	\N	noun	3	0	3	2025-07-06 15:11:47.093651	2025-07-06 15:11:47.093654	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1382	potential	\N	\N	noun	5	0	4	2025-07-06 15:11:47.095766	2025-07-06 15:11:47.095768	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1383	poultry	\N	\N	noun	4	0	3	2025-07-06 15:11:47.097934	2025-07-06 15:11:47.097936	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1385	poverty	\N	\N	noun	4	0	3	2025-07-06 15:11:47.102141	2025-07-06 15:11:47.102143	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1386	powder	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.104207	2025-07-06 15:11:47.104209	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1387	power	\N	\N	adjective	3	0	2	2025-07-06 15:11:47.106243	2025-07-06 15:11:47.106245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1388	powerful	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.10836	2025-07-06 15:11:47.108362	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1389	practice	\N	\N	noun	4	0	4	2025-07-06 15:11:47.110404	2025-07-06 15:11:47.110406	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1390	praise	\N	\N	noun	3	0	3	2025-07-06 15:11:47.112589	2025-07-06 15:11:47.112591	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1391	prawn	\N	\N	noun	3	0	2	2025-07-06 15:11:47.11479	2025-07-06 15:11:47.114792	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1392	prayer	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.116901	2025-07-06 15:11:47.116903	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1393	precise	\N	\N	noun	4	0	3	2025-07-06 15:11:47.119319	2025-07-06 15:11:47.119322	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1394	precisely	\N	\N	adverb	5	0	4	2025-07-06 15:11:47.121476	2025-07-06 15:11:47.121478	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1395	precision	\N	\N	noun	5	0	4	2025-07-06 15:11:47.123506	2025-07-06 15:11:47.123508	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1396	prediction	\N	\N	noun	5	0	4	2025-07-06 15:11:47.125923	2025-07-06 15:11:47.125925	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1397	preference	\N	\N	noun	5	0	5	2025-07-06 15:11:47.128393	2025-07-06 15:11:47.128395	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1398	pregnancy	\N	\N	noun	5	0	4	2025-07-06 15:11:47.130622	2025-07-06 15:11:47.130624	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1399	prejudice	\N	\N	noun	5	0	4	2025-07-06 15:11:47.132883	2025-07-06 15:11:47.132909	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1400	premise	\N	\N	noun	4	0	3	2025-07-06 15:11:47.135435	2025-07-06 15:11:47.135437	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1401	preparation	\N	\N	noun	6	0	4	2025-07-06 15:11:47.137739	2025-07-06 15:11:47.137741	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1402	prepare	\N	\N	noun	4	0	3	2025-07-06 15:11:47.139873	2025-07-06 15:11:47.139875	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1403	presence	\N	\N	noun	4	0	4	2025-07-06 15:11:47.141938	2025-07-06 15:11:47.14194	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1404	present	\N	\N	noun	4	0	3	2025-07-06 15:11:47.143997	2025-07-06 15:11:47.143999	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1405	presentation	\N	\N	noun	6	0	4	2025-07-06 15:11:47.146204	2025-07-06 15:11:47.146206	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1406	preservation	\N	\N	noun	6	0	4	2025-07-06 15:11:47.148264	2025-07-06 15:11:47.148266	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1407	president	\N	\N	noun	5	0	4	2025-07-06 15:11:47.15045	2025-07-06 15:11:47.150452	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1408	press	\N	\N	noun	3	0	2	2025-07-06 15:11:47.153183	2025-07-06 15:11:47.153185	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1409	pressure	\N	\N	noun	4	0	4	2025-07-06 15:11:47.15538	2025-07-06 15:11:47.155382	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1410	prestige	\N	\N	noun	4	0	4	2025-07-06 15:11:47.157858	2025-07-06 15:11:47.15786	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1411	pretend	\N	\N	noun	4	0	3	2025-07-06 15:11:47.160208	2025-07-06 15:11:47.16021	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1412	price	\N	\N	noun	3	0	2	2025-07-06 15:11:47.162284	2025-07-06 15:11:47.162286	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1413	pride	\N	\N	noun	3	0	2	2025-07-06 15:11:47.164403	2025-07-06 15:11:47.164405	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1414	priest	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.16642	2025-07-06 15:11:47.166422	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1415	primary	\N	\N	noun	4	0	3	2025-07-06 15:11:47.168541	2025-07-06 15:11:47.168543	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1416	prince	\N	\N	noun	3	0	3	2025-07-06 15:11:47.172998	2025-07-06 15:11:47.173001	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1417	princess	\N	\N	noun	4	0	4	2025-07-06 15:11:47.176411	2025-07-06 15:11:47.176413	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1418	principal	\N	\N	noun	5	0	4	2025-07-06 15:11:47.179881	2025-07-06 15:11:47.179883	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1419	principle	\N	\N	noun	5	0	4	2025-07-06 15:11:47.182711	2025-07-06 15:11:47.182713	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1420	print	\N	\N	noun	3	0	2	2025-07-06 15:11:47.184865	2025-07-06 15:11:47.184867	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1421	prior	\N	\N	noun	3	0	2	2025-07-06 15:11:47.187004	2025-07-06 15:11:47.187006	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1422	priority	\N	\N	noun	4	0	4	2025-07-06 15:11:47.189075	2025-07-06 15:11:47.189076	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1423	prison	\N	\N	noun	3	0	3	2025-07-06 15:11:47.191189	2025-07-06 15:11:47.191191	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1424	privacy	\N	\N	noun	4	0	3	2025-07-06 15:11:47.193343	2025-07-06 15:11:47.193345	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1425	private	\N	\N	noun	4	0	3	2025-07-06 15:11:47.195667	2025-07-06 15:11:47.195669	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1426	privately	\N	\N	adverb	5	0	4	2025-07-06 15:11:47.197737	2025-07-06 15:11:47.197739	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1427	privilege	\N	\N	noun	5	0	4	2025-07-06 15:11:47.19986	2025-07-06 15:11:47.199862	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1428	prize	\N	\N	noun	3	0	2	2025-07-06 15:11:47.202455	2025-07-06 15:11:47.202472	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1429	probability	\N	\N	noun	6	0	5	2025-07-06 15:11:47.204515	2025-07-06 15:11:47.204517	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1430	probable	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.207656	2025-07-06 15:11:47.207658	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1431	probably	\N	\N	adverb	4	0	4	2025-07-06 15:11:47.20997	2025-07-06 15:11:47.209972	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1432	problem	\N	\N	noun	4	0	3	2025-07-06 15:11:47.212079	2025-07-06 15:11:47.212081	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1433	procedure	\N	\N	noun	5	0	4	2025-07-06 15:11:47.21434	2025-07-06 15:11:47.214342	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1434	process	\N	\N	noun	4	0	3	2025-07-06 15:11:47.216605	2025-07-06 15:11:47.216607	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1435	procession	\N	\N	noun	5	0	4	2025-07-06 15:11:47.218883	2025-07-06 15:11:47.218885	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1436	producer	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.221317	2025-07-06 15:11:47.221319	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1437	product	\N	\N	noun	4	0	3	2025-07-06 15:11:47.223683	2025-07-06 15:11:47.223701	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1438	profession	\N	\N	noun	5	0	4	2025-07-06 15:11:47.225925	2025-07-06 15:11:47.225927	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1439	professional	\N	\N	noun	6	0	4	2025-07-06 15:11:47.228431	2025-07-06 15:11:47.228433	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1440	professor	\N	\N	noun	5	0	4	2025-07-06 15:11:47.230859	2025-07-06 15:11:47.230861	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1441	profile	\N	\N	noun	4	0	3	2025-07-06 15:11:47.233141	2025-07-06 15:11:47.233143	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1442	profit	\N	\N	noun	3	0	3	2025-07-06 15:11:47.235656	2025-07-06 15:11:47.235659	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1443	program	\N	\N	noun	4	0	3	2025-07-06 15:11:47.238238	2025-07-06 15:11:47.23824	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1444	progress	\N	\N	noun	4	0	4	2025-07-06 15:11:47.240301	2025-07-06 15:11:47.240303	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1445	project	\N	\N	noun	4	0	3	2025-07-06 15:11:47.242403	2025-07-06 15:11:47.242404	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1446	promise	\N	\N	noun	4	0	3	2025-07-06 15:11:47.244618	2025-07-06 15:11:47.24462	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1447	promotion	\N	\N	noun	5	0	4	2025-07-06 15:11:47.246675	2025-07-06 15:11:47.246677	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1448	proof	\N	\N	noun	3	0	2	2025-07-06 15:11:47.248704	2025-07-06 15:11:47.248706	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1449	proper	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.250769	2025-07-06 15:11:47.250771	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1450	property	\N	\N	noun	4	0	4	2025-07-06 15:11:47.253255	2025-07-06 15:11:47.253257	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1451	proportion	\N	\N	noun	5	0	4	2025-07-06 15:11:47.255276	2025-07-06 15:11:47.255278	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1452	proposal	\N	\N	noun	4	0	4	2025-07-06 15:11:47.257489	2025-07-06 15:11:47.257491	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1453	prospect	\N	\N	noun	4	0	4	2025-07-06 15:11:47.259397	2025-07-06 15:11:47.259399	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1454	protect	\N	\N	noun	4	0	3	2025-07-06 15:11:47.26145	2025-07-06 15:11:47.261451	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1455	protection	\N	\N	noun	5	0	4	2025-07-06 15:11:47.26366	2025-07-06 15:11:47.263662	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1456	protest	\N	\N	adjective	4	0	3	2025-07-06 15:11:47.265859	2025-07-06 15:11:47.265861	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1457	proud	\N	\N	noun	3	0	2	2025-07-06 15:11:47.268123	2025-07-06 15:11:47.268125	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1458	proudly	\N	\N	adverb	4	0	3	2025-07-06 15:11:47.270341	2025-07-06 15:11:47.270343	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1459	prove	\N	\N	noun	3	0	2	2025-07-06 15:11:47.272495	2025-07-06 15:11:47.272497	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1460	provide	\N	\N	noun	4	0	3	2025-07-06 15:11:47.274737	2025-07-06 15:11:47.274739	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1461	provision	\N	\N	noun	5	0	4	2025-07-06 15:11:47.277205	2025-07-06 15:11:47.277207	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1462	psychology	\N	\N	noun	5	0	5	2025-07-06 15:11:47.279313	2025-07-06 15:11:47.279315	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1463	public	\N	\N	noun	3	0	3	2025-07-06 15:11:47.28177	2025-07-06 15:11:47.281772	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1464	publication	\N	\N	noun	6	0	4	2025-07-06 15:11:47.28405	2025-07-06 15:11:47.284053	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1465	publicity	\N	\N	noun	5	0	4	2025-07-06 15:11:47.286285	2025-07-06 15:11:47.286287	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1466	publish	\N	\N	noun	4	0	3	2025-07-06 15:11:47.288266	2025-07-06 15:11:47.288268	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1467	pudding	\N	\N	verb	4	0	3	2025-07-06 15:11:47.290484	2025-07-06 15:11:47.290485	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1468	pull	\N	\N	noun	2	0	2	2025-07-06 15:11:47.292438	2025-07-06 15:11:47.29244	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1469	pulse	\N	\N	noun	3	0	2	2025-07-06 15:11:47.295323	2025-07-06 15:11:47.295325	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1470	pump	\N	\N	noun	2	0	2	2025-07-06 15:11:47.297346	2025-07-06 15:11:47.297347	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1471	pumpkin	\N	\N	noun	4	0	3	2025-07-06 15:11:47.299369	2025-07-06 15:11:47.299371	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1472	punch	\N	\N	noun	3	0	2	2025-07-06 15:11:47.301565	2025-07-06 15:11:47.301567	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1473	punishment	\N	\N	noun	5	0	5	2025-07-06 15:11:47.303696	2025-07-06 15:11:47.303698	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1474	pupil	\N	\N	noun	3	0	2	2025-07-06 15:11:47.305836	2025-07-06 15:11:47.305838	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1475	purchase	\N	\N	noun	4	0	4	2025-07-06 15:11:47.307873	2025-07-06 15:11:47.307875	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1476	pure	\N	\N	noun	2	0	2	2025-07-06 15:11:47.309924	2025-07-06 15:11:47.309926	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1477	purple	\N	\N	noun	3	0	3	2025-07-06 15:11:47.312162	2025-07-06 15:11:47.312164	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1478	purpose	\N	\N	noun	4	0	3	2025-07-06 15:11:47.314406	2025-07-06 15:11:47.314408	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1479	purse	\N	\N	noun	3	0	2	2025-07-06 15:11:47.316681	2025-07-06 15:11:47.316683	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1480	pursuit	\N	\N	noun	4	0	3	2025-07-06 15:11:47.318829	2025-07-06 15:11:47.318831	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1481	push	\N	\N	noun	2	0	2	2025-07-06 15:11:47.320938	2025-07-06 15:11:47.32094	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1483	puzzle	\N	\N	noun	3	0	3	2025-07-06 15:11:47.325382	2025-07-06 15:11:47.325384	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1484	pyramid	\N	\N	noun	4	0	3	2025-07-06 15:11:47.327515	2025-07-06 15:11:47.327517	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1485	qualification	\N	\N	noun	6	0	4	2025-07-06 15:11:47.329622	2025-07-06 15:11:47.329624	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1486	quality	\N	\N	noun	4	0	3	2025-07-06 15:11:47.331718	2025-07-06 15:11:47.33172	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1487	quantity	\N	\N	noun	4	0	4	2025-07-06 15:11:47.333807	2025-07-06 15:11:47.333809	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1488	quarrel	\N	\N	noun	4	0	3	2025-07-06 15:11:47.33601	2025-07-06 15:11:47.336012	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1490	queen	\N	\N	noun	3	0	2	2025-07-06 15:11:47.340234	2025-07-06 15:11:47.340236	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1491	query	\N	\N	noun	3	0	2	2025-07-06 15:11:47.342373	2025-07-06 15:11:47.342375	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1492	quest	\N	\N	adjective	3	0	2	2025-07-06 15:11:47.344415	2025-07-06 15:11:47.344417	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1493	queue	\N	\N	noun	3	0	2	2025-07-06 15:11:47.346643	2025-07-06 15:11:47.34666	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1494	quick	\N	\N	noun	3	0	2	2025-07-06 15:11:47.348774	2025-07-06 15:11:47.348776	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1495	quickly	\N	\N	adverb	4	0	3	2025-07-06 15:11:47.3508	2025-07-06 15:11:47.350802	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1496	quiet	\N	\N	noun	3	0	2	2025-07-06 15:11:47.352846	2025-07-06 15:11:47.352848	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1497	quietly	\N	\N	adverb	4	0	3	2025-07-06 15:11:47.355018	2025-07-06 15:11:47.35502	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1498	quit	\N	\N	noun	2	0	2	2025-07-06 15:11:47.357059	2025-07-06 15:11:47.357061	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1499	quite	\N	\N	noun	3	0	2	2025-07-06 15:11:47.359087	2025-07-06 15:11:47.359089	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1500	quote	\N	\N	noun	3	0	2	2025-07-06 15:11:47.361152	2025-07-06 15:11:47.361153	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1501	rabbit	\N	\N	noun	3	0	3	2025-07-06 15:11:47.363317	2025-07-06 15:11:47.363336	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1502	race	\N	\N	noun	2	0	2	2025-07-06 15:11:47.365436	2025-07-06 15:11:47.365439	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1503	racial	\N	\N	noun	3	0	3	2025-07-06 15:11:47.367723	2025-07-06 15:11:47.367726	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1504	radar	\N	\N	noun	3	0	2	2025-07-06 15:11:47.369868	2025-07-06 15:11:47.36987	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1505	radio	\N	\N	noun	3	0	2	2025-07-06 15:11:47.372022	2025-07-06 15:11:47.372024	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1506	rag	\N	\N	noun	1	0	1	2025-07-06 15:11:47.37419	2025-07-06 15:11:47.374192	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1507	rage	\N	\N	noun	2	0	2	2025-07-06 15:11:47.376509	2025-07-06 15:11:47.376511	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1508	rail	\N	\N	noun	2	0	2	2025-07-06 15:11:47.378741	2025-07-06 15:11:47.378743	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1509	railway	\N	\N	noun	4	0	3	2025-07-06 15:11:47.380735	2025-07-06 15:11:47.380737	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1510	rain	\N	\N	noun	2	0	2	2025-07-06 15:11:47.382727	2025-07-06 15:11:47.382729	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1511	rainbow	\N	\N	noun	4	0	3	2025-07-06 15:11:47.384757	2025-07-06 15:11:47.384759	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1512	rainfall	\N	\N	noun	4	0	4	2025-07-06 15:11:47.386905	2025-07-06 15:11:47.386907	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1513	random	\N	\N	noun	3	0	3	2025-07-06 15:11:47.389098	2025-07-06 15:11:47.3891	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1514	range	\N	\N	noun	3	0	2	2025-07-06 15:11:47.391182	2025-07-06 15:11:47.391184	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1515	rank	\N	\N	noun	2	0	2	2025-07-06 15:11:47.393091	2025-07-06 15:11:47.393092	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1516	rapid	\N	\N	noun	3	0	2	2025-07-06 15:11:47.396737	2025-07-06 15:11:47.396739	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1517	rare	\N	\N	noun	2	0	2	2025-07-06 15:11:47.399614	2025-07-06 15:11:47.399616	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1518	rarely	\N	\N	adverb	3	0	3	2025-07-06 15:11:47.40348	2025-07-06 15:11:47.403482	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1519	rash	\N	\N	noun	2	0	2	2025-07-06 15:11:47.406052	2025-07-06 15:11:47.406054	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1520	rat	\N	\N	noun	1	0	1	2025-07-06 15:11:47.408406	2025-07-06 15:11:47.408408	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1521	rate	\N	\N	noun	2	0	2	2025-07-06 15:11:47.410688	2025-07-06 15:11:47.41069	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1522	rather	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.412916	2025-07-06 15:11:47.412918	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1523	raw	\N	\N	noun	1	0	1	2025-07-06 15:11:47.414794	2025-07-06 15:11:47.414796	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1524	ray	\N	\N	noun	1	0	1	2025-07-06 15:11:47.416913	2025-07-06 15:11:47.416914	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1525	razor	\N	\N	noun	3	0	2	2025-07-06 15:11:47.418994	2025-07-06 15:11:47.419012	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1526	reach	\N	\N	noun	3	0	2	2025-07-06 15:11:47.421061	2025-07-06 15:11:47.421062	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1527	reaction	\N	\N	noun	4	0	4	2025-07-06 15:11:47.423121	2025-07-06 15:11:47.423123	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1529	reader	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.42766	2025-07-06 15:11:47.427662	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1530	reading	\N	\N	verb	4	0	3	2025-07-06 15:11:47.429674	2025-07-06 15:11:47.429676	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1531	ready	\N	\N	noun	3	0	2	2025-07-06 15:11:47.431664	2025-07-06 15:11:47.431665	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1532	real	\N	\N	noun	2	0	2	2025-07-06 15:11:47.433768	2025-07-06 15:11:47.43377	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1533	realistic	\N	\N	noun	5	0	4	2025-07-06 15:11:47.435811	2025-07-06 15:11:47.435812	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1534	reality	\N	\N	noun	4	0	3	2025-07-06 15:11:47.438319	2025-07-06 15:11:47.43832	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1535	realize	\N	\N	noun	4	0	3	2025-07-06 15:11:47.440398	2025-07-06 15:11:47.4404	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1536	really	\N	\N	adverb	3	0	3	2025-07-06 15:11:47.442391	2025-07-06 15:11:47.442393	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1537	realm	\N	\N	noun	3	0	2	2025-07-06 15:11:47.444507	2025-07-06 15:11:47.444509	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1538	reason	\N	\N	noun	3	0	3	2025-07-06 15:11:47.446666	2025-07-06 15:11:47.446667	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1539	reasonable	\N	\N	adjective	5	0	5	2025-07-06 15:11:47.44875	2025-07-06 15:11:47.448752	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1540	rebellion	\N	\N	noun	5	0	4	2025-07-06 15:11:47.450889	2025-07-06 15:11:47.450891	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1541	recall	\N	\N	noun	3	0	3	2025-07-06 15:11:47.452969	2025-07-06 15:11:47.45297	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1542	receipt	\N	\N	noun	4	0	3	2025-07-06 15:11:47.454901	2025-07-06 15:11:47.454903	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1543	receive	\N	\N	adjective	4	0	3	2025-07-06 15:11:47.456954	2025-07-06 15:11:47.456956	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1544	recent	\N	\N	noun	3	0	3	2025-07-06 15:11:47.458856	2025-07-06 15:11:47.458858	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1545	recently	\N	\N	adverb	4	0	4	2025-07-06 15:11:47.460802	2025-07-06 15:11:47.460804	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1546	reception	\N	\N	noun	5	0	4	2025-07-06 15:11:47.46278	2025-07-06 15:11:47.462782	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1547	recession	\N	\N	noun	5	0	4	2025-07-06 15:11:47.464721	2025-07-06 15:11:47.464723	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1548	recipe	\N	\N	noun	3	0	3	2025-07-06 15:11:47.466693	2025-07-06 15:11:47.466695	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1549	recipient	\N	\N	noun	5	0	4	2025-07-06 15:11:47.468841	2025-07-06 15:11:47.468843	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1550	recognition	\N	\N	noun	6	0	4	2025-07-06 15:11:47.471143	2025-07-06 15:11:47.471145	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1551	recognize	\N	\N	noun	5	0	4	2025-07-06 15:11:47.474453	2025-07-06 15:11:47.474454	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1552	recommend	\N	\N	noun	5	0	4	2025-07-06 15:11:47.476542	2025-07-06 15:11:47.476544	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1553	recommendation	\N	\N	noun	6	0	4	2025-07-06 15:11:47.478474	2025-07-06 15:11:47.478476	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1554	record	\N	\N	noun	3	0	3	2025-07-06 15:11:47.480707	2025-07-06 15:11:47.480709	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1555	recovery	\N	\N	noun	4	0	4	2025-07-06 15:11:47.48266	2025-07-06 15:11:47.482662	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1556	recreation	\N	\N	noun	5	0	4	2025-07-06 15:11:47.484664	2025-07-06 15:11:47.484666	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1557	recruit	\N	\N	noun	4	0	3	2025-07-06 15:11:47.487315	2025-07-06 15:11:47.487317	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1558	rectangle	\N	\N	noun	5	0	4	2025-07-06 15:11:47.489561	2025-07-06 15:11:47.489563	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1559	reduce	\N	\N	noun	3	0	3	2025-07-06 15:11:47.492362	2025-07-06 15:11:47.492364	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1560	reduction	\N	\N	noun	5	0	4	2025-07-06 15:11:47.494665	2025-07-06 15:11:47.494667	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1561	reference	\N	\N	noun	5	0	4	2025-07-06 15:11:47.496624	2025-07-06 15:11:47.496626	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1562	reform	\N	\N	noun	3	0	3	2025-07-06 15:11:47.498712	2025-07-06 15:11:47.498713	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1563	refrigerator	\N	\N	noun	6	0	5	2025-07-06 15:11:47.500643	2025-07-06 15:11:47.500645	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1564	refuge	\N	\N	noun	3	0	3	2025-07-06 15:11:47.502644	2025-07-06 15:11:47.502646	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1565	refund	\N	\N	noun	3	0	3	2025-07-06 15:11:47.504442	2025-07-06 15:11:47.504444	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1566	refuse	\N	\N	noun	3	0	3	2025-07-06 15:11:47.506327	2025-07-06 15:11:47.506329	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1567	regard	\N	\N	noun	3	0	3	2025-07-06 15:11:47.508212	2025-07-06 15:11:47.508214	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1568	regime	\N	\N	noun	3	0	3	2025-07-06 15:11:47.510362	2025-07-06 15:11:47.510364	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1569	region	\N	\N	noun	3	0	3	2025-07-06 15:11:47.51219	2025-07-06 15:11:47.512192	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1570	register	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.514233	2025-07-06 15:11:47.514235	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1571	regret	\N	\N	noun	3	0	3	2025-07-06 15:11:47.516212	2025-07-06 15:11:47.516214	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1572	regular	\N	\N	noun	4	0	3	2025-07-06 15:11:47.518585	2025-07-06 15:11:47.518604	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1573	regularly	\N	\N	adverb	5	0	4	2025-07-06 15:11:47.520745	2025-07-06 15:11:47.520747	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1574	regulation	\N	\N	noun	5	0	4	2025-07-06 15:11:47.522932	2025-07-06 15:11:47.522934	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1575	rejection	\N	\N	noun	5	0	4	2025-07-06 15:11:47.525175	2025-07-06 15:11:47.525177	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1576	relation	\N	\N	noun	4	0	4	2025-07-06 15:11:47.527192	2025-07-06 15:11:47.527194	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1577	relationship	\N	\N	noun	6	0	4	2025-07-06 15:11:47.529284	2025-07-06 15:11:47.529286	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1578	relative	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.531275	2025-07-06 15:11:47.531277	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1579	relatively	\N	\N	adverb	5	0	5	2025-07-06 15:11:47.533447	2025-07-06 15:11:47.533449	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1580	relaxation	\N	\N	noun	5	0	4	2025-07-06 15:11:47.535538	2025-07-06 15:11:47.53554	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1581	relaxed	\N	\N	verb	4	0	3	2025-07-06 15:11:47.537652	2025-07-06 15:11:47.537654	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1582	release	\N	\N	noun	4	0	3	2025-07-06 15:11:47.53996	2025-07-06 15:11:47.539962	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1583	reliable	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.542316	2025-07-06 15:11:47.542318	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1584	relief	\N	\N	noun	3	0	3	2025-07-06 15:11:47.544426	2025-07-06 15:11:47.544428	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1585	relieved	\N	\N	verb	4	0	4	2025-07-06 15:11:47.546421	2025-07-06 15:11:47.546423	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1586	religion	\N	\N	noun	4	0	4	2025-07-06 15:11:47.548402	2025-07-06 15:11:47.548404	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1587	remark	\N	\N	noun	3	0	3	2025-07-06 15:11:47.550586	2025-07-06 15:11:47.550589	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1588	remarkable	\N	\N	adjective	5	0	5	2025-07-06 15:11:47.553025	2025-07-06 15:11:47.553027	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1589	remedy	\N	\N	noun	3	0	3	2025-07-06 15:11:47.555128	2025-07-06 15:11:47.555131	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1590	remember	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.557266	2025-07-06 15:11:47.557269	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1591	remind	\N	\N	noun	3	0	3	2025-07-06 15:11:47.559212	2025-07-06 15:11:47.559214	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1592	remote	\N	\N	noun	3	0	3	2025-07-06 15:11:47.561157	2025-07-06 15:11:47.561159	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1593	removal	\N	\N	noun	4	0	3	2025-07-06 15:11:47.563142	2025-07-06 15:11:47.563144	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1594	rent	\N	\N	noun	2	0	2	2025-07-06 15:11:47.565152	2025-07-06 15:11:47.565154	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1595	repair	\N	\N	noun	3	0	3	2025-07-06 15:11:47.567062	2025-07-06 15:11:47.567064	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1596	repeat	\N	\N	noun	3	0	3	2025-07-06 15:11:47.569284	2025-07-06 15:11:47.569285	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1597	replace	\N	\N	noun	4	0	3	2025-07-06 15:11:47.571256	2025-07-06 15:11:47.571258	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1598	replacement	\N	\N	noun	6	0	5	2025-07-06 15:11:47.57338	2025-07-06 15:11:47.573382	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1600	report	\N	\N	noun	3	0	3	2025-07-06 15:11:47.57746	2025-07-06 15:11:47.577462	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1601	reporter	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.579398	2025-07-06 15:11:47.5794	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1602	representation	\N	\N	noun	6	0	4	2025-07-06 15:11:47.581403	2025-07-06 15:11:47.581405	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1603	representative	\N	\N	adjective	6	0	5	2025-07-06 15:11:47.583398	2025-07-06 15:11:47.5834	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1604	republic	\N	\N	noun	4	0	4	2025-07-06 15:11:47.585586	2025-07-06 15:11:47.585588	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1605	reputation	\N	\N	noun	5	0	4	2025-07-06 15:11:47.588222	2025-07-06 15:11:47.588224	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1606	request	\N	\N	adjective	4	0	3	2025-07-06 15:11:47.590343	2025-07-06 15:11:47.590345	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1607	requirement	\N	\N	noun	6	0	5	2025-07-06 15:11:47.592649	2025-07-06 15:11:47.592651	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1608	rescue	\N	\N	noun	3	0	3	2025-07-06 15:11:47.594659	2025-07-06 15:11:47.594661	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1609	research	\N	\N	noun	4	0	4	2025-07-06 15:11:47.596538	2025-07-06 15:11:47.59654	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1610	resemblance	\N	\N	noun	6	0	5	2025-07-06 15:11:47.598644	2025-07-06 15:11:47.598646	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1611	reserve	\N	\N	noun	4	0	3	2025-07-06 15:11:47.600718	2025-07-06 15:11:47.60072	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1612	residence	\N	\N	noun	5	0	4	2025-07-06 15:11:47.602888	2025-07-06 15:11:47.602889	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1613	resident	\N	\N	noun	4	0	4	2025-07-06 15:11:47.60479	2025-07-06 15:11:47.604793	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1614	resign	\N	\N	noun	3	0	3	2025-07-06 15:11:47.606924	2025-07-06 15:11:47.606926	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1615	resignation	\N	\N	noun	6	0	4	2025-07-06 15:11:47.608849	2025-07-06 15:11:47.608851	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1616	resistance	\N	\N	noun	5	0	5	2025-07-06 15:11:47.612782	2025-07-06 15:11:47.612784	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1617	resolution	\N	\N	noun	5	0	4	2025-07-06 15:11:47.615505	2025-07-06 15:11:47.615507	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1618	resolve	\N	\N	noun	4	0	3	2025-07-06 15:11:47.617607	2025-07-06 15:11:47.617609	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1619	resource	\N	\N	noun	4	0	4	2025-07-06 15:11:47.620534	2025-07-06 15:11:47.620536	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1620	respect	\N	\N	noun	4	0	3	2025-07-06 15:11:47.622517	2025-07-06 15:11:47.622518	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1621	response	\N	\N	noun	4	0	4	2025-07-06 15:11:47.624707	2025-07-06 15:11:47.624709	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1622	responsibility	\N	\N	noun	6	0	5	2025-07-06 15:11:47.626729	2025-07-06 15:11:47.626731	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1623	responsible	\N	\N	adjective	6	0	5	2025-07-06 15:11:47.62968	2025-07-06 15:11:47.629682	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1624	rest	\N	\N	adjective	2	0	2	2025-07-06 15:11:47.631915	2025-07-06 15:11:47.631917	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1625	restaurant	\N	\N	noun	5	0	5	2025-07-06 15:11:47.635008	2025-07-06 15:11:47.63501	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1626	restoration	\N	\N	noun	6	0	4	2025-07-06 15:11:47.637207	2025-07-06 15:11:47.637209	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1627	restrain	\N	\N	noun	4	0	4	2025-07-06 15:11:47.639171	2025-07-06 15:11:47.639173	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1628	result	\N	\N	noun	3	0	3	2025-07-06 15:11:47.641246	2025-07-06 15:11:47.641248	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1629	retail	\N	\N	noun	3	0	3	2025-07-06 15:11:47.644411	2025-07-06 15:11:47.644414	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1630	retain	\N	\N	noun	3	0	3	2025-07-06 15:11:47.646558	2025-07-06 15:11:47.64656	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1631	retirement	\N	\N	noun	5	0	5	2025-07-06 15:11:47.648649	2025-07-06 15:11:47.648651	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1632	retreat	\N	\N	noun	4	0	3	2025-07-06 15:11:47.651045	2025-07-06 15:11:47.651063	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1633	return	\N	\N	noun	3	0	3	2025-07-06 15:11:47.65318	2025-07-06 15:11:47.653181	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1634	reveal	\N	\N	noun	3	0	3	2025-07-06 15:11:47.655232	2025-07-06 15:11:47.65525	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1635	revelation	\N	\N	noun	5	0	4	2025-07-06 15:11:47.657262	2025-07-06 15:11:47.657264	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1636	revenge	\N	\N	noun	4	0	3	2025-07-06 15:11:47.659368	2025-07-06 15:11:47.65937	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1637	revenue	\N	\N	noun	4	0	3	2025-07-06 15:11:47.661981	2025-07-06 15:11:47.661984	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1638	reverse	\N	\N	noun	4	0	3	2025-07-06 15:11:47.664045	2025-07-06 15:11:47.664047	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1639	review	\N	\N	noun	3	0	3	2025-07-06 15:11:47.666384	2025-07-06 15:11:47.666386	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1640	revision	\N	\N	noun	4	0	4	2025-07-06 15:11:47.668734	2025-07-06 15:11:47.668736	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1641	revolution	\N	\N	noun	5	0	4	2025-07-06 15:11:47.67112	2025-07-06 15:11:47.671122	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1642	reward	\N	\N	noun	3	0	3	2025-07-06 15:11:47.673296	2025-07-06 15:11:47.673298	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1643	rhino	\N	\N	noun	3	0	2	2025-07-06 15:11:47.675302	2025-07-06 15:11:47.675303	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1644	rhythm	\N	\N	noun	3	0	3	2025-07-06 15:11:47.677341	2025-07-06 15:11:47.677343	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1645	ribbon	\N	\N	noun	3	0	3	2025-07-06 15:11:47.679367	2025-07-06 15:11:47.679369	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1646	rice	\N	\N	noun	2	0	2	2025-07-06 15:11:47.681429	2025-07-06 15:11:47.681447	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1647	rich	\N	\N	noun	2	0	2	2025-07-06 15:11:47.683472	2025-07-06 15:11:47.683473	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1648	rid	\N	\N	noun	1	0	1	2025-07-06 15:11:47.685456	2025-07-06 15:11:47.685458	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1649	ride	\N	\N	noun	2	0	2	2025-07-06 15:11:47.687395	2025-07-06 15:11:47.687396	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1650	rifle	\N	\N	noun	3	0	2	2025-07-06 15:11:47.689281	2025-07-06 15:11:47.689283	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1651	right	\N	\N	noun	3	0	4	2025-07-06 15:11:47.691161	2025-07-06 15:11:47.691163	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1652	rigid	\N	\N	noun	3	0	2	2025-07-06 15:11:47.693243	2025-07-06 15:11:47.693245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1653	ring	\N	\N	noun	2	0	2	2025-07-06 15:11:47.695529	2025-07-06 15:11:47.69553	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1654	riot	\N	\N	noun	2	0	2	2025-07-06 15:11:47.697836	2025-07-06 15:11:47.697838	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1655	rip	\N	\N	noun	1	0	1	2025-07-06 15:11:47.700182	2025-07-06 15:11:47.700184	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1656	ripe	\N	\N	noun	2	0	2	2025-07-06 15:11:47.702275	2025-07-06 15:11:47.702277	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1657	rise	\N	\N	noun	2	0	2	2025-07-06 15:11:47.704603	2025-07-06 15:11:47.704606	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1658	risk	\N	\N	noun	2	0	2	2025-07-06 15:11:47.70676	2025-07-06 15:11:47.706762	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1659	rival	\N	\N	noun	3	0	2	2025-07-06 15:11:47.708962	2025-07-06 15:11:47.708964	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1660	river	\N	\N	adjective	3	0	2	2025-07-06 15:11:47.711188	2025-07-06 15:11:47.71119	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1661	road	\N	\N	noun	2	0	2	2025-07-06 15:11:47.71315	2025-07-06 15:11:47.713152	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1662	roar	\N	\N	noun	2	0	2	2025-07-06 15:11:47.715372	2025-07-06 15:11:47.715374	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1663	roast	\N	\N	noun	3	0	2	2025-07-06 15:11:47.71741	2025-07-06 15:11:47.717412	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1664	robe	\N	\N	noun	2	0	2	2025-07-06 15:11:47.719705	2025-07-06 15:11:47.719707	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1665	robin	\N	\N	noun	3	0	2	2025-07-06 15:11:47.721744	2025-07-06 15:11:47.721746	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1666	robot	\N	\N	noun	3	0	2	2025-07-06 15:11:47.723754	2025-07-06 15:11:47.723756	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1667	rock	\N	\N	noun	2	0	2	2025-07-06 15:11:47.725725	2025-07-06 15:11:47.725726	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1668	rocket	\N	\N	noun	3	0	3	2025-07-06 15:11:47.727755	2025-07-06 15:11:47.727757	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1669	role	\N	\N	noun	2	0	2	2025-07-06 15:11:47.729671	2025-07-06 15:11:47.729673	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1670	roll	\N	\N	noun	2	0	2	2025-07-06 15:11:47.731904	2025-07-06 15:11:47.731906	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1671	romantic	\N	\N	noun	4	0	4	2025-07-06 15:11:47.733816	2025-07-06 15:11:47.733817	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1672	roof	\N	\N	noun	2	0	2	2025-07-06 15:11:47.736233	2025-07-06 15:11:47.736235	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1673	room	\N	\N	noun	2	0	2	2025-07-06 15:11:47.738456	2025-07-06 15:11:47.738475	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1674	root	\N	\N	noun	2	0	2	2025-07-06 15:11:47.741018	2025-07-06 15:11:47.741021	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1675	rope	\N	\N	noun	2	0	2	2025-07-06 15:11:47.743216	2025-07-06 15:11:47.743218	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1676	rose	\N	\N	noun	2	0	2	2025-07-06 15:11:47.745329	2025-07-06 15:11:47.745331	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1677	rough	\N	\N	noun	3	0	4	2025-07-06 15:11:47.747427	2025-07-06 15:11:47.747429	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1678	roughly	\N	\N	adverb	4	0	4	2025-07-06 15:11:47.749448	2025-07-06 15:11:47.74945	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1679	round	\N	\N	noun	3	0	2	2025-07-06 15:11:47.751882	2025-07-06 15:11:47.751884	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1680	routine	\N	\N	noun	4	0	3	2025-07-06 15:11:47.754355	2025-07-06 15:11:47.754357	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1681	row	\N	\N	noun	1	0	1	2025-07-06 15:11:47.75652	2025-07-06 15:11:47.756522	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1682	royal	\N	\N	noun	3	0	2	2025-07-06 15:11:47.759152	2025-07-06 15:11:47.759154	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1683	rub	\N	\N	noun	1	0	1	2025-07-06 15:11:47.761363	2025-07-06 15:11:47.761365	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1684	rubber	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.763503	2025-07-06 15:11:47.763505	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1685	rubbish	\N	\N	noun	4	0	3	2025-07-06 15:11:47.765623	2025-07-06 15:11:47.765625	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1686	rude	\N	\N	noun	2	0	2	2025-07-06 15:11:47.768068	2025-07-06 15:11:47.76807	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1687	rug	\N	\N	noun	1	0	1	2025-07-06 15:11:47.770279	2025-07-06 15:11:47.770281	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1688	ruin	\N	\N	noun	2	0	2	2025-07-06 15:11:47.772403	2025-07-06 15:11:47.772405	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1689	ruins	\N	\N	noun	3	0	2	2025-07-06 15:11:47.774789	2025-07-06 15:11:47.774791	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1691	ruler	\N	\N	adjective	3	0	2	2025-07-06 15:11:47.779077	2025-07-06 15:11:47.779079	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1692	rumour	\N	\N	noun	3	0	3	2025-07-06 15:11:47.781365	2025-07-06 15:11:47.781367	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1694	rural	\N	\N	noun	3	0	2	2025-07-06 15:11:47.785511	2025-07-06 15:11:47.785512	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1695	rush	\N	\N	noun	2	0	2	2025-07-06 15:11:47.78771	2025-07-06 15:11:47.787712	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1696	rust	\N	\N	noun	2	0	2	2025-07-06 15:11:47.789867	2025-07-06 15:11:47.789869	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1697	s	\N	\N	noun	1	0	1	2025-07-06 15:11:47.7921	2025-07-06 15:11:47.792102	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1698	sac	\N	\N	noun	1	0	1	2025-07-06 15:11:47.794193	2025-07-06 15:11:47.794195	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1699	sacred	\N	\N	verb	3	0	3	2025-07-06 15:11:47.7964	2025-07-06 15:11:47.796402	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1700	sacrifice	\N	\N	noun	5	0	4	2025-07-06 15:11:47.798472	2025-07-06 15:11:47.798474	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1701	sad	\N	\N	noun	1	0	1	2025-07-06 15:11:47.800646	2025-07-06 15:11:47.800648	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1702	saddle	\N	\N	noun	3	0	3	2025-07-06 15:11:47.802858	2025-07-06 15:11:47.80286	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1703	sadly	\N	\N	adverb	3	0	2	2025-07-06 15:11:47.805025	2025-07-06 15:11:47.805027	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1704	safe	\N	\N	noun	2	0	2	2025-07-06 15:11:47.807113	2025-07-06 15:11:47.807115	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1705	safely	\N	\N	adverb	3	0	3	2025-07-06 15:11:47.809107	2025-07-06 15:11:47.809109	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1706	safety	\N	\N	noun	3	0	3	2025-07-06 15:11:47.811111	2025-07-06 15:11:47.811112	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1707	sail	\N	\N	noun	2	0	2	2025-07-06 15:11:47.813243	2025-07-06 15:11:47.813245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1708	sailor	\N	\N	noun	3	0	3	2025-07-06 15:11:47.815569	2025-07-06 15:11:47.815571	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1709	saint	\N	\N	noun	3	0	2	2025-07-06 15:11:47.817728	2025-07-06 15:11:47.81773	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1710	sake	\N	\N	noun	2	0	2	2025-07-06 15:11:47.819974	2025-07-06 15:11:47.819976	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1711	salad	\N	\N	noun	3	0	2	2025-07-06 15:11:47.822253	2025-07-06 15:11:47.822255	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1712	salary	\N	\N	noun	3	0	3	2025-07-06 15:11:47.824457	2025-07-06 15:11:47.824459	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1713	sale	\N	\N	noun	2	0	2	2025-07-06 15:11:47.826483	2025-07-06 15:11:47.826485	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1714	salt	\N	\N	noun	2	0	2	2025-07-06 15:11:47.828572	2025-07-06 15:11:47.828574	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1715	sample	\N	\N	noun	3	0	3	2025-07-06 15:11:47.830538	2025-07-06 15:11:47.83054	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1716	sand	\N	\N	noun	2	0	2	2025-07-06 15:11:47.83408	2025-07-06 15:11:47.834082	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1717	satellite	\N	\N	noun	5	0	4	2025-07-06 15:11:47.837639	2025-07-06 15:11:47.837641	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1718	satisfaction	\N	\N	noun	6	0	4	2025-07-06 15:11:47.840317	2025-07-06 15:11:47.840319	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1719	satisfactory	\N	\N	noun	6	0	5	2025-07-06 15:11:47.843153	2025-07-06 15:11:47.843155	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1720	satisfied	\N	\N	verb	5	0	4	2025-07-06 15:11:47.84524	2025-07-06 15:11:47.845242	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1721	sauce	\N	\N	noun	3	0	2	2025-07-06 15:11:47.847366	2025-07-06 15:11:47.847368	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1722	saucer	\N	\N	adjective	3	0	3	2025-07-06 15:11:47.850271	2025-07-06 15:11:47.850273	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1724	save	\N	\N	noun	2	0	2	2025-07-06 15:11:47.855251	2025-07-06 15:11:47.855253	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1725	saving	\N	\N	verb	3	0	3	2025-07-06 15:11:47.857251	2025-07-06 15:11:47.857253	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1726	saw	\N	\N	noun	1	0	1	2025-07-06 15:11:47.859331	2025-07-06 15:11:47.859333	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1727	say	\N	\N	noun	1	0	1	2025-07-06 15:11:47.861296	2025-07-06 15:11:47.861298	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1728	scale	\N	\N	noun	3	0	2	2025-07-06 15:11:47.863915	2025-07-06 15:11:47.863917	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1729	scan	\N	\N	noun	2	0	2	2025-07-06 15:11:47.866727	2025-07-06 15:11:47.866729	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1730	scandal	\N	\N	noun	4	0	3	2025-07-06 15:11:47.869126	2025-07-06 15:11:47.869128	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1731	scar	\N	\N	noun	2	0	2	2025-07-06 15:11:47.872006	2025-07-06 15:11:47.872009	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1732	scarcely	\N	\N	adverb	4	0	4	2025-07-06 15:11:47.87431	2025-07-06 15:11:47.874312	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1733	scare	\N	\N	noun	3	0	2	2025-07-06 15:11:47.876323	2025-07-06 15:11:47.876325	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1734	scarf	\N	\N	noun	3	0	2	2025-07-06 15:11:47.878406	2025-07-06 15:11:47.878408	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1735	scene	\N	\N	noun	3	0	2	2025-07-06 15:11:47.880514	2025-07-06 15:11:47.880516	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1736	scenery	\N	\N	noun	4	0	3	2025-07-06 15:11:47.882845	2025-07-06 15:11:47.882847	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1737	schedule	\N	\N	noun	4	0	4	2025-07-06 15:11:47.88546	2025-07-06 15:11:47.885462	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1738	scheme	\N	\N	noun	3	0	3	2025-07-06 15:11:47.88771	2025-07-06 15:11:47.887711	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1739	scholar	\N	\N	noun	4	0	3	2025-07-06 15:11:47.88979	2025-07-06 15:11:47.889792	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1740	scholarship	\N	\N	noun	6	0	5	2025-07-06 15:11:47.89235	2025-07-06 15:11:47.892352	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1741	science	\N	\N	noun	4	0	3	2025-07-06 15:11:47.894854	2025-07-06 15:11:47.894856	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1742	scientific	\N	\N	noun	5	0	5	2025-07-06 15:11:47.897097	2025-07-06 15:11:47.897099	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1743	scientist	\N	\N	noun	5	0	4	2025-07-06 15:11:47.899258	2025-07-06 15:11:47.899259	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1745	scope	\N	\N	noun	3	0	2	2025-07-06 15:11:47.904025	2025-07-06 15:11:47.904027	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1746	score	\N	\N	noun	3	0	2	2025-07-06 15:11:47.906074	2025-07-06 15:11:47.906076	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1747	scout	\N	\N	noun	3	0	2	2025-07-06 15:11:47.908108	2025-07-06 15:11:47.90811	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1748	scramble	\N	\N	noun	4	0	4	2025-07-06 15:11:47.910112	2025-07-06 15:11:47.910113	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1749	scratch	\N	\N	noun	4	0	3	2025-07-06 15:11:47.912187	2025-07-06 15:11:47.912189	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1750	scream	\N	\N	noun	3	0	3	2025-07-06 15:11:47.914198	2025-07-06 15:11:47.9142	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1751	screen	\N	\N	noun	3	0	3	2025-07-06 15:11:47.916375	2025-07-06 15:11:47.916378	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1752	screw	\N	\N	noun	3	0	2	2025-07-06 15:11:47.918623	2025-07-06 15:11:47.918625	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1753	script	\N	\N	noun	3	0	3	2025-07-06 15:11:47.920707	2025-07-06 15:11:47.920709	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1754	sculpture	\N	\N	noun	5	0	4	2025-07-06 15:11:47.922773	2025-07-06 15:11:47.922775	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1755	sea	\N	\N	noun	1	0	1	2025-07-06 15:11:47.924741	2025-07-06 15:11:47.924743	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1756	seafood	\N	\N	noun	4	0	3	2025-07-06 15:11:47.926722	2025-07-06 15:11:47.926724	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1757	seal	\N	\N	noun	2	0	2	2025-07-06 15:11:47.928671	2025-07-06 15:11:47.928673	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1758	search	\N	\N	noun	3	0	3	2025-07-06 15:11:47.930696	2025-07-06 15:11:47.930698	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1760	seat	\N	\N	noun	2	0	2	2025-07-06 15:11:47.934684	2025-07-06 15:11:47.934686	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1761	second	\N	\N	noun	3	0	3	2025-07-06 15:11:47.936833	2025-07-06 15:11:47.936834	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1762	secret	\N	\N	noun	3	0	3	2025-07-06 15:11:47.938882	2025-07-06 15:11:47.938884	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1763	secretary	\N	\N	noun	5	0	4	2025-07-06 15:11:47.940774	2025-07-06 15:11:47.940776	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1764	secretly	\N	\N	adverb	4	0	4	2025-07-06 15:11:47.942881	2025-07-06 15:11:47.942883	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1765	section	\N	\N	noun	4	0	4	2025-07-06 15:11:47.944998	2025-07-06 15:11:47.945	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1766	sector	\N	\N	noun	3	0	3	2025-07-06 15:11:47.94706	2025-07-06 15:11:47.947062	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1767	secure	\N	\N	noun	3	0	3	2025-07-06 15:11:47.949111	2025-07-06 15:11:47.949112	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1768	security	\N	\N	noun	4	0	4	2025-07-06 15:11:47.951498	2025-07-06 15:11:47.9515	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1769	see	\N	\N	noun	1	0	1	2025-07-06 15:11:47.953786	2025-07-06 15:11:47.953788	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1770	seed	\N	\N	noun	2	0	2	2025-07-06 15:11:47.956101	2025-07-06 15:11:47.956103	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1771	seek	\N	\N	noun	2	0	2	2025-07-06 15:11:47.95837	2025-07-06 15:11:47.958372	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1772	seem	\N	\N	noun	2	0	2	2025-07-06 15:11:47.960708	2025-07-06 15:11:47.96071	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1773	seize	\N	\N	noun	3	0	2	2025-07-06 15:11:47.962722	2025-07-06 15:11:47.962724	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1774	seldom	\N	\N	noun	3	0	3	2025-07-06 15:11:47.964584	2025-07-06 15:11:47.964586	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1775	selection	\N	\N	noun	5	0	4	2025-07-06 15:11:47.96715	2025-07-06 15:11:47.967153	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1776	self	\N	\N	noun	2	0	2	2025-07-06 15:11:47.969622	2025-07-06 15:11:47.969624	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1778	semester	\N	\N	adjective	4	0	4	2025-07-06 15:11:47.973966	2025-07-06 15:11:47.973967	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1779	seminar	\N	\N	noun	4	0	3	2025-07-06 15:11:47.976226	2025-07-06 15:11:47.976228	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1780	send	\N	\N	noun	2	0	2	2025-07-06 15:11:47.9788	2025-07-06 15:11:47.978802	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1781	senior	\N	\N	noun	3	0	3	2025-07-06 15:11:47.980942	2025-07-06 15:11:47.980943	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1782	sense	\N	\N	noun	3	0	2	2025-07-06 15:11:47.982944	2025-07-06 15:11:47.982962	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1783	sensitive	\N	\N	adjective	5	0	4	2025-07-06 15:11:47.984994	2025-07-06 15:11:47.984996	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1784	sentence	\N	\N	noun	4	0	4	2025-07-06 15:11:47.987087	2025-07-06 15:11:47.987089	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1785	separate	\N	\N	noun	4	0	4	2025-07-06 15:11:47.989203	2025-07-06 15:11:47.989205	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1786	series	\N	\N	noun	3	0	3	2025-07-06 15:11:47.991245	2025-07-06 15:11:47.991247	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1787	serious	\N	\N	adjective	4	0	3	2025-07-06 15:11:47.993334	2025-07-06 15:11:47.993335	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1788	seriously	\N	\N	adverb	5	0	4	2025-07-06 15:11:47.995345	2025-07-06 15:11:47.995347	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1789	servant	\N	\N	noun	4	0	3	2025-07-06 15:11:47.997742	2025-07-06 15:11:47.997744	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1790	serve	\N	\N	noun	3	0	2	2025-07-06 15:11:48.00009	2025-07-06 15:11:48.000092	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1791	service	\N	\N	noun	4	0	3	2025-07-06 15:11:48.002275	2025-07-06 15:11:48.002277	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1792	session	\N	\N	noun	4	0	4	2025-07-06 15:11:48.004512	2025-07-06 15:11:48.004515	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1793	set	\N	\N	noun	1	0	1	2025-07-06 15:11:48.00681	2025-07-06 15:11:48.006812	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1794	setting	\N	\N	verb	4	0	3	2025-07-06 15:11:48.009071	2025-07-06 15:11:48.009073	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1795	settle	\N	\N	noun	3	0	3	2025-07-06 15:11:48.011293	2025-07-06 15:11:48.011294	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1796	settlement	\N	\N	noun	5	0	5	2025-07-06 15:11:48.013583	2025-07-06 15:11:48.013585	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1797	seven	\N	\N	noun	3	0	2	2025-07-06 15:11:48.015895	2025-07-06 15:11:48.015897	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1798	seventeen	\N	\N	noun	5	0	4	2025-07-06 15:11:48.018217	2025-07-06 15:11:48.018219	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1799	seventh	\N	\N	noun	4	0	3	2025-07-06 15:11:48.020321	2025-07-06 15:11:48.020323	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1801	several	\N	\N	noun	4	0	3	2025-07-06 15:11:48.024552	2025-07-06 15:11:48.024554	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1802	severe	\N	\N	noun	3	0	3	2025-07-06 15:11:48.02665	2025-07-06 15:11:48.026652	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1803	sew	\N	\N	noun	1	0	1	2025-07-06 15:11:48.028616	2025-07-06 15:11:48.028618	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1804	sex	\N	\N	noun	1	0	1	2025-07-06 15:11:48.030706	2025-07-06 15:11:48.030725	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1805	shade	\N	\N	noun	3	0	2	2025-07-06 15:11:48.032741	2025-07-06 15:11:48.032743	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1806	shadow	\N	\N	noun	3	0	3	2025-07-06 15:11:48.034742	2025-07-06 15:11:48.034744	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1807	shaft	\N	\N	noun	3	0	2	2025-07-06 15:11:48.036726	2025-07-06 15:11:48.036728	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1808	shake	\N	\N	noun	3	0	2	2025-07-06 15:11:48.038764	2025-07-06 15:11:48.038767	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1809	shallow	\N	\N	noun	4	0	3	2025-07-06 15:11:48.041054	2025-07-06 15:11:48.041056	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1810	shame	\N	\N	noun	3	0	2	2025-07-06 15:11:48.043116	2025-07-06 15:11:48.043118	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1811	shape	\N	\N	noun	3	0	2	2025-07-06 15:11:48.045257	2025-07-06 15:11:48.045259	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1812	share	\N	\N	noun	3	0	2	2025-07-06 15:11:48.047326	2025-07-06 15:11:48.047328	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1813	shark	\N	\N	noun	3	0	2	2025-07-06 15:11:48.049444	2025-07-06 15:11:48.049446	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1814	sharp	\N	\N	noun	3	0	2	2025-07-06 15:11:48.051639	2025-07-06 15:11:48.051641	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1815	shave	\N	\N	noun	3	0	2	2025-07-06 15:11:48.053699	2025-07-06 15:11:48.053701	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1816	she	\N	\N	pronoun	1	0	1	2025-07-06 15:11:48.057449	2025-07-06 15:11:48.057451	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1817	sheep	\N	\N	noun	3	0	2	2025-07-06 15:11:48.06027	2025-07-06 15:11:48.060272	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1818	sheet	\N	\N	noun	3	0	2	2025-07-06 15:11:48.063085	2025-07-06 15:11:48.063087	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1819	shelf	\N	\N	noun	3	0	2	2025-07-06 15:11:48.0652	2025-07-06 15:11:48.065202	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1820	shell	\N	\N	noun	3	0	2	2025-07-06 15:11:48.067532	2025-07-06 15:11:48.067534	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1821	shelter	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.070063	2025-07-06 15:11:48.070065	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1822	shepherd	\N	\N	noun	4	0	4	2025-07-06 15:11:48.073027	2025-07-06 15:11:48.073028	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1823	shield	\N	\N	noun	3	0	3	2025-07-06 15:11:48.075097	2025-07-06 15:11:48.075099	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1824	shift	\N	\N	noun	3	0	2	2025-07-06 15:11:48.077309	2025-07-06 15:11:48.077311	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1825	shine	\N	\N	noun	3	0	2	2025-07-06 15:11:48.079432	2025-07-06 15:11:48.079433	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1826	ship	\N	\N	noun	2	0	2	2025-07-06 15:11:48.081582	2025-07-06 15:11:48.081584	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1827	shirt	\N	\N	noun	3	0	2	2025-07-06 15:11:48.083718	2025-07-06 15:11:48.08372	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1828	shock	\N	\N	noun	3	0	2	2025-07-06 15:11:48.085769	2025-07-06 15:11:48.085771	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1829	shoe	\N	\N	noun	2	0	2	2025-07-06 15:11:48.087923	2025-07-06 15:11:48.087926	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1830	shoes	\N	\N	noun	3	0	2	2025-07-06 15:11:48.090009	2025-07-06 15:11:48.09001	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1831	shoot	\N	\N	noun	3	0	2	2025-07-06 15:11:48.091932	2025-07-06 15:11:48.091934	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1832	shop	\N	\N	noun	2	0	2	2025-07-06 15:11:48.094014	2025-07-06 15:11:48.094016	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1833	shore	\N	\N	noun	3	0	2	2025-07-06 15:11:48.096248	2025-07-06 15:11:48.09625	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1835	shortly	\N	\N	adverb	4	0	3	2025-07-06 15:11:48.100427	2025-07-06 15:11:48.100429	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1836	shorts	\N	\N	noun	3	0	3	2025-07-06 15:11:48.103013	2025-07-06 15:11:48.103015	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1837	shot	\N	\N	noun	2	0	2	2025-07-06 15:11:48.105148	2025-07-06 15:11:48.10515	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1840	shout	\N	\N	noun	3	0	2	2025-07-06 15:11:48.111541	2025-07-06 15:11:48.111543	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1842	shower	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.115856	2025-07-06 15:11:48.115858	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1843	shrink	\N	\N	noun	3	0	3	2025-07-06 15:11:48.117982	2025-07-06 15:11:48.117984	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1844	shut	\N	\N	noun	2	0	2	2025-07-06 15:11:48.120181	2025-07-06 15:11:48.120183	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1845	shuttle	\N	\N	noun	4	0	3	2025-07-06 15:11:48.122296	2025-07-06 15:11:48.122298	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1846	shy	\N	\N	noun	1	0	1	2025-07-06 15:11:48.124428	2025-07-06 15:11:48.12443	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1847	sick	\N	\N	noun	2	0	2	2025-07-06 15:11:48.126659	2025-07-06 15:11:48.126661	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1848	side	\N	\N	noun	2	0	2	2025-07-06 15:11:48.128802	2025-07-06 15:11:48.128804	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1849	sigh	\N	\N	noun	2	0	2	2025-07-06 15:11:48.130879	2025-07-06 15:11:48.130881	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1850	sight	\N	\N	noun	3	0	4	2025-07-06 15:11:48.132919	2025-07-06 15:11:48.13292	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1851	sign	\N	\N	noun	2	0	2	2025-07-06 15:11:48.134942	2025-07-06 15:11:48.134944	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1852	signal	\N	\N	noun	3	0	3	2025-07-06 15:11:48.137528	2025-07-06 15:11:48.137546	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1853	signature	\N	\N	noun	5	0	4	2025-07-06 15:11:48.139672	2025-07-06 15:11:48.139674	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1854	significance	\N	\N	noun	6	0	5	2025-07-06 15:11:48.142806	2025-07-06 15:11:48.142808	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1855	significant	\N	\N	noun	6	0	5	2025-07-06 15:11:48.146479	2025-07-06 15:11:48.146481	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1856	silence	\N	\N	noun	4	0	3	2025-07-06 15:11:48.148995	2025-07-06 15:11:48.148997	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1857	silent	\N	\N	noun	3	0	3	2025-07-06 15:11:48.151014	2025-07-06 15:11:48.151016	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1858	silently	\N	\N	adverb	4	0	4	2025-07-06 15:11:48.153261	2025-07-06 15:11:48.153279	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1859	silk	\N	\N	noun	2	0	2	2025-07-06 15:11:48.155487	2025-07-06 15:11:48.155489	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1860	silly	\N	\N	adverb	3	0	2	2025-07-06 15:11:48.157505	2025-07-06 15:11:48.157507	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1861	silver	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.159739	2025-07-06 15:11:48.159741	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1862	similar	\N	\N	noun	4	0	3	2025-07-06 15:11:48.161909	2025-07-06 15:11:48.161911	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1863	simple	\N	\N	noun	3	0	3	2025-07-06 15:11:48.164073	2025-07-06 15:11:48.164075	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1864	simplicity	\N	\N	noun	5	0	5	2025-07-06 15:11:48.166191	2025-07-06 15:11:48.166192	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1865	simply	\N	\N	adverb	3	0	3	2025-07-06 15:11:48.168467	2025-07-06 15:11:48.168469	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1866	sin	\N	\N	noun	1	0	1	2025-07-06 15:11:48.170879	2025-07-06 15:11:48.170898	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1867	since	\N	\N	conjunction	3	0	2	2025-07-06 15:11:48.172908	2025-07-06 15:11:48.17291	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1868	sincere	\N	\N	noun	4	0	3	2025-07-06 15:11:48.17503	2025-07-06 15:11:48.175032	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1869	sincerely	\N	\N	adverb	5	0	4	2025-07-06 15:11:48.177069	2025-07-06 15:11:48.177071	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1870	sing	\N	\N	noun	2	0	2	2025-07-06 15:11:48.179296	2025-07-06 15:11:48.179298	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1871	singer	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.181355	2025-07-06 15:11:48.181357	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1872	single	\N	\N	noun	3	0	3	2025-07-06 15:11:48.18339	2025-07-06 15:11:48.183392	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1873	sink	\N	\N	noun	2	0	2	2025-07-06 15:11:48.185725	2025-07-06 15:11:48.185727	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1874	sir	\N	\N	noun	1	0	1	2025-07-06 15:11:48.18777	2025-07-06 15:11:48.187772	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1875	sit	\N	\N	noun	1	0	1	2025-07-06 15:11:48.190277	2025-07-06 15:11:48.190279	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1876	site	\N	\N	noun	2	0	2	2025-07-06 15:11:48.192319	2025-07-06 15:11:48.192321	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1877	situation	\N	\N	noun	5	0	4	2025-07-06 15:11:48.194243	2025-07-06 15:11:48.194245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1878	six	\N	\N	noun	1	0	1	2025-07-06 15:11:48.196277	2025-07-06 15:11:48.196279	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1879	sixteen	\N	\N	noun	4	0	3	2025-07-06 15:11:48.198333	2025-07-06 15:11:48.198335	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1880	sixth	\N	\N	noun	3	0	2	2025-07-06 15:11:48.200662	2025-07-06 15:11:48.200664	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1882	size	\N	\N	noun	2	0	2	2025-07-06 15:11:48.205248	2025-07-06 15:11:48.20525	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1883	skate	\N	\N	noun	3	0	2	2025-07-06 15:11:48.207652	2025-07-06 15:11:48.207654	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1884	skeleton	\N	\N	noun	4	0	4	2025-07-06 15:11:48.20998	2025-07-06 15:11:48.209983	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1885	skilful	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.212056	2025-07-06 15:11:48.212058	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1886	skill	\N	\N	noun	3	0	2	2025-07-06 15:11:48.214095	2025-07-06 15:11:48.214097	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1887	skin	\N	\N	noun	2	0	2	2025-07-06 15:11:48.216068	2025-07-06 15:11:48.21607	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1888	skip	\N	\N	noun	2	0	2	2025-07-06 15:11:48.21811	2025-07-06 15:11:48.218112	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1889	skirt	\N	\N	noun	3	0	2	2025-07-06 15:11:48.220284	2025-07-06 15:11:48.220286	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1890	sky	\N	\N	noun	1	0	1	2025-07-06 15:11:48.222537	2025-07-06 15:11:48.222539	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1891	slab	\N	\N	noun	2	0	2	2025-07-06 15:11:48.2249	2025-07-06 15:11:48.224902	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1892	sleep	\N	\N	noun	3	0	2	2025-07-06 15:11:48.227033	2025-07-06 15:11:48.227035	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1893	sleepy	\N	\N	noun	3	0	3	2025-07-06 15:11:48.229082	2025-07-06 15:11:48.229084	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1894	slice	\N	\N	noun	3	0	2	2025-07-06 15:11:48.231494	2025-07-06 15:11:48.231496	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1895	slide	\N	\N	noun	3	0	2	2025-07-06 15:11:48.233798	2025-07-06 15:11:48.2338	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1896	slight	\N	\N	noun	3	0	4	2025-07-06 15:11:48.23625	2025-07-06 15:11:48.236252	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1897	slim	\N	\N	noun	2	0	2	2025-07-06 15:11:48.23885	2025-07-06 15:11:48.238852	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1898	slip	\N	\N	noun	2	0	2	2025-07-06 15:11:48.241101	2025-07-06 15:11:48.241103	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1899	slipper	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.243441	2025-07-06 15:11:48.243443	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1900	slope	\N	\N	noun	3	0	2	2025-07-06 15:11:48.245972	2025-07-06 15:11:48.245974	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1901	slow	\N	\N	noun	2	0	2	2025-07-06 15:11:48.248541	2025-07-06 15:11:48.248544	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1902	slowly	\N	\N	adverb	3	0	3	2025-07-06 15:11:48.250864	2025-07-06 15:11:48.250866	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1903	sly	\N	\N	adverb	1	0	1	2025-07-06 15:11:48.253122	2025-07-06 15:11:48.253124	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1904	small	\N	\N	noun	3	0	2	2025-07-06 15:11:48.255533	2025-07-06 15:11:48.255535	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1905	smart	\N	\N	noun	3	0	2	2025-07-06 15:11:48.257814	2025-07-06 15:11:48.257816	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1906	smell	\N	\N	noun	3	0	2	2025-07-06 15:11:48.260023	2025-07-06 15:11:48.260025	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1907	smile	\N	\N	noun	3	0	2	2025-07-06 15:11:48.262469	2025-07-06 15:11:48.262471	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1908	smoke	\N	\N	noun	3	0	2	2025-07-06 15:11:48.265129	2025-07-06 15:11:48.265131	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1909	smooth	\N	\N	noun	3	0	3	2025-07-06 15:11:48.267455	2025-07-06 15:11:48.267457	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1910	smoothly	\N	\N	adverb	4	0	4	2025-07-06 15:11:48.269905	2025-07-06 15:11:48.269907	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1911	snake	\N	\N	noun	3	0	2	2025-07-06 15:11:48.271875	2025-07-06 15:11:48.271877	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1912	snap	\N	\N	noun	2	0	2	2025-07-06 15:11:48.274049	2025-07-06 15:11:48.274051	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1915	soap	\N	\N	noun	2	0	2	2025-07-06 15:11:48.280242	2025-07-06 15:11:48.280244	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1916	social	\N	\N	noun	3	0	3	2025-07-06 15:11:48.283814	2025-07-06 15:11:48.283816	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1917	society	\N	\N	noun	4	0	3	2025-07-06 15:11:48.286834	2025-07-06 15:11:48.286836	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1918	sock	\N	\N	noun	2	0	2	2025-07-06 15:11:48.289712	2025-07-06 15:11:48.289714	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1919	socks	\N	\N	noun	3	0	2	2025-07-06 15:11:48.292871	2025-07-06 15:11:48.292873	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1920	sofa	\N	\N	noun	2	0	2	2025-07-06 15:11:48.294961	2025-07-06 15:11:48.294963	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1921	soft	\N	\N	noun	2	0	2	2025-07-06 15:11:48.297066	2025-07-06 15:11:48.297068	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1922	softly	\N	\N	adverb	3	0	3	2025-07-06 15:11:48.299195	2025-07-06 15:11:48.299197	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1923	software	\N	\N	noun	4	0	4	2025-07-06 15:11:48.301293	2025-07-06 15:11:48.301295	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1924	soil	\N	\N	noun	2	0	2	2025-07-06 15:11:48.303392	2025-07-06 15:11:48.303394	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1925	solar	\N	\N	noun	3	0	2	2025-07-06 15:11:48.305735	2025-07-06 15:11:48.305737	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1926	soldier	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.308046	2025-07-06 15:11:48.308048	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1927	sole	\N	\N	noun	2	0	2	2025-07-06 15:11:48.310386	2025-07-06 15:11:48.310388	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1928	solid	\N	\N	noun	3	0	2	2025-07-06 15:11:48.312995	2025-07-06 15:11:48.312997	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1929	solution	\N	\N	noun	4	0	4	2025-07-06 15:11:48.315425	2025-07-06 15:11:48.315428	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1930	solve	\N	\N	noun	3	0	2	2025-07-06 15:11:48.317783	2025-07-06 15:11:48.317786	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1931	some	\N	\N	noun	1	0	2	2025-07-06 15:11:48.320046	2025-07-06 15:11:48.320048	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1932	somebody	\N	\N	noun	4	0	4	2025-07-06 15:11:48.322423	2025-07-06 15:11:48.322424	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1933	somehow	\N	\N	noun	4	0	3	2025-07-06 15:11:48.324772	2025-07-06 15:11:48.324774	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1934	someone	\N	\N	noun	4	0	3	2025-07-06 15:11:48.326966	2025-07-06 15:11:48.326968	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1935	something	\N	\N	verb	5	0	4	2025-07-06 15:11:48.329007	2025-07-06 15:11:48.329008	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1936	sometime	\N	\N	noun	4	0	4	2025-07-06 15:11:48.332376	2025-07-06 15:11:48.332378	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1938	somewhat	\N	\N	noun	4	0	4	2025-07-06 15:11:48.337285	2025-07-06 15:11:48.337287	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1939	somewhere	\N	\N	noun	5	0	4	2025-07-06 15:11:48.339352	2025-07-06 15:11:48.339354	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1940	son	\N	\N	noun	1	0	1	2025-07-06 15:11:48.341508	2025-07-06 15:11:48.34151	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1941	song	\N	\N	noun	2	0	2	2025-07-06 15:11:48.343759	2025-07-06 15:11:48.343761	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1942	soon	\N	\N	noun	2	0	2	2025-07-06 15:11:48.346028	2025-07-06 15:11:48.34603	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1943	sore	\N	\N	noun	2	0	2	2025-07-06 15:11:48.347936	2025-07-06 15:11:48.347938	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1944	sorry	\N	\N	noun	3	0	2	2025-07-06 15:11:48.349983	2025-07-06 15:11:48.349985	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1945	sort	\N	\N	noun	2	0	2	2025-07-06 15:11:48.352953	2025-07-06 15:11:48.352955	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1946	soul	\N	\N	noun	2	0	2	2025-07-06 15:11:48.355394	2025-07-06 15:11:48.355396	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1947	sound	\N	\N	noun	3	0	2	2025-07-06 15:11:48.357957	2025-07-06 15:11:48.357959	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1948	soup	\N	\N	noun	2	0	2	2025-07-06 15:11:48.360692	2025-07-06 15:11:48.360694	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1949	source	\N	\N	noun	3	0	3	2025-07-06 15:11:48.36282	2025-07-06 15:11:48.362822	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1950	south	\N	\N	noun	3	0	2	2025-07-06 15:11:48.365368	2025-07-06 15:11:48.36537	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1951	sow	\N	\N	noun	1	0	1	2025-07-06 15:11:48.367801	2025-07-06 15:11:48.367803	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1952	space	\N	\N	noun	3	0	2	2025-07-06 15:11:48.370311	2025-07-06 15:11:48.370313	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1953	spade	\N	\N	noun	3	0	2	2025-07-06 15:11:48.372331	2025-07-06 15:11:48.372333	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1954	span	\N	\N	noun	2	0	2	2025-07-06 15:11:48.374493	2025-07-06 15:11:48.374494	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1955	spare	\N	\N	noun	3	0	2	2025-07-06 15:11:48.376465	2025-07-06 15:11:48.376467	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1956	sparkle	\N	\N	noun	4	0	3	2025-07-06 15:11:48.378459	2025-07-06 15:11:48.37846	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1958	speaker	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.382603	2025-07-06 15:11:48.382605	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1959	special	\N	\N	noun	4	0	3	2025-07-06 15:11:48.384682	2025-07-06 15:11:48.384684	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1960	specialist	\N	\N	noun	5	0	5	2025-07-06 15:11:48.386841	2025-07-06 15:11:48.386843	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1961	species	\N	\N	noun	4	0	3	2025-07-06 15:11:48.388909	2025-07-06 15:11:48.388911	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1962	specific	\N	\N	noun	4	0	4	2025-07-06 15:11:48.391076	2025-07-06 15:11:48.391078	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1963	specify	\N	\N	noun	4	0	3	2025-07-06 15:11:48.393215	2025-07-06 15:11:48.393217	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1964	spectacle	\N	\N	noun	5	0	4	2025-07-06 15:11:48.395344	2025-07-06 15:11:48.395346	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1965	speech	\N	\N	noun	3	0	3	2025-07-06 15:11:48.397534	2025-07-06 15:11:48.397536	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1966	speed	\N	\N	verb	3	0	2	2025-07-06 15:11:48.400038	2025-07-06 15:11:48.40004	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1967	spell	\N	\N	noun	3	0	2	2025-07-06 15:11:48.402221	2025-07-06 15:11:48.402223	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1969	spice	\N	\N	noun	3	0	2	2025-07-06 15:11:48.407478	2025-07-06 15:11:48.407481	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1970	spicy	\N	\N	noun	3	0	2	2025-07-06 15:11:48.409799	2025-07-06 15:11:48.409801	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1971	spider	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.41189	2025-07-06 15:11:48.411908	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1972	spill	\N	\N	noun	3	0	2	2025-07-06 15:11:48.413883	2025-07-06 15:11:48.413885	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1973	spin	\N	\N	noun	2	0	2	2025-07-06 15:11:48.416015	2025-07-06 15:11:48.416017	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1974	spirit	\N	\N	noun	3	0	3	2025-07-06 15:11:48.418048	2025-07-06 15:11:48.41805	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1975	spiritual	\N	\N	noun	5	0	4	2025-07-06 15:11:48.420248	2025-07-06 15:11:48.42025	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1976	spit	\N	\N	noun	2	0	2	2025-07-06 15:11:48.422369	2025-07-06 15:11:48.422371	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1977	spite	\N	\N	noun	3	0	2	2025-07-06 15:11:48.424513	2025-07-06 15:11:48.424514	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1978	splash	\N	\N	noun	3	0	3	2025-07-06 15:11:48.426562	2025-07-06 15:11:48.426564	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1979	splendid	\N	\N	noun	4	0	4	2025-07-06 15:11:48.428584	2025-07-06 15:11:48.428586	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1980	split	\N	\N	noun	3	0	2	2025-07-06 15:11:48.430842	2025-07-06 15:11:48.430844	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1981	spoil	\N	\N	noun	3	0	2	2025-07-06 15:11:48.433005	2025-07-06 15:11:48.433007	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1982	sponsor	\N	\N	noun	4	0	3	2025-07-06 15:11:48.435125	2025-07-06 15:11:48.435127	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1983	spontaneous	\N	\N	adjective	6	0	5	2025-07-06 15:11:48.437558	2025-07-06 15:11:48.43756	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1984	spoon	\N	\N	noun	3	0	2	2025-07-06 15:11:48.440726	2025-07-06 15:11:48.440728	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1985	sport	\N	\N	noun	3	0	2	2025-07-06 15:11:48.442763	2025-07-06 15:11:48.442765	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1986	spot	\N	\N	noun	2	0	2	2025-07-06 15:11:48.444756	2025-07-06 15:11:48.444758	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1987	spouse	\N	\N	noun	3	0	3	2025-07-06 15:11:48.446665	2025-07-06 15:11:48.446667	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1988	spread	\N	\N	noun	3	0	3	2025-07-06 15:11:48.448759	2025-07-06 15:11:48.448761	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1989	spring	\N	\N	verb	3	0	3	2025-07-06 15:11:48.450864	2025-07-06 15:11:48.450866	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1990	sprinkle	\N	\N	noun	4	0	4	2025-07-06 15:11:48.453042	2025-07-06 15:11:48.453044	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1992	squeeze	\N	\N	noun	4	0	3	2025-07-06 15:11:48.457219	2025-07-06 15:11:48.457221	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1993	squirrel	\N	\N	noun	4	0	4	2025-07-06 15:11:48.459308	2025-07-06 15:11:48.45931	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1994	stable	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.46131	2025-07-06 15:11:48.461311	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1995	stadium	\N	\N	noun	4	0	3	2025-07-06 15:11:48.463382	2025-07-06 15:11:48.463384	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1996	staff	\N	\N	noun	3	0	2	2025-07-06 15:11:48.465586	2025-07-06 15:11:48.465587	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1997	stage	\N	\N	noun	3	0	2	2025-07-06 15:11:48.467852	2025-07-06 15:11:48.467854	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1998	stair	\N	\N	noun	3	0	2	2025-07-06 15:11:48.470065	2025-07-06 15:11:48.470067	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
1999	stake	\N	\N	noun	3	0	2	2025-07-06 15:11:48.472453	2025-07-06 15:11:48.472455	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2000	stall	\N	\N	noun	3	0	2	2025-07-06 15:11:48.475136	2025-07-06 15:11:48.475139	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2001	stamp	\N	\N	noun	3	0	2	2025-07-06 15:11:48.478136	2025-07-06 15:11:48.478139	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2002	stand	\N	\N	noun	3	0	2	2025-07-06 15:11:48.480695	2025-07-06 15:11:48.480698	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2003	standard	\N	\N	noun	4	0	4	2025-07-06 15:11:48.483157	2025-07-06 15:11:48.48316	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2004	standing	\N	\N	verb	4	0	4	2025-07-06 15:11:48.48563	2025-07-06 15:11:48.485633	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2005	star	\N	\N	noun	2	0	2	2025-07-06 15:11:48.488328	2025-07-06 15:11:48.488331	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2006	stare	\N	\N	noun	3	0	2	2025-07-06 15:11:48.491098	2025-07-06 15:11:48.491101	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2008	starve	\N	\N	noun	3	0	3	2025-07-06 15:11:48.497682	2025-07-06 15:11:48.497686	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2009	state	\N	\N	noun	3	0	2	2025-07-06 15:11:48.500787	2025-07-06 15:11:48.500791	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2010	statement	\N	\N	noun	5	0	4	2025-07-06 15:11:48.503502	2025-07-06 15:11:48.503506	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2011	station	\N	\N	noun	4	0	4	2025-07-06 15:11:48.509778	2025-07-06 15:11:48.509783	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2012	statistics	\N	\N	noun	5	0	5	2025-07-06 15:11:48.513527	2025-07-06 15:11:48.51353	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2013	statue	\N	\N	noun	3	0	3	2025-07-06 15:11:48.516209	2025-07-06 15:11:48.516211	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2014	status	\N	\N	noun	3	0	3	2025-07-06 15:11:48.519938	2025-07-06 15:11:48.51994	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2015	stay	\N	\N	noun	2	0	2	2025-07-06 15:11:48.522249	2025-07-06 15:11:48.522251	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2016	steady	\N	\N	noun	3	0	3	2025-07-06 15:11:48.525978	2025-07-06 15:11:48.525981	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2017	steak	\N	\N	noun	3	0	2	2025-07-06 15:11:48.528904	2025-07-06 15:11:48.528906	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2018	steal	\N	\N	noun	3	0	2	2025-07-06 15:11:48.531029	2025-07-06 15:11:48.531031	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2019	steam	\N	\N	noun	3	0	2	2025-07-06 15:11:48.53323	2025-07-06 15:11:48.533232	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2020	steel	\N	\N	noun	3	0	2	2025-07-06 15:11:48.535871	2025-07-06 15:11:48.535873	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2021	steep	\N	\N	noun	3	0	2	2025-07-06 15:11:48.538172	2025-07-06 15:11:48.538174	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2022	steer	\N	\N	adjective	3	0	2	2025-07-06 15:11:48.5404	2025-07-06 15:11:48.540402	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2023	stem	\N	\N	noun	2	0	2	2025-07-06 15:11:48.542693	2025-07-06 15:11:48.542695	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2024	step	\N	\N	noun	2	0	2	2025-07-06 15:11:48.545249	2025-07-06 15:11:48.545251	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2025	stereo	\N	\N	noun	3	0	3	2025-07-06 15:11:48.547157	2025-07-06 15:11:48.547159	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2027	sticky	\N	\N	noun	3	0	3	2025-07-06 15:11:48.551077	2025-07-06 15:11:48.551079	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2028	stiff	\N	\N	noun	3	0	2	2025-07-06 15:11:48.553278	2025-07-06 15:11:48.55328	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2030	stimulate	\N	\N	noun	5	0	4	2025-07-06 15:11:48.557521	2025-07-06 15:11:48.557522	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2031	sting	\N	\N	verb	3	0	2	2025-07-06 15:11:48.560291	2025-07-06 15:11:48.560293	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2032	stir	\N	\N	noun	2	0	2	2025-07-06 15:11:48.562301	2025-07-06 15:11:48.562303	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2033	stitch	\N	\N	noun	3	0	3	2025-07-06 15:11:48.564481	2025-07-06 15:11:48.564483	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2034	stock	\N	\N	noun	3	0	2	2025-07-06 15:11:48.566472	2025-07-06 15:11:48.566474	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2035	stocking	\N	\N	verb	4	0	4	2025-07-06 15:11:48.568695	2025-07-06 15:11:48.568697	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2036	stomach	\N	\N	noun	4	0	3	2025-07-06 15:11:48.571344	2025-07-06 15:11:48.571362	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2037	stone	\N	\N	noun	3	0	2	2025-07-06 15:11:48.573275	2025-07-06 15:11:48.573277	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2038	stool	\N	\N	noun	3	0	2	2025-07-06 15:11:48.57536	2025-07-06 15:11:48.575362	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2039	stop	\N	\N	noun	2	0	2	2025-07-06 15:11:48.577543	2025-07-06 15:11:48.577545	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2040	store	\N	\N	noun	3	0	2	2025-07-06 15:11:48.579558	2025-07-06 15:11:48.57956	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2041	storm	\N	\N	noun	3	0	2	2025-07-06 15:11:48.581573	2025-07-06 15:11:48.581575	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2042	story	\N	\N	noun	3	0	2	2025-07-06 15:11:48.583645	2025-07-06 15:11:48.583647	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2043	stove	\N	\N	noun	3	0	2	2025-07-06 15:11:48.585733	2025-07-06 15:11:48.585735	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2044	straight	\N	\N	noun	4	0	4	2025-07-06 15:11:48.58772	2025-07-06 15:11:48.587722	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2045	strain	\N	\N	noun	3	0	3	2025-07-06 15:11:48.589686	2025-07-06 15:11:48.589688	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2046	strange	\N	\N	noun	4	0	3	2025-07-06 15:11:48.591663	2025-07-06 15:11:48.591665	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2047	stranger	\N	\N	adjective	4	0	4	2025-07-06 15:11:48.593774	2025-07-06 15:11:48.593776	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2048	strap	\N	\N	noun	3	0	2	2025-07-06 15:11:48.595824	2025-07-06 15:11:48.595826	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2049	strategy	\N	\N	noun	4	0	4	2025-07-06 15:11:48.598056	2025-07-06 15:11:48.598058	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2050	straw	\N	\N	noun	3	0	2	2025-07-06 15:11:48.600298	2025-07-06 15:11:48.6003	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2051	strawberry	\N	\N	noun	5	0	5	2025-07-06 15:11:48.602402	2025-07-06 15:11:48.602404	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2052	stream	\N	\N	noun	3	0	3	2025-07-06 15:11:48.604723	2025-07-06 15:11:48.604725	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2053	street	\N	\N	noun	3	0	3	2025-07-06 15:11:48.606889	2025-07-06 15:11:48.606891	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2054	strength	\N	\N	noun	4	0	4	2025-07-06 15:11:48.609069	2025-07-06 15:11:48.609071	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2055	strengthen	\N	\N	noun	5	0	5	2025-07-06 15:11:48.611314	2025-07-06 15:11:48.611316	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2056	stress	\N	\N	noun	3	0	3	2025-07-06 15:11:48.613599	2025-07-06 15:11:48.613601	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2057	stretch	\N	\N	noun	4	0	3	2025-07-06 15:11:48.615783	2025-07-06 15:11:48.615785	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2058	strict	\N	\N	noun	3	0	3	2025-07-06 15:11:48.617809	2025-07-06 15:11:48.617811	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2059	strike	\N	\N	noun	3	0	3	2025-07-06 15:11:48.62001	2025-07-06 15:11:48.620012	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2061	strip	\N	\N	noun	3	0	2	2025-07-06 15:11:48.624101	2025-07-06 15:11:48.624103	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2062	stripe	\N	\N	noun	3	0	3	2025-07-06 15:11:48.626236	2025-07-06 15:11:48.626238	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2063	stroke	\N	\N	noun	3	0	3	2025-07-06 15:11:48.62822	2025-07-06 15:11:48.628223	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2064	strong	\N	\N	noun	3	0	3	2025-07-06 15:11:48.630275	2025-07-06 15:11:48.630277	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2065	structure	\N	\N	noun	5	0	4	2025-07-06 15:11:48.63221	2025-07-06 15:11:48.632212	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2066	struggle	\N	\N	noun	4	0	4	2025-07-06 15:11:48.634211	2025-07-06 15:11:48.634213	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2067	student	\N	\N	noun	4	0	3	2025-07-06 15:11:48.636809	2025-07-06 15:11:48.636811	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2068	studio	\N	\N	noun	3	0	3	2025-07-06 15:11:48.63917	2025-07-06 15:11:48.639172	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2070	stuff	\N	\N	noun	3	0	2	2025-07-06 15:11:48.643747	2025-07-06 15:11:48.643749	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2071	stupid	\N	\N	noun	3	0	3	2025-07-06 15:11:48.645683	2025-07-06 15:11:48.645685	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2072	style	\N	\N	noun	3	0	2	2025-07-06 15:11:48.647667	2025-07-06 15:11:48.647669	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2074	submarine	\N	\N	noun	5	0	4	2025-07-06 15:11:48.651697	2025-07-06 15:11:48.651699	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2075	suburb	\N	\N	noun	3	0	3	2025-07-06 15:11:48.653775	2025-07-06 15:11:48.653777	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2076	subway	\N	\N	noun	3	0	3	2025-07-06 15:11:48.655807	2025-07-06 15:11:48.655809	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2077	succeed	\N	\N	verb	4	0	3	2025-07-06 15:11:48.657932	2025-07-06 15:11:48.657934	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2078	success	\N	\N	noun	4	0	3	2025-07-06 15:11:48.659906	2025-07-06 15:11:48.659908	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2079	successful	\N	\N	adjective	5	0	5	2025-07-06 15:11:48.661872	2025-07-06 15:11:48.661874	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2080	such	\N	\N	noun	2	0	2	2025-07-06 15:11:48.663861	2025-07-06 15:11:48.663863	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2081	suck	\N	\N	noun	2	0	2	2025-07-06 15:11:48.665802	2025-07-06 15:11:48.665804	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2082	sudden	\N	\N	noun	3	0	3	2025-07-06 15:11:48.667868	2025-07-06 15:11:48.66787	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2083	suffer	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.670075	2025-07-06 15:11:48.670077	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2084	sugar	\N	\N	noun	3	0	2	2025-07-06 15:11:48.672335	2025-07-06 15:11:48.672353	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2085	suggest	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.674648	2025-07-06 15:11:48.67465	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2086	suggestion	\N	\N	noun	5	0	4	2025-07-06 15:11:48.67684	2025-07-06 15:11:48.676842	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2087	suit	\N	\N	noun	2	0	2	2025-07-06 15:11:48.678758	2025-07-06 15:11:48.678759	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2088	suitable	\N	\N	adjective	4	0	4	2025-07-06 15:11:48.680783	2025-07-06 15:11:48.680785	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2089	sum	\N	\N	noun	1	0	1	2025-07-06 15:11:48.682628	2025-07-06 15:11:48.68263	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2090	summary	\N	\N	noun	4	0	3	2025-07-06 15:11:48.684778	2025-07-06 15:11:48.68478	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2091	summer	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.687001	2025-07-06 15:11:48.687003	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2092	summit	\N	\N	noun	3	0	3	2025-07-06 15:11:48.689083	2025-07-06 15:11:48.689085	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2093	sun	\N	\N	noun	1	0	1	2025-07-06 15:11:48.691012	2025-07-06 15:11:48.691014	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2094	sunny	\N	\N	noun	3	0	2	2025-07-06 15:11:48.693	2025-07-06 15:11:48.693002	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2095	sunrise	\N	\N	noun	4	0	3	2025-07-06 15:11:48.69505	2025-07-06 15:11:48.695052	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2096	sunset	\N	\N	noun	3	0	3	2025-07-06 15:11:48.696986	2025-07-06 15:11:48.696988	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2097	sunshine	\N	\N	noun	4	0	4	2025-07-06 15:11:48.699163	2025-07-06 15:11:48.699165	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2098	super	\N	\N	adjective	3	0	2	2025-07-06 15:11:48.70122	2025-07-06 15:11:48.701222	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2099	superb	\N	\N	noun	3	0	3	2025-07-06 15:11:48.703303	2025-07-06 15:11:48.703305	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2100	superior	\N	\N	noun	4	0	4	2025-07-06 15:11:48.705487	2025-07-06 15:11:48.705489	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2101	supermarket	\N	\N	noun	6	0	5	2025-07-06 15:11:48.708104	2025-07-06 15:11:48.708106	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2102	supper	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.711191	2025-07-06 15:11:48.711193	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2103	supplement	\N	\N	noun	5	0	5	2025-07-06 15:11:48.713238	2025-07-06 15:11:48.71324	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2104	supply	\N	\N	adverb	3	0	3	2025-07-06 15:11:48.715232	2025-07-06 15:11:48.715234	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2105	support	\N	\N	noun	4	0	3	2025-07-06 15:11:48.717276	2025-07-06 15:11:48.717278	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2106	supporter	\N	\N	adjective	5	0	4	2025-07-06 15:11:48.719399	2025-07-06 15:11:48.719423	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2107	suppose	\N	\N	noun	4	0	3	2025-07-06 15:11:48.721588	2025-07-06 15:11:48.72159	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2108	suppress	\N	\N	noun	4	0	4	2025-07-06 15:11:48.723725	2025-07-06 15:11:48.723727	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2109	supreme	\N	\N	noun	4	0	3	2025-07-06 15:11:48.726045	2025-07-06 15:11:48.726047	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2110	sure	\N	\N	noun	2	0	2	2025-07-06 15:11:48.728291	2025-07-06 15:11:48.728293	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2111	surely	\N	\N	adverb	3	0	3	2025-07-06 15:11:48.73028	2025-07-06 15:11:48.730282	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2112	surface	\N	\N	noun	4	0	3	2025-07-06 15:11:48.732344	2025-07-06 15:11:48.732346	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2113	surgeon	\N	\N	noun	4	0	3	2025-07-06 15:11:48.734308	2025-07-06 15:11:48.73431	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2114	surgery	\N	\N	noun	4	0	3	2025-07-06 15:11:48.736408	2025-07-06 15:11:48.73641	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2115	surprise	\N	\N	noun	4	0	4	2025-07-06 15:11:48.738264	2025-07-06 15:11:48.738266	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2116	surprised	\N	\N	verb	5	0	4	2025-07-06 15:11:48.74163	2025-07-06 15:11:48.741633	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2117	surrender	\N	\N	adjective	5	0	4	2025-07-06 15:11:48.744788	2025-07-06 15:11:48.74479	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2118	surround	\N	\N	noun	4	0	4	2025-07-06 15:11:48.746692	2025-07-06 15:11:48.746709	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2119	survey	\N	\N	noun	3	0	3	2025-07-06 15:11:48.749232	2025-07-06 15:11:48.749234	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2120	survive	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.752016	2025-07-06 15:11:48.752018	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2121	suspect	\N	\N	noun	4	0	3	2025-07-06 15:11:48.754455	2025-07-06 15:11:48.754457	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2122	suspend	\N	\N	noun	4	0	3	2025-07-06 15:11:48.756415	2025-07-06 15:11:48.756417	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2123	suspicion	\N	\N	noun	5	0	4	2025-07-06 15:11:48.758503	2025-07-06 15:11:48.758505	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2124	suspicious	\N	\N	adjective	5	0	5	2025-07-06 15:11:48.760426	2025-07-06 15:11:48.760428	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2125	sustain	\N	\N	noun	4	0	3	2025-07-06 15:11:48.762355	2025-07-06 15:11:48.762357	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2126	swallow	\N	\N	noun	4	0	3	2025-07-06 15:11:48.764306	2025-07-06 15:11:48.764308	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2127	swamp	\N	\N	noun	3	0	2	2025-07-06 15:11:48.766275	2025-07-06 15:11:48.766277	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2128	swan	\N	\N	noun	2	0	2	2025-07-06 15:11:48.768431	2025-07-06 15:11:48.768433	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2129	swap	\N	\N	noun	2	0	2	2025-07-06 15:11:48.771037	2025-07-06 15:11:48.771039	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2130	swear	\N	\N	noun	3	0	2	2025-07-06 15:11:48.772977	2025-07-06 15:11:48.772979	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2131	sweat	\N	\N	noun	3	0	2	2025-07-06 15:11:48.774971	2025-07-06 15:11:48.774973	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2132	sweater	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.776931	2025-07-06 15:11:48.776933	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2133	sweep	\N	\N	noun	3	0	2	2025-07-06 15:11:48.778987	2025-07-06 15:11:48.778989	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2134	sweet	\N	\N	noun	3	0	2	2025-07-06 15:11:48.781086	2025-07-06 15:11:48.781088	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2135	swim	\N	\N	noun	2	0	2	2025-07-06 15:11:48.783103	2025-07-06 15:11:48.783105	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2136	swimming	\N	\N	verb	4	0	4	2025-07-06 15:11:48.785435	2025-07-06 15:11:48.785437	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2137	swing	\N	\N	verb	3	0	2	2025-07-06 15:11:48.787914	2025-07-06 15:11:48.787917	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2138	switch	\N	\N	noun	3	0	3	2025-07-06 15:11:48.790117	2025-07-06 15:11:48.790119	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2139	sword	\N	\N	noun	3	0	2	2025-07-06 15:11:48.792527	2025-07-06 15:11:48.792529	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2140	symbol	\N	\N	noun	3	0	3	2025-07-06 15:11:48.794429	2025-07-06 15:11:48.794431	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2141	sympathy	\N	\N	noun	4	0	4	2025-07-06 15:11:48.796319	2025-07-06 15:11:48.79632	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2142	symptom	\N	\N	noun	4	0	3	2025-07-06 15:11:48.798139	2025-07-06 15:11:48.798141	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2143	system	\N	\N	noun	3	0	3	2025-07-06 15:11:48.800113	2025-07-06 15:11:48.800115	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2144	t	\N	\N	noun	1	0	1	2025-07-06 15:11:48.80221	2025-07-06 15:11:48.802212	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2145	table	\N	\N	adjective	3	0	2	2025-07-06 15:11:48.804217	2025-07-06 15:11:48.804219	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2146	tablet	\N	\N	noun	3	0	3	2025-07-06 15:11:48.806137	2025-07-06 15:11:48.806139	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2147	tack	\N	\N	noun	2	0	2	2025-07-06 15:11:48.808319	2025-07-06 15:11:48.808321	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2148	tag	\N	\N	noun	1	0	1	2025-07-06 15:11:48.810325	2025-07-06 15:11:48.810326	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2149	tail	\N	\N	noun	2	0	2	2025-07-06 15:11:48.812421	2025-07-06 15:11:48.812422	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2150	tailor	\N	\N	noun	3	0	3	2025-07-06 15:11:48.814308	2025-07-06 15:11:48.81431	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2152	tale	\N	\N	noun	2	0	2	2025-07-06 15:11:48.818197	2025-07-06 15:11:48.818199	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2153	talent	\N	\N	noun	3	0	3	2025-07-06 15:11:48.820259	2025-07-06 15:11:48.820261	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2154	talented	\N	\N	verb	4	0	4	2025-07-06 15:11:48.822443	2025-07-06 15:11:48.822445	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2155	talk	\N	\N	noun	2	0	2	2025-07-06 15:11:48.824648	2025-07-06 15:11:48.82465	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2156	tall	\N	\N	noun	2	0	2	2025-07-06 15:11:48.826683	2025-07-06 15:11:48.826684	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2157	tank	\N	\N	noun	2	0	2	2025-07-06 15:11:48.828821	2025-07-06 15:11:48.828823	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2158	tap	\N	\N	noun	1	0	1	2025-07-06 15:11:48.830901	2025-07-06 15:11:48.830903	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2159	tape	\N	\N	noun	2	0	2	2025-07-06 15:11:48.832738	2025-07-06 15:11:48.83274	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2160	target	\N	\N	noun	3	0	3	2025-07-06 15:11:48.834765	2025-07-06 15:11:48.834767	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2161	task	\N	\N	noun	2	0	2	2025-07-06 15:11:48.836753	2025-07-06 15:11:48.836755	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2162	taste	\N	\N	noun	3	0	2	2025-07-06 15:11:48.838781	2025-07-06 15:11:48.838783	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2163	tax	\N	\N	noun	1	0	1	2025-07-06 15:11:48.840762	2025-07-06 15:11:48.840764	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2164	taxi	\N	\N	noun	2	0	2	2025-07-06 15:11:48.842791	2025-07-06 15:11:48.842793	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2165	tea	\N	\N	noun	1	0	1	2025-07-06 15:11:48.844855	2025-07-06 15:11:48.844857	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2166	teach	\N	\N	noun	3	0	2	2025-07-06 15:11:48.84692	2025-07-06 15:11:48.846922	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2167	teacher	\N	\N	adjective	4	0	3	2025-07-06 15:11:48.848984	2025-07-06 15:11:48.848986	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2168	team	\N	\N	noun	2	0	2	2025-07-06 15:11:48.850969	2025-07-06 15:11:48.85097	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2169	tear	\N	\N	noun	2	0	2	2025-07-06 15:11:48.853382	2025-07-06 15:11:48.853384	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2170	technical	\N	\N	noun	5	0	4	2025-07-06 15:11:48.855706	2025-07-06 15:11:48.855708	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2171	technique	\N	\N	noun	5	0	4	2025-07-06 15:11:48.858017	2025-07-06 15:11:48.858019	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2172	technology	\N	\N	noun	5	0	5	2025-07-06 15:11:48.860562	2025-07-06 15:11:48.860565	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2173	teenager	\N	\N	adjective	4	0	4	2025-07-06 15:11:48.863109	2025-07-06 15:11:48.863111	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2174	telephone	\N	\N	noun	5	0	4	2025-07-06 15:11:48.865223	2025-07-06 15:11:48.865225	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2175	telescope	\N	\N	noun	5	0	4	2025-07-06 15:11:48.867247	2025-07-06 15:11:48.867249	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2176	television	\N	\N	noun	5	0	4	2025-07-06 15:11:48.869493	2025-07-06 15:11:48.869495	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2177	tell	\N	\N	noun	2	0	2	2025-07-06 15:11:48.871458	2025-07-06 15:11:48.87146	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2178	temperature	\N	\N	noun	6	0	5	2025-07-06 15:11:48.873556	2025-07-06 15:11:48.873558	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2179	temple	\N	\N	noun	3	0	3	2025-07-06 15:11:48.876154	2025-07-06 15:11:48.876156	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2180	temporary	\N	\N	noun	5	0	4	2025-07-06 15:11:48.878194	2025-07-06 15:11:48.878195	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2181	temptation	\N	\N	noun	5	0	4	2025-07-06 15:11:48.880139	2025-07-06 15:11:48.88014	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2182	ten	\N	\N	noun	1	0	1	2025-07-06 15:11:48.882189	2025-07-06 15:11:48.882191	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2183	tenant	\N	\N	noun	3	0	3	2025-07-06 15:11:48.884153	2025-07-06 15:11:48.884155	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2184	tend	\N	\N	noun	2	0	2	2025-07-06 15:11:48.886254	2025-07-06 15:11:48.886256	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2185	tendency	\N	\N	noun	4	0	4	2025-07-06 15:11:48.888282	2025-07-06 15:11:48.888284	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2186	tender	\N	\N	adjective	3	0	3	2025-07-06 15:11:48.890188	2025-07-06 15:11:48.890189	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2187	tennis	\N	\N	noun	3	0	3	2025-07-06 15:11:48.892071	2025-07-06 15:11:48.892072	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2188	tension	\N	\N	noun	4	0	4	2025-07-06 15:11:48.894138	2025-07-06 15:11:48.89414	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2189	tent	\N	\N	noun	2	0	2	2025-07-06 15:11:48.896242	2025-07-06 15:11:48.896244	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2190	tenth	\N	\N	noun	3	0	2	2025-07-06 15:11:48.898215	2025-07-06 15:11:48.898217	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2191	term	\N	\N	noun	2	0	2	2025-07-06 15:11:48.900441	2025-07-06 15:11:48.900443	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2192	terrible	\N	\N	adjective	4	0	4	2025-07-06 15:11:48.902733	2025-07-06 15:11:48.902735	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2193	terrify	\N	\N	noun	4	0	3	2025-07-06 15:11:48.905002	2025-07-06 15:11:48.905004	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2194	terror	\N	\N	noun	3	0	3	2025-07-06 15:11:48.90714	2025-07-06 15:11:48.907142	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2195	test	\N	\N	adjective	2	0	2	2025-07-06 15:11:48.909509	2025-07-06 15:11:48.909511	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2196	text	\N	\N	noun	2	0	2	2025-07-06 15:11:48.911837	2025-07-06 15:11:48.911839	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2197	than	\N	\N	noun	1	0	2	2025-07-06 15:11:48.914242	2025-07-06 15:11:48.914244	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2198	thank	\N	\N	noun	3	0	2	2025-07-06 15:11:48.916508	2025-07-06 15:11:48.91651	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2199	that	\N	\N	noun	1	0	2	2025-07-06 15:11:48.919015	2025-07-06 15:11:48.919018	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2202	theft	\N	\N	noun	3	0	2	2025-07-06 15:11:48.926048	2025-07-06 15:11:48.92605	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2203	their	\N	\N	pronoun	1	0	2	2025-07-06 15:11:48.928537	2025-07-06 15:11:48.928539	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2204	them	\N	\N	pronoun	1	0	2	2025-07-06 15:11:48.931251	2025-07-06 15:11:48.931253	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2205	theme	\N	\N	noun	3	0	2	2025-07-06 15:11:48.933809	2025-07-06 15:11:48.933811	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2207	theory	\N	\N	noun	3	0	3	2025-07-06 15:11:48.938297	2025-07-06 15:11:48.938299	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2208	therapy	\N	\N	noun	4	0	3	2025-07-06 15:11:48.940445	2025-07-06 15:11:48.940446	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2209	there	\N	\N	noun	1	0	2	2025-07-06 15:11:48.942876	2025-07-06 15:11:48.942893	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2210	therefore	\N	\N	noun	5	0	4	2025-07-06 15:11:48.945271	2025-07-06 15:11:48.945273	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2211	these	\N	\N	noun	1	0	2	2025-07-06 15:11:48.948242	2025-07-06 15:11:48.948245	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2212	thesis	\N	\N	noun	3	0	3	2025-07-06 15:11:48.95054	2025-07-06 15:11:48.950542	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2213	they	\N	\N	pronoun	1	0	2	2025-07-06 15:11:48.952738	2025-07-06 15:11:48.952741	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2214	thick	\N	\N	noun	3	0	2	2025-07-06 15:11:48.955118	2025-07-06 15:11:48.955121	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2215	thief	\N	\N	noun	3	0	2	2025-07-06 15:11:48.956952	2025-07-06 15:11:48.956954	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2216	thin	\N	\N	noun	2	0	2	2025-07-06 15:11:48.960418	2025-07-06 15:11:48.960436	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2217	thing	\N	\N	verb	3	0	2	2025-07-06 15:11:48.963573	2025-07-06 15:11:48.963575	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2219	third	\N	\N	noun	3	0	2	2025-07-06 15:11:48.968868	2025-07-06 15:11:48.968871	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2220	thirsty	\N	\N	noun	4	0	3	2025-07-06 15:11:48.971453	2025-07-06 15:11:48.971456	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2221	thirteen	\N	\N	noun	4	0	4	2025-07-06 15:11:48.974606	2025-07-06 15:11:48.974609	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2222	thirty	\N	\N	noun	3	0	3	2025-07-06 15:11:48.976751	2025-07-06 15:11:48.976753	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2223	this	\N	\N	noun	1	0	2	2025-07-06 15:11:48.978699	2025-07-06 15:11:48.978702	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2224	thorough	\N	\N	noun	4	0	4	2025-07-06 15:11:48.980582	2025-07-06 15:11:48.980584	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2225	those	\N	\N	noun	3	0	2	2025-07-06 15:11:48.982555	2025-07-06 15:11:48.982557	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2226	though	\N	\N	noun	3	0	4	2025-07-06 15:11:48.984701	2025-07-06 15:11:48.984703	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2227	thought	\N	\N	noun	4	0	4	2025-07-06 15:11:48.986774	2025-07-06 15:11:48.986776	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2229	thread	\N	\N	noun	3	0	3	2025-07-06 15:11:48.990821	2025-07-06 15:11:48.990823	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2230	threat	\N	\N	noun	3	0	3	2025-07-06 15:11:48.992844	2025-07-06 15:11:48.992846	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2231	three	\N	\N	noun	3	0	2	2025-07-06 15:11:48.994828	2025-07-06 15:11:48.994829	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2232	thrill	\N	\N	noun	3	0	3	2025-07-06 15:11:48.996745	2025-07-06 15:11:48.996747	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2233	throat	\N	\N	noun	3	0	3	2025-07-06 15:11:48.998904	2025-07-06 15:11:48.998906	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2234	through	\N	\N	preposition	4	0	4	2025-07-06 15:11:49.001135	2025-07-06 15:11:49.001137	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2235	throw	\N	\N	noun	3	0	2	2025-07-06 15:11:49.003287	2025-07-06 15:11:49.003289	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2236	thumb	\N	\N	noun	3	0	2	2025-07-06 15:11:49.005353	2025-07-06 15:11:49.005355	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2237	thunder	\N	\N	adjective	4	0	3	2025-07-06 15:11:49.007442	2025-07-06 15:11:49.007444	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2238	thus	\N	\N	noun	2	0	2	2025-07-06 15:11:49.009564	2025-07-06 15:11:49.009566	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2240	tide	\N	\N	noun	2	0	2	2025-07-06 15:11:49.013936	2025-07-06 15:11:49.013938	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2242	tie	\N	\N	noun	1	0	1	2025-07-06 15:11:49.018201	2025-07-06 15:11:49.018202	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2243	tiger	\N	\N	adjective	3	0	2	2025-07-06 15:11:49.020409	2025-07-06 15:11:49.020411	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2244	tight	\N	\N	noun	3	0	4	2025-07-06 15:11:49.022721	2025-07-06 15:11:49.022723	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2245	till	\N	\N	noun	2	0	2	2025-07-06 15:11:49.024736	2025-07-06 15:11:49.024738	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2246	timber	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.026879	2025-07-06 15:11:49.026881	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2247	time	\N	\N	noun	2	0	2	2025-07-06 15:11:49.028853	2025-07-06 15:11:49.028855	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2248	tiny	\N	\N	noun	2	0	2	2025-07-06 15:11:49.030956	2025-07-06 15:11:49.030958	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2249	tip	\N	\N	noun	1	0	1	2025-07-06 15:11:49.033165	2025-07-06 15:11:49.033167	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2250	tire	\N	\N	noun	2	0	2	2025-07-06 15:11:49.03542	2025-07-06 15:11:49.035422	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2251	tired	\N	\N	verb	3	0	2	2025-07-06 15:11:49.037672	2025-07-06 15:11:49.037674	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2252	tissue	\N	\N	noun	3	0	3	2025-07-06 15:11:49.04024	2025-07-06 15:11:49.040242	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2253	title	\N	\N	noun	3	0	2	2025-07-06 15:11:49.042659	2025-07-06 15:11:49.042662	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2255	toast	\N	\N	noun	3	0	2	2025-07-06 15:11:49.047215	2025-07-06 15:11:49.047217	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2256	tobacco	\N	\N	noun	4	0	3	2025-07-06 15:11:49.049548	2025-07-06 15:11:49.049551	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2257	today	\N	\N	noun	3	0	2	2025-07-06 15:11:49.051892	2025-07-06 15:11:49.051895	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2258	toe	\N	\N	noun	1	0	1	2025-07-06 15:11:49.054087	2025-07-06 15:11:49.05409	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2259	tofu	\N	\N	noun	2	0	2	2025-07-06 15:11:49.056555	2025-07-06 15:11:49.056558	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2260	together	\N	\N	adjective	4	0	4	2025-07-06 15:11:49.059131	2025-07-06 15:11:49.059134	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2261	toilet	\N	\N	noun	3	0	3	2025-07-06 15:11:49.061645	2025-07-06 15:11:49.061647	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2262	tolerance	\N	\N	noun	5	0	4	2025-07-06 15:11:49.064366	2025-07-06 15:11:49.064368	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2263	tomato	\N	\N	noun	3	0	3	2025-07-06 15:11:49.067972	2025-07-06 15:11:49.067974	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2264	tomb	\N	\N	noun	2	0	2	2025-07-06 15:11:49.070787	2025-07-06 15:11:49.07079	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2265	tomorrow	\N	\N	noun	4	0	4	2025-07-06 15:11:49.07353	2025-07-06 15:11:49.073533	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2266	ton	\N	\N	noun	1	0	1	2025-07-06 15:11:49.076294	2025-07-06 15:11:49.076296	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2267	tone	\N	\N	noun	2	0	2	2025-07-06 15:11:49.078902	2025-07-06 15:11:49.078905	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2268	tongue	\N	\N	noun	3	0	3	2025-07-06 15:11:49.081585	2025-07-06 15:11:49.081588	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2269	tonight	\N	\N	noun	4	0	4	2025-07-06 15:11:49.084283	2025-07-06 15:11:49.084285	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2270	too	\N	\N	noun	1	0	1	2025-07-06 15:11:49.087138	2025-07-06 15:11:49.087142	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2271	tool	\N	\N	noun	2	0	2	2025-07-06 15:11:49.090077	2025-07-06 15:11:49.09008	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2272	tooth	\N	\N	noun	3	0	2	2025-07-06 15:11:49.092837	2025-07-06 15:11:49.092839	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2273	toothbrush	\N	\N	noun	5	0	5	2025-07-06 15:11:49.095705	2025-07-06 15:11:49.095708	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2274	top	\N	\N	noun	1	0	1	2025-07-06 15:11:49.098417	2025-07-06 15:11:49.09842	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2275	topic	\N	\N	noun	3	0	2	2025-07-06 15:11:49.10108	2025-07-06 15:11:49.101082	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2276	torture	\N	\N	noun	4	0	3	2025-07-06 15:11:49.103924	2025-07-06 15:11:49.103927	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2277	total	\N	\N	noun	3	0	2	2025-07-06 15:11:49.106724	2025-07-06 15:11:49.106727	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2278	touch	\N	\N	noun	3	0	2	2025-07-06 15:11:49.109348	2025-07-06 15:11:49.10935	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2279	tough	\N	\N	noun	3	0	4	2025-07-06 15:11:49.112048	2025-07-06 15:11:49.112051	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2280	tour	\N	\N	noun	2	0	2	2025-07-06 15:11:49.114746	2025-07-06 15:11:49.114749	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2281	tourism	\N	\N	noun	4	0	3	2025-07-06 15:11:49.117256	2025-07-06 15:11:49.117259	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2282	tourist	\N	\N	noun	4	0	3	2025-07-06 15:11:49.11966	2025-07-06 15:11:49.119663	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2283	tournament	\N	\N	noun	5	0	5	2025-07-06 15:11:49.122063	2025-07-06 15:11:49.122065	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2284	toward	\N	\N	noun	3	0	3	2025-07-06 15:11:49.124298	2025-07-06 15:11:49.124301	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2285	towards	\N	\N	noun	4	0	3	2025-07-06 15:11:49.126433	2025-07-06 15:11:49.126435	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2286	towel	\N	\N	noun	3	0	2	2025-07-06 15:11:49.128513	2025-07-06 15:11:49.128516	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2287	tower	\N	\N	adjective	3	0	2	2025-07-06 15:11:49.130778	2025-07-06 15:11:49.13078	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2288	town	\N	\N	noun	2	0	2	2025-07-06 15:11:49.132898	2025-07-06 15:11:49.1329	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2289	toy	\N	\N	noun	1	0	1	2025-07-06 15:11:49.135041	2025-07-06 15:11:49.135043	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2290	trace	\N	\N	noun	3	0	2	2025-07-06 15:11:49.137552	2025-07-06 15:11:49.137554	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2291	track	\N	\N	noun	3	0	2	2025-07-06 15:11:49.139869	2025-07-06 15:11:49.139871	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2292	trade	\N	\N	noun	3	0	2	2025-07-06 15:11:49.142113	2025-07-06 15:11:49.142115	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2293	tradition	\N	\N	noun	5	0	4	2025-07-06 15:11:49.144372	2025-07-06 15:11:49.144374	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2295	traffic	\N	\N	noun	4	0	3	2025-07-06 15:11:49.149436	2025-07-06 15:11:49.149438	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2296	tragedy	\N	\N	noun	4	0	3	2025-07-06 15:11:49.151728	2025-07-06 15:11:49.15173	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2297	trail	\N	\N	noun	3	0	2	2025-07-06 15:11:49.154395	2025-07-06 15:11:49.154397	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2298	train	\N	\N	noun	3	0	2	2025-07-06 15:11:49.156631	2025-07-06 15:11:49.156633	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2299	trainer	\N	\N	adjective	4	0	3	2025-07-06 15:11:49.158804	2025-07-06 15:11:49.158806	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2300	training	\N	\N	verb	4	0	4	2025-07-06 15:11:49.161164	2025-07-06 15:11:49.161166	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2301	trait	\N	\N	noun	3	0	2	2025-07-06 15:11:49.163171	2025-07-06 15:11:49.163189	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2302	tram	\N	\N	noun	2	0	2	2025-07-06 15:11:49.165093	2025-07-06 15:11:49.165095	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2303	transfer	\N	\N	adjective	4	0	4	2025-07-06 15:11:49.167075	2025-07-06 15:11:49.167077	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2304	transform	\N	\N	noun	5	0	4	2025-07-06 15:11:49.169226	2025-07-06 15:11:49.169229	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2305	transition	\N	\N	noun	5	0	4	2025-07-06 15:11:49.171202	2025-07-06 15:11:49.171204	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2306	translate	\N	\N	noun	5	0	4	2025-07-06 15:11:49.17349	2025-07-06 15:11:49.173492	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2307	translation	\N	\N	noun	6	0	4	2025-07-06 15:11:49.175714	2025-07-06 15:11:49.175715	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2308	transmission	\N	\N	noun	6	0	4	2025-07-06 15:11:49.177731	2025-07-06 15:11:49.177748	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2309	transmit	\N	\N	noun	4	0	4	2025-07-06 15:11:49.17978	2025-07-06 15:11:49.179782	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2310	transparent	\N	\N	noun	6	0	5	2025-07-06 15:11:49.181705	2025-07-06 15:11:49.181707	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2311	transport	\N	\N	noun	5	0	4	2025-07-06 15:11:49.183532	2025-07-06 15:11:49.183534	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2312	trap	\N	\N	noun	2	0	2	2025-07-06 15:11:49.185384	2025-07-06 15:11:49.185385	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2313	trash	\N	\N	noun	3	0	2	2025-07-06 15:11:49.187326	2025-07-06 15:11:49.187328	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2314	travel	\N	\N	noun	3	0	3	2025-07-06 15:11:49.189154	2025-07-06 15:11:49.189156	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2315	tray	\N	\N	noun	2	0	2	2025-07-06 15:11:49.191046	2025-07-06 15:11:49.191048	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2316	treasure	\N	\N	noun	4	0	4	2025-07-06 15:11:49.194708	2025-07-06 15:11:49.19471	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2317	treat	\N	\N	noun	3	0	2	2025-07-06 15:11:49.19722	2025-07-06 15:11:49.197222	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2318	treatment	\N	\N	noun	5	0	4	2025-07-06 15:11:49.199723	2025-07-06 15:11:49.199725	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2319	tree	\N	\N	noun	2	0	2	2025-07-06 15:11:49.20226	2025-07-06 15:11:49.202262	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2320	tremble	\N	\N	noun	4	0	3	2025-07-06 15:11:49.2048	2025-07-06 15:11:49.204802	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2321	trend	\N	\N	noun	3	0	2	2025-07-06 15:11:49.206804	2025-07-06 15:11:49.206806	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2322	trial	\N	\N	noun	3	0	2	2025-07-06 15:11:49.209208	2025-07-06 15:11:49.20921	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2323	triangle	\N	\N	noun	4	0	4	2025-07-06 15:11:49.211396	2025-07-06 15:11:49.211397	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2324	trick	\N	\N	noun	3	0	2	2025-07-06 15:11:49.213428	2025-07-06 15:11:49.21343	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2325	trip	\N	\N	noun	2	0	2	2025-07-06 15:11:49.215236	2025-07-06 15:11:49.215238	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2326	triumph	\N	\N	noun	4	0	3	2025-07-06 15:11:49.217266	2025-07-06 15:11:49.217268	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2327	troop	\N	\N	noun	3	0	2	2025-07-06 15:11:49.219456	2025-07-06 15:11:49.219458	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2328	trophy	\N	\N	noun	3	0	3	2025-07-06 15:11:49.221868	2025-07-06 15:11:49.22187	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2329	tropical	\N	\N	noun	4	0	4	2025-07-06 15:11:49.223877	2025-07-06 15:11:49.223879	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2330	trouble	\N	\N	noun	4	0	3	2025-07-06 15:11:49.225779	2025-07-06 15:11:49.225781	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2331	trousers	\N	\N	noun	4	0	4	2025-07-06 15:11:49.227754	2025-07-06 15:11:49.227756	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2332	truck	\N	\N	noun	3	0	2	2025-07-06 15:11:49.230278	2025-07-06 15:11:49.23028	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2334	truly	\N	\N	adverb	3	0	2	2025-07-06 15:11:49.23486	2025-07-06 15:11:49.234862	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2335	trumpet	\N	\N	noun	4	0	3	2025-07-06 15:11:49.237367	2025-07-06 15:11:49.237369	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2336	trunk	\N	\N	noun	3	0	2	2025-07-06 15:11:49.239447	2025-07-06 15:11:49.239449	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2337	trust	\N	\N	noun	3	0	2	2025-07-06 15:11:49.241447	2025-07-06 15:11:49.241449	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2338	truth	\N	\N	noun	3	0	2	2025-07-06 15:11:49.243542	2025-07-06 15:11:49.243544	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2339	try	\N	\N	noun	1	0	1	2025-07-06 15:11:49.245572	2025-07-06 15:11:49.245574	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2340	tube	\N	\N	noun	2	0	2	2025-07-06 15:11:49.247547	2025-07-06 15:11:49.247549	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2341	tuition	\N	\N	noun	4	0	4	2025-07-06 15:11:49.249699	2025-07-06 15:11:49.249701	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2342	tune	\N	\N	noun	2	0	2	2025-07-06 15:11:49.252074	2025-07-06 15:11:49.252076	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2343	tunnel	\N	\N	noun	3	0	3	2025-07-06 15:11:49.254306	2025-07-06 15:11:49.254308	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2344	turn	\N	\N	noun	2	0	2	2025-07-06 15:11:49.25627	2025-07-06 15:11:49.256272	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2345	turtle	\N	\N	noun	3	0	3	2025-07-06 15:11:49.258313	2025-07-06 15:11:49.258315	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2346	tv	\N	\N	noun	1	0	1	2025-07-06 15:11:49.260798	2025-07-06 15:11:49.2608	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2347	twelve	\N	\N	noun	3	0	3	2025-07-06 15:11:49.263146	2025-07-06 15:11:49.263149	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2348	twenty	\N	\N	noun	3	0	3	2025-07-06 15:11:49.265383	2025-07-06 15:11:49.265385	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2349	twice	\N	\N	noun	3	0	2	2025-07-06 15:11:49.267459	2025-07-06 15:11:49.267461	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2350	twin	\N	\N	noun	2	0	2	2025-07-06 15:11:49.269583	2025-07-06 15:11:49.269585	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2351	twist	\N	\N	noun	3	0	2	2025-07-06 15:11:49.272086	2025-07-06 15:11:49.272089	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2352	two	\N	\N	noun	1	0	1	2025-07-06 15:11:49.274252	2025-07-06 15:11:49.274254	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2353	type	\N	\N	noun	2	0	2	2025-07-06 15:11:49.276675	2025-07-06 15:11:49.276677	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2354	typical	\N	\N	noun	4	0	3	2025-07-06 15:11:49.278853	2025-07-06 15:11:49.278856	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2355	ugly	\N	\N	adverb	2	0	2	2025-07-06 15:11:49.280911	2025-07-06 15:11:49.280913	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2356	umbrella	\N	\N	noun	4	0	4	2025-07-06 15:11:49.283224	2025-07-06 15:11:49.283226	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2357	unable	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.285335	2025-07-06 15:11:49.285338	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2358	uncle	\N	\N	noun	3	0	2	2025-07-06 15:11:49.287632	2025-07-06 15:11:49.287634	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2359	unconscious	\N	\N	adjective	6	0	5	2025-07-06 15:11:49.289937	2025-07-06 15:11:49.28994	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2360	under	\N	\N	adjective	3	0	2	2025-07-06 15:11:49.292978	2025-07-06 15:11:49.29298	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2361	undergo	\N	\N	noun	4	0	3	2025-07-06 15:11:49.295091	2025-07-06 15:11:49.295094	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2362	underground	\N	\N	noun	6	0	5	2025-07-06 15:11:49.297258	2025-07-06 15:11:49.29726	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2363	understand	\N	\N	noun	5	0	5	2025-07-06 15:11:49.299215	2025-07-06 15:11:49.299217	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2364	understanding	\N	\N	verb	6	0	5	2025-07-06 15:11:49.301211	2025-07-06 15:11:49.301213	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2365	undertake	\N	\N	noun	5	0	4	2025-07-06 15:11:49.303528	2025-07-06 15:11:49.30353	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2366	underwear	\N	\N	noun	5	0	4	2025-07-06 15:11:49.305641	2025-07-06 15:11:49.305659	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2367	undo	\N	\N	noun	2	0	2	2025-07-06 15:11:49.30768	2025-07-06 15:11:49.307682	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2368	unemployed	\N	\N	verb	5	0	5	2025-07-06 15:11:49.30974	2025-07-06 15:11:49.309742	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2369	unemployment	\N	\N	noun	6	0	5	2025-07-06 15:11:49.312039	2025-07-06 15:11:49.312041	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2370	unexpectedly	\N	\N	adverb	6	0	5	2025-07-06 15:11:49.314422	2025-07-06 15:11:49.314424	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2371	unfair	\N	\N	noun	3	0	3	2025-07-06 15:11:49.316418	2025-07-06 15:11:49.31642	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2372	unfit	\N	\N	noun	3	0	2	2025-07-06 15:11:49.318407	2025-07-06 15:11:49.318409	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2373	unfortunate	\N	\N	noun	6	0	5	2025-07-06 15:11:49.320469	2025-07-06 15:11:49.320471	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2374	unfortunately	\N	\N	adverb	6	0	5	2025-07-06 15:11:49.322547	2025-07-06 15:11:49.322549	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2375	unhappy	\N	\N	noun	4	0	3	2025-07-06 15:11:49.324835	2025-07-06 15:11:49.324837	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2376	uniform	\N	\N	noun	4	0	3	2025-07-06 15:11:49.327054	2025-07-06 15:11:49.327056	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2377	union	\N	\N	noun	3	0	2	2025-07-06 15:11:49.329748	2025-07-06 15:11:49.32975	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2378	unique	\N	\N	noun	3	0	3	2025-07-06 15:11:49.331877	2025-07-06 15:11:49.331895	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2379	unit	\N	\N	noun	2	0	2	2025-07-06 15:11:49.333764	2025-07-06 15:11:49.333766	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2380	unite	\N	\N	noun	3	0	2	2025-07-06 15:11:49.335904	2025-07-06 15:11:49.335906	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2381	universal	\N	\N	noun	5	0	4	2025-07-06 15:11:49.338139	2025-07-06 15:11:49.338141	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2382	universe	\N	\N	noun	4	0	4	2025-07-06 15:11:49.340108	2025-07-06 15:11:49.34011	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2383	university	\N	\N	noun	5	0	5	2025-07-06 15:11:49.342113	2025-07-06 15:11:49.342115	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2384	unknown	\N	\N	noun	4	0	3	2025-07-06 15:11:49.344395	2025-07-06 15:11:49.344397	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2385	unless	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.346508	2025-07-06 15:11:49.34651	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2386	unlike	\N	\N	noun	3	0	3	2025-07-06 15:11:49.348494	2025-07-06 15:11:49.348496	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2387	unlikely	\N	\N	adverb	4	0	4	2025-07-06 15:11:49.350455	2025-07-06 15:11:49.350457	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2388	until	\N	\N	noun	3	0	2	2025-07-06 15:11:49.352317	2025-07-06 15:11:49.352319	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2389	unusual	\N	\N	noun	4	0	3	2025-07-06 15:11:49.35435	2025-07-06 15:11:49.354368	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2390	unwilling	\N	\N	verb	5	0	4	2025-07-06 15:11:49.356327	2025-07-06 15:11:49.356329	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2391	unwillingly	\N	\N	adverb	6	0	5	2025-07-06 15:11:49.358338	2025-07-06 15:11:49.358355	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2393	upon	\N	\N	noun	2	0	2	2025-07-06 15:11:49.362866	2025-07-06 15:11:49.362868	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2394	upper	\N	\N	adjective	3	0	2	2025-07-06 15:11:49.365054	2025-07-06 15:11:49.365056	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2395	upset	\N	\N	noun	3	0	2	2025-07-06 15:11:49.36751	2025-07-06 15:11:49.367512	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2396	upside	\N	\N	noun	3	0	3	2025-07-06 15:11:49.369526	2025-07-06 15:11:49.369528	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2397	urgent	\N	\N	noun	3	0	3	2025-07-06 15:11:49.371734	2025-07-06 15:11:49.371736	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2398	us	\N	\N	pronoun	1	0	1	2025-07-06 15:11:49.373859	2025-07-06 15:11:49.373861	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2399	use	\N	\N	noun	1	0	1	2025-07-06 15:11:49.375863	2025-07-06 15:11:49.375865	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2401	user	\N	\N	adjective	2	0	2	2025-07-06 15:11:49.379872	2025-07-06 15:11:49.379874	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2402	usual	\N	\N	noun	3	0	2	2025-07-06 15:11:49.38192	2025-07-06 15:11:49.381922	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2403	usually	\N	\N	adverb	4	0	3	2025-07-06 15:11:49.384334	2025-07-06 15:11:49.384354	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2404	utility	\N	\N	noun	4	0	3	2025-07-06 15:11:49.386573	2025-07-06 15:11:49.386575	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2405	utter	\N	\N	adjective	3	0	2	2025-07-06 15:11:49.38877	2025-07-06 15:11:49.388772	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2406	vacant	\N	\N	noun	3	0	3	2025-07-06 15:11:49.39081	2025-07-06 15:11:49.390812	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2407	vacation	\N	\N	noun	4	0	4	2025-07-06 15:11:49.39295	2025-07-06 15:11:49.392952	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2408	vaguely	\N	\N	adverb	4	0	3	2025-07-06 15:11:49.395005	2025-07-06 15:11:49.395007	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2409	valid	\N	\N	noun	3	0	2	2025-07-06 15:11:49.397054	2025-07-06 15:11:49.397056	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2410	valley	\N	\N	noun	3	0	3	2025-07-06 15:11:49.399136	2025-07-06 15:11:49.399138	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2411	valuable	\N	\N	adjective	4	0	4	2025-07-06 15:11:49.401406	2025-07-06 15:11:49.401408	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2412	value	\N	\N	noun	3	0	2	2025-07-06 15:11:49.403701	2025-07-06 15:11:49.403703	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2413	vanish	\N	\N	noun	3	0	3	2025-07-06 15:11:49.405767	2025-07-06 15:11:49.405769	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2414	variable	\N	\N	adjective	4	0	4	2025-07-06 15:11:49.407857	2025-07-06 15:11:49.407859	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2415	variation	\N	\N	noun	5	0	4	2025-07-06 15:11:49.409933	2025-07-06 15:11:49.409935	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2416	variety	\N	\N	noun	4	0	3	2025-07-06 15:11:49.413785	2025-07-06 15:11:49.413787	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2417	various	\N	\N	adjective	4	0	3	2025-07-06 15:11:49.416898	2025-07-06 15:11:49.4169	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2418	vary	\N	\N	noun	2	0	2	2025-07-06 15:11:49.419382	2025-07-06 15:11:49.419385	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2419	vast	\N	\N	noun	2	0	2	2025-07-06 15:11:49.422604	2025-07-06 15:11:49.422606	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2420	vegetable	\N	\N	adjective	5	0	4	2025-07-06 15:11:49.42512	2025-07-06 15:11:49.425122	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2421	vehicle	\N	\N	noun	4	0	3	2025-07-06 15:11:49.427997	2025-07-06 15:11:49.427999	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2422	veil	\N	\N	noun	2	0	2	2025-07-06 15:11:49.430352	2025-07-06 15:11:49.430354	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2423	vein	\N	\N	noun	2	0	2	2025-07-06 15:11:49.432459	2025-07-06 15:11:49.432461	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2424	velocity	\N	\N	noun	4	0	4	2025-07-06 15:11:49.434534	2025-07-06 15:11:49.434536	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2425	velvet	\N	\N	noun	3	0	3	2025-07-06 15:11:49.436631	2025-07-06 15:11:49.436633	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2426	vendor	\N	\N	noun	3	0	3	2025-07-06 15:11:49.439423	2025-07-06 15:11:49.439425	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2427	venture	\N	\N	noun	4	0	3	2025-07-06 15:11:49.441488	2025-07-06 15:11:49.44149	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2428	verb	\N	\N	noun	2	0	2	2025-07-06 15:11:49.443548	2025-07-06 15:11:49.443549	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2429	verdict	\N	\N	noun	4	0	3	2025-07-06 15:11:49.445845	2025-07-06 15:11:49.445847	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2430	verge	\N	\N	noun	3	0	2	2025-07-06 15:11:49.448277	2025-07-06 15:11:49.448279	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2431	verse	\N	\N	noun	3	0	2	2025-07-06 15:11:49.450592	2025-07-06 15:11:49.450594	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2432	version	\N	\N	noun	4	0	4	2025-07-06 15:11:49.453032	2025-07-06 15:11:49.453035	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2433	vertical	\N	\N	noun	4	0	4	2025-07-06 15:11:49.455359	2025-07-06 15:11:49.455361	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2434	very	\N	\N	noun	2	0	2	2025-07-06 15:11:49.457389	2025-07-06 15:11:49.45739	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2435	vest	\N	\N	adjective	2	0	2	2025-07-06 15:11:49.4596	2025-07-06 15:11:49.459603	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2436	veteran	\N	\N	noun	4	0	3	2025-07-06 15:11:49.461947	2025-07-06 15:11:49.461949	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2437	via	\N	\N	noun	1	0	1	2025-07-06 15:11:49.464104	2025-07-06 15:11:49.464106	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2438	vibrate	\N	\N	noun	4	0	3	2025-07-06 15:11:49.466411	2025-07-06 15:11:49.466413	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2439	vice	\N	\N	noun	2	0	2	2025-07-06 15:11:49.468589	2025-07-06 15:11:49.468591	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2440	victim	\N	\N	noun	3	0	3	2025-07-06 15:11:49.470834	2025-07-06 15:11:49.470836	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2441	victory	\N	\N	noun	4	0	3	2025-07-06 15:11:49.472849	2025-07-06 15:11:49.47285	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2442	video	\N	\N	noun	3	0	2	2025-07-06 15:11:49.475101	2025-07-06 15:11:49.475103	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2443	view	\N	\N	noun	2	0	2	2025-07-06 15:11:49.477416	2025-07-06 15:11:49.477418	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2444	viewer	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.479719	2025-07-06 15:11:49.479721	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2445	village	\N	\N	noun	4	0	3	2025-07-06 15:11:49.481717	2025-07-06 15:11:49.481719	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2446	villain	\N	\N	noun	4	0	3	2025-07-06 15:11:49.483702	2025-07-06 15:11:49.483704	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2447	vine	\N	\N	noun	2	0	2	2025-07-06 15:11:49.48573	2025-07-06 15:11:49.485732	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2448	violence	\N	\N	noun	4	0	4	2025-07-06 15:11:49.48785	2025-07-06 15:11:49.487852	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2449	violent	\N	\N	noun	4	0	3	2025-07-06 15:11:49.489993	2025-07-06 15:11:49.489995	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2450	violet	\N	\N	noun	3	0	3	2025-07-06 15:11:49.492095	2025-07-06 15:11:49.492097	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2451	violin	\N	\N	noun	3	0	3	2025-07-06 15:11:49.49422	2025-07-06 15:11:49.494222	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2452	virtually	\N	\N	adverb	5	0	4	2025-07-06 15:11:49.496551	2025-07-06 15:11:49.496553	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2453	virtue	\N	\N	noun	3	0	3	2025-07-06 15:11:49.499153	2025-07-06 15:11:49.499155	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2454	virus	\N	\N	noun	3	0	2	2025-07-06 15:11:49.501854	2025-07-06 15:11:49.501856	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2455	visa	\N	\N	noun	2	0	2	2025-07-06 15:11:49.504064	2025-07-06 15:11:49.504066	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2456	visible	\N	\N	adjective	4	0	3	2025-07-06 15:11:49.506148	2025-07-06 15:11:49.50615	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2457	vision	\N	\N	noun	3	0	4	2025-07-06 15:11:49.508365	2025-07-06 15:11:49.508367	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2458	visit	\N	\N	noun	3	0	2	2025-07-06 15:11:49.51039	2025-07-06 15:11:49.510392	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2459	visitor	\N	\N	noun	4	0	3	2025-07-06 15:11:49.512605	2025-07-06 15:11:49.512607	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2460	visual	\N	\N	noun	3	0	3	2025-07-06 15:11:49.515264	2025-07-06 15:11:49.515267	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2461	vital	\N	\N	noun	3	0	2	2025-07-06 15:11:49.518059	2025-07-06 15:11:49.518062	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2462	vitamin	\N	\N	noun	4	0	3	2025-07-06 15:11:49.521357	2025-07-06 15:11:49.52136	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2463	vivid	\N	\N	noun	3	0	2	2025-07-06 15:11:49.523942	2025-07-06 15:11:49.523945	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2464	vocabulary	\N	\N	noun	5	0	5	2025-07-06 15:11:49.526278	2025-07-06 15:11:49.52628	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2465	vocal	\N	\N	noun	3	0	2	2025-07-06 15:11:49.528496	2025-07-06 15:11:49.528498	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2466	voice	\N	\N	noun	3	0	2	2025-07-06 15:11:49.530746	2025-07-06 15:11:49.530748	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2467	void	\N	\N	noun	2	0	2	2025-07-06 15:11:49.532954	2025-07-06 15:11:49.532972	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2468	volcano	\N	\N	noun	4	0	3	2025-07-06 15:11:49.535145	2025-07-06 15:11:49.535147	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2469	volleyball	\N	\N	noun	5	0	5	2025-07-06 15:11:49.537502	2025-07-06 15:11:49.537504	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2470	volt	\N	\N	noun	2	0	2	2025-07-06 15:11:49.539521	2025-07-06 15:11:49.539523	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2471	volume	\N	\N	noun	3	0	3	2025-07-06 15:11:49.541522	2025-07-06 15:11:49.541524	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2472	voluntarily	\N	\N	adverb	6	0	5	2025-07-06 15:11:49.543747	2025-07-06 15:11:49.543749	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2473	voluntary	\N	\N	noun	5	0	4	2025-07-06 15:11:49.546319	2025-07-06 15:11:49.546321	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2474	volunteer	\N	\N	adjective	5	0	4	2025-07-06 15:11:49.548198	2025-07-06 15:11:49.5482	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2475	vomit	\N	\N	noun	3	0	2	2025-07-06 15:11:49.550195	2025-07-06 15:11:49.550197	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2476	vote	\N	\N	noun	2	0	2	2025-07-06 15:11:49.552275	2025-07-06 15:11:49.552277	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2477	voter	\N	\N	adjective	3	0	2	2025-07-06 15:11:49.554825	2025-07-06 15:11:49.554828	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2478	vowel	\N	\N	noun	3	0	2	2025-07-06 15:11:49.556923	2025-07-06 15:11:49.556925	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2479	voyage	\N	\N	noun	3	0	3	2025-07-06 15:11:49.558997	2025-07-06 15:11:49.558999	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2480	wage	\N	\N	noun	2	0	2	2025-07-06 15:11:49.561161	2025-07-06 15:11:49.561163	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2481	wait	\N	\N	noun	2	0	2	2025-07-06 15:11:49.563188	2025-07-06 15:11:49.56319	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2482	waiter	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.565344	2025-07-06 15:11:49.565346	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2483	wake	\N	\N	noun	2	0	2	2025-07-06 15:11:49.567371	2025-07-06 15:11:49.567373	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2484	walk	\N	\N	noun	2	0	2	2025-07-06 15:11:49.56964	2025-07-06 15:11:49.569642	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2486	wallet	\N	\N	noun	3	0	3	2025-07-06 15:11:49.573727	2025-07-06 15:11:49.573728	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2487	wander	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.57575	2025-07-06 15:11:49.575752	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2488	want	\N	\N	noun	2	0	2	2025-07-06 15:11:49.577947	2025-07-06 15:11:49.57795	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2489	war	\N	\N	noun	1	0	1	2025-07-06 15:11:49.58002	2025-07-06 15:11:49.580022	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2490	wardrobe	\N	\N	noun	4	0	4	2025-07-06 15:11:49.582129	2025-07-06 15:11:49.582131	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2491	warehouse	\N	\N	noun	5	0	4	2025-07-06 15:11:49.584137	2025-07-06 15:11:49.584155	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2492	warm	\N	\N	noun	2	0	2	2025-07-06 15:11:49.58658	2025-07-06 15:11:49.586582	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2493	warmly	\N	\N	adverb	3	0	3	2025-07-06 15:11:49.588865	2025-07-06 15:11:49.588867	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2494	warmth	\N	\N	noun	3	0	3	2025-07-06 15:11:49.591174	2025-07-06 15:11:49.591176	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2495	warn	\N	\N	noun	2	0	2	2025-07-06 15:11:49.593183	2025-07-06 15:11:49.593185	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2496	warning	\N	\N	verb	4	0	3	2025-07-06 15:11:49.59521	2025-07-06 15:11:49.595212	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2497	wash	\N	\N	noun	2	0	2	2025-07-06 15:11:49.597353	2025-07-06 15:11:49.597355	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2498	waste	\N	\N	noun	3	0	2	2025-07-06 15:11:49.599329	2025-07-06 15:11:49.599331	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2499	watch	\N	\N	noun	3	0	2	2025-07-06 15:11:49.601437	2025-07-06 15:11:49.601439	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2500	water	\N	\N	adjective	1	0	2	2025-07-06 15:11:49.603496	2025-07-06 15:11:49.603498	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2501	watermelon	\N	\N	noun	5	0	5	2025-07-06 15:11:49.605418	2025-07-06 15:11:49.60542	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2502	wave	\N	\N	noun	2	0	2	2025-07-06 15:11:49.607356	2025-07-06 15:11:49.607358	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2503	wax	\N	\N	noun	1	0	1	2025-07-06 15:11:49.609407	2025-07-06 15:11:49.609409	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2504	way	\N	\N	noun	1	0	1	2025-07-06 15:11:49.611606	2025-07-06 15:11:49.611608	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2505	we	\N	\N	pronoun	1	0	1	2025-07-06 15:11:49.613818	2025-07-06 15:11:49.61382	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2506	weak	\N	\N	noun	2	0	2	2025-07-06 15:11:49.61602	2025-07-06 15:11:49.616022	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2507	weakly	\N	\N	adverb	3	0	3	2025-07-06 15:11:49.617959	2025-07-06 15:11:49.617961	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2508	weakness	\N	\N	noun	4	0	4	2025-07-06 15:11:49.620197	2025-07-06 15:11:49.620199	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2509	wealth	\N	\N	noun	3	0	3	2025-07-06 15:11:49.622215	2025-07-06 15:11:49.622217	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2510	wealthy	\N	\N	noun	4	0	3	2025-07-06 15:11:49.624513	2025-07-06 15:11:49.624516	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2511	weapon	\N	\N	noun	3	0	3	2025-07-06 15:11:49.626492	2025-07-06 15:11:49.626494	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2512	wear	\N	\N	noun	2	0	2	2025-07-06 15:11:49.62852	2025-07-06 15:11:49.628521	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2513	weather	\N	\N	adjective	4	0	3	2025-07-06 15:11:49.630484	2025-07-06 15:11:49.630486	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2514	weave	\N	\N	noun	3	0	2	2025-07-06 15:11:49.632388	2025-07-06 15:11:49.63239	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2515	web	\N	\N	noun	1	0	1	2025-07-06 15:11:49.634414	2025-07-06 15:11:49.634416	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2516	wedding	\N	\N	verb	4	0	3	2025-07-06 15:11:49.638276	2025-07-06 15:11:49.638278	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2517	wednesday	\N	\N	noun	5	0	4	2025-07-06 15:11:49.640978	2025-07-06 15:11:49.640997	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2518	weed	\N	\N	noun	2	0	2	2025-07-06 15:11:49.643544	2025-07-06 15:11:49.643546	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2519	week	\N	\N	noun	2	0	2	2025-07-06 15:11:49.646058	2025-07-06 15:11:49.64606	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2520	weekend	\N	\N	noun	4	0	3	2025-07-06 15:11:49.647958	2025-07-06 15:11:49.64796	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2521	weekly	\N	\N	adverb	3	0	3	2025-07-06 15:11:49.649926	2025-07-06 15:11:49.649927	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2522	weep	\N	\N	noun	2	0	2	2025-07-06 15:11:49.652763	2025-07-06 15:11:49.652765	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2523	weigh	\N	\N	noun	3	0	4	2025-07-06 15:11:49.654781	2025-07-06 15:11:49.654783	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2524	weight	\N	\N	noun	3	0	4	2025-07-06 15:11:49.657517	2025-07-06 15:11:49.657519	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2525	welcome	\N	\N	noun	4	0	3	2025-07-06 15:11:49.659741	2025-07-06 15:11:49.659743	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2526	welfare	\N	\N	noun	4	0	3	2025-07-06 15:11:49.661656	2025-07-06 15:11:49.661658	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2528	west	\N	\N	adjective	2	0	2	2025-07-06 15:11:49.665918	2025-07-06 15:11:49.66592	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2529	western	\N	\N	noun	4	0	3	2025-07-06 15:11:49.667912	2025-07-06 15:11:49.667914	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2531	whale	\N	\N	noun	3	0	2	2025-07-06 15:11:49.672443	2025-07-06 15:11:49.672445	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2532	what	\N	\N	noun	1	0	2	2025-07-06 15:11:49.674571	2025-07-06 15:11:49.674573	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2533	whatever	\N	\N	adjective	4	0	4	2025-07-06 15:11:49.67678	2025-07-06 15:11:49.676782	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2534	wheat	\N	\N	noun	3	0	2	2025-07-06 15:11:49.678876	2025-07-06 15:11:49.678878	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2535	wheel	\N	\N	noun	3	0	2	2025-07-06 15:11:49.681089	2025-07-06 15:11:49.68109	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2536	when	\N	\N	noun	1	0	2	2025-07-06 15:11:49.683003	2025-07-06 15:11:49.683004	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2537	whenever	\N	\N	adjective	4	0	4	2025-07-06 15:11:49.684881	2025-07-06 15:11:49.684883	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2538	where	\N	\N	noun	3	0	2	2025-07-06 15:11:49.68712	2025-07-06 15:11:49.687122	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2539	whereas	\N	\N	noun	4	0	3	2025-07-06 15:11:49.68938	2025-07-06 15:11:49.689382	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2540	whereby	\N	\N	noun	4	0	3	2025-07-06 15:11:49.691441	2025-07-06 15:11:49.691442	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2541	wherever	\N	\N	adjective	4	0	4	2025-07-06 15:11:49.693593	2025-07-06 15:11:49.693595	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2542	whether	\N	\N	adjective	4	0	3	2025-07-06 15:11:49.695681	2025-07-06 15:11:49.695683	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2543	which	\N	\N	noun	1	0	2	2025-07-06 15:11:49.697879	2025-07-06 15:11:49.697897	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2544	while	\N	\N	conjunction	3	0	2	2025-07-06 15:11:49.699856	2025-07-06 15:11:49.699857	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2545	whisper	\N	\N	adjective	4	0	3	2025-07-06 15:11:49.701807	2025-07-06 15:11:49.701809	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2546	whistle	\N	\N	noun	4	0	3	2025-07-06 15:11:49.703823	2025-07-06 15:11:49.703825	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2547	white	\N	\N	noun	3	0	2	2025-07-06 15:11:49.706123	2025-07-06 15:11:49.706125	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2548	who	\N	\N	noun	1	0	1	2025-07-06 15:11:49.70841	2025-07-06 15:11:49.708412	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2549	whole	\N	\N	noun	3	0	2	2025-07-06 15:11:49.710752	2025-07-06 15:11:49.710754	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2550	whom	\N	\N	noun	2	0	2	2025-07-06 15:11:49.713194	2025-07-06 15:11:49.713196	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2552	why	\N	\N	noun	1	0	1	2025-07-06 15:11:49.71733	2025-07-06 15:11:49.717332	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2553	wide	\N	\N	noun	2	0	2	2025-07-06 15:11:49.719633	2025-07-06 15:11:49.719635	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2554	widely	\N	\N	adverb	3	0	3	2025-07-06 15:11:49.721904	2025-07-06 15:11:49.721906	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2555	widen	\N	\N	noun	3	0	2	2025-07-06 15:11:49.723802	2025-07-06 15:11:49.723803	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2556	widespread	\N	\N	noun	5	0	5	2025-07-06 15:11:49.725794	2025-07-06 15:11:49.725796	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2557	wife	\N	\N	noun	2	0	2	2025-07-06 15:11:49.727763	2025-07-06 15:11:49.727765	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2558	wild	\N	\N	noun	2	0	2	2025-07-06 15:11:49.72975	2025-07-06 15:11:49.729752	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2559	wilderness	\N	\N	noun	5	0	5	2025-07-06 15:11:49.731703	2025-07-06 15:11:49.731705	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2560	wildlife	\N	\N	noun	4	0	4	2025-07-06 15:11:49.733709	2025-07-06 15:11:49.733711	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2561	will	\N	\N	noun	1	0	2	2025-07-06 15:11:49.735761	2025-07-06 15:11:49.735763	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2562	willing	\N	\N	verb	4	0	3	2025-07-06 15:11:49.737892	2025-07-06 15:11:49.737894	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2563	win	\N	\N	noun	1	0	1	2025-07-06 15:11:49.739983	2025-07-06 15:11:49.739985	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2564	wind	\N	\N	noun	2	0	2	2025-07-06 15:11:49.742323	2025-07-06 15:11:49.742325	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2565	window	\N	\N	noun	3	0	3	2025-07-06 15:11:49.744678	2025-07-06 15:11:49.74468	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2566	wine	\N	\N	noun	2	0	2	2025-07-06 15:11:49.746917	2025-07-06 15:11:49.746919	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2567	wing	\N	\N	noun	2	0	2	2025-07-06 15:11:49.748883	2025-07-06 15:11:49.748884	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2568	winner	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.750946	2025-07-06 15:11:49.750948	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2569	winter	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.75334	2025-07-06 15:11:49.753342	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2570	wipe	\N	\N	noun	2	0	2	2025-07-06 15:11:49.755415	2025-07-06 15:11:49.755417	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2571	wire	\N	\N	noun	2	0	2	2025-07-06 15:11:49.757399	2025-07-06 15:11:49.757401	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2572	wisdom	\N	\N	noun	3	0	3	2025-07-06 15:11:49.759273	2025-07-06 15:11:49.759275	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2573	wise	\N	\N	noun	2	0	2	2025-07-06 15:11:49.761217	2025-07-06 15:11:49.761219	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2574	wish	\N	\N	noun	2	0	2	2025-07-06 15:11:49.76328	2025-07-06 15:11:49.763282	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2575	wit	\N	\N	noun	1	0	1	2025-07-06 15:11:49.76555	2025-07-06 15:11:49.765553	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2576	with	\N	\N	preposition	1	0	2	2025-07-06 15:11:49.767682	2025-07-06 15:11:49.767684	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2577	withdraw	\N	\N	noun	4	0	4	2025-07-06 15:11:49.769714	2025-07-06 15:11:49.769715	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2578	within	\N	\N	noun	3	0	3	2025-07-06 15:11:49.771848	2025-07-06 15:11:49.77185	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2579	without	\N	\N	noun	4	0	3	2025-07-06 15:11:49.773924	2025-07-06 15:11:49.773926	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2580	witness	\N	\N	noun	4	0	3	2025-07-06 15:11:49.775952	2025-07-06 15:11:49.775954	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2581	witty	\N	\N	noun	3	0	2	2025-07-06 15:11:49.777946	2025-07-06 15:11:49.777948	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2582	wolf	\N	\N	noun	2	0	2	2025-07-06 15:11:49.780034	2025-07-06 15:11:49.780035	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2583	woman	\N	\N	noun	3	0	2	2025-07-06 15:11:49.782014	2025-07-06 15:11:49.782016	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2584	wonder	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.784009	2025-07-06 15:11:49.784011	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2585	wonderful	\N	\N	adjective	5	0	4	2025-07-06 15:11:49.78611	2025-07-06 15:11:49.786112	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2586	wood	\N	\N	noun	2	0	2	2025-07-06 15:11:49.788191	2025-07-06 15:11:49.788192	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2587	wooden	\N	\N	noun	3	0	3	2025-07-06 15:11:49.790208	2025-07-06 15:11:49.79021	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2588	wool	\N	\N	noun	2	0	2	2025-07-06 15:11:49.792202	2025-07-06 15:11:49.792204	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2589	word	\N	\N	noun	1	0	2	2025-07-06 15:11:49.794085	2025-07-06 15:11:49.794087	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2590	work	\N	\N	noun	2	0	2	2025-07-06 15:11:49.796034	2025-07-06 15:11:49.796036	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2592	working	\N	\N	verb	4	0	3	2025-07-06 15:11:49.8012	2025-07-06 15:11:49.801202	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2593	world	\N	\N	noun	3	0	2	2025-07-06 15:11:49.804591	2025-07-06 15:11:49.804594	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2594	worried	\N	\N	verb	4	0	3	2025-07-06 15:11:49.807149	2025-07-06 15:11:49.807152	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2595	worry	\N	\N	noun	3	0	2	2025-07-06 15:11:49.809639	2025-07-06 15:11:49.809642	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2596	worse	\N	\N	noun	3	0	2	2025-07-06 15:11:49.811794	2025-07-06 15:11:49.811796	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2597	worship	\N	\N	noun	4	0	3	2025-07-06 15:11:49.813733	2025-07-06 15:11:49.813735	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2598	worst	\N	\N	noun	3	0	2	2025-07-06 15:11:49.815722	2025-07-06 15:11:49.815724	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2599	worth	\N	\N	noun	3	0	2	2025-07-06 15:11:49.817815	2025-07-06 15:11:49.817817	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2600	worthy	\N	\N	noun	3	0	3	2025-07-06 15:11:49.819833	2025-07-06 15:11:49.819835	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2601	would	\N	\N	noun	1	0	2	2025-07-06 15:11:49.821862	2025-07-06 15:11:49.82188	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2602	wound	\N	\N	noun	3	0	2	2025-07-06 15:11:49.823825	2025-07-06 15:11:49.823827	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2603	wow	\N	\N	noun	1	0	1	2025-07-06 15:11:49.826021	2025-07-06 15:11:49.826023	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2604	wrap	\N	\N	noun	2	0	2	2025-07-06 15:11:49.828226	2025-07-06 15:11:49.828228	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2605	wrist	\N	\N	noun	3	0	2	2025-07-06 15:11:49.830528	2025-07-06 15:11:49.83053	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2606	write	\N	\N	noun	3	0	2	2025-07-06 15:11:49.832549	2025-07-06 15:11:49.832551	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2607	writer	\N	\N	adjective	3	0	3	2025-07-06 15:11:49.834515	2025-07-06 15:11:49.834517	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2608	writing	\N	\N	verb	4	0	3	2025-07-06 15:11:49.836511	2025-07-06 15:11:49.836513	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2609	wrong	\N	\N	noun	3	0	2	2025-07-06 15:11:49.838554	2025-07-06 15:11:49.838556	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2610	yard	\N	\N	noun	2	0	2	2025-07-06 15:11:49.840803	2025-07-06 15:11:49.840805	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2611	yawn	\N	\N	noun	2	0	2	2025-07-06 15:11:49.842803	2025-07-06 15:11:49.842821	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2612	year	\N	\N	noun	2	0	2	2025-07-06 15:11:49.844806	2025-07-06 15:11:49.844808	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2613	yearly	\N	\N	adverb	3	0	3	2025-07-06 15:11:49.847038	2025-07-06 15:11:49.84704	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2614	yell	\N	\N	noun	2	0	2	2025-07-06 15:11:49.849012	2025-07-06 15:11:49.849014	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2615	yellow	\N	\N	noun	3	0	3	2025-07-06 15:11:49.851002	2025-07-06 15:11:49.851004	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2616	yes	\N	\N	noun	1	0	1	2025-07-06 15:11:49.854829	2025-07-06 15:11:49.854832	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2617	yesterday	\N	\N	noun	5	0	4	2025-07-06 15:11:49.857815	2025-07-06 15:11:49.857817	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2618	yet	\N	\N	noun	1	0	1	2025-07-06 15:11:49.860215	2025-07-06 15:11:49.860216	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2619	yield	\N	\N	noun	3	0	2	2025-07-06 15:11:49.862187	2025-07-06 15:11:49.862189	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2620	yogurt	\N	\N	noun	3	0	3	2025-07-06 15:11:49.864704	2025-07-06 15:11:49.864705	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2621	you	\N	\N	pronoun	1	0	1	2025-07-06 15:11:49.866699	2025-07-06 15:11:49.8667	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2622	young	\N	\N	noun	3	0	2	2025-07-06 15:11:49.868984	2025-07-06 15:11:49.868986	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2623	your	\N	\N	pronoun	1	0	2	2025-07-06 15:11:49.87143	2025-07-06 15:11:49.871433	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2624	yourself	\N	\N	noun	4	0	4	2025-07-06 15:11:49.873461	2025-07-06 15:11:49.873462	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2625	youth	\N	\N	noun	3	0	2	2025-07-06 15:11:49.876106	2025-07-06 15:11:49.876108	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2626	zebra	\N	\N	noun	3	0	2	2025-07-06 15:11:49.878027	2025-07-06 15:11:49.878032	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2627	zero	\N	\N	noun	2	0	2	2025-07-06 15:11:49.879975	2025-07-06 15:11:49.879977	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2628	zone	\N	\N	noun	2	0	2	2025-07-06 15:11:49.881936	2025-07-06 15:11:49.881937	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2629	zoo	\N	\N	noun	1	0	1	2025-07-06 15:11:49.883812	2025-07-06 15:11:49.883814	\N	待翻译	easy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
2591	worker	/ˈwɝkɚ/	\N	adjective	5	0	3	2025-07-06 15:11:49.798025	2025-07-13 03:20:13.470522	\N	工人	easy	/static/audio_cache/小学五年级单词（外研社一年级起点）/9c8aa5e61c509f14a6c1a933fc815206.mp3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	system	t	f	\N
\.


--
-- Name: generated_sentences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generated_sentences_id_seq', 3549, true);


--
-- Name: sentences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sentences_id_seq', 5, true);


--
-- Name: vocabulary_libraries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vocabulary_libraries_id_seq', 17, true);


--
-- Name: words_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.words_id_seq', 2692, true);


--
-- PostgreSQL database dump complete
--

