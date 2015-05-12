App.Views.Menu = Backbone.Marionette.ItemView.extend
  template: false
  el: -> App.menu.$el
  events:
    'click a': 'closeDrawerPanel'
  initialize: ->
    @drawerPanel = App.drawerPanel.$el[0]
  closeDrawerPanel: ->
    @drawerPanel.closeDrawer()
