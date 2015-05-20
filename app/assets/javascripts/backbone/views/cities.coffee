App.Views.City = Backbone.Marionette.ItemView.extend
  template: "cities/show"
  tagName: "paper-item"

App.Views.Cities = Backbone.Marionette.CollectionView.extend
  getChildView: -> App.Views.City
  tagName: 'section'
