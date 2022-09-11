WITH
  release AS (
    SELECT
      a.block_timestamp,
      a.gross_profit_usd
    FROM
      flashbots.mev_summary a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
    WHERE
      a.gross_profit_usd > 0
      AND (
        b.success = 'true'
        OR b.success IS NULL
      )
    ORDER BY
      1 ASC
  )
SELECT
  SUM(gross_profit_usd) AS `Gross Profit USD ($)`
FROM
  release