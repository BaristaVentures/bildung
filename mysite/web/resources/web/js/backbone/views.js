/*
 **************************************************
 * This section controls the polls view. 
 **************************************************
 */
var PollsView = Backbone.View.extend({
    el: $('body'),
    events: {
	'click button#add_poll':'addPoll'
    },

    initialize: function(){
	//_.bindAll(this, 'render', 'addPoll');

	this.collection = new Polls();
	this.collection.bind('add', this.appendPoll);

	this.render();
    },

    render: function(){
	var self = this;
	this.collection.fetch({
	    success: function(){
		$(self.el).append("<ul id='polls'></ul>");
		_(self.collection.models).each(function(poll){
		    self.appendPoll(poll);
		}, self);
	    }
	});

    },

    addPoll: function(){
	var poll_question = $("#poll_question").val();
	var poll_pub_date = $("#poll_pub_date").val();
	var poll = new Poll();
	poll.set({
	    question: poll_question,
	    pub_date: poll_pub_date
	});
	poll.save();
	this.collection.add(poll);
    },

    appendPoll: function(poll){
	var pollView = new PollView({
	    model: poll
	});
	$('ul#polls', this.el).append(pollView.render().el);
    }

});


/*
 **************************************************************
 * This section controls the poll view.
 **************************************************************
 */
var PollView = Backbone.View.extend({
    tagName: 'li',

    events: {
	'click button.delete_poll':'remove'
    },

    render: function(){
	$(this.el).append('<span>' + this.model.get('question') + '</span><button class=delete_poll>Delete</button>');
	// var add_choice_button = "<button class='add_choice'>Add Choice</button>";
	// var choice_choice = "<label>Choice:</label><input id='choice_choice'></input>";
	// var choice_votes = "<label>Votes:</label><input id='choice_votes'></input>";
	$(this.el).append("<div id='poll_" + this.model.get('id') + "_choices'></div>");
	this.choices = new ChoicesView(this.model);
	return this;
    },

    remove: function(){
	$(this.el).remove();
	this.model.destroy();
    }
});


/*
 **************************************************************
 * This section controls the choices view.
 **************************************************************
 */
var ChoicesView = Backbone.View.extend({

    events: {
	'click button':'addChoice'
    },

    initialize: function(poll){
	_.bindAll(this, 'render', 'addChoice');
	this.poll = "/api/v1/polls/" + poll.get('id') + "/";
	this.el = 'div#poll_' + poll.get('id') + '_choices';
	this.collection = new Choices({ poll: this.poll });
	this.collection.bind('add', this.appendChoice);
	this.render(poll);
    },

    render: function(poll){

	var self = this;
	this.collection.fetch({
	    success: function(){
		$(self.el).append("<ul></ul>");
		_(self.collection.models).each(function(choice){
		    if(choice.get('poll') == this.poll){
			self.appendChoice(choice);
		    }
		}, self);
	    }
	});
    },

    addChoice: function(){
	alert();
	//var choice_choice = $("#choice_choice").val();
	//var choice_votes = $("#choice_votes").val();
	var choice = new Choice();
	choice.set({
	    choice: choice_choice,
	    votes: choice_votes
	});
	choice.save();
	this.collection.add();
    },

    appendChoice: function(choice){
	var choiceView = new ChoiceView({
	    model: choice
	});
	$('ul', this.el).append(choiceView.render().el);
    }

});


/*
 **************************************************************
 * This section controls the choice view.
 **************************************************************
 */
var ChoiceView = Backbone.View.extend({
    tagName: 'li',

    events: {
	'click button.delete_choice': 'remove',
	'click button.vote_choice': 'vote'
    },

    initialize: function(){
	_.bindAll(this, 'render', 'vote');
	this.model.bind('change', this.render);
	this.model.bind('remove', this.unrender);
    },

    render: function(){
	var buttons = '<button class="delete_choice">Delete</button><button class="vote_choice">Vote</button>';
	$(this.el).html('<span>' + this.model.get('choice') + '</span>  <span>Votes: ' + this.model.get('votes') + '</span>' + buttons);
	return this;
    },

    unrender: function(){
	$(this.el).remove()
    },

    remove: function(){
	$(this.el).remove();
	this.model.destroy();
    },

    vote: function(){
	var votes = this.model.get('votes');
	votes++;
	this.model.set({ votes: votes });
	this.model.save();
    }
});

// This line instanciates the polls view.
var pollsView = new PollsView();
