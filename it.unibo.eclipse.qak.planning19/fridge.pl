%====================================================================================
% fridge description   
%====================================================================================
mqttBroker("localhost", "1883").
context(ctxfridge, "localhost",  "MQTT", "0" ).
 qactor( fridgecoap, ctxfridge, "it.unibo.fridgecoap.Fridgecoap").
