from django.conf.urls import patterns, include, url
from django.conf.urls.defaults import *
from tastypie.api import Api
from api.resources import PollResource, ChoiceResource, CommentResource
from mysite.views import BackbonePage, CoffeeScriptPage
from django.conf import settings
from django.contrib.staticfiles.urls import staticfiles_urlpatterns

v1_api = Api(api_name='v1')
v1_api.register(PollResource())
v1_api.register(ChoiceResource())
v1_api.register(CommentResource())

# Uncomment the next two lines to enable the admin:
from django.contrib import admin

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^api/', include(v1_api.urls)),
    url(r'^backbone/$', BackbonePage.as_view()),
    url(r'^coffeescript/$', CoffeeScriptPage.as_view()),
)

urlpatterns += patterns('',
        (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT}),
    )
