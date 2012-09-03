window.app = {
	Views:{}
	Routers:{}
	Models:{}
	Collections:{}

	init: ->
		console.log "app init"
		window.router = new window.app.Routers.Router()
		Backbone.history.start()
}

window.jst = {
	Poll: Handlebars.compile($("#poll_template").html())
	#Polls: Handlebars.compile("#polls_template").html())
}


jQuery ->
	window.app.init()

console.log "Hello world"