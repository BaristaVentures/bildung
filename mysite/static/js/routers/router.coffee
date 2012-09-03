class Router extends Backbone.Router
	routes: {
		"": "main"
	}

	main: -> 
		window.pollsView = new window.app.Views.PollsView()
		#window.pollView = new window.app.Views.PollView() 
		#poll = new window.app.Models.Poll({id: 1})

	window.app.Routers.Router = Router