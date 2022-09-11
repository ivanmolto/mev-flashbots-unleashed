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
  type as type,
  COUNT(DISTINCT(transaction_hash)) AS `Total Successful MEV Liquidation Txs`
FROM
  release
WHERE
  success = 'true'
  OR success IS NULL
GROUP BY
  1