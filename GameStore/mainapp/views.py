from django import conf
from django.http import HttpResponse
from django.shortcuts import redirect, render
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
    if CurrentUser.is_authenticated:
        context = {'page_name': 'cart', 'cart_games': DbService.get_cart_games(CurrentUser.user_id)}
        return render(request, 'cart.html', context)
    else:
        return redirect('catalog')

def library(request):
    if CurrentUser.is_authenticated:
        games = DbService.get_library_games()
        if games != None:
            context = {'page_name': 'library', 'games': games}
            return render(request, 'library.html', context)
        else:
            return redirect('catalog')
    else:
        return redirect('catalog')

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
        email = request.POST.get('email')
        password = request.POST.get('password')
        confirm_password = request.POST.get('confirm_password')
        if confirm_password == password:
            if CurrentUser.register(nickname=username, password=password, email=email, role_id=1) != None:
                return redirect('catalog')
            else:
                return render(request, 'register.html')
    else:
        return render(request, 'register.html')

def logout(request):
    if CurrentUser.is_authenticated:
        CurrentUser.logout()
    return redirect('catalog')

def game_details(request, game_id):
    context = {'page_name': 'game_details', 'game': DbService.get_game(game_id)}
    return render(request, 'game_details.html', context)

def add_game_to_cart(request, game_id):
    if CurrentUser.is_authenticated:
        DbService.add_game_to_cart(game_id, CurrentUser.user_id)
    return redirect('catalog')

def add_game_to_wishlist(request, game_id):
    context = {'page_name': 'catalog', 'games': DbService.get_games()}
    return render(request, 'catalog.html', context)

def remove_game_from_cart(request, game_id):
    if CurrentUser.is_authenticated:
        if DbService.remove_game_from_cart(game_id):
            return redirect('cart')
        else:
            return redirect('catalog')
    else:
        return redirect('login')

def add_games_to_order(request):
    if CurrentUser.is_authenticated:
        if DbService.create_order():
            return redirect('orders')
        else:
            return redirect('catalog')
    else:  
        return redirect('login')

def pay_order(request, order_id):
    if CurrentUser.is_authenticated:
        if DbService.pay_order(order_id):
            return redirect('orders')
        else:
            return redirect('catalog')
    else:  
        return redirect('login')

def orders(request):
    if CurrentUser.is_authenticated:
        orders = DbService.get_orders()
        if orders != None:
            context = {'page_name': 'orders', 'orders': orders}
            return render(request, 'orders.html', context)
        else:
            return redirect('catalog')
    else:
        return redirect('login')