window.Poll = Backbone.Model.extend({
    url: POLLS_API,
    
    

});

window.PollList = Backbone.Collection.extend({
  url: POLLS_API,
  model: Poll, 

  getCurrentDate: function(){
        var currentDate =  new Date();
        var hours = currentDate.getHours();
        var minutes = currentDate.getMinutes();
        var seconds = currentDate.getSeconds();
        return hours + ":" + minutes + ":" + seconds    
  },  

});

window.PollView = Backbone.View.extend({
  tagName: 'li',
  className: 'poll',

    /*
  initialize: function() {
      this.model.on('change', this.render, this);
      this.model.on('destroy', this.remove, this);
  },*/

  render: function(){
      $(this.el).html(ich.pollTemplate(this.model.toJSON()));
      return this;
  }                                        
});


window.App = Backbone.View.extend({
  el: $('#app'),
 
  events: {
      'click .create' : 'createPoll',
  },
 
  initialize: function(){
      _.bindAll(this, 'addOne', 'addAll', 'render');
      this.polls = new PollList();
      this.polls.bind('add', this.addOne);
      this.polls.bind('reset', this.addAll, this.view);
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
                                 pub_date: this.polls.getCurrentDate(),         
                             });
          this.$('#question').val('');
      }
  }                                  
});


window.Router = Backbone.Router.extend({
    routes: {
            '': 'polls',
            'polls/:id/': 'detail'
        },
    navigate_to: function(model){
            var path = (model && model.get('id') + '/') || '';
            alert(path);
            this.navigate(path, true);
        },
});

window.app = window.app || {};
app.router = new Router();
app.polls = new PollList()
app.list = new App({
    el : $("#app"),
    collection : app.polls,
});
app.list.bind('navigate', app.router.navigate_to, app.router);
