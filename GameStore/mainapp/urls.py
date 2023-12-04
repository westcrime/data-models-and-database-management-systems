from django.urls import path
from . import views

urlpatterns = [
    path('', views.catalog, name = 'catalog'),
    path('catalog/', views.catalog, name = 'catalog'),
    path('news/', views.news, name = 'news'),
    path('about/', views.about, name = 'about'),
    path('profile/', views.profile, name = 'profile'),
    path('cart/', views.cart, name = 'cart'),
    path('library/', views.library, name = 'library'),
    path('logout/', views.logout, name = 'logout'),
    path('register/', views.register, name = 'register'),
    path('login/', views.login, name = 'login'),
]