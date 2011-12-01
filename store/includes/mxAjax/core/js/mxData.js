mxAjax.Data = Class.create();
mxAjax.Data.prototype = {
  	initialize: function(options) {
		this.setOptions(options);
		this.setListeners();

		if (this.options.executeOnLoad == true) {
	  		this.execute();
		}
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
			id: options.id ? options.id : "",
			executeOnLoad: options.executeOnLoad ? options.executeOnLoad : false,
      		eventType: options.eventType ? options.eventType : "click",
      		handler: options.handler ? options.handler : this.handler
    	}, options || {});
  	},

  	setListeners: function() {
		if (this.options.source != undefined) {
			Event.observe($(this.options.source),
				this.options.eventType,
				this.execute.bindAsEventListener(this),
				false);
			eval("$(this.options.source).on"+this.options.eventType+" = function(){return false;};");
		}
  	},

  	execute: function(e) {
    	if (this.options.preFunction != null) this.options.preFunction({id:this.options.id, source:this.options.source, target:null});
		var oParam = (this.options.paramArgs != null) ? this.options.paramArgs : this.options.paramFunction(this.options.id);
	
    	var obj = this; // required because 'this' conflict with Ajax.Request
		var jsonObject = "";
    	var aj = new Ajax.Request(oParam.getUrl(), {
   			asynchronous: true,
      		method: oParam.getHttpMethod(),	
   	  		evalScripts: true,
   			parameters: oParam.getUrlParam(),
	  		postBody: ( (oParam.getHttpMethod() == "post") ? oParam.getPostData() : ''),
   			onSuccess: function(request) {
				var responseText = oParam.removeUnwantedDataFromRequest(request.responseText);
				jsonObject = JSON.parse(responseText);
        		obj.options.handler(responseText, jsonObject, {id:obj.options.id, source:obj.options.source, target:null});
			},
      		onFailure: function(request) {
        		if (obj.options.errorFunction != null) 
					obj.options.errorFunction(request.responseText, {id:obj.options.id, object:"mxData"});
				else 
					mxAjax.onError(request.responseText, {id:obj.options.id, object:"mxData"});
      		},
      		onComplete: function(request) {
				if (obj.options.postFunction != null) obj.options.postFunction(oParam.removeUnwantedDataFromRequest(request.responseText), jsonObject, {id:obj.options.id, source:obj.options.source, target:null});
      		}
 		});
  	},
  
   	handler: function(response, json, options) {
	   //does nothing
   	}
};