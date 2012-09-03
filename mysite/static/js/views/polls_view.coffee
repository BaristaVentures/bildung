class PollsView extends Backbone.View

	el: "#content"

	initialize: ->
		console.log "polls view init"
		_.bindAll @, 'appendItem', 'addAll', 'render'
		@collection = new window.app.Collections.Polls()
		@collection.fetch()
		@collection.bind 'add', @appendItem, @
		@collection.bind 'reset', @addAll, @
		@addAll()


	render: ->
		console.log "render polls"
		return @

	appendItem: (poll) ->
		console.log "append item"
		poll_view = new window.app.Views.PollView model: poll
		@$el.append poll_view.render().el


	addAll: ->
		console.log "addAll"
		console.log @collection.models
		#console.log @collection.meta.total_count
		@collection.each(@appendItem)

	window.app.Views.PollsView = PollsView
