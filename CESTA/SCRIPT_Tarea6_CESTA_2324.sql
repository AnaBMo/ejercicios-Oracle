/* SCRIPT PARA LA CREACIÓN DE TABLAS EN ORACLE EXPRESS EDITION */

CREATE TABLE SOCIOS (
DNI CHAR(9) PRIMARY KEY,
nombre VARCHAR2(20),
apellidos VARCHAR2(50),
direccion VARCHAR2 (50),
telefono VARCHAR2(9),
fecha_nacimiento DATE,
ingresos DECIMAL(6,2),
numfam NUMBER(2),
ayuda CHAR(1) CHECK (ayuda IN ('1','2','3')),
renta DECIMAL(10,2)
);

CREATE TABLE VOLUNTARIOS (
DNI CHAR(9) PRIMARY KEY,
nombre VARCHAR2(20),
apellidos VARCHAR2(50),
direccion VARCHAR2(50),
telefono VARCHAR2(9),
fecha_nacimiento DATE,
puntostotal NUMBER(5)
);

CREATE TABLE CESTA (
ID CHAR(3) PRIMARY KEY,
valor_total DECIMAL(4,2),
tipo VARCHAR(10) CHECK (tipo IN ('basica','estandar','completa')),
puntos NUMBER(5),
fechaprepara DATE,
fecharecoge DATE,
DNIS CHAR(9),
DNIV CHAR(9),
FOREIGN KEY (DNIS) REFERENCES SOCIOS (DNI) ON DELETE CASCADE,
FOREIGN KEY (DNIV) REFERENCES VOLUNTARIOS(DNI) ON DELETE CASCADE
);

CREATE TABLE PRODUCTOS (
referencia VARCHAR2(5) PRIMARY KEY,
nombre VARCHAR2(20),
valor DECIMAL(4,2),
stock NUMBER(4),
medida VARCHAR(3) CHECK (medida IN('L','Kg','Ud'))
);

CREATE TABLE DETALLE_CESTA(
numero_linea CHAR(2),
ID_cesta CHAR(3),
cantidad NUMBER(3),
ref_p VARCHAR2(5),
PRIMARY KEY (numero_linea, ID_cesta),
FOREIGN KEY (ID_cesta) REFERENCES CESTA (ID) ON DELETE CASCADE,
FOREIGN KEY (ref_p) REFERENCES PRODUCTOS(referencia) ON DELETE CASCADE
);

/* DATOS DE SOCIOS */
Insert into SOCIOS values('31642798G', 'Paco', 'Cano Gutierrez','Calle Sabinar 8','617478552','31/01/1987',600.5,6,NULL,25836);
Insert into SOCIOS values('74819253B', 'Dario', 'Ferrer Martinez','Calle Alemania 11','678451947','01/05/2000',350.6,4,NULL,18920);
Insert into SOCIOS values('55487914P', 'Lara', 'Martin Rubio','Calle Mandarina 7','642772771','12/09/1995',400.8,5,NULL,32589);
Insert into SOCIOS values('27445115T', 'Alex', 'Perez Hernandez','Calle Segovia 8','643600501','04/12/1999',604.25,6,NULL,25846);
Insert into SOCIOS values('88544692S', 'Martirio', 'Batalla Salom','Calle Bilbao 2','666458123','31/01/1957',100,3,NULL,25348);
Insert into SOCIOS values('22951645V', 'Custodia', 'Guardiola Conesa','Avenida Juan Carlos 7','674184601','06/07/1983',200,2,NULL,25820);
Insert into SOCIOS values('27531479A', 'Isidro', 'Figueras Perez','Calle Limon 73','700284012','26/11/1977',100,3,NULL,18000);
Insert into SOCIOS values('19311618X', 'Dimas', 'Cerdan Salinas','Calle Mares 14','792666320','29/03/1989',300,3,NULL,60025);
Insert into SOCIOS values('98452175H', 'Eduardo', 'Lopez Lopez', 'Avenida Gato Siames 26', '620314785','23/05/1996',1500,3,NULL,25000);
Insert into SOCIOS values('57934526R', 'Reyes', 'Mayoral Valero', 'Calle Miguel Segura 12', '724159043','27/11/1988',2000,2,NULL,12546);
Insert into SOCIOS values('26354517K', 'Antonia', 'Vicente Prat', 'Calle Maracas 22', '658001200','28/11/1977',1300,2,NULL,26358);
Insert into SOCIOS values('33123987C', 'David', 'Pardo Marquez', 'Calle San Miguel 31','654004221','04/01/1993',2000,4,NULL,15000);
Insert into SOCIOS values('66225571H', 'Ulises', 'Garcia Sanz', 'Calle Fernando Alonso 33', '647412349','18/10/1986',1200,2,NULL,13258);

