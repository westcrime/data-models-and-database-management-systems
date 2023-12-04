from django.http import HttpResponse
from django.shortcuts import render
from .models import *

def catalog(request):
    if 'sort' in request.GET:
        context = {'page_name': 'catalog', 'games': DbService.get_games(sort_factor=request.GET.get('sort'))}
    else:
        context = {'page_name': 'catalog', 'games': DbService.get_games()}
    return render(request, 'catalog.html', context)

def news(request):
    context = {'page_name': 'catalog', 'games': DbService.get_games()}
    return render(request, 'catalog.html', context)

def about(request):
    context = {'page_name': 'catalog', 'games': DbService.get_games()}
    return render(request, 'catalog.html', context)

def profile(request):
    context = {'page_name': 'catalog', 'games': DbService.get_games()}
    return render(request, 'catalog.html', context)

def cart(request):
    context = {'page_name': 'catalog', 'games': DbService.get_games()}
    return render(request, 'catalog.html', context)

def library(request):
    context = {'page_name': 'catalog', 'games': DbService.get_games()}
    return render(request, 'catalog.html', context)

def login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        if CurrentUser.login(username, password) != None:
            return redirect('catalog')
        else:
            return render(request, 'login.html')
    else:
        return render(request, 'login.html')
    
def register(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        confirm_password = request.POST.get('confirm_password')
    else:
        return render(request, 'register.html')

def logout(request):
    context = {'page_name': 'catalog', 'games': DbService.get_games()}
    return render(request, 'catalog.html', context)