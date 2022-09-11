WITH
  release AS (
    SELECT
      a.transaction_hash as transaction_hash,
      a.type,
      b.success
    FROM
      flashbots.mev_summary a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
  )
SELECT
  COUNT(DISTINCT(transaction_hash)) AS `Total MEV Txs`
FROM
  release