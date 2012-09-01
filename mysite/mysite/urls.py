from django.conf.urls import patterns, include, url
from django.contrib import admin
from tastypie.api import Api
from api.resources import MyModelResource

admin.autodiscover()


v1_api = Api(api_name = ' v1')
v1_api.register(MyModelResource())
urlpatterns = patterns('',
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^api/', include(v1_api.urls)),
                  
)
