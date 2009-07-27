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
    jQuery.getJSON(this.uri+query, (function(_scope) {
	  return function(data) {
	    callback(data, _scope);
	  }
	})(scope));
  }
};

Resource.getScript = function(data, callback, scope) {

}
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
  this.proxy.get(query, this.callback, this, jsonp);
};

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var List = function() {
  this.items = [];
};
List.prototype = {
  add: function(item) {
    this.items.push(item);
  },
  each: function() {
  },
  next: function() {
  },
  prev: function() {
  },
  page_up: function() {
  },
  page_down: function() {
  }
  };

/** 
 * @returns:
 * @author:
 * @version:
 * @requires:
 */
var UI = function() {
  this.tpl;
};
UI.prototype.html = function() {
  this.tpl;
  };
