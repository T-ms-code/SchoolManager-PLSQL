---EX4.
create table PROFESOR(
id_profesor number(4),
id_superior number(4),
nume varchar2(25),
prenume varchar2(25),
salariu number(6),
data_angajare date,
constraint PK_PROFESOR primary key(id_profesor),
constraint FK1_PROFESOR foreign key(id_superior) references PROFESOR(id_profesor),
constraint C1_PROFESOR check(salariu>0)
);



create table MATERIE(
id_materie number(4),
id_sef_catedra number(4),
denumire varchar2(25),
constraint PK_MATERIE primary key(id_materie),
constraint FK1_MATERIE foreign key(id_sef_catedra) references PROFESOR(id_profesor),
constraint U1_MATERIE unique(denumire),
constraint C1_MATERIE check (denumire is not null)
);



create table SALA(
id_sala number(4),
capacitate number(2),
tipologie varchar2(25),
constraint PK_SALA primary key (id_sala),
constraint C1_SALA check (capacitate>=0),
constraint C2_SALA check (capacitate is not null)
);



create table CLASA(
id_clasa number(4),
id_diriginte number(4) not null,
id_sala number(4) not null,
denumire varchar2(4),
profil varchar2(25),
numar_elevi number(2),
constraint PK_CLASA primary key (id_clasa),
constraint FK1_CLASA foreign key(id_diriginte) references PROFESOR(id_profesor),
constraint FK2_CLASA foreign key(id_sala) references SALA(id_sala),
constraint C1_CLASA check (numar_elevi>=0),
constraint C2_CLASA check (numar_elevi is not null)
);

-----------------------

create table ELEV(
id_elev number(4),
id_clasa number(4) not null,
nume varchar2(25),
prenume varchar2(25),
medie_generala number(4,2) default 10,
medie_purtare number(2) default 10,
numar_absente number(3) default 0,
contact_parinte varchar2(50),
constraint PK_ELEV primary key(id_elev),
constraint FK1_ELEV foreign key(id_clasa) references CLASA(id_clasa),
constraint C1_ELEV check (medie_generala>=0),
constraint C2_ELEV check (medie_purtare>=0),
constraint C3_ELEV check (numar_absente>=0),
constraint C4_ELEV check (medie_generala is not null),
constraint C5_ELEV check (medie_purtare is not null),
constraint C6_ELEV check (numar_absente is not null),
constraint C7_ELEV check (contact_parinte is not null)
);



create table BURSA(
id_bursa number(4),
tip varchar2(25),
suma number(4) not null,
constraint PK_BURSA primary key(id_bursa),
constraint C1_BURSA check (suma>0)
);



create table PERSONAL_AUXILIAR(
id_pers_aux number(4),
nume varchar2(25),
prenume varchar2(25),
salariu number(6),
data_angajare date,
constraint PK_PERSONAL_AUX primary key(id_pers_aux),
constraint C1_PERSONAL_AUX check(salariu>0)
);



create table OCUPATIE(
id_ocupatie number(4),
denumire varchar2(50),
constraint PK_OCUPATIE primary key(id_ocupatie)
);



create table PREDA(
id_profesor number(4),
id_materie  number(4),
constraint PK_PREDA primary key(id_profesor, id_materie),
constraint FK1_PREDA foreign key(id_profesor) references PROFESOR(id_profesor),
constraint FK2_PREDA foreign key(id_materie) references MATERIE(id_materie)
);



create table PUNE_NOTA(
id_profesor number(4),
id_materie number(4),
id_elev number(4),
data date default sysdate,
nota number(2),
constraint PK_PUNE_NOTA primary key(id_profesor, id_materie, id_elev, data),
constraint FK1_PUNE_NOTA foreign key(id_profesor) references PROFESOR (id_profesor),
constraint FK2_PUNE_NOTA foreign key(id_materie) references MATERIE(id_materie),
constraint FK3_PUNE_NOTA foreign key(id_elev) references ELEV (id_elev),
constraint C1_PUNE_NOTA check (nota>=0),
constraint C2_PUNE_NOTA check (nota is not null)
);



create type t_imb_subcoloana is table of varchar2(50);
/
create type vector_coloana is varray(5) of t_imb_subcoloana;
/
create table SE_STUDIAZA(
id_clasa number(4),
id_materie number(4),
id_profesor number(4),
orar vector_coloana,
constraint PK_SE_STUDIAZA primary key (id_clasa, id_materie, id_profesor),
constraint FK1_SE_STUDIAZA foreign key(id_clasa) references CLASA(id_clasa),
constraint FK2_SE_STUDIAZA foreign key(id_materie) references MATERIE(id_materie),
constraint FK3_SE_STUDIAZA foreign key(id_profesor) references PROFESOR(id_profesor)
);



create table PRIMESTE(
id_elev number(4),
id_bursa number(4),
tip_decontare varchar(4) not null,
constraint PK_PRIMESTE primary key(id_elev, id_bursa),
constraint FK1_PRIMESTE foreign key(id_elev) references ELEV(id_elev),
constraint FK2_PRIMESTE foreign key(id_bursa) references BURSA(id_bursa),
constraint C1_PRIMESTE check(tip_decontare in ('cash', 'card'))
);



create table ESTE_INGRIJITA_DE(
id_sala number(4),
id_pers_aux number(4),
constraint PK_ESTE_INGRIJITA_DE primary key(id_sala, id_pers_aux),
constraint FK1_ESTE_INGRIJITA_DE foreign key(id_sala) references SALA(id_sala),
constraint FK2_ESTE_INGRIJITA_DE foreign key(id_pers_aux) references PERSONAL_AUXILIAR (id_pers_aux)
);



create table ARE(
id_pers_aux number(4),
id_ocupatie number(4),
constraint PK_ARE primary key(id_pers_aux, id_ocupatie),
constraint FK1_ARE foreign key(id_pers_aux) references PERSONAL_AUXILIAR(id_pers_aux),
constraint FK2_ARE foreign key(id_ocupatie) references OCUPATIE (id_ocupatie)
);


commit;


---EX5.
create sequence sec
start with 100
increment by 1
maxvalue 10000;


insert into PROFESOR values(sec.nextval, null, 'Butculescu', 'Catalin', 12000, '02-Feb-04');
insert into PROFESOR values(sec.nextval, 100, 'Nicu', 'Cristinel', 8000, '17-Apr-14');--101

insert into PROFESOR values(sec.nextval, 100, 'Fugulin', 'Daniel', 10000, '02-Feb-04');--102
insert into PROFESOR values(sec.nextval, 102, 'Popa', 'Ion', 10000, '08-Feb-05');
insert into PROFESOR values(sec.nextval, 102, 'Butnarescu', 'Corina', 9000, '15-May-17');

insert into PROFESOR values(sec.nextval, 102, 'Florea', 'Laura', 9500, '28-Oct-11');
insert into PROFESOR values(sec.nextval, 100, 'Voica', 'Cornelia', 9800, '12-Nov-09');--106

insert into PROFESOR values(sec.nextval,106, 'Stanescu', 'Gabriel', 8800, '07-Dec-06');
insert into PROFESOR values(sec.nextval, 106, 'Stanescu', 'Marcel', 8950, '02-Feb-04');

insert into PROFESOR values(sec.nextval, 102, 'Duican', 'Carmen', 6740, '20-Mar-15');

insert into PROFESOR values(sec.nextval, 102, 'Visenescu', 'Valeria', 7708, '01-Jun-19');
insert into PROFESOR values(sec.nextval, 102, 'Ivascu', 'Catalina', 7600, '12-Jul-11');
-----
insert into PROFESOR values(sec.nextval, 106, 'Fugulin', 'Silvia', 5400, '22-Jan-04');
insert into PROFESOR values(sec.nextval, 106, 'Zuluf', 'Ioana', 6743, '16-Nov-12');
insert into PROFESOR values(sec.nextval, 106, 'Lazaroiu', 'Mihaela', 7200, '16-Oct-21');

insert into PROFESOR values(sec.nextval, 102, 'Deaconu', 'Catalin', 5900, '29-Apr-10');
insert into PROFESOR values(sec.nextval, 106, 'Zaharia', 'Adrian', 6430, '17-Oct-16');
insert into PROFESOR values(sec.nextval, 101, 'Scarlat', 'Valentin-Marius', 4800, '01-Sep-10');

insert into PROFESOR values(sec.nextval, 101, 'Bucsan', 'Romeo', 7000, '23-Mar-05');
insert into PROFESOR values(sec.nextval, 106, 'Otopac', 'Alice', 4500, '15-Sep-08');

insert into PROFESOR values(sec.nextval, 106, 'Badea', 'Gheorghe', 5100, '12-Apr-17');

insert into PROFESOR values(sec.nextval, 106, 'Dobroiu', 'Andreea', 5500, '25-Aug-22');

insert into PROFESOR values(123, 101, 'Sterea', 'Daniela', 5790, '24-Sep-21');

select *
from profesor;



insert into MATERIE values(200, 100, 'sport');
insert into MATERIE values(201, 103, 'matematica');
insert into MATERIE values(202, 106, 'informatica');
insert into MATERIE values(203, 108, 'fizica');
insert into MATERIE values(204, 109, 'chimie');
insert into MATERIE values(205, null, 'biologie');
insert into MATERIE values(206, 112, 'romana');
insert into MATERIE values(207, 116, 'istorie');
insert into MATERIE values(208, 117, 'geografie');
insert into MATERIE values(209, 120, 'logica');
insert into MATERIE values(210, 123, 'engleza');
insert into MATERIE values(211, 123, 'franceza');
insert into MATERIE values(212, null, 'sociologie');

select *
from materie;



BEGIN
FOR contor in 300..315 LOOP
  IF contor=306 or contor=308 or contor=310 THEN insert into SALA values (contor, 18, 'laborator de biologie');
  ELSIF contor=313 or contor mod 2=0 THEN insert into SALA values (contor, 25, 'normala');
  ELSIF contor=307 or contor=311 THEN insert into SALA values (contor, 20, 'laborator de informatica');
  ELSIF contor=309  THEN insert into SALA values (contor, 22, 'laborator de fizica');
  ELSE insert into SALA values (contor, 30, 'laborator de chimie');
  END IF;
END LOOP;
END;
/

select *
from sala;



insert into CLASA values (401, 102, 307, '9A', 'mate-info', 5);
insert into CLASA values (402, 101, 301, '9B', 'mate-info', 2);     
insert into CLASA values (403, 103, 302, '10A', 'mate-info', 3);
insert into CLASA values (404, 106, 303, '11A', 'mate-info', 4);
insert into CLASA values (405, 108, 311, '12A', 'mate-info', 2);

