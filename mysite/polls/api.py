from tastypie.resources import ModelResource
from polls.models import Choice, Poll


class PollResource(ModelResource):
    class Meta:
        queryset = Poll.objects.all()
        # resource_name = 'entry'