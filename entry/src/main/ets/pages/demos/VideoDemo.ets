/**
 * @file VideoDemo.ets
 * @author Your Name
 * @date 2025/6/17
 * @description 视频播放功能
 * @description 不知道为什么模拟器声音无法正常听到
 */

@Entry
@Component
struct VideoDemo {
  private controller: VideoController = new VideoController();

  build() {
    Column({ space: 18 }) {
      Video({
        src: 'https://vd2.bdstatic.com/mda-rf7rxpj92i9gj6ht/cae_h264/1749406893949500344/mda-rf7rxpj92i9gj6ht.mp4?abtest=peav_l52&appver=&auth_key=1750173921-0-0-a761bdb5bf0b6529a4e08d17a448eaa7&bcevod_channel=searchbox_feed&cd=0&cr=0&did=cfcd208495d565ef66e7dff9f98764da&logid=3321303011&model=&osver=&pd=1&pt=4&sl=421&sle=1&split=636628&vid=6431287473921532820&vt=1',
        controller: this.controller
      })
        .height(300)
        .controls(false)

      Row({ space: 12 }) {
        Button('播放')
          .onClick(() => {
            this.controller.start()
          })
        Button('暂停')
          .onClick(() => {
            this.controller.pause()
          })
        Button('快进到一分钟')
          .onClick(() => {
            this.controller.setCurrentTime(90)
          })
        Button('停止')
          .onClick(() => {
            this.controller.stop();
          })
      }
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }
}
