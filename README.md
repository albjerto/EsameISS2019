# buonNatali
Ancora da fare (aggiornare se ci ricordiamo altro):
- discutere su se/come realizzare la randomConsumption (renderla pluggable con un attore a sè stante che all'avvio fa un check nella kb per una regola del tipo randomConsumption(true) e trovandola si avvia per inviare un messaggio di randomConsumption al table ogni tot secondi? -> così siamo noi a configurare se vogliamo o meno la randomConsumption scrivendolo in un file prolog di cui faccio il consult all'avvio dell'attore -> attore starebbe nello stesso contesto del table e nel file roomelements.qak)
- decidere come gestire i cibi del frigo dopo la clear (se prevediamo che si possa fare <b>prepare</b> dopo <b>clear</b>, bisogna decidere se mantenere nel frigo il cibo inserito dalla clear alla fine del party o se cassare via tutto e ri-inizializzare il frigo)
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
