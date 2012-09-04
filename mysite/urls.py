from django.conf.urls import patterns, include, url
from polls.api.resources.api import PollResource

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

poll_resource = PollResource()

urlpatterns = patterns('',
    (r'^api/', include(poll_resource.urls)),
    url(r'^admin/', include(admin.site.urls)),
)
