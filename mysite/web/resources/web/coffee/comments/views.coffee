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
            commentView = new CommentView
                model: comment

            $('ul#comment_list', @el).append(commentView.render().el)

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

            comment.save()

            $('input#author').val('')
            $('textarea#comment').val('')
            @collection.add(comment)

        readComments: ->
            self = @
            @collection.fetch
                success: ->
                    for comment in self.collection.models
                        self.appendComment(comment)
                error: ->
                    alert("An error occurred while attempting to fetch Comments Collection.")


    class CommentView extends Backbone.View
        tagName: 'li'

        events:
             "click button.delete_comment": "deleteComment"
             "click button.edit_comment": "editComment"

        initialize: ->
            _.bindAll @

            @model.bind('remove', @unrender)

        render: ->
            @renderTemplate()
            return @

        unrender: ->
            $(@el).remove()

        renderTemplate: ->
            variables = { comment: @model }
            template = _.template($("script#comments_template").html(), variables)
            $(@el).html(template)

        deleteComment: ->
            alert("Destroy")
            @model.destroy()

        editComment: ->
            $('input#author').val(@model.get('author'))
            $('textarea#comment').val(@model.get('comment'))
            $('input#author').focus()

        updateComment: ->
            comment_author = $('input#author').val()
            comment_comment = $('textarea#comment').val()

    new CommentsView()