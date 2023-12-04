from django import template

from mainapp.models import CurrentUser

register = template.Library()


@register.inclusion_tag('nav_menu.html')
def show_navbar_menu(menu=None):
    menu = [
        {'title': "Каталог", 'url_name': 'catalog'},
        {'title': "Новости", 'url_name': 'news'},
        {'title': "О сайте", 'url_name': 'about'}]
    user_menu = [
        {'title': "Мой профиль", 'url_name': 'profile'},
        {'title': "Корзина", 'url_name': 'cart'},
        {'title': "Библиотека", 'url_name': 'library'},
        {'title': "Выйти из профиля", 'url_name': 'logout'},]

    return {"menu": menu, "user_menu": user_menu, 'username': CurrentUser.get_username()}