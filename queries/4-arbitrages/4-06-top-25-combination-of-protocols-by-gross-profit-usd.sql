WITH
  arb AS (
    SELECT
      a.protocols AS protocols,
      a.transaction_hash AS transaction_hash,
      b.success AS success
    FROM
      flashbots.arbitrages a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
  ),
  suc AS (
    SELECT
      a.protocols AS protocols,
      a.transaction_hash AS transaction_hash -- b.gross_profit_usd
    FROM
      arb a -- LEFT JOIN flashbots.mev_summary b ON b.transaction_hash = a.transaction_hash
    WHERE
      success = 'true'
      OR success IS NULL
  ),
  profit AS (
    SELECT
      a.protocols AS protocols,
      -- a.transaction_hash AS transaction_hash,
      b.gross_profit_usd AS gross_profit_usd
    FROM
      suc a
      LEFT JOIN flashbots.mev_summary b ON b.transaction_hash = a.transaction_hash
    WHERE
      b.gross_profit_usd > 0
  )
SELECT
  DISTINCT(protocols) AS `Combination of Protocols`,
  SUM(gross_profit_usd) AS `Gross Profit USD($)`
FROM
  profit
GROUP BY
  1
ORDER BY
  2 DESC
LIMIT
  25