insert into CLASA values (406, 109, 300, '9A', 'filologie', 3); 
insert into CLASA values (407, 115, 304, '10A', 'filologie', 2); 
insert into CLASA values (408, 117, 308, '11A', 'filologie', 2);
insert into CLASA values (409, 106, 309, '12A', 'filologie', 2);

insert into CLASA values (410, 123, 310, '10A', 'sociale', 4);
insert into CLASA values (411, 100, 315, '11D', 'stiinte ale naturii', 2);

select *
from clasa;



insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (114, 401, 'Telu', 'Andrei', '0712444567');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (115, 401, 'Telu', 'Catalin', '0712444567');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (116, 401, 'Pandeliu', 'Casian', 'calincmn10@gmail.com');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (117, 401, 'Popescu', 'Sebastian', '0725767321');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (118, 401, 'Gheorghiu', 'Carmen', '0734225789');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (119, 402, 'Tomescu', 'Gabriel', '0747889022');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (120, 402, 'Nedelcu', 'Alexia', '0712444567');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (121, 403, 'Iordache', 'Andrei', '0763188256');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (122, 403, 'Istru', 'Bianca', 'maria30istru@gmail.com');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (123, 403, 'Istrate', 'Andra-Maria', '0778991333');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (124, 404, 'Duicu', 'Alexandra', '0798245670');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (125, 404, 'Albu', 'Miruna', '0799245670');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (126, 404, 'Velcea', 'Ionut', 'marin12@yahoo.com');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (127, 404, 'Tanasescu', 'Albert', 'martin123@yahoo.com');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (128, 405, 'Lacramioara', 'Florina-Luminita', '0759245670');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (129, 405, 'Tinca', 'Albert', '0759241611');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (130, 406, 'Poenarescu', 'Ovidiu', '0759995970');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (131, 406, 'Pop', 'Vasile', 'calincmn10@gmail.com');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (132, 406, 'Ciuca', 'Teodora', 'mrciuca2@gmail.com');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (133, 407, 'Chiritoiu', 'Marius', '0769245470');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (134, 407, 'Gavrila', 'Eduard', 'xm7mihai@gmail.com');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (135, 408, 'Mogosanu', 'Cezar', 'mogosanu40@gmail.com');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (136, 408, 'Zapucioiu', 'Cristian', 'xm7mihai@gmail.com');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (137, 409, 'Cotandra', 'Alexandru', '0712474561');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (138, 409, 'Vinatoru', 'Isabela', '0712474562');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (139, 410, 'Tinca', 'Matteo', '0712474563');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (140, 410, 'Paraschiv', 'Alexandru', '0756442331');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (141, 410, 'Chitu', 'Daria', '0711111163');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (142, 410, 'Paraschiv', 'Alexia', 'danaparaschiv@gmail.com');

insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (143, 411, 'Florescu', 'Darius', 'calincmn10@gmail.com');
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte)
values (144, 411, 'Serban', 'Alexandru', 'serbanion@gmail.com');

select *
from elev;



commit;

insert into BURSA values(1,'de_merit1', 800);
insert into BURSA values(2,'de_merit2', 650);
insert into BURSA values(3,'de_merit3', 400);
insert into BURSA values(4,'sociala', 300);
insert into BURSA values(5,'de_olimpic', 900);

select *
from bursa;



insert into OCUPATIE values(600,'secretar');
insert into OCUPATIE values(601,'contabil');
insert into OCUPATIE values(602,'instalator');
insert into OCUPATIE values(603,'electrician');
insert into OCUPATIE values(604,'om de serviciu');
insert into OCUPATIE values(605,'bibliotecar');

select *
from ocupatie;



insert into PERSONAL_AUXILIAR values(500, 'Stanciu', 'Silviana',6000, '02-Feb-04');
insert into PERSONAL_AUXILIAR values(501,'Raducu', 'Aurel',6400, '29-Oct-20');
insert into PERSONAL_AUXILIAR values(502, 'Simescu', 'Marcel', 5000, '19-Nov-12');
insert into PERSONAL_AUXILIAR values(503, 'Feraru', 'Cornel', 4300, '06-Jan-05');
insert into PERSONAL_AUXILIAR values(504, 'Cumpanasu', 'Gratiela', 4000, '06-Jan-05');
insert into PERSONAL_AUXILIAR values(505, 'Duinea', 'Ioana', 4000, '06-Jan-05');
insert into PERSONAL_AUXILIAR values(506, 'Velcea', 'Samuel', null, '06-Jan-05');
insert into PERSONAL_AUXILIAR values(507, 'Velcea', 'Paul', null, '06-Jan-05');

select *
from personal_auxiliar;



commit;
--sport
insert into PREDA values(100, 200);
insert into PREDA values(101, 200);
--mate
insert into PREDA values(102, 201);
insert into PREDA values(103, 201);
insert into PREDA values(104, 201);
insert into PREDA values(106, 201);
--info
insert into PREDA values(105, 202);
insert into PREDA values(106, 202);
insert into PREDA values(102, 202);
--fizica
insert into PREDA values(107, 203);
insert into PREDA values(108, 203);
--chimie
insert into PREDA values(109, 204);
insert into PREDA values(111, 204);
--biologie
insert into PREDA values(110, 205);
insert into PREDA values(111, 205);
--romana
insert into PREDA values(112, 206);
insert into PREDA values(113, 206);
insert into PREDA values(114, 206);
--istorie
insert into PREDA values(115, 207);
insert into PREDA values(116, 207);
insert into PREDA values(117, 207);
--geografie
insert into PREDA values(118, 208);
insert into PREDA values(119, 208);
insert into PREDA values(117, 208);
--logica
insert into PREDA values(120, 209);
insert into PREDA values(102, 209);
--engleza 
insert into PREDA values(121, 210);
insert into PREDA values(112, 210);
insert into PREDA values(123, 210);
--franceza
insert into PREDA values(123, 211);

select *
from preda;



