import MusicRecommendHeader from './MusicRecommend/MusicHome';
import ZhiHuCommentDemo from './demos/ZhiHuCommentDemo';
import { router } from '@kit.ArkUI';

PersistentStorage.persistProp<appStorageType>('userInfo', {
  user_token: '123456789',
  user_name: '张三',
  user_id: '1',
});

export interface appStorageType {
  user_token: string;
  user_name: string;
  user_id: string;
};


@Entry
@Component
struct Index {
  @StorageProp('userInfo') userInfo: Partial<appStorageType> = {};

  build() {
    Column({ space: 12 }) {
      MusicRecommendHeader();

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