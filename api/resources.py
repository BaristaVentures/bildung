from tastypie.authorization import Authorization
from tastypie import fields
from tastypie.resources import ModelResource
from polls.models import Poll, Choice, Comment


class PollResource(ModelResource):
    class Meta:
        queryset = Poll.objects.all()
        resource_name = 'polls'
        allowed_methods = ['get', 'post', 'delete', 'put']
        authorization = Authorization()
        

class ChoiceResource(ModelResource):
    poll = fields.ForeignKey(PollResource, 'poll')
    class Meta:
        queryset = Choice.objects.all()
        resource_name = 'choices'
        allowed_methods = ['get', 'post', 'delete', 'put']
        authorization = Authorization()

class CommentResource(ModelResource):
    poll = fields.ForeignKey(PollResource, 'poll')
    
    class Meta:
        queryset = Comment.objects.all()
        resource_name = 'comments'
        allowed_methods = ['get', 'post', 'delete', 'put']
        authorization = Authorization()
        always_return_data = True
