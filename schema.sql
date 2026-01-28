-- Base table storing transaction data
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    transaction_date DATE,
    transaction_time TIME,
    transaction_amount DECIMAL(10,2),
    transaction_status VARCHAR(20),
    transaction_location VARCHAR(50)
);
