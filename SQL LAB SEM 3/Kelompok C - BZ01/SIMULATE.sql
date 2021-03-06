USE beEJibun
GO

-- Purchase Transaction

INSERT INTO Purchase VALUES
('PH021','ST005','VE010','2020-10-10',NULL),
('PH022','ST003','VE006','2019-05-03','2020-05-03'),
('PH023','ST003','VE010','2019-07-20','2020-07-20'),
('PH024','ST006','VE007','2018-01-04','2018-02-04'),
('PH025','ST008','VE010','2016-12-18','2016-12-20'),
('PH026','ST001','VE001','2020-09-25',NULL),
('PH027','ST007','VE008','2016-01-25',NULL),
('PH028','ST009','VE002','2020-08-15','2021-08-15'),
('PH029','ST004','VE004','2018-09-22','2020-09-15'),
('PH030','ST005','VE006','2016-04-28','2016-05-28')

INSERT INTO PurchaseDetails VALUES
('PH021','IT014',15),
('PH022','IT001',10),
('PH023','IT005',8),
('PH024','IT012',12),
('PH025','IT013',6),
('PH026','IT001',9),
('PH027','IT008',30),
('PH028','IT009',13),
('PH029','IT010',17),
('PH030','IT011',7)

-- Sales Transaction

INSERT INTO SalesTransaction VALUES
('SA021','CU008','ST010','2019-03-02'),
('SA022','CU004','ST003','2021-12-20'),
('SA023','CU003','ST006','2020-04-17'),
('SA024','CU002','ST009','2019-11-08'),
('SA025','CU008','ST001','2020-02-05'),
('SA026','CU010','ST003','2020-08-12'),
('SA027','CU007','ST002','2020-05-02'),
('SA028','CU004','ST007','2021-09-23'),
('SA029','CU003','ST008','2019-04-09'),
('SA030','CU001','ST005','2020-10-10')

INSERT INTO SalesTransactionDetails VALUES
('SA021','IT004',50),
('SA022','IT011',22),
('SA023','IT015',27),
('SA024','IT013',16),
('SA025','IT007',42),
('SA026','IT005',41),
('SA027','IT004',273),
('SA028','IT009',125),
('SA029','IT002',19),
('SA030','IT008',56)
