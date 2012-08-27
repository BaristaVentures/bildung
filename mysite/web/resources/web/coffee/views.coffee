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
            $(@el).append("<div id='poll_#{ @model.get('id') }_choices'></div>")
            @el.choices = new ChoicesView(@model)
            return @

    class ChoicesView extends Backbone.View
        initialize: (poll) ->
            @poll = "/api/v1/polls/#{ poll.get('id') }/"
            @el = "div#poll_#{ poll.get('id') }_choices"
            @collection = new Choices({ poll: @poll })
            @render(poll);

        render: (poll) ->
            self = @
            @collection.fetch
                success: ->
                    $(self.el).append("<ul></ul>")
                    for choice in self.collection.models
                        if choice.get('poll') is self.poll
                            self.appendChoice(choice)
                error: ->
                    alert("An error occurred while attempting to fetch Choices Collection.");

        appendChoice: (choice) ->
            choiceView = new ChoiceView({
                model: choice
            })
            $('ul', @el).append(choiceView.render().el)

    class ChoiceView extends Backbone.View
        tagName: 'li'

        render: ->
            $(@el).html("<span>#{ @model.get('choice') }</span>")
            return @

    new PollsView()