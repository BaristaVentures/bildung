from django.conf.urls.defaults import *
from api.resources import PollResource, ChoiceResource
from django.conf.urls import patterns, include, url
from tastypie.api import Api
# from django.conf.urls.defaults import *
# from tastypie.api import Api
# from polls.api import PollResource, ChoiceResource


from django.contrib import admin
admin.autodiscover()

v1_api = Api(api_name='rest')
v1_api.register(PollResource())
v1_api.register(ChoiceResource())

# poll_resource = PollResource()

urlpatterns = patterns('',
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', include(admin.site.urls)),
    (r'^api/', include(v1_api.urls)),
)