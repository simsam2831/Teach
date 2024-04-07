from django.shortcuts import render
from rest_framework import viewsets
from .models import Professor, School
from .serializers import ProfessorSerializer, SchoolSerializer
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets

class ProfessorViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = Professor.objects.all()
    serializer_class = ProfessorSerializer

class SchoolViewSet(viewsets.ModelViewSet):
    queryset = School.objects.all()
    serializer_class = SchoolSerializer