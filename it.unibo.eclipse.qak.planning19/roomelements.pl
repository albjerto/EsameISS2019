%====================================================================================
% roomelements description   
%====================================================================================
mqttBroker("localhost", "1883").
context(ctxroomelements, "localhost",  "MQTT", "0" ).
context(ctxdummyworkinroom, "workinroomhost",  "MQTT", "0" ).
 qactor( butlermind, ctxdummyworkinroom, "external").
  qactor( dishwasher, ctxroomelements, "it.unibo.dishwasher.Dishwasher").
  qactor( pantry, ctxroomelements, "it.unibo.pantry.Pantry").
  qactor( table, ctxroomelements, "it.unibo.table.Table").
  qactor( fridge, ctxroomelements, "it.unibo.fridge.Fridge").
  qactor( proxyfridge, ctxroomelements, "it.unibo.proxyfridge.Proxyfridge").
