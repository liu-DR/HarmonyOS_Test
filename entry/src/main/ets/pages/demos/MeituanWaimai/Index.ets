/**
 * @file Index.ets
 * @author Your Name
 * @date 2025/6/12
 * @description 美团外卖入口文件
 */
import ChooseDishesDemo from './ChooseDishesDemo';

@Entry
@Component
struct MeiTuanWaiMaiDemo {
  build() {
    Column() {
      ChooseDishesDemo();
    }
  }
}