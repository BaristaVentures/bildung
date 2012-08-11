from tastypie.resources import ModelResource
from polls.models import Poll


class PollResource(ModelResource):
    class Meta:
        queryset = Poll.objects.all()
        resource_name = 'polls'
