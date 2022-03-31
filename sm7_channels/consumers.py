from asyncio import events
import json
from channels.generic.websocket import AsyncWebsocketConsumer


class DetectData(AsyncWebsocketConsumer):

    async def connect(self):
        # 그룹의 이름을 지정
        self.group_name='detectData'

        # 채널 레이어를 통해 그룹을 생성
        await self.channel_layer.group_add(
            self.group_name,
            self.channel_name
        )
        print("debug1")     # 핸드쉐이킹 하고 접속하기전에 출력
        # 웹소켓 연결을 받는다.
        await self.accept()
        await self.send("dj")
        print("debug2")

    async def disconnect(self,close_code):
        pass

    async def receive(self,text_data):
        print('debug3')
        # 웹소켓으로 부터 데이터를 받으면 그룹으로 메시지를 보낸다.
        print(text_data)
        await self.channel_layer.group_send(
            # 얘가 event
            self.group_name,
            {
                'type':'randomFunction',
                'value':text_data,
            }
        )
        await self.send(text_data)

    # 받아온 이벤트의 값 == text_data를 출력해준다.
    async def randomFunction(self,event):
        print (event['value'])
        print ("event")
        await self.send(event['value'])


class Test1(AsyncWebsocketConsumer):

    async def connect(self):
        print("debug")
        await self.accept()
        print("debug2")
        await self.send(text_data=json.dumps({'type':'receive'}))

    async def disconnect(self,close_code):
        pass

    async def receive(self,text_data):
        # 웹소켓으로 부터 데이터를 받으면 그룹으로 메시지를 보낸다.
        print(text_data)
        await self.send(text_data)
        