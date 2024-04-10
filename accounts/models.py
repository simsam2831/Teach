from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.db import models

class UserManager(BaseUserManager):
    # Méthodes pour créer user et superuser
    pass

class User(AbstractBaseUser):
    email = models.EmailField(unique=True)
    # Autres champs communs
    objects = UserManager()

    USERNAME_FIELD = 'email'

class Teacher(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    # champs spécifiques à Teacher

class School(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    # champs spécifiques à School
