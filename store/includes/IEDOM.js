
document.createElement = function(cE,interface){
//this is for DOM node not dynamically created
onload=function(){
var list=document.all;
var max=list.length;

while(--max)
{
list[max].getAttribute=interface.getAttribute;
list[max].setAttribute=interface.setAttribute;

}
//HTML node
list[0].getAttribute=interface.getAttribute;
list[0].setAttribute=interface.setAttribute;
}


return function (tagName) {
var element = cE(tagName);
element.getAttribute=interface.getAttribute;
element.setAttribute=interface.setAttribute;

return element;
}
}(document.createElement,{

getAttribute:function (attribute) {

switch(attribute){
case "class": attribute = "className";break;
case "for": attribute = "htmlFor";break;
case "style": return this.style.cssText;break;
case "type":return(this.id)?((document.getElementById)?document.getElementById(this.id):document.all[this.id]).type:this.type;break;
case "accesskey":return this.accessKey;break;
case "maxlength":return this.maxLength;break;
}
return this[attribute];
}

,setAttribute:function (attribute, value) {

switch(attribute){
case "name":return document.createElement(this.outerHTML.replace(/name=[a-zA-Z]+/," ").replace(">"," name="+value+">"));
case "class": attribute = "className";break;
case "for": attribute = "htmlFor";break;
case "type":
var me=this.parentNode;

if(!/id=/.test(this.outerHTML))
this.id=this.uniqueID;
if(me){
this.outerHTML=this.outerHTML.replace(/type=[a-zA-Z]+/," ").replace(">"," type="+value+">");

var t=me.childNodes;
var max=t.length;
for(var i=0;i<max;i++)
if(t[i].id==this.id){
t[i].getAttribute=this.getAttribute;
t[i].setAttribute=this.setAttribute;   
}
}else this.type=value;

return;break;
case "accesskey":this.accessKey=value;return;break;
case "style": this.style.cssText =value;return;break;
case "maxlength":this.maxLength=value;return;break;
}

if(attribute.indexOf("on")==0){


this[attribute] = function(){eval(value)};

}
else
this[attribute] = value;
}
});

