/* =====================================================
   FRAUD RULE 1: High Transaction Amount
   Flag transactions with unusually high amounts
   ===================================================== */

CREATE VIEW high_amount_indicator AS
SELECT
    bt.*,
    CASE
        WHEN transaction_amount >= 50000 THEN 1
        ELSE 0
    END AS high_amount_flag
FROM base_transactions bt;

/* =====================================================
   FRAUD RULE 2: Late Night Transactions
   Flag transactions between 12 AM and 5 AM
   ===================================================== */

CREATE VIEW late_night_indicator AS
SELECT
    bt.*,
    CASE
        WHEN transaction_time BETWEEN '00:00:00' AND '05:00:00'
        THEN 1
        ELSE 0
    END AS late_night_flag
FROM base_transactions bt;

/* =====================================================
   FRAUD RULE 3: Repeated Failed Attempts Before Success
   Flag success transactions preceded by 2 failures
   ===================================================== */

CREATE VIEW failed_attempts_indicator AS
SELECT
    bt.*,
    CASE
        WHEN
            SUM(
                CASE
                    WHEN transaction_status = 'FAILED' THEN 1
                    ELSE 0
                END
            ) OVER (
                PARTITION BY transaction_date, transaction_location
                ORDER BY transaction_time
                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
            ) >= 2
            AND transaction_status = 'SUCCESS'
        THEN 1
        ELSE 0
    END AS failed_attempts_flag
FROM base_transactions bt;

/* =====================================================
   FRAUD RULE 4: Multiple Location Transactions
   Flag days with transactions from more than one location
   ===================================================== */

CREATE VIEW multiple_location_indicator AS
SELECT
    bt.*,
    CASE
        WHEN loc.location_count > 1 THEN 1
        ELSE 0
    END AS multiple_location_flag
FROM base_transactions bt
JOIN (
    SELECT
        transaction_date,
        COUNT(DISTINCT transaction_location) AS location_count
    FROM base_transactions
    GROUP BY transaction_date
) loc
ON bt.transaction_date = loc.transaction_date;
