class Comment extends Backbone.Model
    urlRoot: "/api/v1/comments/"

class Comments extends Backbone.Collection
    model: Comment
    url: "/api/v1/comments/"
    parse: (data) ->
        return data.objects