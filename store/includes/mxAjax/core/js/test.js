/*
	coded by Kae - kae@verens.com
	I'd appreciate any feedback.
	You have the right to include this in your sites.
	Please retain this notice.
*/

/* edit these variables to customise the multiselect */ {
	var show_toplinks=true;
}

/* global variables - do not touch */ {
	var isIE=window.attachEvent?true:false,selectDefaults=[];
}
function addEvent(el,ev,fn){
	if(isIE)el.attachEvent('on'+ev,fn);
	else if(el.addEventListener)el.addEventListener(ev,fn,false);
}
function addChildren(o,a){
	for(i in a)o.appendChild(a[i]===a[i].toString()?newText(a[i]):a[i]);
}
function X(o,a){
	for(i in a)o[i]=a[i];
}
function newEl(t){
	return document.createElement(t);
}
function newText(t){
	return document.createTextNode(t);
}
function buildMultiselects(){
	do{
		found=0;
		a=document.getElementsByTagName('select');
		for(b=0;b<a.length,!found;++b){
			var ms=a[b];
			if(ms==null)break;
			var name=ms.name.replace(/\[\]$/,'');
			if(ms&&ms.multiple){
				/* common variables */ {
					selectDefaults[name]=[];
					var found=1,disabled=ms.disabled?1:0,msw=ms.offsetWidth,msh=ms.offsetHeight;
					if(msw<120)msw=120;
					if(msh<60)msh=60;
				}
				/* set up wrapper */ {
					var wrapper=newEl('div'),k={width:msw+'px',height:msh+'px',position:'relative',border:'2px solid #000',borderColor:'#333 #ccc #ccc #333',font:'10px sans-serif'};
					if(disabled)k.background='#ddd';
					X(wrapper.style,k);
				}
				if(show_toplinks){ /* reset, all, none */
					var c="alert('selection disabled')",d="multiselect_selectall('"+name+"','",e="javascript:";
					var f=disabled?{a:c,b:c,c:c}:{a:d+"checked');",b:d+"');",c:d+"reset');"};
					addChildren(wrapper,[newLink(e+f.a,'all'),', ',newLink(e+f.b,'none'),', ',newLink(e+f.c,'reset')]);
				}
				/* setup multiselect */ {
					var newmultiselect=newEl('div'),g=isIE?{w:msw-4,h:19}:{w:msw,h:15},h=show_toplinks?{t:'15px',h:msh-g.h}:{t:0,h:msh};
					X(newmultiselect.style,{position:'absolute',top:h.t,left:0,overflow:'auto',width:g.w+'px',height:h.h+'px'});
				}
				c=ms.getElementsByTagName('option');
				for(d=0;d<c.length;d++){
					var label=newEl('label'),k={display:'block',border:'1px solid #eee',borderWidth:'1px 0',font:'10px arial',lineHeight:'10px',paddingLeft:'20px'};
					checkbox=newEl('input');
					X(checkbox.style,{marginLeft:'-16px',marginTop:'-2px'});
					X(checkbox,{type:'checkbox',name:ms.name,value:c[d].value});
					if(c[d].selected){
						X(checkbox,{checked:'checked',defaultChecked:true});
						X(k,{background:'blue',color:'#fff'});
					}
					if(c[d].disabled){
						checkbox.disabled='disabled';
						X(k,{background:'#fff',color:'#666'});
					}
					X(label.style,k);
					checkbox.onchange=checkbox.onclick=new Function('updateBackground(this)');
					selectDefaults[name][d]=c[d].selected?'checked':'';
					if(disabled)checkbox.disabled="disabled";
					addChildren(label,[checkbox,c[d].innerHTML.replace(/\&nbsp;?/g,' ').replace(/\&lt;?/g,'<').replace(/\&gt;?/g,'>')]);
					newmultiselect.appendChild(label);
				}
				wrapper.appendChild(newmultiselect);
				ms.parentNode.insertBefore(wrapper,ms);
				ms.parentNode.removeChild(ms);
			}
		}
	}while(found);
}
function multiselect_selectall(name,val){
	var els=document.getElementsByTagName('input'),found=0;
	for(var i=0;i<els.length;++i)if((els[i].name==name+'[]'||els[i].name==name)&&!els[i].disabled){
		els[i].checked=val=='reset'?selectDefaults[name][found++]:val;
		updateBackground(els[i]);
	}
}
function newLink(href,text){
	var e=newEl('a');e.href=href;e.appendChild(newText(text));return e;
}
function updateBackground(el){
	var p=el.parentNode,c=el.checked?true:false,s=c?{b:'blue',c:'#fff'}:{b:'#fff',c:'#000'};
	X(p.style,{backgroundColor:s.b,color:s.c});
}
function multiselect_hasSelected(name){
	var els=document.getElementsByTagName('input');
	for(var i=0;i<els.length;++i)if((els[i].name==name+'[]'||els[i].name==name)&&els[i].checked)return true;
	return false;
}

addEvent(window,'load',buildMultiselects);
