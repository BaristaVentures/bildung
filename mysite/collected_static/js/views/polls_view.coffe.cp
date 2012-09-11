class PollsView extends Backbone.View

	el: "#content"
	#el: $('body')

	#events: 'click button#add': 'addItem'

    #initialize: ->
        #_.bindAll @
        #@collection = new window.app.Collections.Polls
        #@collection.bind 'add', @appendItem
        #render()
	initialize: ->

	  _.bindAll @

	  @collection = new window.app.Collections.Polls()
	  @collection.bind 'add', @appendItem

	  @counter = 0

	  @render()
		#_.bindAll @, 'appendItem', 'addAll', 'addItem', 'render	'
		#_.bindAll @, 'render'

		#@collection = new window.app.Collections.Polls()
		#@collection.bind 'add', @appendItem
		#@collection.bind 'add', @appendItem
		#@collection.bind 'reset', @addAll
        #@collection.fetch()
		#@addAll()
		#@addItem()
		#@render()
  render: ->
    console.log "render polls_view"
    $(@el).append '<button>Add List Item</button>'
    $(@el).append '<ul></ul>'


  addItem: ->
    @counter++
    poll = new window.app.Models.Poll
    #poll.set part2: "#{item.get 'part2'} #{@counter}"
    @collection.add poll

  appendItem: (poll) ->
    $('ul').append "<li>#{poll.get 'pub_date'} #{poll.get 'question'}!</li>"

  events: 'click button': 'addItem'

    #render: ->
        #console.log "render polls view"

 		#$(@el).append("<ul> <li>hello world</li> </ul>");
        #_(@collection.models).each: (poll) ->
        #    @appendItem(poll)
        #return @
        #@collection.each(@appendItem)
        #return @

    #addItem: ->
        #console.log "render polls view"
        #poll = new window.app.Models.Poll()
        #@collection.add poll
        #@counter++
        #$('ul').append "<li>Hello, Backbone #{@counter}!</li>"

	#appendItem: (poll) ->
		#console.log "append item"
		#poll_view = new window.app.Views.PollView model: poll
		#@$el.append poll_view.render().el


	#addAll: ->
		#console.log "addAll"
		#console.log @collection.models
		#console.log @collection.meta.total_count
		#@collection.each(@appendItem)

	window.app.Views.PollsView = PollsView
