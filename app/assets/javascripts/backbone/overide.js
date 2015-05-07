'use strict'
Backbone.Model.prototype.validation   = {}
Backbone.Model.prototype.getName      = function() {
  return this.id || this.cid;
}
Backbone.Collection.prototype.perform = function(callback, options){
  options = options ? _.extend(options, {success: callback}) : {};
  if(!this.models.length) this.fetch(options);
  else callback(this, this.models);
  return this;
}
Backbone.Collection.prototype.fetchOne = function(id, options){
  var collection = this;
  var newOptions = {};
  newOptions.success = function(model, resp, opts) {
    collection.add(model);
  };
  newOptions.error = function(error, xhr, opts) {
    console.error(arguments);
  }

  if(options.success) {
    var successFunc = options.success;
    newOptions.success = function(model, resp, opts) {
      collection.add(model);
      successFunc(model, resp, opts);
    }
  }
  if(options.error) {
    var errorFunc = options.error;
    newOptions.error = function(error, xhr, opts) {
      console.error(arguments);
      errorFunc(error, xhr, opts);
    }
  };

  options = options ? _.extend(options, newOptions) : {};

  var model = this.get(id);
  if(model) {
    options.success(model, model.attributes, options);
  } else {
    model = this.model.new({id: id});
    model.fetch(options);
  }

  return this;
}
Backbone.Marionette.Renderer.render = function(template, data) {
  if( !JST[template] && !_.trim(template) )
    throw "Template '" + template + "' not found!";
  else if(JST[template])
    return JST[template](data);
  else
    return _.template(template, data, {variable: 'args'});
};

_.extend(Backbone.Validation.validators, {
  presence: function(value, attr, required, model, computed) {
    return this.required(value, attr, required, model, computed);
  },
  numericality: function(value, attr, validationValue, model, computed) {
    var error = this.pattern(value, attr, Backbone.Validation.patterns.number, model);
    if(error) return error;

    if(validationValue.greater_than_or_equal_to) {
      return this.min(value, attr, 0, model);
    };

    if(validationValue.only_integer) {
      return this.pattern(value, attr, Backbone.Validation.patterns.digits, model);
    };
  },
  length: function(value, attr, validationValue, model) {
    if(validationValue.allow_blank && value == '') {
      return '';
    };
    var min = validationValue.minimum;
    var max = validationValue.maximum;

    if(min && max)
      return this.rangeLength(value, attr, [min, max], model);

    if(min)
      return this.minLength(value, attr, min, model);

    if(max)
      return this.maxLength(value, attr, max, model);
  },
  inclusion: function(value, attr, validationValue, model) {
    return this.oneOf(value, attr, validationValue.in, model);
  }
});

_.extend(Backbone.Validation.callbacks, {
  valid: function(view, attr, selector) {
    // compose the attr - for complex situations
    var arr = attr.split('.'),
      el = '';
    for (var i = 0; i < arr.length; i++) {
      if (i === 0) el += arr[i];
      else el += '[' + arr[i] + ']';
    }

    var control, group;
    control = view.$('[' + selector + '="' + el + '"]');
    group = control.parents(".control-group");
    group.removeClass("error");

    if (control.data("error-style") === "tooltip") {
      if (control.data("tooltip")) {
        return control.tooltip("hide");
      }
    } else if (control.data("error-style") === "inline") {
      return group.find(".help-inline.error-message").remove();
    } else {
      return group.find(".help-block.error-message").remove();
    }
  },

  invalid: function(view, attr, error, selector) {
    // compose the attr - for complex situations
    var arr = attr.split('.'),
      el = '';
    for (var i = 0; i < arr.length; i++) {
      if (i === 0) el += arr[i];
      else el += '[' + arr[i] + ']';
    }

    var control, group, position, target;
    control = view.$('[' + selector + '="' + el + '"]');
    group = control.parents(".control-group");
    group.addClass("error");

    if (control.data("error-style") === "tooltip") {
      position = control.data("tooltip-position") || "right";
      control.tooltip({
        placement: position,
        trigger: "manual",
        title: error
      });
      return control.tooltip("show");
    } else if (control.data("error-style") === "inline") {
      if (group.find(".help-inline").length === 0) {
        group.find(".controls").append("<span class=\"help-inline error-message\"></span>");
      }

      target = group.find(".help-inline");
      return target.text(error);
    } else {
      if (group.find(".help-block").length === 0) {
        group.find(".controls").append("<p class=\"help-block error-message\"></p>");
      }

      target = group.find(".help-block");
      return target.text(error);
    }
  }
});

_.mixin(s.exports());
_.mixin({
  decodeUrl : function (str, options) {
    var pairs = str.split(/&amp;|&/i);
    var h = {};
    var options = options || {};
    for(var i = 0; i < pairs.length; i++) {
      var kv = pairs[i].split('=');
      kv[0] = decodeURIComponent(kv[0] ? kv[0].replace(/\+/g, ' ') : kv[0]);
      if(!options.except || options.except.indexOf(kv[0]) == -1) {
        if((/^\w+\[\w+\]$/).test(kv[0])) {
          var matches = kv[0].match(/^(\w+)\[(\w+)\]$/);
          if(typeof h[matches[1]] === 'undefined') {
            h[matches[1]] = {};
          }
          h[matches[1]][matches[2]] = decodeURIComponent(kv[1] ? kv[1].replace(/\+/g, ' ') : kv[1]);
        } else {
          h[kv[0]] = decodeURIComponent(kv[1] ? kv[1].replace(/\+/g, ' ') : kv[1]);
        }
      }
    }
    return h;
  },
  decodeCookie : function (str, options) {
    var pairs = str.split(/&amp;|&/i);
    var h = {};
    var options = options || {};
    for(var i = 0; i < pairs.length; i++) {
      var kv = pairs[i].split('=');
      kv[0] = decodeURIComponent(kv[0] ? kv[0].replace(/\+/g, ' ') : kv[0]);
    }
    try {kv[0] = JSON.parse(kv[0])}
    catch(e){}
    return kv[0];
  },
});

$.fn.serializeObject = function() {
  var json, patterns, push_counters,
    _this = this;
  json = {};
  push_counters = {};
  patterns = {
    validate: /^[a-zA-Z][a-zA-Z0-9_]*(?:\[(?:\d*|[a-zA-Z0-9_]+)\])*$/,
    key: /[a-zA-Z0-9_]+|(?=\[\])/g,
    push: /^$/,
    fixed: /^\d+$/,
    named: /^[a-zA-Z0-9_]+$/
  };
  this.build = function(base, key, value) {
    base[key] = value;
    return base;
  };
  this.push_counter = function(key) {
    if (push_counters[key] === void 0) {
      push_counters[key] = 0;
    }
    return push_counters[key]++;
  };
  $.each($(this).serializeArray(), function(i, elem) {
    var k, keys, merge, re, reverse_key;
    if (!patterns.validate.test(elem.name)) {
      return;
    }
    keys = elem.name.match(patterns.key);
    merge = elem.value;
    reverse_key = elem.name;
    while ((k = keys.pop()) !== void 0) {
      if (patterns.push.test(k)) {
        re = new RegExp("\\[" + k + "\\]$");
        reverse_key = reverse_key.replace(re, '');
        merge = _this.build([], _this.push_counter(reverse_key), merge);
      } else if (patterns.fixed.test(k)) {
        merge = _this.build([], k, merge);
      } else if (patterns.named.test(k)) {
        merge = _this.build({}, k, merge);
      }
    }
    return json = $.extend(true, json, merge);
  });
  return json;
};
