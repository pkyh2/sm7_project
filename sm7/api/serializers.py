from rest_framework import serializers
from .models import Account

# Account 모델로 만든 데이터를 json형태로 변환해준다.
class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['name', 'email', 'password']