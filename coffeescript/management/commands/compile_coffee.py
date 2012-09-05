from django.core.management.base import NoArgsCommand, CommandError
import os, sys
import subprocess

class Command(NoArgsCommand):
    help = 'Compiles coffeescript into javascript'

    def handle(self, **options):
        coffee_path = "mysite/web/resources/web/coffee/"
        js_path = "mysite/web/resources/web/js/"
        
        command = "coffee -o %s -cw %s" % (js_path, coffee_path)
       
        print "Watching changes..."

        try:
            # This command compile the Coffee Script and whatch it for changes.
            f = subprocess.call(command, shell=True)
                
            # Print subprocess's output while running.
            while True:
                print f.readline(),
        except (KeyboardInterrupt):
            print "Done"
            sys.exit(0)
