-- Test

-- SELECT CAST(AES_DECRYPT(AES_ENCRYPT('mytext','mykeystring'),'mykeystring') AS CHAR(64));

-- SELECT CAST( AES_ENCRYPT('000000', 'rfid_keysting') AS CHAR(50));
SELECT AES_ENCRYPT('000000', 'rfid_keysting');

SELECT AES_ENCRYPT('000001', 'rfid_keysting'), AES_ENCRYPT('000001', 'rfid_keysting'),
	AES_ENCRYPT('222222', 'rfid_keysting'),
    AES_ENCRYPT('000333', 'rfid_keysting'),
    AES_ENCRYPT('004444', 'rfid_keysting'),
    AES_ENCRYPT('00055', 'rfid_keysting');

SELECT AES_ENCRYPT('000002', 'rfid_keysting'),
	AES_ENCRYPT('111111', 'rfid_keysting'),
    AES_ENCRYPT('112233', 'rfid_keysting'),
    AES_ENCRYPT('112244', 'rfid_keysting'),
    AES_ENCRYPT('552233', 'rfid_keysting');



ALTER TABLE `customers` AUTO_INCREMENT = 1;

INSERT INTO Customers (Customer_Id,RFID_ID,password,e_mail,phone_number)VALUES
	(1, '16FEDA6FFC', AES_ENCRYPT('000000', 'rfid_keysting'), 'noah_1@gmail.com', '6191234567'),
	(2, '16FEDA6FFD', AES_ENCRYPT('000011', 'rfid_keysting'), 'william_2@gmail.com', '6191234568'),
	(3, '16FEDA6FFE', AES_ENCRYPT('000022', 'rfid_keysting'), 'james_3@gmail.com', '6191234569'),
	(4, '16FEDA6FFF', AES_ENCRYPT('000033', 'rfid_keysting'), 'logan_4@gmail.com', '6191234570'),
	(5, '16FEDA7000', AES_ENCRYPT('440000', 'rfid_keysting'), 'benjamin_5@gmail.com', '6191234571'),
	(6, '16FEDA7001', AES_ENCRYPT('550000', 'rfid_keysting'), 'mason_6@gmail.com', '6191234572'),
	(7, '16FEDA7002', AES_ENCRYPT('660000', 'rfid_keysting'), 'olivia_7@gmail.com', '6191234573'),
	(8, '16FEDA7003', AES_ENCRYPT('770000', 'rfid_keysting'), 'ava_8@gmail.com', '6191234574'),
	(9, '16FEDA7004', AES_ENCRYPT('880000', 'rfid_keysting'), 'isabella_9@gmail.com', '6191234575'),
	(10, '16FEDA7005', AES_ENCRYPT('990000', 'rfid_keysting'), 'sophia_10@gmail.com', '6191234576'),
	(11, '16FEDA7006', AES_ENCRYPT('111111', 'rfid_keysting'), 'mia_11@gmail.com', '6191234577'),
	(12, '16FEDA7007', AES_ENCRYPT('222222', 'rfid_keysting'), 'amelia_12@gmail.com', '6191234578')
;