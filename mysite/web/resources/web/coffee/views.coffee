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
            poll_question = $("#poll_question").val()
            poll_pub_date = $("#poll_pub_date").val()
            poll = new Poll();

            poll.set
                question: poll_question,
                pub_date: poll_pub_date

            self = @
            poll.save {},
                success: (model) ->
                    self.collection.add(model)
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

        events:
            'click button.delete_poll': 'remove'

        render: ->
            $(@el).append("<span>#{ @model.get 'question' }</span>")
            $(@el).append("&nbsp; <button class='delete_poll'>Delete</button>")
            $(@el).append("<div id='poll_#{ @model.get('id') }_choices'></div>")
            @el.choices = new ChoicesView(@model)
            return @

        remove: ->
            self = @
            @model.destroy
                success: ->
                    $(self.el).remove()
                error: ->
                    alert("There was an error trying to delete the poll.")

    class ChoicesView extends Backbone.View

        initialize: (poll) ->
            _.bindAll @
            @poll = "/api/v1/polls/#{ poll.get('id') }/"
            @el = "div#poll_#{ poll.get('id') }_choices"
            @collection = new Choices({ poll: @poll })
            @collection.bind('add', @appendChoice)
            @render(poll);

        render: (poll) ->
            self = @
            @collection.fetch
                success: ->
                    self.renderTemplate(poll)
                    for choice in self.collection.models
                        if choice.get('poll') is self.poll
                            self.appendChoice(choice)
                error: ->
                    alert("An error occurred while attempting to fetch Choices Collection.")

        renderTemplate: (poll) ->
            variables = { poll_id: poll.get('id') }
            template = _.template($("#choices_template").html(), variables)
            $(@el).append(template)

            self = @
            $("button#add_choice_poll_#{ poll.id }").click ->
                self.addChoice(poll)

        appendChoice: (choice) ->
            choiceView = new ChoiceView({
                model: choice
            })
            $('ul#choices', @el).append(choiceView.render().el)

        addChoice: (poll) ->
            choice_choice = $("#choice_name_poll_#{ poll.get('id') }").val()
            choice_votes = $("#choice_votes_poll_#{ poll.get('id') }").val()
            choice = new Choice()
            choice.set
                choice: choice_choice,
                votes: parseInt(choice_votes),
                poll: poll.get('resource_uri')

            self = @
            choice.save {},
                success: ->
                    self.collection.add(choice)
                error: (model, response) ->
                    console.log response
                    error =
                        """
                        There was an error trying to save a choice.
                        Response: #{ response.responseText.error_message }
                        """
                    alert(error)

    class ChoiceView extends Backbone.View
        tagName: 'li'

        events:
            'click button.delete_choice': 'remove',
            'click button.vote_choice': 'vote'

        initialize: ->
            _.bindAll @
            @model.bind('change', @render)

        render: ->
            choice_name = "<span>#{ @model.get('choice') }</span>"
            choice_votes = "&nbsp;<span>Votes: #{ @model.get('votes') }</span>"
            vote_button = "&nbsp; <button class='vote_choice'>Vote</button>"
            delete_button = "&nbsp; <button class='delete_choice'>Delete</button>"
            $(@el).html(choice_name + choice_votes + vote_button + delete_button)
            return @

        remove: ->
            self = @
            @model.destroy
                success: ->
                    $(self.el).remove()
                error: ->
                    alert("There was an error trying to delete the choice.")

        vote: ->
            votes = @model.get('votes')
            votes++
            @model.set
                votes: votes
            @model.save
                success: ->
                    console.log("vote")
                error: ->
                    alert("There was an error while trying to vote for a choice.")


    new PollsView()