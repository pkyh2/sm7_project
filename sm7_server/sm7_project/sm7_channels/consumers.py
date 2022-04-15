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
        # 웹소켓 연결을 받는다.
        print(self.group_name)
        await self.accept()

    async def disconnect(self, close_code):
        pass

    async def receive(self, text_data):
        await self.channel_layer.group_send(
            # 얘가 event
            self.group_name,
            {
                'type':'sendFunction',
                'value':text_data,
            }
        )

    # 받아온 이벤트의 값 == text_data를 출력해준다.
    async def sendFunction(self,event):
        await self.send(event['value'])