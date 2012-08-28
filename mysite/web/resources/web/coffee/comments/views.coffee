jQuery ->

    class CommentsView extends Backbone.View
        el: $('div#comments')

        initialize: ->
            _.bindAll @
            @collection = new Comments()
            @render()

        render: ->
            @getComments()

        appendComment: (comment) ->
            commentView = new CommentView({
                model: comment
            })
            $(@el).append(commentView.render().el)

        getComments: ->
            self = @
            @collection.fetch
                success: ->
                    for comment in self.collection.models
                        self.appendComment(comment)
                error: ->
                    alert("An error occurred while attempting to fetch Comments Collection.")

    class CommentView extends Backbone.View
        initialize: ->
            _.bindAll @

        render: ->
            @renderTemplate()
            #$(@el).append("<p>Here comes the comments.</p>")
            return @

        renderTemplate: ->
            variables = { comment: @model }
            template = _.template($("script#comments_template").html(), variables)
            $(@el).append(template)

    new CommentsView()