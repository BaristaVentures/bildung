from django.http import Http404
from django.shortcuts import render_to_response, get_object_or_404
from polls.models import Choice, Poll
from django.template import RequestContext
from django.http import HttpResponseRedirect, HttpResponse
from django.core.urlresolvers import reverse


def vote(request, poll_id):
    p = get_object_or_404(Poll, pk = poll_id)
    try:
        selected_choice = p.choice_set.get(pk = request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        return render_to_response('polls/detail.html', {'poll' : p, 'error_message' : "You didn't select a choice",}, context_instance = RequestContext(request))
    else: 
        selected_choice.votes += 1
        selected_choice.save()
        return HttpResponseRedirect(reverse('poll_results', args = (p.id,)))
