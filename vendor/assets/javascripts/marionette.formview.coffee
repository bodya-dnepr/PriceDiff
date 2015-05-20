###*
# FormView Extension of Backbone.Marionette.ItemView
#
# @param {Object} options                   Options defining this FormView
# @param {Object} [options.model]           Form Data.
# @param {Object} [options.fields]          Which Fields to include
#
###

Marionette.FormView = Marionette.ItemView.extend(
  className: 'formView'
  validateOnTheFly: true
  fields: {}
  template: JST['form_view_partials/_form']
  events: 'submit form': 'onSubmit'
  templateHelpers:
    getInput: _.bind(@getInput, this)
    className: @cid
    legend: "#{@constructor.name} Details"
    fields: @fields
  constructor: ({model, fields, validateOnTheFly}) ->
    @fields           = !_.isEmpty(fields) ? fields : model.fields
    @validateOnTheFly = !!validateOnTheFly
    throw new Error('Model Must Be Provided') if !model
    throw new Error('There are no fields to render') if _.isEmpty(@fields)

    @initValidateOnTheFly() if @validateOnTheFly
    Backbone.Validation.bind this

    Marionette.ItemView::constructor.apply this, arguments
    return

  getInput: ({name, as, default_value}) ->
    value = @model.get(i) or default_value or ''
    field = @fields[name]
    type  = as || field.type
    label = (@model.labels||{}).name || _.capitalize(_.humanize(name))

    return JST["form_view_partials/_#{type}"](
      viewId: @cid
      fieldName: name
      label: label
      type: type
      value: value
    )

  initValidateOnTheFly: ->
    onChangeEvents = {}
    for i of @model.validation
      onChangeEvents["change ##{@cid}_#{i}"] = 'onFieldChange'
    @events = _.extend(@events, onChangeEvents)
    return
  onBeforeClose: ->
    Backbone.Validation.unbind this
    return
  onSubmit: (e) ->
    e.preventDefault() and e.stopImmediatePropagation()
    data = @$el.find('form').serializeObject()
    @model.save() if @model.set(data)
    return
  onFieldChange: (evt) ->
    el  = evt.currentTarget
    @model.validate "#{el.name}": el.value
    return
)
