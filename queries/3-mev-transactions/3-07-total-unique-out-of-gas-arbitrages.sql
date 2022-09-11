SELECT
  COUNT(DISTINCT(transaction_hash)) AS `# Out of gas Arbitrages`
FROM
  flashbots.arbitrages
WHERE
  error = 'Out of gas'