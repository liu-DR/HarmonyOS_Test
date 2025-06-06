import promptAction from '@ohos.promptAction';

@Component
export default struct MusicRecommendHeader {
  @State swiperList: string[] = ['租购 薛之谦', '星星 张杰', '江南 林俊杰', '稻香 周杰伦'];

  build() {
    Row() {
      Row() {
        Image($r('app.media.gengduo'))
          .width(24)
          .margin({ right: 20 })
          .onClick(() => {
            promptAction.showToast({ message: '打开更多左侧侧边栏' })
          })

        Row() {
          Image($r('app.media.sousuo'))
            .width(18)
            .margin({ right: 8 })

          Swiper() {
            ForEach(this.swiperList, (item: string) => {
              Text(item)
                .width(120)
                .opacity(0.6)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(1)
            })
          }
          .height(32)
          .loop(true)
          .autoPlay(true)
          .interval(3000)
          .vertical(true)
          .indicator(false)

          Image($r('app.media.saoma'))
            .width(22)
            .position({ right: 0, top: 0})
            .onClick(() => {
              console.info('2222222')
              promptAction.showToast({
                message: "点击扫描，打开扫描窗口",
                duration: 2000,
              })
            })
        }
        .height(42)
        .backgroundColor('#f0f0f0')
        .borderRadius(18)
        .padding(12)
        .layoutWeight(1)
        .onClick(() => {
          promptAction.showToast({ message: '打开搜索页面' })
        })

        // 扫描
        Image($r('app.media.yuyin'))
          .width(28)
          .margin({ left: 16 })
          .onClick(() => {
            promptAction.showToast({ message: '打开听歌识曲页面' })
          })
      }
      .height(50)
    }
    .width('100%')
    .height(50)
    .padding({ left: 12, right: 12 })
    .backgroundColor(Color.Orange)
  }
}