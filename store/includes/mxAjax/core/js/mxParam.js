mxAjax.Param = Class.create();
mxAjax.Param.prototype = {
  	initialize: function(_url, options) {
		this.url = _url;
		this.setOptions(options);
		this.defaultParam = "";
		this.type = "Param";
		this.htmlResponse = false;
		this.callList = Array();
  	},

  	setOptions: function(options) {
		if  ( [this.url.toLowerCase()].grep('cfc') != ""  && !(options.serverFramework) ) options.serverFramework = "cfc";
    	this.options = Object.extend({
      		httpMethod: options.httpMethod ? options.httpMethod : "get",
      		param: options.param ? options.param : '',
      		cffunction: options.cffunction ? options.cffunction : '',
      		serverFramework: options.serverFramework ? options.serverFramework : "cfm"
    		}, options || {});
    	this.options.orgParam = this.options.param;

  	},
  	
  	getParam: function() { return this.options.orgParam; },
  	setParam: function(param) {this.options.param = param},

  	addCall: function(options) {
		this.callList.push(options);
  	},

  	getUrlParam: function() {
		var urlData = "";
		if (this.getHttpMethod() == "get") {
			urlData = this.getParamDataString();
		} else {
			if (this.callList.length > 0 ) urlData = "json=true";
			if (this.options.serverFramework == "cfc") {
				urlData =  (urlData.length > 0) ? urlData+"&method=init" : "method=init";
			}
		}
		return urlData;
  	},

	getParamDataString: function()
	{
		if (this.callList.length > 0 ) {
			jsParam = JSON.stringify((this.callList.length == 1) ? this.callList[0] : {"calls":this.callList});
			//if (this.options.serverFramework == "cfc") 
				jsParam = "method=init&json=true&mxAjaxParam=" + jsParam;
		} else {
		    jsParam =  "function=" + this.options.cffunction + this.buildParameterString(this.options.param);
			if (this.defaultParam != "") jsParam = jsParam + "&" + this.defaultParam;
			//if (this.options.serverFramework == "cfc") 
				jsParam = "method=init&" + jsParam;
		}
		if (jsParam.toLowerCase().indexOf("htmlresponse=true") >= 0) this.htmlResponse = true;
		return jsParam;
	},
	
  	getPostData: function() {
		formData = this.getParamDataString();
		return formData;
  	},
	
	getUrl: function() {
		var returnUrl = this.url;
		returnUrl = returnUrl + (returnUrl.indexOf('?') > 0 ? '' : '?');
		if (this.getHttpMethod() == "post") {
			var jsParam = "";
			if (this.options.serverFramework == "cfc") {
				returnUrl = returnUrl + "method=init";
				if (this.callList.length > 0) returnUrl = returnUrl + "&json=true";
			}
		}
		if (returnUrl.toLowerCase().indexOf("htmlresponse=true") >= 0) this.htmlResponse = true;
		
		//dont allow browser to cache request.
    	// Get a unique ID for this call
    	var random = Math.floor(Math.random() * 10001);
    	var id = (random + "_" + new Date().getTime()).toString();
		returnUrl += "&" + id;
		
		return returnUrl;
	},

	setHttpMethod: function(_httpMethod) {
		this.options.httpMethod = _httpMethod;
	},

	getHttpMethod: function() {
		return this.options.httpMethod;
	},

	setDefaultParam: function(defaultParam) {
		return this.defaultParam = defaultParam;
	},

	buildParameterString: function(parameterList) {
  		var returnString = '';
  		var params = (parameterList || '').split(',');
  		if (params != null) {
    		for (var p=0; p<params.length; p++) {
      			var pair = params[p].split('=');
      			var key = pair[0];
      			var val = pair[1];
      			// if val is not null and it contains a match for a variable, then proceed
      			if (!isEmpty(val) || isString(val)) {
        			var varList = val.match( new RegExp("\\{[\\w\\.\\(\\)\\[\\]]*\\}", 'g') );
        			if (!isNull(varList)) {
          				var field = $(varList[0].substring(1, varList[0].length-1));
						switch (field.type) {
							case 'checkbox':
							case 'radio':
							case 'text':
							case 'textarea':
							case 'password':
							case 'hidden':
							case 'select-one':
							  	returnString += '&' + key + '=' + encodeURIComponent(field.value);
							  	break;
							case 'select-multiple':
							  	var fieldValue = $F(varList[0].substring(1, varList[0].length-1));
							  	for (var i=0; i<fieldValue.length; i++) {
									returnString += '&' + key + '=' + encodeURIComponent(fieldValue[i]);
							  	}
							  	break;
							default:
							  	returnString += '&' + key + '=' + encodeURIComponent(field.innerHTML);
							  	break;
          				}
        			} else {
          				// just add back the pair
          				returnString += '&' + key + '=' + encodeURIComponent(val);
        			}
      			}
    		}
		}
		return returnString;
  	},

	isHtmlResponse: function(){
		return this.htmlResponse;
	},

	removeUnwantedDataFromRequest: function(content){
		if (content.indexOf("mxajax****/") >= 0)  content = content.substring(content.indexOf("mxajax****/")+11);
		if (content.indexOf("/****mxajax") >= 0)  content = content.substring(0,content.indexOf("/****mxajax"));
		return content;
	}
};