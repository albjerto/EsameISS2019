/*
frontend/uniboSupports/coapClientToResourceModel
*/
const coap             = require("node-coap-client").CoapClient; 
var coapAddr           = "coap://192.168.1.8:5683"	//RESOURCE ON RASPBERRY PI
//const coapAddr       = "coap://localhost:5683"
var coapResourceAddr   = coapAddr + "/fridge"
var io; // copiaggio spudorato da mqqtUtils.js

/*
coap
    .tryToConnect( coapAddr )
    .then((result ) => { //  true or error code or Error instance  
        console.log("coap connection done"); // do something with the result  
    })
    ;
*/

exports.setcoapAddr = function ( addr ){
	coapAddr = "coap://"+ addr + ":5683";
	coapResourceAddr   = coapAddr + "/fridge"
	console.log("coap coapResourceAddr  " + coapResourceAddr);
}

exports.setIoSocket = function (iosock) {
 	io    = iosock;
	console.log("coapFridge SETIOSOCKET io=" + io);
}

exports.coapGet = function (  ){
	coap
	    .request(
	         coapResourceAddr,
	        "get" /* "get" | "post" | "put" | "delete" */
 	        //[payload /* Buffer */,
	        //[options /* RequestOptions */]]
	    )
	    .then(response => { 			/* handle response */
	    	console.log("coap get done> " + response.payload );}
	     )
	    .catch(err => { /* handle error */ 
	    	console.log("coap get error> " + err );}
	    )
	    ;
	    
}//coapPut

exports.coapPut = function (  cmd ){ 
	coap
	    .request(
	        coapResourceAddr,     
	        "put" ,			                          // "get" | "post" | "put" | "delete"   
	        new Buffer(cmd)                          // payload Buffer 
 	        //[options]]							//  RequestOptions 
	    )
	    .then(response => { 			// handle response
	    	console.log("coapClientToFridge received response -> " + response.payload); //.toString();
			io.sockets.send(response.payload.toString());		
		}
	    )
	    .catch(err => { // handle error  
	    	console.log("coap put error> " + err + " for cmd=" + cmd);
		}
	    )
	    ;
	    
}//coapPut


exports.observeFridge= function(){
	coap.observe(
       coapResourceAddr,
        "put",
        response =>{ 	//callback
	    	console.log("coap event:  " + response.payload); //.toString(); TODO non credo di dover stampar il payload ma l'id
			io.sockets.send("fridge:" + response.payload);		
		},
		new Buffer("showState()")
		
    )
    .then(() => { console.log("coap: observing"+ coapResourceAddr);})
    .catch(err => { console.log("coap observ error error> " + err );})
    ;	
}




/*
const myself          = require('./coapClientToResourceModel');

function test(){
//	console.log("GET");
// 	myself.coapGet();
 	console.log("PUT");
 	myself.coapPut("w")
//	myself.coapGet();
}

test()
*/
/*
 * ========= EXPORTS =======
 */

//module.exports = coap;
