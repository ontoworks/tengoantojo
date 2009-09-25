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
      if(!receivingClass.prototype[methodName]) {
	receivingClass.prototype[methodName] = givingClass.prototype[methodName];
      }
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
  this.item_type;
};
List.prototype = {
  add: function(item) {
    this.items.push(item);
  },
  each: function() {
    $.each(this.items, function(e) {
	return e;
      });
  },
  empty: function() {
    this.items=new Array();
  },
  next: function() {
  },
  prev: function() {
  }
};

var Paged_List = function(o) {
  this.id = o.id;
  this.page_size = o.page_size;
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
  var page = $("#"+this.id).find(".product-list-page").get(page_n);
  var new_page = count%this.page_size == 0 ? true : false;
  if (new_page) {;
    $(page).empty();
  }
  $(page).append(item.html());
  this._add(item);
};
