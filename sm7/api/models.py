# Create your models here.
from django.db import models

class Account(models.Model):
    # 이름, 이메일, 비번, 생성시간 데이터를 정의 DB의 table을 만든 부분
    name = models.CharField(max_length = 50)
    email = models.CharField(max_length = 200)
    password = models.CharField(max_length = 200)
    created_at = models.DateTimeField(auto_now_add=True)    # 객체 생성시간을 자동으로 넣어준다.