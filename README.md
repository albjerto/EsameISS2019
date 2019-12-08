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
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.robotMinds19/src/robotmind.qak` sia coerente con il deployment che si vuole effettuare
* controllare che all'interno del file `it.unibo.eclipse.qak.robotMinds19/basicRobotConfig.pl` sia decommentata solo la riga relativa al robot virtuale
Avviare quindi `it.unibo.eclipse.qak.robotMinds19/src/it/unibo/ctxRobotMind/MainCtxRobotMind`.
### MainCtxWorkInRoom ###
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/workinroom.qak` sia coerente con il deployment che si vuole effettuare
* controllare che nell'attore `workerinroom` siano decommentati lo `stepTime` e `pauseTime` relativi al robot virtuale
Avviare quindi `it.unibo.eclipse.qak.planning19/src/it/unibo/ctxWorkInRoom/MainCtxWorkInRoom`.
### MainCtxFridge ###
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/fridge.qak` sia coerente con il deployment che si vuole effettuare
Avviare quindi `it.unibo.eclipse.qak.planning19/src/ctxFridge/MainCtxFridge`.
### MainCtxRoomElements ###
* controllare che l'ip del broker mqtt specificato nel file `it.unibo.eclipse.qak.planning19/src/roomelements.qak` sia coerente con il deployment che si vuole effettuare
Avviare quindi `it.unibo.eclipse.qak.planning19/src/ctxRoomElements/MainCtxRoomElements`.

## Usage con robot fisico ##
