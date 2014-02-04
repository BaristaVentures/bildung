(function(){
    window.Poll = Backbone.Model.extend({
        urlRoot: POLLS_API

    });

    window.Polls = Backbone.Collection.extend({
        urlRoot: POLLS_API,
        model: Poll, 

        // maybeFetch: function(options){
        //     // Helper function to fetch only if this collection has not been fetched before.
        //     if(this._fetched){
        //         // If this has already been fetched, call the success, if it exists
        //         options.success && options.success();
        //         return;
        //     }

        //     // when the original success function completes mark this collection as fetched
        //     var self = this,
        //         successWrapper = function(success){
        //             return function(){
        //                 self._fetched = true;
        //                 success && success.apply(this, arguments);
        //             };
        //         };
        //     options.success = successWrapper(options.success);
        //     this.fetch(options);
        // },

        // getOrFetch: function(id, options){
        //     // Helper function to use this collection as a cache for models on the server
        //     var model = this.get(id);

        //     if(model){
        //         options.success && options.success(model);
        //         return;
        //     }

        //     model = new Poll({
        //         resource_uri: id
        //     });

        //     model.fetch(options);
        // }        
    });
    window.PollView = Backbone.View.extend({
        tagName: 'li',

        initialize: function(){
          _.bindAll(this, 'render'); // every function that uses 'this' as the current object should be in here
        },


        // className: 'tweet',

        // events: {
        //     'click .permalink': 'navigate'           
        // },

        // initialize: function(){
        //     this.model.bind('change', this.render, this);
        // },

        // navigate: function(e){
        //     this.trigger('navigate', this.model);
        //     e.preventDefault();
        // },

        render: function(){
            $(this.el).html(this.model.  ());
            return this;
        }                                        
    });

    window.ListView = Backbone.View.extend({

        el: $('body'),

        initialize: function(){
            _.bindAll(this, 'addOne', 'addAll');

            this.collection.bind('add', this.addOne);
            this.collection.bind('reset', this.addAll, this);
            this.views = [];
        },

        addAll: function(){
            this.views = [];
            this.collection.each(this.addOne);
        },

        addOne: function(poll){
            var view = new PollView({
                model: Poll
            });
            $(this.el).prepend(view.render().el);
            this.views.push(view);
            view.bind('all', this.rethrow, this);
        },

        // rethrow: function(){
        //     this.trigger.apply(this, arguments);
        // }

    });

    window.Router = Backbone.Router.extend({
        routes: {
            '': 'list',
            ':id/': 'detail'
        },

        navigate_to: function(model){
            var path = (model && model.get('id') + '/') || '';
            this.navigate(path, true);
        },

        detail: function(){},

        list: function(){}
    });
 var listView = new ListView();
})();