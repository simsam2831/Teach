from django.urls import path, include
from django.contrib import admin
from accounts.views import UserCreateView, LoginView
from rest_framework.routers import DefaultRouter
from accounts import views

router = DefaultRouter()
router.register(r'users', views.UserViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('api/users/', UserCreateView.as_view(), name='user-create'),
    path('api/login/', LoginView.as_view(), name='login'),  # Ajout du chemin pour l'authentification
]
