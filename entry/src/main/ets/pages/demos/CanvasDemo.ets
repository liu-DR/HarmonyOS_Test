/**
 * @file CanvasDemo.ets
 * @author Your Name
 * @date 2025/6/19
 * @description 文件描述
 */

interface canVasSizeType {
  width: Length;
  height: Length;
};

interface coordObj {
  x: number;
  y: number
};

interface guessPointListType {
  x: number;
  y: number;
  isReset: boolean;
}

@Component
struct SameCase {
  canvasContext = new CanvasRenderingContext2D();
  @Prop canVasSize: Partial<canVasSizeType>;

  build() {
    Column({ space: 12 }) {
      Text('小案例')
      Canvas(this.canvasContext)
        .width('100%')
        .aspectRatio(1.4)
        .backgroundColor(Color.Gray)
        .onAreaChange((_: Area, newValue: Area) => {
          this.canVasSize.width = newValue.width;
          this.canVasSize.height = newValue.height
        })

      Row({ space: 12 }) {
        Button('画线')
          .onClick(() => {
            // 画蓝线
            this.canvasContext.beginPath(); // 开始绘制
            this.canvasContext.moveTo(50, 50);
            this.canvasContext.lineTo(250, 50);
            this.canvasContext.strokeStyle = 'blue';
            this.canvasContext.lineWidth = 4
            this.canvasContext.stroke(); // 执行绘制操作
            this.canvasContext.closePath(); // 结束绘制

            // 画红线
            this.canvasContext.beginPath();
            this.canvasContext.moveTo(250, 50);
            this.canvasContext.lineTo(250, 250);
            this.canvasContext.strokeStyle = 'red';
            this.canvasContext.lineWidth = 4;
            this.canvasContext.stroke();
            this.canvasContext.closePath();
          })


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

        Button('画矩形')
          .onClick(() => {
            this.canvasContext.beginPath();
            this.canvasContext.lineWidth = 4;
            this.canvasContext.strokeStyle = 'blue';
            this.canvasContext.rect(50, 50, 200, 200);
            this.canvasContext.fillStyle = 'green'
            this.canvasContext.fill();
            this.canvasContext.stroke();
            this.canvasContext.closePath();
          })

        Button('清除面板')
          .onClick(() => {
            this.canvasContext.clearRect(0, 0, this.canVasSize.width as number, this.canVasSize.height as number)
          })
      }
    }
  }
}


@Component
struct SignCase {
  @State coordObj: Partial<coordObj> = {};
  @State imageUrl: string = '';
  @State drawIng: boolean = false;
  @Consume guessPointList: guessPointListType[];
  @Consume isEnd: boolean;
  private context = new CanvasRenderingContext2D({ antialias: true });

  // 绘制
  drawCanvas(x: number, y: number) {
    this.context.moveTo(this.coordObj.x, this.coordObj.y);
    this.context.lineTo(x, y);
    this.coordObj.x = x;
    this.coordObj.y = y;
    this.context.stroke();
  };

  build() {
    Column({ space: 12 }) {
      Canvas(this.context)
        .width('100%')
        .aspectRatio(1.2)
        .backgroundColor(Color.Gray)
        .onReady(() => {
          this.context.strokeStyle = 'green';
          this.context.lineWidth = 4;
        })
        .onTouch((event) => {
          switch (event.type) {
            case TouchType.Down:
              this.drawIng = true;
              this.coordObj.x = event.touches[0].x;
              this.coordObj.y = event.touches[0].y;
              this.context.beginPath();
              this.isEnd = false;
              this.guessPointList.push({
                x: event.touches[0].x,
                y: event.touches[0].y,
                isReset: true
              });
              break;
            case TouchType.Up:
              this.drawIng = false;
              this.context.closePath();
              this.isEnd = true;
              break;
            case TouchType.Move:
              if (this.drawIng) {
                this.drawCanvas(event.touches[0].x, event.touches[0].y);
                this.guessPointList.push({
                  x: event.touches[0].x,
                  y: event.touches[0].y,
                  isReset: false
                });
              }
              break;
            default:
              break;
          }
        });

      // if (this.imageUrl) {
      //   Image(this.imageUrl).width('100%').aspectRatio(1.2)
      // }

      Row({ space: 12 }) {
        Button('清空画板')
          .onClick(() => {
            this.context.clearRect(0, 0, 360, 300)
          });

        // 点击后预览器卡死，模拟器正常
        // Button('签字板保存')
        //   .onClick(async () => {
        //     this.imageUrl = await this.context.toDataURL("image/png");
        //   })
      }
    }
  }
}

@Component
struct GuessCanvas {
  @State coordObj: Partial<coordObj> = {};
  @State timer: number = -1;
  @Consume guessPointList: guessPointListType[];
  @Consume @Watch('updateIsEnd') isEnd: boolean;
  private guessContext = new CanvasRenderingContext2D({ antialias: true });

  drawLine(props: guessPointListType) {
    if (props.isReset) {
      this.guessContext.closePath();
      this.guessContext.beginPath();
      this.coordObj.x = props.x;
      this.coordObj.y = props.y;
    }

    this.guessContext.moveTo(this.coordObj.x, this.coordObj.y);
    this.guessContext.lineTo(props.x, props.y);
    this.coordObj.x = props.x;
    this.coordObj.y = props.y;
    this.guessContext.stroke();
  }

  drawGuess() {
    if (this.guessPointList.length && this.timer === -1) {
      this.timer = setInterval(() => {
        // 结束轮询
        if (!this.guessPointList.length) {
          clearInterval(this.timer);
          this.timer = -1;
          return;
        }

        // 取出坐标点
        let point: guessPointListType = this.guessPointList.shift() as guessPointListType;
        // 开始绘画
        this.drawLine(point);
      }, 100);
    }
  };

  updateIsEnd() {
    if (this.isEnd) {
      // 绘制画布
      this.drawGuess();
    }
  }

  build() {
    Column() {
      Canvas(this.guessContext)
        .width('100%')
        .aspectRatio(1.2)
        .backgroundColor(Color.Red)
        .onReady(() => {
          this.guessContext.lineWidth = 4;
          this.guessContext.strokeStyle = Color.White;
        })
    }
  }
}

@Entry
@Component
struct CanvasDemo {
  @State canVasSize: Partial<canVasSizeType> = {};
  @State isSameCase: boolean = true;
  @Provide guessPointList: guessPointListType[] = [];
  @Provide isEnd: boolean = false;
  @Provide isClear: boolean = false;
  private canvasContext = new CanvasRenderingContext2D();

  clearDraw(func: () => void) {
    if (func) {
      func();
    }
  };

  build() {
    Column({ space: 12 }) {
      if (this.isSameCase) {
        SameCase({ canvasContext: this.canvasContext, canVasSize: this.canVasSize })
      } else {
        SignCase();
        GuessCanvas();
      }

      Row({ space: 12 }) {
        Button(!this.isSameCase ? '小案例' : '签字板')
          .onClick(() => {
            this.isSameCase = !this.isSameCase;
          });
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}