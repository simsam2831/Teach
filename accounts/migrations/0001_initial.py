# Generated by Django 5.0.4 on 2024-04-07 14:03

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Professor",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("first_name", models.CharField(max_length=100)),
                ("last_name", models.CharField(max_length=100)),
                ("age", models.IntegerField()),
                ("years_of_experience", models.IntegerField()),
                ("diploma", models.CharField(max_length=100)),
                ("availability", models.CharField(max_length=100)),
                ("desired_salary", models.IntegerField()),
                ("school_types", models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name="School",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=100)),
                ("location", models.CharField(max_length=100)),
                ("school_type", models.CharField(max_length=100)),
            ],
        ),
    ]
