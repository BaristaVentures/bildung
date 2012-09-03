class PollView extends Backbone.View

	#el: "#content"

	initialize: ->
		console.log "poll view init"
		_.bindAll @, 'render'
		#@model = new window.app.Models.Poll()
		#@model.fetch()
		#@model.bind 'remove', @remove, @
		@model.bind 'change', @render, @
		#@render()

	render: ->
		console.log "render poll"
		console.log @model.attributes	
		@$el.html(window.jst.Poll(@model.attributes))
		          #window.jst.poll()
		return @

	window.app.Views.PollView = PollView
