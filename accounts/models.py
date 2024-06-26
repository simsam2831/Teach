from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.db import models

class UserManager(BaseUserManager):
    def create_user(self, username, email, password=None, **extra_fields):
        if not username:
            raise ValueError('The Username must be set')
        if not email:
            raise ValueError('The Email must be set')
        email = self.normalize_email(email)
        user = self.model(username=username, email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        return self.create_user(username, email, password, **extra_fields)

class User(AbstractBaseUser):
    username = models.CharField(max_length=40, unique=True)
    email = models.EmailField(unique=True)
    account_type = models.CharField(max_length=10, choices=(('Teacher', 'Teacher'), ('School', 'School')))
    objects = UserManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']


class School(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='school')
    school_name = models.CharField(max_length=100, default='School Name')
    address = models.CharField(max_length=255, default='Address')

    def __str__(self):
        return self.school_name
    

class Job(models.Model):
    title = models.CharField(max_length=255, verbose_name="Intitulé")
    description = models.TextField(verbose_name="Description")
    duration = models.CharField(max_length=100, verbose_name="Durée")
    salary = models.CharField(max_length=100, blank=True, null=True, verbose_name="Salaire")
    school_name = models.CharField(max_length=255, verbose_name="Nom de l'école")
    school = models.ForeignKey(School, on_delete=models.CASCADE, related_name='jobs')

    def __str__(self):
        return self.title


class Teacher(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='teacher')
    first_name = models.CharField(max_length=100, default='First Name')
    last_name = models.CharField(max_length=100, default='Last Name')
    age = models.CharField(max_length=3, default='25')
    years_of_experience = models.CharField(max_length=50, default='0-1 years')
    availability = models.CharField(max_length=100, default='Available')

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

