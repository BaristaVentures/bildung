from django.core.management.base import NoArgsCommand, CommandError
import os

class Command(NoArgsCommand):
    help = 'Compiles coffeescript into javascript'

    def handle(self, **options):
        path = "mysite/web/resources/web"
        f = os.popen("coffee --join %s/js/app.js --compile %s/coffee/*.coffee" % (path, path))
        for i in f.readlines():
            print i
