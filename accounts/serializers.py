from rest_framework import serializers
from .models import Teacher, School, User
from django.contrib.auth import get_user_model

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    account_type = serializers.ChoiceField(choices=['Teacher', 'School'], write_only=True)
    
    #Teacher
    first_name = serializers.CharField(write_only=True, required=False)
    last_name = serializers.CharField(write_only=True, required=False)
    age = serializers.IntegerField(write_only=True, required=False)
    years_of_experience = serializers.CharField(write_only=True, required=False)
    availability = serializers.CharField(write_only=True, required=False)
    
    #School
    school_name = serializers.CharField(write_only=True, required=False)
    address = serializers.CharField(write_only=True, required=False)

    class Meta:
        model = User
        fields = ('username', 'email', 'password', 'account_type',
                  'first_name', 'last_name', 'age', 'years_of_experience', 'availability',
                  'school_name', 'address')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        account_type = validated_data.pop('account_type')

        # Ici, pop tous les champs qui ne sont pas destinés au modèle User
        user_data = {key: validated_data.pop(key) for key in ['username', 'email', 'password']}

        user = User.objects.create_user(**user_data)

        if account_type == 'Teacher':
            # Créez un enseignant avec les champs restants
            Teacher.objects.create(user=user, **validated_data)
        elif account_type == 'School':
            # Créez une école avec les champs restants
            School.objects.create(user=user, **validated_data)

        return user


