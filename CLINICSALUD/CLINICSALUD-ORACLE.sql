ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

create table clinica (
    codigo char(6),
    nombre varchar2(35),
    direccion varchar2(50),
    localidad varchar2(35),
    provincia varchar2(20),
    primary key (codigo)
);

create table paciente (
	NSS char(12),
    DNI char(9) unique,
    nombre varchar2(30),
    apellidos varchar2(50),
    sexo char(1) check (sexo in ('M','F')),
    fechaNac date,
    historial varchar2(450),
    primary key (NSS)
);

create table medico (
	n_colegiado char(9),
    nombre varchar2(30),
    apellidos varchar2(50),
    especialidad varchar2(20),
    fecha_alta Date,
    clinica char(6),	
    primary key (n_colegiado),
    constraint fk_med_idc foreign key (clinica) references clinica(codigo) 
    on delete cascade
);

create table consultas (
	medico char(9),
    paciente char(12),
    fecha_consulta date,
    importe number(5,2),  	
    primary key(medico,paciente,fecha_consulta),
    constraint fk_con_idm foreign key (medico) references medico(n_colegiado)
    on delete cascade,
    constraint fk_con_idp foreign key (paciente) references paciente(nss)
    on delete cascade
);
	
INSERT INTO clinica VALUES('000001','Clínica del Carmen','Avda Italia 22','Huelva','Huelva');
INSERT INTO clinica VALUES('000002','Clínica Plaza de las Monjas','Plaza de las Monjas 2','Huelva','Huelva');
INSERT INTO clinica VALUES('000003','Grupo Pediátrico Uncibay','Calle Molina Lario 7, 2º','Málaga','Málaga');
INSERT INTO clinica VALUES('000004','Policlínica San Juan','Avda del Mediterráneo 20','Alhaurín de la Torre','Málaga');
INSERT INTO clinica VALUES('000005','Clínica HLA Santa Isabel','Calle Luis Montoto 100','Sevilla','Sevilla');
INSERT INTO clinica VALUES('000006','Centro médico Semud','Calle Ponce de León 1','Utrera','Sevilla');
INSERT INTO clinica VALUES('000007','Policlínica Úbeda','Calle Explanada 23 Bajo','Úbeda','Jaén');
INSERT INTO clinica VALUES('000008','Policlínica Santa María','Calle Santa María Soledad 13','Cádiz','Cádiz');
INSERT INTO clinica VALUES('000009','Policlínica Los Millares','Carrera del Duende 16','Almería','Almería');
INSERT INTO clinica VALUES('000010','Clínica El Brillante','Avda Brillante 64','Córdoba','Córdoba');
INSERT INTO clinica VALUES('000011','Vithas Rincón de la Victoria','Avda de la Torre 15','Rincón de la Victoria','Málaga');
INSERT INTO clinica VALUES('000012','Centro Médico Vithas Limonar','Calle La Era 6','Málaga','Málaga');


INSERT INTO paciente VALUES('048234231013','12322341E','Juan','González Fernández','M','24/03/1986',NULL);
INSERT INTO paciente VALUES('285543156276','67863423Z','Ramón','Rodríguez Núñez','M','02/09/1999',NULL);
INSERT INTO paciente VALUES('296755433362','02384234P','María','Martín Sánchez','F','24/11/1970',NULL);
INSERT INTO paciente VALUES('184376546134','98712234Y','Laura','Gutiérrez Albiol','F','04/06/2001',NULL);
INSERT INTO paciente VALUES('117775436758','64528976S','Inma','Domínguez Cerrato','F','03/03/1993',NULL);
INSERT INTO paciente VALUES('238712259124','34500232W','Jose','Torres Lopez','M','24/03/1980',NULL);
INSERT INTO paciente VALUES('147655600078','56434010Z','Luis','Miguel Casado','M','01/08/1998',NULL);
INSERT INTO paciente VALUES('215438967278','70725455H','Francisco','Heiver Jhons','M','25/05/2021',NULL);
INSERT INTO paciente VALUES('219127751986','34678891C','Salvador','Rubiales Perez','M','02/08/2015',NULL);
INSERT INTO paciente VALUES('296001902000','80092300K','Ascensión','Rodríguez Ruiz','F','24/06/2020',NULL);

