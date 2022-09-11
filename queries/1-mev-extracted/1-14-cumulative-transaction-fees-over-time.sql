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
  ),
  profit AS (
    SELECT
      date_trunc('day', block_timestamp) as day,
      SUM(gas_used * gas_price / 1e18) AS gas_fees
    FROM
      release
    GROUP BY
      1
    ORDER BY
      1 ASC
  )
SELECT
  day,
  SUM(gas_fees) OVER(
    ORDER BY
      day
  ) as `C. Tx Fees(Ξ)`
FROM
  profit
ORDER BY
  1