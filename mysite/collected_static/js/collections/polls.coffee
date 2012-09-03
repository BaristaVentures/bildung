class Polls extends Backbone.Collection
	urlRoot: POLLS_API
	model: window.app.Models.Poll
window.app.Collections.Polls = Polls