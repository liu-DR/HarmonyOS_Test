import { appStorageType } from '../Index';

@Entry
@Component
struct AppStorageDemo {
  @StorageProp('userInfo') userInfo: Partial<appStorageType> = {};
  @StorageLink('userInfo') userInfoLink: Partial<appStorageType> = {};

  aboutToAppear(): void {
    AlertDialog.show({
      message: JSON.stringify(AppStorage.get<appStorageType>('userInfo'))
    })
  }

  build() {
    Column({ space: 12 }) {
      Text(this.userInfo.user_token).fontSize(30)
      Text(this.userInfo.user_name).fontSize(30)
      Text(this.userInfo.user_id).fontSize(30)

      Button('修改用户信息')
        .onClick(() => {
          this.userInfoLink.user_name = '李四'
        })
    }
    .height('100%')
    .width('100%')
  }
}