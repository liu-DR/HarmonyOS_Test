/**
 * @file MusicCommendContent.ets
 * @author Your Name
 * @date 2025/6/20
 * @description 推荐页面内容
 */


@Entry
@Component
export default struct MusicCommendContent {
  @Styles
  columnStyles() {
    .width(160)
    .height('100%')
    .backgroundColor('#b9b9b9')
    .borderRadius(8)
  };

  @Builder
  commendItems() {
    Column() {
      Text('每日推荐')
        .width('100%')
        .fontColor(Color.White)
        .fontSize(14)
        .padding(10)
        .textAlign(TextAlign.Start)
    }
    .columnStyles()
  }

  build() {
    Column({ space: 12 }) {
      Scroll() {
        Row({ space: 12 }) {
          this.commendItems();
          this.commendItems();
          this.commendItems();
          this.commendItems();
          this.commendItems();
        }
        .height('100%')
        .alignItems(VerticalAlign.Top)
      }
      .height(200)
      .scrollBarWidth(0)
      .scrollable(ScrollDirection.Horizontal)


      // Text('测试1111').fontSize(40).width(60).height('100%')
      // Text('测试1111').fontSize(40).width(60).height('100%')
      // Text('测试1111').fontSize(40).width(60).height('100%')
      // Text('测试1111').fontSize(40).width(60).height('100%')
      // Text('测试1111').fontSize(40).width(60).height('100%')
      // Text('测试1111').fontSize(40).width(60).height('100%')
      // Text('测试1111').fontSize(40).width(60).height('100%')
      // Text('测试1111').fontSize(40).width(60).height('100%')

    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}