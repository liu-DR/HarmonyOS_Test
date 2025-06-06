/**
 * @file StateStyleDemo.ets
 * @author Your Name
 * @date 2025/6/6
 * @description 学习stateStyle多态样式
 * @description focused-聚焦态、pressed-按压态、disabled-禁用态、normal-正常态、selected-选中态
 * @description 获焦态目前仅支持通过外接键盘的Tab键、方向键触发。
 * */

import curves from '@ohos.curves';

@Extend(Text) function textStateStyle() {
  .width(100)
  .height(40)
  .borderRadius(20)
  .backgroundColor(Color.Blue)
  .fontColor(Color.White)
  .textAlign(TextAlign.Center)
}

@Extend(TextInput) function inputStateStyle() {
  .width('80%')
  .height(40)
}

@Entry
@Component
struct StateStyleDemo {
  @State textEnable: boolean = true;

  @Styles pressedStyles() {
    .width(200)
    .height(80)
    .borderRadius(40)
    .backgroundColor(Color.Orange)
  };

  @Styles disabledStyles() {
    .backgroundColor(Color.Red)
  };

  @Styles inputFocusedStyles() {
    .border({
      width: 1,
      color: Color.Red
    })
  };

  build() {
    Column({ space: 16 }) {
      Text('按压状态')
        .textStateStyle()
        .stateStyles({
          pressed: this.pressedStyles,
        })

      Text('禁用状态')
        .textStateStyle()
        .stateStyles({
          disabled: this.disabledStyles,
        })
        .enabled(this.textEnable)

      Button('设置按钮禁用状态')
        .onClick(() => {
          this.textEnable = !this.textEnable;
        })

      // 聚焦态适用于输入框
      TextInput({ placeholder: '输入框1' })
        .inputStateStyle()
        .stateStyles({
          focused: this.inputFocusedStyles
        })

      TextInput({ placeholder: '输入框2' })
        .inputStateStyle()
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM])
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)
  }
}