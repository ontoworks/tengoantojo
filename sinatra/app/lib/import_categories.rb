#
# import_categories.rb
#
# import categories into couchdb
#
require 'rest_client'
require 'json'

@categories=[{:id=>'1747',:name=>'Accesorios para Vehículos'},{:id=>'1071',:name=>'Animales y Mascotas'},{:id=>'1039',:name=>'Cámaras Digitales y Foto'},{:id=>'1051',:name=>'Celulares y Teléfonos'},{:id=>'1798',:name=>'Coleccionables y Hobbies'},{:id=>'1648',:name=>'Computación'},{:id=>'1144',:name=>'Consolas y Videojuegos'},{:id=>'1276',:name=>'Deportes y Fitness'},{:id=>'5726',:name=>'Electrodomésticos'},{:id=>'1000',:name=>'Electrónica, Audio y Video'},{:id=>'1574',:name=>'Hogar y Muebles'},{:id=>'1499',:name=>'Industrias y Oficinas'},{:id=>'1182',:name=>'Instrumentos Musicales'},{:id=>'1132',:name=>'Juegos y Juguetes'},{:id=>'3025',:name=>'Libros, Revistas y Comics'},{:id=>'1168',:name=>'Música, Películas y Series'},{:id=>'3937',:name=>'Relojes y Joyas'},{:id=>'1430',:name=>'Ropa y Accesorios'},{:id=>'1246',:name=>'Salud y Belleza'},{:id=>'1953',:name=>'Otras categorías'}] 

