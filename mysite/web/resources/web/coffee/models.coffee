# These are the Coffee Script client models.

# Poll model.
class Poll extends Backbone.Model
    urlRoot: '/api/v1/polls/'

# Polls model.
class Polls extends Backbone.Collection
    model: Poll
    url: "/api/v1/polls/"
    parse: (data) ->
        console.log data
        return data.objects

# Choice model.
class Choice extends Backbone.Model
    urlRoot: '/api/v1/choices/'

# Choices model.
class Choices extends Backbone.Collection
    model: Choice,
    url: '/api/v1/choices/',
    parse: (data) ->
        return data.objects