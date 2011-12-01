//Orignal domInclude version - http://www.onlinetools.org/tools/dominclude/
var domIncludeContent = "";
mxAjax.DomInclude = Class.create();
mxAjax.DomInclude.prototype = {
	initialize: function(options) {
		this.setOptions(options);
		this.setup();
		$(this.options.source).preset=$(this.options.source).innerHTML;
   	},

	setOptions: function(options) {
    	this.options = Object.extend({
      		id: options.id ? options.id : "",
      		eventType: options.eventType ? options.eventType : "click",
      		triggerClass: options.triggerClass ? options.triggerClass : "DOMpop",
      		popupClass: options.popupClass ? options.popupClass : "popup", // class of the popup
      		openPopupLinkClass: options.openPopupLinkClass ? options.openPopupLinkClass : "popuplink", // class of the link when the popup is open
      		displayPrefix: options.displayPrefix ? options.displayPrefix : "Hide ", // text to add to the link when the popup is open 
      		imagetypes: options.imagetypes ? options.imagetypes : "jpg|JPG|JPEG|jpeg|gif|GIF|png|PNG", // filter to define which files should not open in an iframe
      		frameSize: options.frameSize ? options.frameSize : [320,180], // dimensions of the popup
      		handler: options.handler ? options.handler : this.handler
    	}, options || {});
  	},

  	setup: function() {
    	Event.observe($(this.options.source),
      		this.options.eventType,
      		this.execute.bindAsEventListener(this),
      		false);
		eval("$(this.options.source).on"+this.options.eventType+" = function(){return false;};");
  	},

	ifrContainer:null,

	getTarget:function(e){
		var target = window.event ? window.event.srcElement : e ? e.target : null;
		if (!target){return false;}
		while(target.nodeType!=1 && target.nodeName.toLowerCase()!='body'){
			target=target.parentNode;
		}
		return target;
	},
	
	execute:function(e){
		var t=this.getTarget(e);
		if(t.nodeName.toLowerCase()!='a'){
			t=t.parentNode;	
		}
		if(this.ifrContainer){
			this.killPopup();
			t.innerHTML=t.preset;
			this.cssjs('remove',t,this.options.openPopupLinkClass,null,this);
		} else {
			if (this.options.paramArgs) {
		    	if (this.options.preFunction != null) this.options.preFunction({id:this.options.id, source:this.options.source, target:this.options.target});
				var oParam = (this.options.paramArgs != null) ? this.options.paramArgs : this.options.paramFunction(this.options.id);
		
				// parse targets
		    	var obj = this; // required because 'this' conflict with Ajax.Request
		    	var setFunc = this.setField;
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
											  ,t,obj);
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
			} else
				this.displayPopup(t,null,this);		
		}
		this.cancelClick(e);
	},

  	handler: function(response, options, target, thisRef) {
  		thisRef.displayPopup(target, response, thisRef);		
  	},
	
	displayPopup:function(t,content, thisRef) {
		thisRef.cssjs('add',t,thisRef.options.openPopupLinkClass, null, thisRef);
		t.innerHTML=thisRef.options.displayPrefix+t.preset;
		thisRef.ifrContainer=document.createElement('div');
		thisRef.cssjs('add',thisRef.ifrContainer,thisRef.options.popupClass, null, thisRef);
		var targetURL=t.getAttribute('href');
		var ftype=targetURL.substring(targetURL.lastIndexOf('.')+1,targetURL.length);
		var ftypeid = "frm" + this.options.source;
		ftype=new RegExp(thisRef.options.imagetypes).test(ftype)?'img':'iframe';
		var ifr=document.createElement(ftype);
		ifr.id = ftypeid;
		if(ftype=='iframe'){
			ifr.style.width=thisRef.options.frameSize[0]+'px';
			ifr.style.height=thisRef.options.frameSize[1]+'px';
		}
		thisRef.ifrContainer.appendChild(ifr);
		if (!thisRef.options.paramArgs) {
			ifr.setAttribute('src',targetURL);
		}
		document.body.appendChild(thisRef.ifrContainer);
		thisRef.positionPopup(t,thisRef);
		if (thisRef.options.paramArgs) {
			if(ftype=='iframe'){
				try {
					ifr.contentDocument.write(content);
					ifr.contentDocument.close();
        		} catch (e) {
					domIncludeContent = content;
					setTimeout("domIncludeLoadFrameContent('" + ftypeid + "')", 50);
        		}			
			}
		}
	},
	
	positionPopup:function(o, thisRef){
		var x=0;
		var y=0;
		var h=o.offsetHeight;
		while (o != null){
			x += o.offsetLeft;
			y += o.offsetTop;
			o = o.offsetParent;
		}
		thisRef.ifrContainer.style.left=x+'px';
		thisRef.ifrContainer.style.top=y+h+'px';
	},
	killPopup:function(e){
		this.ifrContainer.parentNode.removeChild(this.ifrContainer);
		this.ifrContainer=null;
		this.cancelClick(e);
	},
	cancelClick:function(e){
		if (window.event && window.event.cancelBubble 
		    && window.event.returnValue){
			window.event.cancelBubble = true;
			window.event.returnValue = false;
			return;
		}
		if (e && e.stopPropagation && e.preventDefault){
			e.stopPropagation();
			e.preventDefault();
		}
	},
	cssjs:function(a,o,c1,c2,thisRef){
		switch (a){
			case 'swap':
				o.className=!thisRef.cssjs('check',o,c1,null,thisRef)?o.className.replace(c2,c1):o.className.replace(c1,c2);
			break;
			case 'add':
				if(!thisRef.cssjs('check',o,c1,null,thisRef)){o.className+=o.className?' '+c1:c1;}
			break;
			case 'remove':
				var rep=o.className.match(' '+c1)?' '+c1:c1;
				o.className=o.className.replace(rep,'');
			break;
			case 'check':
				var found=false;
				var temparray=o.className.split(' ');
				for(var i=0;i<temparray.length;i++){
					if(temparray[i]==c1){found=true;}
				}
				return found;
			break;
		}
	}
}

function domIncludeLoadFrameContent(id, content)
{
	var f = document.getElementById(id);
	f.contentWindow.document.write(domIncludeContent);
	f.contentWindow.document.close();
}