@subcategories=[[1,1747,'Accesorios para Carros','6934','C','Audio para Carros','3381','C','Farolas, Stops e Iluminación','8657','N','GPS','8662','N','Llantas y Rines','8415','N','Otros','2232','H','Repuestos y Acc. para Motos','8475','N'],


[1,1071,'Aves','1100','K','Gatos','1081','K','Libros de Animales','3615','K','Otros','6152','H','Peces','1091','K','Perros y Accesorios','1072','C'],


[1,1743,'Carros','1744','N','Carros Antiguos','5682','N','Motos','1763','N','Otros Vehículos','1907','N'],


[1,1051,'Accesorios para Celulares','3813','C','Celulares','1055','C','Memorias para Celulares','7908','C','Otros','1915','H','Radios y Handies','1058','C','Tarificadores y Cabinas','10616','N','Telefonía Fija','1053','C','Telefonía IP','5237','C','Teléfonos Inalámbricos','2895','C'],


[1,1798,'Billetes y Monedas','6165','N','Colecciones Diversas','2355','H','Comics','3435','K','Filatelia','1861','C','Modelismo','3407','C','Muñecos y Accesorios','3422','N','Otros','2458','H','R.P.G. - Cartas','3390','C','Vehículos en Miniatura','3398','K'],


[1,1648,'Accesorios para Portátiles','3377','C','Apple','1870','C','Cartuchos, Toner y Tintas','2141','C','CDs y DVDs Vírgenes','1670','C','Computadores y Servidores','1649','N','Discos Duros y Externos','1669','C','Fuentes, UPS y Estabilizadores','1718','C','Impresoras','1676','C','Memorias Portátiles USB','5027','C','Memorias RAM','1694','C','Monitores y Video Beams','1655','C','Otros','1912','H','Palms, Agendas y Accesorios','1651','C','Partes y Componentes de PC','1691','C','Periféricos y Accesorios de PC','1712','C','Portátiles','1652','C','Quemadores de DVDs y CDs','9849','C','Redes y Redes Inalámbricas','1700','C','Software','1723','C','Tarjetas de Video y Captura','1686','C'],


[1,1144,'Game Boy','8867','C','GameCube','4394','C','Juegos para PC','1154','C','Nintendo 64','2919','N','Nintendo DS','7440','N','Nintendo Wii','11223','C','Otras Consolas y Accesorios','6001','C','PlayStation 1 - PS1','1149','C','PlayStation 2 - PS2','5998','C','PlayStation 3 - PS3','11623','C','PlayStation Portable - PSP','8735','C','Xbox','9826','C','Xbox 360','9959','C'],


[1,1039,'Accesorios para Cámaras','4998','C','Cámaras Automáticas','1040','K','Cámaras Digitales','1042','C','Memorias Digitales','3553','C','Otros','1914','H','Telescopios y Binoculares','4708','C','Videocámaras y Filmadoras','8876','N'],


[1,1276,'Aerobics y Fitness','1338','N','Bicicletas y Ciclismo','1292','C','Buceo','8969','K','Camping','1362','C','Deportes Extremos','1355','N','Equipos y Máquinas de Gimnasia','8432','C','Fútbol','1285','C','Golf','1342','C','Otros','1358','H','Paintball y Airsoft','4218','N','Patines y Tennis con Patines','17772','K','Relojes Deportivos','5723','C','Ropa Deportiva y Accesorios','6415','N','Skateboard','1295','H','Tenis y Squash','8540','C','Tennis y Zapatos Deportivos','3724','C'],


[1,5726,'Artículos de Cocina','1618','N','Cuidado Personal','7082','K','DVDs y Home Theaters','15237','N','Lavadoras','18353','K','Neveras','30112','K','Otros','1899','K','Pequeños Electrodomésticos','1581','C','Televisores y Plasmas','15083','C'],


[1,1000,'Accesorios Audio y Video','3690','C','Audio para Carros','1023','C','Audio para el Hogar','3835','C','Audio Portátil','1012','C','Audio Profesional','1024','C','Calculadoras','1060','C','Componentes Electrónicos','11830','K','DVDs y Home Theaters','1001','C','Equipos de Seguridad','2912','N','GPS','3571','C','iPod','6205','C','Otros','1070','H','Palms, Agendas y Accesorios','3296','N','Pilas, Cargadores y Baterías','4102','C','Reproductores MP3 y MP4','1019','C','Televisores','14903','C','Video Beams y Pantallas','4800','C','Videocámaras y Filmadoras','1006','C'],


[1,1574,'Artículos para Navidad','10935','H','Cocina','1592','H','Decoración','1631','N','Dormitorio','1608','N','Herramientas','2525','N','Muebles','1623','N','Otros','1902','H'],


[1,1499,'Equipamiento para Oficinas','2102','K','Herramientas','5226','C','Industria Gastronómica','5182','K','Industria Textil','5160','H','Muebles','8538','H','Otras Máquinas para Industrias','8536','H','Otros','8544','H','Seguridad para Industrias','8952','N'],


[1,1459,'Acción de Club','50970','N','Apartamento','1472','N','Bodega','50564','N','Casa','1466','N','Edificio','50754','N','Finca','1496','N','Habitación','60850','N','Hacienda','50751','N','Hotel','50960','N','Local y Consultorio','50559','N','Lote y Casalote','1493','N','Negocio','50529','N','Oficina','1478','N','Otro Inmueble','1892','N','Parcela de Cementerio','50968','N','Resort','68211','N','Vacacionales','68206','N'],


[1,1182,'Amplificadores','3011','C','Audio Profesional','8687','C','Bajos','3018','K','Baterías y Percusión','3004','C','Guitarras','2987','C','Instrumentos de Viento','3005','C','Otros','3014','K','Partituras','3360','K','Teclados','2997','C','Violines','3023','K'],


[1,1132,'Juegos','2960','C','Juguetes','2533','C','Modelismo','1841','N','Muñecos y Accesorios','2978','C','Otros','1910','H','Vehículos en Miniatura','2097','H'],


[1,3025,'Comics','3043','K','Libros','1196','C','Otros','1227','K','Revistas','1955','K'],


[1,1168,'Música','1176','C','Otros','1228','H','Películas','1169','C','Series y Temporadas','5633','K'],


[1,1953,'Adultos','2818','N','Alimentos y Bebidas','1403','C','Arte y Antigüedades','1367','N','Bebés','1384','C','Boletas para Espectáculos','40433','K','Otros','3530','H'],


[1,3937,'Joyería','1431','N','Otros','3938','H','Relojes de Pulso','1442','C'],


[1,1430,'Bolsos, Carteras y Maletines','3109','N','Gafas y Lentes','8472','H','Otros','1911','H','Ropa Femenina','1451','N','Ropa Masculina','3114','N','Ropa para Bebés','1455','N','Ropa para Niños','3122','K','Zapatos','5208','C'],


[1,1246,'Cuidado Bucal','44067','K','Cuidado de la Piel','1253','C','Cuidado del Cabello','1263','C','Cuidado del Cuerpo','1260','C','Cuidado para Uñas','29762','K','Equipamiento Médico','8634','C','Equipos y Máquinas de Gimnasia','8828','N','Otros','1275','H','Perfumes y Fragancias','1271','C','Suplementos Alimenticios','8830','C'],


[1,1540,'Belleza e Higiene Personal','9028','N','Educación','1563','N','Encuentros','9859','N','Fiestas y Eventos','9135','N','Mantenimiento de Vehículos','9007','N','Mantenimiento del Hogar','9080','N','Otros','1898','N','Profesionales','1541','N','Recreación y Ocio','9001','N','Reparaciones e Instalaciones','9004','N','Restaurantes','9020','N','Servicios Médicos','9056','H','Viajes y Turismo','1229','N'],


[2,6934,'Ahorradores de Gasolina','8028','K','Alarmas y Seguridad','6958','K','Herramientas','45926','K','Manuales','6937','C','Otros Accesorios','6924','K','Tableros','8681','K'],


[2,3381,'Amplificadores y Plantas','3385','K','Otros','3387','K','Parlantes','3384','C','Radios con DVD y Pantalla','8539','C','Radios con MP3','5953','K','Radios con USB','6867','K','Transmisores FM','10892','K','Woofers y SubWoofers','3693','C'],


[2,8657,'Angel Eyes','45933','H','Leds','45927','H','Otros','45934','H','Stops','45932','H','Xenon','45931','H'],


[2,8662,'Equipos','10975','N','Mapas y Accesorios','10984','K','Otros','10986','K'],


[2,8415,'Llantas','23030','N','Otros','8409','N','Rines','23029','N'],


[2,8475,'Accesorios','23028','H','Cascos','21947','H','Guantes','23018','H','Indumentaria','21948','H','Otros','21949','H'],


[2,1072,'Accesorios','1078','K','Adiestramiento','32646','K','Otros','1080','K','Perros de Raza','1073','C'],


[2,1744,'Acura','52891','N','Alfa Romeo','53272','N','Aro','64462','N','Asia','10356','N','Audi','5782','N','Beijing','64481','N','Bentley','64483','N','BMW','5783','N','Bronto','64485','N','Buick','64487','N','BYD','58189','N','Cadillac','9215','N','Chana','58040','N','Changan','64464','N','Changfenj','64456','N','Changhe','57992','N','Chery','42429','N','Chevrolet','3185','N','Chrysler','4357','N','Citroën','5779','N','Corvette','58036','N','Dacia','64459','N','Daewoo','5680','N','Daihatsu','6619','N','DFM','64537','N','Dodge','6672','N','Eagle','64489','N','Ferrari','7232','N','Fiat','3174','N','Ford','3180','N','FSO','58192','N','Geely','58071','N','GMC','65446','N','Gonow','64525','N','GWM','65463','N','Hafei','58005','N','Hino','64491','N','Honda','5739','N','Hummer','8509','N','Hyundai','5683','N','Infiniti','58031','N','International','65479','N','Isuzu','6599','N','Iveco','64493','N','Jaguar','50192','N','Jeep','6600','N','Jmc','64496','N','Kia','7079','N','Lada','47668','N','Lancia','58181','N','Land Rover','8125','N','Landwind','58012','N','Lexus','10357','N','Lincoln','9375','N','Mazda','5681','N','Mercedes Benz','6038','N','Mercury','58085','N','MG','53375','N','Mini','8480','N','Mitsubishi','5743','N','Nissan','6173','N','Oldsmobile','64501','N','Opel','8505','N','Otras Marcas','1750','N','Peugeot','5748','N','Plymouth','64467','N','Polonez','60857','N','Pontiac','6072','N','Porsche','43547','N','QQ','58225','N','Renault','3205','N','Rover','6041','N','Seat','6109','N','Shuanghuan','64469','N','Simca','64471','N','Skoda','8686','N','Ssangyong','11927','N','Subaru','7078','N','Suzuki','6583','N','Tata','11807','N','Tavria','64473','N','Toyota','5753','N','Triumph','64475','N','Uaz','64477','N','Volkswagen','3196','N','Volvo','7080','N','Wuling','65484','N','Yakima','64479','N','Zaz','64504','N','Zhongxing','65398','N','Zotye','65494','N'],


[2,5682,'Otros','69982','N'],


[2,1763,'Clásicas','2556','N','Cuatriciclos y Triciclos','35519','N','Custom / Chopper','5678','N','De Calle','6172','N','Deportivas / Naked','4359','N','Enduro, Cross y Trial','35477','N','Otros Tipos','1904','N','Scooters y Ciclomotores','1766','N','Touring','35649','N'],


[2,1907,'Ambulancias','11915','N','Autobuses','47664','N','Camiones','41696','N','Carros Blindados','60847','N','Carros de Competencia','53280','N','Carros de Golf','60867','N','Carros Especiales','53282','N','Chocados','53276','N','Grúas','52943','N','Kartings','9069','N','Maquinaria Pesada','41706','N','Motorhomes','7370','N','Otros','4096','N','Recreación','53283','N','Taxis','47913','N','Trailers','41702','N','Tuning','53289','N','Volquetas','57646','N'],


[2,3813,'Adaptadores de Audio','39209','C','Adaptadores USB Bluetooth','6933','N','Antenas','4161','K','Baterías','5068','C','Cables de Audio y TV','3520','K','Cables de datos','4922','C','Carcasas','4159','C','Cargadores','5069','C','Cámaras y Telescopios','5992','K','Displays y LCD','48906','C','Estuches y Forros','5213','N','Flex','5217','C','Holders','6944','K','Lápices Opticos','39109','C','Manos Libres','5072','C','Otros','5549','H','Parlantes','11860','C','Películas Protectoras','12953','C','Ring Tones y Utilidades','5988','H','SIM Cards','10983','H','Teclados','39046','C','Trackballs','66821','K'],


[2,1055,'Alcatel','5571','K','Apple iPhone','32089','C','Avantel','68548','K','Blackberry','9724','C','HP - iPAQ','10773','K','HTC','30151','C','LG','7076','C','Motorola','3503','C','Nokia','3507','C','Otras Marcas','3527','C','Palm Treo','10168','C','Samsung','3519','C','Siemens','4792','C','Sony Ericsson','5238','C'],


[2,7908,'Memory Stick Duo / Pro Duo','10907','C','Memory Stick Micro - M2','10969','C','miniSD','10898','C','Otros','8899','C','SD - Secure Digital','10987','C','SDHC','40659','C','TransFlash - microSD','9347','C'],


[2,1058,'Accesorios y Repuestos','2910','C','Equipos','2907','C','Otros','2911','K'],


[2,10616,'Cabinas','68009','H','Otros','53603','H','Plantas Celulares','68027','H','Tarificadores','53597','H'],


[2,1053,'Faxes','8473','K','Otros','2899','H','Teléfonos de Mesa','2896','N'],


[2,5237,'Otros','17663','K','Recarga de Crédito','17664','K','Routers y Gateways','17662','K','Teléfonos','9210','K'],


[2,2895,'General Electric','32086','C','Otras Marcas','32103','C','Panasonic','32091','C','Vtech','40740','C'],


[2,6165,'Billetes','9356','N','Monedas','9355','N','Otros','30107','H'],


[2,1861,'América','2151','K','Asia','2278','K','Europa','2150','K','Otros','2457','K','África','2152','K'],


[2,3407,'Aeromodelismo','3408','N','Automodelismo','3409','C','Otros','3413','H'],


[2,3422,'Animé','12086','N','Caballeros del Zodíaco','12094','N','Marvel','8357','K','Otros','3434','K','Personajes de Cine y TV','7168','N','Spawn','6017','K','Star Wars','7169','N'],


[2,3390,'Magic','8547','H','Otros','3395','H','Yu-Gi-Oh!','4404','H'],


[2,3377,'Adaptadores y Baterías','7222','C','Bases','16555','H','Cables','16558','H','Discos Duros','3707','C','Maletines para Portátiles','7223','N','Memorias','3582','C','Mouses','72842','K','Otros','3584','H','Pantallas','5874','N','Skins Protectores','72841','K','Tarjetas PCMCIA','7220','H','Teclados','4222','N'],


[2,1870,'Accesorios','10945','H','Computadores','10947','H','Otros','5440','H','Portátiles','10952','C'],


[2,2141,'Cartuchos','7415','C','Otros','3570','K','Sistemas Continuos de Tinta','10856','K','Tintas Sueltas y Recargas','3561','C','Toner','3560','C'],


[2,1670,'CDs Vírgenes','3379','K','DVDs Vírgenes','4719','K','Otros','5013','H','Porta CDs, Cajas y Sobres','9529','N'],


[2,1649,'AMD Athlon ','4201','H','AMD Athlon 64','8934','H','AMD Athlon 64 X2','36873','H','AMD Phenom','5912','H','AMD Sempron','6833','H','Intel Celeron','3133','H','Intel Core 2 Duo','9947','H','Intel Pentium 4','3134','H','Intel Pentium D - Dual Core','9854','H','Intel Pentium III','6954','H','Otros','1654','H'],


[2,1669,'Cajas Externas','7032','C','Discos Duros','1672','C','Otros','4972','H'],


[2,1718,'Fuentes','9913','K','Otros','9566','K','UPS y Estabilizadores','1721','K'],


[2,1676,'Chorro de Tinta','1677','C','Equipos Multifunción','1683','C','Láser Color','6832','C','Láser Monocromáticas','1678','C','Matriz de Punto','1679','C','Otros','1685','C','Repuestos y Accesorios','10190','C'],


[2,5027,'16 GB o más','21159','C','2 GB','9544','C','4 GB','12890','C','8 GB','7393','C','Hasta 1 GB','7414','C'],


[2,1694,'Para PC','37156','C','Para Portátiles','7177','C'],


[2,1655,'Monitores','1656','C','Otros','1661','H','Video Beams y Pantalllas','1657','C'],


[2,1651,'Accesorios','3308','C','Agendas Electrónicas','4360','K','Blackberry','9722','C','Dell','11950','K','HP y Compaq','3305','K','Otros','3307','K','PalmOne y Palm','3304','C'],


[2,1691,'Boards','1692','N','Coolers y Ventiladores','9752','H','Fuentes','63861','K','Modems','1701','H','Otros','1699','K','Pantallas','72865','K','Procesadores','1693','N','Tarjetas Controladoras','63859','K','Tarjetas de Sonido','4119','K'],


[2,1712,'Audífonos y Diademas','31377','C','Cables y Conectores','1715','C','Conversores y Adaptadores','6644','K','Escáners','9714','K','Joysticks','2048','C','Kits de Teclado y Mouse','6263','C','Lectores de Códigos de Barras','6280','K','Lectores de Huellas Digitales','10349','K','Mouses','1714','C','Otros','1717','H','Parlantes','3378','N','Switches','9817','K','Teclados','1713','K','Webcams','1667','C'],


[2,1652,'Acer','13516','C','Apple - MacBook','4142','C','Asus','51710','C','Compaq','50949','C','Dell','13517','C','HP','13510','C','IBM y Lenovo','13513','C','Otras Marcas','3143','C','Sony Vaio','13514','C','Toshiba','13524','C'],


[2,9849,'Externas','3525','K','Internas','4112','K','Otros','9846','K'],


[2,1700,'Adaptadores USB Bluetooth','6952','C','Antenas','7642','K','Otros','1710','H','Patch´s','1704','K','Routers Convencionales','1707','K','Routers Inalámbricos','5563','C','Switches','1708','N','Tarjetas de Red','1706','K','Tarjetas de Red Inalámbricas','5016','C','Telefonía IP','10335','N'],


[2,1723,'Aplicaciones Comerciales','1728','K','Cursos','10337','K','Diseño y Multimedia','1731','K','Herramientas de Productividad','1733','K','Idiomas','43637','K','Juegos','9856','K','Otros','1739','K','Sistemas Operativos','1737','K'],


[2,1686,'Capturadoras','6932','C','Otros','1690','K','Tarjetas de Video','1658','C'],


[2,8867,'Accesorios','4370','K','Consolas','10981','K','Juegos','10970','K','Otros','10966','K'],


[2,4394,'Accesorios','10132','K','Consolas','8872','K','Juegos','6283','C','Otros','9957','K'],


[2,1154,'Acción y Aventura','2951','K','Deportes y Carreras','2952','K','Otros','2956','K'],


[2,2919,'Accesorios','7285','H','Juegos','40977','N','Otros','2922','H'],


[2,7440,'Accesorios','40978','H','Consolas','40980','H','Juegos','40979','N','Otros','40971','H'],


[2,11223,'Accesorios','12937','C','Consolas','11965','K','Juegos','11956','C','Otros','11964','K'],


[2,6001,'Accesorios','6340','K','Consolas','2931','K','Juegos','6298','K','Otros','1152','K'],


[2,1149,'Consolas','8448','K','Juegos','8488','K','Otros','8430','K'],


[2,5998,'Accesorios','5997','K','Consolas','2930','K','Juegos','6285','C','Otros','9958','K'],


[2,11623,'Accesorios','38536','K','Consolas','11624','K','Juegos','11626','C','Otros','11625','K'],


[2,8735,'Accesorios','32275','C','Consolas','10149','C','Juegos','10134','C','Otros','10131','K'],


[2,9826,'Accesorios','10152','K','Consolas','4831','K','Juegos','6295','C','Otros','9960','K'],


[2,9959,'Accesorios','10208','C','Consolas','10336','K','Juegos','10142','C','Otros','10144','K'],


[2,4998,'Baterías para Cámaras','40741','C','Battery Grips','70233','K','Cables','12790','N','Cargadores','5101','C','Estuches y Forros','8431','K','Flashes e Iluminación','40737','K','Kits de Pilas y Cargadores','7272','N','Lectores de Memorias','6945','H','Lentes y Filtros','40742','C','Otros','4192','H','Pantallas y Protectores','70255','K','Pilas Recargables','7274','N','Portaretratos Digitales','59386','K','Trípodes','40736','K'],


[2,1042,'10 Megapixels','70239','C','5 Megapixeles','4746','C','6 Megapixeles','9851','C','7 Megapixeles','9850','C','8 Megapixeles','9247','C','9 Megapixeles','37923','C','Hasta 4.9 Megapixeles','4999','C','Más de 11 Megapixels','70211','C'],


[2,3553,'CompactFlash','4232','C','Memory Stick Duo / Pro Duo','10644','C','Otras','5548','C','SD - Secure Digital','6648','C','SDHC','38540','C'],


[2,4708,'Binoculares','4707','K','Otros','5308','K','Telescopios','4702','K'],


[2,8876,'Con Disco Duro','40729','N','DVD','10985','C','High Definition','59543','N','Mini DV','10979','N','Otros','10333','C'],


[2,1338,'Cinturones y Fajas Reductoras','5261','C','Otros','1341','H','Suplementos Alimenticios','5565','N'],


[2,1292,'Accesorios','12214','K','Bicicletas','8411','C','Indumentaria','1935','K','Otros','6143','K','Repuestos','1934','H'],


[2,1362,'Accesorios','8589','H','Bolsas de Dormir y Colchones','1364','K','Brújulas','9904','K','Carpas','1363','H','Linternas y Lámparas','6040','C','Navajas, Cuchillos y Puñales','5513','H','Otros','1366','K','Recipientes Térmicos','12203','K'],


[2,1355,'Accesorios','7409','H','Binoculares','9878','H','Indumentaria','40944','H','Morrales y Tulas','7085','H','Otros','1884','H'],


[2,8432,'Bicicletas','31049','K','Elípticas','16351','K','Gimnasia Pasiva','16352','H','Multigimnasios','40951','K','Máquinas para Abdominales','40937','K','Otros','16354','H'],


[2,1285,'Bufandas','3279','K','Camisetas','7413','C','Guayos','7403','K','Otros','1289','K'],


[2,1342,'Accesorios','1348','H','Otros','1347','H','Palos','1344','K'],


[2,4218,'Accesorios','40949','H','Armas','40938','N','Balines, Pipetas y Bolas','48423','H','Otros','40943','H'],


[2,5723,'Casio','27835','K','Otras Marcas','27848','K','Swatch','27839','K','Tag Heuer','48403','K','Tissot','48400','K','Tommy Hilfiger','27846','K'],


[2,6415,'Accesorios','40957','H','Otros','8418','H','Ropa Femenina','40954','H','Ropa Masculina','40959','H'],


[2,8540,'Accesorios','48424','K','Otros','48437','K','Raquetas','48407','K'],


[2,3724,'Etnies','62886','K','Hombres','22263','C','Mujeres','22238','C','Niños','22383','C','Otros','62532','C'],


[2,1618,'Cubiertos','8387','H','Ollas y Sartenes','8386','H','Otros','1620','H'],


[2,15237,'Home Theaters','15238','K','Otros','15240','H','Reproductores de DVD','15239','K'],


[2,1581,'Batidoras y Procesadoras','4339','H','Cafeteras y Tostadoras','4340','H','Licuadoras','4338','H','Otros','30109','K'],


[2,15083,'Convencionales','15103','C','LCD','15084','C','Otros','15112','K','Pantalla Plana','18176','C','Plasmas','15093','C'],


[2,3690,'Antenas','36570','K','Audífonos','3697','C','Cables','5054','H','Controles Remotos','4632','K','Micrófonos','4633','C','Otros','3698','K'],


[2,1023,'Amplificadores y Plantas','5539','K','Otros','3165','K','Parlantes','3162','N','Radios con DVD y Pantalla','8543','N','Radios con MP3','6866','K','Radios con USB','4870','K','Transmisores FM','10933','K','Woofers y Subwoofers','4990','C'],


[2,3835,'Minicomponentes','1014','K','Otros','3845','K','Parlantes','3839','C','Radiograbadoras','1013','K'],


[2,1012,'Discmans y CD Players','2856','K','Grabadoras de Periodista','2855','K','Otros','2860','K','Parlantes','3691','K','Radios','2854','C'],


[2,1024,'Accesorios','2878','K','Bajos y Bocinas','6872','K','Luces y Efectos','2874','K','Mezcladores y Mixers','6645','K','Otros','2879','K'],


[2,1060,'Científicas','1061','K','Financieras','1062','K','Graficadoras','4809','C','Otros','1064','K'],


[2,1001,'Accesorios','6347','K','DVDs Portátiles','18216','K','Home Theaters','1015','K','Otros','1009','H','Reproductores de DVD','1004','K'],


[2,2912,'Alarmas y Sensores','5715','H','Cajas Fuertes','8722','H','Combos de Seguridad','29676','H','Cámaras','5844','N','Otros','7161','H'],


[2,3571,'Equipos','10742','C','Mapas y Accesorios','10730','K','Otros','10722','K'],


[2,6205,'Accesorios','7263','N','Otros','7454','H','Reproductores','7262','C'],


[2,3296,'Accesorios','3302','N','Agendas Electrónicas','1059','K','HP y Compaq','3299','K','Otros','3301','K','PalmOne y Palm','3298','N'],


[2,4102,'Baterías para Cámaras','40727','C','Cargadores','40738','C','Kits de Pilas y Cargadores','7275','N','Otros','7270','H','Pilas Recargables','7279','C'],


[2,1019,'Accesorios','6203','C','iPod','16304','C','MP3','5991','C','MP4','9324','C','Otros','5984','K'],


[2,14903,'Convencionales','8661','C','LCD','8574','C','Otros','14906','K','Pantalla Plana','18194','C','Plasmas','4651','C'],


[2,4800,'Cables','59294','K','Otros','4799','K','Pantallas','11897','K','Video Beams','11889','C'],


[2,1006,'Con Disco Duro','12816','C','DVD','5841','C','High Definition','44528','C','Mini DV','9245','C','Otros','7450','C'],


[2,1631,'Cuadros','1635','H','Figuras Decorativas','7156','H','Lámparas e Iluminación','7155','H','Otros','7175','H','Relojes','1636','H'],


[2,1608,'Camas','3231','H','Colchones','1612','H','Muebles y Juegos Alcoba','8410','H','Otros','1900','H'],


[2,2525,'Eléctricas','2526','K','Manuales','2527','K','Otros','2529','K'],


[2,1623,'Juegos de Sala y Comedor','7149','H','Mesas y Escritorios','7148','H','Otros','1630','H','Sillas y Bancas','6117','H','Sofás','7159','H'],


[2,5226,'Eléctricas','5228','K','Manuales','5235','K','Otros','5236','K'],


[2,8952,'Alarmas y Sensores','29747','H','Combos de Seguridad','29748','H','Cámaras','8953','N','Otros','8955','H'],


[2,50970,'Venta','50972','H'],


[2,1472,'Arriendo','1473','H','Venta','1474','H'],


[2,50564,'Arriendo','50565','H','Venta','50566','H'],


[2,1466,'Arriendo','1467','H','Venta','1468','H'],


[2,50754,'Arriendo','60849','H','Venta','50756','H'],


[2,1496,'Arriendo','6402','H','Venta','6403','H'],


[2,60850,'Arriendo','60851','H'],


[2,50751,'Arriendo','69980','H','Venta','50753','H'],


[2,50960,'Arriendo','60862','H','Venta','50962','H'],


[2,50559,'Arriendo','50560','H','Venta','50561','H'],


[2,1493,'Arriendo','50177','H','Venta','52059','H'],


[2,50529,'Arriendo','60863','H','Venta','50530','H'],


[2,1478,'Arriendo','6399','H','Venta','6401','H'],


[2,1892,'Arriendo','6395','H','Venta','6396','H'],


[2,50968,'Venta','50969','H'],


[2,68211,'Venta','68212','H'],


[2,68206,'Apartamento','68207','H','Casa','68208','H','Otro','68210','H','Resort','68209','H'],


[2,3011,'Otros','4453','K','Para Bajo','4452','K','Para Guitarra','4451','C'],


[2,8687,'Accesorios','8688','K','Bajos y Bocinas','49675','K','Mezcladores y Mixers','8689','K','Micrófonos','11904','C','Otros','8690','K'],


[2,3004,'Accesorios','8425','C','Baterías','21950','K','Otros','8456','K','Redoblantes','29160','K'],


[2,2987,'Accesorios','7086','C','Acústicas','29465','K','Electroacústicas','7861','K','Eléctricas','4275','C','Otros','6302','K'],


[2,3005,'Acordeones','4615','K','Armónicas','4612','H','Clarinetes','6812','H','Flautas','8937','K','Otros','3772','H','Saxofones','4611','K','Trompetas','3770','H'],


[2,2997,'Accesorios','3002','K','Casio','3000','K','Korg','3001','K','Otros','3003','K','Yamaha','2998','K'],


[2,2960,'Juegos de Mesa','1161','C','Juegos de Rol','1133','K','Juegos Inflables','46101','K','Otros','2962','K'],


[2,2533,'A Control Remoto','13496','H','Bloques y Construcción - Legos','12172','K','Carros, Aviones y Barcos','2963','H','Electrónicos','2967','H','Juguetes para Bebés','3655','N','Muñecas','1139','C','Ositos y Peluches','1166','C','Otros','2534','K','Vehículos para Niños','10811','H'],


[2,1841,'Aeromodelismo','1842','N','Automodelismo','1843','C','Otros','1847','H'],


[2,2978,'Animé','10962','C','Caballeros del Zodíaco','12186','C','Marvel','71989','K','Otros','2980','K','Personajes de Cine y TV','7163','C','Spawn','8474','K','Star Wars','7160','C'],


[2,1196,'Arte, Arquitectura y Diseño','1198','C','Autoayuda y Superación','6955','K','Ciencias Económicas','5485','K','Ciencias Exactas','5497','C','Ciencias Humanísticas','5489','C','Ciencias Médicas y Naturales','5493','K','Ciencias Sociales','7146','K','Diccionarios y Enciclopedias','1221','C','Esoterismo','1201','K','Internet e Informática','6951','K','Literatura Universal','4014','C','Manuales','8344','C','Otros','5490','K','Recreación, Hobbies y Oficios','8348','C','Religión','1215','K'],


[2,1176,'Alternativa','2015','C','Latina','2019','C','Metal','4419','C','Otros','2085','C','Pop','2143','C','Religiosa','2195','C','Rock en Español','2545','C','Rock en Inglés','2011','C'],


[2,1169,'Acción y Aventura','2086','K','Drama','2091','K','Infantiles','13536','K','Otras','2096','K','Suspenso y Terror','2095','K'],


[2,2818,'Cosmética y Cuidado Personal','2791','N','Juguetes Eróticos','2736','N','Lencería y Accesorios','2771','N','Libros y Revistas','2677','N','Otros','2817','H','Videos','2700','H'],


[2,1403,'Alimentos Dulces','1418','K','Alimentos Salados','1411','K','Bebidas','41010','K','Otros','8383','K'],


[2,1367,'Antigüedades','1372','H','Arte','1368','N','Artesanías','1945','H','Otros','1885','H'],


[2,1384,'Alimentación','5360','C','Coches','15047','K','Cunas, Corrales y Moisés','15046','H','Juguetes','1392','C','Otros','15044','K','Ropa','1396','C','Sillas','8814','K'],


[2,1431,'Collares','1435','H','Otros','1440','H','Pulseras','1434','H'],


[2,1442,'Hombres','1443','C','Infantiles','1447','C','Mujeres','1444','C','Otros','1449','C'],


[2,3109,'Billeteras','7412','H','Bolsos','7407','N','Canguros','4966','H','Carteras','26539','H','Maletines para Portátiles','10361','N','Morrales y Tulas','10360','H','Otros','7400','H'],


[2,1451,'Blusas','3107','N','Busos','7298','H','Camisetas','7925','H','Chalecos','31441','H','Chaquetas y Abrigos','7918','H','Gabanes','6114','H','Medias','27240','H','Otros','3113','H','Pantalones','7919','H','Pijamas','16344','H','Ropa Deportiva','4570','H','Ropa Interior','3110','H','Vestidos','5299','H','Vestidos de Baño','24632','H'],


[2,3114,'Busos','7189','H','Camisas','6432','N','Camisetas','3115','N','Camisetas Tipo Polo','8870','N','Chaquetas','8439','H','Corbatas','6514','H','Correas y Cinturones','7680','H','Gorras y Cachuchas','10499','H','Otros','3121','H','Pantalones y Jeans','3116','H','Ropa Deportiva','40960','H','Ropa Interior','26536','H','Trajes','3119','H'],


[2,1455,'Bodys','10271','K','Conjuntos','39956','H','Otros','4919','H','Pijamas','39957','K','Ropa de Abrigo','6564','K','Vestidos','10281','K'],


[2,5208,'Botas','8784','K','Otros','5609','K','Sandalias','9255','K','Zapatos de Vestir','5608','K','Zapatos Deportivos','5607','C'],


[2,1253,'Acné','8252','K','Aparatos Electrónicos','44066','K','Baba de Caracol','9555','K','Cremas','7859','K','Geles','7860','K','Otros','1259','K'],


[2,1263,'Máquinas para Cortar Cabello','5411','K','Otros','1267','K','Planchas','4598','K','Secadores','4597','K','Tratamientos','1266','K'],


[2,1260,'Cinturones y Fajas Reductoras','8837','C','Cremas, Aceites y Geles','44062','N','Depilación','43673','N','Masajeadores','10217','N','Máquinas de Afeitar','7087','K','Otros','1882','H','Tratamientos Externos','7729','H','Yoga y Pilates','70070','K'],


[2,8634,'Accesorios Odontológicos','44065','K','Caminadores y Muletas','70071','K','Estetoscopios y Fonendoscopios','44505','K','Glucómetros','44063','K','Microscopios','44509','K','Monitores','67673','K','Otros','31379','K','Otros Equipos','70067','K','Sillas de Ruedas','31378','K','TapaBocas','44510','K','Tensiómetros','31051','C','Termómetros','44064','K'],


[2,8828,'Bicicletas','31048','K','Elípticas','16345','K','Gimnasia Pasiva','16346','H','Multigimnasios','40945','K','Máquinas para Abdominales','40955','K','Otros','16347','H'],


[2,1271,'Hombre','1272','C','Mujer','1273','C','Otros','6284','C'],


[2,8830,'Creatina','10704','K','Otros','8834','K','Proteinas','8831','K','Quemadores y Reductores','8832','K','Vitaminas y Minerales','8833','K'],


[2,9028,'Cosmetología','9029','H','Depilación','8998','H','Manicura','8978','H','Maquillaje','8979','H','Otros','9022','H','Pedicuría','9008','H','Peluquería','9010','H','Spa','9021','H'],


[2,1563,'Apoyo Escolar','9003','H','Apoyo Universitario','9046','H','Bailes y Danzas','9042','H','Culinaria','9023','H','Deportes','9062','H','Idiomas','1566','H','Informática','8980','H','Instrumentos Musicales','9045','H','Otros','1896','H'],


[2,9859,'Hombre busca Hombre','9860','H','Hombre busca Mujer','9861','H','Mujer busca Hombre','9862','H','Mujer busca Mujer','9858','H'],


[2,9135,'Alquileres','9133','H','Comida','9134','H','Otros','9129','H','Personal de Contratación','9130','H','Salones','9137','H','Shows y Animaciones','9131','H'],


[2,9007,'Autos y Camionetas','10199','H','Motos','10202','H','Otros Vehículos','10203','H'],


[2,9080,'Carpintería','9082','H','Cerrajería','9096','H','Electricidad','9118','H','Gas','9121','H','Jardinería','9100','H','Otros','9085','H','Pintura','9097','H','Plomería','9084','H','Tapicería','9115','H','Tratamiento de Pisos','9077','H'],


[2,1898,'Alquiler de Equipos de Oficina','41707','H','Hosting y Dominios','9123','H','Lavado','9017','H','Limpieza','8989','H','Mascotas buscan novio/a','11913','H','Otros','9016','H','Seguridad','8990','H'],


[2,1541,'Administración','9063','H','Comercio','9065','H','Comunicación','9066','H','Construcción','9074','H','Consultorías y Asesorías','1544','H','Contabilidad','1547','H','Derecho','1546','H','Diseño','3652','H','Economía','9043','H','Educación','9044','H','Filosofía y Letras','9009','H','Informática','1545','H','Investigación','8994','H','Medicina y Salud','1542','H','Otros','1894','H','Traductores','9018','H','Turismo','9000','H'],


[2,9001,'Casinos','9011','H','Centros de Vacaciones','9013','H','Cines','8984','H','Otros','8976','H','Teatros','9052','H','Video Clubes','9032','H'],


[2,9004,'Audio y Video','9122','H','Celulares','8996','H','Computadoras','3653','H','Electrodomésticos','8977','H','Fotografía','9053','H','Impresoras','9112','H','Lectoras, Placas y Discos','9136','H','Monitores','9075','H','Otros','9019','H','Portátiles','9113','H','Telefonía','9102','H'],


[2,9020,'Cocina Internacional','9054','H','Cocina Nacional','9055','H','Otros','9033','H'],


[2,1229,'Alquiler de Autos','8997','H','Hospedaje','5370','H','Otros','1245','H','Paquete','6311','H'],


[3,6937,'Chapa y Pintura','45940','K','Despiece','45929','K','Mecánica y Mantenimiento','45939','K','Otros','8429','K','Tuning','45930','K'],


[3,3384,'300W a 590W','40962','C','600W o más','44926','C','Hasta 295W','40963','C'],


[3,8539,'Combos - DVD y Pantalla','11006','K','DVD Players','11026','K','Otros','11002','K'],


[3,3693,'10\"','5435','K','12\"','5439','K','Otros','5104','K'],


[3,10975,'Garmin','23033','N','Magellan','23031','K','Otras Marcas','23026','K'],


[3,23030,'R13 y Menores','45935','H','R14','45936','H','R15','45928','H','R16','45937','H','R17 y Mayores','45938','H'],


[3,8409,'R13 y Menores','45950','H','R14','45951','H','R15','45952','H','R16','45953','H','R17 y Mayores','45954','H'],


[3,23029,'R13 y Menores','45945','H','R14','45946','H','R15','45947','H','R16','45948','H','R17 y Mayores','45949','H'],


[3,1073,'Razas Grandes','8447','K','Razas Medianas','8424','K','Razas Pequeñas','8422','K'],


[3,52891,'Integra','53287','H','Legend','58183','H','Otros Modelos','58222','H'],


[3,53272,'Otros Modelos','64461','H'],


[3,64462,'Otros Modelos','64463','H'],


[3,10356,'Otros Modelos','65404','H','Topic','65472','H','Towner','36235','H'],


[3,5782,'A3','27485','H','A4','27452','H','A5','50403','H','A6','27289','H','A8','50401','H','Allroad','52707','H','Cabrio','51488','H','Otros Modelos','47662','H','Q7','29571','H','RS6','47650','H','S3','27486','H','S4','27494','H','TT','52722','H'],


[3,64481,'Otros Modelos','64482','H'],


[3,64483,'Otros Modelos','64484','H'],


[3,5783,'M3','27451','H','M5','52716','H','Otros Modelos','47661','H','Serie 1','24202','H','Serie 3','24317','H','Serie 5','24329','H','Serie 6','52717','H','Serie 7','24281','H','Serie 8','27291','H','X3','24208','H','X5','24356','H','X6','52134','H','Z3','27318','H','Z4','27319','H','Z8','36171','H'],


[3,64485,'Otros Modelos','64486','H'],


[3,64487,'Otros Modelos','64488','H'],


[3,58189,'Flyer','58184','H','Otros Modelos','58190','H'],


[3,9215,'Escalade','27392','H','Otros','71374','H'],


[3,58040,'Benni','58042','H','Otros Modelos','58248','H','Star Carga','71375','H','Star Furgon','65390','H','Star Pick-Up','65405','H','Star Van','65391','H'],


[3,64464,'Otros Modelos','64465','H'],


[3,64456,'Otros Modelos','64457','H'],


[3,57992,'Otros Modelos','64458','H'],


[3,42429,'Otros Modelos','60838','H','QQ','53277','H','Tiggo','65392','H'],


[3,3185,'Alto','35438','H','Apache','65393','H','Astra','3186','H','Astro','65518','H','Avalanche','29579','H','Aveo','32563','H','Belair','60819','H','Blazer','3189','H','C-10','65394','H','C-30','34063','H','Camaro','32550','H','Caprice','34022','H','Captiva','65455','H','Cavalier','32496','H','Celebrity','60839','H','Chevelle','71396','H','Chevette','3187','H','Chevy','32470','H','Chevy C2','35459','H','Cheyenne','65469','H','Colorado','32520','H','Corsa 2 Ptas.','3188','H','Corsa 4 Ptas.','71391','H','Corvair','60840','H','Epica','32565','H','Equinox','32472','H','Esteem','34065','H','Furgón','71406','H','Grand Blazer','65378','H','Grand Vitara','65379','H','HHR','39241','H','Impala','32551','H','Jimny','65490','H','Lumina','65515','H','Luv','65514','H','Luv D-Max','65481','H','Malibú','34016','H','Mini Blazer','65410','H','Monte Carlo','51565','H','Monza','3191','H','Nova','60741','H','Optra','32567','H','Otros Modelos','29647','H','Rodeo','65505','H','S-10','29645','H','Samurai','65500','H','Silverado','62791','H','Spark','32473','H','Sprint','35458','H','Suburban','38436','H','Super Carry','65511','H','Swift','34068','H','Tahoe','65425','H','Tigra','36055','H','TrailBlazer','65426','H','Trooper','65400','H','Van','60742','H','Vectra','3194','H','Vitara','65427','H','Vivant','32558','H','Wagon R','34044','H','Zafira','29656','H'],


[3,4357,'      Durango','27475','H','Caravan','29497','H','Grand Caravan','29507','H','Neon','27476','H','Otros Modelos','65401','H','Pacifica','32339','H','PT Cruiser','29521','H','Town & Country','55073','H'],


[3,5779,'Allure','71403','H','AX','47691','H','Berlingo','24212','H','C15','24252','H','C2','32532','H','C3','24349','H','C4','29589','H','C5','24285','H','C8','62795','H','Evasion','36264','H','Jumper','24286','H','Otros Modelos','47694','H','Picasso','29500','H','Saxo','24225','H','Xantia','24226','H','Xsara','24259','H','ZX','52720','H'],


[3,58036,'Corvette','58044','H','Otros Modelos','58237','H'],


[3,64459,'Otros Modelos','64460','H'],


[3,5680,'Cielo','29539','H','Damas','65506','H','Espero','29617','H','Labo','65501','H','Lanos','29586','H','Leganza','34030','H','Matiz','29619','H','Nubira','29620','H','Otros Modelos','29616','H','Racer','29621','H','Tacuma','29501','H','Tico','29591','H'],


[3,6619,'Applause','24313','H','Charade','24335','H','F20','65478','H','Feroza','24336','H','Grand Move','32356','H','Korando','65516','H','Otros Modelos','47648','H','Rocky','32357','H','Sirion','24260','H','Terios','24350','H','YRV','60808','H'],


[3,64537,'Furgon','65499','H','Otros Modelos','65395','H','Van','65496','H'],


[3,6672,'Caliber ','71376','H','Charger','71395','H','Dakota','36228','H','Otros Modelos','65460','H','Ram','36164','H'],


[3,64489,'Otros Modelos','64490','H'],


[3,7232,'348 GTS','58228','H','Otros Modelos','58236','H'],


[3,3174,'124','60820','H','128','24233','H','132','71397','H','147','24234','H','500','52896','H','Adventure','65519','H','Bertone','71377','H','Bravo','24315','H','Croma','34043','H','Fiorino','62710','H','Idea','29597','H','Lancia','71378','H','Línea','53016','H','Marea','24230','H','Mirafiori','35447','H','Otros Modelos','24236','H','Palio','24231','H','Panda','24332','H','Premio','32541','H','Punto','30846','H','Siena','24320','H','Spider','71408','H','Stilo','29598','H','Strada','62711','H','Tempra','24232','H','Tipo','24334','H','Topolino','60868','H','Uno','24322','H','Uno Furgón','65418','H'],


[3,3180,'Adventure','65435','H','Aerostar','65461','H','Bronco','65422','H','Conquistador','60788','H','Contour','27413','H','Cortina','60835','H','Crown Victoria','50429','H','Del Rey','36084','H','Econoline','27359','H','EcoSport','65419','H','Edge','60809','H','Escape','65488','H','Escort','24237','H','Expedition','65517','H','Explorer','6622','H','F-100','6623','H','F-150','62732','H','F-250','62759','H','F-350','32576','H','F-450','65432','H','Fairmont','60724','H','Falcon','24238','H','Festiva','34034','H','Fiesta','24287','H','Flex','71383','H','Focus','24288','H','Furgón','71379','H','Fusion','33996','H','Galaxy','24273','H','Granada','35462','H','Ka','24351','H','Laser','35442','H','Lobo','65507','H','Maverick','71393','H','Mondeo','24239','H','Mustang','27343','H','Nova','71380','H','Orion','24289','H','Otros Modelos','24299','H','Probe','27483','H','Ranger','6625','H','Shelby','71384','H','Sierra','24240','H','Skyliner','71399','H','Sport Trac','65450','H','Taurus','24241','H','Thunderbird','27508','H','Torino','71407','H','Vans','71402','H','Windstar','27442','H'],


[3,58192,'Otros Modelos','58191','H','Polonez','58252','H'],


[3,58071,'CK','58038','H','Otros Modelos','58238','H'],


[3,65446,'Envoy','65407','H','Otros Modelos','65447','H'],


[3,64525,'GX6','65424','H','Otros Modelos','65423','H','Troy','71381','H'],


[3,65463,'Deer','65428','H','Hover','65429','H','Otros Modelos','65464','H','Safe','71394','H','Socool','65430','H','Wingle','65487','H'],


[3,58005,'Minyi','65451','H','Otros Modelos','65408','H','Zhongyi','65497','H'],


[3,64491,'Otros Modelos','64492','H'],


[3,5739,'Accord','27501','H','Civic','27419','H','CR-V','27405','H','CRX','35455','H','Fit','27420','H','Integra','35460','H','Legend','35449','H','Odyssey','65498','H','Otros Modelos','27302','H','Passport','38425','H','Pilot','65452','H','Prelude','35428','H','Quinted','71405','H','Ridgeline','65453','H'],


[3,8509,'H1','65442','H','H2','62802','H','H3','27444','H','Otros Modelos','65380','H'],


[3,5683,'Accent','29531','H','Atos','29660','H','Elantra','29564','H','Excel','29661','H','Genesis','71392','H','Getz','34109','H','H1','62716','H','H100','62717','H','I10','71404','H','I30','51588','H','Otros Modelos','29471','H','Pony','60852','H','Santa Fe','62761','H','Santamo','29488','H','Santro','35445','H','Scoupe','34092','H','Sonata','29489','H','Starex','38428','H','Terracan','62808','H','Tiburón','34131','H','Tucson','62734','H','Veracruz','35434','H'],


[3,58031,'Otros Modelos','64466','H'],


[3,65479,'Otros Modelos','65480','H','Pick-Up','65420','H'],


[3,6599,'Otros Modelos','65421','H','Pick-Up','29599','H','Rodeo','62706','H'],


[3,64493,'Daily','64495','H','Otros Modelos','64494','H'],


[3,50192,'Otros Modelos','58242','H','S-Type','52854','H','X-Type','52808','H','XK','52815','H'],


[3,6600,'Cherokee','29573','H','CJ','65454','H','Comando','65402','H','Commander','32467','H','Compass','32388','H','Grand Cherokee','29574','H','Liberty','38437','H','Otros Modelos','65381','H','Patriot','32389','H','Rubicon','65512','H','Wagoneer','71382','H','Willys','65502','H','Wrangler','29600','H'],


[3,64496,'Otros Modelos','64497','H'],


[3,7079,'Besta','29601','H','Carens','29518','H','Carnival','29519','H','Cerato','36983','H','Clarus','29546','H','Grand Sportage','29520','H','K2700','65462','H','Magentis','38393','H','Mohave','71400','H','Opirus','29603','H','Otros Modelos','47659','H','Picanto','36218','H','Pregio','29604','H','Pride','52708','H','Rio','36959','H','Sephia','36213','H','Shuma','36138','H','Sorento','38435','H','Spectra','41837','H','Sportage','29503','H'],


[3,47668,'2104','60829','H','2105','60855','H','2106','60856','H','Niva','65508','H','Otros Modelos','47669','H','Samara','47914','H'],


[3,58181,'Dedra','58196','H','Kappa','58243','H','Otros Modelos','58182','H'],


[3,8125,'Defender','29663','H','Discovery','27458','H','Freelander','27459','H','Otros Modelos','65467','H','Range Rover','27309','H','Santana','65509','H'],


[3,58012,'Otros Modelos','64498','H'],


[3,10357,'LS','57985','H','LX','65513','H','Otros Modelos','58176','H'],


[3,9375,'Otros Modelos','64499','H'],


[3,5681,'121','29474','H','323','29505','H','626','29610','H','929','32478','H','Allegro','34078','H','BT-50','65431','H','CX7','32490','H','CX9','32491','H','Demio','65474','H','Furgón','71409','H','Matsuri','35451','H','Mazda 2','60816','H','Mazda 3','32376','H','Mazda 5','32328','H','Mazda 6','32330','H','Miata','51479','H','MPV','65473','H','MX3','29473','H','MX5','36942','H','MX6','36943','H','Otros Modelos','29611','H','RX-7','29504','H','RX-8','32492','H','Serie B','65475','H'],


[3,6038,'Clase A','24242','H','Clase B','32459','H','Clase C','24337','H','Clase CL','27282','H','Clase CLK','24338','H','Clase D','35425','H','Clase E','24301','H','Clase G','65468','H','Clase M','65470','H','Clase S','24262','H','Clase SL','24302','H','Clase SLK','24246','H','Otros Modelos','24195','H','Smart','50431','H','Sprinter','65471','H','Viano','29566','H','Vito','65510','H'],


[3,58085,'Mariner','65411','H','Otros Modelos','58177','H','Sable','58178','H'],


[3,53375,'Otros Modelos','64500','H'],


[3,8480,'Cooper','52125','H','Cooper S','52124','H','Cord','60841','H','Otros Modelos','58204','H'],


[3,5743,'Advancer','71410','H','Campero','65489','H','Colt','24264','H','Diamante','38396','H','Eclipse','27410','H','Expo','65403','H','Galant','24254','H','Grandis','38398','H','GT','71401','H','L200','65448','H','L200 Sportero','65412','H','L300','65449','H','Lancer','24247','H','Mirage','36999','H','Montero','65457','H','Nativa','65382','H','Otros Modelos','24359','H','Outlander','65458','H','Pick-Up','65376','H','Santamo','71398','H','Sapporo','32495','H','Sigma','41647','H','Space Wagon','65377','H'],


[3,6173,'350 Z','35443','H','Ad Wagon','51591','H','Almera','35430','H','Altima','35421','H','Armada','65406','H','B13','35424','H','B14','35439','H','B15','35423','H','Bluebird','29631','H','Cedric','60813','H','D-21','65436','H','D-22','65437','H','Frontier','65443','H','Hard Top','65413','H','King Cab','65438','H','Micra','35453','H','Murano','35437','H','Murano','65383','H','Máxima','24266','H','Otros Modelos','24196','H','Pathfinder','65414','H','Patrol','65444','H','Primera','29478','H','Qashgai','65415','H','Quest','35433','H','Samurai','65416','H','Sentra','24267','H','Sunny','38399','H','Terrano','65439','H','Tiida','41826','H','Titan','65491','H','Urban','65440','H','Vanette','65417','H','X-Terra','29516','H','X-Trail','65441','H','ZX','71431','H'],


[3,64501,'Otros Modelos','64502','H'],


[3,8505,'Otros Modelos','64503','H'],


[3,1750,'Otros Modelos','34040','H'],


[3,5748,'105','71441','H','106','24309','H','107','60817','H','205','24343','H','206','24197','H','207','52148','H','305','24371','H','306','24372','H','307','24344','H','308','52126','H','309','24345','H','404','24373','H','405','24310','H','406','24221','H','407','24346','H','504','24367','H','505','24268','H','604','35448','H','605','24200','H','607','24353','H','807','65459','H','Boxer','24366','H','Otros Modelos','24374','H','Partner','24308','H'],


[3,64467,'Otros Modelos','64468','H'],


[3,60857,'Otros Modelos','60858','H'],


[3,6072,'Bonneville ','27489','H','G6','27279','H','Grand Am','27372','H','Otros Modelos','58197','H','Sunfire ','27313','H'],


[3,43547,'911','48317','H','Boxster','48315','H','Cayenne','48340','H','Otros Modelos','60801','H'],


[3,58225,'Otros Modelos','58226','H'],


[3,3205,'Clio','6606','H','Etoile','35456','H','Express','29557','H','Fuego','29585','H','Kangoo','62803','H','Koleos','71417','H','Laguna','6607','H','Logan','29652','H','Master','29540','H','Mégane','6602','H','Otros Modelos','6614','H','R12','6608','H','R18','6609','H','R19','6610','H','R21','6634','H','R4','60814','H','R5','34033','H','R6','60802','H','R9','6611','H','Safrane','51586','H','Sandero','41088','H','Scénic','6635','H','Symbol','34036','H','Twingo','6613','H'],


[3,6041,'Otros Modelos','58208','H','Serie 200','51478','H','Serie 400','51471','H','Serie 600','51473','H'],


[3,6109,'      Alhambra','27362','H','      Altea','27363','H','      Leon','27364','H','      Toledo','27453','H','Córdoba','27287','H','Ibiza','52718','H','Otros Modelos','47660','H'],


[3,64469,'Otros Modelos','64470','H'],


[3,64471,'Otros Modelos','64472','H'],


[3,8686,'Fabia','36939','H','Favorite','60815','H','Felicia','36997','H','Forman','60828','H','Octavia','36946','H','Otros Modelos','57624','H'],


[3,11927,'Actyon','47727','H','Family','65503','H','Korando','32430','H','Kyron','47728','H','Musso','32431','H','Otros Modelos','65476','H','Rexton','32432','H'],


[3,7078,'Forester','36165','H','Impreza','52721','H','Legacy','29493','H','Otros Modelos','47715','H','Outback','29536','H','Tribeca','65477','H'],


[3,6583,'Baleno','24364','H','Fun','29561','H','Grand Vitara','24303','H','LJ','65409','H','Otros Modelos','47649','H','Sidekick','62778','H','SJ','65445','H','Swift','52706','H','Vitara','24274','H'],


[3,11807,'Indica','53275','H','Otros Modelos','58198','H'],


[3,64473,'Otros Modelos','64474','H'],


[3,5753,'4Runner','65384','H','Autana','65465','H','Avalon','51460','H','Avensis','29654','H','Burbuja','65385','H','Camry','24355','H','Celica','24213','H','Corolla','24271','H','Corona','24214','H','Cresside','71433','H','Crown','51543','H','Delta','65386','H','FJ','71420','H','FJ Cruiser','65387','H','Fortuner','65466','H','Hiace','24275','H','Highlander','65396','H','Hilux','62780','H','Land Cruiser','65482','H','Land Cruiser 100','65388','H','Macho','65504','H','MR2','51542','H','Otros Modelos','24370','H','Paseo','43516','H','Prado','65389','H','Previa','62729','H','RAV4','62782','H','Sahara','65492','H','Samurai','65483','H','Scion','71412','H','Sequoia','65434','H','Sienna','43536','H','Starlet','55660','H','Supra','43528','H','Tacoma','29567','H','Tercel','24369','H','Tundra','43524','H','Yaris','35427','H'],


[3,64475,'Otros Modelos','64476','H'],


[3,64477,'Otros Modelos','64478','H'],


[3,3196,'      Derby','27345','H','Atlantic','27328','H','Bora','27433','H','Brasilia','34026','H','Buggy','41657','H','Cabriolet','27350','H','Caddy','65456','H','Combi','27300','H','Corrado','38404','H','Crossfox','43967','H','Escarabajo','24297','H','Fastback','60861','H','Fox','29614','H','Gol','24217','H','Golf','24282','H','Jetta','27478','H','Karmann','71423','H','Multivan','65397','H','New Beetle','29584','H','Otros Modelos','24306','H','Parati','24218','H','Passat','24219','H','Polo','24278','H','Quantum','29635','H','Santana','24305','H','Saveiro','3202','H','Scirocco','51491','H','Spacefox','34039','H','Touareg','51461','H','Vento','57643','H'],


[3,7080,'      XC90','27352','H','460','32341','H','850','32446','H','940','32447','H','960','36167','H','C30','51492','H','Otros Modelos','58209','H','S40','27479','H','S60','27427','H','S70','36238','H','S80','27423','H','V40','36243','H','V70','36239','H'],


[3,65484,'Otros Modelos','65485','H','Van','65486','H'],


[3,64479,'Otros Modelos','64480','H'],


[3,64504,'Otros Modelos','64505','H'],


[3,65398,'Admiral','65493','H','Otros Modelos','65399','H'],


[3,65494,'Nomada','65433','H','Otros Modelos','65495','H'],


[3,69982,'Otros','69965','H'],


[3,2556,'BMW','32741','N','Ducati','33201','N','Harley Davidson ','25168','N','Honda','25369','N','Kawasaki','35514','N','Otras Marcas','25464','N','Suzuki','25134','N','Triumph','71177','N','Yamaha','25320','N'],


[3,35519,'Akt','71194','N','Honda','35707','N','Kawasaki ','35775','N','KTM','35668','N','Kymco','71200','N','Otras Marcas','35814','N','Suzuki','35677','N','United Motors','71242','N','Yamaha','35850','N'],


[3,5678,'BMW','35544','N','Harley Davidson','35478','N','Honda','35628','N','Kawasaki','35629','N','Otras Marcas','35607','N','Suzuki','35505','N','Yamaha','35611','N'],


[3,6172,'Akt','71098','N','Aprilia','35659','N','Ayco','71122','N','Bajaj','71092','N','Honda','33067','N','Jialing','71104','N','Kawasaki','35650','N','Kymco','33060','N','Lifan','71128','N','Otras Marcas','33025','N','Sachs','71086','N','Suzuki','33256','N','United Motors','71116','N','Vento','71110','N','Yakima','71134','N','Yamaha','33008','N'],


[3,4359,'Agusta','71160','N','Aprilia','28534','N','BMW','28535','N','Buell','71146','N','Cagiva','28901','N','Ducati','28537','N','Honda','6778','N','Kawasaki','35472','N','MD Bikes','71145','N','Otras Marcas','6783','N','Suzuki','6782','N','United Motors','71213','N','Yamaha','6781','N'],


[3,35477,'Akt','71171','N','Aprilia','71183','N','BMW','35851','N','Cagiva','35844','N','Ducati','35841','N','Gasgas','71201','N','Gilera','71231','N','Honda','35834','N','Husqvarna','71159','N','Kawasaki','35728','N','KTM','35797','N','Otras Marcas','35845','N','Suzuki','35843','N','United Motors','71153','N','Vento','71225','N','Yakima','71219','N','Yamaha','35842','N'],


[3,1904,'Agusta','71338','N','Akt','71296','N','Aprilia','71320','N','Ayco','71254','N','Bajaj','71361','N','BMW','33133','N','Buell','71362','N','Cagiva','71260','N','Ducati','33766','N','Gasgas','71368','N','Gilera','71302','N','Harley Davidson','33971','N','Honda','32777','N','Husqvarna','71344','N','Jialing','71253','N','Kawasaki','35652','N','KTM','33767','N','Kymco','71314','N','Lifan','71332','N','MD Bikes','71284','N','Otras Marcas','25452','N','Peugeot ','71350','N','Piaggio','71308','N','Sachs','71326','N','Suzuki','32778','N','Triumph','71290','N','United Motors','71270','N','Vento','71278','N','Yakima','71266','N','Yamaha','32761','N'],


[3,1766,'Aprilia','33687','N','Honda','25085','N','Kawasaki','35609','N','Kymco','71207','N','Otras Marcas','25266','N','Peugeot ','25253','N','Piaggio','71147','N','Suzuki','25254','N','United Motors','71385','N','Yamaha','25255','N'],


[3,35649,'BMW','35822','N','Ducati','35846','N','Honda','35847','N','Kawasaki','35747','N','KTM','35746','N','Otras Marcas','35823','N','Suzuki','35733','N','Yamaha','35761','N'],


[3,11915,'Otros','69966','H'],


[3,47664,'Autobuses','71424','H','Microbuses','71438','H','Otros ','69967','H'],


[3,41696,'Chasis','71421','H','Estacas','71427','H','Furgones','71425','H','Nineras','71426','H','Otros ','69968','H','Tanques','71416','H','Tractocamiones','71439','H'],


[3,60847,'Otros ','69983','H'],


[3,53280,'Otros ','69978','H'],


[3,60867,'Otros ','69979','H'],


[3,53282,'Otros ','69969','H'],


[3,53276,'Otros ','69970','H'],


[3,52943,'Otros ','69971','H'],


[3,9069,'Otros ','69972','H'],


[3,41706,'Agrícola','71430','H','Asfalto','71440','H','Bulldozer','71429','H','Cargadores','71419','H','Compresores','71418','H','Martillos','71434','H','Mezcladoras','71432','H','Minicargadores','71435','H','Montacargas','71436','H','Motoniveladoras','71415','H','Otros ','69973','H','Plantas Eléctricas','71428','H','Recicladora','71414','H','Retroexcavadoras','71437','H','Vibrocompactadores','71411','H'],


[3,7370,'Otros','71422','H'],


[3,4096,'Otros ','69977','H'],


[3,53283,'Otros','71413','H'],


[3,47913,'Otros ','69974','H'],


[3,41702,'Otros ','69981','H'],


[3,53289,'Otros ','69975','H'],


[3,57646,'Otros ','69976','H'],


[3,39209,'Motorola','72373','K','Nokia','72377','K','Otros','72375','K','Samsung','72374','K','Sony Ericsson','72378','K'],


[3,6933,'Convencionales','72835','K','Mini Adaptadores','72832','K','Otros','72833','K'],


[3,5068,'Blackberry','58502','K','HTC','57802','K','iPhone','72592','K','LG','47826','K','Motorola','6929','K','Nokia','6947','K','Otras Marcas','6948','K','Samsung','8541','K','Siemens','72837','K','Sony Ericsson','6928','K'],


[3,4922,'iPhone','67079','K','LG','8588','K','Motorola','6301','K','Nokia','5305','K','Otras Marcas','6291','K','Samsung','6303','K','Sony Ericsson','6290','K'],


[3,4159,'Blackberry','4168','K','HTC','57803','K','iPhone','68049','K','LG','57804','K','Motorola','4169','C','Nokia','4170','C','Otras Marcas','4172','K','Palm Treo','68032','K','Samsung','4173','K','Sony Ericsson','9373','K'],


[3,5069,'Blackberry','58473','C','LG','16533','C','Motorola','16534','N','Nokia','16532','N','Otras Marcas','16535','N','Palm Treo','16544','C','Samsung','40734','C','Sony Ericsson','16530','N','Universales','68051','C'],


[3,48906,'Blackberry','72125','K','HTC','57792','K','iPhone','68065','K','LG','57793','K','Motorola','53588','K','Nokia','53592','K','Otros','53590','K','Palm Treo','68064','K','Samsung','53589','K','Sony Ericsson','53593','K'],


[3,5213,'Blackberry','31672','N','HTC','67993','N','iPhone','48009','N','LG','57789','N','Motorola','7889','N','Nokia','7905','N','Otras Marcas','7888','N','Palm Treo','38535','N','Samsung','31671','N','Sony Ericsson','10156','N'],


[3,5217,'iPhone','58507','K','LG','38531','K','Motorola','12895','K','Nokia','12883','K','Otros','12888','K','Samsung','48011','K','Sony Ericsson','48012','K'],


[3,39109,'HTC','72384','K','Otras Marcas','72385','K','Sony Ericsson','72403','K'],


[3,5072,'Bluetooth','6962','C','Convencionales','10786','C','Otros','12800','C'],


[3,11860,'Nokia','67997','K','Otras Marcas','66781','K','Sony Ericsson','66780','K'],


[3,12953,'Blackberry','61097','K','HTC','58478','K','iPhone','53594','K','LG','47837','K','Motorola','12917','K','Nokia','12910','K','Otros','12942','K','Palm Treo','47822','K','Samsung','58499','K','Sony Ericsson','12943','K'],


[3,39046,'Motorola','48553','K','Nokia','48552','K','Otras Marcas','48573','K','Sony Ericsson','61315','K'],


[3,5571,'Alcatel - Todas las Series','13004','K'],


[3,32089,'Apple iPhone - Otros Modelos','32099','K','iPhone 16 GB','47541','K','iPhone 3G 16 GB','57681','K','iPhone 3G 8 GB','50399','K','iPhone 8 GB','32078','K'],


[3,9724,'7290','55263','K','8100','47858','K','8120','48786','K','8220','55312','K','8310','47824','K','8320','63857','K','8900','68063','K','9000 / Bold','55264','K','Blackberry - Otros Modelos','13450','K','Storm','58467','K'],


[3,10773,'HP - iPAQ - Todas las Series','13458','H'],


[3,30151,'HTC - Otros Modelos','30136','K','Qteck','68003','K','Touch Diamond','47487','K','Touch Viva','68004','K','TyTN II','47547','K'],


[3,7076,'LG - Otros Modelos','12994','K','Serie Cu','68005','K','Serie Kf','68067','K','Serie Kp','68022','K','Serie Mg','13447','K','Viewty - KE990','51731','K'],


[3,3503,'A1200','48980','K','K1','48953','K','L6','48957','K','Motorola - Otros Modelos','4231','K','PEBL','9212','K','U9','51598','K','V3','8339','K','W230','68023','K','W375','51606','K','W5','51611','K','Z3','48958','K','Z6','48979','K','Zn200','68044','K'],


[3,3507,'1100','68029','K','1208','68068','K','2630','68006','K','2760','68030','K','3500','68031','K','5200','48981','K','5310','48952','K','5610','57796','K','5800','48982','K','6131','48985','K','6300','48960','K','E71','66212','K','N73','48954','K','N78','68007','K','N80','68035','K','N95','48984','K','N96','66213','K','Nokia - Otros Modelos','7926','K'],


[3,3527,'Otras Marcas - Otros Modelos','15622','K'],


[3,10168,'650','13013','K','680','29923','K','750','29931','K','Palm Treo - Otros Modelos','13016','K'],


[3,3519,'J700','68015','K','Omnia','50516','K','Samsung -  Otros Modelos','7890','K','Serie D','68041','K','Serie E','68042','K','Serie F','68043','K'],


[3,4792,'Siemens - Todos los Modelos','68016','K'],


[3,5238,'C702','68008','K','K550 / K550i','68020','K','K850','48986','K','Sony Ericsson - Otros Modelos','7917','K','W200','48983','K','W300','48955','K','W380','48987','K','W580','48956','K','W760','68019','K','W810 / W810i','68024','K','W880 / W880i','68025','K','W910','48967','K','Xperia X1','68026','K'],


[3,10907,'2 GB','12897','K','4 GB','16106','K','6 GB o más','48126','K','Hasta 1 GB','12878','K'],


[3,10969,'2 GB','16221','K','4 GB','16222','K','6 GB o más','48912','K','Hasta 1 GB','16220','K'],


[3,10898,'2 GB','12902','K','4 GB','16248','K','6 GB o más','48131','K','Hasta 1 GB','16247','K'],


[3,8899,'2 GB','16243','K','4 GB','16244','K','6 GB o más','48128','K','Hasta 1 GB','16242','K'],


[3,10987,'2 GB','12796','K','4 GB','16099','K','6 GB o más','48913','K','Hasta 1 GB','10988','K'],


[3,40659,'2 GB','40649','K','4 GB','40650','K','6 GB o más','50274','K','Hasta 1 GB','40648','K'],


[3,9347,'2 GB','16234','K','4 GB','16240','K','6 GB o más','48130','K','Hasta 1 GB','12896','K'],


[3,2910,'Antenas','39210','K','Baterías y Cargadores','39224','K','Otros Accesorios','39121','K'],


[3,2907,'Icom','39211','K','Motorola','16531','K','Otras Marcas','16538','K','Yaesu','61258','K'],


[3,2896,'General Electric','70478','H','Otras Marcas','70480','H','Panasonic','70455','H'],


[3,32086,'2.4 GHz','7042','K','5.8 GHz','39144','K','DECT 6.0','64151','K','Otras Frecuencias','39154','K'],


[3,32103,'2.4 GHz','7034','K','5.8 GHz','39277','K','DECT 6.0','64152','K','Otras Frecuencias','39278','K'],


[3,32091,'2.4 GHz','7038','K','5.8 GHz','39271','K','DECT 6.0','64153','K','Otras Frecuencias','39272','K'],


[3,40740,'2.4 GHz','40802','K','5.8 GHz','40803','K','DECT 6.0','68021','K','Otras Frecuencias','40805','K'],


[3,9356,'América','9473','N','Asia','9468','N','Europa','9470','N','Otros','9472','H','África','30111','N'],


[3,9355,'América','30110','N','Asia','30104','H','Europa','30106','N','Oceanía','44228','H','Otros','30105','H','África','44183','H'],


[3,3408,'Aviones','8100','N','Helicópteros','8101','H','Otros','8118','H','Planos y Cursos','12089','H'],


[3,3409,'Accesorios','72490','K','Autos','10231','C','Otros','7943','K'],


[3,12086,'Dragon Ball','71996','K','Evangelion','39448','K','Gundam','44469','K','Otros','71997','K','Revoltech','71998','K','Transformers','71999','K'],


[3,12094,'Caballeros de Bronce','72005','H','Caballeros Dorados','72004','H','Otros','72000','K'],


[3,7168,'Batman','72009','K','Gears Of War','72006','K','Gi Joe','72008','K','Los Simpsons','46190','K','Otros','46193','K','Spiderman','72010','K','Terminator','72007','K','Transformers','46192','K'],


[3,7169,'Naves','72013','K','Otros','72012','K','Personajes','72011','K'],


[3,7222,'Acer','54425','K','Apple','63147','K','Asus','63170','K','Compaq','63171','K','Dell','12933','K','Gateway','63148','K','Genéricas','9379','K','HP','9398','K','IBM','12932','K','Otros','9435','K','Sony Vaio','12946','K','Toshiba','32322','K'],


[3,3707,'1 TB o más','72840','K','120 GB a 190 GB','36814','K','200 GB a 490 GB','38736','K','500GB','38936','K','Hasta 100 GB','36880','K'],


[3,7223,'Fundas','40749','H','Maletines','26532','H','Morrales','26538','H','Otros','26535','H'],


[3,3582,'DDR','36813','C','DDR2','36878','C','DDR3','50973','C','DIMM / SDRAM','36879','C','Otras Memorias','36812','C'],


[3,5874,'14.1 Pulgadas','38867','H','15.4 Pulgadas','38875','H','16 Pulgadas o más','38872','H','Hasta 14 Pulgadas','38873','H','Otros','68175','H'],


[3,4222,'Acer','54164','H','Compaq','54165','H','Dell','54148','H','HP','54150','H','Otros','54167','H','Sony Vaio','54151','H','Toshiba','54166','H'],


[3,10952,'MacBook - Core 2 Duo','16096','C','MacBook - Core Duo','16103','C','Otros','16092','C'],


[3,7415,'Epson','54423','K','HP','54422','K','Lexmark','63855','K','Otros','14838','K'],


[3,3561,'Kits de Recarga','53587','K','Manuales','10879','K','Otros','10880','K','Tintas','10871','K'],


[3,3560,'HP','7233','K','Okidata','63856','K','Otros','7241','K','Ricoh','54424','K','Samsung','12925','K','Xerox','7239','K'],


[3,9529,'Cajas','63854','H','Otros','63860','H','Porta CDs','63858','H'],


[3,7032,'1.8','72843','K','2.5','72844','K','3.5','72845','K','Otras','72846','K'],


[3,1672,'120 GB a 190 GB','5029','C','200 GB a 490 GB','7371','C','500 GB o más','10394','C','Hasta 100 GB','5918','C'],


[3,1677,'Brother','17923','K','Canon','4194','K','Epson','3703','K','HP','3704','K','Lexmark','3705','K','Otras Marcas','9771','K','Samsung','14414','K'],


[3,1683,'Brother','17920','K','Canon','6327','K','Epson','6325','K','HP','6331','K','Lexmark','6326','K','Otras Marcas','6328','K','Samsung','14430','K'],


[3,6832,'Brother','17924','K','Canon','14450','K','Epson','14451','K','HP','14452','K','Lexmark','14453','K','Otras Marcas','14714','K','Samsung','14456','K'],


[3,1678,'Brother','17919','K','Canon','14418','K','Epson','14419','K','HP','6719','K','Lexmark','9364','K','Otras Marcas','7238','K','Samsung','9727','K'],


[3,1679,'Brother','17925','K','Canon','14422','K','Epson','6046','K','HP','14423','K','Lexmark','14424','K','Otras Marcas','6052','K','Samsung','14426','K'],


[3,1685,'Brother','17926','K','Canon','14432','K','Epson','14433','K','HP','14434','K','Lexmark','14435','K','Otras Marcas','14437','K','Samsung','14438','K'],


[3,10190,'Brother','38958','K','Canon','14392','K','Epson','14396','K','HP','14397','K','Lexmark','14401','K','Otras Marcas','23052','K','Samsung','14399','K'],


[3,21159,'Kingston','42324','K','Markvision','42325','K','Otras Marcas','42326','K','Sandisk','51656','K'],


[3,9544,'Kingston','42316','K','Markvision','42317','K','Otras Marcas','42318','K','Sandisk','42389','K'],


[3,12890,'Kingston','42320','K','Markvision','42321','K','Otras Marcas','42322','K','Sandisk','42387','K'],


[3,7393,'Kingston','42220','K','Markvision','42218','K','Otras Marcas','42222','K','Sandisk','42223','K'],


[3,7414,'Kingston','42068','K','Markvision','42069','K','Otras Marcas','42066','K','Sandisk','51628','K'],


[3,37156,'DDR','4304','C','DDR2','9948','C','DDR3','55255','C','DIMM / SDRAM','4303','C','Otras Memorias','4305','C'],


[3,7177,'DDR','37162','C','DDR2','37110','C','DDR3','50927','C','DIMM / SDRAM','54969','C','Otras Memorias','37163','C'],


[3,1656,'Convencionales','5604','C','LCD','4695','C','Otros','9946','K'],


[3,1657,'Cables','49654','K','Otros','9585','K','Pantallas','11609','K','Video Beams','11901','C'],


[3,3308,'Baterias','10321','C','Cables','5606','K','Carcasas','57928','K','Cargadores','9757','K','Estuches y Protectores','4136','K','Lápices','11898','C','Otros','4137','K','Pantallas','57923','K','Teclados','5005','K'],


[3,9722,'7290','55262','K','8100','46206','K','8120','66784','K','8220','55241','K','8310','47850','K','8320','63853','K','8520','72862','K','8900','68018','K','9000 / Bold','46203','K','Otros Modelos','13461','K','Storm','58506','K'],


[3,3304,'Otras','7151','K','Treo','7636','C','Tungsten','5007','K','TX','9847','K','Zire','5001','K'],


[3,1692,'Otros','3717','H','Para AMD','6965','H','Para Intel','6956','H'],


[3,1693,'AMD Athlon','9785','H','AMD Athlon X2','40463','H','AMD Phenom','44380','H','Intel Celeron','9794','H','Intel Core 2 Duo','10390','H','Intel Dual Core','40464','H','Intel Pentium 4','9745','H','Intel Pentium III','3625','H','Otros','3155','H'],


[3,31377,'Con Micrófono','72863','K','Otros','72867','K','Sin Micrófono','72866','K'],


[3,1715,'Cables de Red','54154','K','Dvi','54426','K','FireWire','36856','K','Hdmi','32207','H','Otros','7621','H','Para Impresoras','54169','K','PS/2','17962','H','RCA','63862','K','Serial ATA','9443','H','USB','5877','H','VGA','36844','H'],


[3,2048,'Gamepads','68165','K','Otros','10866','K','Simuladores de Vuelo y Combate','68163','K','Timones y Pedales','68172','K'],


[3,6263,'Inalámbricos','57553','K','Otros','57495','K','Tradicionales','57494','K'],


[3,1714,'Láser','36907','C','Otros','4298','C','Ópticos','4295','C'],


[3,3378,'Con Subwoofer','12901','N','Otros','4208','K','Sin Subwoofer','12893','K'],


[3,1667,'Con Micrófono','11145','C','Sin Micrófono','11109','C'],


[3,13516,'AMD Turion','9453','C','AMD Turion 64 X2','13769','N','Intel Atom','54973','C','Intel Celeron','9445','C','Intel Core 2 Duo','13791','C','Intel Core Duo','13764','C','Intel Pentium 4','7623','C','Intel Pentium M - Centrino','16233','C','Otros Procesadores','51039','C'],


[3,4142,'Intel Core 2 Duo','13957','C','Intel Core Duo','16091','C','Otros Procesadores','13996','C'],


[3,51710,'AMD Turion','51694','C','AMD Turion 64 X2','52784','C','Intel Atom','54972','C','Intel Celeron','51717','C','Intel Core 2 Duo','51719','C','Intel Core Duo','51720','N','Intel Pentium 4','51721','N','Intel Pentium M - Centrino','51698','C','Otros Procesadores','51699','N'],


[3,50949,'AMD Turion','51053','C','AMD Turion 64 X2','52788','C','Intel Atom','53565','C','Intel Celeron','51054','C','Intel Core 2 Duo','51055','C','Intel Core Duo','51056','C','Intel Pentium 4','51057','C','Intel Pentium M - Centrino','51060','C','Otros Procesadores','51061','C'],


[3,13517,'AMD Turion','13748','C','AMD Turion 64 X2','13773','C','Intel Atom','54970','C','Intel Celeron','10326','C','Intel Core 2 Duo','13795','C','Intel Core Duo','10991','C','Intel Pentium 4','7643','C','Intel Pentium M - Centrino','16235','C','Otros Procesadores','51072','C'],


[3,13510,'AMD Turion','16224','C','AMD Turion 64 X2','13775','C','Intel Atom','54968','C','Intel Celeron','6708','C','Intel Core 2 Duo','13797','C','Intel Core Duo','10872','C','Intel Pentium 4','6725','C','Intel Pentium M - Centrino','16236','C','Otros Procesadores','50991','C'],


[3,13513,'AMD Turion','13750','C','AMD Turion 64 X2','13776','N','Intel Atom','54971','C','Intel Celeron','11120','C','Intel Core 2 Duo','13798','C','Intel Core Duo','13768','C','Intel Pentium 4','16341','C','Intel Pentium M - Centrino','40471','C','Otros Procesadores','51002','C'],


[3,3143,'AMD Turion','16225','C','AMD Turion 64 X2','13777','N','Intel Atom','55076','C','Intel Celeron','6709','C','Intel Core 2 Duo','13799','C','Intel Core Duo','10875','C','Intel Pentium 4','7376','C','Intel Pentium M - Centrino','16237','C','Otros Procesadores','13523','C'],


[3,13514,'AMD Turion','13751','C','AMD Turion 64 X2','13778','N','Intel Atom','54967','C','Intel Celeron','13740','C','Intel Core 2 Duo','13800','C','Intel Core Duo','10882','C','Intel Pentium 4','9610','C','Intel Pentium M - Centrino','16238','C','Otros Procesadores','51013','C'],


[3,13524,'AMD Turion','13752','C','AMD Turion 64 X2','13779','N','Intel Atom','54974','C','Intel Celeron','6707','C','Intel Core 2 Duo','13801','C','Intel Core Duo','10883','C','Intel Pentium 4','6693','C','Intel Pentium M - Centrino','16239','C','Otros Procesadores','51024','C'],


[3,6952,'Convencionales','72834','K','Mini Adaptadores','72836','K','Otros','72838','K'],


[3,5563,'108 Mbps','11343','K','54 Mbps','11342','K','Otros','11341','K'],


[3,1708,'12 a 16 Puertos','37085','H','24 Puertos o más','37177','H','8 Puertos','37084','H','Hasta 5 Puertos','37119','H'],


[3,5016,'Otras','40685','K','PCI','40641','K','USB','54421','K'],


[3,10335,'Otros','16557','K','Recarga de Crédito','16556','K','Routers y Gateways','16554','K','Teléfonos','16559','K'],


[3,6932,'Externas','72868','K','Internas','72870','K','Otras','72869','K'],


[3,1658,'AGP','6255','C','Otros','5483','C','PCI Express','9275','C'],


[3,6283,'Acción','40985','C','Aventura','43723','C','Deportes y Carreras','40975','C','Otros Juegos','40976','C'],


[3,40977,'Acción y Aventura','58515','H','Deportes y Carreras','58516','H','Otros','58519','H'],


[3,40979,'Acción y Aventura','43728','N','Deportes y Carreras','43732','N','Otros Juegos','43733','N'],


[3,12937,'Cables','43148','K','Controles','43197','K','Otros','43198','K'],


[3,11956,'Acción y Aventura','18071','C','Deportes y Carreras','18073','C','Otros Juegos','18072','C'],


[3,6285,'Acción y Aventura','42442','C','Deportes y Carreras','42445','C','Otros','42466','C'],


[3,11626,'Acción','43180','C','Aventura','18070','C','Deportes y Carreras','18067','C','Otros Juegos','18079','C'],


[3,32275,'Cables','58518','K','Cargadores','51640','K','Estuches y Protectores','51632','K','Memorias','58517','K','Otros','51633','K'],


[3,10149,'Convencionales','46758','K','Otros','46757','K','Slim','46756','K'],


[3,10134,'Acción y Aventura','43458','K','Deportes y Carreras','43463','K','Otros','43459','K'],


[3,6295,'Acción y Aventura','43740','C','Deportes, Luchas y Carreras','43727','C','Otros Juegos','43741','C'],


[3,10208,'Adaptadores y Cargadores','58520','K','Cables','18118','K','Controles y Volantes','18114','K','Otros Accesorios','18102','K'],


[3,10142,'Acción y Aventura','10869','C','Deportes y Carreras','10874','C','Otros','10887','C'],


[3,40741,'Canon','59392','K','JVC','59395','K','Kodak','59391','K','Nikon','59382','K','Olympus','70258','K','Otras Marcas','59396','K','Panasonic','59393','K','Samsung','59394','K','Sony','59381','K'],


[3,12790,'Otros','70229','H','Para Kodak','70227','H','Para Nikon','70226','H','Para Samsung','70228','H','Para Sony','70253','H'],


[3,5101,'De Baterías','50201','C','De Pilas Recargables','50215','K','Otros','7269','K'],


[3,7272,'2000 mAh y más','8414','H','Hasta 1800 mAh','8441','H'],


[3,40742,'Canon','70234','K','Nikon','70235','K','Otros','70260','K','Sony','70259','K'],


[3,7274,'AA','70256','K','AAA','70261','K','Otros','70236','K'],


[3,70239,'Canon','70241','K','Casio','70240','K','Fujifilm','70250','K','HP','70242','K','Kodak','70243','K','Nikon','70244','K','Olympus','70245','K','Otras Marcas','70246','K','Panasonic','70247','K','Pentax','70252','K','Polaroid','70251','K','Samsung','70248','K','Sony','70249','K'],


[3,4746,'Canon','6647','K','Casio','40941','K','Fujifilm','12856','K','HP','8542','K','Kodak','7401','K','Nikon','7399','K','Olympus','8546','K','Otras Marcas','6641','K','Panasonic','12872','K','Pentax','50209','K','Polaroid','17864','K','Samsung','12873','K','Sony','6640','K'],


[3,9851,'Canon','11891','K','Casio','40936','K','Fujifilm','17859','K','HP','12874','K','Kodak','11900','K','Nikon','11887','K','Olympus','12875','K','Otras Marcas','11893','K','Panasonic','12876','K','Pentax','50212','K','Polaroid','17865','K','Samsung','12877','K','Sony','11890','K'],


[3,9850,'Canon','12805','K','Casio','40942','K','Fujifilm','17860','K','HP','12809','K','Kodak','12807','K','Nikon','12808','K','Olympus','12802','K','Otras Marcas','12806','K','Panasonic','12801','K','Pentax','50204','K','Polaroid','17866','K','Samsung','12804','K','Sony','12803','K'],


[3,9247,'Canon','10917','K','Casio','12638','K','Fujifilm','11247','K','HP','10931','K','Kodak','12581','K','Nikon','11028','K','Olympus','12556','K','Otras Marcas','10928','K','Panasonic','12664','K','Pentax','17665','K','Polaroid','12639','K','Samsung','12582','K','Sony','10921','K'],


[3,37923,'Canon','37925','K','Casio','37939','K','Fujifilm','37927','K','HP','37928','K','Kodak','37929','K','Nikon','37930','K','Olympus','37932','K','Otras Marcas','37933','K','Panasonic','37934','K','Pentax','37935','K','Polaroid','37937','K','Samsung','37942','K','Sony','37936','K'],


[3,4999,'Canon','8444','K','Casio','12715','K','Fujifilm','12716','K','HP','6946','K','Kodak','6940','K','Nikon','7549','K','Olympus','6926','K','Otras Marcas','6927','K','Panasonic','12503','K','Pentax','38978','K','Polaroid','17863','K','Samsung','12506','K','Sony','6939','K'],


[3,70211,'Canon','70213','K','Casio','70212','K','Fujifilm','70222','K','HP','70214','K','Kodak','70215','K','Nikon','70216','K','Olympus','70217','K','Otras Marcas','70218','K','Panasonic','70219','K','Pentax','70224','K','Polaroid','70223','K','Samsung','70220','K','Sony','70221','K'],


[3,4232,'2 GB','12814','K','4 GB','13860','K','6 GB o más','47509','K','Hasta 1 GB','11812','K'],


[3,10644,'2 GB','10638','K','4 GB','12853','K','6 GB o más','47513','K','Hasta 1 GB','10678','K'],


[3,5548,'2 GB','16252','K','4 GB','16253','K','6 GB o más','48907','K','Hasta 1 GB','16251','K'],


[3,6648,'2 GB','12799','K','4 GB','16102','K','6 GB o más','48908','K','Hasta 1 GB','8869','K'],


[3,38540,'2 GB','38542','K','4 GB','38541','K','6 GB o más','47510','K','Hasta 1 GB','38543','K'],


[3,40729,'Canon','40730','K','JVC','40731','K','Otras Marcas','40732','K','Panasonic','40733','K','Samsung','49677','K','Sony','40735','K'],


[3,10985,'Canon','16515','K','JVC','16516','K','Otras Marcas','16517','K','Panasonic','16518','K','Samsung','49679','K','Sony','16519','K'],


[3,59543,'Canon','59544','H','JVC','59545','H','Otras Marcas','59546','H','Panasonic','59547','H','Samsung','59549','H','Sony','59548','H'],


[3,10979,'Canon','16372','K','JVC','16371','K','Otras Marcas','16370','K','Panasonic','16369','K','Samsung','49680','K','Sony','16373','K'],


[3,10333,'Canon','16520','K','JVC','16521','K','Otras Marcas','16522','K','Panasonic','16523','K','Samsung','49681','K','Sony','16524','K'],


[3,5261,'Body','70078','K','De Latex','70079','K','De yeso','70080','K','Otros','70082','K','Térmica','70081','K'],


[3,5565,'Creatina','12307','K','Otros','8027','K','Proteinas','8025','K','Quemadores y Reductores','8030','K','Vitaminas y Minerales','8029','K'],


[3,8411,'De Carrera','62889','K','De Montaña','62883','K','Estilo Libre','62888','K','Otros Modelos','62884','K'],


[3,6040,'De Mano','47781','K','Frontales','47811','K','Lámparas','47740','H','Otros','47741','H'],


[3,7413,'Clubes Extranjeros','6037','K','Clubes Nacionales','6034','K','Otros','62887','K','Selecciones','6032','K'],


[3,40938,'Escopetas','48421','H','Marcadoras','48402','H','Metralletas','48401','H','Otros','48422','H','Pistolas','48406','H','Rifles','48408','H'],


[3,22263,'Adidas','4679','K','Circa','62552','K','Converse','6969','K','Diesel','7249','K','Fila','26533','K','New Balance','62535','K','Nike','4678','K','Otras Marcas','4681','K','Puma','5717','K','Reebok','62551','K'],


[3,22238,'Adidas','23477','K','Circa','62590','K','Converse','23362','K','Diesel','62620','K','Fila','62629','K','New Balance','62589','K','Nike','23396','K','Otras Marcas','23481','K','Puma','23488','K','Reebok','23476','K','Vans','62621','K'],


[3,22383,'Adidas','23381','K','Circa','62631','K','Converse','23411','K','Diesel','62636','K','Fila','62637','K','New Balance','62630','K','Nike','23431','K','Otras Marcas','23438','K','Puma','23445','K','Reebok','23452','K','Vans','62626','K'],


[3,62532,'Adidas','62638','K','Circa','62639','K','Converse','62601','K','Diesel','62608','K','Fila','62610','K','New Balance','62625','K','Nike','62623','K','Otras Marcas','62602','K','Puma','6511','K','Reebok','4680','K','Vans','62607','K'],


[3,15103,'40\" o más','15110','K','De 21\" a 31\"','15108','K','De 32\" a 39\"','15109','K','Hasta 20\"','15111','K'],


[3,15084,'40\" o más','15091','K','De 21\" a 31\"','11894','K','De 32\" a 39\"','11903','K','Hasta 20\"','15092','K'],


[3,18176,'40\" o más','18183','K','De 21\" a 31\"','18181','K','De 32\" a 39\"','18182','K','Hasta 20\"','18184','K'],


[3,15093,'40\" o más','15096','K','De 32\" a 39\"','15097','K'],


[3,3697,'Con Diadema','10585','K','Otros','10573','K','Sin Diadema','10558','K'],


[3,4633,'Inalámbricos','8719','K','No Inalámbricos','8728','K','Otros','8723','K'],


[3,3162,'300W a 590W','40948','N','600W o más','44932','N','Hasta 295W','40947','N'],


[3,8543,'Combos - DVD y Pantalla','11018','K','DVD Players','11005','K','Otros','11007','K'],


[3,4990,'10\"','5317','K','12\"','5310','K','Otros','5316','K'],


[3,3839,'Con Subwoofer','3978','C','Otros','3980','K','Sin Subwoofer','3861','K'],


[3,2854,'Coby','59298','K','Otros','59301','K','Sony','59300','K'],


[3,4809,'HP','12798','K','Otros','12792','K','Texas Instruments','12794','K'],


[3,5844,'Cámaras de Vigilancia','10553','H','Cámaras Espía','10583','H','Cámaras IP','49346','H','Otros','10581','H'],


[3,10742,'Garmin','23035','C','Magellan','23027','K','Otras Marcas','23032','K'],


[3,7263,'Audífonos','8840','H','Baterías','8707','H','Cables','8860','H','Cargadores, Docks y Bases','8838','H','Fundas, Protectores y Forros','8841','N','iTrip y Transmisores FM','8835','H','Otros','8717','H','Parlantes','9853','H'],


[3,7262,'iPod classic','31591','C','iPod mini','14546','C','iPod nano','8826','C','iPod shuffle','8827','C','iPod touch','32320','C','iPod video','10977','C','iPod y iPod photo','14547','C','Otros','9372','K'],


[3,3302,'Baterías','57927','N','Cables','6494','K','Carcasas','57926','K','Cargadores','7031','K','Estuches y Protectores','8656','K','Lápices','11905','N','Otros','4146','K','Pantallas','72864','K','Teclados','4882','K'],


[3,3298,'Otras','7228','K','Tungsten','4874','K','TX','9848','K','Zire','4889','K'],


[3,40727,'Canon','59398','K','JVC','59397','K','Kodak','59390','K','Nikon','59399','K','Olympus','70225','K','Otras Marcas','59387','K','Panasonic','59389','K','Samsung','59388','K','Sony','59400','K'],


[3,40738,'De Baterías','50200','C','De Pilas Recargables','50217','K','Otros','50216','K'],


[3,7275,'2000 mAh y más','8419','H','Hasta 1800 mAh','8443','H'],


[3,7279,'AA','70257','K','AAA','70237','K','Otros','70238','K'],


[3,6203,'Audífonos','18203','K','Baterías','36555','K','Cables','18174','K','Cargadores','36554','K','Estuches y Protectores','18205','K','Otros Accesorios','18186','K','Parlantes','38942','K','Transmisores','18204','K'],


[3,16304,'Accesorios','8940','N','Otros','16282','K','Reproductores','8947','C'],


[3,5991,'2 GB o más','6195','K','Hasta 1 GB','12791','K'],


[3,9324,'2 GB','9852','K','4 GB','10579','K','6 GB o más','40696','K','Hasta 1 GB','12797','K'],


[3,8661,'40\" o más','14898','K','De 21\" a 31\"','14944','K','De 32\" a 39\"','14946','K','Hasta 20\"','14905','K'],


[3,8574,'40\" o más','14942','K','De 21\" a 31\"','11899','K','De 32\" a 39\"','11902','K','Hasta 20\"','14938','K'],


[3,18194,'40\" o más','18201','K','De 21\" a 31\"','18198','K','De 32\" a 39\"','18199','K','Hasta 20\"','18202','K'],


[3,4651,'40\" o más','10570','K','De 32\" a 39\"','10740','K'],


[3,11889,'Epson','15040','K','NEC','72847','K','Optoma Technology','15038','K','Otros','15042','K','Sony','15041','K','Viewsonic','72848','K'],


[3,12816,'Canon','14273','K','JVC','14275','K','Otras Marcas','14159','K','Panasonic','14280','K','Samsung','14161','K','Sony','14258','K'],


[3,5841,'Canon','14052','K','JVC','14061','K','Otras Marcas','14034','K','Panasonic','14062','K','Samsung','14036','K','Sony','14035','K'],


[3,44528,'Canon','44741','K','JVC','44530','K','Otras Marcas','44531','K','Panasonic','44532','K','Samsung','44533','K','Sony','44534','K'],


[3,9245,'Canon','11008','K','JVC','11014','K','Otras Marcas','10996','K','Panasonic','10994','K','Samsung','11015','K','Sony','11020','K'],


[3,7450,'Canon','14028','K','JVC','14048','K','Otras Marcas','14047','K','Panasonic','14038','K','Samsung','14037','K','Sony','14046','K'],


[3,8953,'Cámaras de Vigilancia','49676','H','Cámaras Espía','49684','H','Cámaras IP','49674','H','Otros','49678','H'],


[3,4451,'Engl','72839','K','Fender','5357','K','Laney','10531','K','Marshall','5350','K','Otros','5351','K'],


[3,11904,'Inalámbricos','59303','K','No Inalámbricos','59295','K','Otros','59297','K'],


[3,8425,'Baquetas','29161','K','Otros','45430','K','Parches','6813','K','Pedales','45431','K','Platillos','8451','K'],


[3,7086,'Afinadores','8421','K','Otros Accesorios','8440','K','Pedaleras','8436','K'],


[3,4275,'Epiphone','4853','K','Fender','8445','K','Gibson','12497','K','Ibanez','8446','K','Jackson','8438','K','Otras Marcas','8420','K','Schecter','26976','K','Washburn','12990','K','Yamaha','4276','K'],


[3,1161,'Ajedrez','7932','K','Billar','8004','K','Niños','1162','K','Otros','2959','K','Rompecabezas','1858','K'],


[3,3655,'Carritos','27812','K','Columpios','3657','K','Gimnasios','27821','K','Juguetes','3658','K','Mesas y Sillas','27810','K','Otros','3659','K','Triciclos','45977','K'],


[3,1139,'Accesorios','1142','K','Barbies','1140','K','Indumentaria','1141','K','Otros','1143','K'],


[3,1166,'Osos','21884','K','Otros','21885','K','Perros','21894','K','Personajes de Disney','72487','K'],


[3,1842,'Aviones','7937','N','Helicópteros','7933','H','Otros','7971','H','Planos y Cursos','12088','H'],


[3,1843,'Accesorios','12483','K','Autos','6906','N','Otros','8229','K'],


[3,10962,'Dragon Ball','14835','K','Evangelion','14808','K','Gundam','14811','K','Otros','14832','K','Revoltech','14833','K','Transformers','39617','K'],


[3,12186,'Caballeros de Bronce','14825','H','Caballeros Dorados','14821','H','Otros','14799','K'],


[3,7163,'Alien - Predator','21924','K','Batman','38525','K','Gears Of War','38488','K','Gi Joe','38490','K','Los Simpsons','6753','K','Otros','12187','K','Spiderman','14834','K','Terminator','38489','K','Transformers','46191','K'],


[3,7160,'Naves','71991','K','Otros','71992','K','Personajes','71990','K'],


[3,1198,'Arquitectura y Diseño','49219','K','Arte','49220','K','Otros','11706','K'],


[3,5497,'Física y Química','40538','K','Matemáticas','6007','K','Otros','5499','K','Solucionarios','10500','K'],


[3,5489,'Filosofía','41517','K','Otros','5496','K','Psicología','41523','K'],


[3,1221,'Diccionarios','40486','K','Enciclopedias','4002','K','Otros','40528','K'],


[3,4014,'Novelas','4505','K','Otros','4504','K','Poesías','4021','K'],


[3,8344,'Animales','49222','K','Carpintería y Cerrajería','41126','K','Carros','10501','K','Cocina','41124','K','Dibujo y Diseño','41125','K','Idiomas','41123','K','Música y Danza','49221','K','Otros','10502','K'],


[3,8348,'Animales y Mascotas','8261','K','Cocina','3036','K','Deportes','1219','K','Jardinería','1220','K','Música','3500','K','Otros','4511','K'],


[3,2015,'CDs','15188','K','DVDs','15167','K','Otros Formatos','15174','K','Vinilos','15236','K'],


[3,2019,'CDs','15234','K','DVDs','15216','K','Otros Formatos','15177','K','Vinilos','15210','K'],


[3,4419,'CDs','26228','K','DVDs','26227','K','Otros Formatos','26230','K','Vinilos','27602','K'],


[3,2085,'CDs','15204','K','DVDs','6276','K','Otros Formatos','16486','K','Vinilos','29677','K'],


[3,2143,'CDs','16494','K','DVDs','6275','K','Otros Formatos','16477','K','Vinilos','25669','K'],


[3,2195,'CDs','29667','K','DVDs','29668','K','Otros Formatos','29669','K','Vinilos','29678','K'],


[3,2545,'CDs','26225','K','DVDs','26229','K','Otros Formatos','26226','K','Vinilos','27637','K'],


[3,2011,'CDs','15644','K','DVDs','6279','K','Otros Formatos','16474','K','Vinilos','25686','K'],


[3,2791,'Aceites','2797','H','Feromonas','41531','H','Otros','2799','H','Retardantes','2795','H'],


[3,2736,'Artículos para Sadomasoquismo','40932','H','Cremas y Lubricantes','6959','N','Otros','6960','H','Vibradores y Consoladores','6925','N'],


[3,2771,'Baby Dolls','41844','H','Bodys','2790','H','Conjuntos','72116','H','Fantasías / Disfraces','2789','H','Otros','41530','H','Tangas','41843','H'],


[3,2677,'Gay','40953','H','Heterosexual','40933','H','Otros','2683','H'],


[3,1368,'Cursos, Libros y Materiales','35940','H','Otros','1371','H','Pinturas','1369','H'],


[3,5360,'Leche','39965','K','Otros','5361','K','Platos y Cubiertos','39992','K','Teteros','5363','K'],


[3,1392,'Carritos','71986','K','Columpios','71985','K','Gimnasios','27814','K','Juguetes','71987','K','Mesas y Sillas','27826','K','Otros','1887','K','Triciclos','71988','K'],


[3,1396,'Bodys','10209','K','Conjuntos','28130','H','Otros','1888','H','Pijamas','31419','K','Ropa de Abrigo','6549','K','Vestidos','10280','K'],


[3,1443,'Clásicos','3952','C','Deportivos','3950','C','Otros','3953','C'],


[3,1447,'Clásicos','27844','C','Deportivos','4480','C','Otros','27845','C'],


[3,1444,'Clásicos','3956','C','Deportivos','3954','C','Otros','3957','C'],


[3,1449,'Clásicos','27928','C','Deportivos','27936','C','Otros','27944','C'],


[3,7407,'Estampados','62547','H','Lisos','62548','H','Otros','62549','H'],


[3,10361,'Fundas','62536','H','Maletines','26530','H','Morrales','26528','H','Otros','26531','H'],


[3,3107,'Esqueletos','10819','H','Manga Corta','10814','H','Manga Larga','3970','H','Otros','7293','H'],


[3,6432,'Cuadrille','62542','H','Lisas','62540','H','Otros','7687','H','Rayadas','62541','H'],


[3,3115,'Azules','8083','H','Blancas','62537','H','Negras','5528','H','Otros','5533','H','Rojas','8071','H'],


[3,8870,'Lisas','62538','H','Otras','62543','H','Rayadas','62539','H'],


[3,5607,'Etnies','62885','K','Hombres','62550','C','Mujeres','62534','C','Niños','62546','C','Otros','6860','C'],


[3,8837,'Body','70057','K','De Latex','70058','K','De yeso','70087','K','Otros','70088','K','Térmica','70056','K'],


[3,44062,'Aceites','70065','H','Cremas','70059','H','Geles Reafirmantes','70077','H','Otros','70060','H'],


[3,43673,'Depiladoras','70061','H','Laser y Definitiva','43716','H','Otros','43667','H'],


[3,10217,'Corporales','70062','H','Otros Masajeadores','70063','H','Pies','70064','H'],


[3,31051,'Análogos','70083','K','Digitales con Lcd','44504','K','Otros','70084','K'],


[3,1272,'Armani','5415','K','Benetton','26364','K','Bvlgari','8129','K','Calvin Klein','5393','K','Carolina Herrera','5410','K','Cartier','26352','K','Chanel','26224','K','Christian Dior','26350','K','Cuba','26357','K','Diesel','67682','K','Dolce & Gabbana','5379','K','Esika - Ebel','31415','K','Ferrari','5390','K','Givenchy','26356','K','Hugo Boss','5416','K','Hugo Boss','70089','K','Issey Miyake','70072','K','Lacoste','7776','K','Nautica','70066','K','Otras Marcas','5402','K','Paco Rabanne','70068','K','Perry Ellis','26362','K','Polo','70085','K','Ralph Lauren','5418','K','Swiss Army','7777','K','Tommy Hilfiger','26354','K','Victoria´s Secret','26361','K'],


[3,1273,'Armani','5380','K','Benetton','16317','K','Beverly Hills','70069','K','Burberry','26370','K','Bvlgari','26433','K','Cacharel','5400','K','Calvin Klein','5381','K','Carolina Herrera','5386','K','Dolce & Gabbana','5377','K','Esika - Ebel','30851','K','Fred Hayman','70086','K','Givenchy','9558','K','Hugo Boss','7820','K','Jennifer Lopez','70073','K','Jesús del Pozo','26443','K','Kenzo','5409','K','Lacoste','17771','K','Lancome','16355','K','Liz Claiborne','26445','K','Mont Blanc','16358','K','Moschino','70076','K','Oscar De La Renta','70075','K','Otras Marcas','5403','K','Paris Hilton','26448','K','Perry Ellis','7768','K','Ralph Lauren','7824','K','Victoria´s Secret','5396','K','Yanbal','70074','K'],


[3,6284,'Benetton','27900','K','Carolina Herrera','27901','K','Hugo Boss','27902','K','Lacoste','27903','K','Otras Marcas','27904','K','Perry Ellis','27905','K','Ralph Lauren','44068','K','Victoria´s Secret','27906','K'],


[4,40962,'6\"','4647','K','6\" x 9\"','4648','K','Combos','7560','K','Otros','44936','K'],


[4,44926,'6\"','44929','K','6\" x 9\"','9732','K','Combos','44927','K','Otros','44928','K'],


[4,40963,'6\"','7434','K','6\" x 9\"','7907','K','Combos','44925','K','Otros','7429','K'],


[4,23033,'eTrex','40981','K','Forerunner','59304','K','Gpsmap 60','40982','K','Nüvi','49683','K','Otros','40965','K'],


[4,32741,'0 - 50 cc','32749','H','050 cc - 125 cc','32974','H','125 cc - 250 cc','32882','H','250 cc - 500 cc','32883','H','500 cc o más','32916','H'],


[4,33201,'0 - 50 cc','32917','H','050 cc - 125 cc','32719','H','125 cc - 250 cc','33161','H','250 cc - 500 cc','33162','H','500 cc o más','32886','H'],


[4,25168,'0 - 50 cc','32925','H','050 cc - 125 cc','32926','H','125 cc - 250 cc','32927','H','250 cc - 500 cc','32928','H','500 cc o más','32697','H'],


[4,25369,'0 - 50 cc','33166','H','050 cc - 125 cc','33167','H','125 cc - 250 cc','32896','H','250 cc - 500 cc','33168','H','500 cc o más','32897','H'],


[4,35514,'0 - 50 cc','35735','H','050 cc - 125 cc','35848','H','125 cc - 250 cc','35849','H','250 cc - 500 cc','35852','H','500 cc o más','35853','H'],


[4,25464,'0 - 50 cc','32698','H','050 cc - 125 cc','32699','H','125 cc - 250 cc','32700','H','250 cc - 500 cc','32929','H','500 cc o más','32976','H'],


[4,25134,'0 - 50 cc','32855','H','050 cc - 125 cc','33171','H','125 cc - 250 cc','32811','H','250 cc - 500 cc','32677','H','500 cc o más','32765','H'],


[4,71177,'0 - 50 cc','71178','H','050 cc - 125 cc','71179','H','125 cc - 250 cc','71180','H','250 cc - 500 cc','71181','H','500 cc o más','71182','H'],


[4,25320,'0 - 50 cc','32813','H','050 cc - 125 cc','32751','H','125 cc - 250 cc','32922','H','250 cc - 500 cc','32923','H','500 cc o más','32696','H'],


[4,71194,'0 - 50 cc','71195','H','050 cc - 125 cc','71196','H','125 cc - 250 cc','71197','H','250 cc - 500 cc','71198','H','500 cc o más','71199','H'],


[4,35707,'0 - 50 cc','35808','H','050 cc - 125 cc','35809','H','125 cc - 250 cc','35737','H','250 cc - 500 cc','35738','H','500 cc o más','35785','H'],


[4,35775,'0 - 50 cc','35786','H','050 cc - 125 cc','35787','H','125 cc - 250 cc','35739','H','250 cc - 500 cc','35788','H','500 cc o más','35740','H'],


[4,35668,'0 - 50 cc','35669','H','050 cc - 125 cc','35736','H','125 cc - 250 cc','35854','H','250 cc - 500 cc','35719','H','500 cc o más','35720','H'],


[4,71200,'0 - 50 cc','71189','H','050 cc - 125 cc','71190','H','125 cc - 250 cc','71191','H','250 cc - 500 cc','71192','H','500 cc o más','71193','H'],


[4,35814,'0 - 50 cc','35857','H','050 cc - 125 cc','35789','H','125 cc - 250 cc','35858','H','250 cc - 500 cc','35859','H','500 cc o más','35722','H'],


[4,35677,'0 - 50 cc','35763','H','050 cc - 125 cc','35764','H','125 cc - 250 cc','35765','H','250 cc - 500 cc','35766','H','500 cc o más','35721','H'],


[4,71242,'0 - 50 cc','71243','H','050 cc - 125 cc','71244','H','125 cc - 250 cc','71245','H','250 cc - 500 cc','71246','H','500 cc o más','71247','H'],


[4,35850,'0 - 50 cc','35855','H','050 cc - 125 cc','35784','H','125 cc - 250 cc','35762','H','250 cc - 500 cc','35856','H','500 cc o más','35791','H'],


[4,35544,'0 - 50 cc','35817','H','050 cc - 125 cc','35781','H','125 cc - 250 cc','35768','H','250 cc - 500 cc','35776','H','500 cc o más','35810','H'],


[4,35478,'0 - 50 cc','35780','H','050 cc - 125 cc','35815','H','125 cc - 250 cc','35767','H','250 cc - 500 cc','35816','H','500 cc o más','35860','H'],


[4,35628,'0 - 50 cc','35777','H','050 cc - 125 cc','35778','H','125 cc - 250 cc','35723','H','250 cc - 500 cc','35861','H','500 cc o más','35724','H'],


[4,35629,'0 - 50 cc','35862','H','050 cc - 125 cc','35779','H','125 cc - 250 cc','35811','H','250 cc - 500 cc','35725','H','500 cc o más','35799','H'],


[4,35607,'0 - 50 cc','35801','H','050 cc - 125 cc','35734','H','125 cc - 250 cc','35693','H','250 cc - 500 cc','35802','H','500 cc o más','35694','H'],


[4,35505,'0 - 50 cc','35692','H','050 cc - 125 cc','35863','H','125 cc - 250 cc','35793','H','250 cc - 500 cc','35800','H','500 cc o más','35769','H'],


[4,35611,'0 - 50 cc','35818','H','050 cc - 125 cc','35835','H','125 cc - 250 cc','35790','H','250 cc - 500 cc','35741','H','500 cc o más','35792','H'],


[4,71098,'0 - 50 cc','71099','H','050 cc - 125 cc','71100','H','125 cc - 250 cc','71101','H','250 cc - 500 cc','71102','H','500 cc o más','71103','H'],


[4,35659,'0 - 50 cc','35804','H','050 cc - 125 cc','35805','H','125 cc - 250 cc','35806','H','250 cc - 500 cc','35770','H','500 cc o más','35812','H'],


[4,71122,'0 - 50 cc','71123','H','050 cc - 125 cc','71124','H','125 cc - 250 cc','71125','H','250 cc - 500 cc','71126','H','500 cc o más','71127','H'],


[4,71092,'0 - 50 cc','71093','H','050 cc - 125 cc','71094','H','125 cc - 250 cc','71095','H','250 cc - 500 cc','71096','H','500 cc o más','71097','H'],


[4,33067,'0 - 50 cc','33196','H','050 cc - 125 cc','33080','H','125 cc - 250 cc','33197','H','250 cc - 500 cc','33278','H','500 cc o más','33198','H'],


[4,71104,'0 - 50 cc','71105','H','050 cc - 125 cc','71106','H','125 cc - 250 cc','71107','H','250 cc - 500 cc','71108','H','500 cc o más','71109','H'],


[4,35650,'0 - 50 cc','35803','H','050 cc - 125 cc','35782','H','125 cc - 250 cc','35794','H','250 cc - 500 cc','35783','H','500 cc o más','35795','H'],


[4,33060,'0 - 50 cc','32937','H','050 cc - 125 cc','32820','H','125 cc - 250 cc','33208','H','250 cc - 500 cc','32821','H','500 cc o más','33209','H'],


[4,71128,'0 - 50 cc','71129','H','050 cc - 125 cc','71130','H','125 cc - 250 cc','71131','H','250 cc - 500 cc','71132','H','500 cc o más','71133','H'],


[4,33025,'0 - 50 cc','32822','H','050 cc - 125 cc','32823','H','125 cc - 250 cc','32824','H','250 cc - 500 cc','33300','H','500 cc o más','33301','H'],


[4,71086,'0 - 50 cc','71087','H','050 cc - 125 cc','71088','H','125 cc - 250 cc','71089','H','250 cc - 500 cc','71090','H','500 cc o más','71091','H'],


[4,33256,'0 - 50 cc','32818','H','050 cc - 125 cc','33336','H','125 cc - 250 cc','33296','H','250 cc - 500 cc','33181','H','500 cc o más','33297','H'],


[4,71116,'0 - 50 cc','71117','H','050 cc - 125 cc','71118','H','125 cc - 250 cc','71119','H','250 cc - 500 cc','71120','H','500 cc o más','71121','H'],


[4,71110,'0 - 50 cc','71111','H','050 cc - 125 cc','71112','H','125 cc - 250 cc','71113','H','250 cc - 500 cc','71114','H','500 cc o más','71115','H'],


[4,71134,'0 - 50 cc','71135','H','050 cc - 125 cc','71136','H','125 cc - 250 cc','71137','H','250 cc - 500 cc','71138','H','500 cc o más','71139','H'],


[4,33008,'0 - 50 cc','33279','H','050 cc - 125 cc','33015','H','125 cc - 250 cc','33180','H','250 cc - 500 cc','33016','H','500 cc o más','33280','H'],


[4,71160,'0 - 50 cc','71168','H','050 cc - 125 cc','71169','H','125 cc - 250 cc','71170','H','250 cc - 500 cc','71166','H','500 cc o más','71167','H'],


[4,28534,'0 - 50 cc','28592','H','050 cc - 125 cc','28835','H','125 cc - 250 cc','28779','H','250 cc - 500 cc','28780','H','500 cc o más','28781','H'],


[4,28535,'0 - 50 cc','28553','H','050 cc - 125 cc','28554','H','125 cc - 250 cc','28555','H','250 cc - 500 cc','28782','H','500 cc o más','28593','H'],


[4,71146,'0 - 50 cc','71140','H','050 cc - 125 cc','71141','H','125 cc - 250 cc','71142','H','250 cc - 500 cc','71143','H','500 cc o más','71144','H'],


[4,28901,'0 - 50 cc','28836','H','050 cc - 125 cc','28556','H','125 cc - 250 cc','28557','H','250 cc - 500 cc','28558','H','500 cc o más','28837','H'],


[4,28537,'0 - 50 cc','28427','H','050 cc - 125 cc','32878','H','125 cc - 250 cc','28212','H','250 cc - 500 cc','28595','H','500 cc o más','28883','H'],


[4,6778,'0 - 50 cc','28404','H','050 cc - 125 cc','28599','H','125 cc - 250 cc','28600','H','250 cc - 500 cc','28601','H','500 cc o más','28362','H'],


[4,35472,'0 - 50 cc','35748','H','050 cc - 125 cc','35695','H','125 cc - 250 cc','35820','H','250 cc - 500 cc','35749','H','500 cc o más','35821','H'],


[4,71145,'0 - 50 cc','71237','H','050 cc - 125 cc','71238','H','125 cc - 250 cc','71239','H','250 cc - 500 cc','71240','H','500 cc o más','71241','H'],


[4,6783,'0 - 50 cc','28610','H','050 cc - 125 cc','28571','H','125 cc - 250 cc','28572','H','250 cc - 500 cc','28786','H','500 cc o más','28682','H'],


[4,6782,'0 - 50 cc','28458','H','050 cc - 125 cc','28459','H','125 cc - 250 cc','28409','H','250 cc - 500 cc','28410','H','500 cc o más','28605','H'],


[4,71213,'0 - 50 cc','71214','H','050 cc - 125 cc','71215','H','125 cc - 250 cc','71216','H','250 cc - 500 cc','71217','H','500 cc o más','71218','H'],


[4,6781,'0 - 50 cc','28609','H','050 cc - 125 cc','28745','H','125 cc - 250 cc','28461','H','250 cc - 500 cc','28439','H','500 cc o más','28746','H'],


[4,71171,'0 - 50 cc','71172','H','050 cc - 125 cc','71173','H','125 cc - 250 cc','71174','H','250 cc - 500 cc','71175','H','500 cc o más','71176','H'],


[4,71183,'0 - 50 cc','71184','H','050 cc - 125 cc','71185','H','125 cc - 250 cc','71186','H','250 cc - 500 cc','71187','H','500 cc o más','71188','H'],


[4,35851,'0 - 50 cc','35712','H','050 cc - 125 cc','35757','H','125 cc - 250 cc','35819','H','250 cc - 500 cc','35697','H','500 cc o más','35771','H'],


[4,35844,'0 - 50 cc','35682','H','050 cc - 125 cc','35825','H','125 cc - 250 cc','35683','H','250 cc - 500 cc','35798','H','500 cc o más','35684','H'],


[4,35841,'0 - 50 cc','35813','H','050 cc - 125 cc','35755','H','125 cc - 250 cc','35807','H','250 cc - 500 cc','35756','H','500 cc o más','35732','H'],


[4,71201,'0 - 50 cc','71202','H','050 cc - 125 cc','71203','H','125 cc - 250 cc','71204','H','250 cc - 500 cc','71205','H','500 cc o más','71206','H'],


[4,71231,'0 - 50 cc','71232','H','050 cc - 125 cc','71233','H','125 cc - 250 cc','71234','H','250 cc - 500 cc','71235','H','500 cc o más','71236','H'],


[4,35834,'0 - 50 cc','35709','H','050 cc - 125 cc','35796','H','125 cc - 250 cc','35673','H','250 cc - 500 cc','35678','H','500 cc o más','35759','H'],


[4,71159,'0 - 50 cc','71161','H','050 cc - 125 cc','71162','H','125 cc - 250 cc','71163','H','250 cc - 500 cc','71164','H','500 cc o más','71165','H'],


[4,35728,'0 - 50 cc','35679','H','050 cc - 125 cc','35760','H','125 cc - 250 cc','35704','H','250 cc - 500 cc','35660','H','500 cc o más','35670','H'],


[4,35797,'0 - 50 cc','35675','H','050 cc - 125 cc','35773','H','125 cc - 250 cc','35665','H','250 cc - 500 cc','35726','H','500 cc o más','35727','H'],


[4,35845,'0 - 50 cc','35688','H','050 cc - 125 cc','35685','H','125 cc - 250 cc','35686','H','250 cc - 500 cc','35826','H','500 cc o más','35687','H'],


[4,35843,'0 - 50 cc','35680','H','050 cc - 125 cc','35758','H','125 cc - 250 cc','35836','H','250 cc - 500 cc','35661','H','500 cc o más','35681','H'],


[4,71153,'0 - 50 cc','71154','H','050 cc - 125 cc','71155','H','125 cc - 250 cc','71156','H','250 cc - 500 cc','71157','H','500 cc o más','71158','H'],


[4,71225,'0 - 50 cc','71226','H','050 cc - 125 cc','71227','H','125 cc - 250 cc','71228','H','250 cc - 500 cc','71229','H','500 cc o más','71230','H'],


[4,71219,'0 - 50 cc','71220','H','050 cc - 125 cc','71221','H','125 cc - 250 cc','71222','H','250 cc - 500 cc','71223','H','500 cc o más','71224','H'],


[4,35842,'0 - 50 cc','35772','H','050 cc - 125 cc','35824','H','125 cc - 250 cc','35676','H','250 cc - 500 cc','35708','H','500 cc o más','35666','H'],


[4,71338,'0 - 50 cc','71339','H','050 cc - 125 cc','71340','H','125 cc - 250 cc','71341','H','250 cc - 500 cc','71342','H','500 cc o más','71343','H'],


[4,71296,'0 - 50 cc','71297','H','050 cc - 125 cc','71298','H','125 cc - 250 cc','71299','H','250 cc - 500 cc','71300','H','500 cc o más','71301','H'],


[4,71320,'0 - 50 cc','71321','H','050 cc - 125 cc','71322','H','125 cc - 250 cc','71323','H','250 cc - 500 cc','71324','H','500 cc o más','71325','H'],


[4,71254,'0 - 50 cc','71248','H','050 cc - 125 cc','71249','H','125 cc - 250 cc','71250','H','250 cc - 500 cc','71251','H','500 cc o más','71252','H'],


[4,71361,'0 - 50 cc','71356','H','050 cc - 125 cc','71357','H','125 cc - 250 cc','71358','H','250 cc - 500 cc','71359','H','500 cc o más','71360','H'],


[4,33133,'0 - 50 cc','32803','H','050 cc - 125 cc','32973','H','125 cc - 250 cc','32804','H','250 cc - 500 cc','32805','H','500 cc o más','33286','H'],


[4,71362,'0 - 50 cc','71363','H','050 cc - 125 cc','71364','H','125 cc - 250 cc','71365','H','250 cc - 500 cc','71366','H','500 cc o más','71367','H'],


[4,71260,'0 - 50 cc','71261','H','050 cc - 125 cc','71262','H','125 cc - 250 cc','71263','H','250 cc - 500 cc','71264','H','500 cc o más','71265','H'],


[4,33766,'0 - 50 cc','33785','H','050 cc - 125 cc','33703','H','125 cc - 250 cc','33786','H','250 cc - 500 cc','33650','H','500 cc o más','33755','H'],


[4,71368,'0 - 50 cc','71369','H','050 cc - 125 cc','71370','H','125 cc - 250 cc','71371','H','250 cc - 500 cc','71372','H','500 cc o más','71373','H'],


[4,71302,'0 - 50 cc','71303','H','050 cc - 125 cc','71304','H','125 cc - 250 cc','71305','H','250 cc - 500 cc','71306','H','500 cc o más','71307','H'],


[4,33971,'0 - 50 cc','33704','H','050 cc - 125 cc','33555','H','125 cc - 250 cc','33590','H','250 cc - 500 cc','33768','H','500 cc o más','33715','H'],


[4,32777,'0 - 50 cc','32779','H','050 cc - 125 cc','32780','H','125 cc - 250 cc','32964','H','250 cc - 500 cc','32799','H','500 cc o más','32995','H'],


[4,71344,'0 - 50 cc','71345','H','050 cc - 125 cc','71346','H','125 cc - 250 cc','71347','H','250 cc - 500 cc','71348','H','500 cc o más','71349','H'],


[4,71253,'0 - 50 cc','71255','H','050 cc - 125 cc','71256','H','125 cc - 250 cc','71257','H','250 cc - 500 cc','71258','H','500 cc o más','71259','H'],


[4,35652,'0 - 50 cc','35754','H','050 cc - 125 cc','35731','H','125 cc - 250 cc','35718','H','250 cc - 500 cc','35698','H','500 cc o más','35699','H'],


[4,33767,'0 - 50 cc','38634','H','050 cc - 125 cc','38680','H','125 cc - 250 cc','38681','H','250 cc - 500 cc','38682','H','500 cc o más','38633','H'],


[4,71314,'0 - 50 cc','71315','H','050 cc - 125 cc','71316','H','125 cc - 250 cc','71317','H','250 cc - 500 cc','71318','H','500 cc o más','71319','H'],


[4,71332,'0 - 50 cc','71333','H','050 cc - 125 cc','71334','H','125 cc - 250 cc','71335','H','250 cc - 500 cc','71336','H','500 cc o más','71337','H'],


[4,71284,'0 - 50 cc','71285','H','050 cc - 125 cc','71286','H','125 cc - 250 cc','71287','H','250 cc - 500 cc','71288','H','500 cc o más','71289','H'],


[4,25452,'0 - 50 cc','33290','H','050 cc - 125 cc','33291','H','125 cc - 250 cc','33292','H','250 cc - 500 cc','32876','H','500 cc o más','32877','H'],


[4,71350,'0 - 50 cc','71351','H','050 cc - 125 cc','71352','H','125 cc - 250 cc','71353','H','250 cc - 500 cc','71354','H','500 cc o más','71355','H'],


[4,71308,'0 - 50 cc','71309','H','050 cc - 125 cc','71310','H','125 cc - 250 cc','71311','H','250 cc - 500 cc','71312','H','500 cc o más','71313','H'],


[4,71326,'0 - 50 cc','71327','H','050 cc - 125 cc','71328','H','125 cc - 250 cc','71329','H','250 cc - 500 cc','71330','H','500 cc o más','71331','H'],


[4,32778,'0 - 50 cc','32801','H','050 cc - 125 cc','33028','H','125 cc - 250 cc','32802','H','250 cc - 500 cc','32996','H','500 cc o más','33029','H'],


[4,71290,'0 - 50 cc','71291','H','050 cc - 125 cc','71292','H','125 cc - 250 cc','71293','H','250 cc - 500 cc','71294','H','500 cc o más','71295','H'],


[4,71270,'0 - 50 cc','71273','H','050 cc - 125 cc','71274','H','125 cc - 250 cc','71275','H','250 cc - 500 cc','71276','H','500 cc o más','71277','H'],


[4,71278,'0 - 50 cc','71279','H','050 cc - 125 cc','71280','H','125 cc - 250 cc','71281','H','250 cc - 500 cc','71282','H','500 cc o más','71283','H'],


[4,71266,'0 - 50 cc','71267','H','050 cc - 125 cc','71268','H','125 cc - 250 cc','71269','H','250 cc - 500 cc','71271','H','500 cc o más','71272','H'],


[4,32761,'0 - 50 cc','32970','H','050 cc - 125 cc','32971','H','125 cc - 250 cc','32972','H','250 cc - 500 cc','32790','H','500 cc o más','32791','H'],


[4,33687,'0 - 50 cc','33638','H','050 cc - 125 cc','33639','H','125 cc - 250 cc','33869','H','250 cc - 500 cc','33642','H','500 cc o más','33802','H'],


[4,25085,'0 - 50 cc','32681','H','050 cc - 125 cc','33204','H','125 cc - 250 cc','32843','H','250 cc - 500 cc','32682','H','500 cc o más','32844','H'],


[4,35609,'0 - 50 cc','35689','H','050 cc - 125 cc','35667','H','125 cc - 250 cc','35742','H','250 cc - 500 cc','35664','H','500 cc o más','35743','H'],


[4,71207,'0 - 50 cc','71208','H','050 cc - 125 cc','71209','H','125 cc - 250 cc','71210','H','250 cc - 500 cc','71211','H','500 cc o más','71212','H'],


[4,25266,'0 - 50 cc','33252','H','050 cc - 125 cc','33118','H','125 cc - 250 cc','33119','H','250 cc - 500 cc','32688','H','500 cc o más','33120','H'],


[4,25253,'0 - 50 cc','32990','H','050 cc - 125 cc','33272','H','125 cc - 250 cc','32991','H','250 cc - 500 cc','33143','H','500 cc o más','32807','H'],


[4,71147,'0 - 50 cc','71148','H','050 cc - 125 cc','71149','H','125 cc - 250 cc','71150','H','250 cc - 500 cc','71151','H','500 cc o más','71152','H'],


[4,25254,'0 - 50 cc','32683','H','050 cc - 125 cc','32684','H','125 cc - 250 cc','33031','H','250 cc - 500 cc','32685','H','500 cc o más','32686','H'],


[4,71385,'0 - 50 cc','71386','H','050 cc - 125 cc','71387','H','125 cc - 250 cc','71388','H','250 cc - 500 cc','71389','H','500 cc o más','71390','H'],


[4,25255,'0 - 50 cc','33213','H','050 cc - 125 cc','33053','H','125 cc - 250 cc','32836','H','250 cc - 500 cc','32710','H','500 cc o más','32733','H'],


[4,35822,'0 - 50 cc','35827','H','050 cc - 125 cc','35837','H','125 cc - 250 cc','35828','H','250 cc - 500 cc','35829','H','500 cc o más','35830','H'],


[4,35846,'0 - 50 cc','35674','H','050 cc - 125 cc','35662','H','125 cc - 250 cc','35663','H','250 cc - 500 cc','35744','H','500 cc o más','35710','H'],


[4,35847,'0 - 50 cc','35671','H','050 cc - 125 cc','35751','H','125 cc - 250 cc','35714','H','250 cc - 500 cc','35701','H','500 cc o más','35774','H'],


[4,35747,'0 - 50 cc','35702','H','050 cc - 125 cc','35696','H','125 cc - 250 cc','35752','H','250 cc - 500 cc','35717','H','500 cc o más','35706','H'],


[4,35746,'0 - 50 cc','35831','H','050 cc - 125 cc','35832','H','125 cc - 250 cc','35833','H','250 cc - 500 cc','35729','H','500 cc o más','35705','H'],


[4,35823,'0 - 50 cc','35715','H','050 cc - 125 cc','35690','H','125 cc - 250 cc','35838','H','250 cc - 500 cc','35672','H','500 cc o más','35691','H'],


[4,35733,'0 - 50 cc','35700','H','050 cc - 125 cc','35703','H','125 cc - 250 cc','35716','H','250 cc - 500 cc','35713','H','500 cc o más','35753','H'],


[4,35761,'0 - 50 cc','35745','H','050 cc - 125 cc','35750','H','125 cc - 250 cc','35730','H','250 cc - 500 cc','35839','H','500 cc o más','35840','H'],


[4,4169,'A1200','67093','K','K1','67092','K','Otros','67101','K','V3','67099','K'],


[4,4170,'6131','68045','K','6681','72121','K','N73','68056','K','N95','68061','K','Otros','68057','K'],


[4,58473,'De Automóvil','58474','K','De emergencia','68050','K','De Pared','58475','K','Otros','58476','K','Solares','68028','K'],


[4,16533,'De Automóvil','58483','K','De Emergencia','68062','K','De Pared','58484','K','Otros','58485','K','Solares','68033','K'],


[4,16534,'De Automóvil','39150','H','De Emergencia','68036','H','De Pared','39159','H','Otros','39107','H','Solares','57797','H'],


[4,16532,'De Automóvil','39258','H','De Emergencia','68037','H','De Pared','39259','H','Otros','39260','H','Solares','57798','H'],


[4,16535,'De Automóvil','39267','H','De Emergencia','68038','H','De Pared','39268','H','Otros','39269','H','Solares','57799','H'],


[4,16544,'De Automóvil','39261','K','De Emergencia','68046','K','De Pared','39262','K','Otros','39263','K','Solares','68034','K'],


[4,40734,'De Automóvil','40806','K','De Emergencia','68039','K','De Pared','40807','K','Otros','40808','K','Solares','57800','K'],


[4,16530,'De Automóvil','39264','H','De Emergencia','68040','H','De Pared','39265','H','Otros','39266','H','Solares','57801','H'],


[4,68051,'De Automóvil','68052','K','De Emergencia','68047','K','De Pared','68053','K','Otros','68054','K','Solares','68055','K'],


[4,31672,'Acrílico','57805','H','Cuero','57806','H','Otros Materiales','57787','H','Silicona','57788','H'],


[4,67993,'Acrílico','67998','H','Cuero','67999','H','Otros Materiales','68000','H','Silicona','68001','H'],


[4,48009,'Acrílico','48975','H','Cuero','48976','H','Otros Materiales','48977','H','Silicona','48978','H'],


[4,57789,'Acrílico','57790','H','Cuero','57791','H','Otros Materiales','57794','H','Silicona','57795','H'],


[4,7889,'Acrílico','48911','H','Cuero','48914','H','Otros Materiales','48910','H','Silicona','48909','H'],


[4,7905,'Acrílico','48962','H','Cuero','48963','H','Otros Materiales','48964','H','Silicona','48965','H'],


[4,7888,'Acrílico','48966','H','Cuero','48968','H','Otros Materiales','48969','H','Silicona','48970','H'],


[4,38535,'Acrílico','58284','H','Cuero','58285','H','Otros Materiales','58288','H','Silicona','58289','H'],


[4,31671,'Acrílico','57807','H','Cuero','57808','H','Otros Materiales','57809','H','Silicona','57810','H'],


[4,10156,'Acrílico','48971','H','Cuero','48972','H','Otros Materiales','48973','H','Silicona','48974','H'],


[4,6962,'HTC','67994','K','iPhone','67080','K','LG','32102','K','Motorola','31620','K','Nokia ','32667','K','Otras Marcas','31673','K','Samsung','39221','K','Sony Ericsson','31621','K'],


[4,10786,'HTC','67995','K','iPhone','67082','K','LG','32080','K','Motorola','32003','K','Nokia ','8537','K','Otras Marcas','6963','K','Samsung','39222','K','Sony Ericsson','6961','K'],


[4,12800,'HTC','67996','K','iPhone','68048','K','LG','68069','K','Motorola','32668','K','Nokia ','32669','K','Otras Marcas','32670','K','Samsung','40739','K','Sony Ericsson','32671','K'],


[4,9473,'Argentina','44188','H','Brasil','44189','H','Colombia','44219','H','Otros','44190','H','Perú','44187','H'],


[4,9468,'Brunei','44192','H','Cambodia','44191','H','China','44207','H','Myanmar','44193','H','Otros','44206','H','Singapur','44205','H'],


[4,9470,'Alemania','44185','H','Austria','44184','H','Bielorusia','44213','H','Bosnia Herzegovina','44214','H','Bulgaria','44194','H','Croacia','44220','H','España','44200','H','Grecia','44221','H','Hungría','44215','H','Otros','44208','H','Polonia','44186','H','Rumania','44216','H','Rusia','44217','H','Yugoslavia','44222','H'],


[4,30111,'Congo','44209','H','Ghana','44224','H','Guinea','44201','H','Mozambique','44197','H','Nigeria','44210','H','Otros','44229','H','Zaire','44211','H','Zambia','44223','H'],


[4,30110,'Brasil','44195','H','Colombia','44225','H','Cuba','44181','H','Ecuador','44182','H','Estados Unidos','44212','H','Jamaica','44231','H','Otros','44232','H','Perú','44226','H','Venezuela','44230','H'],


[4,30106,'Alemania','44233','H','Austria','44218','H','España','44202','H','Francia','44196','H','Gran Bretaña','44198','H','Grecia','44227','H','Otros','44203','H','Rusia','44199','H'],


[4,8100,'Accesorios','72485','N','Aviones Antiguos','72002','H','Comerciales','72001','H','De Guerra','72486','H','Otros','72003','H'],


[4,10231,'Camionetas y Camiones','72492','K','De Carrera','72491','C','Deportivos','72493','K','Otros','72494','K'],


[4,36813,'1 GB','55087','K','2 GB o más','55088','K','512 MB','55089','K','Hasta 256 MB','51652','K'],


[4,36878,'1 GB','37125','K','2 GB o más','37127','K','512 MB','37130','K','Hasta 256 MB','37128','K'],


[4,50973,'1 GB','51386','K','2 GB o más','51388','K','512 MB','51390','K','Hasta 256 MB','51389','K'],


[4,36879,'1 GB','37133','K','2 GB o más','37135','K','512 MB','37138','K','Hasta 256 MB','37136','K'],


[4,36812,'1 GB','37141','K','2 GB o más','37143','K','512 MB','37146','K','Hasta 256 MB','37144','K'],


[4,16096,'11\" a 13,9\"','55090','K','15\" a 15,9\"','55091','K','16\" o más','55092','K'],


[4,16103,'11\" a 13,9\"','55102','K','15\" a 15,9\"','55086','K','16\" o más','55103','K'],


[4,16092,'11\" a 13,9\"','55077','K','15\" a 15,9\"','55078','K','16\" o más','55093','K'],


[4,5029,'Externos','40459','K','Otros','38923','K','Para PCs','38984','K','Para Portátiles','38922','K'],


[4,7371,'Externos','36842','K','Otros','39030','K','Para PCs','36876','K','Para Portátiles','39031','K'],


[4,10394,'Externos','36815','K','Otros','39022','K','Para PCs','36863','K','Para Portátiles','39023','K'],


[4,5918,'Externos','38740','K','Otros','38791','K','Para PCs','38731','K','Para Portátiles','40460','K'],


[4,4304,'1 GB','7640','K','2 GB o más','14326','K','512 MB','14329','K','Hasta 256 MB','4309','K'],


[4,9948,'1 GB','11166','K','2 GB o más','11967','K','512 MB','11128','K','Hasta 256 MB','12935','K'],


[4,55255,'1 GB','55257','K','2 GB o más','57470','K','512 MB','55260','K','Hasta 256 MB','55259','K'],


[4,4303,'1 GB','14322','H','2 GB o más','14323','K','512 MB','14325','H','Hasta 256 MB','8603','H'],


[4,4305,'1 GB','14331','K','2 GB o más','14309','K','512 MB','14313','K','Hasta 256 MB','14310','K'],


[4,37162,'1 GB','55094','K','2 GB o más','55095','K','512 MB','55096','K','Hasta 256 MB','51625','K'],


[4,37110,'1 GB','37165','K','2 GB o más','37112','K','512 MB','37149','K','Hasta 256 MB','37168','K'],


[4,50927,'1 GB','50936','K','2 GB o más','50938','K','512 MB','50940','K','Hasta 256 MB','50939','K'],


[4,54969,'1 GB','55079','K','2 GB o más','55080','K','512 MB','55081','K','Hasta 256 MB','55082','K'],


[4,37163,'1 GB','37150','K','2 GB o más','37151','K','512 MB','37154','K','Hasta 256 MB','37155','K'],


[4,5604,'17\"','10992','K','19\" ','18444','K','Hasta 15\"','10990','K'],


[4,4695,'17\"','6931','K','19\" o más','8862','K','Hasta 15\"','6964','K'],


[4,11901,'Epson','14731','K','NEC','72849','K','Optoma Technology','14728','K','Otros','14733','K','Sony','14732','K','Viewsonic','56702','K'],


[4,10321,'HP Ipaq','68145','K','Htc','68144','K','Otros','68146','K','Palm','68168','K'],


[4,11898,'Otros','72860','K','Para Hp','72859','K','Para HTC','72857','K','Para Palms','72854','K'],


[4,7636,'650','13011','K','680','30160','K','750','30152','K','Otros Modelos','13023','K'],


[4,36907,'Genius','37060','C','Logitech','37063','C','Microsoft','37066','C','Otras Marcas','37072','C'],


[4,4298,'Genius','37095','C','Logitech','37098','C','Microsoft','37101','C','Otras Marcas','37107','C'],


[4,4295,'Genius','10383','C','Logitech','10388','C','Microsoft','10387','C','Otras Marcas','10376','C'],


[4,12901,'2.1','40470','K','5.1','40469','K','Otros','40465','K'],


[4,11145,'Genius','57694','K','Logitech','57695','K','Otras Marcas','57699','K'],


[4,11109,'Genius','57652','K','Logitech','57659','K','Otras Marcas','57674','K'],


[4,9453,'11\" a 13,9\"','53804','K','14\" a 14,9\"','53923','K','15\" a 15,9\"','53924','K','16\" o más','55341','K','Hasta 10,9\"','53922','K'],


[4,13769,'11\" a 13,9\"','55342','H','14\" a 14,9\"','55343','H','15\" a 15,9\"','55344','H','16\" o más','55345','H','Hasta 10,9\"','55346','H'],


[4,54973,'11\" a 13,9\"','55347','K','14\" a 14,9\"','55348','K','15\" a 15,9\"','55349','K','16\" o más','55350','K','Hasta 10,9\"','55351','K'],


[4,9445,'11\" a 13,9\"','53871','K','14\" a 14,9\"','53872','K','15\" a 15,9\"','53846','K','16\" o más','55352','K','Hasta 10,9\"','53845','K'],


[4,13791,'11\" a 13,9\"','55353','K','14\" a 14,9\"','55354','K','15\" a 15,9\"','55355','K','16\" o más','55356','K','Hasta 10,9\"','55357','K'],


[4,13764,'11\" a 13,9\"','55358','K','14\" a 14,9\"','55359','K','15\" a 15,9\"','55360','K','16\" o más','55361','K','Hasta 10,9\"','55362','K'],


[4,7623,'11\" a 13,9\"','53870','K','14\" a 14,9\"','53809','K','15\" a 15,9\"','53810','K','16\" o más','55363','K','Hasta 10,9\"','53869','K'],


[4,16233,'11\" a 13,9\"','55364','K','14\" a 14,9\"','55365','K','15\" a 15,9\"','55366','K','16\" o más','55367','K','Hasta 10,9\"','55368','K'],


[4,51039,'11\" a 13,9\"','53830','K','14\" a 14,9\"','53831','K','15\" a 15,9\"','53927','K','16\" o más','55369','K','Hasta 10,9\"','53849','K'],


[4,13957,'11\" a 13,9\"','53921','K','15\" a 15,9\"','53913','K','16\" o más','53914','K'],


[4,16091,'11\" a 13,9\"','55097','K','15\" a 15,9\"','55085','K','16\" o más','55098','K'],


[4,13996,'11\" a 13,9\"','55099','K','15\" a 15,9\"','55100','K','16\" o más','55101','K'],


[4,51694,'11\" a 13,9\"','55370','K','14\" a 14,9\"','55371','K','15\" a 15,9\"','55372','K','16\" o más','55373','K','Hasta 10,9\"','55374','K'],


[4,52784,'11\" a 13,9\"','55375','K','14\" a 14,9\"','55376','K','15\" a 15,9\"','55377','K','16\" o más','55378','K','Hasta 10,9\"','55379','K'],


[4,54972,'11\" a 13,9\"','55380','K','14\" a 14,9\"','55381','K','15\" a 15,9\"','55382','K','16\" o más','55383','K','Hasta 10,9\"','55384','K'],


[4,51717,'11\" a 13,9\"','55385','K','14\" a 14,9\"','55386','K','15\" a 15,9\"','55387','K','16\" o más','55388','K','Hasta 10,9\"','55389','K'],


[4,51719,'11\" a 13,9\"','55390','K','14\" a 14,9\"','55391','K','15\" a 15,9\"','55392','K','16\" o más','55393','K','Hasta 10,9\"','55394','K'],


[4,51720,'11\" a 13,9\"','55395','H','14\" a 14,9\"','55396','H','15\" a 15,9\"','55397','H','16\" o más','55398','H','Hasta 10,9\"','55399','H'],


[4,51721,'11\" a 13,9\"','55400','H','14\" a 14,9\"','55401','H','15\" a 15,9\"','55402','H','16\" o más','55403','H','Hasta 10,9\"','55404','H'],


[4,51698,'11\" a 13,9\"','55405','K','14\" a 14,9\"','55406','K','15\" a 15,9\"','55407','K','16\" o más','55408','K','Hasta 10,9\"','55409','K'],


[4,51699,'11\" a 13,9\"','54064','H','14\" a 14,9\"','54025','H','15\" a 15,9\"','54085','H','16\" o más','55410','H','Hasta 10,9\"','54084','H'],


[4,51053,'11\" a 13,9\"','55106','K','14\" a 14,9\"','55104','K','15\" a 15,9\"','55083','K','16\" o más','55105','K','Hasta 10,9\"','55084','K'],


[4,52788,'11\" a 13,9\"','53727','K','14\" a 14,9\"','53728','K','15\" a 15,9\"','53729','K','16\" o más','53730','K','Hasta 10,9\"','53726','K'],


[4,53565,'11\" a 13,9\"','53796','K','14\" a 14,9\"','53797','K','15\" a 15,9\"','53732','K','16\" o más','53733','K','Hasta 10,9\"','53731','K'],


[4,51054,'11\" a 13,9\"','53735','K','14\" a 14,9\"','53736','K','15\" a 15,9\"','53769','K','16\" o más','53771','K','Hasta 10,9\"','53734','K'],


[4,51055,'11\" a 13,9\"','53737','K','14\" a 14,9\"','53738','K','15\" a 15,9\"','53739','K','16\" o más','53741','K','Hasta 10,9\"','53763','K'],


[4,51056,'11\" a 13,9\"','53773','K','14\" a 14,9\"','53742','K','15\" a 15,9\"','53743','K','16\" o más','53744','K','Hasta 10,9\"','53772','K'],


[4,51057,'11\" a 13,9\"','53781','K','14\" a 14,9\"','53782','K','15\" a 15,9\"','53799','K','16\" o más','53784','K','Hasta 10,9\"','53780','K'],


[4,51060,'11\" a 13,9\"','53785','K','14\" a 14,9\"','53787','K','15\" a 15,9\"','53789','K','16\" o más','53761','K','Hasta 10,9\"','53757','K'],


[4,51061,'11\" a 13,9\"','53786','K','14\" a 14,9\"','53788','K','15\" a 15,9\"','53790','K','16\" o más','53762','K','Hasta 10,9\"','53758','K'],


[4,13748,'11\" a 13,9\"','55411','K','14\" a 14,9\"','55412','K','15\" a 15,9\"','55413','K','16\" o más','55414','K','Hasta 10,9\"','55415','K'],


[4,13773,'11\" a 13,9\"','55416','K','14\" a 14,9\"','55417','K','15\" a 15,9\"','55418','K','16\" o más','55419','K','Hasta 10,9\"','55420','K'],


[4,54970,'11\" a 13,9\"','55421','K','14\" a 14,9\"','55422','K','15\" a 15,9\"','55423','K','16\" o más','55424','K','Hasta 10,9\"','55425','K'],


[4,10326,'11\" a 13,9\"','54365','K','14\" a 14,9\"','54366','K','15\" a 15,9\"','54266','K','16\" o más','55426','K','Hasta 10,9\"','54364','K'],


[4,13795,'11\" a 13,9\"','55427','K','14\" a 14,9\"','55428','K','15\" a 15,9\"','55429','K','16\" o más','55430','K','Hasta 10,9\"','55431','K'],


[4,10991,'11\" a 13,9\"','55432','K','14\" a 14,9\"','55433','K','15\" a 15,9\"','55434','K','16\" o más','55435','K','Hasta 10,9\"','55436','K'],


[4,7643,'11\" a 13,9\"','54262','K','14\" a 14,9\"','54363','K','15\" a 15,9\"','54263','K','16\" o más','55437','K','Hasta 10,9\"','54261','K'],


[4,16235,'11\" a 13,9\"','55438','K','14\" a 14,9\"','55439','K','15\" a 15,9\"','55440','K','16\" o más','55441','K','Hasta 10,9\"','55442','K'],


[4,51072,'11\" a 13,9\"','54368','K','14\" a 14,9\"','54324','K','15\" a 15,9\"','54325','K','16\" o más','55443','K','Hasta 10,9\"','54367','K'],


[4,16224,'11\" a 13,9\"','55444','K','14\" a 14,9\"','55445','K','15\" a 15,9\"','55446','K','16\" o más','55447','K','Hasta 10,9\"','55448','K'],


[4,13775,'11\" a 13,9\"','55449','K','14\" a 14,9\"','55450','K','15\" a 15,9\"','55451','K','16\" o más','55452','K','Hasta 10,9\"','55453','K'],


[4,54968,'11\" a 13,9\"','55454','K','14\" a 14,9\"','55455','K','15\" a 15,9\"','55456','K','16\" o más','55457','K','Hasta 10,9\"','55458','K'],


[4,6708,'11\" a 13,9\"','54413','K','14\" a 14,9\"','54414','K','15\" a 15,9\"','54388','K','16\" o más','55459','K','Hasta 10,9\"','54412','K'],


[4,13797,'11\" a 13,9\"','55460','K','14\" a 14,9\"','55461','K','15\" a 15,9\"','55462','K','16\" o más','55463','K','Hasta 10,9\"','55464','K'],


[4,10872,'11\" a 13,9\"','55465','K','14\" a 14,9\"','55466','K','15\" a 15,9\"','55467','K','16\" o más','55468','K','Hasta 10,9\"','55469','K'],


[4,6725,'11\" a 13,9\"','54383','K','14\" a 14,9\"','54384','K','15\" a 15,9\"','54385','K','16\" o más','55470','K','Hasta 10,9\"','54382','K'],


[4,16236,'11\" a 13,9\"','55471','K','14\" a 14,9\"','55472','K','15\" a 15,9\"','55473','K','16\" o más','55474','K','Hasta 10,9\"','55475','K'],


[4,50991,'11\" a 13,9\"','54244','K','14\" a 14,9\"','54417','K','15\" a 15,9\"','54418','K','16\" o más','55476','K','Hasta 10,9\"','54243','K'],


[4,13750,'11\" a 13,9\"','55477','K','14\" a 14,9\"','55478','K','15\" a 15,9\"','55479','K','16\" o más','55480','K','Hasta 10,9\"','55481','K'],


[4,13776,'11\" a 13,9\"','55482','H','14\" a 14,9\"','55483','H','15\" a 15,9\"','55484','H','16\" o más','55485','H','Hasta 10,9\"','55486','H'],


[4,54971,'11\" a 13,9\"','55487','K','14\" a 14,9\"','55488','K','15\" a 15,9\"','55489','K','16\" o más','55490','K','Hasta 10,9\"','55491','K'],


[4,11120,'11\" a 13,9\"','55492','K','14\" a 14,9\"','55493','K','15\" a 15,9\"','55494','K','16\" o más','55495','K','Hasta 10,9\"','55496','K'],


[4,13798,'11\" a 13,9\"','55497','K','14\" a 14,9\"','55498','K','15\" a 15,9\"','55499','K','16\" o más','55500','K','Hasta 10,9\"','55501','K'],


[4,13768,'11\" a 13,9\"','55502','K','14\" a 14,9\"','55503','K','15\" a 15,9\"','55504','K','16\" o más','55505','K','Hasta 10,9\"','55506','K'],


[4,16341,'11\" a 13,9\"','55507','K','14\" a 14,9\"','55508','K','15\" a 15,9\"','55509','K','16\" o más','55510','K','Hasta 10,9\"','55511','K'],


[4,40471,'11\" a 13,9\"','55512','K','14\" a 14,9\"','55513','K','15\" a 15,9\"','55514','K','16\" o más','55515','K','Hasta 10,9\"','55516','K'],


[4,51002,'11\" a 13,9\"','55517','K','14\" a 14,9\"','55518','K','15\" a 15,9\"','55519','K','16\" o más','55520','K','Hasta 10,9\"','55521','K'],


[4,16225,'11\" a 13,9\"','55647','K','14\" a 14,9\"','55648','K','15\" a 15,9\"','55649','K','16\" o más','55650','K','Hasta 10,9\"','55651','K'],


[4,13777,'11\" a 13,9\"','55612','H','14\" a 14,9\"','55613','H','15\" a 15,9\"','55614','H','16\" o más','55615','H','Hasta 10,9\"','55616','H'],


[4,55076,'11\" a 13,9\"','55617','K','14\" a 14,9\"','55618','K','15\" a 15,9\"','55619','K','16\" o más','55620','K','Hasta 10,9\"','55621','K'],


[4,6709,'11\" a 13,9\"','55622','K','14\" a 14,9\"','55623','K','15\" a 15,9\"','55624','K','16\" o más','55625','K','Hasta 10,9\"','55626','K'],


[4,13799,'11\" a 13,9\"','55627','K','14\" a 14,9\"','55628','K','15\" a 15,9\"','55629','K','16\" o más','55630','K','Hasta 10,9\"','55631','K'],


[4,10875,'11\" a 13,9\"','55632','K','14\" a 14,9\"','55633','K','15\" a 15,9\"','55634','K','16\" o más','55635','K','Hasta 10,9\"','55636','K'],


[4,7376,'11\" a 13,9\"','55637','K','14\" a 14,9\"','55638','K','15\" a 15,9\"','55639','K','16\" o más','55640','K','Hasta 10,9\"','55641','K'],


[4,16237,'11\" a 13,9\"','55652','K','14\" a 14,9\"','55653','K','15\" a 15,9\"','55654','K','16\" o más','55655','K','Hasta 10,9\"','55656','K'],


[4,13523,'11\" a 13,9\"','55642','K','14\" a 14,9\"','55643','K','15\" a 15,9\"','55644','K','16\" o más','55645','K','Hasta 10,9\"','55646','K'],


[4,13751,'11\" a 13,9\"','55522','K','14\" a 14,9\"','55523','K','15\" a 15,9\"','55524','K','16\" o más','55525','K','Hasta 10,9\"','55526','K'],


[4,13778,'11\" a 13,9\"','55527','H','14\" a 14,9\"','55528','H','15\" a 15,9\"','55529','H','16\" o más','55530','H','Hasta 10,9\"','55531','H'],


[4,54967,'11\" a 13,9\"','55532','K','14\" a 14,9\"','55533','K','15\" a 15,9\"','55534','K','16\" o más','55535','K','Hasta 10,9\"','55536','K'],


[4,13740,'11\" a 13,9\"','55537','K','14\" a 14,9\"','55538','K','15\" a 15,9\"','55539','K','16\" o más','55540','K','Hasta 10,9\"','55541','K'],


[4,13800,'11\" a 13,9\"','55542','K','14\" a 14,9\"','55543','K','15\" a 15,9\"','55544','K','16\" o más','55545','K','Hasta 10,9\"','55546','K'],


[4,10882,'11\" a 13,9\"','55547','K','14\" a 14,9\"','55548','K','15\" a 15,9\"','55549','K','16\" o más','55550','K','Hasta 10,9\"','55551','K'],


[4,9610,'11\" a 13,9\"','55552','K','14\" a 14,9\"','55553','K','15\" a 15,9\"','55554','K','16\" o más','55555','K','Hasta 10,9\"','55556','K'],


[4,16238,'11\" a 13,9\"','55557','K','14\" a 14,9\"','55558','K','15\" a 15,9\"','55559','K','16\" o más','55560','K','Hasta 10,9\"','55561','K'],


[4,51013,'11\" a 13,9\"','55562','K','14\" a 14,9\"','55563','K','15\" a 15,9\"','55564','K','16\" o más','55565','K','Hasta 10,9\"','55566','K'],


[4,13752,'11\" a 13,9\"','55567','K','14\" a 14,9\"','55568','K','15\" a 15,9\"','55569','K','16\" o más','55570','K','Hasta 10,9\"','55571','K'],


[4,13779,'11\" a 13,9\"','55572','H','14\" a 14,9\"','55573','H','15\" a 15,9\"','55574','H','16\" o más','55575','H','Hasta 10,9\"','55576','H'],


[4,54974,'11\" a 13,9\"','55577','K','14\" a 14,9\"','55578','K','15\" a 15,9\"','55579','K','16\" o más','55580','K','Hasta 10,9\"','55581','K'],


[4,6707,'11\" a 13,9\"','55582','K','14\" a 14,9\"','55583','K','15\" a 15,9\"','55584','K','16\" o más','55585','K','Hasta 10,9\"','55586','K'],


[4,13801,'11\" a 13,9\"','55587','K','14\" a 14,9\"','55588','K','15\" a 15,9\"','55589','K','16\" o más','55590','K','Hasta 10,9\"','55591','K'],


[4,10883,'11\" a 13,9\"','55592','K','14\" a 14,9\"','55593','K','15\" a 15,9\"','55594','K','16\" o más','55595','K','Hasta 10,9\"','55596','K'],


[4,6693,'11\" a 13,9\"','55597','K','14\" a 14,9\"','55598','K','15\" a 15,9\"','55599','K','16\" o más','55600','K','Hasta 10,9\"','55601','K'],


[4,16239,'11\" a 13,9\"','55602','K','14\" a 14,9\"','55603','K','15\" a 15,9\"','55604','K','16\" o más','55605','K','Hasta 10,9\"','55606','K'],


[4,51024,'11\" a 13,9\"','55607','K','14\" a 14,9\"','55608','K','15\" a 15,9\"','55609','K','16\" o más','55610','K','Hasta 10,9\"','55611','K'],


[4,6255,'256 MB','11137','C','320 MB o más','11954','C','Hasta 128 MB','11171','C'],


[4,5483,'256 MB','24526','C','320 MB o más','38999','C','Hasta 128 MB','24522','C'],


[4,9275,'256 MB','11121','C','320 MB o más','11190','C','Hasta 128 MB','11158','C'],


[4,40985,'E - Everyone','43860','K','M - Mature','43861','K','Otros','43862','K','T - Teen','43863','K'],


[4,43723,'E - Everyone','43729','K','M - Mature','43725','K','Otros','43724','K','T - Teen','43735','K'],


[4,40975,'E - Everyone','43864','K','M - Mature','43865','K','Otros','43866','K','T - Teen','43867','K'],


[4,40976,'E - Everyone','43868','K','M - Mature','43869','K','Otros','43870','K','T - Teen','43871','K'],


[4,43728,'E - Everyone','43730','H','M - Mature','43731','H','Otros','43736','H','T - Teen','43737','H'],


[4,43732,'E - Everyone','43851','H','M - Mature','43852','H','Otros','43853','H','T - Teen','43854','H'],


[4,43733,'E - Everyone','43855','H','M - Mature','43856','H','Otros','43857','H','T - Teen','43858','H'],


[4,18071,'E - Everyone','43149','K','M - Mature','43203','K','Otros','43204','K','T - Teen','43199','K'],


[4,18073,'E - Everyone','43506','K','M - Mature','43507','K','Otros','43508','K','T - Teen','43509','K'],


[4,18072,'E - Everyone','43510','K','M - Mature','43511','K','Otros','43512','K','T - Teen','43513','K'],


[4,42442,'E - Everyone','42465','K','M - Mature','42477','K','Otros','42443','K','T - Teen','42444','K'],


[4,42445,'E - Everyone','43260','K','M - Mature','43261','K','Otros','43262','K','T - Teen','43263','K'],


[4,42466,'E - Everyone','43787','K','M - Mature','43788','K','Otros','43789','K','T - Teen','43790','K'],


[4,43180,'E - Everyone','43200','K','M - Mature','43142','H','Otros','43143','H','T - Teen','43162','H'],


[4,18070,'E - Everyone','43466','K','M - Mature','43467','K','Otros','43457','K','T - Teen','43461','K'],


[4,18067,'E - Everyone','43768','K','M - Mature','43471','K','Otros','43472','K','T - Teen','43769','K'],


[4,18079,'E - Everyone','43770','K','M - Mature','43475','K','Otros','43476','K','T - Teen','43477','K'],


[4,43740,'E - Everyone','43738','K','M - Mature','43739','K','Otros','43734','K','T - Teen','43726','K'],


[4,43727,'E - Everyone','43897','K','M - Mature','43898','K','Otros','43899','K','T - Teen','43900','K'],


[4,43741,'E - Everyone','43901','K','M - Mature','43902','K','Otros','43903','K','T - Teen','43904','K'],


[4,10869,'E - Everyone','43187','K','M - Mature','43176','K','Otros','43194','K','T - Teen','43193','K'],


[4,10874,'E - Everyone','43633','K','M - Mature','43636','K','Otros','43634','K','T - Teen','43635','K'],


[4,10887,'E - Everyone','43764','K','M - Mature','43765','K','Otros','43766','K','T - Teen','43767','K'],


[4,50201,'Canon','59404','K','Casio','70230','K','Kodak','59402','K','Nikon','59403','K','Olympus','70231','K','Otras Marcas','59406','K','Panasonic','59405','K','Sony','59401','K'],


[4,40948,'6\"','4643','K','6\" x 9\"','4644','K','Combos','7601','K','Otros','44930','K'],


[4,44932,'6\"','44935','K','6\" x 9\"','9804','K','Combos','44933','K','Otros','44923','K'],


[4,40947,'6\"','7424','K','6\" x 9\"','8353','K','Combos','44934','K','Otros','7267','K'],


[4,3978,'2.1','40467','K','5.1','40472','K','Otros','40466','K'],


[4,23035,'eTrex','40972','K','Forerunner','59302','K','Gpsmap 60','40964','K','Nüvi','49521','K','Otros','40967','K'],


[4,8841,'Otros','40970','H','Para nano','40966','H','Para touch y iPhone','44909','H','Para video','40969','H'],


[4,31591,'120 GB','51770','K','160 GB','31594','K','80 GB','31592','K'],


[4,14546,'4 GB','16288','K','6 GB','16280','K'],


[4,8826,'1 GB','16297','K','16 GB','51818','K','2 GB','16291','K','4 GB','16292','K','8 GB','16272','K'],


[4,8827,'1 GB','16278','K','2 GB','44888','K','512 MB','16277','K'],


[4,32320,'16 GB','32614','K','32 GB','43718','K','8 GB','32321','K'],


[4,10977,'30 GB','11892','K','60 GB','11896','K','80 GB','11886','K'],


[4,14547,'10 GB','16281','K','15 GB','16290','K','20 GB','16275','K','30 GB','16305','K','40 GB','16298','K','5 GB','16299','K','60 GB','16289','K'],


[4,57927,'HP Ipaq','72851','K','HTC','72850','K','Otros','72852','K','Palm','72853','K'],


[4,11905,'Otros','72861','K','Para HP','72856','K','Para HTC','72858','K','Para Palms','72855','K'],


[4,50200,'Canon','59383','K','Casio','70254','K','Kodak','59408','K','Nikon','59409','K','Olympus','70232','K','Otras Marcas','59385','K','Panasonic','59384','K','Sony','59407','K'],


[4,8940,'Audífonos','8941','H','Baterías','49682','H','Cables','9855','H','Cargadores, Docks y Bases','8942','H','Fundas, Protectores y Forros','8943','N','iTrip y Transmisores FM','8945','H','Otros','8944','H','Parlantes','9857','H'],


[4,8947,'iPod classic','31597','C','iPod mini','16284','C','iPod nano','8948','C','iPod shuffle','8949','C','iPod touch','35864','C','iPod video','10980','C','iPod y iPod photo','16293','C','Otros','8951','K'],


[4,7937,'Accesorios','72488','N','Aviones Antiguos','29962','H','Comerciales','71984','H','De Guerra','72489','H','Otros','29963','H'],


[4,6906,'Camionetas y Camiones','9478','K','De Carrera','46304','N','Deportivos','9481','K','Otros','46253','K'],


[4,6959,'Aceites','46753','H','Cremas','46755','H','Lubricantes y Geles','46754','H','Otros','46752','H','Retardantes','72114','H'],


[4,6925,'Anales','40934','H','Anillos','40961','H','Arneses','40931','H','Bombas de Vacío','40940','H','Excitadores','40939','H','Huevitos','72117','H','Jelly','41032','H','Otros','40935','H','Vaginas, Culitos y Bocas','72115','H'],


[4,3952,'Casio','6452','K','Otras Marcas','27831','K','Swatch','7110','K','Tag Heuer','48389','K','Tissot','48426','K','Tommy Hilfiger','27834','K'],


[4,3950,'Casio','8881','K','Otras Marcas','8868','K','Swatch','8875','K','Tag Heuer','48388','K','Tissot','48425','K','Tommy Hilfiger','23148','K'],


[4,3953,'Casio','27907','K','Otras Marcas','27909','K','Swatch','27911','K','Tag Heuer','48396','K','Tissot','48433','K','Tommy Hilfiger','27913','K'],


[4,27844,'Casio','27952','K','Guess','27953','K','Otras Marcas','27954','K','Swatch','27956','K','Tag Heuer','48390','K','Timex','27957','K','Tissot','48427','K','Tommy Hilfiger','27958','K'],


[4,4480,'Casio','8213','K','Guess','27830','K','Otras Marcas','5152','K','Swatch','27829','K','Tag Heuer','48393','K','Timex','5129','K','Tissot','48430','K','Tommy Hilfiger','27842','K'],


[4,27845,'Casio','27959','K','Guess','27960','K','Otras Marcas','27961','K','Swatch','27963','K','Tag Heuer','48397','K','Timex','27964','K','Tissot','48434','K','Tommy Hilfiger','27965','K'],


[4,3956,'Casio','27914','K','Otras Marcas','27916','K','Swatch','27918','K','Tag Heuer','48391','K','Tissot','48428','K','Tommy Hilfiger','27920','K'],


[4,3954,'Casio','9307','K','Otras Marcas','9309','K','Swatch','24473','K','Tag Heuer','48394','K','Tissot','48431','K','Tommy Hilfiger','24477','K'],


[4,3957,'Casio','27921','K','Otras Marcas','27923','K','Swatch','27925','K','Tag Heuer','48398','K','Tissot','48435','K','Tommy Hilfiger','27927','K'],


[4,27928,'Casio','27929','K','Otras Marcas','27931','K','Swatch','27933','K','Tag Heuer','48392','K','Tissot','48429','K','Tommy Hilfiger','27935','K'],


[4,27936,'Casio','27937','K','Otras Marcas','27939','K','Swatch','27941','K','Tag Heuer','48395','K','Tissot','48432','K','Tommy Hilfiger','27943','K'],


[4,27944,'Casio','27945','K','Otras Marcas','27947','K','Swatch','27949','K','Tag Heuer','48399','K','Tissot','48436','K','Tommy Hilfiger','27951','K'],


[4,62550,'Adidas','7442','K','Circa','62545','K','Converse','18165','K','Diesel','18332','K','Fila','26534','K','New Balance','62533','K','Nike','7438','K','Otras Marcas','7441','K','Puma','7439','K','Reebok','62544','K'],


[4,62534,'Adidas','62611','K','Circa','62604','K','Converse','62612','K','Diesel','62613','K','Fila','62632','K','New Balance','62600','K','Nike','62614','K','Otras Marcas','62605','K','Puma','62633','K','Reebok','62603','K','Vans','62615','K'],


[4,62546,'Adidas','62634','K','Circa','62595','K','Converse','62618','K','Diesel','62588','K','Fila','62591','K','New Balance','62594','K','Nike','62627','K','Otras Marcas','62635','K','Puma','62628','K','Reebok','62593','K','Vans','62592','K'],


[4,6860,'Adidas','62596','K','Circa','62619','K','Converse','62622','K','Diesel','62609','K','Fila','62597','K','New Balance','62616','K','Nike','62598','K','Otras Marcas','62617','K','Puma','62599','K','Reebok','62624','K','Vans','62606','K'],


[5,72485,'Accesorios y Repuestos','71995','H','Motores','71994','H','Radios','71993','H'],


[5,72491,'Ferrari','72495','K','Ford','72496','K','Honda','72497','K','Otros','72499','K'],


[5,37060,'Con Cable','37061','K','Inalámbricos','37062','K'],


[5,37063,'Con Cable','37064','K','Inalámbricos','37065','K'],


[5,37066,'Con Cable','37067','K','Inalámbricos','37068','K'],


[5,37072,'Con Cable','37073','K','Inalámbricos','37074','K'],


[5,37095,'Con Cable','37096','K','Inalámbricos','37097','K'],


[5,37098,'Con Cable','37099','K','Inalámbricos','37100','K'],


[5,37101,'Con Cable','37102','K','Inalámbricos','37103','K'],


[5,37107,'Con Cable','37108','K','Inalámbricos','37109','K'],


[5,10383,'Con Cable','36859','K','Inalámbricos','36904','K'],


[5,10388,'Con Cable','37079','K','Inalámbricos','37080','K'],


[5,10387,'Con Cable','37081','K','Inalámbricos','37082','K'],


[5,10376,'Con Cable','37087','K','Inalámbricos','37088','K'],


[5,11137,'ATI','24566','K','NVIDIA','24567','K','Otras Marcas','24568','K'],


[5,11954,'ATI','24557','K','NVIDIA','24558','K','Otras Marcas','39167','K'],


[5,11171,'ATI','24569','K','NVIDIA','24570','K','Otras Marcas','24571','K'],


[5,24526,'ATI','24527','K','NVIDIA','24528','K','Otras Marcas','39184','K'],


[5,38999,'ATI','39186','K','NVIDIA','39187','K','Otras Marcas','39188','K'],


[5,24522,'ATI','24523','K','NVIDIA','24524','K','Otras Marcas','39183','K'],


[5,11121,'ATI','24572','K','NVIDIA','24573','K','Otras Marcas','24574','K'],


[5,11190,'ATI','23792','K','NVIDIA','23606','K','Otras Marcas','23607','K'],


[5,11158,'ATI','24575','K','NVIDIA','24576','K','Otras Marcas','24577','K'],


[5,8943,'Otros','40984','H','Para nano','40968','H','Para touch y iPhone','44922','H','Para video','40983','H'],


[5,31597,'120 GB','52157','K','160 GB','32007','K','80 GB','31598','K'],


[5,16284,'4 GB','16303','K','6 GB','16287','K'],


[5,8948,'1 GB','16300','K','16 GB','52158','K','2 GB','16302','K','4 GB','16301','K','8 GB','16276','K'],


[5,8949,'1 GB','16283','K','2 GB','44924','K','512 MB','16279','K'],


[5,35864,'16 GB','35921','K','32 GB','43859','K','8 GB','35865','K'],


[5,10980,'30 GB','11906','K','60 GB','11895','K','80 GB','11888','K'],


[5,16293,'10 GB','16285','K','15 GB','16296','K','20 GB','16295','K','30 GB','16273','K','40 GB','16274','K','5 GB','16294','K','60 GB','16286','K'],


[5,72488,'Accesorios y Repuestos','29987','H','Motores','38522','H','Otros','72484','H','Radios','38454','H'],


[5,46304,'Ferrari','72500','K','Ford','72498','K','Honda','72501','K','Otros','72502','K']]

