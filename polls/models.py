import datetime
from django.db import models
from django.utils import timezone

# Create your models here.

class Poll(models.Model):
    question = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')

    def __unicode__(self):
        return self.question

    def was_published_recently(self):
        return self.pub_date >= timezone.now() - datetime.timedelta(days=1)
    was_published_recently.admin_order_field = 'pub_date'
    was_published_recently.boolean = True
    was_published_recently.short_description = 'Published recently?'

class Choice(models.Model):
    poll = models.ForeignKey(Poll)
    choice = models.CharField(max_length=200)
    votes = models.IntegerField()

    def __unicode__(self):
        return self.choice

class Comment(models.Model):
    poll = models.ForeignKey(Poll)
    author = models.CharField(max_length=20)
    comment = models.TextField(max_length=1000)
    pub_date = models.DateTimeField('date published')
    
    def __unicode__(self):
        comment = {
            'Author': self.author,
            'Comment': self.comment,
            'Pub Date': self.pub_date,
            'Poll': self.poll,
        }

        return str(comment)
        #return u'Author: %s, Comment: %s, Pub Date: %s, Poll: %s' % (self.author, self.comment, self.pub_date, self.poll)
