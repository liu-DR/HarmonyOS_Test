/**
 * @file ChooseDishesDemo.ets
 * @author Your Name
 * @date 2025/6/13
 * @description 点菜页面
 */
import {
  classItemsType,
  Product,
  dishClassItemProps,
  handleAddCutCartProps,
  ProductPromotion,
  ProductPricing
} from './type'

@Observed
export class classItemsTypeModel implements classItemsType {
  name: string = ''
  index: number = 0

  constructor(model: classItemsType) {
    this.name = model.name
    this.index = model.index
  }
}

@Observed
export class ProductPromotionModel implements ProductPromotion {
  discount: string = ''
  limit: string = ''

  constructor(model: ProductPromotion) {
    this.discount = model.discount
    this.limit = model.limit
  }
}

@Observed
export class ProductPricingModel implements ProductPricing {
  currentPrice: number = 0
  originalPrice: number = 0
  newCustomerPrice: number = 0

  constructor(model: ProductPricing) {
    this.currentPrice = model.currentPrice
    this.originalPrice = model.originalPrice
    this.newCustomerPrice = model.newCustomerPrice
  }
}

@Observed
export class ProductModel implements Product {
  id: number = 0
  name: string = ''
  tags: string[] = []
  salesVolume: string = ''
  recentOrders: string = ''
  recommendation: string | null = null
  promotion: ProductPromotion = new ProductPromotionModel({} as ProductPromotion)
  pricing: ProductPricing = new ProductPricingModel({} as ProductPricing)
  hasSpecification: boolean = false
  imageUrl: string = ''
  count: number = 0

  constructor(model: Product) {
    this.id = model.id
    this.name = model.name
    this.tags = model.tags
    this.salesVolume = model.salesVolume
    this.recentOrders = model.recentOrders
    this.recommendation = model.recommendation
    this.promotion = model.promotion
    this.pricing = model.pricing
    this.hasSpecification = model.hasSpecification
    this.imageUrl = model.imageUrl
    this.count = model.count
  }
}

// 持久化购物车数据，正常应该是存接口里
PersistentStorage.persistProp('cutCart_list', '[]');

@Extend(Image) function imageStyles(multiple: number = 2) {
  .width(40 * multiple)
  .aspectRatio(1)
}

@Component
struct MTBalanceCom {
  @Link showCart: boolean;
  @Consume cutCartList: Product[];

  handleAmount() {
    let mount: number = 0;
    this.cutCartList?.map((item: Product) => {
      if(item.count > 0){
        const mun = item.pricing.currentPrice * item.count;
        mount += mun;
      };
    });
    return mount;
  }

  // 判断是否需要配送费
  handleFeeMount() {
    let amount: number = 0;
    this.cutCartList?.map((item: Product) => {
      if(item.count > 0){
        const mun = item.pricing.currentPrice * item.count;
        amount += mun;
      };
    });

    if(amount > 30) {
      return 0;
    } else {
      return 5;
    }
  };

