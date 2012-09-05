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


            $('div#comment_list', @el).append(commentView.render().el)

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
                success: (model, response) ->
                    $('input#author').val('')
                    $('textarea#comment').val('')
                    self.collection.add(model)

        readComments: ->
            self = @
            @collection.fetch
                success: ->
                    for comment in self.collection.models
                        self.appendComment(comment)

                error: ->
                    alert("An error occurred while attempting to fetch Comments Collection.")


    class CommentView extends Backbone.View
        #tagName: 'li'

        events:
            "click button.delete_comment": "deleteComment"
            "click button.edit_comment": "editComment"
            "click button.cancel_update": "cancelUpdate"
            "click button.update_comment": "updateComment"

        initialize: ->
            _.bindAll @
            @model.bind('remove', @unrender)
            @model.bind('change', @render)

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
            @model.destroy()

        editComment: ->
            $(".toggle_#{ @model.get('id') }").toggle()

        updateComment: ->
            comment_author = $("input#editing_author_#{ @model.get('id') }").val()
            comment_comment = $("textarea#editing_comment_#{ @model.get('id') }").val()

            @model.set
                author: comment_author
                comment: comment_comment

            @model.save

        cancelUpdate: ->
            $(".toggle_#{ @model.get('id') }").toggle()


    new CommentsView()