interface classItemsType {
  name: string;
  index: number;
};

/** 商品促销信息接口 */
interface ProductPromotion {
  /** 折扣信息（如：1.11折） */
  discount: string;
  /** 购买限制（如：限1份 | 单点不送） */
  limit: string;
};

/** 商品定价信息接口 */
interface ProductPricing {
  /** 当前价格（单位：元） */
  currentPrice: number;
  /** 原价（划线价） */
  originalPrice: number;
  /** 新客专享价 */
  newCustomerPrice: number;
};

// 商品信息类型
interface Product {
  /** 商品ID */
  id: number;
  /** 商品名称 */
  name: string;
  /** 商品标签（如：新品尝鲜、点★专享） */
  tags: string[];
  /** 月销量信息 */
  salesVolume: string;
  /** 近期销量信息 */
  recentOrders: string;
  /** 特殊推荐语（可选字段） */
  recommendation: string | null;
  /** 促销信息 */
  promotion: ProductPromotion;
  /** 定价信息 */
  pricing: ProductPricing;
  /** 是否有规格可选 */
  hasSpecification: boolean;
  /** 商品图片 */
  imageUrl: string;
  /** 商品选中数量 */
  count: number
};

interface dishClassItemProps {
  list: Product,
  multiple?: number;
  showCart?: boolean
};

interface handleAddCutCartProps {
  list: Product;
  type: 'add' | 'cut'
};

export {
  classItemsType,
  ProductPromotion,
  ProductPricing,
  Product,
  dishClassItemProps,
  handleAddCutCartProps
};
