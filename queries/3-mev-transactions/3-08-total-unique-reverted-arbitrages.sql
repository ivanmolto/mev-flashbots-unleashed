SELECT
  COUNT(DISTINCT(transaction_hash)) AS `# Reverted Arbitrages`
FROM
  flashbots.arbitrages
WHERE
  error = 'Reverted'