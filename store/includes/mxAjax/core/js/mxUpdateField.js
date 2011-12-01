mxAjax.UpdateField = Class.create();
mxAjax.UpdateField.prototype = {
  	initialize: function(options) {
    	this.setOptions(options);
    	this.setListeners();
		if (this.options.executeOnLoad == true) this.execute();
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		id: options.id ? options.id : "",
      		executeOnLoad: options.executeOnLoad ? options.executeOnLoad : false,
      		eventType: options.eventType ? options.eventType : "click",
      		parser: options.parser ? options.parser : new mxAjax.CFArrayToJSArray(),
      		handler: options.handler ? options.handler : this.handler
    	}, options || {});
  	},

  	setListeners: function() {
    	Event.observe($(this.options.source),
      		this.options.eventType,
      		this.execute.bindAsEventListener(this),
      		false);
    	eval("$(this.options.source).on"+this.options.eventType+" = function(){return false;};");
  	},

  	execute: function(e) {
    	if (this.options.preFunction != null) this.options.preFunction({id:this.options.id, source:this.options.source, target:this.options.target});
		var oParam = (this.options.paramArgs != null) ? this.options.paramArgs : this.options.paramFunction(this.options.id);

		// parse targets
    	var targetList = this.options.target.split(',');
    	var obj = this; // required because 'this' conflict with Ajax.Request
    	var setFunc = this.setField;
		var jsonObject = "";
		var results = "";
    	var aj = new Ajax.Request(oParam.getUrl(), {
      		asynchronous: true,
      		method: oParam.getHttpMethod(),
      		evalScripts: true,
      		parameters: oParam.getUrlParam(),
	  		postBody: ( (oParam.getHttpMethod() == "post") ? oParam.getPostData() : ''),
      		onSuccess: function(request) {
				var responseText = oParam.removeUnwantedDataFromRequest(request.responseText);

        		jsonObject = obj.options.parser.parse(responseText);
        		results = obj.options.parser.itemList;
        		obj.options.handler(responseText, jsonObject, {target: obj.options.target,
									  source: obj.options.source,
                                      items: results,
									  id:obj.options.id,
                                      targets: targetList});
      		},
      		onFailure: function(request) {
        		if (obj.options.errorFunction != null) 
					obj.options.errorFunction(request.responseText, {id:obj.options.id, object:"mxUpdateField"});
				else 
					mxAjax.onError(request.responseText, {id:obj.options.id, object:"mxUpdateField"});
      		},
      		onComplete: function(request) {
				if (obj.options.postFunction != null) obj.options.postFunction(oParam.removeUnwantedDataFromRequest(request.responseText), jsonObject, {id:obj.options.id, source:obj.options.source, target: obj.options.target, items: results});
      		}
    	});
	},
	
  	handler: function(response, json, options) {
    	for (var i=0; i<options.targets.length && i<options.items.length; i++) {
      		$(options.targets[i]).value = options.items[i];
    	}
  	}
};
