from polls.models import Poll, Choice
from django.contrib import admin

class ChoiceInline(admin.TabularInline):
    model = Choice
    # Number of inline options that will be shwoing by default.
    extra = 3

class PollAdmin(admin.ModelAdmin):
    # This fieldset separate the information in the form view by giving names
    # to the sections.
    # The 'collapse' option collapse the section that is indicated.
    fieldsets = [
        (None, {'fields': ['question']}),
        ('Date information', {'fields': ['pub_date'], 'classes': ['collapse']}),
        ]
    # This option allows the user to add new choices to the poll by inline.
    inlines = [ChoiceInline]
    # This option shows the information that is needed.
    list_display = ('question', 'pub_date', 'was_published_recently')
    # Add a filter side bar using this field as the criterion.
    list_filter = ['pub_date']
    
    # Add a search option for the question field.
    search_fields = ['question']

    # Drill down the polls by date.
    date_hierarchy = 'pub_date'

admin.site.register(Poll, PollAdmin)
