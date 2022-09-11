WITH
  release AS (
    SELECT
      a.transaction_hash as transaction_hash,
      a.type as type,
      b.success as success
    FROM
      flashbots.mev_summary a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
  )
SELECT
  COUNT(DISTINCT(transaction_hash)) AS `Total Successful MEV Arbitrage Txs`
FROM
  release
WHERE
  type = 'arbitrage'
  AND (
    success = 'true'
    OR success IS NULL
  )