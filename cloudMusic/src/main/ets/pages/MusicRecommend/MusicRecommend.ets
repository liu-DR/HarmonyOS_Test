import MusicRecommendHeader from './MusicRecommendHeader';

import { tabContentStylesType } from './interface';
import promptAction from '@ohos.promptAction';

@Extend(TabContent)
function tabContentStyles(styleProps: tabContentStylesType) {
  .tabBar(
    SubTabBarStyle.of(styleProps.text)
      .indicator({
        color: '#000000',
        width: 60,
        height: 2,
        borderRadius: 1,
        marginTop: 14
      })
      .labelStyle({
        unselectedColor: '#838489',
        selectedColor: '#000000',
        maxLines: 1,
        minFontSize: 14,
        maxFontSize: 16
      })
  )
};


@Entry
@Component
export default struct MusicRecommend {
  @State activeKey: number = 0;
  @State showLeftContent: boolean = false;
  @State tabsItems: tabContentStylesType[] = [
    { text: '推荐', id: 0 },
    { text: '音乐', id: 1 },
    { text: '播客', id: 2 },
    { text: '听书', id: 3 },
  ];
  private tabController = new TabsController();

  @Builder
  textCom(commendText: string) {
    Scroll() {
      Column({ space: 12 }) {
        Button(commendText)
          .fontSize(40)
          .onClick(() => {
            // this.showLeftContent = true;
            promptAction.openCustomDialog({
              builder: () => this.textCom('测试弹窗'),
              width: 200,
              height: 200
            })
          })
      }
    }
    .width('100%')
    .height('100%')
    .padding(12)
    .scrollBarWidth(0)
  };

  build() {
    Stack() {
      Column() {
        MusicRecommendHeader();

        Tabs({ controller: this.tabController, index: this.activeKey }) {
          ForEach(this.tabsItems, (item: tabContentStylesType) => {
            TabContent() {
              this.textCom(item.text)
            }.tabContentStyles({ text: item.text, id: item.id })
          })
        }
        .height('100%')
        .width('100%')
        .barHeight(50)
        .scrollable(true)
        .divider({
          strokeWidth: 0.5,
          color: '#f1f2f7'
        })
        .animationDuration(0)
        .animationMode(AnimationMode.ACTION_FIRST)
        .onChange((index) => {
          this.activeKey = index;
        })

      }
      .height('100%')
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      if (this.showLeftContent) {
        // 侧边栏
        Column() {
          Column() {
            Text('侧边栏')
          }
          .width('80%')
          .height('100%')
          .backgroundColor(Color.White)
          .expandSafeArea([SafeAreaType.SYSTEM])
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#ccc')
        .position({ top: 0, left: 0 })
        .alignItems(HorizontalAlign.Start)
        .onClick(() => {
          this.showLeftContent = false;
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}