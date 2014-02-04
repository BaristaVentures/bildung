class PollsView extends Backbone.View

	el: "#content"

 initialize: ->
    _.bindAll @
    @collection = new window.app.Collections.Polls()
    @collection.bind 'add', @appendItem
    @collection.bind 'reset', @addAll
    @collection.fetch()
    @render()
    #@addAll()


 render: ->
   console.log "render polls_view"
   $(@el).append '<button>Add List Item</button>'
   $(@el).append '<ul></ul>'


 addItem: ->
   poll = new window.app.Models.Poll
   @collection.add poll
   poll.save()

 appendItem: (poll) ->
   poll_view = new window.app.Views.PollView model: poll
   @$el.append poll_view.render().el

 addAll: ->
   console.log "addAll"
   console.log @collection.models
   @collection.each(@appendItem)

 events: 'click button': 'addItem'


 window.app.Views.PollsView = PollsView
