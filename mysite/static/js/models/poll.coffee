class Poll extends Backbone.Model
	
	defaults:
		id: "10"
		pub_date: "2015-07-26T23:38:12.644701+00:00"
		question: "How to make this more amazing?"
		resource_uri: "/api/rest/polls/10/"

	urlRoot: POLLS_API
window.app.Models.Poll = Poll