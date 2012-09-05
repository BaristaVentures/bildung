"""
This file demonstrates writing tests using the unittest module. These will pass
when you run "manage.py test".

Replace this with more appropriate tests for your application.
"""

from django.test import TestCase
from django.utils import timezone
from polls.models import Poll, Choice

class PollTest(TestCase):
    def test_polls_creation(self):
        """
        Tests that create polls.
        """
        poll_question = "Is this a test?"
        poll_pub_date = timezone.now()
        poll = Poll.objects.create(question=poll_question, pub_date=poll_pub_date)
        self.assertEqual(poll.question, poll_question)
        self.assertEqual(poll.pub_date, poll_pub_date)

class ChoiceTest(TestCase):
    def test_choice_creattion(self):
        """
        Tests a choice creation for a poll.
        """
        poll = Poll.objects.create(question="Is this a test?", pub_date=timezone.now())
        choice_name = "yes, this is a test."
        choice_votes = 0
        choice = Choice.objects.create(poll=poll, choice=choice_name, votes=choice_votes)
        self.assertEqual(choice.choice, choice_name)
        self.assertEqual(choice.votes, choice_votes)
        self.assertEqual(choice.poll, poll)
        
