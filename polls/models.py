import datetime
from django.db import models
from django.utils import timezone

# Create your models here.

class Poll(models.Model):
    question = models.CharField("poll's question", max_length=200)
    pub_date = models.DateTimeField("date published")

    def __unicode__(self):
        poll = { 
            'Question': self.question, 
            'Pub Date': self.pub_date 
        }
        return str(poll)

    def was_published_recently(self):
        return self.pub_date >= timezone.now() - datetime.timedelta(days=1)
    
    was_published_recently.admin_order_field = 'pub_date'
    was_published_recently.boolean = True
    was_published_recently.short_description = 'Published recently?'

class Choice(models.Model):
    poll = models.ForeignKey(Poll, verbose_name="related poll")
    choice = models.CharField("choice's name", max_length=200)
    votes = models.IntegerField("choices's votes")

    def __unicode__(self):
        choice = {
            'Poll': self.poll.id,
            'Choice': self.choice,
            'Votes': self.votes
        }
        return str(choice)

class Comment(models.Model):
    poll = models.ForeignKey(Poll, verbose_name="related poll")
    author = models.CharField("comment's author", max_length=20)
    comment = models.TextField("comment's body", max_length=1000)
    pub_date = models.DateTimeField("date published")
    
    def __unicode__(self):
        comment = {
            'Author': self.author,
            'Comment': self.comment,
            'Pub Date': self.pub_date,
            'Poll': self.poll,
        }

        return str(comment)
