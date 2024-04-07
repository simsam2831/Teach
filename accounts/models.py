from django.db import models

class Professor(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    age = models.IntegerField()
    years_of_experience = models.IntegerField()
    diploma = models.CharField(max_length=100)
    availability = models.CharField(max_length=100)  
    desired_salary = models.IntegerField()
    school_types = models.CharField(max_length=100) 

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

class School(models.Model):
    name = models.CharField(max_length=100)
    location = models.CharField(max_length=100)
    school_type = models.CharField(max_length=100)  

    def __str__(self):
        return self.name
