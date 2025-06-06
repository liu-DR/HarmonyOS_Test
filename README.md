## HarmonyOS 学习

### 1、初始化项目各文件目录意义

- **AppScope > app.json5** ：应用的全局配置信息，具体配置信息官网查询


- **entry** : 项目开发的工程模块，可以理解为项目页面结构代码的存放目录

    - **src > main > ets** : 存放ArkTS源码
    - **src > main > ets > pages**: 应用页面代码
    - **src > main > ets > entryability**: 应用入口文件
    - **src > main > ets > entrybackupability**： 应用提供扩展的备份恢复能力
    - **src > main > resources**：存放应用需要使用的资源文件，图形、多媒体、字符串等


### 2、认识ArkTs

- 常见的装饰器类别：

    - **@Entry**：使用@Entry装饰的组件，在页面加载时会首先创建并默认展示，并且一个页面有且只能有一个@Entry
    - **@Component**：表示该部分代码内容为一个自定义组件
    - **@State**：
    - **@Link**：


- 生命周期

    - **aboutToAppear**：在页面初始化创建加载之前执行
    - **onPageShow**：在页面初始化后，并且页面加载完成并展示在前台时触发
    - **onPageHide**：当应用进入后台时，页面消失，此时触发
    - **aboutToDisappear**：在页面被卸载销毁时执行
    - **onBackPress**：当通过系统方式执行返回操作时触发，可设置返回值；比如当用户点击返回按钮时，可设置返回值，当返回值为true时，表示有页面自行处理返回逻辑，不进行页面返回；当返回值为false时，表示使用系统处理返回逻辑，默认是false

- 样式方法
  
  - 设置宽高比属性：aspectRatio(value: number)