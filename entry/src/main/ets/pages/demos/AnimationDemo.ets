/**
 * @file AnimationDemo.ets
 * @author Your Name
 * @date 2025/6/16
 * @description Animation动画
 */

@Entry
@Component
struct AnimationDemo {
  @State widthSize: number = 100;
  @State heightSize: number = 40;
  @State scaleNum: number = 1;
  @State animationObj: AnimateParam = {
    duration: 100,
    iterations: -1,
    playMode: PlayMode.Alternate
  };

  @State showLeftContent: boolean = false;

  build() {
    Column({ space: 12 }) {
      Image($r('app.media.aixin'))
        .width(80)
        .aspectRatio(1)
        .scale({
          x: this.scaleNum,
          y:this.scaleNum
        })
        .animation(this.animationObj)
      Button('测试')
        .width(this.widthSize)
        .height(this.heightSize)
        .animation({
          //  动画时间
          duration: 1500,
          // 重复次数
          iterations: 10,
          // 动画速度
          tempo: 2,
          //  动画曲线
          curve: Curve.Ease,
          // 动画播放模式
          playMode: PlayMode.Alternate
        })

      Button('改变按钮属性')
        .onClick(() => {
          this.widthSize = 200;
          this.heightSize = 80
        })

      Button('恢复原样')
        .onClick(() => {
          this.widthSize = 100;
          this.heightSize = 40
        })

      Button(this.scaleNum === 1 ? '开始心跳' : '停止心跳')
        .onClick(() => {
          if(this.scaleNum === 1) {
            this.animationObj.duration = 100
            this.scaleNum = 1.1
          } else {
            this.animationObj.duration = 0;
            this.scaleNum = 1;
          }
        })

      if(this.showLeftContent) {
        Column() {
          Column() {
            Text('侧边栏')
          }
          .width('80%')
          .height('100%')
          .backgroundColor(Color.Orange)
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Gray)
        .position({ top: 0, left: 0 })
        .zIndex(2)
        .alignItems(HorizontalAlign.Start)
        .onClick(() => {
          animateTo({
            duration: 300
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
          }
        })
      }

      Button('打开侧边栏')
        .onClick(() => {
          animateTo({
            duration: 300
          }, () => {
            this.showLeftContent = true;
          })
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}