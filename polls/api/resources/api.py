from tastypie.authorization import Authorization
from tastypie.resources import ModelResource
from tastypie import fields
from polls.models import Poll
from polls.models import Choice


class PollResource(ModelResource):
    class Meta:
        queryset = Poll.objects.all()
        resource_name = 'polls'
        authorization = Authorization()

class ChoiceResource(ModelResource):

    poll = fields.ForeignKey(PollResource, 'poll')

    class Meta:
        queryset = Choice.objects.all()
        resource_name = 'choices'