insert into  SE_STUDIAZA values(401,200, 101, vector_coloana(t_imb_subcoloana('08:00'),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(401,201, 102, vector_coloana(t_imb_subcoloana('09:00'),t_imb_subcoloana('11:00'),t_imb_subcoloana('09:00'),t_imb_subcoloana('08:00','10:00'),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(401,202, 106, vector_coloana(t_imb_subcoloana('10:00'),t_imb_subcoloana('10:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00')));
insert into  SE_STUDIAZA values(401,202, 105, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana('09:00')));
insert into  SE_STUDIAZA values(401,203, 107, vector_coloana(t_imb_subcoloana('11:00'),t_imb_subcoloana(),t_imb_subcoloana('10:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(401,204, 109, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('11:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(401,205, 110, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('11:00'),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(401,206, 112, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('09:00','12:00'),t_imb_subcoloana('10:00','11:00')));
insert into  SE_STUDIAZA values(401,210, 112, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('09:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));

insert into  SE_STUDIAZA values(402,200, 100, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(402,201, 106, vector_coloana(t_imb_subcoloana('08:00','09:00','11:00'),t_imb_subcoloana(),t_imb_subcoloana('09:00'),t_imb_subcoloana('12:00'),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(402,202, 106, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('11:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('09:00','10:00')));
insert into  SE_STUDIAZA values(402,202, 102, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('10:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00')));
insert into  SE_STUDIAZA values(402,203, 108, vector_coloana(t_imb_subcoloana('10:00'),t_imb_subcoloana(),t_imb_subcoloana('10:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(402,204, 111, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('11:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(402,205, 110, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(402,206, 113, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('09:00','10:00','11:00'),t_imb_subcoloana('11:00')));
insert into  SE_STUDIAZA values(402,210, 121, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('09:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));

insert into  SE_STUDIAZA values(403,200, 100, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('11:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(403,201, 103, vector_coloana(t_imb_subcoloana('08:00','09:00','11:00'),t_imb_subcoloana(),t_imb_subcoloana('10:00','11:00'),t_imb_subcoloana('10:00'),t_imb_subcoloana('10:00')));
insert into  SE_STUDIAZA values(403,202, 105, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('09:00','10:00'),t_imb_subcoloana(),t_imb_subcoloana('09:00','11:00'),t_imb_subcoloana('08:00','11:00')));
insert into  SE_STUDIAZA values(403,203, 107, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(403,204, 109, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(403,205, 110, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('09:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(403,206, 114, vector_coloana(t_imb_subcoloana('10:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('09:00')));
insert into  SE_STUDIAZA values(403,210, 121, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana()));

insert into  SE_STUDIAZA values(404,200, 101, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('11:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(404,201, 104, vector_coloana(t_imb_subcoloana('08:00','09:00','10:00'),t_imb_subcoloana('10:00'),t_imb_subcoloana('09:00'),t_imb_subcoloana('10:00'),t_imb_subcoloana('08:00')));
insert into  SE_STUDIAZA values(404,202, 102, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('09:00'),t_imb_subcoloana('10:00','11:00'),t_imb_subcoloana('09:00','11:00'),t_imb_subcoloana('09:00','10:00','11:00')));
insert into  SE_STUDIAZA values(404,206, 114, vector_coloana(t_imb_subcoloana('11:00'),t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana('08:00'),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(404,210, 123, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));

insert into  SE_STUDIAZA values(405,201, 102, vector_coloana(t_imb_subcoloana('08:00'),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(405,201, 104, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('09:00'),t_imb_subcoloana(),t_imb_subcoloana('09:00','11:00'),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(405,202, 105, vector_coloana(t_imb_subcoloana('09:00','10:00'),t_imb_subcoloana('11:00'),t_imb_subcoloana('10:00'),t_imb_subcoloana('08:00'),t_imb_subcoloana('10:00')));
insert into  SE_STUDIAZA values(405,206, 112, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00','09:00'),t_imb_subcoloana(),t_imb_subcoloana('09:00')));


insert into SE_STUDIAZA values(406, 200, 100, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('16:00','17:00')));
insert into  SE_STUDIAZA values(406,207, 115, vector_coloana(t_imb_subcoloana('14:00','16:00','17:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into  SE_STUDIAZA values(406,207, 117, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('17:00'),t_imb_subcoloana('15:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(406, 206, 112, vector_coloana(t_imb_subcoloana('15:00'),t_imb_subcoloana('14:00'),t_imb_subcoloana('14:00','16:00','17:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(406, 208, 118, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('15:00','16:00','18:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(406, 205, 110, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('14:00','15:00'),t_imb_subcoloana()));
insert into SE_STUDIAZA values(406, 209, 120, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('16:00'),t_imb_subcoloana()));
insert into SE_STUDIAZA values(406, 209, 102, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('14:00')));
insert into SE_STUDIAZA values(406, 211, 123, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('17:00'),t_imb_subcoloana('15:00')));

insert into SE_STUDIAZA values(407, 207, 117, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('14:00','15:00'),t_imb_subcoloana()));
insert into SE_STUDIAZA values(407, 207, 115, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('14:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(407, 206, 113, vector_coloana(t_imb_subcoloana('14:00','15:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(407, 208, 118, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('14:00','17:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(407, 208, 117, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('16:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(407, 208, 119, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('15:00'),t_imb_subcoloana(),t_imb_subcoloana()));

insert into SE_STUDIAZA values(408, 211, 123, vector_coloana(t_imb_subcoloana('14:00', '15:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(408, 209, 120, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('14:00'),t_imb_subcoloana(),t_imb_subcoloana()));

insert into SE_STUDIAZA values(409, 209, 102, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('14:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(409, 207, 117, vector_coloana(t_imb_subcoloana('14:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('14:00','15:00','16:00','17:00')));

insert into SE_STUDIAZA values(410, 211, 123, vector_coloana(t_imb_subcoloana('08:00','09:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(410, 210, 121, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(410, 207, 117, vector_coloana(t_imb_subcoloana('10:00'),t_imb_subcoloana('09:00','10:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(410, 207, 115, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana(),t_imb_subcoloana()));
insert into SE_STUDIAZA values(410, 208, 118, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00'),t_imb_subcoloana()));
insert into SE_STUDIAZA values(410, 206, 114, vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana('08:00')));

insert into SE_STUDIAZA values(411, 200, 101, vector_coloana(t_imb_subcoloana('14:00','15:00'),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()));

select id_clasa, id_materie, id_profesor, b.*
from se_studiaza a, table(a.orar)b; 

select *
from se_studiaza;

commit;

SELECT id_clasa, id_materie,  id_profesor, zi.COLUMN_VALUE c0, ora.COLUMN_VALUE c1
FROM SE_STUDIAZA t, TABLE(t.orar) zi,TABLE(zi.COLUMN_VALUE) ora;

---APLICATIE DE PROBARE DACA FIECARE PROFESOR NU PREDA ALTE MATERII IN AFARA DE CELE PE CARE LE STIE:
select s.id_clasa, s.id_profesor, s.id_materie
from se_studiaza s
where not exists
(
select 1
from preda p
where p.id_profesor=s.id_profesor and p.id_materie=s.id_materie
);

---APLICATIE DE PROBARE DACA EXISTA SUPRAPUNERI IN ORAR pentru acelasi profesor in clase diferite:
DECLARE
    TYPE rec IS RECORD (id_clasa NUMBER, id_materie NUMBER, id_profesor NUMBER, orar_pentru_o_zi t_imb_subcoloana );
    TYPE tab_imb IS TABLE OF rec; 
    tb1 tab_imb;
    tb2 tab_imb;
BEGIN
FOR contor in 1..5 LOOP
    tb1:=tab_imb();
    tb2:=tab_imb();
    FOR r IN (SELECT id_clasa, id_materie, id_profesor, orar FROM SE_STUDIAZA) LOOP
            tb1.EXTEND;
            tb1(tb1.LAST).id_clasa:=r.id_clasa;
            tb1(tb1.LAST).id_materie:=r.id_materie;
            tb1(tb1.LAST).id_profesor:=r.id_profesor;
            tb1(tb1.LAST).orar_pentru_o_zi:=r.orar(contor);
    END LOOP;
    FOR r IN (SELECT id_clasa, id_materie, id_profesor, orar FROM SE_STUDIAZA) LOOP
            tb2.EXTEND;
            tb2(tb2.LAST).id_clasa:=r.id_clasa;
            tb2(tb2.LAST).id_materie:=r.id_materie;
            tb2(tb2.LAST).id_profesor:=r.id_profesor;
            tb2(tb2.LAST).orar_pentru_o_zi:=r.orar(contor); 
    END LOOP;
    FOR i IN 1..tb1.COUNT LOOP
      FOR j IN 1..tb2.COUNT LOOP
        IF tb1(i).id_clasa<tb2(j).id_clasa and tb1(i).id_profesor=tb2(j).id_profesor THEN
           IF tb1(i).orar_pentru_o_zi.count<>0 and tb2(j).orar_pentru_o_zi.count<>0 THEN
              FOR k1 IN 1..tb1(i).orar_pentru_o_zi.count LOOP
                FOR k2 IN 1..tb2(j).orar_pentru_o_zi.count LOOP
                  IF  tb1(i).orar_pentru_o_zi(k1)=  tb2(j).orar_pentru_o_zi(k2) THEN            
                        DBMS_OUTPUT.PUT_LINE('Exista o suprapunere pentru profesorul '||tb1(i).id_profesor||' la clasele:'||tb1(i).id_clasa||' si '||tb2(j).id_clasa||', la ora '||tb1(i).orar_pentru_o_zi(k1)||' si ziua '||contor||' a saptamanii.');
                  END IF;
                END LOOP;
              END LOOP;
            END IF;
        END IF;
      END LOOP;
    END LOOP;
END LOOP;
END;
/

---APLICATIE DE PROBARE DACA EXISTA SUPRAPUNERI IN ORAR pentru acelasi profesor in aceeasi clasa (la materii diferite):
DECLARE
    TYPE rec IS RECORD (id_clasa NUMBER, id_materie NUMBER, id_profesor NUMBER, orar_pentru_o_zi t_imb_subcoloana );
    TYPE tab_imb IS TABLE OF rec; 
    tb1 tab_imb;
BEGIN
FOR contor in 1..5 LOOP
    tb1:=tab_imb();
    FOR r IN (SELECT id_clasa, id_materie, id_profesor, orar FROM SE_STUDIAZA) LOOP
            tb1.EXTEND;
            tb1(tb1.LAST).id_clasa:=r.id_clasa;
            tb1(tb1.LAST).id_materie:=r.id_materie;
            tb1(tb1.LAST).id_profesor:=r.id_profesor;
            tb1(tb1.LAST).orar_pentru_o_zi:=r.orar(contor);
    END LOOP;
    FOR i IN 1..tb1.COUNT LOOP
      FOR j IN 1..tb1.COUNT LOOP
        IF tb1(i).id_clasa=tb1(j).id_clasa and tb1(i).id_profesor=tb1(j).id_profesor and tb1(i).id_materie<tb1(j).id_materie THEN
           IF tb1(i).orar_pentru_o_zi.count<>0 and tb1(j).orar_pentru_o_zi.count<>0 THEN
              FOR k1 IN 1..tb1(i).orar_pentru_o_zi.count LOOP
                FOR k2 IN 1..tb1(j).orar_pentru_o_zi.count LOOP
                  IF  tb1(i).orar_pentru_o_zi(k1)=  tb1(j).orar_pentru_o_zi(k2) THEN            
                        DBMS_OUTPUT.PUT_LINE('Exista o suprapunere pentru profesorul '||tb1(i).id_profesor||' la clasa '||tb1(i).id_clasa||', la materiile:'||tb1(i).id_materie||' si '||tb1(j).id_materie||', la ora '||tb1(i).orar_pentru_o_zi(k1)||' si ziua '||contor||' a saptamanii.');
                  END IF;
                END LOOP;
              END LOOP;
            END IF;
        END IF;
      END LOOP;
    END LOOP;
END LOOP;
END;
/

---APLICATIE DE PROBARE DACA EXISTA SUPRAPUNERI IN ORAR pentru profesori diferiti in aceeasi clasa:
DECLARE
    TYPE rec IS RECORD (id_clasa NUMBER, id_materie NUMBER, id_profesor NUMBER, orar_pentru_o_zi t_imb_subcoloana );
    TYPE tab_imb IS TABLE OF rec; 
    tb1 tab_imb;
    tb2 tab_imb;
BEGIN
FOR contor in 1..5 LOOP
    tb1:=tab_imb();
    tb2:=tab_imb();
    FOR r IN (SELECT id_clasa, id_materie, id_profesor, orar FROM SE_STUDIAZA) LOOP
            tb1.EXTEND;
            tb1(tb1.LAST).id_clasa:=r.id_clasa;
            tb1(tb1.LAST).id_materie:=r.id_materie;
            tb1(tb1.LAST).id_profesor:=r.id_profesor;
            tb1(tb1.LAST).orar_pentru_o_zi:=r.orar(contor);
    END LOOP;
    FOR r IN (SELECT id_clasa, id_materie, id_profesor, orar FROM SE_STUDIAZA) LOOP
            tb2.EXTEND;
            tb2(tb2.LAST).id_clasa:=r.id_clasa;
            tb2(tb2.LAST).id_materie:=r.id_materie;
            tb2(tb2.LAST).id_profesor:=r.id_profesor;
            tb2(tb2.LAST).orar_pentru_o_zi:=r.orar(contor); 
    END LOOP;
    FOR i IN 1..tb1.COUNT LOOP
      FOR j IN 1..tb2.COUNT LOOP
        IF tb1(i).id_clasa=tb2(j).id_clasa and tb1(i).id_profesor<tb2(j).id_profesor  THEN
           IF tb1(i).orar_pentru_o_zi.count<>0 and tb2(j).orar_pentru_o_zi.count<>0 THEN
              FOR k1 IN 1..tb1(i).orar_pentru_o_zi.count LOOP
                FOR k2 IN 1..tb2(j).orar_pentru_o_zi.count LOOP
                  IF  tb1(i).orar_pentru_o_zi(k1)=  tb2(j).orar_pentru_o_zi(k2) THEN            
                        DBMS_OUTPUT.PUT_LINE('Exista o suprapunere pentru profesorii:'||tb1(i).id_profesor||' si '||tb2(j).id_profesor||', la clasa '||tb1(i).id_clasa||', la ora '||tb1(i).orar_pentru_o_zi(k1)||' si ziua '||contor||' a saptamanii.');
                  END IF;
                END LOOP;
              END LOOP;
            END IF;
        END IF;
      END LOOP;
    END LOOP;
END LOOP;
END;
/



DECLARE
random_date date;
start_date date:=to_date('01-Sep-2023'); 
end_date date:=to_date('30-Jun-2024');
total_days number:=end_date - start_date;
nota number(2);
ok number(2);
BEGIN
FOR c1 in (select id_elev a1, id_clasa a2 from elev) LOOP
       FOR c2 in (select id_materie b2, id_profesor b3, orar b4 from se_studiaza where id_clasa=c1.a2) LOOP
              FOR j IN 1..5 LOOP
                    IF c2.b4(j).count<>0 THEN
                       FOR i IN 1..2 LOOP
                              random_date:=start_date + trunc(DBMS_RANDOM.VALUE(0, total_days + 1));
                              ok:=0;
                              CASE 
                              WHEN j=1 THEN
                                    WHILE to_char(random_date, 'DY')<>'MON' LOOP
                                      random_date:=start_date + trunc(DBMS_RANDOM.VALUE(0, total_days + 1));
                                    END LOOP;
                                    nota:=trunc(DBMS_RANDOM.VALUE(1, 11));
                                    select count(*) INTO ok
                                    from pune_nota
                                    where id_profesor=c2.b3 and id_materie=c2.b2 and id_elev=c1.a1 and data=random_date;
                                    IF ok=0 and random_date NOT IN ('25-Dec-2023','01-Jan-2024', '05-May-2024') THEN
                                        --DBMS_OUTPUT.PUT_LINE(c2.b3||' '||c2.b2||' '||c1.a1||' '||j||' '||random_date||' '||nota);
                                        insert into PUNE_NOTA values(c2.b3, c2.b2, c1.a1, random_date, nota);
                                    END IF;
                              WHEN j=2 THEN
                                    WHILE to_char(random_date, 'DY')<>'TUE' LOOP
                                      random_date:=start_date + trunc(DBMS_RANDOM.VALUE(0, total_days + 1));
                                    END LOOP;
                                    nota:=trunc(DBMS_RANDOM.VALUE(1, 11));
                                    select count(*) INTO ok
                                    from pune_nota
                                    where id_profesor=c2.b3 and id_materie=c2.b2 and id_elev=c1.a1 and data=random_date;
                                    IF ok=0 and random_date NOT IN ('25-Dec-2023','01-Jan-2024', '05-May-2024') THEN
                                        --DBMS_OUTPUT.PUT_LINE(c2.b3||' '||c2.b2||' '||c1.a1||' '||j||' '||random_date||' '||nota);
                                        insert into PUNE_NOTA values(c2.b3, c2.b2, c1.a1, random_date, nota);
                                    END IF;
                              WHEN j=3 THEN
                                    WHILE to_char(random_date, 'DY')<>'WED' LOOP
                                      random_date:=start_date + trunc(DBMS_RANDOM.VALUE(0, total_days + 1));
                                    END LOOP;
                                    nota:=trunc(DBMS_RANDOM.VALUE(1, 11));
                                    select count(*) INTO ok
                                    from pune_nota
                                    where id_profesor=c2.b3 and id_materie=c2.b2 and id_elev=c1.a1 and data=random_date;
                                    IF ok=0 and random_date NOT IN ('25-Dec-2023','01-Jan-2024', '05-May-2024') THEN
                                        --DBMS_OUTPUT.PUT_LINE(c2.b3||' '||c2.b2||' '||c1.a1||' '||j||' '||random_date||' '||nota);
                                        insert into PUNE_NOTA values(c2.b3, c2.b2, c1.a1, random_date, nota);
                                    END IF;
                              WHEN j=4 THEN
                                    WHILE to_char(random_date, 'DY')<>'THU' LOOP
                                      random_date:=start_date + trunc(DBMS_RANDOM.VALUE(0, total_days + 1));
                                    END LOOP;
                                    nota:=trunc(DBMS_RANDOM.VALUE(1, 11));
                                    select count(*) INTO ok
                                    from pune_nota
                                    where id_profesor=c2.b3 and id_materie=c2.b2 and id_elev=c1.a1 and data=random_date;
                                    IF ok=0 and random_date NOT IN ('25-Dec-2023','01-Jan-2024', '05-May-2024') THEN
                                        --DBMS_OUTPUT.PUT_LINE(c2.b3||' '||c2.b2||' '||c1.a1||' '||j||' '||random_date||' '||nota);
                                        insert into PUNE_NOTA values(c2.b3, c2.b2, c1.a1, random_date, nota);
                                    END IF;
                              ELSE
                                    WHILE to_char(random_date, 'DY')<> 'FRI' LOOP
                                      random_date:=start_date + trunc(DBMS_RANDOM.VALUE(0, total_days + 1));
                                    END LOOP;
                                    nota:=trunc(DBMS_RANDOM.VALUE(1, 11));
                                    select count(*) INTO ok
                                    from pune_nota
                                    where id_profesor=c2.b3 and id_materie=c2.b2 and id_elev=c1.a1 and data=random_date;
                                    IF ok=0 and random_date NOT IN ('25-Dec-2023','01-Jan-2024', '05-May-2024') THEN
                                        --DBMS_OUTPUT.PUT_LINE(c2.b3||' '||c2.b2||' '||c1.a1||' '||j||' '||random_date||' '||nota);
                                        insert into PUNE_NOTA values(c2.b3, c2.b2, c1.a1, random_date, nota);
                                    END IF;
                        END CASE;
                    END LOOP;
                END IF;
        END LOOP;
    END LOOP;
END LOOP;
END;
/
insert into PUNE_NOTA values (100,200,114,'07-Nov-2023',10);
insert into PUNE_NOTA values (111,205,119,'02-May-2024',8);

select * from pune_nota ;

commit;

---Actualizare absente si medie_purtare:
DECLARE
cod number(4);
BEGIN
FOR i IN 1..15 LOOP
    select trunc(DBMS_RANDOM.VALUE(114, 145)) INTO cod
    from DUAL;
    update elev
    set medie_purtare=medie_purtare-1
    where id_elev=cod;
    select trunc(DBMS_RANDOM.VALUE(114, 145)) INTO cod
    from DUAL;
    update elev
    set numar_absente=numar_absente+1
    where id_elev=cod;
END LOOP;
END;
/

---ACTUALIZARE medie-generala IN FUNCTIE DE NOTELE INSERATE:
DECLARE 
suma number(4);
numar number(2);
medie number(4,2);
exista number(4);
BEGIN
FOR c1 in (select id_clasa a1 from clasa) LOOP
    select count(id_materie) INTO numar
    from(
    select distinct id_materie
    from se_studiaza
    where id_clasa=c1.a1);
    numar:=numar+1;--luam in calcul si nota la purtare
    FOR c2 in (select id_elev b1, medie_purtare b2 from elev where id_clasa=c1.a1) LOOP
        suma:=c2.b2;--luam in calcul si nota la purtare
        FOR c3 in (select distinct id_materie d1 from se_studiaza where id_clasa=c1.a1) LOOP
                select count(*) INTO exista
                from pune_nota
                where id_materie=c3.d1 and id_elev=c2.b1;
                IF exista<>0 THEN
                    select round(avg(nota)) INTO medie
                    from pune_nota
                    where id_materie=c3.d1 and id_elev=c2.b1;
                    suma:=suma+medie;
                END IF;
        END LOOP;
        update elev
        set medie_generala=suma/numar
        where id_elev=c2.b1;
    END LOOP;         
END LOOP;
END;
/

select * from elev;



DECLARE
BEGIN
FOR c1 in (select id_elev a1, id_clasa a2 , medie_generala a3, medie_purtare a4, numar_absente a5 from elev) LOOP
IF c1.a4>=9 and c1.a5<=1 THEN
    IF  c1.a3>=5.4 and c1.a3<7 THEN IF c1.a1 mod 2=0 THEN  insert into primeste values(c1.a1, 3, 'cash');
                                                ELSE insert into primeste values(c1.a1, 3, 'card');
                                                END IF;
           ELSIF c1.a3>=7 and c1.a3<9 THEN IF c1.a1 mod 4=0 THEN  insert into primeste values(c1.a1, 2, 'cash');
                                                ELSE insert into primeste values(c1.a1, 2, 'card');
                                                END IF;
           ELSIF c1.a3>=9 THEN IF c1.a1 mod 5=0 THEN  insert into primeste values(c1.a1, 1, 'cash');
                                                ELSE insert into primeste values(c1.a1, 1, 'card');
                                                END IF;
          END IF;
END IF;
END LOOP;
END;
/
insert into primeste values(132, 5, 'cash');
insert into primeste values(140, 5, 'card');
insert into primeste values(128, 4, 'cash');
insert into primeste values(132, 4, 'cash');

select *
from primeste;



insert into are values(500,600);
insert into are values(500,601);
insert into are values(501,601);
insert into are values(502,602);
insert into are values(502,603);
insert into are values(502,604);
insert into are values(503,603);
insert into are values(503,604);
insert into are values(504,604);
insert into are values(505,605);
insert into are values(506,604);
insert into are values(507,604);
  
select *
from are;



DECLARE
ok number(2);
BEGIN
FOR c1 IN (select id_sala a1 from sala) LOOP
     ok:=0;
     FOR c2 IN (select id_pers_aux b1 from personal_auxiliar where  id_pers_aux not in(500,501,505,507)) LOOP
         IF c1.a1 mod 4 = c2.b1 mod 3 THEN insert into este_ingrijita_de values(c1.a1, c2.b1);
         ELSIF ok=0 THEN insert into este_ingrijita_de values(c1.a1, 507); ok:=1;
         END IF;
     END LOOP;
END LOOP;
END;
/

select *
from este_ingrijita_de;

commit;



select *
from se_studiaza;



---EX6.
CREATE OR REPLACE PROCEDURE actualizare_orar (v_nume IN profesor.nume%type, denumire_clasa IN clasa.denumire%type,
v_profil clasa.profil%type, denumire_materie materie.denumire%type, ziua varchar2, ora varchar2)
IS 

contor number(2) := 1;
ok number(1) := 0;--Verific daca ora noua se afla dupa toate celelalte.
ok1 number(1) := 0;--Verificam daca profesorul preda acea materie.
ok2 number(1) := 0;--Verificam daca profesorul preda sau nu la clasa
--respectiva materia respectiva, ca sa stim daca facem insert sau update.

TYPE vector_coduri IS VARRAY(3) OF number(4);
--Pentru modularitate si abstractizare, voi retine id_profesor, id_clasa
--id_materie intr-un vector cu 3 elemente.
v1 vector_coduri := vector_coduri();

TYPE tab_indexat_zile_saptamanii IS TABLE OF number(1) INDEX BY varchar2(3);
--Pentru un acces rapid si pentru simpificarea codului.
t1 tab_indexat_zile_saptamanii;

TYPE tab_indexat_orare IS TABLE OF se_studiaza.orar%type INDEX BY PLS_INTEGER;
t2 tab_indexat_orare;--Toate orarele profesorului respectiv de la toate clasele unde preda in ziua data.
t3  tab_indexat_orare;--Toate orarele profesorilor de la clasa respectiva in ziua data, orare
--doar pentru clasa respectiva.


--TABLOURI IMBRICATE+VECTORI:
t4 t_imb_subcoloana:=t_imb_subcoloana();--Aici vom face reuniunea tuturor
--orelor de predare din t2 si t3. In aceasta reuniune nu trebuie sa se gaseasca
--ora respectiva/data ca parametru.
t5 t_imb_subcoloana := t_imb_subcoloana();--Tabloul care contine doar ora respectiva.
t6 t_imb_subcoloana := t_imb_subcoloana();--Tabloul-intersesctie dintre t5 si t4(trebuie:t6<>t5).

orar_actual se_studiaza.orar%type;--Orarul actual al profesorului pentru clasa si materia respectiva.
orar_nou vector_coloana := vector_coloana(t_imb_subcoloana(),t_imb_subcoloana(),
t_imb_subcoloana(),t_imb_subcoloana(),t_imb_subcoloana()); --Noul orar al profesorului pentru clasa respectiva/Tip vector

exceptie1 EXCEPTION;
exceptie2 EXCEPTION;

BEGIN
t1('MON') := 1; t1('TUE') := 2; t1('WED') := 3;
t1('THU') := 4;t1('FRI') := 5;

v1.extend;
select id_profesor INTO v1(1)
from profesor 
where upper(nume) = upper(v_nume);

v1.extend;
select id_clasa INTO v1(2)
from clasa 
where upper(denumire) = upper(denumire_clasa) and upper(profil) = upper(v_profil);

v1.extend;
select id_materie INTO v1(3)
from materie
where upper(denumire) = upper(denumire_materie);

select count(*) INTO ok1
from preda 
where id_materie = v1(3) and id_profesor = v1(1);
IF ok1 = 0 THEN RAISE exceptie1;
END IF;

select orar BULK COLLECT INTO t2
from se_studiaza
where id_profesor = v1(1);

select orar BULK COLLECT INTO t3
from se_studiaza
where id_clasa = v1(2);

IF t2.count <> 0 THEN
   FOR i in 1..t2.last LOOP
               t4 := t4 MULTISET UNION DISTINCT t2(i)(t1(ziua));
    END LOOP;
END IF;

IF t3.count <> 0 THEN
   FOR i in 1..t3.last LOOP
               t4 := t4 MULTISET UNION DISTINCT t3(i)(t1(ziua));
    END LOOP;
END IF;
              
t5.extend;
t5(1) := ora;

t6 := t4 MULTISET INTERSECT DISTINCT t5; 
IF t6 = t5 THEN RAISE exceptie2;
END IF;

select count(*) INTO ok2
from se_studiaza
where id_profesor = v1(1) and id_clasa = v1(2) and id_materie = v1(3);

if ok2 = 0 THEN orar_nou(t1(ziua)).extend; orar_nou(t1(ziua))(1) := ora; insert into SE_STUDIAZA values (v1(2),v1(3),v1(1), orar_nou);
ELSE 
    select orar INTO orar_actual
    from se_studiaza
    where id_profesor = v1(1) and id_clasa = v1(2) and id_materie = v1(3);
    IF orar_actual(t1(ziua)).count = 0 THEN orar_actual(t1(ziua)).extend; orar_actual(t1(ziua))(1) := ora; orar_nou := orar_actual;
    ELSE
        FOR i IN 1..5 LOOP
            IF i <> t1(ziua) THEN orar_nou(i) := orar_actual(i);
            END IF;
        END LOOP;
        FOR i IN 1..orar_actual(t1(ziua)).last LOOP
            IF orar_actual(t1(ziua))(i) < ora THEN orar_nou(t1(ziua)).extend; orar_nou(t1(ziua))(contor) := orar_actual(t1(ziua))(i); contor := contor + 1; 
            ELSE ok := 1; orar_nou(t1(ziua)).extend; orar_nou(t1(ziua))(contor) := ora; contor := contor + 1;
            orar_nou(t1(ziua)).extend; orar_nou(t1(ziua))(contor) := orar_actual(t1(ziua))(i); contor := contor + 1; 
            END IF;
        END LOOP;
        IF ok = 0 THEN orar_nou(t1(ziua)).extend; orar_nou(t1(ziua))(contor) := ora;
        END IF;
    END IF;
    update SE_STUDIAZA
    set orar = orar_nou
    where id_profesor = v1(1) and id_clasa = v1(2) and id_materie = v1(3);
END IF;

DBMS_OUTPUT.PUT_LINE('Orarul a fost actualizat cu succes!');
commit;

EXCEPTION WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Nu exista profesorul, clasa sau materia!'); 
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Exista mai mult de un profesor sau o clasa din cele date!');
WHEN exceptie1 THEN DBMS_OUTPUT.PUT_LINE('Profesorul dat nu preda acea materie!');
WHEN exceptie2 THEN DBMS_OUTPUT.PUT_LINE('Exista suprapuneri in orar!');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Alta eroare!');
END actualizare_orar;
/




EXECUTE actualizare_orar('Stanciu', '10A', 'mate-info', 'informatica', 'MON', '12:00');
EXECUTE actualizare_orar('Fugulin', '10A', 'mate-info', 'informatica', 'MON', '12:00');



BEGIN 
actualizare_orar('Florea', '10A', 'mate-info', 'chimie', 'MON', '12:00');
END;
/

BEGIN 
actualizare_orar('Florea', '10A', 'mate-info', 'informatica', 'THU', '08:00');
END;
/

BEGIN 
actualizare_orar('Florea', '10A', 'mate-info', 'informatica', 'THU', '08:00');
END;
/

BEGIN 
actualizare_orar('Florea', '10A', 'mate-info', 'informatica', 'THU', '10:00');
END;
/

BEGIN 
actualizare_orar('Florea', '10A', 'mate-info', 'informatica', 'THU', '12:00');
END;
/

BEGIN 
actualizare_orar('Florea', '10A', 'mate-info', 'informatica', 'THU', '15:00');
END;
/

BEGIN 
actualizare_orar('Florea', '10A', 'mate-info', 'informatica', 'THU', '14:00');
END;
/

BEGIN 
actualizare_orar('Florea', '10A', 'mate-info', 'informatica', 'MON', '15:00');
END;
/


BEGIN 
actualizare_orar('Florea', '9B', 'mate-info', 'informatica', 'MON', '16:00');
END;
/




---E7.
CREATE OR REPLACE PROCEDURE afisare_program
IS 

CURSOR c2(cod_clasa number) IS--CURSOR CLASIC/IMPLICIT parametrizat, dependent de un CICLU CURSOR CU SUBCERE
    select m.id_materie, NVL(MAX(m.denumire),'NE'),
        CURSOR(
          select p.id_profesor, NVL(p.nume,'N')||' '||NVL(p.prenume,'E'), s2.orar
          from profesor p, se_studiaza s2
          where p.id_profesor = s2.id_profesor and
          s2.id_clasa = cod_clasa
          and s2.id_materie = m.id_materie--ATENTE: daca foloseam s.id_materie,
          --nu ar fi mers, caci colona s.id_materie nu e pusa in group by
      )--EXPRESIE CURSOR
    from materie m, se_studiaza s 
    where m.id_materie = s.id_materie and s.id_clasa = cod_clasa
    group by m.id_materie;---Ignora cursorul.   

cod_materie materie.id_materie%type;
denumire_materie materie.denumire%type;   
c3 SYS_REFCURSOR;--CURSOR DINAMIC pentru EXPRESIA CURSOR

TYPE inregistare_profesor IS RECORD (cod profesor.id_profesor%type, nume varchar2(100), orar se_studiaza.orar%type);
TYPE tab_imbricat_profesori IS TABLE OF inregistare_profesor;
t tab_imbricat_profesori;
aux inregistare_profesor;

contor number(4) := 0;
nr_ore number(4);
nr_total_ore number(4);
TYPE inregistare_profesor_nr_ore IS RECORD (cod profesor.id_profesor%type, nr_ore number(4));
TYPE tab_imbricat_profesori_nr_ore IS TABLE OF inregistare_profesor_nr_ore;
t2 tab_imbricat_profesori_nr_ore;
aux2 inregistare_profesor_nr_ore;

BEGIN
FOR c1 IN (select c.id_clasa cod_clasa, NVL(c.denumire,'NE') v_denumire, NVL(c.profil,'NE') v_profil,
           dirig.id_profesor cod_diriginte, NVL(dirig.nume,'N')||' '||NVL(dirig.prenume,'E') v_diriginte
           from clasa c, profesor dirig
           where c.id_diriginte=dirig.id_profesor) LOOP--CICLU CURSOR CU SUBCERE, neparametrizat
    DBMS_OUTPUT.PUT_LINE('Clasa: '||c1.cod_clasa||', '||c1.v_denumire||' de '||c1.v_profil||' cu dirigintele: '||c1.cod_diriginte||', '||c1.v_diriginte);
    contor := 0;
    
    OPEN c2(c1.cod_clasa);
    LOOP
        contor := contor+1;
        nr_total_ore := 0;
        FETCH c2 INTO  cod_materie, denumire_materie, c3;
        EXIT WHEN c2%NOTFOUND;
        
        t := tab_imbricat_profesori();
        t2 := tab_imbricat_profesori_nr_ore();
        FETCH c3 BULK COLLECT INTO t;
        
        IF t.count <> 0 THEN
            FOR j IN 1..t.last LOOP
                t2.extend;
                t2(j).cod := t(j).cod;
                nr_ore := 0;
                FOR k IN 1..5 LOOP
                    nr_ore := nr_ore + t(j).orar(k).count;
                END LOOP;
                t2(j).nr_ore := nr_ore;
                nr_total_ore := nr_total_ore + nr_ore;
            END LOOP;
        END IF;
        DBMS_OUTPUT.PUT_LINE('   Materie'||contor||': '||cod_materie||', '||denumire_materie||'-numar de ore pe sapt.:'||nr_total_ore);
        --Sortez descrescator dupa numarul de ore predate
        --in paralel pe t si t2:
        IF t2.count >= 2 THEN
            FOR i IN 1..t2.count-1 LOOP
                FOR j IN i+1..t2.count LOOP
                    IF t2(i).nr_ore < t2(j).nr_ore THEN 
                        aux2 := t2(i);
                        t2(i) := t2(j);
                        t2(j) := aux2;
                        aux := t(i);
                        t(i) := t(j);
                        t(j) := aux;
                    END IF;
                    END LOOP;
                END LOOP;
        END IF;
        IF t.count <> 0 THEN
            FOR i IN 1..t.count LOOP
                DBMS_OUTPUT.PUT_LINE('       Profesorul cu codul:'||t(i).cod||' si numele:'||t(i).nume||' preda '||t2(i).nr_ore||' ore pe saptamana.');
            END LOOP;
        END IF;
    
    END LOOP;
    CLOSE c2;
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
END LOOP;

END;
/
            

EXECUTE afisare_program;

BEGIN
afisare_program;
END;
/












---E8.
CREATE OR REPLACE FUNCTION gaseste_bursieri (nume_profesor profesor.nume%type)
RETURN number IS

nr number(4);
cod_profesor profesor.id_profesor%type;
nume_prof varchar2(100);
denumire_materie materie.denumire%type;
denumire_clasa clasa.denumire%type;
profil_clasa clasa.profil%type;

nr_elevi number(4);
nr_elevi_bursieri number(4);
nr_elevi_bmerit number(4);
nr_elevi_bspeciala number(4);
raport number(4,2);

ok number(2):=0;
contor_exceptii number(2) := 1;

nume_in_format_invalid EXCEPTION;
PRAGMA EXCEPTION_INIT (nume_in_format_invalid, -00020);

BEGIN
select count(*) INTO ok
from profesor
where upper(nume) = upper(nume_profesor) and nume <> nume_profesor;

IF ok <> 0 THEN raise nume_in_format_invalid;
END IF;

select id_profesor, nume||' '||NVL(prenume,'') INTO cod_profesor, nume_prof
from profesor
where upper(nume) = upper(nume_profesor);
contor_exceptii := contor_exceptii+1;

select NVL(denumire,'NE'), NVL(profil,'NE') INTO denumire_clasa, profil_clasa
from clasa where id_diriginte = cod_profesor;
contor_exceptii := contor_exceptii+1;

select NVL(denumire,'NE') INTO denumire_materie
from profesor pf, preda pr, materie mt
where pf.id_profesor = pr.id_profesor and pr.id_materie = mt.id_materie
and upper(nume) = upper(nume_profesor);

select count(*) INTO nr_elevi_bursieri
from elev e2
where exists(
    select 1
    from clasa c, elev e, primeste p
    where c.id_clasa = e.id_clasa and e.id_elev = p.id_elev 
    and c.denumire = denumire_clasa
    and c.profil =  profil_clasa
    and e2.id_elev = e.id_elev
    );

select count(*) INTO nr_elevi_bmerit 
from clasa c, elev e, primeste p, bursa b
where c.id_clasa = e.id_clasa and e.id_elev = p.id_elev 
and p.id_bursa = b.id_bursa and c.denumire = denumire_clasa
and c.profil =  profil_clasa and tip like '%merit%';

select count(*) INTO nr_elevi_bspeciala 
from clasa c, elev e, primeste p, bursa b
where c.id_clasa = e.id_clasa and e.id_elev = p.id_elev 
and p.id_bursa = b.id_bursa and c.denumire = denumire_clasa
and c.profil =  profil_clasa and tip NOT like '%merit%';

raport :=  nr_elevi_bmerit/nr_elevi_bspeciala;

select numar_elevi INTO nr_elevi 
from clasa 
where id_diriginte = cod_profesor;

DBMS_OUTPUT.PUT_LINE('Profesorul '||nume_prof||' cu id-ul '||cod_profesor||' preda '||denumire_materie||' si este diriginte la clasa '||denumire_clasa||' de '||
profil_clasa||'.');
DBMS_OUTPUT.PUT_LINE('Clasa are '||nr_elevi_bursieri||' elevi bursieri, iar raportul dintre numarul de burse de merit si cele speciale este '||raport||'.');

return nr_elevi;

EXCEPTION
WHEN NO_DATA_FOUND THEN 
    CASE contor_exceptii
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: nu exista un profesor cu numele dat!');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: nu exista o clasa unde profesorul dat sa fie diriginte!');
    END CASE;
    return -1;
WHEN TOO_MANY_ROWS THEN
    CASE contor_exceptii 
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: exista mai mult de un profesor cu numele dat!');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE ('EXCEPTIE: exista mai mult de o clasa unde profesorul dat este diriginte!');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE ('EXCEPTIE: exista mai mult de o materie pe care profesorul dat sa o predea!');
    END CASE;
    return -1;
WHEN nume_in_format_invalid THEN
DBMS_OUTPUT.PUT_LINE('EXCEPTIE (cod:'||SQLCODE||'): numele dat exista, dar scris cu initiala si restul literelor-mici!');
return -1;
WHEN ZERO_DIVIDE  THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: nu se poate face raportul dintre bursieri, intrucat nu exista elevii ce iau burse speciale!');
return -1;
END;
/


VARIABLE rezultat number;
EXECUTE :rezultat := gaseste_bursieri ('Stanciu');
PRINT rezultat;

VARIABLE rezultat number;
EXECUTE :rezultat := gaseste_bursieri ('Dobroiu');
PRINT rezultat;

BEGIN
DBMS_OUTPUT.PUT_LINE(gaseste_bursieri ('Fugulin'));
END;
/

BEGIN
DBMS_OUTPUT.PUT_LINE(gaseste_bursieri ('Voica'));
END;
/

BEGIN
DBMS_OUTPUT.PUT_LINE(gaseste_bursieri ('Sterea'));
END;
/
select (gaseste_bursieri ('Sterea'))
from dual;

VARIABLE rezultat number;
EXECUTE :rezultat := gaseste_bursieri ('duican');
PRINT rezultat;


BEGIN
DBMS_OUTPUT.PUT_LINE(gaseste_bursieri ('Butculescu'));
END;
/

VARIABLE rezultat number;
EXECUTE :rezultat := gaseste_bursieri ('Duican');
PRINT rezultat;








---EX9.
CREATE OR REPLACE PROCEDURE adauga_nota (nume_elev elev.nume%type, denumire_materie materie.denumire%type,
data varchar2, nota number) IS

cod_elev elev.id_elev%type;
cod_materie materie.id_materie%type;
cod_profesor profesor.id_profesor%type;
nume_profesor profesor.nume%type;
contor_exceptii number(2) := 1;
data_verificata date;
ok number(2);

zi_corespunzatoare number(2);
orar_prof se_studiaza.orar%type;

nota_gresita EXCEPTION;
data_necorespunzatoare EXCEPTION;
suprapunere EXCEPTION;


BEGIN
select id_elev INTO cod_elev
from elev
where upper(nume) =  upper(nume_elev);
contor_exceptii := contor_exceptii + 1;

select m.id_materie, p.id_profesor, NVL(p.nume,'NE')
INTO cod_materie, cod_profesor, nume_profesor 
from elev e join clasa c on e.id_clasa = c.id_clasa
            join  se_studiaza s on c.id_clasa = s.id_clasa
            join materie m on s.id_materie = m.id_materie
            join profesor p on s.id_profesor = p.id_profesor
where e.id_elev = cod_elev and upper(m.denumire) =  upper(denumire_materie);

IF nota<0 or nota >10 THEN raise nota_gresita;
END IF;
data_verificata := TO_DATE(data, 'DD-MON-YYYY');

select count(id_profesor) INTO ok
from pune_nota
where id_profesor = cod_profesor 
and id_materie = cod_materie 
and id_elev = cod_elev
and data = data_verificata;
IF ok = 1 THEN raise suprapunere;
END IF;

zi_corespunzatoare := TO_CHAR(data_verificata, 'D')-1;
IF zi_corespunzatoare = 0 or zi_corespunzatoare = 6 or
NOT(data_verificata BETWEEN TO_DATE('01-Sep-2023', 'DD-Mon-YYYY') and TO_DATE('30-Jun-2024', 'DD-Mon-YYYY')) or
TO_CHAR(data_verificata, 'DD-Mon-YYYY') IN ('25-Dec-2023','01-Jan-2024', '05-May-2024') THEN 
raise data_necorespunzatoare;
END IF;

select s.orar INTO orar_prof
from se_studiaza s, clasa c, elev e  
where s.id_clasa = c.id_clasa and e.id_clasa = c.id_clasa
and s.id_profesor = cod_profesor and s.id_materie = cod_materie 
and e.id_elev = cod_elev;
IF orar_prof(zi_corespunzatoare).count = 0 THEN raise data_necorespunzatoare;
END IF;    

insert into PUNE_NOTA values(cod_profesor, cod_materie, cod_elev, data_verificata, round(nota));
commit;
DBMS_OUTPUT.PUT_LINE('Profesorul '||nume_profesor||' a pus nota '||round(nota)||' elevului '||nume_elev||' la '||denumire_materie||' .');

EXCEPTION 
WHEN NO_DATA_FOUND THEN 
    IF contor_exceptii = 1 THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: Nu exista elevul dat!');
    ELSIF contor_exceptii = 2 THEN
    DBMS_OUTPUT.PUT_LINE('EXCEPTIE: Nu exista materia data sau nu se preda materia data la clasa elevului!');
    END IF;
WHEN TOO_MANY_ROWS THEN
      IF contor_exceptii = 1 THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: Exista mai mult de un elev cu numele dat!');
      ELSIF contor_exceptii = 2 THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: La clasa elevului, materia data este predata de mai multi profesori!');
      END IF;
WHEN nota_gresita THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: Nota trebuie sa fie intre 0 si 10 (inclusiv)!');
WHEN suprapunere THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: Deja exista o nota la acea materie pusa elevului la data respectiva, nu se mai poate pune alta!');
WHEN data_necorespunzatoare THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: Data pica in vreo vacanta sau nu este in orarul profesorului clasei!');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('EXCEPTIE: Cel mai probabil, data nu este valida/existenta!');
END;
/

EXECUTE adauga_nota('Garnita', 'matematica', '13-SEP-2023', 2);

EXECUTE adauga_nota('Pandeliu', 'istorie', '13-SEP-2023', 2);


EXECUTE adauga_nota('Telu', 'matematica', '13-SEP-2023', 2);


EXECUTE adauga_nota('Pandeliu', 'informatica', '13-SEP-2023', 2);


BEGIN
adauga_nota('Pandeliu', 'matematica', '15-SEP-2023', 20);
END;
/

BEGIN
adauga_nota('Pandeliu', 'matematica', '13-SEP-2023', 7.5);
END;
/

BEGIN
adauga_nota('Pandeliu', 'matematica', '20-OCT-2023', 8);
END;
/

BEGIN
adauga_nota('Pandeliu', 'matematica', '50-OCT-2023', 8);
END;
/

BEGIN
adauga_nota('Pandeliu', 'matematica', '19-OCT-2023', 8.5);
END;
/






---EX10.
CREATE OR REPLACE TRIGGER actualizare_medie_generala 
   AFTER INSERT OR DELETE OR UPDATE on pune_nota 
     
DECLARE 
suma number(4);
numar number(2);
medie number(4,2);

BEGIN
FOR c1 in (select id_clasa a1 from clasa) LOOP
    select count(id_materie) INTO numar
    from(
    select distinct id_materie
    from se_studiaza
    where id_clasa=c1.a1);
    numar:=numar+1;--luam in calcul si nota la purtare
    FOR c2 in (select id_elev b1, medie_purtare b2 from elev where id_clasa=c1.a1) LOOP
        suma:=c2.b2;--luam in calcul si nota la purtare
        FOR c3 in (select distinct id_materie d1 from se_studiaza where id_clasa=c1.a1) LOOP
            select round(NVL(avg(nota),0)) INTO medie
            from pune_nota
            where id_materie=c3.d1 and id_elev=c2.b1;
            suma:=suma+medie;   
        END LOOP;
        update elev
        set medie_generala=suma/numar
        where id_elev=c2.b1;
    END LOOP;         
END LOOP;

DBMS_OUTPUT.PUT_LINE('S-a facut si actualizarea mediei generale!');
END; 
/ 


select nume, medie_generala
from elev
where nume = 'Pandeliu';

BEGIN
adauga_nota('Pandeliu', 'matematica', '05-OCT-2023', 10);
END;
/

BEGIN
adauga_nota('Pandeliu', 'matematica', '26-OCT-2023', 10);
END;
/

BEGIN
adauga_nota('Pandeliu', 'matematica', '06-SEP-2023', 10);
END;
/

update pune_nota
set nota = 0
where  id_elev = 116 and id_profesor = 102  and id_materie = 201 
and to_CHAR(data,'DD-MON-YYYY') IN ('19-OCT-2023', '05-OCT-2023', '26-OCT-2023', '06-SEP-2023');


delete pune_nota
where  id_elev = 116 and id_profesor = 102  and id_materie = 201 
and to_CHAR(data,'DD-MON-YYYY') IN ('19-OCT-2023', '05-OCT-2023', '26-OCT-2023', '06-SEP-2023');

commit;






---EX11.
CREATE OR REPLACE TRIGGER actualizare_numar_elevi 
   AFTER INSERT OR DELETE OR UPDATE on elev
   FOR EACH ROW

DECLARE
numar1 number(4);
numar2 number(4);

BEGIN  
IF INSERTING THEN 
    update clasa
    set numar_elevi =  numar_elevi + 1
    where id_clasa = :NEW.id_clasa;
    
    select c.numar_elevi, s.capacitate
    INTO numar1, numar2
    from clasa c, sala s
    where c.id_sala = s.id_sala 
    and c.id_clasa = :NEW.id_clasa;
    
    IF numar1 > numar2 THEN 
    RAISE_APPLICATION_ERROR(-20001, 'EROARE: s-a depasit capacitatea salii!');
    END IF;
    
ELSIF DELETING THEN 
    update clasa
    set numar_elevi =  numar_elevi - 1
    where id_clasa = :OLD.id_clasa;
    
ELSE 
    IF :NEW.id_clasa <> :OLD.id_clasa THEN
        update clasa
        set numar_elevi =  numar_elevi + 1
        where id_clasa = :NEW.id_clasa;
        
        update clasa
        set numar_elevi =  numar_elevi - 1
        where id_clasa = :OLD.id_clasa;
        
        select c.numar_elevi, s.capacitate
        INTO numar1, numar2
        from clasa c, sala s
        where c.id_sala = s.id_sala 
        and c.id_clasa = :NEW.id_clasa;
        
        IF numar1 > numar2 THEN 
        RAISE_APPLICATION_ERROR(-20001, 'EROARE: s-a depasit capacitatea salii!');
        END IF;
    END IF;
END IF;
    
DBMS_OUTPUT.PUT_LINE('S-a facut si actualizare numarului de elevi!');
END;
/




select c.id_clasa clasa, count(e.id_elev) nr_elevi,
max(s.id_sala) sala, max(s.capacitate) capacitate_sala
from elev e, clasa c, sala s
where e.id_clasa = c.id_clasa and
c.id_sala = s.id_sala and c.id_clasa = 402
group by c.id_clasa;


BEGIN
FOR i IN 1..13 LOOP
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte) 
values (200+i, 401, 'N'||i, 'P'||i, '0000000000');
END LOOP;
END;
/

INSERT INTO elev (id_elev, id_clasa, nume, prenume, contact_parinte)
VALUES (214, 401 ,'N14', 'P14', '000000000');
INSERT INTO elev (id_elev, id_clasa, nume, prenume, contact_parinte)
VALUES (215, 401 ,'N15', 'P15', '000000000');

INSERT INTO elev (id_elev, id_clasa, nume, prenume, contact_parinte)
VALUES (216, 401 ,'N16', 'P16', '000000000');

update elev
set id_clasa = 402
where id_clasa = 401 and id_elev IN (201, 202, 203);

update elev
set id_clasa = 402
where id_clasa = 401 and id_elev >= 204;

BEGIN
FOR i IN 1..15 LOOP
insert into ELEV (id_elev, id_clasa, nume, prenume, contact_parinte) 
values (220+i, 401, 'N'||i, 'P'||i, '0000000000');
END LOOP;
END;
/

update elev
set id_clasa = 402
where id_clasa = 401 and id_elev >= 221;

delete elev
where id_clasa = 401 and id_elev >=119;

delete elev
where id_clasa = 402 and id_elev >=121;






---EX12.
CREATE TABLE audit_TMS 
(nume_bd               VARCHAR2(50), 
 utilizator            VARCHAR2(30), 
 eveniment             VARCHAR2(20),
 nume_obiect           VARCHAR2(30),
 tip                   VARCHAR2(30),  
 data                  TIMESTAMP(3));
 
 
CREATE OR REPLACE TRIGGER audit_schema 
  AFTER CREATE OR DROP OR ALTER ON SCHEMA 
BEGIN 
  INSERT INTO audit_TMS 
  VALUES (SYS.DATABASE_NAME, SYS.LOGIN_USER,  
SYS.SYSEVENT,  SYS.DICTIONARY_OBJ_NAME,
SYS.DICTIONARY_OBJ_TYPE, SYSTIMESTAMP(3));

DBMS_OUTPUT.PUT_LINE('Comanda LDD a fost inregistrata!');
END; 
/ 

CREATE TABLE tabel_test (coloana_1 number(2)); 
ALTER TABLE tabel_test ADD (coloana_2 number(2)); 
INSERT INTO tabel_test VALUES (1,2); 
DROP TABLE tabel_test;


SELECT * FROM audit_TMS; 






---EX13.
---CREAREA PACHETULUI:
CREATE OR REPLACE PACKAGE 
 SITUATIE_ELEV IS
 
TYPE inregistrare_elev IS RECORD
(nume_e elev.nume%type, prenume_e elev.prenume%type,
medieg_e elev.medie_generala%type, mediep_e elev.medie_purtare%type,
nr_absente_e elev.numar_absente%type, 
diriginte_e varchar2(50));
elevul inregistrare_elev;

TYPE profesorii IS TABLE OF varchar2(50);
TYPE inregistrare_materie IS RECORD
(cod_materie materie.id_materie%type, denumire_materie materie.denumire%type,
profii profesorii);
TYPE materii_profesori IS TABLE OF inregistrare_materie;
materii_prof materii_profesori;

FUNCTION venit_burse (
cod_elev elev.id_elev%type)
RETURN number;

FUNCTION gaseste_medie( 
cod_elev elev.id_elev%type,
cod_materie materie.id_materie%type)
RETURN number;

CURSOR c_materii_corig
(cod_elev elev.id_elev%type)
RETURN materie%ROWTYPE; 

PROCEDURE gaseste_materii_prof(
cod_elev IN elev.id_elev%type,
t OUT materii_profesori);

PROCEDURE prezinta_situatie_scolara(
cod_elev elev.id_elev%type);

END  SITUATIE_ELEV;
/



CREATE OR REPLACE PACKAGE BODY
 SITUATIE_ELEV IS
 
CURSOR c_materii_corig
(cod_elev elev.id_elev%type) 
RETURN materie%ROWTYPE
IS
select distinct m.id_materie, NVL(m.id_sef_catedra,-1),  NVL(m.denumire,'NE')
from elev e, clasa c, se_studiaza s, materie m
where e.id_clasa = c.id_clasa and 
c.id_clasa = s.id_clasa and 
s.id_materie = m.id_materie and e.id_elev = cod_elev
and gaseste_medie(cod_elev, s.id_materie) < 5;

FUNCTION exista_elev( 
cod_elev elev.id_elev%type, 
cod_materie materie.id_materie%type DEFAULT -1) 
RETURN NUMBER
IS 
ok number(2) := 0;

BEGIN
select count(*) INTO ok
from elev
where id_elev = cod_elev;
IF ok = 0 THEN return 0;
END IF;

IF cod_materie <> -1 THEN
select count(*) INTO ok
from elev e, clasa c, se_studiaza s
where e.id_clasa = c.id_clasa and
c.id_clasa = s.id_clasa and s.id_materie = cod_materie;
END IF;

return ok;
END exista_elev;


FUNCTION venit_burse (
cod_elev elev.id_elev%type)
RETURN number IS
suma_b number := -1;

BEGIN
IF exista_elev(cod_elev) <> 0 THEN
select NVL(sum(suma),0)
INTO suma_b
from primeste p, bursa b
where p.id_bursa = b.id_bursa
and p.id_elev = cod_elev;

ELSE
DBMS_OUTPUT.PUT_LINE('Nu exista elevul dat!');
END IF;
return suma_b;

END venit_burse;


FUNCTION gaseste_medie( 
cod_elev elev.id_elev%type,
cod_materie materie.id_materie%type)
RETURN number IS
medie number := -1;

BEGIN
IF exista_elev(cod_elev, cod_materie) <> 0 THEN
select round(NVL(avg(p.nota),0))
INTO medie
from pune_nota p
where p.id_elev = cod_elev and
p.id_materie =  cod_materie;

ELSE
DBMS_OUTPUT.PUT_LINE('Nu exista elevul dat care sa studieze materia data!');
END IF;

return medie;

END gaseste_medie;


PROCEDURE gaseste_materii_prof(
cod_elev IN elev.id_elev%type,
t OUT materii_profesori) IS

BEGIN
t := materii_profesori();
IF exista_elev(cod_elev) <> 0 THEN 
FOR c1 IN (select distinct m.id_materie a1, NVL(m.denumire,'NE') a2
          from elev e, clasa c, se_studiaza s, materie m
          where e.id_clasa = c.id_clasa and c.id_clasa = s.id_clasa
          and s.id_materie = m.id_materie and e.id_elev = cod_elev) LOOP
    t.extend;
    t(t.last).cod_materie := c1.a1;
    t(t.last).denumire_materie := c1.a2;
    t(t.last).profii := profesorii();
    FOR c2 IN (select NVL(p.nume,'N')||' '||NVL(p.prenume,'E') a1
          from elev e, clasa c, se_studiaza s, profesor p
          where e.id_clasa = c.id_clasa and c.id_clasa = s.id_clasa
          and s.id_materie = c1.a1 and s.id_profesor = p.id_profesor
          and e.id_elev = cod_elev) LOOP
        t(t.last).profii.extend;
        t(t.last).profii(t(t.last).profii.last) := c2.a1;
    END LOOP;
END LOOP;
ELSE DBMS_OUTPUT.PUT_LINE('Nu exista elevul dat!');
END IF;

END gaseste_materii_prof;


PROCEDURE prezinta_situatie_scolara(
cod_elev elev.id_elev%type)
IS
nr  number := 0;
v1 number(4);
v2 number(4);
v3 varchar2(50);

BEGIN
IF exista_elev(cod_elev) <> 0 THEN
select NVL(e.nume,'NE'),NVL(e.prenume,'NE'),
e.medie_generala, e.medie_purtare, e.numar_absente,
NVL(d.nume,'N')||' '||NVL(d.prenume,'N') INTO elevul
from elev e, clasa c, profesor d
where e.id_clasa = c.id_clasa and c.id_diriginte = d.id_profesor
and e.id_elev = cod_elev;

FOR x IN c_materii_corig(cod_elev) LOOP
nr := nr+1;
END LOOP;

IF nr < 3 THEN 
DBMS_OUTPUT.PUT_LINE('Elevul '||elevul.nume_e||' '||elevul.prenume_e||' NU este in pericol sa ramana repetent.');
DBMS_OUTPUT.PUT_LINE('Dirigintele sau este '||elevul.diriginte_e||'.');
DBMS_OUTPUT.PUT_LINE('Elevul are urmatoarea situatie scolara:');
DBMS_OUTPUT.PUT_LINE('Medie generala: '||elevul.medieg_e||'---Medie la purtare: '||elevul.mediep_e||'---Numar absente: '||elevul.nr_absente_e);
DBMS_OUTPUT.PUT_LINE('Incaseaza din burse suma totala de '||venit_burse(cod_elev)||' lei.');
DBMS_OUTPUT.PUT_LINE('   Materii: ');
gaseste_materii_prof(cod_elev, materii_prof);
IF materii_prof.count() <> 0 THEN
    FOR i IN 1..materii_prof.last LOOP
        DBMS_OUTPUT.PUT_LINE('La materia '||materii_prof(i).denumire_materie||' predata de: ');
        IF materii_prof(i).profii.count <> 0 THEN 
            FOR j IN 1..materii_prof(i).profii.last LOOP
                DBMS_OUTPUT.PUT_LINE(materii_prof(i).profii(j));
            END LOOP;
        END IF;
        DBMS_OUTPUT.PUT_LINE(' are media '||gaseste_medie(cod_elev, materii_prof(i).cod_materie)||'.');
    END LOOP;
END IF;

ELSE 
DBMS_OUTPUT.PUT_LINE('Elevul '||elevul.nume_e||' '||elevul.prenume_e||' ESTE in pericol sa ramana repetent!');
DBMS_OUTPUT.PUT_LINE('Dirigintele sau este '||elevul.diriginte_e||'.');
DBMS_OUTPUT.PUT_LINE('Elevul are urmatoarea situatie scolara:');
DBMS_OUTPUT.PUT_LINE('Medie generala: '||elevul.medieg_e||'---Medie la purtare: '||elevul.mediep_e||'---Numar absente: '||elevul.nr_absente_e);
DBMS_OUTPUT.PUT_LINE('Incaseaza din burse suma totala de '||venit_burse(cod_elev)||'lei.');
DBMS_OUTPUT.PUT_LINE('   Materii: ');
gaseste_materii_prof(cod_elev, materii_prof);
IF materii_prof.count() <> 0 THEN
    FOR i IN 1..materii_prof.last LOOP
        DBMS_OUTPUT.PUT_LINE('La materia '||materii_prof(i).denumire_materie||' predata de: ');
        IF materii_prof(i).profii.count <> 0 THEN 
            FOR j IN 1..materii_prof(i).profii.last LOOP
                DBMS_OUTPUT.PUT_LINE(materii_prof(i).profii(j));
            END LOOP;
        END IF;
        DBMS_OUTPUT.PUT_LINE(' are media '||gaseste_medie(cod_elev, materii_prof(i).cod_materie)||' .');
    END LOOP;
END IF;
DBMS_OUTPUT.PUT_LINE('Elevul este in situatie de corigenta la urmatoarele materii: ');

OPEN c_materii_corig(cod_elev); 
LOOP
FETCH c_materii_corig INTO v1, v2, v3;
EXIT WHEN c_materii_corig%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v3);
END LOOP;
CLOSE c_materii_corig;


END IF;

ELSE DBMS_OUTPUT.PUT_LINE('Nu exista elevul dat!');
END IF;

DBMS_OUTPUT.PUT_LINE('---------------------');
DBMS_OUTPUT.PUT_LINE('');

END prezinta_situatie_scolara;

END  SITUATIE_ELEV;
/



--drop PACKAGE SITUATIE_ELEV;
---TESTAREA PACHETULUI:
select NVL(sum(suma),0) 
from bursa b, primeste p
where b.id_bursa = p.id_bursa
and id_elev = 132;


select p.id_materie, round(NVL(avg(p.nota),0))
from pune_nota p, elev e, materie m
where p.id_elev = 132
group by p.id_materie;

DECLARE
v1 number(4);
v2 number(4);
v3 varchar2(50);

BEGIN
DBMS_OUTPUT.PUT_LINE(SITUATIE_ELEV.venit_burse(132));
DBMS_OUTPUT.PUT_LINE(SITUATIE_ELEV.gaseste_medie(132,207));
SITUATIE_ELEV.gaseste_materii_prof (132, SITUATIE_ELEV.materii_prof);

IF SITUATIE_ELEV.materii_prof.count() <> 0 THEN
    FOR i IN 1..SITUATIE_ELEV.materii_prof.last LOOP
        DBMS_OUTPUT.PUT_LINE('La materia '||SITUATIE_ELEV.materii_prof(i).denumire_materie||' predata de: ');
        IF SITUATIE_ELEV.materii_prof(i).profii.count <> 0 THEN 
            FOR j IN 1..SITUATIE_ELEV.materii_prof(i).profii.last LOOP
                DBMS_OUTPUT.PUT_LINE(SITUATIE_ELEV.materii_prof(i).profii(j));
            END LOOP;
        END IF;
        DBMS_OUTPUT.PUT_LINE(' are media '||SITUATIE_ELEV.gaseste_medie(132, SITUATIE_ELEV.materii_prof(i).cod_materie)||' .');
    END LOOP;
END IF;
DBMS_OUTPUT.PUT_LINE('Elevul este in situatie de corigenta la urmatoarele materii: ');

OPEN SITUATIE_ELEV.c_materii_corig(132); 
LOOP
FETCH SITUATIE_ELEV.c_materii_corig INTO v1, v2, v3;
EXIT WHEN SITUATIE_ELEV.c_materii_corig%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v3);
END LOOP;
CLOSE SITUATIE_ELEV.c_materii_corig;

DBMS_OUTPUT.PUT_LINE('');

SITUATIE_ELEV.prezinta_situatie_scolara(132);
END;
/

EXECUTE SITUATIE_ELEV.prezinta_situatie_scolara(160);



---REZOLVAREA PROBLEMEI FORMULATE:
BEGIN
FOR c IN (select id_elev from elev) LOOP
SITUATIE_ELEV.prezinta_situatie_scolara(c.id_elev);
END LOOP;
END;
/















SELECT object_name, object_type, status
FROM all_objects
WHERE object_name = 'UTL_MAIL';
--EXECUTE SITUATIE_ELEV.exista_elev(132);




drop table audit_user;
drop trigger audit_schema;

select *
from elev
where id_clasa = 402;
commit;






delete pune_nota
where  id_elev = 116 and id_profesor = 102  and id_materie = 201 
and data = to_date('06-SEP-2023');


update pune_nota
set data = to_date('20-SEP-2023')
where  id_elev = 116 and id_profesor = 102  and id_materie = 201 
and data = to_date('06-SEP-2023');

insert into pune_nota values(20, 201, 116, '20-SEP-2023', 80);

select sum(nota)
from pune_nota
where id_materie=500;


SELECT SYSTIMESTAMP FROM DUAL;

rollback;
select *
from elev
where id_elev=116;

drop TRIGGER modifica_medie_generala;
select s.id_profesor 
from se_studiaza s, materie m
where s.id_materie = m.id_materie and s.id_clasa = 401
and m.denumire = 'informatica';

select *
from pune_nota 
where id_elev = 116 and id_profesor = 102  and id_materie = 201;
---Pandeliu---Prof.mate---Matematica

select *
from se_studiaza
where id_profesor = 102 and id_clasa=401;

select sysdate
from dual;

select TO_CHAR(SYSDATE,'HH24:MI')
from dual;

select TO_CHAR((TO_DATE('02-Jan-2025', 'DD-MON-YYYY')), 'D')
from dual;

SELECT * FROM NLS_SESSION_PARAMETERS WHERE PARAMETER = 'NLS_TERRITORY';
----SISTEMUL/SYSDATE MEU E CU 2 ZILE IN URMA, DAR POATE RECUNOASTE DATE NORMAL/BINE!

SELECT MOD(TO_CHAR(TO_DATE(SYSDATE, 'DD-MON-YYYY'), 'D') + 5, 7) + 1 AS ziua_saptamanii
FROM dual;

select *
from primeste;

select *
from se_studiaza where id_clasa=402;

select *
from clasa where id_clasa=406;

select *
from profesor where id_profesor=109;

select *
from preda;
            
select *
from elev;
            
        
select TO_CHAR(SYSDATE,'HH24')
from dual;

commit;

drop TRIGGER modifica_medie_generala;







