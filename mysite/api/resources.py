from tastypie.resources import ModelResource
from polls.models import Choice, Poll
from tastypie import fields
from tastypie.authorization import Authorization

class PollResource(ModelResource):
    class Meta:
        queryset = Poll.objects.all()
        authorization = Authorization()
        resource_name = 'polls'
        # authorization= Authorization()
        # allowed_methods = ['get']

class ChoiceResource(ModelResource):
    poll = fields.ForeignKey(PollResource, 'poll')

    class Meta:
        queryset = Choice.objects.all()
        authorization = Authorization()
        resource_name = 'choices'
