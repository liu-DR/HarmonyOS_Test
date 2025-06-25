import MusicRecommendHeader from './MusicRecommendHeader';

import { tabContentStylesType } from './interface';
import MusicCommendContent from './MusicCommendContent';

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

  @Styles
  defaultStyles() {
    .width('100%')
    .height('100%')
  };

  @Builder
  textCom(props: tabContentStylesType) {
    Scroll() {
      if (props.id === 0) {
        MusicCommendContent();
      } else {
        Column({ space: 12 }) {
          Button('推荐')
            .fontSize(40)
        }
      }
    }
    .defaultStyles()
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
              this.textCom(item);
            }.tabContentStyles({ text: item.text, id: item.id })
          })
        }
        .defaultStyles()
        .barHeight(50)
        .scrollable(false)
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
      .defaultStyles()
      .alignItems(HorizontalAlign.Start)

      if (this.showLeftContent) {
        // 侧边栏
        Column() {
          Row() {
            Column() {
              Text('侧边栏')
            }
            .width('80%')
            .height('100%')
            .backgroundColor(Color.White)
            .opacity(1)
            .expandSafeArea([SafeAreaType.SYSTEM])
            .onClick((event) => {
              event.preventDefault();
            })
          }
        }
        .defaultStyles()
        .position({ top: 0, left: 0 })
        .alignItems(HorizontalAlign.Start)
        .backgroundColor('#33000000')
        .onClick(() => {
          animateTo({
            duration: 400
          }, () => {
            this.showLeftContent = false;
          })
        })
        .transition({
          type: TransitionType.Insert,
          translate: {
            x: '-100%'
          }
        })
        .transition({
          type: TransitionType.Delete,
          translate: {
            x: '-100%'
          },
          opacity: 0
        })
      }
    }
    .defaultStyles()
  }
}