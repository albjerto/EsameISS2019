/*
* =====================================
* frontend/uniboSupports/mqttUtils.js
* =====================================
*/
const mqtt   = require ('mqtt');  //npm install --save mqtt
const topic  = "unibo/qak/events";

var mqttAddr = 'mqtt://localhost'
//var mqttAddr = 'mqtt://192.168.43.229'
//var mqttAddr = 'mqtt://iot.eclipse.org'

var client   = mqtt.connect(mqttAddr);
var io  ; 	//Upgrade for socketIo;
var robotModel    = "none";
var sonarModel    = "none";
var roomMapModel  = "none";
var fridgeModel = "none"; // per show contenuto del fridge sul frontend
var tableFoodModel = "none"; // per show contenuto del cibo sul tavolo sul frontend
var tableTablewareModel = "none"; // per show contenuto del tableware sul tavolo sul frontend
var dishwasherModel = "none"; // per show contenuto della dishwasher sul frontend
var pantryModel = "none"

console.log("mqtt client= " + client );

exports.setIoSocket = function ( iosock ) {
 	io    = iosock;
	console.log("mqtt SETIOSOCKET io=" + io);
}


client.on('connect', function () {
	  client.subscribe( topic );
	  console.log('client has connected successfully with ' + mqttAddr);
});

//The message usually arrives as buffer, so I had to convert it to string data type;
client.on('message', function (topic, message){
  //console.log("mqtt io="+ io );
  //msg(modelContent,event,resourcemodel,none,content(robot(state(5))),74)
  
  console.log("mqtt RECEIVES:"+ message.toString()); //if toString is not given, the message comes as buffer
   
  var msgStr          = message.toString();
  if(msgStr.indexOf("content")<0) return; 		//it is some other message sent via MQTT
  var spRobot			= msgStr.indexOf("robot");
  var spSonarRobot		= msgStr.indexOf("sonarRobot");
  var spRoomMap			= msgStr.indexOf("roomMap");
  var spFridge			= msgStr.indexOf("fridge"); // elaborazione relativa al fridge
  var spTableFood		= msgStr.indexOf("tableFood"); // elaborazione relativa al cibo sul tavolo
  var spTableTableware	= msgStr.indexOf("tableTableware"); // elaborazione relativa al tableware sul tavolo
  var spDishwasher		= msgStr.indexOf("dishwasher"); // elaborazione relativa alla dishwasher
  var spPantry			= msgStr.indexOf("pantry"); // elaborazione relativa alla dishwasher
  var spButlerFood		= msgStr.indexOf("butlerFood"); 
  var spButlerTableware	= msgStr.indexOf("butlerTableware");
   
   
  var sp1				= msgStr.indexOf("state");
  var msgStr			= msgStr.substr(sp1);
  var sp2				= msgStr.indexOf("))");
  var msg				= ""; 
  var content			= message.toString().substr(sp1,sp2+1);
	  if( spRobot > 0      ) { msg = msg + "robotState:"; robotModel   = msg+content ;   };
	  if( spSonarRobot > 0 ) { msg = msg + "sonarRobot:"; sonarModel   = msg+content ; };
	  if( spRoomMap > 0 )    { msg = msg + "roomMap:";    roomMapModel = msg+content ; };
	  if( spFridge > 0 )     { msg = msg + "fridge:";     fridgeModel  = msg+content ; }; // elaborazione relativa al fridge
	  if( spTableFood > 0 )     { msg = msg + "tableFood:";     tableFoodModel  = msg+content ; }; // elaborazione relativa al cibo sul tavolo
	  if( spTableTableware > 0 )     { msg = msg + "tableTableware:"; tableTablewareModel  = msg+content ; }; // elaborazione relativa al tableware sul tavolo
	  if( spDishwasher > 0 )     { msg = msg + "dishwasher:";     dishwasherModel  = msg+content ; }; // elaborazione relativa alla dishwasher
	  if( spPantry > 0 )     { msg = msg + "pantry:";     pantryModel  = msg+content ; };
	  if( spButlerFood > 0 )     { msg = msg + "butlerFood:";     butlerFoodModel  = msg+content ; }; 
	  if( spButlerTableware > 0 )     { msg = msg + "butlerTableware:";     butlerTablewareModel  = msg+content ; };
	  
	  msg = msg + content  ;	
	  
	  console.log("mqtt send on io.sockets| "+ msg  + " content=" + content);  
	  io.sockets.send( msg );   
});
 
exports.publish = function( msg, topic ){
	console.log('mqtt publish ' + client);
	client.publish(topic, msg);
}

exports.getrobotmodel = function(){
	return robotModel;
}
exports.getsonarrobotmodel = function(){
	return sonarModel;
}
