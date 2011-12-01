mxAjax.MessageTicker = Class.create();
mxAjax.MessageTicker.prototype = {
  	initialize: function(options) {
    	this.currMessageCtr = -1;
    	this.setOptions(options);
    	if (this.options.executeOnLoad == true) this.execute();
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		id: options.id ? options.id : "",
      		executeOnLoad: options.executeOnLoad ? options.executeOnLoad : false,
      		parser: options.parser ? options.parser : new mxAjax.CFArrayToJSKeyValueParser(),
      		messageScrollDelay: options.messageScrollDelay ? options.messageScrollDelay : 15,
      		messageDisplayIntervel: options.messageDisplayIntervel ? options.messageDisplayIntervel : 7000,
      		messageScrollCtr: options.messageScrollCtr ? options.messageScrollCtr : 1,
      		handler: options.handler ? options.handler : this.handler
    	}, options || {});
  	},

  	execute: function() {
		if (this.options.paramArgs) {
	    	if (this.options.preFunction != null) this.options.preFunction({id:this.options.id, source:this.options.source, target:this.options.target});
			var oParam = (this.options.paramArgs != null) ? this.options.paramArgs : this.options.paramFunction(this.options.id);
	
			// parse targets
	    	var obj = this; // required because 'this' conflict with Ajax.Request
			var results = "";
	    	var aj = new Ajax.Request(oParam.getUrl(), {
	      		asynchronous: true,
	      		method: oParam.getHttpMethod(),
	      		evalScripts: true,
	      		parameters: oParam.getUrlParam(),
		  		postBody: ( (oParam.getHttpMethod() == "post") ? oParam.getPostData() : ''),
	      		onSuccess: function(request) {
					var responseText = oParam.removeUnwantedDataFromRequest(request.responseText);
	        		obj.options.handler(JSON.parse(responseText), {source: obj.options.source,
										  id:obj.options.id}
										  ,obj);
  					setInterval(obj.scrollMessage.bind(obj), obj.options.messageDisplayIntervel);
	      		},
	      		onFailure: function(request) {
	        		if (obj.options.errorFunction != null) 
						obj.options.errorFunction(request.responseText, {id:obj.options.id, object:"mxDomInclude"});
					else 
						mxAjax.onError(request.responseText, {id:obj.options.id, object:"mxDomInclude"});
	      		},
	      		onComplete: function(request) {
					if (obj.options.postFunction != null) obj.options.postFunction(oParam.removeUnwantedDataFromRequest(request.responseText), {id:obj.options.id, source:obj.options.source});
	      		}
	    	});
		} else {
			setInterval(this.scrollMessage.bind(this), this.options.messageDisplayIntervel);
		}
  	},
  	
  	handler: function(response, options) {
  		var message = $(options.source);
  		for (i=0; i<response.length; i++) {
			var div = document.createElement("div");
			div.style.height = message.style.height;
			div.innerHTML = response[i];
      		message.appendChild( div );
  		}
  	},
  	
	scrollMessage: function()
	{
		var message = $(this.options.source);
		var messageScrollCtr = 0;
		var obj = this;
		
		if (this.currMessageCtr != -1) {
			for (i=0; i < message.childNodes.length; i++) {
				if (message.childNodes[i].id != undefined) {
					message.appendChild( message.removeChild(message.childNodes[i]) );
					break;
				}
			}
			
			var visibleCtr = 0;
			for (i=0; i < message.childNodes.length; i++) {
				if (message.childNodes[i].id != undefined) {
					if (visibleCtr < 2) {
						message.childNodes[i].style.visibility = "visible";
						visibleCtr = visibleCtr + 1;
					} else
						message.childNodes[i].style.visibility = "hidden";
				}
			}
		} else this.currMessageCtr =1;
		message.scrollTop = 0;
		
		var messageScrollObj=window.setInterval(
			function()
			{
				var message = $(obj.options.source);
				message.scrollTop = messageScrollCtr;
				messageScrollCtr = messageScrollCtr +  obj.options.messageScrollCtr;
				if( messageScrollCtr >= parseFloat(message.style.height) ) 
				{
					clearInterval(messageScrollObj);
					for (i=0; i < message.childNodes.length; i++) {
						if (message.childNodes[i].id != undefined) {
							message.childNodes[i].style.visibility = "hidden";
							break;
						}
					}
					TipsDelay=0;
				}
			},
		obj.options.messageScrollDelay);
	}
}