/* DATOS DE VOLUNTARIOS */
Insert into VOLUNTARIOS values('22447896V', 'Patricia', 'Fernandez Ruiz','Calle Japon 1','624752004','14/07/1997',1500);
Insert into VOLUNTARIOS values('77421335E', 'David', 'Gonzalez Azcona','Calle Madrid 17','634008222','25/10/1998',400);
Insert into VOLUNTARIOS values('10942404Y','Cosme','Nogueira Rebollo','Calle del Motor 33','605203665','16/06/1973',650);
Insert into VOLUNTARIOS values('40139191X','Francisca','Becerra Zapata','Calle de la Rosa 12','667884221', '13/12/1992',200);
Insert into VOLUNTARIOS values('56497230K','Jose Luis','Arce Navarro','Calle Berlin 12','742851002','28/02/1986',500);
Insert into VOLUNTARIOS values('79512435F','Juan','Moreno Fernandez','Calle Salamanca 77','621325079','30/10/1974',100);
Insert into VOLUNTARIOS values('52413279I','Amaia','Valverde Lopez','Avenida Marco Polo 32','657035042','13/09/1990',500);
Insert into VOLUNTARIOS values('91471235B','Jesus','Cruz Cobo','Avenida Calvo Sotelo 27','649651036','27/04/1995',800);
Insert into VOLUNTARIOS values('55976143M','Maria Isabel','Beltran Lopez','Calle Perro 56','691023456','05/12/1979',200);
Insert into VOLUNTARIOS values('27555115T', 'Alejandra', 'Collado  Hernandez','Calle Solaz 9','643600701','04/11/1999',1001);

/* DATOS DE PRODUCTOS */
Insert into PRODUCTOS values('A0001','Pan',0.50,500,'Ud');
Insert into PRODUCTOS values('A0002','Leche',0.85,200,'L');
Insert into PRODUCTOS values('A0003','Patatas',1.70,100,'Kg');
Insert into PRODUCTOS values('A0004','Azucar',1.05,100,'Kg');
Insert into PRODUCTOS values('A0005','Harina',1.00,300,'Kg');
Insert into PRODUCTOS values('A0006','Latas de conserva',2.20,100,'Ud');
Insert into PRODUCTOS values('A0007','Aceite Oliva',4.50,70,'L');
Insert into PRODUCTOS values('A0008','Aceite Girasol',3.20,80,'L');
Insert into PRODUCTOS values('A0009','Pasta',1.15,100,'Kg');
Insert into PRODUCTOS values('A0010','Arroz',1.30,200,'Kg');

/* DATOS DE CESTA */
Insert into CESTA values('001',16.95,'basica',13,'01/04/2023','02/04/2023','55487914P','52413279I' );
Insert into CESTA values('002',45.20,'completa',30,'01/01/2023','10/01/2023','88544692S', '56497230K');
Insert into CESTA values('003',36.00, 'estandar',20,'15/02/2023','18/02/2023','26354517K','22447896V');
Insert into CESTA values('004',21.10, 'estandar',10,'01/03/2023','09/03/2023','26354517K','55976143M');
Insert into CESTA values('005',16.80, 'basica', 12,'02/11/2023','22/11/2023','66225571H','79512435F');
Insert into CESTA values('006',26.60, 'estandar', 3, '05/04/2023','25/04/2023','98452175H','91471235B');
Insert into CESTA values('007',50.10, 'completa', 10,'10/02/2023','12/02/2023','19311618X','91471235B');
Insert into CESTA values('008',21.80,'basica', 8,'01/05/2023','11/05/2023','19311618X','91471235B');
Insert into CESTA values('009',45.95,'completa',8,'01/05/2023','08/05/2023','19311618X','79512435F');
Insert into CESTA values('010',19.20,'estandar' ,7,'01/04/2023','07/04/2023','98452175H','56497230K');

