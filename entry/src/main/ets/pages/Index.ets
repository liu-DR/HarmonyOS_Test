import { router } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

// import MusicRecommendHeader from 'cloudmusic/src/main/ets/MusicRecommend/MusicHome';
import { BusinessError } from '@kit.BasicServicesKit';

PersistentStorage.persistProp<appStorageType>('userInfo', {
  user_token: '123456789',
  user_name: '张三',
  user_id: '1',
});

export interface appStorageType {
  user_token: string;
  user_name: string;
  user_id: string;
}
;


@Entry
@Component
struct Index {
  @StorageProp('userInfo') userInfo: Partial<appStorageType> = {};
  @StorageProp('abilityParams') abilityParams: string = '';
  @State isShow: boolean = false;

  build() {
    Column({ space: 12 }) {
      // MusicRecommendHeader();

      Column({ space: 12 }) {
        Text(this.userInfo.user_token).fontSize(30)
        Text(this.userInfo.user_name).fontSize(30)
        Text(this.userInfo.user_id).fontSize(30)
        Button('创建AppStorage全局数据存储')
          .onClick(() => {
            AppStorage.setOrCreate<appStorageType>('userInfo', {
              user_token: '123456789',
              user_name: '张三',
              user_id: '1',
            });

            router.pushUrl({
              url: 'pages/demos/AppStorageDemo'
            })
          })

        Button('点击前往美团外卖')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/demos/MeituanWaimai/Index'
            })
          });

        if (this.isShow) {
          Button('是否展示我')
        }

        Button('唤醒一个新进程')
          .onClick(async () => {
            const context = this.getUIContext()?.getHostContext() as common.UIAbilityContext;
            context.startAbilityForResult({
              bundleName: 'com.example.myapplication',
              abilityName: 'CloudMusicAbility',
              parameters: {
                abilityParams: {
                  id: JSON.stringify(new Date().getTime())
                }
              }
            }).then((result: common.AbilityResult) => {
              console.info('startAbilityForResult succeed 1111111111');
              if (result.want?.parameters?.id) {
                this.isShow = true;
              }
            }).catch((err: BusinessError) => {
              console.error(`startAbilityForResult failed, code is ${err.code}, message is ${err.message}`)
            })
          })

        Button('查看视频播放Demo')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/demos/VideoDemo'
            })
          })

        Button('前往Canvas')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/demos/CanvasDemo'
            })
          })
      }
      .width('100%')
      .height('100%')
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