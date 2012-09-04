from django.conf.urls import patterns, include, url
from polls.api.resources.api import PollResource, ChoiceResource
from tastypie.api import Api

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

v1_api = Api(api_name='v1')
v1_api.register(PollResource())
v1_api.register(ChoiceResource())

urlpatterns = patterns('',
    url(r'^polls/', include('polls.urls')),    
    url(r'^admin/', include(admin.site.urls)),
    (r'^api/', include(v1_api.urls)),
)
