from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import Account
from .serializers import AccountSerializer
from rest_framework.parsers import JSONParser
# Create your views here.

# API를 만들 경우 CSRF 보안이 필요하지 않다. API 서버는 API Key등 다른 인증 방식을 사용한다.
@csrf_exempt
def account_list(request):      
    if request.method == "GET":             # 입력된 정보를 모두 조회
        query_set = Account.objects.all()
        serializer = AccountSerializer(query_set, many=True)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == "POST":          # 신규주소를 생성(회원가입)
        data = JSONParser().parse(request)
        serializer = AccountSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def account(request, pk):                   # 호출시 pk번호를 조회해 해당 번호와 맞는 데이터를 조회, 수정, 삭제
    obj = Account.objects.get(pk=pk)

    if request.method == "GET":
        serializer = AccountSerializer(obj)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == "PUT":
        data = JSONParser().parse(request)
        serializer = AccountSerializer(obj, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

    elif request.method == "DELETE":
        obj.delete()
        return HttpResponse(status=204)

@csrf_exempt
def login(request):                         # login api 호출시 email과 password를 입력했을때 DB데이터와 일치하면 200 아니면 400호출
    if request.method == "POST":
        data = JSONParser().parse(request)
        search_email = data['email']
        obj = Account.objects.get(email=search_email)

        if data['password'] == obj.password:
            return HttpResponse(status=200)
        else:
            return HttpResponse(status=400)
