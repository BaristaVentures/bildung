from tastypie.resources import ModelResource
from polls.models import Choice, Poll
from tastypie import fields
from tastypie.authorization import Authorization

class PollResource(ModelResource):
    #choices = fields.ToManyField('api.resources.ChoiceResource', 'choice_set', full=True)

    class Meta:
        queryset = Poll.objects.all()
        authorization = Authorization()
        resource_name = 'polls'
        list_allowed_methods = ['get', 'post', 'delete', 'put']
        # http://127.0.0.1:8000/api/rest/polls/?format=json
        
    def dehydrate(self, bundle):
         bundle.data['choices'] = [{'choice':ch.choice, 'votes':ch.votes} for ch in bundle.obj.choice_set.all()]
         return bundle

class ChoiceResource(ModelResource):
    poll = fields.ForeignKey(PollResource, 'poll', full=True)

    class Meta:
        queryset = Choice.objects.all()
        authorization = Authorization()
        resource_name = 'choices'
        list_allowed_methods = ['get', 'post', 'delete', 'put']
