/*
 **************************************************************
 * This section controls the poll model.
 **************************************************************
 */
var Poll = Backbone.Model.extend({
    urlRoot: "/api/v1/polls/",
});

/*
 **************************************************************
 * This section controls the polls model.
 **************************************************************
 */
var Polls = Backbone.Collection.extend({
    model: Poll,
    url: "/api/v1/polls/",
    parse: function(data){
	return data.objects;
    }
});

/*
 **************************************************************
 * This section controls the choice model.
 **************************************************************
 */
var Choice = Backbone.Model.extend({
    urlRoot: "/api/v1/choices/",
});

/*
 **************************************************************
 * This section controls the choices model.
 **************************************************************
 */
var Choices = Backbone.Collection.extend({
    model: Choice,
    url: "/api/v1/choices/",
    parse: function(data){
	return data.objects;
    }
});