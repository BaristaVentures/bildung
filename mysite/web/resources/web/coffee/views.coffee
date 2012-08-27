# These are the Coffee Script client views.
jQuery ->
    class PollsView extends Backbone.View
        el: $('div#polls')

        events:
            'click button#add_poll': 'addPoll'

        initialize: ->
            _.bindAll @
            @collection = new Polls()
            @collection.bind('add', @appendPoll)
            @render()

        render: ->
            self = @
            @collection.fetch
                success: ->
                    for poll in self.collection.models
                        self.appendPoll(poll)

                error: ->
                   alert("An error occurred while attempting to fetch Polls Collection.")

        addPoll: ->
            poll_question = $("#poll_question").val();
            poll_pub_date = $("#poll_pub_date").val();
            poll = new Poll();

            poll.set
                question: poll_question,
                pub_date: poll_pub_date,

            self = @
            poll.save {},
                success: ->
                    self.collection.add(poll)
                error: (model, response) ->
                    error =
                        """
                        There was an error trying to save a poll.
                        Response: #{ response.responseText }
                        """
                    alert(error)

        appendPoll: (poll) ->
            pollView = new PollView({
                model: poll
            })
            $('ul#polls', @el).append(pollView.render().el)


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
                    $(self.el).append("<ul id='choices'></ul>")
                    for choice in self.collection.models
                        if choice.get('poll') is self.poll
                            self.appendChoice(choice)
                error: ->
                    alert("An error occurred while attempting to fetch Choices Collection.");

        appendChoice: (choice) ->
            choiceView = new ChoiceView({
                model: choice
            })
            $('ul#choices', @el).append(choiceView.render().el)

    class ChoiceView extends Backbone.View
        tagName: 'li'

        render: ->
            $(@el).html("<span>#{ @model.get('choice') }</span>")
            return @

    new PollsView()