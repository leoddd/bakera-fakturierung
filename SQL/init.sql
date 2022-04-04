/*----------------------
-- Database definition --
----------------------*/
DROP DATABASE IF EXISTS bakera_fakturierung;
CREATE DATABASE bakera_fakturierung
    CHARACTER SET UTF8mb4
    COLLATE utf8mb4_bin
;

USE bakera_fakturierung;

/*----------------------
--  Table definition  --
----------------------*/
DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
    customer_id int(11) NOT NULL,

    name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    zip varchar(5) NOT NULL,
    city varchar(255) NOT NULL,

    PRIMARY KEY (customer_id)
);

DROP TABLE IF EXISTS invoice;
CREATE TABLE invoice(
    invoice_id int(11) NOT NULL,
    customer_id int(11) NOT NULL,

    order_date DATE NOT NULL,
    delivery_date DATE NOT NULL,

    vat decimal(3,2) NOT NULL,

    PRIMARY KEY (invoice_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

DROP TABLE IF EXISTS item;
CREATE TABLE item(
    item_id int(11) NOT NULL,

    name varchar(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (item_id)
);

DROP TABLE IF EXISTS invoice_item_mm;
CREATE TABLE invoice_item_mm(
    invoice_id int(11) NOT NULL,
    item_id int(11) NOT NULL,

    item_position int(11) DEFAULT 0 NOT NULL,
    item_amount int(11) DEFAULT 1 NOT NULL,

    PRIMARY KEY (invoice_id, item_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

/*----------------------
--    Mock content    --
----------------------*/
INSERT INTO customer
VALUES
    (1, "Jörgen Schuster", "Hauptstraße 123", "34266", "Niestetal")
;

INSERT INTO invoice
VALUES
    (1, 1, "2004-04-16", "2004-04-17", 0.16)
;

INSERT INTO item
VALUES
    (1, "3D Graphic Power", 98.00),
    (2, "Super Games", 34.20)
;

INSERT INTO invoice_item_mm
VALUES
    (1, 1, 1, 1),
    (1, 2, 2, 2)
;
