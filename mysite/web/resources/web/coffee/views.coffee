# These are the Coffee Script client views.
jQuery ->
    class PollsView extends Backbone.View
        el: $('div#polls')

        initialize: ->
            _.bindAll @
            @collection = new Polls()
            @render()

        render: ->
            self = @
            @collection.fetch
                success: ->
                    $(self.el).append("<ul></ul>")
                    for poll in self.collection.models
                        self.appendPoll(poll)
                error: ->
                   alert("An error occurred while attempting to fetch Polls Collection.")

        appendPoll: (poll) ->
            pollView = new PollView({
                model: poll
            })
            $('ul', @el).append(pollView.render().el)


    class PollView extends Backbone.View
        tagName: 'li'

        render: ->
            $(@el).append("<span>#{ @model.get 'question' }</span>")

            return @

    new PollsView()