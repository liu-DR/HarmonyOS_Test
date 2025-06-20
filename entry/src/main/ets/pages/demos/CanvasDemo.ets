/**
 * @file CanvasDemo.ets
 * @author Your Name
 * @date 2025/6/19
 * @description 文件描述
 */

interface canVasSizeType {
  width: Length;
  height: Length;
}

@Entry
@Component
struct CanvasDemo {
  @State canVasSize: Partial<canVasSizeType> = {};
  private canvasContext = new CanvasRenderingContext2D();

  build() {
    Column({ space: 12 }) {
      Canvas(this.canvasContext)
        .width('100%')
        .aspectRatio(1.4)
        .backgroundColor(Color.Gray)
        .onAreaChange((_: Area, newValue: Area) => {
          this.canVasSize.width = newValue.width;
          this.canVasSize.height = newValue.height
        })

      Row({ space: 12 }) {
        Button('画蓝线')
          .onClick(() => {
            this.canvasContext.beginPath(); // 开始绘制
            this.canvasContext.moveTo(50, 50);
            this.canvasContext.lineTo(250, 50);
            this.canvasContext.strokeStyle = 'blue';
            this.canvasContext.lineWidth = 4
            this.canvasContext.stroke(); // 执行绘制操作
            this.canvasContext.closePath(); // 结束绘制
          })

        Button('画红线')
          .onClick(() => {
            this.canvasContext.beginPath();
            this.canvasContext.moveTo(250, 50);
            this.canvasContext.lineTo(250, 250);
            this.canvasContext.strokeStyle = 'red';
            this.canvasContext.lineWidth = 4;
            this.canvasContext.stroke();
            this.canvasContext.closePath();
          });

        Button('画圆')
          .onClick(() => {
            this.canvasContext.beginPath();
            this.canvasContext.strokeStyle = 'blue';
            this.canvasContext.lineWidth = 4;
            this.canvasContext.arc(180, 130, 100, 0, 360);
            this.canvasContext.stroke();
            this.canvasContext.fillStyle = 'red'; // 设置填充色的颜色
            this.canvasContext.fill(); // 设置填充色
            this.canvasContext.closePath();
          })

        Button('清除面板')
          .onClick(() => {
            this.canvasContext.clearRect(0, 0, this.canVasSize.width as number, this.canVasSize.height as number)
          })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}