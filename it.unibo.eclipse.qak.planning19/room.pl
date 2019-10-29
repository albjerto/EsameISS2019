%====================================================================================
% room description   
%====================================================================================
mqttBroker("localhost", "1883").
context(ctxroom, "localhost",  "MQTT", "0" ).
 qactor( dishwasher, ctxroom, "it.unibo.dishwasher.Dishwasher").
  qactor( pantry, ctxroom, "it.unibo.pantry.Pantry").
  qactor( table, ctxroom, "it.unibo.table.Table").
  qactor( fridge, ctxroom, "it.unibo.fridge.Fridge").
