import MusicRecommendHeader from './MusicRecommend/MusicHome';
import ZhiHuCommentDemo from './demos/ZhiHuCommentDemo';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column({ space: 12 }) {
      MusicRecommendHeader();

      Row() {
        Button('开启倒计时', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
      }
      .width('100%')
      .height(300)
      .backgroundColor(Color.Brown)
      .justifyContent(FlexAlign.Center)

    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.White)
    // 使安全区的背景向上下拓展
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}