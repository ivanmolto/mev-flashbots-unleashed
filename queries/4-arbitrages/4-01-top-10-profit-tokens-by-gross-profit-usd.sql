WITH
  arb AS (
    SELECT
      a.profit_token_address AS profit_token_address,
      a.transaction_hash AS transaction_hash,
      b.success AS success
    FROM
      flashbots.arbitrages a
      LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
  ),
  suc AS (
    SELECT
      a.profit_token_address AS profit_token_address,
      a.transaction_hash AS transaction_hash -- b.gross_profit_usd
    FROM
      arb a -- LEFT JOIN flashbots.mev_summary b ON b.transaction_hash = a.transaction_hash
    WHERE
      success = 'true'
      OR success IS NULL
  ),
  profit AS (
    SELECT
      a.profit_token_address AS profit_token_address,
      -- a.transaction_hash AS transaction_hash,
      b.gross_profit_usd AS gross_profit_usd
    FROM
      suc a
      LEFT JOIN flashbots.mev_summary b ON b.transaction_hash = a.transaction_hash
    WHERE
      b.gross_profit_usd > 0
  ),
  tok AS (
    SELECT
      a.profit_token_address AS profit_token_address,
      a.gross_profit_usd AS gross_profit_usd,
      b.symbol AS symbol
    FROM
      profit a
      LEFT JOIN tokens.erc20 b ON b.contract_address = a.profit_token_address
  )
SELECT
  -- profit_token_address AS `Profit Token`,
  symbol AS `Profit Token Symbol`,
  SUM(gross_profit_usd) AS `Gross Profit USD($)`
FROM
  tok
GROUP BY
  1
ORDER BY
  2 DESC
LIMIT
  10