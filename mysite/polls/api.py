from tastypie.resources import ModelResource
from polls.models import Choice, Poll
from tastypie import fields


class PollResource(ModelResource):
    class Meta:
        queryset = Poll.objects.all()
        # resource_name = 'poll'
        # authorization= Authorization()

class ChoiceResource(ModelResource):
    poll = fields.ForeignKey(PollResource, 'poll')

    class Meta:
        queryset = Choice.objects.all()
        # resource_name = 'choice'