  build() {
    Row(){
      Row({ space: 28 }) {
        Badge({
          count: this.cutCartList?.length || 0,
          position: { x: 50, y: 34 },
          style: {},
          maxCount: 99
        }) {
          Image($r('app.media.waimai'))
            .width(55)
            .aspectRatio(1)
            .position({ bottom: 0, left: 20 })
        }
        Column() {
          Text() {
            Span('￥').fontSize(10)
            Span(this.handleAmount().toFixed(2).toString()).fontSize(22)
          }
          .fontColor('#ffffff')

          Text(`预估另需配送费 ￥${this.handleFeeMount()}`)
            .fontColor('#ccc')
            .fontSize(12)
        }
        .height('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
      }
      .height('100%')
      .layoutWeight(1)
      .borderRadius({ topLeft: '45%', bottomLeft: '45%' })
      .onClick(() => {
        this.showCart = !this.showCart
      })

      Text('去结算')
        .width(80)
        .height('100%')
        .fontSize(16)
        .backgroundColor('#ffffb42e')
        .borderRadius({ topRight: 50, bottomRight: 50 })
        .textAlign(TextAlign.Center)
    }
    .width('90%')
    .height(50)
    .backgroundColor('#ff262626')
    .borderRadius('45%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
};

@Component
struct MTCartCom {
  @Consume cutCartList: Product[];
  @Builder childDemo() {};
  @BuilderParam getDisClassItems: () => void = this.childDemo;

  build() {
    Column() {
      Row() {
        Text('购物车').fontSize(14)
        Text('清空购物车')
          .fontSize(14)
          .fontColor('#ccc')
          .onClick(() => {
            AppStorage.set<string>('cutCart_list' ,'[]');
          })
      }
      .width('100%')
      .height(30)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(8)
      .onClick(() => {
        AlertDialog.show({message: JSON.stringify(this.cutCartList)})
      })

      if(this.cutCartList?.length) {
        List() {
          this.getDisClassItems()
        }
        .height(220)
        .padding({ left: 12, right: 12 })
      } else {
        Row(){
          Text('暂无任何商品数据，请先添加商品')
        }.justifyContent(FlexAlign.Center).width('100%').height(220)
      }
    }
    .width('100%')
    .height(300)
    .backgroundColor(Color.White)
  }
}


interface GeneratedTypeLiteralInterface_1 {
  list: Product;
}

@Component
export default struct ChooseDishesDemo {
  @State active: number = 0;
  @State showCart: boolean = false;
  @State categorList: string[] = ['店长推荐', '新品菜心粥', '健康肉粥', '炒饭·潮汕汤', '石磨肠粉·豆浆', '美味甜粥', '养胃素粥', '海鲜靓粥', '端午粽子专区'];
  @State productList: ProductModel[] = [
    new ProductModel({
      "id": 1001,
      "name": "艾草糯糍（1颗）艾草糯糍（1颗）艾草糯糍（1颗）",
      "tags": ["新品尝鲜"], // 商品标签
      "salesVolume": "月售1000+", // 月销量
      "recentOrders": "近期400+人已下单", // 近期销量
      "recommendation": "粥推荐哦", // 特殊推荐语
      "promotion": {
        "discount": "1.11折", // 折扣信息
        "limit": "限1份 | 单点不送" // 购买限制
      },
      "pricing": {
        "currentPrice": 12.55, // 当前价格（单位：元）
        "originalPrice": 0.9, // 原价（划线价）
        "newCustomerPrice": 0 // 新客专享价
      },
      "hasSpecification": true, // 是否有规格可选
      "imageUrl": 'https://img.freepik.com/free-photo/green-mochi-rice-cake-with-red-bean-paste_1150-26588.jpg',
      "count": 0
    }),
    new ProductModel({
      "id": 1002,
      "name": "安心油条（1只）",
      "tags": ["点★专享"],
      "salesVolume": "月售400+",
      "recentOrders": "近期100+人已下单",
      "recommendation": "粥推荐哦", // 特殊推荐语
      "promotion": {
        "discount": "3.57折",
        "limit": "限1份 | 单点不送"
      },
      "pricing": {
        "currentPrice": 17.9,
        "originalPrice": 2.8,
        "newCustomerPrice": 0
      },
      "hasSpecification": false,
      "imageUrl": 'https://img.freepik.com/free-photo/green-mochi-rice-cake-with-red-bean-paste_1150-26588.jpg',
      "count": 0
    }),
    new ProductModel({
      "id": 1003,
      "name": "葱香小油条",
      "tags": ["点★专享"],
      "salesVolume": "月售900+",
      "recentOrders": "近期400+人已下单",
      "recommendation": "粥推荐哦", // 特殊推荐语
      "promotion": {
        "discount": "6.25折",
        "limit": "限6份 | 单点不送" // 允许购买多份
      },
      "pricing": {
        "currentPrice": 23.9,
        "originalPrice": 0.8,
        "newCustomerPrice": 0
      },
      "hasSpecification": true,
      "imageUrl": 'https://img.freepik.com/free-photo/green-mochi-rice-cake-with-red-bean-paste_1150-26588.jpg',
      count: 0
    })
  ];
  @StorageLink('cutCart_list') @Watch('updateCartList') cartListJson: string = '';
  @Provide cutCartList: Product[] = [];

  updateCartList() {
    const list: Product[] = JSON.parse(AppStorage.get<string>('cutCart_list') || '[]');
    this.cutCartList = list;
  }

  aboutToAppear(): void {
    this.updateCartList();
  }

  // 加减购物车商品
  handleAddCutCart(props: handleAddCutCartProps) {
    const list: Product | undefined = this.cutCartList.find(f => f.id === props.list.id);

    if(props.type === 'add') {
      if(list) {
        list.count++;
      } else {
        props.list.count = 1;
        this.cutCartList.unshift(props.list)
      }
    } else {
      if(!list) return;

      if(props.list.count > 1) {
        list.count--;
      } else {
        props.list.count = 0;
        const index: number = this.cutCartList.findIndex(f => f.id === props.list.id);
        this.cutCartList.splice(index, 1)
      }
    };
    AppStorage.set<string>('cutCart_list', JSON.stringify(this.cutCartList));
  }

  getCount(id: number) {
    const count = this.cutCartList.find(f => f.id === id)?.count || 0;
    return count;
  }

  // 添加购物车组件
  @Builder addCutCart(addProps: GeneratedTypeLiteralInterface_1) {
    Row({ space: 8 }) {
      Row(){
        Image($r('app.media.minus')).width(10).aspectRatio(1)
      }
      .width(16)
      .aspectRatio(1)
      .backgroundColor(Color.White)
      .border({
        color: '#000',
        width: 0.5
      })
      .justifyContent(FlexAlign.Center)
      .visibility(this.getCount(addProps.list.id) ? Visibility.Visible : Visibility.None)
      .onClick(() => {
        this.handleAddCutCart({ list: addProps.list, type: 'cut' })
      })

      Text(`${this.getCount(addProps.list.id)}`)
        .width(20)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          AlertDialog.show({message: JSON.stringify(this.productList)})
        })

      Row() {
        Image($r('app.media.plus'))
          .width(12).aspectRatio(1)
      }
      .width(16)
      .aspectRatio(1)
      .backgroundColor('#f8c74e')
      .borderRadius(4)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.handleAddCutCart({ list: addProps.list, type: 'add' })
      })
    }
  };

  // 左侧菜单分类
  @Builder classItems(props: classItemsType) {
    ListItem() {
      Text(props.name).fontSize(16).textAlign(TextAlign.Center)
    }
    .width(90)
    .height(65)
    .backgroundColor(props.index === this.active ? '#fff' : '#f5f5f5')
    .padding({ left: 8, right: 8 })
    .onClick(() => {
      this.active = props.index;
    })
  };

  // 右侧菜品分类
  @Builder dishClassItem(props: dishClassItemProps) {
    ListItem() {
      Row({ space: 10 }) {
        Image(props.list.imageUrl)
          .imageStyles()
        Column({ space: 4}) {
          Text(props.list.name)
            .fontSize(16)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(2)
          if(!props.showCart) {
            Text() {
              ForEach(props.list?.tags, (tag: string) => {
                Span(tag)
                  .fontSize(12)
                  .fontColor('#ffffb42e')
                  .backgroundColor(Color.Red)
              })
            }
            Text(props.list.salesVolume)
              .fontSize(12)
              .fontColor('#bbb')
            Text(props.list.recentOrders)
              .fontSize(12)
              .fontColor('#bbb')
          }
          Row() {
            Text(){
              Span('￥').fontSize(12)
              Span(props.list.pricing.currentPrice.toString())
            }
            .fontColor(Color.Red)
            this.addCutCart({list: props.list})
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .padding(8)
      .alignItems(VerticalAlign.Top)
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Row() {
        // 左侧菜单分类
        List() {
          ForEach(this.categorList, (item: string, index: number) => {
            this.classItems({name: item, index});
          })
        }
        .width(90)
        .height('100%')
        .backgroundColor('#f5f5f5');

        // 右侧菜品
        List() {
          ForEach(this.productList, (product: Product) => {
            this.dishClassItem({ list: product })
          });
        }
        .layoutWeight(1)
        .height('100%')
      }

      // 购物车展示
      if(this.showCart) {
        MTCartCom() {
          ForEach(this.cutCartList, (product: Product) => {
            this.dishClassItem({ list: product, showCart: true, multiple: 1 })
          })
        }
      }

      // 底下结算展示
      MTBalanceCom({ showCart: this.showCart })
    }
  }
}