# Esame ISS 2019 #
Progetto relativo al tema d'esame di Ingegneria dei Sistemi Software M 2019.
Autori:
* Gioele Pisanelli
* Tommaso Liverani
* Alberto Jesu

## Usage con robot virtuale ##
Si riporta la procedura d'avvio dei vari elementi. È importante avviare sempre tutto nel seguente ordine:
* robot virtuale
* frontend
* MainCtxRobotMind
* MainCtxWorkInRoom
* MainCtxFridge
* MainCtxRoomElements
### Robot virtuale ###
Per poter eseguire l'ambiente virtuale, è prima necessario ottenere i moduli richiesti. Per far ciò:
* eseguire da terminale `npm install` al percorso `it.unibo.robots19/node/WEnv/WebGLScene`
* eseguire da terminale `npm install` al percorso `it.unibo.robots19/node/WEnv/server`

Per avviare il robot virtuale eseguire `node main 8999` alla directory `it.unibo.robots19/node/WEnv/server/src`. Il robot virtuale sarà visibile all'url `localhost:8090`.
### Frontend ###
Per poter eseguire il frontend, è prima necessario ottenere i moduli richiesti. Per far ciò:
* eseguire da terminale `npm install` alla directory `it.unibo.frontend19/nodeCode/frontend`

Per avviare il frontend eseguire eseguire `node frontendServer localhost` al percorso `it.unibo.frontend19/nodeCode/frontend`. Il frontend sarà visibile all'url `localhost:8080`.
### MainCtxRobotMind ###
* importare il progetto `it.unibo.eclipse.qak.robotMinds19`, modificare nel file `it.unibo.eclipse.qak.robotMinds19/build.gradle` il percorso relativo alle librerie col proprio, eseguire `gradle build eclipse` alla root del progetto e refresharlo
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.robotMinds19/src/robotmind.qak` sia coerente con il deployment che si vuole effettuare
* controllare che all'interno del file `it.unibo.eclipse.qak.robotMinds19/basicRobotConfig.pl` sia decommentata solo la riga relativa al robot virtuale

Avviare quindi `it.unibo.eclipse.qak.robotMinds19/src/it/unibo/ctxRobotMind/MainCtxRobotMind`.
### MainCtxWorkInRoom ###
* importare il progetto `it.unibo.eclipse.qak.planning19`, modificare nel file `it.unibo.eclipse.qak.planning19/build.gradle` il percorso relativo alle librerie col proprio, eseguire `gradle build eclipse` alla root del progetto e refresharlo
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/workinroom.qak` sia coerente con il deployment che si vuole effettuare
* controllare che nell'attore `workerinroom` siano decommentati lo `StepTime` e `PauseTime` relativi al robot virtuale

Avviare quindi `it.unibo.eclipse.qak.planning19/src/it/unibo/ctxWorkInRoom/MainCtxWorkInRoom`.
### MainCtxFridge ###
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/fridge.qak` sia coerente con il deployment che si vuole effettuare

Avviare quindi `it.unibo.eclipse.qak.planning19/src/ctxFridge/MainCtxFridge`.
### MainCtxRoomElements ###
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/roomelements.qak` sia coerente con il deployment che si vuole effettuare
* controllare che il file `it.unibo.eclipse.qak.planning19/resources/itunibo.coap.client/CoapClientControl.kt` contenga l'indirizzo del frigo secondo il deployment che si vuole effettuare

Avviare quindi `it.unibo.eclipse.qak.planning19/src/ctxRoomElements/MainCtxRoomElements`.

## Usage con robot fisico ##
Anche in questo caso, l'ordine di avvio degli elementi è:
* robot fisico
* frontend
* MainCtxRobotMind
* MainCtxWorkInRoom
* MainCtxFridge
* MainCtxRoomElements
### Robot fisico ###
Raspberry e mBot devono essere collegati ad un'adeguata sorgente di alimentazione ed accesi. Dovranno, inoltre, essere collegati uno all'altro tramite seriale.
### Frontend ###
La procedura d'avvio del frontend è identica a quella del caso d'uso con robot virtuale.
### MainCtxRobotMind ###
* controllare che l'IP del broker mqtt all'inzio del file `it.unibo.eclipse.qak.robotMinds19/src/robotmind.qak` sia coerente col deployment che si vuole effettuare
* modificare nel file `it.unibo.eclipse.qak.robotMinds19/build_ctxRobotMind` il percorso delle librerie con il proprio
* eseguire `gradle -b build_ctxRobotMind distZip` all'interno della directory `it.unibo.eclipse.qak.robotMinds19`
* spostare ed estrarre su raspberry il file `robotMind-1.0.zip` creato nella cartella `it.unibo.eclipse.qak.robotMinds19/build/distributions`
* controllare che nel file `robotMinds-1.0/bin/basicRobotSupport.pl`
  * sia decommentata unicamente la riga relativa a mBot
  * nella stessa riga, la porta descritta sia `/dev/ttyUSB0`
Si può infine eseguire `sudo bash it.unibo.eclipse.qak.robotMinds19-1.0` all'interno della directory `robotMind-1.0/bin`
### MainCtxWorkInRoom ###
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/workinroom.qak` sia coerente con il deployment che si vuole effettuare
* controllare che nell'attore `workerinroom` siano decommentati lo `StepTime` e `PauseTime` relativi al robot fisico
* modificare nel file `it.unibo.eclipse.qak.planning19/build_ctxWorkInRoom` il percorso delle librerie con il proprio
* eseguire `gradle -b build_ctxWorkInRoom distZip` all'interno di `it.unibo.eclipse.qak.planning19`
* spostare ed estrarre su raspberry il file `workInRoom-1.0.zip` creato nella cartella `it.unibo.eclipse.qak.planning19/build/distributions`
* eseguire `sudo bash it.unibo.eclipse.qak.planning19-1.0` nella cartella `workInRoom-1.0/bin`
### MainCtxFridge ###
* importare il progetto `it.unibo.eclipse.qak.planning19`, modificare nel file `it.unibo.eclipse.qak.planning19/build.gradle` il percorso relativo alle librerie col proprio, eseguire `gradle build eclipse` alla root del progetto e refresharlo
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/fridge.qak` sia coerente con il deployment che si vuole effettuare

Avviare quindi `it.unibo.eclipse.qak.planning19/src/ctxFridge/MainCtxFridge`.
### MainCtxRoomElements ###
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/roomelements.qak` sia coerente con il deployment che si vuole effettuare
* controllare che il file `it.unibo.eclipse.qak.planning19/resources/itunibo.coap.client/CoapClientControl.kt` contenga l'ip del frigo
* modificare nel file `it.unibo.eclipse.qak.planning19/build_ctxRoomElements` il percorso delle librerie con il proprio
* eseguire `gradle -b build_ctxRoomElements distZip` all'interno di `it.unibo.eclipse.qak.planning19`
* spostare ed estrarre su raspberry il file `roomElements-1.0.zip` creato nella cartella `it.unibo.eclipse.qak.planning19/build/distributions`
* eseguire `sudo bash it.unibo.eclipse.qak.planning19-1.0` nella cartella `roomElements-1.0/bin`
