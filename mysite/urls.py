from django.conf.urls import patterns, include, url
from django.conf.urls.defaults import *
from polls.api import PollResource

poll_resource = PollResource()

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', include(admin.site.urls)),
    (r'^api/', include(poll_resource.urls)),
)
