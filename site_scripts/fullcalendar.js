/*
 * FullCalendar v1.2.1
 * http://arshaw.com/fullcalendar/
 *
 * use fullcalendar.css for basic styling
 * requires jQuery UI core and draggables ONLY if you plan to do drag & drop
 *
 * Copyright (c) 2009 Adam Shaw
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * Date: 2009-05-31 13:56:02 -0700 (Sun, 31 May 2009)
 * Revision: 23
 */
(function(c){c.fn.fullCalendar=function(w){if(typeof w=="string"){var s=Array.prototype.slice.call(arguments,1);var r;this.each(function(){var y=c.data(this,"fullCalendar")[w].apply(this,s);if(typeof r=="undefined"){r=y}});if(typeof r!="undefined"){return r}return this}w=w||{};var t=w.rightToLeft;var m,l;if(t){m=-1;l=6;this.addClass("r2l")}else{m=1;l=0}var x=typeof w.showTime=="undefined"?"guess":w.showTime;var k=typeof w.buttons=="undefined"?true:w.buttons;var v=(w.weekStart||0)%7;var n=w.timeFormat||"gx";var p=w.titleFormat||(t?"Y F":"F Y");var o,j,q,u=true;this.each(function(){var av=w.year?new Date(w.year,w.month||0,1):new Date();var W,O;var N;var aI;var K=false;var X=[];var Z=w.eventSources||[];if(w.events){Z.push(w.events)}function aA(){aF();ah()}function ag(){d(av,-1);aA()}function ap(){d(av,1);aA()}function G(){av=new Date();aA()}function aC(aJ,aK){av=new Date(aJ,aK,1);aA()}function at(){h(av,-1);aA()}function y(){h(av,1);aA()}c.data(this,"fullCalendar",{refresh:aA,prevMonth:ag,nextMonth:ap,today:G,gotoMonth:aC,prevYear:at,nextYear:y,addEvent:function(aJ){X.push(f(aJ));aF();B()},updateEvent:function(aN){aN.start=c.fullCalendar.parseDate(aN.start);aN.end=c.fullCalendar.parseDate(aN.end);var aM=aN.start-aN._start;var aK=aN.end-aN.start;aN._start=a(aN.start);for(var aL=0;aL<X.length;aL++){var aO=X[aL];if(aO.id===aN.id&&aO!==aN){aO.start=new Date(aO.start.getTime()+aM);aO._start=a(aO.start);aO.end=new Date(aO.start.getTime()+aK);for(var aJ in aN){if(aJ&&aJ!="start"&&aJ!="end"&&aJ.charAt(0)!="_"){aO[aJ]=aN[aJ]}}}}aF();B()},removeEvent:function(aN){if(typeof aN=="object"){aN=aN.id}var aM=[];for(var aL=0;aL<X.length;aL++){if(X[aL].id!==aN){aM.push(X[aL])}}X=aM;for(var aL=0;aL<Z.length;aL++){var aO=Z[aL];if(typeof aO!="string"&&!c.isFunction(aO)){var aK=[];for(var aJ=0;aJ<aO.length;aJ++){if(aO[aJ].id!==aN){aK.push(aO[aJ])}}Z[aL]=aK}}aF();B()},getEventsById:function(aL){var aK=[];for(var aJ=0;aJ<X.length;aJ++){if(X[aJ].id===aL){aK.push(X[aJ])}}return aK},addEventSource:function(aJ){Z.push(aJ);F();I(aJ,function(){C();aF();B()})},removeEventSource:function(aM){var aL=[];for(var aJ=0;aJ<Z.length;aJ++){if(aM!==Z[aJ]){aL.push(Z[aJ])}}Z=aL;var aK=[];for(var aJ=0;aJ<X.length;aJ++){if(X[aJ].source!==aM){aK.push(X[aJ])}}X=aK;aF();B()}});var af,z,aq,aB;var A=c("<div class='full-calendar-header'/>").appendTo(this);if(k){var ae=c("<div class='full-calendar-buttons'/>").appendTo(A);if(k==true||k.today!==false){z=c("<button class='today' />").append(c("<span />").html(typeof k.today=="string"?k.today:"today")).click(G);ae.append(z)}if(k.prevYear){var aG=c("<button class='prev-year' />").append(c("<span />").html(typeof k.prevYear=="string"?k.prevYear:"&laquo;")).click(at);if(t){ae.prepend(aG)}else{ae.append(aG)}}if(k==true||k.prevMonth!==false){var aG=c("<button class='prev-month' />").append(c("<span />").html(typeof k.prevMonth=="string"?k.prevMonth:(t?"&gt;":"&lt;"))).click(ag);if(t){ae.prepend(aG)}else{ae.append(aG)}}if(k==true||k.nextMonth!==false){var aG=c("<button class='next-month' />").append(c("<span />").html(typeof k.nextMonth=="string"?k.nextMonth:(t?"&lt;":"&gt;"))).click(ap);if(t){ae.prepend(aG)}else{ae.append(aG)}}if(k.nextYear){var aG=c("<button class='next-year' />").append(c("<span />").html(typeof k.nextYear=="string"?k.nextYear:"&raquo;")).click(y);if(t){ae.prepend(aG)}else{ae.append(aG)}}}if(w.title!==false){af=c("<h2 class='full-calendar-title'/>").appendTo(A)}aq=c("<div class='full-calendar-month' style='position:relative'/>").appendTo(c("<div class='full-calendar-month-wrap'/>").appendTo(this));var ac,an,E;function ah(){K=true;av.setDate(1);g(av);var aV=av.getFullYear();var aS=av.getMonth();var aP=c.fullCalendar.formatDate(av,p);if(af){af.text(aP)}g(av);W=a(av);i(W,-((W.getDay()-v+7)%7));O=a(av);d(O,1);i(O,(7-O.getDay()+v)%7);aI=Math.round((O.getTime()-W.getTime())/604800000);if(w.fixedWeeks!=false){i(O,(6-aI)*7);aI=6}N=g(new Date());if(z){if(N.getFullYear()==aV&&N.getMonth()==aS){z.css("visibility","hidden")}else{z.css("visibility","visible")}}var aJ=c.fullCalendar.dayNames;var aK=c.fullCalendar.dayAbbrevs;if(!an){var aY=c("<table style='width:100%'/>").appendTo(aq);ac="<thead><tr>";for(var aO=0;aO<7;aO++){var aM=(aO*m+l+v)%7;ac+="<th class='"+aK[aM].toLowerCase()+(aO==0?" first":"")+"'>"+(w.abbrevDayHeadings!=false?aK[aM]:aJ[aM])+"</th>"}ac=c(ac+"</tr></thead>").appendTo(aY);an="<tbody>";var aT=a(W);for(var aO=0;aO<aI;aO++){an+="<tr class='week"+(aO+1)+"'>";var aN="";for(var aM=0;aM<7;aM++){var aZ="<td class='day "+aK[(aM+v)%7].toLowerCase()+(aM==l?" first":"")+(aT.getMonth()==aS?"":" other-month")+(aT.getTime()==N.getTime()?" today":"")+"'><div class='day-number'>"+aT.getDate()+"</div><div class='day-content'><div/></div></td>";if(t){aN=aZ+aN}else{aN+=aZ}i(aT,1)}an+=aN+"</tr>"}an=c(an+"</tbody>").appendTo(aY);E=c("<div style='position:absolute;top:0;left:0;z-index:1;width:100%' />").appendTo(aq).click(function(a0,a1){if(w.dayClick){J();var a2=M(a0.pageX,a0.pageY);if(a2){return w.dayClick.call(a2,aE(a2))}}})}else{var aW=aI-an.find("tr").length;if(aW<0){an.find("tr:gt("+(aI-1)+")").remove()}else{if(aW>0){var aQ="";for(var aO=0;aO<aW;aO++){aQ+="<tr class='week"+(aI+aO)+"'>";for(var aM=0;aM<7;aM++){aQ+="<td class='day "+aK[(aM*m+l+v)%7].toLowerCase()+(aM==0?" first":"")+"'><div class='day-number'></div><div class='day-content'><div/></div></td>"}aQ+="</tr>"}if(aQ){an.append(aQ)}}}var aT=a(W);an.find("tr").each(function(){for(var a0=0;a0<7;a0++){var a1=this.childNodes[a0*m+l];if(aT.getMonth()==aS){c(a1).removeClass("other-month")}else{c(a1).addClass("other-month")}if(aT.getTime()==N.getTime()){c(a1).addClass("today")}else{c(a1).removeClass("today")}c(a1.childNodes[0]).text(aT.getDate());i(aT,1)}})}am();if(u){var aU=an.find("tr");var aL=aU.find("td");var aX=aU.position().top;var aR=aL.position().top;o=aR<0;j=aX!=aR;q=an.position().top!=aX;u=false}az(B);K=false;if(w.monthDisplay){w.monthDisplay(av.getFullYear(),av.getMonth(),aP)}}function am(){var aK=an.width();var aL=Math.floor(aK/7);var aJ=Math.round(aL*0.85);ac.find("th").filter(":lt(6)").width(aL).end().filter(":eq(6)").width(aK-aL*6);an.find("td").height(aJ);E.height(aq.height());aB=aq.width()}var ai=[];function B(){ai=[];var aM=0;var aK=a(W);var aL=i(a(aK),7);while(aK.getTime()<O.getTime()){var aJ=[];c.each(X,function(aP,aR){if(aR.end.getTime()>aK.getTime()&&aR.start.getTime()<aL.getTime()){var aQ,aT,aO,aS;if(aR.start.getTime()<aK.getTime()){aQ=a(aK);aO=false}else{aQ=a(aR.start);aO=true}if(aR.end.getTime()>aL.getTime()){aT=a(aL);aS=false}else{aT=a(aR.end);aS=true}aQ=g(aQ);aT=g((aT.getHours()==0&&aT.getMinutes()==0)?aT:i(aT,1));aJ.push({event:aR,start:aQ,end:aT,isStart:aO,isEnd:aS,msLength:aT-aQ})}});aJ.sort(b);var aN=[];c.each(aJ,function(aR,aP){var aO=0;while(true){var aS=false;if(aN[aO]){for(var aQ=0;aQ<aN[aO].length;aQ++){if(aP.end.getTime()>aN[aO][aQ].start.getTime()&&aP.start.getTime()<aN[aO][aQ].end.getTime()){aS=true;break}}}if(aS){aO++;continue}else{break}}if(aN[aO]){aN[aO].push(aP)}else{aN[aO]=[aP]}});ai[aM]=aN;i(aK,7);i(aL,7);aM++}ao()}var R=[];function ao(){for(var aY=0;aY<ai.length;aY++){var aL=ai[aY];var aJ=an.find("tr:eq("+aY+")");var aN=aJ.find("td:first");var a1=aN.find("div.day-content div").css("position","relative");var aS=a1.position().top;if(o){aS-=aN.position().top}if(j){aS+=aJ.position().top}if(q){aS+=an.position().top}var aT=0;for(var aW=0;aW<aL.length;aW++){var aU=aL[aW];var aQ=0;for(var aV=0;aV<aU.length;aV++){var a0=aU[aV];var aX=a0.event;var aR,aP,a2,aM;if(t){aP=a0.isStart?aJ.find("td:eq("+((a0.start.getDay()-v+7)%7*m+l)+") div.day-content div"):an;aR=a0.isEnd?aJ.find("td:eq("+((a0.end.getDay()+6-v)%7*m+l)+") div.day-content div").position().left:an.position().left;a2=a0.isEnd;aM=a0.isStart}else{aR=a0.isStart?aJ.find("td:eq("+((a0.start.getDay()-v+7)%7)+") div.day-content div").position().left:an.position().left;aP=a0.isEnd?aJ.find("td:eq("+((a0.end.getDay()+6-v)%7)+") div.day-content div"):an;a2=a0.isStart;aM=a0.isEnd}aP=aP.position().left+aP.width();var aO=aX.className;if(typeof aO=="string"){aO=" "+aO}else{if(typeof aO=="object"){aO=" "+aO.join(" ")}}var aK=c("<table class='event"+(aO||"")+"' />").append("<tr>"+(a2?"<td class='nw'/>":"")+"<td class='n'/>"+(aM?"<td class='ne'/>":"")+"</tr>").append("<tr>"+(a2?"<td class='w'/>":"")+"<td class='c'/>"+(aM?"<td class='e'/>":"")+"</tr>").append("<tr>"+(a2?"<td class='sw'/>":"")+"<td class='s'/>"+(aM?"<td class='se'/>":"")+"</tr>");L(aX,aK.find("td.c"));if(w.eventRender){var a3=w.eventRender(aX,aK);if(typeof a3!="undefined"){if(a3===false){continue}if(a3!==true){aK=c(a3)}}}aK.css({position:"absolute",top:aS,left:aR,width:aP-aR,"z-index":3}).appendTo(aq);aw(aX,aK);var aZ=aK.outerHeight({margin:true});if(aZ>aQ){aQ=aZ}}aT+=aQ;aS+=aQ}a1.height(aT)}}function L(aL,aK){c("<span class='event-title' />").text(aL.title).appendTo(aK);var aJ=typeof aL.showTime=="undefined"?x:aL.showTime;if(aJ!=false){if(aJ==true||aJ=="guess"&&(aL.start.getHours()||aL.start.getMinutes()||aL.end.getHours()||aL.end.getMinutes())){var aN=c.fullCalendar.formatDate(aL.start,n);var aM=c("<span class='event-time' />");if(t){aK.append(aM.text(" "+aN))}else{aK.prepend(aM.text(aN+" "))}}}}function aw(aK,aJ){aJ.click(function(aM){if(!aJ.hasClass("ui-draggable-dragging")){if(w.eventClick){var aL=w.eventClick.call(this,aK,aM);if(aL===false){return false}}if(aK.url){window.location.href=aK.url}}});if(w.eventMouseover){aJ.mouseover(function(aL){w.eventMouseover.call(this,aK,aL)})}if(w.eventMouseout){aJ.mouseout(function(aL){w.eventMouseout.call(this,aK,aL)})}if(typeof aK.draggable!="undefined"){if(aK.draggable){ak(aK,aJ)}}else{if(w.draggable){ak(aK,aJ)}}R.push([aK,aJ])}function aF(){for(var aJ=0;aJ<R.length;aJ++){R[aJ][1].remove()}R=[]}var Y,D;var Q;function ak(aK,aJ){aJ.draggable({zIndex:4,delay:50,opacity:w.eventDragOpacity,revertDuration:w.eventRevertDuration,start:function(aN,aO){for(var aM=0;aM<R.length;aM++){var aL=R[aM];var aP=aL[0];if(aL[1].get(0)!=this&&(aP==aK||typeof aP.id!="undefined"&&aP.id==aK.id)){aL[1].hide()}}if(!Q){Q=c("<div class='over-day' style='position:absolute;z-index:2' />").appendTo(aq)}J();D=Y=null;aa(this,aN,aO);if(w.eventDragStart){w.eventDragStart.call(this,aK,aN,aO)}},drag:function(aL,aM){aa(this,aL,aM)},stop:function(aM,aN){if(!D||D==Y){for(var aL=0;aL<R.length;aL++){R[aL][1].show()}}else{var aO=aH(Y,D);for(var aL=0;aL<X.length;aL++){if(aK==X[aL]||typeof aK.id!="undefined"&&aK.id==X[aL].id){i(X[aL].start,aO,true);i(X[aL].end,aO,true);X[aL]._start=a(X[aL].start)}}if(w.eventDrop){w.eventDrop.call(this,aK,aO,aM,aN)}aF();B()}Q.hide();if(w.eventDragStop){w.eventDragStop.call(this,aK,aM,aN)}}})}function aa(aK,aJ,aL){var aM=D;D=M(aJ.pageX,aJ.pageY);if(!Y){Y=D}if(D!=aM){if(D){c(aK).draggable("option","revert",D==Y);Q.css({top:P,left:S,width:T,height:ad,display:"block"})}else{c(aK).draggable("option","revert",true);Q.hide()}}}var V,U,H,au;var ab,al,ar;var S,P,T,ad;function J(){var aJ,aL,aK=aq.offset();H=aK.left;au=aK.top;U=[];an.find("tr").each(function(){aJ=c(this);U.push(aJ.position().top+(j?an.position().top:0))});U.push(U[U.length-1]+aJ.height());V=[];aJ.find("td").each(function(){aL=c(this);V.push(aL.position().left)});V.push(V[V.length-1]+aL.width());ab=null}function M(aK,aO){var aL=-1,aN=-1;var aM=U.length-1,aJ=V.length-1;while(aL<aM&&aO>au+U[aL+1]){aL++}while(aN<aJ&&aK>H+V[aN+1]){aN++}if(aL<0||aL>=aM||aN<0||aN>=aJ){return ab=null}else{if(!ab||aL!=al||aN!=ar){al=aL;ar=aN;ab=an.find("tr:eq("+aL+") td:eq("+aN+")").get(0);S=V[aN];P=U[aL];T=V[aN+1]-S;ad=U[aL+1]-P;return ab}}return ab}function aE(aO){var aL,aJ=an.get(0).getElementsByTagName("tr");for(aL=0;aL<aJ.length;aL++){var aM=aJ[aL];for(var aK=0;aK<7;aK++){if(aM.childNodes[aK]==aO){var aN=a(W);return i(aN,aL*7+aK*m+l)}}}}function aH(aL,aJ){var aN,aM,aQ=an.get(0).getElementsByTagName("tr");for(var aP=0;aP<aQ.length;aP++){var aR=aQ[aP];for(var aO=0;aO<7;aO++){var aK=aR.childNodes[aO];if(aK==aL){aN=aP*7+aO*m+l}if(aK==aJ){aM=aP*7+aO*m+l}}}return aM-aN}function az(aM){X=[];if(Z.length>0){var aL=Z.length;var aJ=function(){if(--aL==0){C();if(aM){aM(X)}}};F();for(var aK=0;aK<Z.length;aK++){I(Z[aK],aJ)}}}function I(aM,aO){var aN=av.getFullYear();var aJ=av.getMonth();var aL=function(aP){if(av.getFullYear()==aN&&av.getMonth()==aJ){for(var aQ=0;aQ<aP.length;aQ++){f(aP[aQ]);aP[aQ].source=aM}X=X.concat(aP)}if(aO){aO(aP)}};if(typeof aM=="string"){var aK={};aK[w.startParam||"start"]=Math.round(W.getTime()/1000);aK[w.endParam||"end"]=Math.round(O.getTime()/1000);aK[w.cacheParam||"_"]=(new Date()).getTime();c.getJSON(aM,aK,aL)}else{if(c.isFunction(aM)){aM(W,O,aL)}else{aL(aM)}}}var aD=0;function F(){if(!aD++&&w.loading){w.loading(true)}}function C(){if(!--aD&&w.loading){w.loading(false)}}var ay=c(this);var ax=this;var aj=0;c(window).resize(function(){if(!K){var aJ=++aj;setTimeout(function(){if(aJ==aj){if(ay.css("display")!="none"){if(aq.width()!=aB){aF();am();ao();if(w.resize){w.resize.call(ax)}}}}},200)}});if(ay.css("display")!="none"){ah()}});return this};function f(j){if(j.date){j.start=j.date;delete j.date}j.start=c.fullCalendar.parseDate(j.start);j._start=a(j.start);j.end=c.fullCalendar.parseDate(j.end);if(!j.end||j.end<=j.start){j.end=i(a(j.start),1)}return j}function b(k,j){return(j.msLength-k.msLength)*100+(k.event.start-j.event.start)}function e(j){return(j<10?"0":"")+j}function d(k,l,j){k.setMonth(k.getMonth()+l);if(j){return k}return g(k)}function h(k,l,j){k.setFullYear(k.getFullYear()+l);if(j){return k}return g(k)}function i(k,l,j){k.setDate(k.getDate()+l);if(j){return k}return g(k)}function g(j){j.setHours(0);j.setMinutes(0);j.setSeconds(0);j.setMilliseconds(0);return j}function a(j){return new Date(+j)}c.fullCalendar={monthNames:["January","February","March","April","May","June","July","August","September","October","November","December"],monthAbbrevs:["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],dayNames:["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],dayAbbrevs:["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],formatDate:function(n,m){var l=c.fullCalendar.dateFormatters;var k="";for(var j=0;j<m.length;j++){var o=m.charAt(j);if(l[o]){k+=l[o](n)}else{k+=o}}return k},dateFormatters:{a:function(j){return j.getHours()<12?"am":"pm"},A:function(j){return j.getHours()<12?"AM":"PM"},x:function(j){return j.getHours()<12?"a":"p"},X:function(j){return j.getHours()<12?"A":"P"},g:function(j){return j.getHours()%12||12},G:function(j){return j.getHours()},h:function(j){return e(j.getHours()%12||12)},H:function(j){return e(j.getHours())},i:function(j){return e(j.getMinutes())},F:function(j){return c.fullCalendar.monthNames[j.getMonth()]},m:function(j){return e(j.getMonth()+1)},M:function(j){return c.fullCalendar.monthAbbrevs[j.getMonth()]},n:function(j){return j.getMonth()+1},Y:function(j){return j.getFullYear()},y:function(j){return(j.getFullYear()+"").substring(2)},c:function(j){return j.getUTCFullYear()+"-"+e(j.getUTCMonth()+1)+"-"+e(j.getUTCDate())+"T"+e(j.getUTCHours())+":"+e(j.getUTCMinutes())+":"+e(j.getUTCSeconds())+"Z"}},parseDate:function(j){if(typeof j=="object"){return j}if(typeof j=="undefined"){return null}if(typeof j=="number"){return new Date(j*1000)}return c.fullCalendar.parseISO8601(j,true)||Date.parse(j)||new Date(parseInt(j)*1000)},parseISO8601:function(l,j){var m="([0-9]{4})(-([0-9]{2})(-([0-9]{2})(T([0-9]{2}):([0-9]{2})(:([0-9]{2})(.([0-9]+))?)?(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?";var o=l.match(new RegExp(m));if(!o){return null}var n=0;var k=new Date(o[1],0,1);if(o[3]){k.setMonth(o[3]-1)}if(o[5]){k.setDate(o[5])}if(o[7]){k.setHours(o[7])}if(o[8]){k.setMinutes(o[8])}if(o[10]){k.setSeconds(o[10])}if(o[12]){k.setMilliseconds(Number("0."+o[12])*1000)}if(!j){if(o[14]){n=(Number(o[16])*60)+Number(o[17]);n*=((o[15]=="-")?1:-1)}n-=k.getTimezoneOffset()}return new Date(Number(k)+(n*60*1000))}}})(jQuery);