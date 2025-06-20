/**
 * @file Index.ets
 * @author Your Name
 * @date 2025/6/14
 * @description 云音乐应用入口
 */
import MusicRecommend from './MusicRecommend/MusicRecommend';

@Entry
@Component
struct Index {
  build() {
    Column({ space: 12 }) {
      MusicRecommend();
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f6f8')
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}