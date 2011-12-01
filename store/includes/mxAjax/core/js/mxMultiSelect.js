mxAjax.MultiSelect = Class.create();
mxAjax.MultiSelect.prototype = {
  	initialize: function(options) {
    	this.setOptions(options);
    	this.container;
    	this.setListeners();
    	this.controlCreated = false;
    	if (this.options.executeOnLoad == true) this.execute();
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		id: options.id ? options.id : "",
      		source: options.source ? options.source : "",
      		executeOnLoad: options.executeOnLoad ? options.executeOnLoad : false,
      		eventType: options.eventType ? options.eventType : "change",
      		handler: options.handler ? options.handler : this.handler
    	}, options || {});
  	},
  	
  	setListeners: function() {
		if (this.options.source != "") {
	    	Event.observe($(this.options.source),
	      		this.options.eventType,
	      		this.execute.bindAsEventListener(this),
	      		false);
	    	eval("$(this.options.source).on"+this.options.eventType+" = function(){return false;};");
	    }
  	},
  	
  	execute: function(e) {
  		var target = $(this.options.target);
  		var obj = this;
  		var container = document.createElement("div");
  		Element.addClassName(container, this.options.cssClass);
		if (this.options.control && !this.controlCreated) 
		{
			if (this.options.selectAllActionControl) 
			{
				var link1 = $(this.options.selectAllActionControl);
		  		eval("link1.onclick=function(){obj.selectAll(obj)};");

				var link2 = $(this.options.clearAllActionControl);
		  		eval("link2.onclick=function(){obj.clearAll(obj)};");
			} 
			else 
			{
		  		var control = $(this.options.control);
		  		control.appendChild(this.createSpan("["));
		  		link1 = this.createHrefLink("Select All");
		  		eval("link1.onclick=function(){obj.selectAll(obj)};");
		  		control.appendChild(link1);
		  		control.appendChild(this.createSpan("]"));
		
		  		control.appendChild(this.createSpan("&nbsp;&nbsp;&nbsp;"));
		
		  		control.appendChild(this.createSpan("["));
		  		link2 = this.createHrefLink("Clear All");
		  		eval("link2.onclick=function(){obj.clearAll(obj)};");
		  		control.appendChild(link2);
		  		control.appendChild(this.createSpan("]"));
		  	}
		  	this.controlCreated = true;
	  	}

		if (this.options.source == "")
		{
			for (i=0; i < target.childNodes.length; i++) {
				if (target.childNodes[i].id != undefined) {
					//console.debug(target.childNodes[i].value + "  " + target.childNodes[i].innerHTML + "  " + target.childNodes[i].selected + "  " + target.childNodes[i].disabled);
					selectElement = obj.createSelectElement(obj, target.childNodes[i].innerHTML, target.name, target.childNodes[i].value, target.childNodes[i].disabled, target.childNodes[i].selected, {});
					container.appendChild(selectElement);
				}
			}
			target.parentNode.insertBefore(container,target);
			target.parentNode.removeChild(target);		
			this.container = container;
		}
		else
		{
	    	if (this.options.preFunction != null) this.options.preFunction({id:this.options.id, source:this.options.source, target:this.options.target});
			var oParam = (this.options.paramArgs != null) ? this.options.paramArgs : this.options.paramFunction(this.options.id);
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
	        		obj.handler(responseText, jsonObject, {target: obj.options.target,
										  source: obj.options.source,
	                                      items: results,
										  id:obj.options.id,
	                                      defaultOptions: obj.options.defaultOptions});
	      		},
	      		onFailure: function(request) {
	        		if (obj.options.errorFunction != null) 
						obj.options.errorFunction(request.responseText, {id:obj.options.id, object:"mxMultiSelect"});
					else 
						mxAjax.onError(request.responseText, {id:obj.options.id, object:"mxMultiSelect"});
	      		},
	      		onComplete: function(request) {
					if (obj.options.postFunction != null) obj.options.postFunction(oParam.removeUnwantedDataFromRequest(request.responseText), jsonObject, {id:obj.options.id, source:obj.options.source, target: obj.options.target, items: results});
	      		}
	    	});
		}
  	},
  	
  	handler: function(response, json, options)
  	{
  		var obj = this;
  		var target = $(this.options.target);
  		var container = document.createElement("div");
  		Element.addClassName(container, this.options.cssClass);
    	var defaultSelectedValues = (options.defaultOptions || '').split(",");
    	for (var i=0; i<options.items.length; i++) 
    	{
			selectElement = obj.createSelectElement(obj, options.items[i].value, target.name, options.items[i].key, false, false, defaultSelectedValues);
			container.appendChild(selectElement);
    	}
    	container.id = target.id;
    	container.name = target.name;
    	
		target.parentNode.insertBefore(container,target);
		target.parentNode.removeChild(target);		
		this.container = container;
  	},

	createHrefLink: function(text) {
		var link=document.createElement('a')
		link.href="javascript:void(0)";
		var linkContent = document.createElement("span");
		linkContent.innerHTML = text;
		link.appendChild(linkContent);
		return link;
	},

	createSpan: function(content) {
		var text = document.createElement("span");
		text.innerHTML = content;
		return text;
	},

  	selectAll: function(classThis) {
		for (i=0; i < this.container.childNodes.length; i++) {
			var obj = this.container.childNodes[i].getElementsByTagName('input')[0];
			obj.checked = true;
			this.handleOnClick(this, obj);
		}
  	},
  	
  	clearAll: function(classThis) {
		for (i=0; i < this.container.childNodes.length; i++) {
			var obj = this.container.childNodes[i].getElementsByTagName('input')[0];
			if (obj.disabled == false) {
				obj.checked = false;
				this.handleOnClick(this, obj);
			}
		}
  	},
	  	
  	handleOnClick: function(classThis, elem) {
  		if (elem.disabled == false) 
  		{
	  		if (elem.checked) {
	  			Element.addClassName(elem.parentNode, "selected");
	  		} else {
	  			Element.removeClassName(elem.parentNode, "selected");
	  		}
	  	}
  	},
  	
  	createSelectElement: function(obj, content, name, value, disabled, selected, defaultSelectedValues)
  	{
		var input = Try.these(
      		function() {
      			if (selected) {
	      			return document.createElement("<input type='checkbox' checked name='" + name + "' value='" + value + "'>");
	      		} else {
	      			return document.createElement("<input type='checkbox' name='" + name + "' value='" + value + "'>");
	      		}
      		},
      		function() { 
      			var inp = document.createElement("input");
				inp.setAttribute("type", "checkbox");
				inp.setAttribute("name", name);
				inp.setAttribute("value", value);
      			return inp;
      		} 
		)|| false;
		
		var label = document.createElement("label");
		if (disabled) {
			Element.addClassName(label, "disabled");
			input.setAttribute("disabled", "true");
		}
	
		if (selected) {
			Element.addClassName(label, "selected");
			input.setAttribute("checked", true);
			//input.checked = true;
			//alert(input.getAttribute("checked"));
		}
		
   		for (j=0; j<defaultSelectedValues.length; j++) {
     		if (defaultSelectedValues[j] == value) {
				Element.addClassName(label, "selected");
				//input.setAttribute("checked", "");
     		}
   		}
		
		eval("input.onclick=function(){obj.handleOnClick(obj, this)};");
		eval("input.onchange=function(){obj.handleOnClick(obj, this)};");
					
		label.appendChild(input);
		label.appendChild( this.createSpan(content + "<br>") );
		return label;
  	}
}


		
		function handleData(response) {
					alert(response);
				}