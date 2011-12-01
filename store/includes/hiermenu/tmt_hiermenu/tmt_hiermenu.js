/** 
* Copyright 2004 massimocorner.com
* JavaScript library for the "hiermenu" ColdFusion custom tag
* @author      Massimo Foti (massimo@massimocorner.com)
* @version     1.0, 2004-10-12
 */
function tmt_showHiermenu(menuobj){
	if(document.all){
		var childMenus = menuobj.parentNode.childNodes;
		for(var i=0; i<childMenus.length; i++){	
			var obj = childMenus[i];
			if(obj.nodeName.toLowerCase() == "ul"){
				obj.style.display = "block";
				obj.attachEvent("onmouseover", function(){obj.style.display = "block";});
			}
		}	
	}
}

function tmt_hideHiermenu(menuobj){
	if(document.all){
		var childMenus = menuobj.parentNode.childNodes;
		for(var i=0; i<childMenus.length; i++){	
			var obj = childMenus[i];
			if(obj.nodeName.toLowerCase() == "ul"){
				obj.style.display = "none";
				obj.attachEvent("onmouseout", function(){obj.style.display = "none";});
			}
		}
	}
}
