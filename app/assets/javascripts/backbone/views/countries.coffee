App.Views.Countries = Backbone.Marionette.CollectionView.extend
  getChildView: -> App.Views.Country
  tagName: 'section'
