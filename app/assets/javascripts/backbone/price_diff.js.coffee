#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

window.App = new Marionette.Application
  Routers: {}
  Views: {}
  Models: {}
  Collections: {}#new ObjectObserver({}).open((added) -> _.mapObject added, setCollection )

$ ->
  App.addRegions
    title: "#title"
    drawerPanel: "#drawerPanel"
    menu: "core-header-panel[drawer] core-menu"
    content: "core-header-panel[main] div.content"

  document.addEventListener 'polymer-ready', ->
    navicon = document.getElementById('navicon')
    drawerPanel = document.getElementById('drawerPanel')
    navicon.addEventListener 'click', ->
      drawerPanel.togglePanel()
    App.start()

  App.on 'start', (options) ->
    App.router = new App.Routers.MainRouter
    Backbone.history.start() if Backbone.history

    (new App.Views.Menu).render()
    title = new App.Views.TitleView
    App.title.show(title)
