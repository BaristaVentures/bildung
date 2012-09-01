from django.views.generic import TemplateView

class BackbonePage(TemplateView):
    template_name = "backbone.html"

class CoffeeScriptPage(TemplateView):
    template_name = "coffeescript.html"

class HomePage(TemplateView):
    template_name = "home.html"
