window.Poll = Backbone.Model.extend({
    url: POLLS_API,
  /*  
  url: function(){
     return this.get('resource_uri') || this.collection.url;
  }
  */
});

window.Polls = Backbone.Collection.extend({
  url: POLLS_API,
  model: Poll, 
  parse: function(data){
      return data.objects;
  }                                             
});

window.PollView = Backbone.View.extend({
  tagName: 'li',
  className: 'poll',
 
  render: function(){
      $(this.el).html(ich.pollTemplate(this.model.toJSON()));
      return this;
  }                                        
});


window.App = Backbone.View.extend({
  el: $("#app"),
 
  events: {
      "click .create" : "createPoll",
  },
 
  initialize: function(){
      _.bindAll(this, 'addOne', 'addAll', 'render');
      this.polls = new Polls();
      this.polls.bind('add', this.addOne);
      this.polls.bind('refresh', this.addAll);
      this.polls.bind('all', this.render);
      this.polls.fetch();
  },
 
  addAll: function(){
      this.polls.each(this.addOne);
  },
 
  addOne: function(poll){
      var view = new PollView({model:poll});
      this.$('#polls').append(view.render().el);
  },
 
  createPoll: function(){
      alert("event fired");
      var poll = this.$('#question').val();
      if(poll){
          this.polls.create({
                                 question: poll,
                                 pub_date: '00:00:00',
                             });
          this.$('#question').val('');
      }
  }                                  
});

window.app = new App();
