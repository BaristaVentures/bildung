from django.conf.urls import patterns, include, url
from django.conf.urls.defaults import *
from polls.api import PollResource, ChoiceResource

poll_resource = PollResource()
choice_resource = ChoiceResource()

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', include(admin.site.urls)),
    (r'^api/', include(poll_resource.urls)),
    (r'^api/', include(choice_resource.urls)),
)
