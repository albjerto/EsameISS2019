# buonNatali
Ancora da fare (aggiornare se ci ricordiamo altro):
- rendere il frigo funzionante con coap 
(
Il coap server frigo mantiene una variabile actor basic in cui alla creazione del server stesso dall'attore frigo poniamo l'attore frigo (dal codice qak gli si passa myself)
Quando il coap server frigo riceve un messaggio usa MsgUtil.kt per inviare un messaggio all'attore frigo che ha ottenuto -> quest'ultimo esegue la computazione definita nel qak ovvero una qualche solve relativa al prolog -> a questo punto basta che il coap server frigo invochi sull'attore frigo la getCurSol per ottenere il risultato della computazione effettuata dall'attore sul suo prolog -> il coap server frigo gira quindi la risposta a chi di dovere tramite protocollo coap
NB fare così implica levare i messaggi di risposta dall'attore frigo (commentarli pls)
Inoltre è da controllare che così facendo il comportamento resti invariato -> tutti i comportamenti dell'attore frigo sono attuabili in questo modo? Ricordarsi che alla peggio l'attore frigo potrebbe continuare ad inviare messaggi mqtt se si tratta di comunicazioni minime di sincronizzazione o simili con altri attori in cui non vogliamo implementare ricezione coap
)

- provare il robot fisico
- fare i test
- fare la roba nei commenti dei vari file
- rendere meno strongly coupled gli enti non intelligenti (table, dishwasher ecc) prevedendo la possibilità che diventino intelligenti? (regola prolog del tipo smart(true) che ricerco nella kb e se solved allora ricerco anche locazione dell'ente per parlargli altrimenti si svolge tutto come già è?)
