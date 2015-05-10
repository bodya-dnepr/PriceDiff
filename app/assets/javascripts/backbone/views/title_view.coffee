title = 'Price Diff'
App.Views.TitleView = Backbone.Marionette.ItemView.extend(
  template: 'title'

  initialize: ->
    @__defineGetter__ "title", -> title
    @__defineSetter__ "title", (val) -> @el.innerText= title = _.capitalize(val)
    @observer = new MutationObserver((mutations) ->
      mutations.forEach (mutation) ->
        title = mutation.target.textContent
        window.title = document.title = title
    )
  onShow: ->
    @el = @el.parentElement
    @observer.observe @el, characterData: true, subtree: true, attributes: true, childList: true
    @title = @el.innerText
  onBeforeDestroy: ->
    @observer.disconnect()
)
