DOMinclude={
	ifrContainer:null,
	currentTrigger:null,
	init:function(){
		if(!document.getElementById || !document.createTextNode){return;}
		var allLinks=document.getElementsByTagName('a');
		for(var i=0;i<allLinks.length;i++){
			if(!DOMinclude.cssjs('check',allLinks[i],DOMinccfg.triggerClass)){continue;}
			DOMinclude.addEvent(allLinks[i],'click',DOMinclude.openPopup,false);			
			allLinks[i].preset=allLinks[i].innerHTML;
			allLinks[i].onclick=DOMinclude.safariClickFix;
			allLinks[i].isOpen=false;
		}
	},
	openPopup:function(e){
		var t=DOMinclude.getTarget(e);
		if(t.nodeName.toLowerCase()!='a'){
			t=t.parentNode;	
		}
		if(DOMinclude.currentTrigger && DOMinclude.currentTrigger!=t){
			DOMinclude.currentTrigger.isOpen=false;
		}
		DOMinclude.killPopup();
		if(!t.isOpen){
			DOMinclude.cssjs('add',t,DOMinccfg.openPopupLinkClass);
			t.innerHTML=DOMinccfg.displayPrefix+t.preset;
			DOMinclude.ifrContainer=document.createElement('div');
			DOMinclude.cssjs('add',DOMinclude.ifrContainer,DOMinccfg.popupClass);
			var targetURL=t.getAttribute('href');
			var ftype=targetURL.substring(targetURL.lastIndexOf('.')+1,targetURL.length);
			ftype=new RegExp(DOMinccfg.imagetypes).test(ftype)?'img':'iframe';
			var ifr=document.createElement(ftype);
			if(ftype=='iframe'){
				ifr.style.width=DOMinccfg.frameSize[0]+'px';
				ifr.style.height=DOMinccfg.frameSize[1]+'px';
			}
			DOMinclude.ifrContainer.appendChild(ifr);
			ifr.setAttribute('src',targetURL);
			document.body.appendChild(DOMinclude.ifrContainer);
			DOMinclude.positionPopup(t);
			DOMinclude.cancelClick(e);
			DOMinclude.currentTrigger=t;
			t.isOpen=true;
		} else {
			t.isOpen=false;
		}
	},
	positionPopup:function(o){
		var x=0;
		var y=0;
		var h=o.offsetHeight;
		while (o != null){
			x += o.offsetLeft;
			y += o.offsetTop;
			o = o.offsetParent;
		}
		DOMinclude.ifrContainer.style.left=x+'px';
		DOMinclude.ifrContainer.style.top=y+h+'px';
	},
	killPopup:function(e){
		if(!DOMinclude.ifrContainer){return;}
		if(DOMinclude.currentTrigger){
			if(arguments.length>0){
				DOMinclude.currentTrigger.isOpen=false;
			}
			DOMinclude.currentTrigger.innerHTML=DOMinclude.currentTrigger.preset;
			DOMinclude.cssjs('remove',DOMinclude.currentTrigger,DOMinccfg.openPopupLinkClass);
			DOMinclude.currentTrigger=null;
		}
		DOMinclude.ifrContainer.parentNode.removeChild(DOMinclude.ifrContainer);
		DOMinclude.ifrContainer=null;
		DOMinclude.cancelClick(e);
	},
	getTarget:function(e){
		var target = window.event ? window.event.srcElement : e ? e.target : null;
		if (!target){return false;}
		while(target.nodeType!=1 && target.nodeName.toLowerCase()!='body'){
			target=target.parentNode;
		}
		return target;
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
	addEvent: function(elm, evType, fn, useCapture){
		if (elm.addEventListener){
			elm.addEventListener(evType, fn, useCapture);
			return true;
		} else if (elm.attachEvent) {
			var r = elm.attachEvent('on' + evType, fn);
			return r;
		} else {
			elm['on' + evType] = fn;
		}
	},
	cssjs:function(a,o,c1,c2){
		switch (a){
			case 'swap':
				o.className=!DOMinclude.cssjs('check',o,c1)?o.className.replace(c2,c1):o.className.replace(c1,c2);
			break;
			case 'add':
				if(!DOMinclude.cssjs('check',o,c1)){o.className+=o.className?' '+c1:c1;}
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
	},
    safariClickFix:function(){
      return false;
    }
}
DOMinclude.addEvent(window,'load',DOMinclude.init,false);			
