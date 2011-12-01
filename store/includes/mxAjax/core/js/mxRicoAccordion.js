/* openrico.org rico.js */
 
/**
  *
  *  Copyright 2005 Sabre Airline Solutions
  *
  *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
  *  file except in compliance with the License. You may obtain a copy of the License at
  *
  *         http://www.apache.org/licenses/LICENSE-2.0
  *
  *  Unless required by applicable law or agreed to in writing, software distributed under the
  *  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
  *  either express or implied. See the License for the specific language governing permissions
  *  and limitations under the License.
  **/

// rico.js --------------------

/**
Updates Made by Arjun Kalura
**/

mxAjax.RicoAccordion = Class.create();
mxAjax.RicoAccordion.prototype = {

   initialize: function(container, options) {
      this.container            = $(container);
      this.lastExpandedTab      = null;
      this.accordionTabs        = new Array();
      this.setOptions(options);
      this._attachBehaviors();

      this.container.style.borderBottom = '1px solid ' + this.options.borderColor;

      // set the initial visual state...
      for ( var i=1 ; i < this.accordionTabs.length ; i++ )
      {
         this.accordionTabs[i].collapse();
         this.accordionTabs[i].content.style.display = 'none';
      }
      this.lastExpandedTab = this.accordionTabs[0];
      this.lastExpandedTab.content.style.height = this.options.panelHeight + "px";
      this.lastExpandedTab.showExpanded();
      this.lastExpandedTab.titleBar.style.fontWeight = this.options.expandedFontWeight;
	  if (this.options.executeOnLoad == true) {
	      if ( this.options.onShowTab ) {
    	     this.options.onShowTab(this.lastExpandedTab);
    	     this.lastExpandedTab.setDynamicallyLoaded(true);
 		  }
	  }
   },

   setOptions: function(options) {
      this.options = Object.extend({
         expandedBg          : '#63699c',
         hoverBg             : '#63699c',
         collapsedBg         : '#6b79a5',
         expandedTextColor   : '#ffffff',
         expandedFontWeight  : 'bold',
         hoverTextColor      : '#ffffff',
         collapsedTextColor  : '#ced7ef',
         collapsedFontWeight : 'normal',
         hoverTextColor      : '#ffffff',
         borderColor         : '#1f669b',
         panelHeight         : 200,
         onHideTab           : null,
         onShowTab           : null,
		 executeOnLoad		 : options.executeOnLoad ? options.executeOnLoad : false,
		 dynamicLoadOnce	 : options.dynamicLoadOnce ? options.dynamicLoadOnce : true
      }, options || {});
   },

   showTabByIndex: function( anIndex, animate ) {
      var doAnimate = arguments.length == 1 ? true : animate;
      this.showTab( this.accordionTabs[anIndex], doAnimate );
   },

   showTab: function( accordionTab, animate ) {

      var doAnimate = arguments.length == 1 ? true : animate;

      if ( this.options.onHideTab )
         this.options.onHideTab(this.lastExpandedTab);

      this.lastExpandedTab.showCollapsed(); 
      var accordion = this;
      var lastExpandedTab = this.lastExpandedTab;

      this.lastExpandedTab.content.style.height = (this.options.panelHeight - 1) + 'px';
      accordionTab.content.style.display = '';

      accordionTab.titleBar.style.fontWeight = this.options.expandedFontWeight;

      if ( doAnimate ) {
         new mxAjax.EffectAccordionSize( this.lastExpandedTab.content,
                                   accordionTab.content,
                                   1,
                                   this.options.panelHeight,
                                   100, 10,
                                   { complete: function() {accordion.showTabDone(lastExpandedTab)} } );
         this.lastExpandedTab = accordionTab;
      }
      else {
         this.lastExpandedTab.content.style.height = "1px";
         accordionTab.content.style.height = this.options.panelHeight + "px";
         this.lastExpandedTab = accordionTab;
         this.showTabDone(lastExpandedTab);
      }
   },

   showTabDone: function(collapsedTab) {
      collapsedTab.content.style.display = 'none';
      this.lastExpandedTab.showExpanded();
      if ( this.options.onShowTab ) {
      	 if (this.options.dynamicLoadOnce == false)
      	 	this.options.onShowTab(this.lastExpandedTab);
      	 else if (this.lastExpandedTab.getDynamicallyLoaded() == false) {
	         this.options.onShowTab(this.lastExpandedTab);
    	     this.lastExpandedTab.setDynamicallyLoaded(true);
    	 }
      }
   },

   _attachBehaviors: function() {
      var panels = this._getDirectChildrenByTag(this.container, 'DIV');
      for ( var i = 0 ; i < panels.length ; i++ ) {

         var tabChildren = this._getDirectChildrenByTag(panels[i],'DIV');
         if ( tabChildren.length != 2 )
            continue; // unexpected

         var tabTitleBar   = tabChildren[0];
         var tabContentBox = tabChildren[1];
         this.accordionTabs.push( new mxAjax.RicoAccordionTab(this,tabTitleBar,tabContentBox) );
      }
   },

   _getDirectChildrenByTag: function(e, tagName) {
      var kids = new Array();
      var allKids = e.childNodes;
      for( var i = 0 ; i < allKids.length ; i++ )
         if ( allKids[i] && allKids[i].tagName && allKids[i].tagName == tagName )
            kids.push(allKids[i]);
      return kids;
   }


};


