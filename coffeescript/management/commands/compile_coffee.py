from django.core.management.base import NoArgsCommand, CommandError
import os

class Command(NoArgsCommand):
    help = 'Compiles coffeescript into javascript'

    def handle(self, **options):
        path = "mysite/web/resources/web"
        f = os.popen("coffee --join " + path +"/js/app.js --compile " + path + "/coffee/*.coffee")
        for i in f.readlines():
            print i
