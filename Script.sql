--Test 1
-- Создание таблицы examination
CREATE TABLE real_data.examination (
    id INTEGER PRIMARY KEY,
    scores INTEGER NOT NULL CHECK (scores >= 0 AND scores <= 100)
);

-- Заполнение таблицы данными (20 строк)
INSERT INTO real_data.examination (id, scores) VALUES
(1, 85),
(2, 92),
(3, 78),
(4, 92),  -- Дубликат баллов для проверки ранжирования
(5, 65),
(6, 88),
(7, 95),
(8, 72),
(9, 81),
(10, 92), -- Еще один с 92 баллами
(11, 77),
(12, 84),
(13, 91),
(14, 69),
(15, 100), -- Максимальный балл
(16, 45),  -- Минимальный в этом наборе
(17, 88),  -- Дубликат 88 баллов
(18, 79),
(19, 63),
(20, 74);

-- Запрос для создания колонки с позицией в рейтинге
SELECT 
    id,
    scores,
    RANK() OVER (ORDER BY scores DESC) AS position_rank,
    DENSE_RANK() OVER (ORDER BY scores DESC) AS position_dense_rank,
    ROW_NUMBER() OVER (ORDER BY scores DESC, id ASC) AS position_row_number
FROM REAL_data.examination
ORDER BY scores DESC, id ASC;

-- Альтернативный вариант с явным указанием порядковых номеров
SELECT 
    id,
    scores,
    RANK() OVER (ORDER BY scores DESC) AS rating_position
FROM real_data.examination
ORDER BY rating_position, id;

-- Версия с созданием нового столбца (если нужно сохранить в новой таблице)
CREATE TABLE examination_with_ranking AS
SELECT 
    id,
    scores,
    RANK() OVER (ORDER BY scores DESC) AS position
FROM examination
ORDER BY position, id;

-- Проверка результата
SELECT * FROM examination_with_ranking ORDER BY position, id;


-- Test 2
-- Создаем первую таблицу (30 строк)
CREATE TABLE real_data.table1 (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    value INTEGER
);

-- Создаем вторую таблицу (20 строк)
CREATE TABLE real_data.table2 (
    id INTEGER PRIMARY KEY,
    data VARCHAR(50),
    amount INTEGER
);

-- Заполняем первую таблицу (30 строк)
INSERT INTO real_data.table1 (id, name, value) VALUES
(1, 'A1', 100), 
(2, 'A2', 200), 
(3, 'A3', 300), 
(4, 'A4', 400), 
(5, 'A5', 500),
(6, 'A6', 600), 
(7, 'A7', 700), 
(8, 'A8', 800), 
(9, 'A9', 900), 
(10, 'A10', 1000),
(11, 'A11', 1100), 
(12, 'A12', 1200), 
(13, 'A13', 1300), 
(14, 'A14', 1400), 
(15, 'A15', 1500),
(16, 'A16', 1600), 
(17, 'A17', 1700), 
(18, 'A18', 1800), 
(19, 'A19', 1900), 
(20, 'A20', 2000),
(21, 'A21', 2100), 
(22, 'A22', 2200), 
(23, 'A23', 2300), 
(24, 'A24', 2400), 
(25, 'A25', 2500),
(26, 'A26', 2600), 
(27, 'A27', 2700), 
(28, 'A28', 2800), 
(29, 'A29', 2900), 
(30, 'A30', 3000);

-- Заполняем вторую таблицу (20 строк)
INSERT INTO real_data.table2 (id, data, amount) VALUES
	(1, 'B1', 10), 
	(2, 'B2', 20), 
	(3, 'B3', 30), 
	(4, 'B4', 40), 
	(5, 'B5', 50),
	(6, 'B6', 60), 
	(7, 'B7', 70), 
	(8, 'B8', 80), 
	(9, 'B9', 90), 
	(10, 'B10', 100),
	(11, 'B11', 110), 
	(12, 'B12', 120), 
	(13, 'B13', 130), 
	(14, 'B14', 140), 
	(15, 'B15', 150),
	(16, 'B16', 160), 
	(17, 'B17', 170), 
	(18, 'B18', 180), 
	(19, 'B19', 190), 
	(20, 'B20', 200);

