/**
 * @file @Observed和@ObjectLink装饰器.ets
 * @author Your Name
 * @date 2025/6/10
 * @description @Observed装饰器和@ObjectLink装饰器的应用
 */

interface mockDataType {
  username: string;
  comment: string;
  likes: number;
  comment_time: string;
  user_id: string;
  isLike: boolean | null
};

@Observed
export class mockDataTypeModel implements mockDataType {
  username: string = ''
  comment: string = ''
  likes: number = 0
  comment_time: string = ''
  user_id: string = ''
  isLike: boolean | null = null

  constructor(model: mockDataType) {
    this.username = model.username
    this.comment = model.comment
    this.likes = model.likes
    this.comment_time = model.comment_time
    this.user_id = model.user_id
    this.isLike = model.isLike
  }
}

@Component
struct NavHeader {
  build() {
    Row({ space: 16 }) {
      Row() {
        Image($r('app.media.chevron_left'))
          .size({ width: 12, height: 12 })
          .fillColor('#84848')
      }
      .width(24)
      .aspectRatio(1)
      .backgroundColor('#f5f5f5')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)

      Text('评论回复')
        .fontSize(18)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(48)
    .padding({ left: 12, right: 40 })
    .border({
      color: '#f4f4f4',
      width: {
        bottom: 1
      }
    })
  }
}

@Component
struct CommentContent {
  @ObjectLink items: mockDataTypeModel;

  @Styles imageStyles() {
    .width(12)
    .aspectRatio(1)
    .margin({
      right: 4
    })
  }

  build() {
    Row({space: 10}) {
      Text(this.items.username.slice(0, 1))
        .width(32)
        .aspectRatio(1)
        .borderRadius(16)
        .backgroundColor('#c3c4c5')
        .padding(4)
        .fontColor(Color.Blue)
        .textAlign(TextAlign.Center)

      Column({space: 8}) {
        Text(this.items.username)
          .fontSize(20)

        Text(this.items.comment)
          .fontSize(16)
          .fontColor('#565656')
          .width('100%')

        Row() {
          Text(`${this.items.comment_time} .IP属地深圳`)
            .fontSize(12)
            .fontColor('#c3c4c5')

          Row(){
            if(this.items.isLike) {
              Image($r('app.media.aixin')).imageStyles()
            } else {
              Image($r('app.media.greyAiXin')).imageStyles()
            }
            Text(`${this.items.likes}`)
              .fontSize(12)
              .fontColor('#c3c4c5')
          }
          .onClick(() => {
            if(this.items.isLike) {
              this.items.isLike = false;
              this.items.likes--;
            } else {
              this.items.isLike = true;
              this.items.likes++;
            };
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .padding(12)
    .alignItems(VerticalAlign.Top)
  }
}

@Entry
@Component
export default struct Observed_ObjectLink {
  @State mockData: mockDataTypeModel[] = [
    new mockDataTypeModel({
      "user_id": 'user_001',
      "username": "张三",
      "comment": "非常赞同你的观点，这个问题的分析很深入。",
      "likes": 150,
      "comment_time": "2024-05-19T09:30:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": 'user_002',
      "username": "王麻子",
      "comment": "这个问题真的很复杂，需要更多的数据支持。",
      "likes": 75,
      "comment_time": "2024-05-19T10:00:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": "user_005",
      "username": "孙七",
      "comment": "这个问题真的很复杂，需要更多的数据支持。",
      "likes": 75,
      "comment_time": "2024-05-19T10:00:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": "user_006",
      "username": "周八",
      "comment": "文章写得很好，受益匪浅。",
      "likes": 60,
      "comment_time": "2024-05-19T10:15:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": "user_007",
      "username": "吴九",
      "comment": "有些观点不太同意，希望能看到更多论证。",
      "likes": 50,
      "comment_time": "2024-05-19T10:30:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": "user_008",
      "username": "郑十",
      "comment": "这个话题很有趣，期待后续讨论。",
      "likes": 45,
      "comment_time": "2024-05-19T10:45:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": "user_009",
      "username": "王十一",
      "comment": "分析得很透彻，值得深思。",
      "likes": 40,
      "comment_time": "2024-05-19T11:00:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": "user_010",
      "username": "李十二",
      "comment": "内容很丰富，信息量大。",
      "likes": 35,
      "comment_time": "2024-05-19T11:15:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": "user_011",
      "username": "张十三",
      "comment": "有些地方没看懂，希望能解释一下。",
      "likes": 30,
      "comment_time": "2024-05-19T11:30:00Z",
      "isLike": false
    }),
    new mockDataTypeModel({
      "user_id": "user_012",
      "username": "赵十四",
      "comment": "这个话题很有争议，期待更多讨论。",
      "likes": 25,
      "comment_time": "2024-05-19T11:45:00Z",
      "isLike": false
    })
  ];
  @State commValue: string = '';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        NavHeader()
        CommentContent({ items: this.mockData[0] })
        Divider()
          .strokeWidth(6)
          .color('#f4f4f4')
        Scroll() {
          Column() {
            Text(`回复 ${this.mockData.length - 1}`)
              .width('100%')
              .fontSize(18)
              .margin({ left: 24, top: 12 })
            ForEach(this.mockData, (item: mockDataType, index: number) => {
              if (index !== 0) {
                CommentContent({ items: item })
              }
            })

            Text('暂时没有更多了')
              .width('100%')
              .height(40)
              .fontSize(12)
              .textAlign(TextAlign.Center)
              .fontColor('#cccccc')
          }
          .padding({
            bottom: 60
          })
        }
        .layoutWeight(1)
        .scrollBarWidth(0)
      }

      Row({space: 16}){
        TextInput({ placeholder: '回复~', text: this.commValue })
          .layoutWeight(1)
          .backgroundColor('#f4f5f6')
          .placeholderColor('#cccccc')
          .onChange((val: string) => {
            this.commValue = val;
          })
        Text('发布')
          .width(42)
          .fontSize(18)
          .fontColor('#6ecff0')
          .onClick(() => {
            const commObj: mockDataTypeModel = new mockDataTypeModel({
              user_id: `${new Date()}`,
              username: '福建第一贝利亚',
              comment: this.commValue,
              likes: 0,
              comment_time: `${new Date().getMonth()}-${new Date().getDay()}`,
              isLike: false
            });
            this.mockData.splice(1, 0, commObj);
            this.commValue = '';
          })
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .border({
        color: '#f4f5f6',
        width: {
          top: 1
        }
      })
      .padding({ left: 12, right: 12 })
    }
  }
}