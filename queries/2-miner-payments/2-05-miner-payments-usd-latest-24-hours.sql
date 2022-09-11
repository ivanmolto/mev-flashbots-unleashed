WITH
  release AS (
    SELECT
      a.block_timestamp,
      a.miner_payment_usd
    FROM
      flashbots.mev_summary a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
    WHERE
      a.block_timestamp > NOW() - interval 24 hour
      AND (
        b.success = 'true'
        OR b.success IS NULL
      )
    ORDER BY
      1 ASC
  )
SELECT
  COALESCE(SUM(miner_payment_usd), 'n/a') AS `Miner Payment USD ($)`
FROM
  release