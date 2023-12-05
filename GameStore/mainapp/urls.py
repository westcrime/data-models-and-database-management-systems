from django.urls import path
from . import views

urlpatterns = [
    path('', views.catalog, name = 'catalog'),
    path('catalog/', views.catalog, name = 'catalog'),
    path('news/', views.news, name = 'news'),
    path('about/', views.about, name = 'about'),
    path('profile/', views.profile, name = 'profile'),
    path('orders/', views.orders, name = 'orders'),
    path('cart/', views.cart, name = 'cart'),
    path('library/', views.library, name = 'library'),
    path('logout/', views.logout, name = 'logout'),
    path('register/', views.register, name = 'register'),
    path('login/', views.login, name = 'login'),
    path('game/<int:game_id>/', views.game_details, name='game_details'),
    path('add_game_to_cart/<int:game_id>/', views.add_game_to_cart, name='add_game_to_cart'),
    path('remove_game_from_cart/<int:game_id>/', views.remove_game_from_cart, name='remove_game_from_cart'),
    path('add_game_to_wishlist/<int:game_id>/', views.add_game_to_wishlist, name='add_game_to_wishlist'),
    path('add_games_to_order/', views.add_games_to_order, name='add_games_to_order'),
    path('pay_order/<int:order_id>/', views.pay_order, name='pay_order'),
    path('add_money_to_balance/', views.pay_order, name='pay_order'),
]