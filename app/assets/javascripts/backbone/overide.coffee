Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc

Backbone.Model::validation = {}
Backbone.Model::getName = -> @id or @cid

Backbone.Collection::perform = (callback, options) ->
  options = if options then _.extend(options, success: callback) else {}
  if !@models.length
    @fetch options
  else
    callback this, @models
  this

Backbone.Collection::fetchOne = (id, options) ->
  collection = this
  newOptions = {}

  newOptions.success = (model, resp, opts) ->
    collection.add model
    return

  newOptions.error = (error, xhr, opts) ->
    console.error arguments
    return

  if options.success
    successFunc = options.success

    newOptions.success = (model, resp, opts) ->
      collection.add model
      successFunc model, resp, opts
      return

  if options.error
    errorFunc = options.error

    newOptions.error = (error, xhr, opts) ->
      console.error arguments
      errorFunc error, xhr, opts
      return

  options = if options then _.extend(options, newOptions) else {}
  model = @get(id)
  if model
    options.success model, model.attributes, options
  else
    model = @model.new(id: id)
    model.fetch options
  this

Backbone.Marionette.Renderer.render = (template, data) ->
  tpl_file = "backbone/templates/#{template}"
  if !JST[tpl_file] and !_.trim(template)
    throw 'Template \'' + template + '\' not found!'
  else if JST[tpl_file]
    return JST[tpl_file](data)
  else
    return _.template(template, data, variable: 'args')
  return

_.extend Backbone.Validation.validators,
  presence: (value, attr, required, model, computed) ->
    @required value, attr, required, model, computed
  numericality: (value, attr, validationValue, model, computed) ->
    error = @pattern(value, attr, Backbone.Validation.patterns.number, model)
    if error
      return error
    if validationValue.greater_than_or_equal_to
      return @min(value, attr, 0, model)
    if validationValue.only_integer
      return @pattern(value, attr, Backbone.Validation.patterns.digits, model)
    return
  length: (value, attr, validationValue, model) ->
    if validationValue.allow_blank and value == ''
      return ''
    min = validationValue.minimum
    max = validationValue.maximum
    if min and max
      return @rangeLength(value, attr, [
        min
        max
      ], model)
    if min
      return @minLength(value, attr, min, model)
    if max
      return @maxLength(value, attr, max, model)
    return
  inclusion: (value, attr, validationValue, model) ->
    @oneOf value, attr, validationValue.in, model
_.extend Backbone.Validation.callbacks,
  valid: (view, attr, selector) ->
    # compose the attr - for complex situations
    arr = attr.split('.')
    el = ''
    i = 0
    while i < arr.length
      if i == 0
        el += arr[i]
      else
        el += '[' + arr[i] + ']'
      i++
    control = undefined
    group = undefined
    control = view.$('[' + selector + '="' + el + '"]')
    group = control.parents('.control-group')
    group.removeClass 'error'
    if control.data('error-style') == 'tooltip'
      if control.data('tooltip')
        return control.tooltip('hide')
    else if control.data('error-style') == 'inline'
      return group.find('.help-inline.error-message').remove()
    else
      return group.find('.help-block.error-message').remove()
    return
  invalid: (view, attr, error, selector) ->
    # compose the attr - for complex situations
    arr = attr.split('.')
    el = ''
    i = 0
    while i < arr.length
      if i == 0
        el += arr[i]
      else
        el += '[' + arr[i] + ']'
      i++
    control = undefined
    group = undefined
    position = undefined
    target = undefined
    control = view.$('[' + selector + '="' + el + '"]')
    group = control.parents('.control-group')
    group.addClass 'error'
    if control.data('error-style') == 'tooltip'
      position = control.data('tooltip-position') or 'right'
      control.tooltip
        placement: position
        trigger: 'manual'
        title: error
      control.tooltip 'show'
    else if control.data('error-style') == 'inline'
      if group.find('.help-inline').length == 0
        group.find('.controls').append '<span class="help-inline error-message"></span>'
      target = group.find('.help-inline')
      target.text error
    else
      if group.find('.help-block').length == 0
        group.find('.controls').append '<p class="help-block error-message"></p>'
      target = group.find('.help-block')
      target.text error
_.mixin s.exports()
_.mixin
  decodeUrl: (str, options) ->
    `var options`
    pairs = str.split(/&amp;|&/i)
    h = {}
    options = options or {}
    while i < pairs.length
      kv = pairs[i].split('=')
      kv[0] = decodeURIComponent(if kv[0] then kv[0].replace(/\+/g, ' ') else kv[0])
      if !options.except or options.except.indexOf(kv[0]) == -1
        if /^\w+\[\w+\]$/.test(kv[0])
          matches = kv[0].match(/^(\w+)\[(\w+)\]$/)
          if typeof h[matches[1]] == 'undefined'
            h[matches[1]] = {}
          h[matches[1]][matches[2]] = decodeURIComponent(if kv[1] then kv[1].replace(/\+/g, ' ') else kv[1])
        else
          h[kv[0]] = decodeURIComponent(if kv[1] then kv[1].replace(/\+/g, ' ') else kv[1])
      i++
    h
  decodeCookie: (str, options) ->
    `var options`
    pairs = str.split(/&amp;|&/i)
    h = {}
    options = options or {}
    while i < pairs.length
      kv = pairs[i].split('=')
      kv[0] = decodeURIComponent(if kv[0] then kv[0].replace(/\+/g, ' ') else kv[0])
      i++
    try
      kv[0] = JSON.parse(kv[0])
    catch e
    kv[0]

$.fn.serializeObject = ->
  json = undefined
  patterns = undefined
  push_counters = undefined
  _this = this
  json = {}
  push_counters = {}
  patterns =
    validate: /^[a-zA-Z][a-zA-Z0-9_]*(?:\[(?:\d*|[a-zA-Z0-9_]+)\])*$/
    key: /[a-zA-Z0-9_]+|(?=\[\])/g
    push: /^$/
    fixed: /^\d+$/
    named: /^[a-zA-Z0-9_]+$/

  @build = (base, key, value) ->
    base[key] = value
    base

  @push_counter = (key) ->
    if push_counters[key] == undefined
      push_counters[key] = 0
    push_counters[key]++

  $.each $(this).serializeArray(), (i, elem) ->
    k = undefined
    keys = undefined
    merge = undefined
    re = undefined
    reverse_key = undefined
    if !patterns.validate.test(elem.name)
      return
    keys = elem.name.match(patterns.key)
    merge = elem.value
    reverse_key = elem.name
    while (k = keys.pop()) != undefined
      if patterns.push.test(k)
        re = new RegExp('\\[' + k + '\\]$')
        reverse_key = reverse_key.replace(re, '')
        merge = _this.build([], _this.push_counter(reverse_key), merge)
      else if patterns.fixed.test(k)
        merge = _this.build([], k, merge)
      else if patterns.named.test(k)
        merge = _this.build({}, k, merge)
    json = $.extend(true, json, merge)
  json
