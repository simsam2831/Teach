# Generated by Django 5.0.4 on 2024-04-10 17:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("accounts", "0002_school_address_school_school_name_teacher_age_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="teacher",
            name="age",
            field=models.CharField(default="25", max_length=3),
        ),
    ]