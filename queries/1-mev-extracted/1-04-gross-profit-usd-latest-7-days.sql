WITH
  release AS (
    SELECT
      a.block_timestamp,
      a.gross_profit_usd
    FROM
      flashbots.mev_summary a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
    WHERE
      a.block_timestamp > NOW() - interval 7 days
      AND (
        b.success = 'true'
        OR b.success IS NULL
      )
      AND a.gross_profit_usd > 0
    ORDER BY
      1 ASC
  )
SELECT
  SUM(gross_profit_usd) AS `Gross Profit USD ($)`
FROM
  release