-- Пример FULL JOIN
SELECT 
    COALESCE(t1.id, t2.id) as id,
    t1.name,
    t1.value,
    t2.data,
    t2.amount
FROM real_data.table1 t1
FULL JOIN real_data.table2 t2 ON t1.id = t2.id;

/*
Ответ: минимально 30 и максимально 50 строк.

Обоснование:
Для двух таблиц с 30 и 20 строками при операции FULL JOIN:

Максимум (50 строк): когда ключи абсолютно уникальные (нет совпадений), результат содержит все строки из обеих таблиц: 30 + 20 = 50

Минимум (30 строк): когда ключи полностью совпадают и меньшая таблица является подмножеством большей, результат содержит все строки большей таблицы: max(30, 20) = 30

Формула: количество строк = m + n - k, где:

m = 30 (строк в первой таблице)

n = 20 (строк во второй таблице)

k = количество совпадений (0 ≤ k ≤ 20)

Таким образом:

Максимум при k = 0: 30 + 20 - 0 = 50

Минимум при k = 20: 30 + 20 - 20 = 30
*/

--Test 3

-- Создаем таблицу account
CREATE TABLE real_data.account (
    id INTEGER,
    client_id INTEGER,
    open_dt DATE,
    close_dt DATE
);

-- Создаем таблицу transaction
CREATE TABLE real_data.transaction_va (
    id INTEGER,
    account_id INTEGER,
    transaction_date DATE,
    amount NUMERIC(10,2),
    type VARCHAR(3)
);

-- Заполняем таблицу account (30 строк)
INSERT INTO real_data.account (id, client_id, open_dt, close_dt) VALUES
-- Клиент 1 (4 счета)
(1, 1, '2023-01-01', NULL),
(2, 1, '2023-02-01', '2023-06-01'),
(3, 1, '2023-03-01', NULL),
(4, 1, '2023-04-01', NULL),

-- Клиент 2 (3 счета)
(5, 2, '2023-01-15', NULL),
(6, 2, '2023-02-15', '2023-05-15'),
(7, 2, '2023-03-15', NULL),

-- Клиент 3 (3 счета)
(8, 3, '2023-01-20', NULL),
(9, 3, '2023-02-20', NULL),
(10, 3, '2023-03-20', '2023-07-20'),

-- Клиент 4 (3 счета)
(11, 4, '2023-02-01', NULL),
(12, 4, '2023-03-01', NULL),
(13, 4, '2023-04-01', NULL),

-- Клиент 5 (3 счета)
(14, 5, '2023-02-10', NULL),
(15, 5, '2023-03-10', NULL),
(16, 5, '2023-04-10', NULL),

-- Клиент 6 (3 счета) - мало покупок
(17, 6, '2023-01-01', NULL),
(18, 6, '2023-02-01', NULL),
(19, 6, '2023-03-01', NULL),

-- Клиент 7 (3 счета) - много покупок
(20, 7, '2023-01-01', NULL),
(21, 7, '2023-02-01', NULL),
(22, 7, '2023-03-01', NULL),

-- Клиент 8 (3 счета) - смешанно
(23, 8, '2023-01-01', NULL),
(24, 8, '2023-02-01', NULL),
(25, 8, '2023-03-01', NULL),

-- Клиент 9 (2 счета) - нет покупок в последний месяц
(26, 9, '2023-01-01', NULL),
(27, 9, '2023-02-01', NULL),

-- Клиент 10 (3 счета) - закрытые счета
(28, 10, '2023-01-01', '2023-05-01'),
(29, 10, '2023-02-01', '2023-06-01'),
(30, 10, '2023-03-01', '2023-07-01');

