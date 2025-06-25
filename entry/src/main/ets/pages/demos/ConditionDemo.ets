/**
 * @file ConditionDemo.ets
 * @author Your Name
 * @date 2025/6/6
 * @description 条件渲染
 */

@Entry
@Component
struct ConditionDemo {
  @State showImage: boolean = false;
  @State selectIndex: number = 2;

  build() {
    Column({ space: 12 }) {
      //  Toggle切换
      Row({ space: 12 }) {
        Toggle({ type: ToggleType.Switch })
          .onChange((isOn) => {
            this.showImage = isOn;
          });
        // if条件渲染语句
        if (this.showImage) {
          Image($r('app.media.sousuo'))
            .width(24)
        } else {
          // Image($r('app.media.yuyin'))
          //   .width(24)
        }
      }

      // Select下拉项
      Select([{ value: '勇士' }, { value: '湖人' }, { value: '太阳' }])
        .selected(this.selectIndex)
        .value('测试')
        .onSelect((index, value) => {
          CustomDialog(() => {

          })
        })


    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}