INSERT INTO medico VALUES('414117320','Fernando','García Pérez-Sevillano','Endocrinología','15/03/2000','000001');
INSERT INTO medico VALUES('212305458','Belén','Hinojosa Jara','Alergología','05/05/1998','000001');
INSERT INTO medico VALUES('414112680','Rafael Fernando','Romero Garrido','Cardiología','01/08/2001','000002');
INSERT INTO medico VALUES('414115731','Pablo','Herrera Martín','Aparato Digestivo','07/07/2015','000002');
INSERT INTO medico VALUES('292904902','Manuel Ramón','Baca Cots','Pediatría','03/09/2018','000003');
INSERT INTO medico VALUES('292908760','Manuel','Rueda Ortiz','Otorrinolaringolo','17/04/1999','000004');
INSERT INTO medico VALUES('414112290','Matilde','Zamorano del Río','Ginecología','03/04/2002','000005');
INSERT INTO medico VALUES('414106178','Rafael Carlos','López Jiménez','Oftalmología','07/11/1999','000006');
INSERT INTO medico VALUES('414105898','Miguel','Fashho Bayouk','Dermatología','29/10/2003','000006');
INSERT INTO medico VALUES('232303028','Pedro','Fuentes Peñas','Medicina General','26/02/2010','000007');
INSERT INTO medico VALUES('111105075','María del Rosario de Fátima','Ramírez Chamorro','Urología','13/07/2011','000008');
INSERT INTO medico VALUES('040403859','María Luisa','Morales Martínez','Nutrición','31/12/1995','000009');
INSERT INTO medico VALUES('141404656','Miguel Ángel','Martín Pérez','Neumología','20/06/1999','000010');
INSERT INTO medico VALUES('211108485','Antonio Enrique','Gómez Menchero','Cardiología','09/10/2005','000001');
INSERT INTO medico VALUES('414117017','Álvaro','Arce León','Cardiología','29/09/2008','000001');
INSERT INTO medico VALUES('292911024','Ester','Romero Escribano','Traumatología','15/09/2004','000004');
INSERT INTO medico VALUES('141403602','Antonio','Pineda Sicilia','Traumatología','18/07/2001','000010');
INSERT INTO medico VALUES('412104405','Francisco José','Lara Pulido','Traumatología','19/03/2017','000001');
INSERT INTO medico VALUES('212102841','Luisa','Mira Toscano','Pediatría','19/03/2000','000001');
INSERT INTO medico VALUES('294118197','Rubén Jesús','Gil Cardona','Pediatría','07/05/2001','000011');
INSERT INTO medico VALUES('292910421','Pablo','Cabezudo García','Neurología','07/05/2000','000012');

INSERT INTO consultas VALUES('414112680','048234231013','15/03/2020',45);
INSERT INTO consultas VALUES('414117017','238712259124','14/02/2023',110);
INSERT INTO consultas VALUES('211108485','215438967278','03/05/2020',95);
INSERT INTO consultas VALUES('292904902','296001902000','11/02/2023',80);
INSERT INTO consultas VALUES('292904902','296001902000','01/12/2022',70);
INSERT INTO consultas VALUES('292904902','296001902000','08/03/2023',80);
INSERT INTO consultas VALUES('212102841','219127751986','17/05/2020',35);
INSERT INTO consultas VALUES('294118197','215438967278','01/08/2021',35);
INSERT INTO consultas VALUES('412104405','048234231013','13/06/2022',40);
INSERT INTO consultas VALUES('141403602','147655600078','11/11/2021',45);
INSERT INTO consultas VALUES('292911024','117775436758','02/06/2022',55);
INSERT INTO consultas VALUES('212305458','048234231013','15/12/2021',65);
INSERT INTO consultas VALUES('111105075','285543156276','19/04/2023',60);
INSERT INTO consultas VALUES('292908760','296001902000','19/04/2021',100);
INSERT INTO consultas VALUES('292908760','296001902000','30/06/2021',100);
INSERT INTO consultas VALUES('292908760','296001902000','18/05/2022',120);
INSERT INTO consultas VALUES('292910421','296001902000','23/05/2020',80);
INSERT INTO consultas VALUES('292910421','296001902000','10/04/2021',85);
INSERT INTO consultas VALUES('292910421','296001902000','01/04/2022',90);
INSERT INTO consultas VALUES('292910421','296001902000','11/06/2022',90);
INSERT INTO consultas VALUES('292910421','296001902000','30/03/2023',95);
INSERT INTO consultas VALUES('414117320','296755433362','15/01/1998',95);
INSERT INTO consultas VALUES('414117320','296755433362','15/06/1998',95);
INSERT INTO consultas VALUES('414117320','296755433362','01/02/1999',100);
INSERT INTO consultas VALUES('414117320','296755433362','01/07/1999',100);
INSERT INTO consultas VALUES('414117320','296755433362','15/01/2000',120);
INSERT INTO consultas VALUES('414117320','296755433362','30/05/2000',120);
INSERT INTO consultas VALUES('414117320','296755433362','15/09/2000',120);
INSERT INTO consultas VALUES('414117320','296755433362','10/03/2001',150);
INSERT INTO consultas VALUES('414117320','296755433362','20/09/2001',150);
INSERT INTO consultas VALUES('414117320','296755433362','14/02/2002',170);
INSERT INTO consultas VALUES('414117320','296755433362','22/07/2002',170);
INSERT INTO consultas VALUES('414117320','296755433362','11/05/2005',200);
INSERT INTO consultas VALUES('414117320','296755433362','15/06/2005',200);
INSERT INTO consultas VALUES('414117320','296755433362','01/07/2005',200);
INSERT INTO consultas VALUES('414117320','296755433362','15/07/2006',220);
INSERT INTO consultas VALUES('414117320','296755433362','30/06/2007',225);
INSERT INTO consultas VALUES('414117320','296755433362','01/05/2008',230);
INSERT INTO consultas VALUES('414117320','296755433362','22/05/2009',235);
INSERT INTO consultas VALUES('414117320','184376546134','10/01/2023',250);























































