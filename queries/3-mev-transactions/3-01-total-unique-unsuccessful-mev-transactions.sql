SELECT
  COUNT(DISTINCT(a.transaction_hash)) AS `Total Unique Successful MEV Tx`
FROM
  flashbots.mev_summary a
  LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
WHERE
  b.success = 'false'