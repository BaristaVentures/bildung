from tastypie.resources import ModelResource
from polls.models import Poll

class MyModelResource(ModelResource):
    class Meta:
        queryset = Poll.objects.all()
        allowed_methods = ['get']
