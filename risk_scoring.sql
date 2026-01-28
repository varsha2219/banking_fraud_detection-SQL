/* =====================================================
   TRANSACTION RISK SCORING
   Assign risk scores based on fraud indicators
   ===================================================== */

CREATE VIEW transaction_risk_score AS
SELECT
    bt.transaction_id,
    bt.transaction_date,
    bt.transaction_time,
    bt.transaction_amount,
    bt.transaction_location,

    ha.high_amount_flag,
    ln.late_night_flag,
    ml.multiple_location_flag,
    fa.failed_attempts_flag,

    (
        CASE WHEN ha.high_amount_flag = 1 THEN 30 ELSE 0 END +
        CASE WHEN ln.late_night_flag = 1 THEN 15 ELSE 0 END +
        CASE WHEN ml.multiple_location_flag = 1 THEN 25 ELSE 0 END +
        CASE WHEN fa.failed_attempts_flag = 1 THEN 20 ELSE 0 END
    ) AS risk_score,

    CASE
        WHEN (
            CASE WHEN ha.high_amount_flag = 1 THEN 30 ELSE 0 END +
            CASE WHEN ln.late_night_flag = 1 THEN 15 ELSE 0 END +
            CASE WHEN ml.multiple_location_flag = 1 THEN 25 ELSE 0 END +
            CASE WHEN fa.failed_attempts_flag = 1 THEN 20 ELSE 0 END
        ) >= 60 THEN 'HIGH RISK'
        WHEN (
            CASE WHEN ha.high_amount_flag = 1 THEN 30 ELSE 0 END +
            CASE WHEN ln.late_night_flag = 1 THEN 15 ELSE 0 END +
            CASE WHEN ml.multiple_location_flag = 1 THEN 25 ELSE 0 END +
            CASE WHEN fa.failed_attempts_flag = 1 THEN 20 ELSE 0 END
        ) BETWEEN 30 AND 59 THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END AS risk_category

FROM base_transactions bt
LEFT JOIN high_amount_indicator ha
    ON bt.transaction_id = ha.transaction_id
LEFT JOIN late_night_indicator ln
    ON bt.transaction_id = ln.transaction_id
LEFT JOIN multiple_location_indicator ml
    ON bt.transaction_id = ml.transaction_id
LEFT JOIN failed_attempts_indicator fa
    ON bt.transaction_id = fa.transaction_id;
