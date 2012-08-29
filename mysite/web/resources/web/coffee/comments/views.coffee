jQuery ->

    class CommentsView extends Backbone.View
        el: $('div#comments')

        events:
            "click button#create_comment": "createComment"

        initialize: ->
            _.bindAll @
            @collection = new Comments()
            @collection.bind("add", @appendComment)
            @render()

        render: ->
            @readComments()

        appendComment: (comment) ->
            commentView = new CommentView({
                model: comment
            })
            $(@el).append(commentView.render().el)

        createComment: ->
            comment_author = $('input#author').val()
            comment_comment = $('textarea#comment').val()
            comment_poll = "/api/v1/polls/#{ $('input#poll').val() }/"

            comment = new Comment()
            comment.set
                author: comment_author,
                comment: comment_comment,
                pub_date: new Date(),
                poll: comment_poll

            self = @
            comment.save {},
                success: ->
                    self.collection.add(comment)
                    $('input#author').val('')
                    $('textarea#comment').val('')
                error: ->
                    alert("An error occurred while attempting to create a Comment.")

        readComments: ->
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
            return @

        renderTemplate: ->
            variables = { comment: @model }
            template = _.template($("script#comments_template").html(), variables)
            $('div#comments_items').append(template)

    new CommentsView()