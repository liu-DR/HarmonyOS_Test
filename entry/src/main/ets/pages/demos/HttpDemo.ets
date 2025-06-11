/**
 * @file HttpDemo.ets
 * @author Your Name
 * @date 2025/6/10
 * @description HTTP网络请求
 */
import http from '@ohos.net.http'

@Entry
@Component
struct HTTPDemo {
  @State results: string[] = [];

  // 获取每日推荐歌曲列表
  async getCommendMusicList() {
    const axios = http.createHttp();

    // 获取请求头内容
    // axios.on('headersReceive', async (obj) => {
    //   AlertDialog.show({ message: JSON.stringify(obj) })
    // })

    const result = await axios.request('http://localhost:3000/recommend/songs');

    // AlertDialog.show({ message: JSON.stringify(result.result) });

    this.results = JSON.stringify(result.result).split(',')
  }

  aboutToAppear(): void {
    this.getCommendMusicList();
  }

  build() {
    Column(){
      Text('HTTP网络请求').fontSize(30);
      ForEach(this.results, (res: string) => {
        Text(res).fontColor(Color.White).fontSize(20)
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Brown)
  }
}