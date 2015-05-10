#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

window.App = new Marionette.Application
  regions:
    title: "#title"
    menu: "core-header-panel[drawer] core-menu"
    content: "core-header-panel[main] div.content"
  Routers: {}
  Views: {}
  Models: {}
  Collections: new ObjectObserver({}).open((added) -> _.mapObject added, setCollection )


setCollection = (collection, name) ->
  name = _.capitalize(name)
  if ! !App.Collections[name] and App.Collections[name].hasOwnProperty('new')
    App.Collections[name]
  else
    App.Collections[name] = do ->
      self = undefined

      constructor = ->

      App.Collections[name] = (models, options) ->
        if !self
          constructor.call this
          self = this
        collection.apply this, arguments
        self

      App.Collections[name].prototype = collection.prototype

      App.Collections[name].new = (models, options) ->
        new collection(models, options)

      App.Collections[name]

document.addEventListener 'polymer-ready', ->
  navicon = document.getElementById('navicon')
  drawerPanel = document.getElementById('drawerPanel')
  navicon.addEventListener 'click', ->
    drawerPanel.togglePanel()

  title = new App.Views.TitleView
  App.title.show(title)
