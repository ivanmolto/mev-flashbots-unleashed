WITH
  arb AS (
    SELECT
      a.protocols AS protocols,
      a.transaction_hash AS transaction_hash,
      b.success AS success
    FROM
      flashbots.arbitrages a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
  )
SELECT
  DISTINCT(protocols) AS `Combination of Protocols`,
  COUNT(DISTINCT(transaction_hash)) AS `Unique Successful Arbitrages Txs`
FROM
  arb
WHERE
  success = 'true'
  OR success IS NULL
GROUP BY
  1
ORDER BY
  2 DESC
LIMIT
  25