-- Заполняем таблицу transaction (20 строк)
-- Транзакции за последний месяц (предположим, текущая дата 2023-07-15)
INSERT INTO real_data.transaction_va (id, account_id, transaction_date, amount, type) VALUES
-- Клиент 1: покупки на 4000 (меньше 5000)
(1, 1, '2023-07-10', 1000.00, 'PUR'),
(2, 1, '2023-07-12', 1500.00, 'PUR'),
(3, 3, '2023-07-05', 1500.00, 'PUR'),

-- Клиент 2: покупки на 6000 (больше 5000)
(4, 5, '2023-07-03', 3000.00, 'PUR'),
(5, 5, '2023-07-08', 3000.00, 'PUR'),

-- Клиент 3: покупки на 4500 (меньше 5000)
(6, 8, '2023-07-01', 2000.00, 'PUR'),
(7, 8, '2023-07-10', 2500.00, 'PUR'),

-- Клиент 4: покупки на 2000 (меньше 5000)
(8, 11, '2023-07-02', 1000.00, 'PUR'),
(9, 12, '2023-07-09', 1000.00, 'PUR'),

-- Клиент 5: покупки на 5500 (больше 5000)
(10, 14, '2023-07-04', 2500.00, 'PUR'),
(11, 15, '2023-07-11', 3000.00, 'PUR'),

-- Клиент 6: покупки на 3000 (меньше 5000)
(12, 17, '2023-07-06', 1500.00, 'PUR'),
(13, 18, '2023-07-13', 1500.00, 'PUR'),

-- Клиент 7: покупки на 7000 (больше 5000)
(14, 20, '2023-07-03', 3500.00, 'PUR'),
(15, 21, '2023-07-10', 3500.00, 'PUR'),

-- Клиент 8: покупки на 4800 (меньше 5000)
(16, 23, '2023-07-05', 2400.00, 'PUR'),
(17, 24, '2023-07-12', 2400.00, 'PUR'),

-- Клиент 9: нет покупок в последний месяц
-- (клиент должен попасть в результат, так как 0 < 5000)

-- Клиент 10: покупки на закрытых счетах (не должны учитываться)
(18, 28, '2023-07-01', 10000.00, 'PUR'), -- счет закрыт в мае
(19, 29, '2023-07-01', 10000.00, 'PUR'), -- счет закрыт в июне

-- Пополнения (не покупки) - не должны учитываться
(20, 1, '2023-07-01', 5000.00, 'DEP');

-- Решение задачи (без подзапросов и оконных функций)
SELECT 
    a.client_id
FROM real_data.account a
LEFT JOIN real_data.transaction_va t ON a.id = t.account_id 
    AND t.transaction_date >= DATE '2023-07-01'  -- последний месяц (июль)
    AND t.transaction_date <= DATE '2023-07-15'  -- текущая дата
    AND t.type = 'PUR'  -- только покупки
    AND (a.close_dt IS NULL OR a.close_dt >= t.transaction_date)  -- счет был открыт на дату транзакции
GROUP BY a.client_id
HAVING COALESCE(SUM(t.amount), 0) < 5000.00
ORDER BY a.client_id;

-- Проверочный запрос для понимания данных
SELECT 
    a.client_id,
    COUNT(DISTINCT a.id) as accounts_count,
    COUNT(t.id) as transactions_last_month,
    COALESCE(SUM(t.amount), 0) as total_purchases
FROM real_data.account a
LEFT JOIN real_data.transaction_va t ON a.id = t.account_id 
    AND t.transaction_date >= DATE '2023-07-01'
    AND t.transaction_date <= DATE '2023-07-15'
    AND t.type = 'PUR'
    AND (a.close_dt IS NULL OR a.close_dt >= t.transaction_date)
GROUP BY a.client_id
ORDER BY a.client_id;