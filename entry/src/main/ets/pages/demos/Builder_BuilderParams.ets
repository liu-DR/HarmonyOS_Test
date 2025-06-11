/**
 * @file Builder_BuilderParams.ets
 * @author Your Name
 * @date 2025/6/7
 * @description Builder_BuilderParams的功能实践
 * @description 当在父组件中创建自定义Builder构建函数时，子组件想要使用BuilderParam接收该Builder函数时，需要在子组件中，创建一个空的Builder函数，对BuilderParam函数进行初始化赋值
 *
 */

interface staffInfoType {
  id: string;
  name: string;
  author: string;
  organization: string;
  topUser: string;
};

interface propsType {
  items: staffInfoType
}

@Component
struct CardDemo {
  /**
   * 注释：这里需要注意，如果不使用创建一个空的Builder函数对BuilderParam进行初始化赋值的话，这里会报错，程序无法执行
   * 报错信息：BuilderParam property can only initialized by Builder function or LocalBuilder method in struct.
   */
  @Builder child() {}
  @BuilderParam getContent: () => void = this.child;

  build() {
    Column() {
      this.getContent();
    }
    .width('100%')
    .height(400)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}

@Entry
@Component
struct Builder_BuilderParams_Demo {
  @State staffInfo: staffInfoType[] = [{
    id: '1',
    name: '张三',
    author: '普通',
    organization: '研发部',
    topUser: '老王'
  }];

  @Builder CardItem(props: propsType) {
    Row(){
      Text(props.items.organization)
      Text(props.items.name).fontColor('#ccc')
    }
    .width('100%')
    .height(50)
    .padding(10)
    .border({
      color: '#f4f5f6',
      width: {
        bottom: 1
      }
    })
    .justifyContent(FlexAlign.SpaceBetween)
  };

  build() {
    Column() {
      CardDemo() {
        // 懒得造数据
        ForEach(this.staffInfo, (item: staffInfoType) => {
          this.CardItem({ items: item });
          this.CardItem({ items: item });
          this.CardItem({ items: item });
          this.CardItem({ items: item });
        })
      };

      Text(`${JSON.stringify(this.staffInfo)}`)
      Button('改变组织')
        .onClick(() => {
          this.staffInfo = [{
            id: '1',
            name: '李四',
            author: '普通',
            organization: '开发部',
            topUser: '老王'
          }]
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
    .padding(12)
  }
}