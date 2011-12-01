mxAjax.Select = Class.create();
mxAjax.Select.prototype = {
	initialize: function(options) {
		this.setOptions(options);
		this.setListeners();
		if (this.options.executeOnLoad == true) this.execute();
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		id: options.id ? options.id : "",
      		executeOnLoad: options.executeOnLoad ? options.executeOnLoad : false,
      		eventType: options.eventType ? options.eventType : "change",
      		parser: options.parser ? options.parser : new mxAjax.CFArrayToJSKeyValueParser(),
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
	
    	var obj = this; // required because 'this' conflict with Ajax.Request
		var jsonObject = "";
		var results = "";
    	var aj = new Ajax.Request(oParam.getUrl(), {
      		asynchronous: true,
      		evalScripts: true,
      		method: oParam.getHttpMethod(),
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
                                      defaultOptions: obj.options.defaultOptions});
      		},
      		onFailure: function(request) {
        		if (obj.options.errorFunction != null) 
					obj.options.errorFunction(request.responseText, {id:obj.options.id, object:"mxSelect"});
				else 
					mxAjax.onError(request.responseText, {id:obj.options.id, object:"mxSelect"});
      		},
      		onComplete: function(request) {
				if (obj.options.postFunction != null) obj.options.postFunction(oParam.removeUnwantedDataFromRequest(request.responseText), jsonObject, {id:obj.options.id, source:obj.options.source, target: obj.options.target, items: results});
      		}
    	});
  	},

  	handler: function(response, json, options) {
    	// build an array of option values to be set as selected
    	var defaultSelectedValues = (options.defaultOptions || '').split(",");
    	$(options.target).options.length = 0;
    	$(options.target).disabled = false;

    	for (var i=0; i<options.items.length; i++) {
      		var newOption = new Option(options.items[i].value, options.items[i].key);
      		for (j=0; j<defaultSelectedValues.length && newOption.selected == false; j++) {
        		if (defaultSelectedValues[j] == options.items[i].key) {
          			newOption.selected = true;
        		}
      		}
      		$(options.target).options[i] = newOption;
    	}
  	}
};