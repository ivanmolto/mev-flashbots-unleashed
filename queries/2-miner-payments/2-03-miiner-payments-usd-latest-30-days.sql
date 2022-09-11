WITH
  release AS (
    SELECT
      a.block_timestamp,
      a.miner_payment_usd
    FROM
      flashbots.mev_summary a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
    WHERE
      a.block_timestamp > NOW() - interval 30 day
      AND (
        b.success = 'true'
        OR b.success IS NULL
      )
    ORDER BY
      1 ASC
  )
SELECT
  SUM(miner_payment_usd) AS `Gross Profit USD ($)`
FROM
  release