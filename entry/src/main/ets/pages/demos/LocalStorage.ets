/**
 * @file LocalStorage.ets
 * @author Your Name
 * @date 2025/6/10
 * @description LocalStorage页面级内存状态
 */
import router from "@ohos.router";

export interface userInfoType {
  name: string;
  age: number;
}

let userInfo: Record<string, userInfoType> = {
  'user': {
    name: '张三',
    age: 18
  }
};

export const local = new LocalStorage(userInfo);

@Entry(local)
@Component
struct LocalStorageDemo {
  // 只能设置一个，设置多个会被覆盖
  @LocalStorageLink('user') myUserLink: Partial<userInfoType> = {};
  @LocalStorageProp('user') myUser: Partial<userInfoType> = {}

  build() {
    Column({space: 12}){
      Text(this.myUser.name).fontSize(20)
      Text(this.myUser.age?.toString()).fontSize(20)
      Button('点击修改信息')
        .onClick(() => {
          this.myUserLink.name = '李四Link';
          this.myUserLink.age = 56;
        })
      Button('点击跳转到我的信息页面')
        .onClick(() => {
          router.pushUrl({
            url: 'pages/components/MyMessage'
          })
        })
    }
    .width('100%')
    .height('100%')
  }
}