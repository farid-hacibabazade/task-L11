-- ONE-TO-ONE

CREATE TABLE students
(
    id           SERIAL PRIMARY KEY,
    full_name    VARCHAR(250),
    birth_date   DATE,
    phone_number varchar(20)
);

CREATE TABLE student_cards
(
    id            SERIAL PRIMARY KEY,
    student_id    INTEGER REFERENCES students (id),
    serial_number VARCHAR(15),
    expiry_date   DATE
);

INSERT INTO students (id, full_name, birth_date, phone_number)
VALUES (DEFAULT, 'Rubabe Eliyeva', '2006-09-15', '077-652-65-24'),
       (DEFAULT, 'Murad Osmanov', '2005-04-21', '055-144-90-11'),
       (DEFAULT, 'Eli Valiyev', '2005-08-07', '011-412-87-35'),
       (DEFAULT, 'Elman Hasanli', '2004-01-30', '050-325-87-91');

INSERT INTO student_cards (id, student_id, serial_number, expiry_date)
VALUES (DEFAULT, 1, '5463278', '2026-07-31'),
       (DEFAULT, 2, '1479652', '2025-10-30'),
       (DEFAULT, 3, '4568231', '2026-07-31'),
       (DEFAULT, 4, '6823942', '2025-07-30');



SELECT s.full_name, sc.serial_number, sc.expiry_date
FROM students s
         INNER JOIN student_cards sc ON s.id = sc.student_id;

SELECT s.full_name, s.phone_number, sc.serial_number, sc.expiry_date
FROM students s
         INNER JOIN student_cards sc on s.id = sc.student_id;


-- ONE-TO-MANY

CREATE TABLE customers
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name  VARCHAR(100),
    email      VARCHAR(100)
);

CREATE TABLE bank_cards
(
    id          SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers (id),
    card_number VARCHAR(16) UNIQUE,
    expiry_date DATE,
    cvv_number  VARCHAR(3)
);

INSERT INTO customers (id, first_name, last_name, email)
VALUES (DEFAULT, 'Abuzer', 'Emrahov', 'ab.emrahov@gmail.com'),
       (DEFAULT, 'Emin', 'Ismayilov', 'ismayilov55@gmai.com'),
       (DEFAULT, 'Leyla', 'Demirzade', 'leilademir@mail.ru'),
       (DEFAULT, 'Osman', 'Cebrayilov', 'cebi_osman@mail.ru');

INSERT INTO bank_cards (id, customer_id, card_number, expiry_date, cvv_number)
VALUES (DEFAULT, 1, '1254896523542356', '2028-01-30', '452'),
       (DEFAULT, 3, '4582365485239812', '2027-03-24', '052'),
       (DEFAULT, 2, '7458526652566651', '2025-02-17', '365'),
       (DEFAULT, 2, '4596215856685365', '2026-09-06', '475'),
       (DEFAULT, 2, '7412563358962366', '2025-05-30', '049');

SELECT c.first_name, c.last_name, bc.card_number, bc.cvv_number
FROM customers c
         INNER JOIN bank_cards bc on c.id = bc.customer_id;

SELECT c.first_name, c.last_name, bc.card_number, bc.cvv_number
FROM customers c
         LEFT JOIN bank_cards bc ON bc.customer_id = c.id;


CREATE TABLE companies
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(128),
    site  VARCHAR(128),
    email VARCHAR(128)
);

CREATE TABLE products
(
    id         BIGSERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES companies (id),
    category   TEXT,
    name       VARCHAR(128)
);

INSERT INTO companies (id, name, site, email)
VALUES (DEFAULT, 'AZERSUN HOLDING', 'azersun.com', 'info@azersun.com'),
       (DEFAULT, 'BIZIM TARLA', 'bizimtarla.az', 'info@bizimtarla.az');

INSERT INTO products (id, company_id, category, name)
VALUES (DEFAULT, 1, 'Cay', 'Beta Tea'),
       (DEFAULT, 2, 'Erzaq', 'Qarisiq turshu'),
       (DEFAULT, 1, 'Yag', 'Zeytun yagi'),
       (DEFAULT, 2, 'Erzaq', 'Zogal kompotu'),
       (DEFAULT, 2, 'Erzaq', 'Heyva murebbesi');

SELECT c.name, p.name, p.category
FROM companies c
         INNER JOIN products p on c.id = p.company_id;

-- MANY-TO-MANY

CREATE TABLE students
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(256)
);

CREATE TABLE teachers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(128),
    subject_name VARCHAR(128)
);

CREATE TABLE teacher_student
(
    id          SERIAL PRIMARY KEY,
    teacher_id  INT NOT NULL REFERENCES teachers (id),
    student_id  INT NOT NULL REFERENCES students (id),
    UNIQUE (teacher_id, student_id)
);

INSERT INTO teachers (id, name, subject_name)
VALUES (DEFAULT, 'Fatma Rzayeva', 'Riyaziyyat'),
       (DEFAULT, 'Ulviyye Memmedzade', 'Ana dili'),
       (DEFAULT, 'Emin Azimov', 'Cografiya');

INSERT INTO students (id, name)
VALUES (DEFAULT, 'Nicat Rustemzade '),
       (DEFAULT, 'Telman Suleymanov'),
       (DEFAULT, 'Agshin Aliyev'),
       (DEFAULT, 'Murad Ebulov'),
       (DEFAULT, 'Aygun Cobanova'),
       (DEFAULT, 'Nargiz Ahmedova'),
       (DEFAULT, 'Meryem Ahmedova'),
       (DEFAULT, 'Tural Qasimzade');

INSERT INTO teacher_student (id, teacher_id, student_id)
VALUES (DEFAULT, 1, 2),
       (DEFAULT, 1, 7),
       (DEFAULT, 1, 8),
       (DEFAULT, 2, 2),
       (DEFAULT, 2, 8),
       (DEFAULT, 2, 3),
       (DEFAULT, 2, 5),
       (DEFAULT, 3, 1),
       (DEFAULT, 3, 5),
       (DEFAULT, 3, 4),
       (DEFAULT, 3, 6),
       (DEFAULT, 3, 8),
       (DEFAULT, 3, 7),
       (DEFAULT, 2, 1),
       (DEFAULT, 1, 6),
       (DEFAULT, 1, 4);

SELECT t.name, s.name, t.subject_name
FROM teacher_student ts
         INNER JOIN students s on ts.student_id = s.id
         INNER JOIN teachers t on ts.teacher_id = t.id
ORDER BY t.id;








