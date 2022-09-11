SELECT
  CONCAT(
    '<a href="https://etherscan.io/tx/',
    transaction_hash,
    '">',
    "Etherscan",
    '</a>'
  ) AS `Link`,
  a.block_timestamp AS `Block Timestamp`,
  a.type AS `Type`,
  a.gross_profit_usd AS `Gross Profit USD ($)`,
  format_number(miner_payment_usd, 2) AS `Miner Payment USD ($)`,
  a.transaction_hash AS `Transaction Hash`,
  a.gas_used AS `Gas used`
FROM
  flashbots.mev_summary a
  LEFT JOIN ethereum.transactions b ON b.hash = a.transaction_hash
WHERE
  b.success = 'true'
  OR b.success IS NULL
ORDER BY
  4 DESC
LIMIT
  5000