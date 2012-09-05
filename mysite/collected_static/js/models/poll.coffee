class Poll extends Backbone.Model
	
	defaults:
		id: "1"
		pub_date: "2012-07-26T23:38:12.644701+00:00"
		question: "What's new?"
		resource_uri: "/api/rest/polls/1/"

	urlRoot: POLLS_API
window.app.Models.Poll = Poll