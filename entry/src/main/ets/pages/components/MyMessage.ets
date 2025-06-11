/**
 * @file MyMessage.ets
 * @author Your Name
 * @date 2025/6/7
 * @description 我的消息页面组件
 */

import { ComposeTitleBar, promptAction, ComposeTitleBarMenuItem } from '@kit.ArkUI';
import { local, userInfoType } from '../demos/LocalStorage';

interface titleIconType {
  iconCode: string;
  title: string;
  colorCode: string;
}

@Component
struct CommentTop {
  @Link isSearch: boolean;
  @State menuItems: Array<ComposeTitleBarMenuItem> = [
    {
      value: $r("app.media.clear"),
      isEnabled: true,
      action: () => promptAction.showToast({ message: "show toast index 1" })
    },
    {
      value: $r('app.media.sousuo'),
      isEnabled: true,
      action: () => {
        promptAction.showToast({ message: "show toast index 1" });
        this.isSearch = true;
      }
    }
  ];

  build() {
    // Row() {
    //   Row() {
    //     Image($r('app.media.arrow_left'))
    //       .width(24)
    //       .margin({ right: 16 })
    //     Text('我的消息')
    //       .fontSize(20)
    //   }
    //   Row() {
    //     Image($r("app.media.clear"))
    //       .width(24)
    //       .margin({ right: 24 })
    //     Image($r('app.media.sousuo'))
    //       .width(24)
    //   }
    // }
    // .width('100%')
    // .backgroundColor(Color.White)
    // .padding(12)
    // .justifyContent(FlexAlign.SpaceBetween)

    // 尝试使用系统组件，顶部标题栏ComposeTitleBar，暂时不知道如何进行返回操作
    ComposeTitleBar({
      menuItems: this.menuItems,
      title: "我的消息",
    })
      .onClick(() => {
        promptAction.showToast({ message: '点击返回' })
      })
  }
}

@Component
struct CommentTitleIcon {
  @Builder titleIcon(items: titleIconType) {
    Column({ space: 10 }) {
      Row(){
        Image($r(items.iconCode))
      }
      .width(50)
      .height(50)
      .borderRadius('50%')
      .padding(8)
      .backgroundColor(Color[items.colorCode])
      Text(items.title)
    }
  };

  build() {
    Row() {
      this.titleIcon({title: '粉丝', colorCode: 'Red', iconCode: 'app.media.fensi'});
      this.titleIcon({title: '评论', colorCode: 'Blue', iconCode: 'app.media.pinglun'});
      this.titleIcon({title: '提到我', colorCode: 'Orange', iconCode: 'app.media.aite'});
      this.titleIcon({title: '赞和通知', colorCode: 'Yellow', iconCode: 'app.media.icon'});
    }
    .width('100%')
    .padding({ left: 18, right: 18, top: 12 })
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceAround)
  }
}

@Entry(local)
@Component
struct MyMessageComponent {
  @LocalStorageProp('user') myUser: Partial<userInfoType> = {};
  @LocalStorageLink('user') myUserLink: Partial<userInfoType> = {};
  @State nameList: string[] = ['薛之谦', '林俊杰', '周杰伦', '张三', '李四', '王五', '王麻子', '孙琦', '张学友', '许嵩', '周传雄', '刘德华', '陈奕迅'];
  @State isSearch: boolean = false;

  @Builder commListTimes(list: string) {
    Row({ space: 12 }) {
      Row(){
        Text(list.slice(0, 1)).fontColor(Color.Blue)
        Text('V')
          .width(16)
          .height(16)
          .borderRadius('50%')
          .backgroundColor(Color.Red)
          .fontColor(Color.White)
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .padding(2)
          .position({ right: -6, bottom: -6 })
      }
        .width(46)
        .aspectRatio(1)
        .borderRadius('50%')
        .backgroundColor(Color.Orange)
        .padding(6)
        .justifyContent(FlexAlign.Center)


      Column({ space: 6 }) {
        Row() {
          Text('云音乐')
            .fontSize(16)
          Text(`${new Date().getMonth() + 1}月${new Date().getDay()}日`)
            .fontColor('#cccccc')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        Text('阿里妈妈MUX倾力打造的矢量图标管理、交流平台。')
          .width('100%')
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .padding(12)
    .alignItems(VerticalAlign.Top)
  };

  @Builder commListContent() {
    Scroll() {
      Column({ space: 10 }){
        if(!this.isSearch) {
          CommentTitleIcon();
        }

        ForEach(this.nameList, (list: string) => {
          this.commListTimes(list)
        })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .padding({ bottom: 60 })
    }
    .layoutWeight(1)
    .scrollBarWidth(0)
  };

  build() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Column() {
        CommentTop({ isSearch: this.isSearch });
        this.commListContent()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .expandSafeArea([SafeAreaType.SYSTEM])

      // 播放器公共组件占位
      Row({space: 12}){
        Text('这里是播放歌曲公共组件占位').fontSize(20).width('100%').textAlign(TextAlign.Center)

        // 测试LocalStorage页面数据存储功能
        // Text('这里是展示LocalStorageProp的单向数据传递')
        // Text(this.myUser.name).fontSize(30)
        // Text(this.myUser.age?.toString()).fontSize(30)
        //
        // Divider().strokeWidth(6).color(Color.Orange)
        //
        // Text('这里是展示LocalStorageLink的双向数据传递')
        // Text(this.myUserLink.name).fontSize(30)
        // Text(this.myUserLink.age?.toString()).fontSize(30)
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.Yellow)
    }
  }
}