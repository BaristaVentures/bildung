from django.conf.urls import patterns, include, url
from django.views.generic import ListView
from django.views.generic import DetailView as dv
from .views import DetailView, IndexView
from polls.models import Poll

# Uncomment the next two lines to enable the admin:
#from django.contrib import admin
#admin.autodiscover()

urlpatterns = patterns('',
  url(r'^$',
    IndexView.as_view(),
      name='index'),
  url(r'^(?P<pk>\d+)/$',
    DetailView.as_view(),
      name='detail'),
  url(r'^(?P<pk>\d+)/results/$',
    dv.as_view(
      model=Poll,
      template_name='polls/results.html'),
      name='poll_results'),
  url(r'^(?P<poll_id>\d+)/vote/$', 'polls.views.vote'),
)

