WITH
  release AS (
    SELECT
      a.block_timestamp AS block_timestamp,
      CASE
        WHEN a.gas_used = '18446744073709552000' THEN '2500000'
        ELSE a.gas_used
      END AS gas_used,
      a.gas_price as gas_price
    FROM
      flashbots.mev_summary a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
  )
SELECT
  date_trunc('quarter', block_timestamp) as quarter,
  SUM(gas_used * gas_price / 1e18) AS `Tx Fees (Ξ)`
FROM
  release
GROUP BY
  1
ORDER BY
  1 ASC