def send_categories
  @couchdb=RestClient::Resource.new "http://localhost:5984/categories"
  @root={}
  @path={}
  

  # import categories into couchdb
  @categories.each do |c|
    o={:name=>c[:name],:foreign_id=>c[:id],:name_path=>[c[:name]],:leaf=>true}
    json_o=@couchdb.post o.to_json
    new_o=JSON.parse json_o
    o[:_id]=new_o["id"]
    o[:_rev]=new_o["rev"]
    # puts id_path to doc
    o[:id_path]=[new_o["id"]]
    update_json=@couchdb[new_o["id"]].put o.to_json
    new_rev=(JSON.parse update_json)["rev"]
    o[:_rev]=new_rev
    @root[c[:id]]=o
  end

  # import subcategories into couchdb
  @subcategories.each do |c|
    depth,parent_id=c.slice! 0,2
    parent_id=parent_id.to_s
    n=c.length/3
    n.times do |t|
      name, foreign_id, letter=c.slice! 0,3

      # if parent does not exist, create it
      unless @root[parent_id]
        # parent_id as name cause there's not given name
        # for this node: works as a container
        parent_o={:name=>parent_id,:foreign_id=>parent_id,:name_path=>[parent_id],:leaf=>true}
        json_o=@couchdb.post parent_o.to_json
        new_o=JSON.parse json_o
        parent_o[:_id]=new_o["id"]
        parent_o[:_rev]=new_o["rev"]
        parent_o[:id_path]=[new_o["id"]]
        # puts id_path to doc
        update_json=@couchdb[new_o["id"]].put parent_o.to_json
        new_rev=(JSON.parse update_json)["rev"]
        parent_o[:_rev]=new_rev
        @root[parent_id]=parent_o
      end

      name_path=@root[parent_id][:name_path].clone
      name_path << name
      o={:name=>name,:foreign_id=>foreign_id,:depth=>depth,:foreign_parent_id=>parent_id.to_s, :name_path=>name_path, :leaf=>true}
      # post new category
      json_o=@couchdb.post o.to_json
      new_o=JSON.parse json_o
      o[:_id]=new_o["id"]
      o[:_rev]=new_o["rev"]
      o[:id_path]=@root[parent_id][:id_path].clone
      o[:id_path] << new_o["id"]
      # puts id_path to doc
      update_json=@couchdb[new_o["id"]].put o.to_json
      new_rev=(JSON.parse update_json)["rev"]
      o[:_rev]=new_rev
      @root[foreign_id]=o

      # updates parent's leaf to false
      if @root[parent_id][:leaf]
        @root[parent_id][:leaf]=false
        @couchdb[@root[parent_id][:_id]].put @root[parent_id].to_json
      end

    end
  end
  "fin"
end
