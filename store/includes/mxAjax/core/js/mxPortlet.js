mxAjax.ExtendedPeriodicalUpdater = Class.create();
Object.extend(Object.extend(mxAjax.ExtendedPeriodicalUpdater.prototype, Ajax.PeriodicalUpdater.prototype), {
  	initialize: function(container, url, options) {
    	this.setOptions(options);
    	this.onComplete = this.options.onComplete;

    	this.frequency = (this.options.frequency || 2);
    	this.decay = (this.options.decay || 1);

    	this.updater = {};
    	this.container = container;
    	this.url = url;

    	this.start();
		
  	},
	
	onTimerEvent: function() {
		//dont allow browser to cache request.
    	var random = Math.floor(Math.random() * 10001);
    	var id = (random + "_" + new Date().getTime()).toString();
	
		//this.updater = (this.options.isHtmlResponse) ? new Ajax.Updater(this.container, this.url, this.options) : 
		this.updater = new Ajax.Request(this.url + "&" + id, this.options);
	}
});

mxAjax.Portlet = Class.create();
mxAjax.Portlet.prototype = {
	initialize: function(options) {
    	this.setOptions(options);
    	this.setListeners();
		if (this.options.executeOnLoad == true) this.execute();
    	if (this.preserveState) this.checkCookie();
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
			id: options.id ? options.id : "",
			executeOnLoad: options.executeOnLoad ? options.executeOnLoad : false,
      		eventType: options.eventType ? options.eventType : "click",
			parser: options.parser ? options.parser : new mxAjax.ParseJson(),
      		handler: options.handler ? options.handler : this.handler,
      		target: options.source+"Content",
      		close: options.source+"Close",
      		refresh: options.source+"Refresh",
      		toggle: options.source+"Size",
      		isMaximized: true,
      		expireDays: options.expireDays || "0",
      		expireHours: options.expireHours || "0",
      		expireMinutes: options.expireMinutes || "0",
      		refreshPeriod: options.refreshPeriod || null
    	}, options || {});

    	if (parseInt(this.options.expireDays) > 0
        	|| parseInt(this.options.expireHours) > 0
        	|| parseInt(this.options.expireMinutes) > 0) 
		{
      		this.preserveState = true;
      		this.options.expireDate = getExpDate(
        	parseInt(this.options.expireDays),
        	parseInt(this.options.expireHours),
        	parseInt(this.options.expireMinutes));
    	}
    	this.isAutoRefreshSet = false;
  	},

  	setListeners: function() {
    	if (this.options.imageClose) {
      		eval("$(this.options.close).on"+this.options.eventType+" = this.closePortlet.bindAsEventListener(this)");
    	}
    	if (this.options.imageRefresh) {
      		eval("$(this.options.refresh).on"+this.options.eventType+" = this.refreshPortlet.bindAsEventListener(this)");
    	}
    	if (this.options.imageMaximize && this.options.imageMinimize) {
      		eval("$(this.options.toggle).on"+this.options.eventType+" = this.togglePortlet.bindAsEventListener(this)");
    	}
  	},

  	execute: function(e) {
    	if (this.options.preFunction != null) this.options.preFunction({id:this.options.id, source:this.options.source, target:this.options.target});
		var oParam = (this.options.paramArgs != null) ? this.options.paramArgs : this.options.paramFunction(this.options.id);

		var json = null;
		var results = null;
		var responseText = "";
    	var obj = this; // required because 'this' conflict with Ajax.Request
    	if (this.options.refreshPeriod && this.isAutoRefreshSet == false) {
			// periodic updater
			var freq = this.options.refreshPeriod;
			this.ajaxPeriodicalUpdater = new mxAjax.ExtendedPeriodicalUpdater(this.options.target, oParam.getUrl(), {
				asynchronous: true,
				evalScripts: true,
				isHtmlResponse: oParam.isHtmlResponse(), 
				method: oParam.getHttpMethod(),
      			parameters: oParam.getUrlParam(),
	  			postBody: ( (oParam.getHttpMethod() == "post") ? oParam.getPostData() : ''),
				frequency: freq,
				onSuccess: function(request) {
					responseText = request.responseText;
					if (oParam.isHtmlResponse()) {
						Element.update(obj.options.target, responseText);
					} else {
						responseText = oParam.removeUnwantedDataFromRequest(responseText);
						json = obj.options.parser.parse(responseText);
						results = obj.options.parser.itemList;
					}
					obj.options.handler(responseText, json, {source: obj.options.source,
											id: obj.options.id,
											target: obj.options.target,
											items: results,
											isHtmlResponse: oParam.isHtmlResponse()});
				},
				onFailure: function(request) {
					if (obj.options.errorFunction != null) 
						obj.options.errorFunction(responseText, {id:obj.options.id, object:"mxPortlet"});
					else 
						mxAjax.onError(request.responseText, {id:obj.options.id, object:"mxPortlet"});
				},
				onComplete: function(request) {
					if (obj.options.postFunction != null) obj.options.postFunction(responseText, json, {id:obj.options.id, source:obj.options.source, target: obj.options.target});
				}
			});
      		this.isAutoRefreshSet = true;
    	} else {
      		// normal updater
			//this.ajaxUpdater = new Ajax.Updater(this.options.target, oParam.getUrl(), {
      		this.ajaxUpdater = new Ajax.Request(oParam.getUrl(), {
				asynchronous: true,
				evalScripts: true,
				method: oParam.getHttpMethod(),
      			parameters: oParam.getUrlParam(),
	  			postBody: ( (oParam.getHttpMethod() == "post") ? oParam.getPostData() : ''),
				onSuccess: function(request) {
					responseText = request.responseText;
					if (oParam.isHtmlResponse()) {
						Element.update(obj.options.target, responseText);
					} else {
						responseText = oParam.removeUnwantedDataFromRequest(responseText);
						json = obj.options.parser.parse(responseText);
						results = obj.options.parser.itemList;
					}
					obj.options.handler(responseText, json, {source: obj.options.source,
											id: obj.options.id,
											target: obj.options.target,
											items: results,
											isHtmlResponse: oParam.isHtmlResponse()});
				},
				onFailure: function(request) {
					if (obj.options.errorFunction != null) 
						obj.options.errorFunction(responseText, {id:obj.options.id, object:"mxPortlet"});
					else 
						mxAjax.onError(request.responseText, {id:obj.options.id, object:"mxPortlet"});
				},
				onComplete: function(request) {
					if (obj.options.postFunction != null) obj.options.postFunction(responseText, json, {id:obj.options.id, source:obj.options.source, target: obj.options.target});
				}
      		});
    	}
  	},

  	handler: function(response, json, options) {
		if (!options.isHtmlResponse) {
			if (options.target  != undefined) {
				Element.update(options.target, options.items);
			}
		}
  	},

	checkCookie: function() {
    	// Check cookie for save state
    	var cVal = getCookie("mxAjax.Portlet."+this.options.source);
    	if (cVal != null) {
      		if (cVal == AJAX_PORTLET_MIN) {
        		this.togglePortlet();
      		} else if (cVal == AJAX_PORTLET_CLOSE) {
        		this.closePortlet();
      		}
    	}
  	},

  	stopAutoRefresh: function() {
    	// stop auto-update if present
    	if (this.ajaxPeriodicalUpdater != null
        	&& this.options.refreshPeriod
        	&& this.isAutoRefreshSet == true) {
      	this.ajaxPeriodicalUpdater.stop();
    	}
  	},

  	startAutoRefresh: function() {
    	// stop auto-update if present
    	if (this.ajaxPeriodicalUpdater != null && this.options.refreshPeriod) {
      		this.ajaxPeriodicalUpdater.start();
    	}
  	},

  	refreshPortlet: function(e) {
    	// clear existing updater
    	this.stopAutoRefresh();
    	if (this.ajaxPeriodicalUpdater != null) {
      		this.startAutoRefresh();
    	} else {
      		this.execute();
    	}
  	},

  	closePortlet: function(e) {
    	this.stopAutoRefresh();
    	Element.remove(this.options.source);
    	// Save state in cookie
    	if (this.preserveState) {
      		setCookie("mxAjax.Portlet."+this.options.source,
        	AJAX_PORTLET_CLOSE,
        	this.options.expireDate);
    	}
  	},

  	togglePortlet: function(e) {
    	Element.toggle(this.options.target);
    	if (this.options.isMaximized) {
      		$(this.options.toggle).src = this.options.imageMaximize;
      		this.stopAutoRefresh();
    	} else {
      		$(this.options.toggle).src = this.options.imageMinimize;
      		this.startAutoRefresh();
    	}
    	this.options.isMaximized = !this.options.isMaximized;
    	// Save state in cookie
    	if (this.preserveState) {
      		setCookie("mxAjax.Portlet."+this.options.source,
        	(this.options.isMaximized == true ? AJAX_PORTLET_MAX : AJAX_PORTLET_MIN),
        	this.options.expireDate);
    	}
  	}
};