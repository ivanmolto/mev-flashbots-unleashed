SELECT
  date_trunc('quarter', block_timestamp) as quarter,
  SUM(a.miner_payment_usd) AS `Miner Paym. ($)`
FROM
  flashbots.mev_summary a
  LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
WHERE
  b.success = 'true'
  OR b.success IS NULL
GROUP BY
  1
ORDER BY
  1 ASC