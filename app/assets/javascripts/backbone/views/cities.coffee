App.Views.Cities = Backbone.Marionette.CollectionView.extend
  getChildView: -> App.Views.City
  tagName: 'section'
