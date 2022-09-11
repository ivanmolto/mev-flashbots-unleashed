SELECT
  COUNT(DISTINCT(transaction_hash)) AS `# Reverted liquidations`
FROM
  flashbots.liquidations
WHERE
  error = 'Reverted'