/* DATOS DE DETALLE DE CESTA */
Insert into DETALLE_CESTA values(001, '001', 4,'A0001'); 
Insert into DETALLE_CESTA values(003, '001', 2,'A0003'); 
Insert into DETALLE_CESTA values(004, '001', 4,'A0002'); 
Insert into DETALLE_CESTA values(002, '001', 5,'A0005');
Insert into DETALLE_CESTA values(005, '001', 3,'A0004'); 

Insert into DETALLE_CESTA values(001, '002', 4,'A0004');
Insert into DETALLE_CESTA values(003, '002', 2,'A0007');
Insert into DETALLE_CESTA values(004, '002', 10,'A0006');
Insert into DETALLE_CESTA values(002, '002', 5,'A0003');
Insert into DETALLE_CESTA values(005, '002', 3,'A0001');

Insert into DETALLE_CESTA values(001, '003', 4,'A0008');
Insert into DETALLE_CESTA values(003, '003', 2,'A0006');
Insert into DETALLE_CESTA values(004, '003', 9,'A0004');
Insert into DETALLE_CESTA values(002, '003', 5,'A0002');
Insert into DETALLE_CESTA values(005, '003', 3,'A0003');

Insert into DETALLE_CESTA values(001, '004', 4,'A0003');
Insert into DETALLE_CESTA values(003, '004', 2,'A0004');
Insert into DETALLE_CESTA values(004, '004', 4,'A0009');
Insert into DETALLE_CESTA values(002, '004', 5,'A0001');
Insert into DETALLE_CESTA values(005, '004', 3,'A0003');

Insert into DETALLE_CESTA values(001, '005', 4,'A0002');
Insert into DETALLE_CESTA values(003, '005', 2,'A0003');
Insert into DETALLE_CESTA values(004, '005', 1,'A0007');
Insert into DETALLE_CESTA values(002, '005', 5,'A0001');
Insert into DETALLE_CESTA values(005, '005', 3,'A0005');

Insert into DETALLE_CESTA values(001, '006', 4,'A0004');
Insert into DETALLE_CESTA values(003, '006', 2,'A0005');
Insert into DETALLE_CESTA values(004, '006', 4,'A0008');
Insert into DETALLE_CESTA values(002, '006', 5,'A0001');
Insert into DETALLE_CESTA values(005, '006', 3,'A0003');

Insert into DETALLE_CESTA values(001, '007', 4,'A0004');
Insert into DETALLE_CESTA values(003, '007', 2,'A0001');
Insert into DETALLE_CESTA values(004, '007', 4,'A0008');
Insert into DETALLE_CESTA values(002, '007', 5,'A0007');
Insert into DETALLE_CESTA values(005, '007', 3,'A0006');

Insert into DETALLE_CESTA values(001, '008', 4,'A0002');
Insert into DETALLE_CESTA values(003, '008', 2,'A0009');
Insert into DETALLE_CESTA values(004, '008', 9,'A0001');
Insert into DETALLE_CESTA values(002, '008', 5,'A0005');
Insert into DETALLE_CESTA values(005, '008', 3,'A0006');

Insert into DETALLE_CESTA values(001, '009', 4,'A0007');
Insert into DETALLE_CESTA values(003, '009', 7,'A0006');
Insert into DETALLE_CESTA values(004, '009', 4,'A0003');
Insert into DETALLE_CESTA values(002, '009', 5,'A0002');
Insert into DETALLE_CESTA values(005, '009', 3,'A0001');

Insert into DETALLE_CESTA values(001, '010', 4,'A0001');
Insert into DETALLE_CESTA values(003, '010', 2,'A0009');
Insert into DETALLE_CESTA values(004, '010', 4,'A0002');
Insert into DETALLE_CESTA values(002, '010', 5,'A0003');
Insert into DETALLE_CESTA values(005, '010', 3,'A0005');
