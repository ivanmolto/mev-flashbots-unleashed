WITH
  profit AS (
    SELECT
      date_trunc('day', a.block_timestamp) as day,
      SUM(a.gross_profit_usd) AS gross_profit_usd
    FROM
      flashbots.mev_summary a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
    WHERE
      a.gross_profit_usd > 0
      AND (
        b.success = 'true'
        OR b.success IS NULL
      )
    GROUP BY
      1
    ORDER BY
      1 ASC
  )
SELECT
  day,
  SUM(gross_profit_usd) OVER(
    ORDER BY
      day
  ) as `C. Gross Profit($)`
FROM
  profit
ORDER BY
  1