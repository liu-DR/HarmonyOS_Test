## HarmonyOS 学习

### 1、初始化项目各文件目录意义

- **AppScope > app.json5** ：应用的全局配置信息，具体配置信息官网查询


- **entry** : 项目开发的工程模块，可以理解为项目页面结构代码的存放目录

    - **src > main > ets** : 存放ArkTS源码
    - **src > main > ets > pages**: 应用页面代码
    - **src > main > ets > entryability**: 应用入口文件
    - **src > main > ets > entrybackupability**： 应用提供扩展的备份恢复能力
    - **src > main > resources**：存放应用需要使用的资源文件，图形、多媒体、字符串等
      - base/element：用于存放各种类型数据
      - base/media：用于存放图片、图标等资源文件
      - base/profile/main_pages：用于配置页面路由信息


### 2、认识ArkTs

- #### 常见的装饰器类别：
    - **@Entry**：使用@Entry装饰的组件，在页面加载时会首先创建并默认展示，并且一个页面有且只能有一个@Entry
    - **@Component**：表示该部分代码内容为一个自定义组件
    - **@State**：用于定义一个状态变量，表示组件内状态
    - **Prop**：用于装饰从父组件传递的变量属性，不能双向同步
    - **@Link**：在子组件中使用，用于装饰从父组件中传递的属性建立双向数据绑定，子组件修改，父组件会同步更新
    - **@Provide和@Consume**：用于装饰祖先组件和后代子组件的双向数据通信，祖先组件中使用Provide定义数据，后代不同层级之间通过命名机制传递
      - 使用方法
        ```markdown
          // 通过相同的变量名绑定
          @Provide age: number = 0;
          @Consume age: number;

                  // 通过相同的变量别名绑定
          @Provide('a') id: number = 0;
          @Consume('a') age: number;
        ```
    - **@Observed和@ObjectLink**：状态抬变量数据拥有多层数据结构时并且非第一层数据发生变化时，监听数据变化并及时更新UI内容。（其他的装饰器无法监听除第一层数据之外的变化）

- #### 引用状态
  - **State**：组件内状态
  - **LocalStorage-UIAbility**：存在在内存状态，当应用被退出后台时清除，针对于页面级别的存储范围
  - **AppStorage**：存在于应用全局得的UI状态存储，和进程绑定，并且不会写入磁盘
    - 获取方式：
      ```markdown
        方法1：AppStorage.get<appStorageType>('userInfo')
        方法2： 
            // prop单向传递
            @StorageProp('userInfo') userInfo: Partial<appStorageType> = {};
            // 双向传递
            @StorageLink('userInfo') userInfoLink: Partial<appStorageType> = {};
      ```
  - **PersistentStorage**：状态存储持久化，会将数据存储在磁盘中，，并且会监听的`AppStorage`的数据变化，发生变化时会自动更新往磁盘中进行更新。
    - 使用方法：PersistentStorage.persistProp<T>(key, value: T)

- 生命周期

    - **aboutToAppear**：在页面初始化创建加载之前执行
    - **onPageShow**：在页面初始化后，并且页面加载完成并展示在前台时触发
    - **onPageHide**：当应用进入后台时，页面消失，此时触发
    - **aboutToDisappear**：在页面被卸载销毁时执行
    - **onBackPress**：当通过系统方式执行返回操作时触发，可设置返回值；比如当用户点击返回按钮时，可设置返回值，当返回值为true时，表示有页面自行处理返回逻辑，不进行页面返回；当返回值为false时，表示使用系统处理返回逻辑，默认是false

- 样式方法
  
  - 设置宽高比属性：aspectRatio(value: number)
  - 自适应宽高：layoutWeight(value: number)


- #### 网络管理
  1、应用权限：system_grant(系统权限)和user_grant(用户授权)



### 问题搜集

1、当状态变量为对层嵌套时，不能使用拓展运算符和延展运算符的情况下如何进行更新
 - 