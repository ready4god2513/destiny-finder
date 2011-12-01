mxAjax.CFQueryToJSKeyValueParser = Class.create();
mxAjax.CFQueryToJSKeyValueParser.prototype = {
  	initialize: function(options) {
		options = (options != undefined) ? options : {};
    	this.type = "CFQueryToJSKeyValueParser";
		this.setOptions(options);
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		delimeter: options.delimeter ? options.delimeter : ",",
      		callno: options.callno ? options.callno : 0,
      		path: options.path ? options.path : ''
    	}, options || {});
  	},

  	parse: function(content) {
		var myObject = JSON.parse(content);
		data = ([content].grep(/"calls"/) == "") ? myObject : myObject.calls[this.options.callno].data;
		if (this.options.path != "") data = eval("data" + this.options.path);
		//Object.dpDump(myObject);
		var fields = myObject.COLUMNLIST.split(",");
		this.itemList = Array(); 
		for (var ctr=0; ctr < myObject.RECORDCOUNT; ctr++)
		{
			this.itemList.push({key:myObject.DATA[fields[0]][ctr], value:myObject.DATA[fields[1]][ctr]});
		}
		return myObject;
  	}
};


mxAjax.CFArrayToJSKeyValueParser = Class.create();
mxAjax.CFArrayToJSKeyValueParser.prototype = {
  	initialize: function(options) {
		options = (options != undefined) ? options : {};
    	this.type = "CFArrayToJSKeyValue";
		this.setOptions(options);
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		delimeter: options.delimeter ? options.delimeter : ",",
      		callno: options.callno ? options.callno : 0,
      		path: options.path ? options.path : ''
    	}, options || {});
  	},

  	parse: function(content) {
		var myObject = JSON.parse(content);
		data = ([content].grep(/"calls"/) == "") ? myObject : myObject.calls[this.options.callno].data;
		if (this.options.path != "") data = eval("data" + this.options.path);
		this.itemList = data.collect(function(item) {
			var id = item;
			var value = item;
			if (this.options.delimeter != "") {
				var list = item.split(this.options.delimeter);
				id = list[0];
				value = list[1];
			} 
			return {key:id, value:value};
			}.bind(this));
		return myObject;
  	}
};

mxAjax.CFStructToJSKeyValueParser = Class.create();
mxAjax.CFStructToJSKeyValueParser.prototype = {
  	initialize: function(options) {
		options = (options != undefined) ? options : {};
    	this.type = "CFStructToJSKeyValueParser";
		this.setOptions(options);
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		delimeter: options.delimeter ? options.delimeter : ",",
      		callno: options.callno ? options.callno : 0,
      		path: options.path ? options.path : ''
    	}, options || {});
  	},

  	parse: function(content) {
		var myObject = JSON.parse(content);
		data = ([content].grep(/"calls"/) == "") ? myObject : myObject.calls[this.options.callno].data;
		this.itemList = Array();
		for (var prop in data ) {
			if (typeof data[prop] != "function")
				this.itemList.push({key:prop, value:data[prop]});
		}
		return myObject;
  	}
};


mxAjax.CFArrayToJSArray = Class.create();
mxAjax.CFArrayToJSArray.prototype = {
  	initialize: function(options) {
		options = (options != undefined) ? options : {};
    	this.type = "CFArrayToJSArray";
		this.setOptions(options);
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		delimeter: options.delimeter ? options.delimeter : ",",
      		callno: options.callno ? options.callno : 0,
      		path: options.path ? options.path : ''
    	}, options || {});
  	},

  	parse: function(content) {
		var myObject = JSON.parse(content);
		data = ([content].grep(/"calls"/) == "") ? myObject : myObject.calls[this.options.callno].data;
		this.itemList = data;
		return myObject;
  	}
};


mxAjax.ParseJson = Class.create();
mxAjax.ParseJson.prototype = {
  	initialize: function(options) {
		options = (options != undefined) ? options : {};
    	this.type = "ParseJson";
		this.setOptions(options);
  	},

  	setOptions: function(options) {
    	this.options = Object.extend({
      		delimeter: options.delimeter ? options.delimeter : ",",
      		callno: options.callno ? options.callno : 0,
      		path: options.path ? options.path : ''
    	}, options || {});
  	},

  	parse: function(content) {
		var myObject = JSON.parse(content);
		data = ([content].grep(/"calls"/) == "") ? myObject : myObject.calls[this.options.callno].data;
		if (this.options.path != "") data = eval("data" + this.options.path);
		this.itemList = data;
		return myObject;
  	}
};