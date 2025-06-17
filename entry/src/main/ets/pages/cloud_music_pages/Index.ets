/**
 * @file Index.ets
 * @author Your Name
 * @date 2025/6/14
 * @description 云音乐应用入口
 */
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @StorageProp('abilityParams') abilityParams: string = '';

  aboutToAppear(): void {
    AlertDialog.show({message: this.abilityParams})
  }

  build() {
    Column({ space: 12}) {
      Text('云音乐应用入口').fontSize(30)
      Row() {
        Text('测试底部是否避让安全区')
      }.backgroundColor(Color.Red).width('100%').height(60)

      Button('我销毁我自己')
        .onClick(() => {
          const context = this.getUIContext()?.getHostContext() as common.UIAbilityContext;
          context.terminateSelfWithResult({
            resultCode: 1,
            want: {
              bundleName: 'com.example.myapplication',
              abilityName: 'EntryAbility',
              parameters: {
                id: JSON.stringify(new Date().getTime())
              }
            }
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ccc')
    .justifyContent(FlexAlign.End)
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}