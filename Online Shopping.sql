
CREATE DATABASE IF NOT EXISTS online_store;


USE online_store;


CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('customer', 'employee') NOT NULL
);


CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    minimum_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


CREATE TABLE IF NOT EXISTS discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    discount_percentage DECIMAL(5, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


CREATE TABLE IF NOT EXISTS currencies (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_code VARCHAR(3) UNIQUE NOT NULL,
    currency_name VARCHAR(50) NOT NULL
);


CREATE TABLE IF NOT EXISTS exchange_rates (
    exchange_rate_id INT AUTO_INCREMENT PRIMARY KEY,
    base_currency_id INT NOT NULL,
    target_currency_id INT NOT NULL,
    rate DECIMAL(10, 4) NOT NULL,
    FOREIGN KEY (base_currency_id) REFERENCES currencies(currency_id),
    FOREIGN KEY (target_currency_id) REFERENCES currencies(currency_id)
);




CREATE TABLE IF NOT EXISTS sales_items (
    sale_item_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    position VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'shipped', 'delivered') NOT NULL DEFAULT 'pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS product_suppliers (
    product_id INT NOT NULL,
    supplier_id INT NOT NULL,
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

INSERT INTO users (username, password, role) VALUES 
('Aley321', 'password123', 'customer'),
('eryklft22', 'abc123', 'customer'),
('mstfmstnglu07', 'test123', 'customer'),
('brkyakkush31', 'pass456', 'customer'),
('mhmtbrkscm33', 'userpass', 'customer'),
('mestanoglumusafa', 'employeepass', 'employee'),
('secmemehmetberke', 'managerpass', 'employee'),
('kirasecme', 'staffpass', 'employee'),
('mestanking', 'adminpass', 'employee'),
('tanhduil', 'secretarypass', 'employee');

INSERT INTO products (name, price, quantity, minimum_price) VALUES 
('telephone', 1000.00, 700, 600.00),
('computer', 1900.99, 500, 1500.00),
('tablet', 490.99, 800, 300.00),
('smart watch', 90.99, 150, 80.00),
('mouse', 39.99, 800, 25.00),
('earphones', 59.99, 300, 40.00),
('keyboard', 140.99, 200, 100.00),
('Charger', 24.99, 120, 18.00),
('speaker', 34.99, 90, 28.00),
('camera', 190.99, 180, 150.00);

INSERT INTO sales (user_id, product_id, quantity, total_price) VALUES 
(1, 1, 2, 59.98),
(1, 2, 1, 19.99),
(2, 3, 5, 249.95),
(3, 4, 3, 29.97),
(3, 5, 1, 39.99),
(4, 6, 2, 119.98),
(5, 7, 4, 59.96),
(5, 8, 1, 24.99),
(5, 9, 2, 69.98),
(5, 10, 3, 59.97);

INSERT INTO discounts (product_id, discount_percentage, start_date, end_date) VALUES 
(1, 10.00, '2024-05-01', '2024-05-10'),
(3, 20.00, '2024-05-15', '2024-05-20'),
(5, 15.00, '2024-05-10', '2024-05-15'),
(7, 8.00, '2024-05-05', '2024-05-12'),
(9, 12.00, '2024-05-20', '2024-05-25'),
(2, 5.00, '2024-05-01', '2024-05-05'),
(4, 10.00, '2024-05-10', '2024-05-15'),
(6, 18.00, '2024-05-15', '2024-05-20'),
(8, 7.00, '2024-05-01', '2024-05-07'),
(10, 13.00, '2024-05-20', '2024-05-25');

INSERT INTO currencies (currency_code, currency_name) VALUES 
('USD', 'United States Dollar'),
('EUR', 'Euro'),
('GBP', 'British Pound'),
('JPY', 'Japanese Yen'),
('CAD', 'Canadian Dollar'),
('AUD', 'Australian Dollar'),
('CHF', 'Swiss Franc'),
('CNY', 'Chinese Yuan'),
('SEK', 'Swedish Krona'),
('TR', 'Turkish Lira');

INSERT INTO exchange_rates (base_currency_id, target_currency_id, rate) VALUES 
(1, 2, 0.82),
(1, 3, 0.72),
(2, 1, 1.22),
(3, 1, 1.39),
(4, 1, 0.0091),
(5, 1, 0.8),
(6, 1, 0.73),
(7, 1, 1.09),
(8, 1, 0.4),
(9, 1, 0.68);

INSERT INTO sales_items (sale_id, product_id, quantity, unit_price, total_price) VALUES 
(1, 1, 2, 29.99, 59.98),
(2, 2, 1, 19.99, 19.99),
(3, 3, 5, 49.99, 249.95),
(4, 4, 3, 9.99, 29.97),
(5, 5, 1, 39.99, 39.99),
(6, 6, 2, 59.99, 119.98),
(7, 7, 4, 14.99, 59.96),
(8, 8, 1, 24.99, 24.99),
(9, 9, 2, 34.99, 69.98),
(10, 10, 3, 19.99, 59.97);

INSERT INTO customers (user_id, full_name, email, phone_number, address) VALUES 
(1, 'Hasan Yalcın', 'hçnylcn@gmail.com', '0882679355', '123 Main St, SofiaCity, Bulgaria'),
(2, 'Hacı Eray', 'hacieray31@gmail.com', '0882669288', '456 Elm St, StudentskiGradTown, Bulgaria'),
(3, 'Kürt Aleyna', 'kürtaleynags@gmail.com', '0886788999', '789 Maple St, AstonVillage, Bulgaria'),
(4, 'Mehmet Yurdakul', 'myurdakul@gmail.com', '0889992343', '876 Oak St, Sofia, Bulgaria'),
(5, 'Mustafa Meloni', 'mustafameloni@gmail.com', '0888789888', '543 Cedar St, Sofia, Bulgaria'),
(6, 'Ceyda Sefer', 'ceydasefer@gmail.com', '0882981223', '654 Pine St,Pleven, Bulgaria'),
(7, 'Berke Secme', 'secmeborke@gmail.com', '0884567889', '432 Birch St, Kırcali, Bulgaria'),
(8, 'Tatar Ramazan', 'tatarramazan@gmail.com', '0882899887', '321 Walnut St, Plovdiv, Bulgaria'),
(9, 'James Harden', 'jamesharden@gmail.com', '0882669285', '234 Spruce St, Sofia, Bulgaria'),
(10, 'Mauro Icardi', 'vandaxicardi@gmail.com', '0882789986', '765 Fir St, Pleven, Bulgaria');

INSERT INTO employees (user_id, full_name, email, phone_number, position) VALUES 
(1, 'Kurt Aleyna', 'kürtaleyna@gmail.com', '0885468892', 'Manager'),
(2, 'Eray Kalafati', 'eraykalafati@gmail.com', '0889678899', 'Sales Representative'),
(3, 'Berkay Bee', 'beeberkay@gmail.com', '0883678990', 'Accountant'),
(4, 'General Mustafa', 'generalmustafa@gmail.com', '0888794567', 'HR Manager'),
(5, 'Jessica Martinez', 'jessicamartinez@gmail.com', '0886754563', 'Customer Service Representative'),
(6, 'Daniel Hernandez', 'danielhernandez@gmail.com', '0889765454', 'Warehouse Supervisor'),
(7, 'Sarah Lopez', 'sarahlopez@gmail.com', '0889564321', 'Marketing Coordinator'),
(8, 'Arap Berke', 'arapberke@gmail.com', '0882669285', 'IT Specialist'),
(9, 'Emily Perez', 'emilyperez@gmail.com', '0885657889', 'Assistant Manager'),
(10, 'Brian Torres', 'briantorres@gmail.com', '0884536789', 'Store Associate');

INSERT INTO orders (customer_id, total_price, status) VALUES 
(1, 79.97, 'pending'),
(2, 19.99, 'shipped'),
(3, 299.92, 'pending'),
(4, 119.91, 'delivered'),
(5, 194.94, 'pending'),
(6, 239.96, 'shipped'),
(7, 84.97, 'pending'),
(8, 94.96, 'delivered'),
(9, 149.97, 'pending'),
(10, 179.94, 'shipped');




