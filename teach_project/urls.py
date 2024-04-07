from django.urls import path, include
from rest_framework.routers import DefaultRouter
from accounts import views

router = DefaultRouter()
router.register(r'professors', views.ProfessorViewSet)
router.register(r'schools', views.SchoolViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
