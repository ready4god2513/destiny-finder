mxAjax.Rating = Class.create();
mxAjax.Rating.prototype = {
  	initialize: function(options) {
    	this.saved = false;
    	this.defaultRatingIndex = -1;
    	this.setOptions(options);

    	// create message DIV
    	if (this.options.messageClass) {
      		this.messageContainer = new Insertion.Top($(this.options.source),
        	'<div id="'+ this.options.source +'_message" class="' + this.options.messageClass +'"></div>');
    	}
    	this.setListeners();
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		id: options.id ? options.id : "",
      		parser: options.parser ? options.parser : new mxAjax.CFArrayToJSKeyValueParser(),
      		handler: options.handler ? options.handler : this.handler,
      		savedMessage: options.savedMessage ? options.savedMessage : "<font color='red'><b>Saved</b></font>",
      		defaultRating: options.defaultRating ? options.defaultRating : ""
    	}, options || {});
    	this.ratingParameter = AJAX_RATING_PARAMETER;

		if (this.options.defaultRating != "")
		{
	  		var ratings = this.options.ratings.split(',');

	    	// get containing div
	    	var container = $(this.options.source);
	  		
	  		// get list of all anchors
	  		var elements = container.getElementsByTagName('a');
	  		for (var i=0; i < ratings.length ; i++)
	  		{
	  			if (ratings[i] == this.options.defaultRating) {
	  				this.defaultRatingIndex = i;
	  			}
	 		}
	 		if (this.defaultRatingIndex >= 0)
	 		{
		    	// update styles
		    	for (var i=0; i<elements.length; i++) {
		      		if (i <= this.defaultRatingIndex) {
		        		if (Element.hasClassName(container, 'onoff')
		              		&& Element.hasClassName(elements[i], this.options.selectedClass)) {
		          			Element.removeClassName(elements[i], this.options.selectedClass);
		        		} else {
		          			Element.addClassName(elements[i], this.options.defaultSelectedClass);
		        		}
		      		}
		    	}
		    }
		}
  	},

  	setListeners: function() {
    	// attach events to anchors
    	var elements = $(this.options.source).getElementsByTagName('a');
    	for (var j=0; j<elements.length; j++) {
      		elements[j].onmouseover = this.raterMouseOver.bindAsEventListener(this);
      		elements[j].onmouseout = this.raterMouseOut.bindAsEventListener(this);
      		elements[j].onclick = this.raterClick.bindAsEventListener(this);
    	}
  	},

  	getCurrentRating: function(list) {
    	var selectedIndex = -1;
    	for (var i=0; i<list.length; i++) {
      		if (Element.hasClassName(list[i], this.options.selectedClass)) {
        		selectedIndex = i;
      		}
    	}
    	return selectedIndex;
  	},

  	getCurrentIndex: function(list, elem) {
    	var currentIndex = 0;
    	for (var i=0; i<list.length; i++) {
      		if (elem == list[i]) {
        		currentIndex = i;
      		}
    	}
    	return currentIndex;
  	},

  	raterMouseOver: function (e) {
    	// get containing div
    	var container = Event.findElement(e, 'div');

    	// get list of all anchors
    	var elements = container.getElementsByTagName('a');

    	// find the current rating
    	var selectedIndex = this.getCurrentRating(elements);
    	
    	// find the index of the 'hovered' element
    	var currentIndex = this.getCurrentIndex(elements, Event.element(e));

    	// set message
    	if (this.options.messageClass) {
      		$(container.id+'_message').innerHTML = Event.element(e).title;
    	}
    	
    	// iterate over each anchor and apply styles
    	for (var i=0; i<elements.length; i++) {
      		if (selectedIndex > -1) {
        		if (i <= selectedIndex && i <= currentIndex)
          			Element.addClassName(elements[i], this.options.selectedOverClass);
        		else if (i <= selectedIndex && i > currentIndex)
          			Element.addClassName(elements[i], this.options.selectedLessClass);
        		else if (i > selectedIndex && i <= currentIndex)
          			Element.addClassName(elements[i], this.options.overClass);
      		} else {
      			Element.removeClassName(elements[i], this.options.defaultSelectedClass);
        		if (i <= currentIndex) {
        			Element.addClassName(elements[i], this.options.overClass);
       			}
      		}
    	}
  	},

  	raterMouseOut: function (e) {
    	// get containing div
    	var container = Event.findElement(e, 'div');

    	// get list of all anchors
    	var elements = container.getElementsByTagName('a');

    	// clear message
    	if (this.options.messageClass) {
    		if (this.saved)
    			$(container.id+'_message').innerHTML = this.options.savedMessage;
    		else
	      		$(container.id+'_message').innerHTML = '';
    	}

    	// iterate over each anchor and apply styles
    	for (var i=0; i<elements.length; i++) {
      		Element.removeClassName(elements[i], this.options.selectedOverClass);
      		Element.removeClassName(elements[i], this.options.selectedLessClass);
      		Element.removeClassName(elements[i], this.options.overClass);
      		Element.removeClassName(elements[i], this.options.defaultSelectedClass);
      		if ( (!this.saved) && (i <= this.defaultRatingIndex) ) {
	      		Element.addClassName(elements[i], this.options.defaultSelectedClass);
      		}
    	}
  	},

  	raterClick: function (e) {
    	// get containing div
    	var container = Event.findElement(e, 'div');

    	// get list of all anchors
    	var elements = container.getElementsByTagName('a');

    	// find the index of the 'hovered' element
    	var currentIndex = this.getCurrentIndex(elements, Event.element(e));

    	// update styles
    	for (var i=0; i<elements.length; i++) {
      		Element.removeClassName(elements[i], this.options.selectedOverClass);
      		Element.removeClassName(elements[i], this.options.selectedLessClass);
      		Element.removeClassName(elements[i], this.options.overClass);
      		Element.removeClassName(elements[i], this.options.defaultSelectedClass);
      		if (i <= currentIndex) {
        		if (Element.hasClassName(container, 'onoff')
              		&& Element.hasClassName(elements[i], this.options.selectedClass)) {
          			Element.removeClassName(elements[i], this.options.selectedClass);
        		} else {
          			Element.addClassName(elements[i], this.options.selectedClass);
        		}
      		} else if (i > currentIndex) {
        		Element.removeClassName(elements[i], this.options.selectedClass);
      		}
    	}

    	// send AJAX
    	var ratingToSend = 0;
   		var ratings = this.options.ratings.split(',');
    	if (Element.hasClassName(container, 'onoff')) {
    		// send opposite of what was selected
      		if (ratings[0] == ratingToSend) ratingToSend = ratings[1];
      		else ratingToSend = ratings[0];
    	} else {
    		ratingToSend = ratings[currentIndex];
    	}
    	
    	this.execute(ratingToSend);

    	// set field (if defined)
    	if (this.options.state) {
      		$(this.options.state).value = ratingToSend;
    	}
  	},

  	execute: function(ratingValue) {
    	if (this.options.preFunction != null) this.options.preFunction({id:this.options.id, source:this.options.source, target:this.options.target});
		var oParam = (this.options.paramArgs != null) ? this.options.paramArgs : this.options.paramFunction(this.options.id);

    	// parse parameters and do replacements
    	var ajaxParameters = oParam.getParam();
    	var re = new RegExp("(\\{"+this.ratingParameter+"\\})", 'g');
    	ajaxParameters = ajaxParameters.replace(re, ratingValue);
    	oParam.setParam(ajaxParameters);
		
    	var obj = this; // required because 'this' conflict with Ajax.Request
    	var toggleStateFunc = this.getToggleStateValue;
    	var aj = new Ajax.Request(oParam.getUrl(), {
      		asynchronous: true,
      		method: oParam.getHttpMethod(),
      		parameters: oParam.getUrlParam(),
	  		postBody: ( (oParam.getHttpMethod() == "post") ? oParam.getPostData() : ''),
      		onSuccess: function(request) {
        		obj.options.handler(request, {id:obj.options.id});
        		obj.saved = true;
      		},
      		onFailure: function(request) {
        		if (obj.options.errorFunction != null) obj.options.errorFunction(request);
      		},
      		onComplete: function(request) {
        		if (obj.options.postFunction != null) obj.options.postFunction(request);
      		}
    	});
  	},

  	handler: function(request, options) {
    	
  	},

  	getToggleStateValue: function(name, results) {
    	for (var i=0; i<results.length; i++) {
      		if (results[i][0] == name) return results[i][1];
    	}
    	return "";
  	}
}