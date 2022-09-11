SELECT
  date_trunc('day', block_timestamp) as day,
  SUM(a.gross_profit_usd) AS `Gross Profit ($)`
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