mxAjax.RicoAccordionTab = Class.create();
mxAjax.RicoAccordionTab.prototype = {
   initialize: function(accordion, titleBar, content) {
      this.accordion = accordion;
      this.titleBar  = titleBar;
      this.content   = content;
      this._attachBehaviors();
      this.dynamicallyloaded = false;
   },

   setDynamicallyLoaded: function(value) {
      this.dynamicallyloaded = value;
   },

   getDynamicallyLoaded: function() {
      return this.dynamicallyloaded;
   },

   collapse: function() {
      this.showCollapsed();
      this.content.style.height = "1px";
   },

   showCollapsed: function() {
      this.expanded = false;
      this.titleBar.style.backgroundColor = this.accordion.options.collapsedBg;
      this.titleBar.style.color           = this.accordion.options.collapsedTextColor;
      this.titleBar.style.fontWeight      = this.accordion.options.collapsedFontWeight;
      this.content.style.overflow = "hidden";
   },

   showExpanded: function() {
      this.expanded = true;
      this.titleBar.style.backgroundColor = this.accordion.options.expandedBg;
      this.titleBar.style.color           = this.accordion.options.expandedTextColor;
      this.content.style.overflow         = "visible";
   },

   titleBarClicked: function(e) {
      if ( this.accordion.lastExpandedTab == this )
         return;
      this.accordion.showTab(this);
   },

   hover: function(e) {
		this.titleBar.style.backgroundColor = this.accordion.options.hoverBg;
		this.titleBar.style.color           = this.accordion.options.hoverTextColor;
   },

   unhover: function(e) {
      if ( this.expanded ) {
         this.titleBar.style.backgroundColor = this.accordion.options.expandedBg;
         this.titleBar.style.color           = this.accordion.options.expandedTextColor;
      }
      else {
         this.titleBar.style.backgroundColor = this.accordion.options.collapsedBg;
         this.titleBar.style.color           = this.accordion.options.collapsedTextColor;
      }
   },

   _attachBehaviors: function() {
      this.content.style.border = "1px solid " + this.accordion.options.borderColor;
      this.content.style.borderTopWidth    = "0px";
      this.content.style.borderBottomWidth = "0px";
      this.content.style.margin            = "0px";

      this.titleBar.onclick     = this.titleBarClicked.bindAsEventListener(this);
      this.titleBar.onmouseover = this.hover.bindAsEventListener(this);
      this.titleBar.onmouseout  = this.unhover.bindAsEventListener(this);
   }
};


mxAjax.EffectAccordionSize = Class.create();
mxAjax.EffectAccordionSize.prototype = {

   initialize: function(e1, e2, start, end, duration, steps, options) {
      this.e1       = $(e1);
      this.e2       = $(e2);
      this.start    = start;
      this.end      = end;
      this.duration = duration;
      this.steps    = steps;
      this.options  = arguments[6] || {};

      this.accordionSize();
   },

   accordionSize: function() {

      if (this.isFinished()) {
         // just in case there are round errors or such...
         this.e1.style.height = this.start + "px";
         this.e2.style.height = this.end + "px";

         if(this.options.complete)
            this.options.complete(this);
         return;
      }

      if (this.timer)
         clearTimeout(this.timer);

      var stepDuration = Math.round(this.duration/this.steps) ;

      var diff = this.steps > 0 ? (parseInt(this.e1.offsetHeight) - this.start)/this.steps : 0;
      this.resizeBy(diff);

      this.duration -= stepDuration;
      this.steps--;

      this.timer = setTimeout(this.accordionSize.bind(this), stepDuration);
   },

   isFinished: function() {
      return this.steps <= 0;
   },

   resizeBy: function(diff) {
      var h1Height = this.e1.offsetHeight;
      var h2Height = this.e2.offsetHeight;
      var intDiff = parseInt(diff);
      if ( diff != 0 ) {
         this.e1.style.height = (h1Height - intDiff) + "px";
         this.e2.style.height = (h2Height + intDiff) + "px";
      }
   }
};