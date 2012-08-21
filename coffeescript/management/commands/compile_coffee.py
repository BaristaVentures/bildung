from django.core.management.base import NoArgsCommand, CommandError
import os

class Command(NoArgsCommand):
    help = 'Compiles coffeescript into javascript'

    def handle(self, **options):
        f = os.popen("coffee --join static/js/app.js --compile static/coffee/*.coffee")
        for i in f.readlines():
            print i
