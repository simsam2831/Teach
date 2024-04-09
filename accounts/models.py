from django.db import models

class Professor(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    age = models.IntegerField()
    years_of_experience = models.CharField(max_length=50)  # Changed to CharField to accommodate the options like "0-1 years", etc.
    phone_number = models.CharField(max_length=30)  # To store phone numbers as string
    hourly_rate = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)  # To store hourly rate as decimal and make it optional

    def __str__(self):
        return f"{self.first_name} {self.last_name}"


class School(models.Model):
    name = models.CharField(max_length=100)
    location = models.CharField(max_length=100)
    school_type = models.CharField(max_length=100)  

    def __str__(self):
        return self.name
