from django.conf.urls.defaults import *
from polls.api import PollResource
from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

poll_resource = PollResource()

urlpatterns = patterns('',
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', include(admin.site.urls)),
    (r'^api/', include(poll_resource.urls)),
)