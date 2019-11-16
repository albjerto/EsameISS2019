%====================================================================================
% workinroom description   
%====================================================================================
mqttBroker("localhost", "1883").
context(ctxworkinroom, "localhost",  "MQTT", "0" ).
context(ctxdummyformind, "otherhost",  "MQTT", "0" ).
context(ctxdummyroomelements, "localhost",  "MQTT", "0" ).
 qactor( resourcemodel, ctxdummyformind, "external").
  qactor( onestepahead, ctxdummyformind, "external").
  qactor( basicrobot, ctxdummyformind, "external").
  qactor( dishwasher, ctxdummyroomelements, "external").
  qactor( pantry, ctxdummyroomelements, "external").
  qactor( proxyfridge, ctxdummyroomelements, "external").
  qactor( table, ctxdummyroomelements, "external").
  qactor( butlermind, ctxworkinroom, "it.unibo.butlermind.Butlermind").
  qactor( butlerplanexecutor, ctxworkinroom, "it.unibo.butlerplanexecutor.Butlerplanexecutor").
  qactor( workerinroom, ctxworkinroom, "it.unibo.workerinroom.Workerinroom").
