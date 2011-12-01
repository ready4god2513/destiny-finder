mxAjax.TabPanel = Class.create();
mxAjax.TabPanel.prototype = {
	initialize: function(options) {
    	this.setOptions(options);
		this.execute();
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
			id: options.id ? options.id : "",
			executeOnLoad: options.executeOnLoad ? options.executeOnLoad : false,
      		eventType: options.eventType ? options.eventType : "click",
			parser: options.parser ? options.parser : new mxAjax.ParseJson(),
      		handler: options.handler ? options.handler : this.handler
    	}, options || {});
  	},

  	execute: function(e) {
    	if (this.options.preFunction != null) this.options.preFunction({id:this.options.id, source:this.options.source, target:this.options.target});
		var oParam = (this.options.paramArgs != null) ? this.options.paramArgs : this.options.paramFunction(this.options.id);
    	var obj = this; // required because 'this' conflict with Ajax.Request
    	//var aj = new Ajax.Updater(this.options.target, oParam.getUrl(), {

		var json = null;
		var results = null;
		var responseText = "";
		var aj = new Ajax.Request(oParam.getUrl(), {
			asynchronous: true,
      		evalScripts: true,
			method: oParam.getHttpMethod(),
      		parameters: oParam.getUrlParam(),
	  		postBody: ( (oParam.getHttpMethod() == "post") ? oParam.getPostData() : ''),
      		onSuccess: function(request) {
				var src = (obj.options.source) ? obj.options.source : document.getElementsByClassName(obj.options.currentStyleClass, $(obj.options.panelStyleId))[0];
				responseText = request.responseText;
				
				if (oParam.isHtmlResponse()) {
					Element.update(obj.options.target, responseText);
				} else {
					responseText = oParam.removeUnwantedDataFromRequest(responseText);
        			json = obj.options.parser.parse(responseText);
        			results = obj.options.parser.itemList;
				}
        		obj.options.handler(responseText, json, {source: src,
										id: obj.options.id,
										target: obj.options.target,
										items: results,
										isHtmlResponse: oParam.isHtmlResponse(), 
                                      	panelStyleId: obj.options.panelStyleId,
                                      	currentStyleClass: obj.options.currentStyleClass});
      		},
      		onFailure: function(request) {
        		if (obj.options.errorFunction != null) 
					obj.options.errorFunction(responseText, {id:obj.options.id, object:"mxTabPanel"});
				else 
					mxAjax.onError(request.responseText, {id:obj.options.id, object:"mxTabPanel"});
      		},
      		onComplete: function(request) {
				if (obj.options.postFunction != null) obj.options.postFunction(responseText, json, {id:obj.options.id, source:obj.options.source, target: obj.options.target});
      		}
    	});
  	},

  	handler: function(response, json, options) {
		if (!options.isHtmlResponse) {
			if (options.target  != undefined) {
				Element.update(options.target, options.items);
			}
		}
    	// find current anchor
    	var cur = document.getElementsByClassName(options.currentStyleClass, $(options.panelStyleId));
    	// remove class
    	cur[0].className = '';
    	// add class to selected tab
    	options.source.className = options.currentStyleClass;
  	}
};