from django.contrib.auth import get_user_model, authenticate, login
from rest_framework.response import Response
from .serializers import UserSerializer
from rest_framework import viewsets, status, views, generics
from .models import Teacher, School, User
from django.http import JsonResponse
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework.views import APIView

User = get_user_model()

class LoginView(views.APIView):
    def post(self, request, *args, **kwargs):
        user = authenticate(request, username=request.data.get('username'), password=request.data.get('password'))
        if user is not None:
            login(request, user)
            return Response({"success": True, "account_type": user.account_type})
        else:
            return Response({"success": False, "message": "Invalid credentials"}, status=400)

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserCreateView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            self.perform_create(serializer)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

def user_info(request, username):
    user = UserModel.objects.filter(username=username).first()
    if user:
        is_teacher = hasattr(user, 'teacher')
        is_school = hasattr(user, 'school')
        user_type = 'Teacher' if is_teacher else 'School' if is_school else 'Unknown'
        return JsonResponse({'userType': user_type})
    else:
        return JsonResponse({'error': 'User not found'}, status=404)
    
