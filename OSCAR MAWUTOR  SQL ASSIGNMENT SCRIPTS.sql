                                                        --  SOLUTIONS TO DATA SCIENCE SQL CHALLENGE


--QUESTION 1

   SELECT COUNT(u_id) FROM users;


-- QUESTION 2

   SELECT COUNT(transfer_id) FROM transfers WHERE send_amount_currency = 'CFA'


--QUESTION 3

    SELECT COUNT(u_id) FROM transfers WHERE send_amount_currency = 'CFA'


--QUESTION 4

   SELECT COUNT(atx_id) FROM agent_transactions
   WHERE EXTRACT(YEAR FROM when_created)=2018
   GROUP BY EXTRACT(MONTH FROM when_created)


--QUESTION 5

  WITH agentwithdrawers AS
  (SELECT COUNT(agent_id) AS netwithdrawers FROM agent_transactions
  HAVING COUNT(amount)IN (SELECT COUNT(amount) FROM agent_transactions WHERE amount > -1
  AND amount !=0 HAVING COUNT(amount)>(SELECT COUNT(amount)
  FROM agent_transactions WHERE amount < 1 AND amount !=0)))
  SELECT netwithdrawers FROM agentwithdrawers


--QUESTION 6

  SELECT agents.city,
  COUNT (amount)
  FROM agent_transactions
  INNER JOIN agents
  ON agents.agent_id = agent_transactions.agent_id
  WHERE agent_transactions.when_created > current_date - interval '7 days'
  GROUP BY agents.city;


QUESTION 7

  SELECT City, Volume, Country INTO atx_volume_city_summary_with_Country
  FROM( Select agents.city AS City, agents.country AS Country, count(agent_transactions.atx_id)
  AS Volume FROM agents
  INNER JOIN agent_transactions ON agents.agent_id =agent_transactions.agent_id
  where (agent_transactions.when_created > (NOW() - INTERVAL '1 week'))
  GROUP BY agents.country,agents.city) as atx_volume_summary_with_Country;


--QUESTION 8

  SELECT w.ledger_location as "country",tn.send_amount_currency AS "kind",
  SUM(tn.send_amount_scalar) AS "volume"
  FROM transfers AS tn INNER JOIN wallets AS w ON tn.transfer_id =w.wallet_id
  WHERE tn. when_created = CURRENT_DATE-INTERVAL '1 week'
  GROUP By w.ledger_location,tn.send_amount_currency


--QUESTION 9

  SELECT COUNT(transfers.source_wallet_id)
  AS Unique_Senders,
  COUNT (transfer_id)
  AS Transactions_Count,transfers.kind
  AS Transfer_kind,wallets.ledger_location
  AS Country,
  SUM(transfers.send_amount_scalar)
  AS Volume
  FROM transfers
  INNER JOIN WALLETS
  ON transfers.source_wallet_id =
  wallets.wallet_id
  WHERE (transfers.when_created>
  (NOW()-INTERVAL '1 week'))
  GROUP BY wallets.ledger_location,
  transfers.kind;


--QUESTION 10

  SELECT source_wallet_id, send_amount_scalar FROM transfers
  WHERE send_amount_currency = 'CFA' AND (send_amount_scalar>10000000) AND (transfers.when_created > (NOW() - INTERVAL '1 month'));





