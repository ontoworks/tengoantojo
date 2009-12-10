/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
function augment(receivingClass, givingClass) {
  if (arguments[2]) {
    for (var i=2, len=arguments.length; i<len; i++) {
      receivingClass.prototype[arguments[i]] = givingClass.prototype[arguments[i]];
    }
  } else { // give static methods 
    for (methodName in givingClass) {
      if(!receivingClass[methodName]) {
	receivingClass[methodName] = givingClass[methodName];
      }
    }
    for (methodName in givingClass.prototype) {
      if(!receivingClass.prototype[methodName])
	receivingClass.prototype[methodName] = givingClass.prototype[methodName];
    }
  }
}

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
function register_proxy(proxies) {
  $.each(proxies, function() {
      augment(this,Resource);
    });
}

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
function google_query(q, max_results) {
  var alt="json";
  var query="?q="+q+"&alt="+alt+"&max-results="+max_results;
  return query;
}

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
function google_query_json(q, max_results) {
  var alt="json";
  var query="?q="+q+"&alt="+alt+"&max-results="+max_results;
  return query;
}

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var Resource = function() {
  this.uri = "";
};
Resource.get = function(query, callback, scope, jsonp) {
  if (jsonp==true) {
    alert("here");
    var _callback = (function(_scope) {
	  return function(data) {
	    alert("here2??");
	    callback(data, _scope);
	  }
	  })(scope);
    alert(_callback);
    $.ajax({dataType:"jsonp",
	  url: this.uri+query,
	  type:"GET",
	  error:function(data, textStatus, error_thrown) {
	    alert(error_thrown);
	},
	  success:function(a,b) {
	  alert("hooolaaaa");
	},
	  error:function(a,b,c) {
	  alert(c);
	}
	
      });
    /*jQuery.getJSON(this.uri+query, (function(_scope) {
	  return function(data) {
	    callback(data, _scope);
	  }
	  })(scope));*/
  } else {
    var random=Math.round(Math.random()*100000000);
    query += "&c="+random;
    jQuery.getJSON(this.uri+query, (function(_scope) {
	  return function(data) {
	    callback(data, _scope);
	    _scope.jquery.trigger(jQuery.Event("ready"));
	  }
	})(scope));
  }
};

Resource.post = function() {
};
Resource.put = function() {
};
//Resource.delete = function() {}; // cannot be named like this


/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var Proxy= function() {
};
augment(Proxy, Resource);

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var Query = function() {
  this.proxy;
  this.uri;
};
Query.prototype.query = function(query, jsonp) {
  var event_load = jQuery.Event("load");
  this.jquery.trigger(event_load);
  this.proxy.get(query, this.callback, this, jsonp);
};

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var UI = function(id) {
  this.id;
  this.jquery;
  this.tpl;
  this.proxy;
};
UI.prototype.initialize = function() {
  this.jquery = $("#"+this.id);
};
UI.prototype.layout = function() {
  if (!this.tpl)
    return $(this.id).clone();
  else
    return this.tpl;
};
UI.prototype.state = function() {
  for(var i=0; this.items.length; i++) {
    alert(this.items[i].id);
  }
};

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var List = function() {
  this.items = [];
  this.item_type= "";
  this._ids= {};
};
List.prototype = {
  add: function(item) {
    this.items.push(item);
    this._ids[item.id]=this.items.length-1;
  },
  get: function(id) {
    return this.items[this._ids[id]];
  },
  each: function() {
    $.each(this.items, function(e) {
	return e;
      });
  },
  empty: function() {
    this.items=[];
    this._ids={};
  },
  next: function() {
  },
  prev: function() {
  }
};

/** 
 * @returns:
 * @author: Santiago Gaviria
 * @version:
 * @requires:
 */
var Paged_List = function(o) {
  this.id = o.id;
  this.page_size = o.page_size;
  this.$pages_container=$("#"+this.id).find(".product-list-page");
};
augment(Paged_List, List);
Paged_List.prototype.page_up = function() {
},
Paged_List.prototype.page_down = function() {
};
Paged_List.prototype._add = List.prototype.add;
Paged_List.prototype.add = function(item) {
  var count = this.items.length;
  var page_n = Math.floor(count/this.page_size);
  var page = this.$pages_container.get(page_n);
  var new_page = count%this.page_size == 0 ? true : false;

  if (new_page) {
    $(page).empty();
  }
  $(page).append(item.render());
  this._add(item.product());
};

/** 
 * @returns:
 * @author: Santiago Gaviria
 * @version:
 * @requires:
 */

//
// 
// regex param makes sense of any of
// these values:
//
// "alpha", 
// "numeric",
// "alphanumeric",
// "email",
// "currency"
// 
// or a custom regex e.g. /^hola mundo$/
// to match the field's value against
//
var Form_Field= function(o) {
  var default_matches= {
    alpha:/\w+/,
    numeric:/^\d+$/,
    alphanumeric:/^[A-Z0-9\s]+/,
    email:/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/,
    currency:/^([0-9]{1,3}(,[0-9]{3})*(\.[0-9]+)?|\.[0-9]+)$/
  };
  
  var name=o.name ? o.name : "";
  var label=o.label ? o.label : "";
  var value=o.value ? o.value : "";
  var match=o.match;
  var empty_text=o.empty_text ? o.empty_text : "";
  
  function regex(key) {
    if (default_matches[key])
      return default_matches[key];
    return key;
  }
  
  // Getters and setters
  this.name= function(val) {
    if(arguments.length==0)
      return name;
    name=val;
    return this;
  };
  this.label= function(val) {
    if(arguments.length==0)
      return label;
    label=val;
    return this;
  };
  this.value= function(val) {
    if(arguments.length==0)
      return value;
    value=val;
    return this;
  };
  this.match= function(val) {
    if(arguments.length==0)
      return regex(match);
    match=val;
    return this;
  };
  this.empty_text= function(val) {
    if(arguments.length==0)
      return empty_text;
    empty_text=val;
    return this;
  };
  
  this.after_validate= o.after_validate ? o.after_validate : function(){};
};
// Validates there is a valid value
// for this field
Form_Field.prototype.is_valid= function() {
  var valid=true;
  if(this.match()) {
    valid=this.value().match(this.match());
  }
  this.after_validate(this,valid);
  return valid;
};

/** 
 * @returns:
 * @author: Santiago Gaviria
 * @version:
 * @requires: Form_Field
 */
var Form= function(data, options) {
  this.fields= {};
  this.valid= false;

  for (var field in data) {
    this.fields[field]= new Form_Field(data[field]);
    this.fields[field].label(field);
  }
};
Form.prototype.is_valid= function() {
  var valid= true;
  for (var label in this.fields) {
    var field= this.fields[label];
    if (!field.is_valid()) {
      valid= false;
    }
  }
  return valid;
};
Form.prototype.post= function(callback) {
  if (this.is_valid()) {
    var data={};
    for (var label in this.fields) {
      var field= this.fields[label];
      data[field.name()]=field.value();
    }
    $.post("/santiago/items", data, callback);
  }
};
Form.prototype.get_field= function(label) {
  return this.fields[label];
};
