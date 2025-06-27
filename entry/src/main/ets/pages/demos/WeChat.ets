/**
 * @file WeChat.ets
 * @author Your Name
 * @date 2025/6/25
 * @description 用户首选项
 */
import { preferences } from '@kit.ArkData';
import http from '@ohos.net.http';
import { util } from '@kit.ArkTS';

interface MessageItems {
  // 消息内容
  content: string;

  // 用户头像
  avatar: ResourceStr;

  // 用户昵称
  username: string;

  // 消息id
  id: string;
  timestamp: number;

  // 是否是自己发送的消息
  self: boolean;
};

class MessageStore {
  async getStore() {
    return await preferences.getPreferences(getContext(), "message_store");
  };

  async setMessageList(json: string) {
    const store = await this.getStore();
    await store.put("message_list", json)
    await store.flush();
  };

  async getMessageList() {
    const store = await this.getStore();
    const data = await store.get("message_list", "[]") as string;
    return JSON.parse(data);
  };
}

interface resultType {
  content: string;
  result: number;
}

@Component
struct MsgList {
  @Prop msg: Partial<MessageItems> = {};

  @Builder
  contacts() {
    Row({ space: 8 }) {
      Image($r('app.media.waimai')).width(28).aspectRatio(1);
      Text(this.msg.content)
        .backgroundColor(Color.White)
        .padding(8)
      Text().width(28)
    }
  };

  @Builder
  selfItem() {
    Text().width(28)
    Text(this.msg.content)
      .backgroundColor('#a9ea7a')
      .padding(8)
    Image($r('app.media.waimai')).width(28).aspectRatio(1)
  }

  build() {
    Row() {
      if (this.msg.self) {
        this.selfItem()
      } else {
        this.contacts()
      }
    }
    .width('100%')
  }
}

@Entry
@Component
struct WeChat {
  MessageStore: MessageStore = new MessageStore();
  @State inputVal: string = '';
  @State @Watch('updateMessageList') messageList: MessageItems[] = [];
  private http: http.HttpRequest = http.createHttp();
  private scroller: ListScroller = new ListScroller();

  updateMessageList() {
    this.MessageStore.setMessageList(JSON.stringify(this.messageList));
    this.scroller.scrollToIndex(this.messageList.length - 1);
  };

  async getMessageList() {
    this.messageList = await this.MessageStore.getMessageList();
  }

  aboutToAppear(): void {
    this.getMessageList();
  };

  // 发起对话获取对话内容
  async sendMessage() {
    const contentStr = this.inputVal;
    const msg: MessageItems = {
      id: util.generateRandomUUID(),
      content: contentStr,
      avatar: '',
      timestamp: Date.now(),
      username: '李四',
      self: true,
    };
    this.messageList.push(msg);
    this.inputVal = '';

    const res =
      await this.http.request(`http://api.qingyunke.com/api.php?key=free&appid=0&msg=${encodeURI(contentStr)}`);
    const result = JSON.parse(res.result as string) as resultType;

    if (result.result === 0) {
      const resMsg: MessageItems = {
        id: util.generateRandomUUID(),
        content: result.content,
        avatar: '',
        timestamp: Date.now(),
        username: '李四',
        self: false,
      };
      this.messageList.push(resMsg);
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 12 }) {
        Text('🤯饭醉团伙')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({
            top: 12,
            bottom: 12,
          })
          .fontSize(18)

        List({ space: 12, initialIndex: this.messageList.length - 1, scroller: this.scroller }) {
          ForEach(this.messageList, (msg: MessageItems) => {
            ListItem() {
              Row({ space: 8 }) {
                if (msg.self) {
                  Text().width(28)
                  Text(msg.content)
                    .backgroundColor('#a9ea7a')
                    .padding(8)
                }
                Image($r('app.media.waimai')).width(28).aspectRatio(1)
                if (!msg.self) {
                  Text(msg.content)
                    .backgroundColor(Color.White)
                    .padding(8)
                  Text().width(28)
                }
              }
              .width('100%')
              .justifyContent(msg.self ? FlexAlign.End : FlexAlign.Start)
            }
          }, (msg: MessageItems) => msg.id)
        }
        .width('100%')
        .listDirection(Axis.Vertical)
        .scrollBar(BarState.Off)
        .padding({
          left: 14,
          right: 14,
          bottom: 120
        })
      }
      .width('100%')
      .height('100%')


      Row({ space: 12 }) {
        TextInput({ text: this.inputVal })
          .layoutWeight(1)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .onChange((val: string) => {
            this.inputVal = val
          })
        Button('发送', { type: ButtonType.Normal })
          .fontSize(18)
          .width(70)
          .borderRadius(8)
          .onClick(() => {
            if (this.inputVal) {
              this.sendMessage();
            }
          })

        Button('清空', { type: ButtonType.Normal })
          .fontSize(18)
          .width(70)
          .borderRadius(8)
          .onClick(() => {
            this.messageList = [];
          })
      }
      .width('100%')
      .backgroundColor('#f3f3f3')
      .padding(12)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f3f3f3')
  }
}