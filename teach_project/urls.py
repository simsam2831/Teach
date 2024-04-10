from django.urls import path, include
from rest_framework.routers import DefaultRouter
from accounts import views
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from django.contrib import admin
from accounts.views import UserCreateView


router = DefaultRouter()
router.register(r'users', views.UserViewSet, basename='user') 

urlpatterns = [
    path('', include(router.urls)),
    path('users/', UserCreateView.as_view(), name='user-create'),
    path('admin/', admin.site.urls),
    path('api/', include('accounts.urls')),
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]
