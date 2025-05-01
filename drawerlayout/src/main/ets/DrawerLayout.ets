import { DrawerLayoutController } from '../../../Index'
import { DrawerLayoutStatus } from './DrawerLayoutStatus'

@ComponentV2
export struct DrawerLayout {
  /**
   * 抽屉打开的进度
   * @param progress 0-1
   * @param status 抽屉状态，打开或关闭 注意：完全关闭状态才会是关闭状态，中间状态视为打开状态
   */
  @Event onProgressChange?: (progress: number, status: DrawerLayoutStatus) => void
  /**
   * 遮罩点击事件
   */
  @Event onMaskClick?: (event: ClickEvent) => void
  /**
   * 抽屉宽度,默认200vp
   */
  @Param drawerWidth: number = 200
  /**
   * 抽屉打开关闭时的动画时长，默认300
   */
  @Param animateDuration: number = 300
  /**
   * 抽屉的初始状态,默认关闭（仅首次有效）
   */
  @Param @Once drawerLayoutStatus: DrawerLayoutStatus = DrawerLayoutStatus.Close
  /**
   * 抽屉打开时主视图的遮罩,默认0x33000000
   */
  @Param maskColor: ResourceColor = 0x33000000
  /**
   * 主布局
   */
  @BuilderParam mainContent: () => void
  /**
   * 抽屉布局
   */
  @BuilderParam navContent: () => void
  /**
   * 抽屉控制器
   */
  @Param controller?: DrawerLayoutController = undefined
  // **********************************以下是私有属性************************************************
  // 按下的x坐标
  @Local private touchX: number = 0
  // // 按下的y坐标
  // @Local private touchY: number = 0
  // 当前抽屉的横向偏移
  @Local private offsetX: number = 0
  // 是否正在横向滑动
  @Local private horizontalMotion: boolean = false
  // 抽屉的状态
  @Local private drawerProgress: number = 0

  aboutToAppear() {
    if (this.drawerLayoutStatus === DrawerLayoutStatus.Close) {
      this.offsetX = -this.drawerWidth
    } else {
      this.offsetX = 0
    }

    this.initController()
  }

  build() {
    Stack({
      alignContent: Alignment.TopStart
    }) {
      this.mainContent()

      Column() {

      }
      .onClick((event: ClickEvent) => {
        this.onMaskClick?.(event)
      })
      .width("100%")
      .height("100%")
      .backgroundColor(this.maskColor)
      .opacity(this.drawerProgress)
      .visibility(this.drawerLayoutStatus == DrawerLayoutStatus.Open ? Visibility.Visible : Visibility.Hidden)

      Column() {
        this.navContent()
      }
      .height("100%")
      .width(this.drawerWidth)
      .offset({
        x: this.offsetX,
        y: 0
      })
    }
    .onTouch((event: TouchEvent) => {
      this.handleEvent(event)
    })
    .gesture(PanGesture({
      fingers: 1,
      direction: PanDirection.Horizontal
    })
      .onActionStart(() => {
        if (this.drawerLayoutStatus == DrawerLayoutStatus.Close && this.touchX >= this.drawerWidth) {
          return
        }
        this.horizontalMotion = true
      })
      .onActionEnd(() => {
        this.horizontalMotion = false
      })
    )
    .height("100%")
    .width("100%")
  }

  /**
   * 关闭抽屉布局
   * @param animate 是否动画开启
   */
  closeDrawerLayout(animate: boolean = true) {
    if (animate) {
      animateTo({
        duration: 300,
        curve: Curve.Linear,
        delay: 0,
      }, () => {
        this.offsetX = -this.drawerWidth
      })
    } else {
      this.offsetX = -this.drawerWidth
    }
  }

  /**
   * 打开抽屉布局
   * @param animate 是否动画开启
   */
  openDrawerLayout(animate: boolean = true) {
    if (animate) {
      animateTo({
        duration: 300,
        curve: Curve.Linear,
        delay: 0,
      }, () => {
        this.offsetX = 0
      })
    } else {
      this.offsetX = 0
    }
  }

  @Monitor("offsetX")
  updateDrawerStatus() {
    if (this.offsetX == -this.drawerWidth) {
      this.drawerLayoutStatus = DrawerLayoutStatus.Close
    } else {
      this.drawerLayoutStatus = DrawerLayoutStatus.Open
    }
    // 回调进度，全部打开是 1，关闭是 0
    const progress = Math.abs(this.offsetX / this.drawerWidth)
    // 保留两位小数
    this.drawerProgress = Math.round((1 - progress) * 100) / 100
    this.onProgressChange?.(this.drawerProgress, this.drawerLayoutStatus)
  }

  // @Monitor("drawerLayoutStatus")
  // private onUpdateDrawerLayoutStatus() {
  //   if (this.drawerLayoutStatus == DrawerLayoutStatus.Open) {
  //
  //   } else {
  //
  //   }
  // }

  // *************************以下方法供外部使用 START****************************************
  openDrawer = (animate?: boolean) => {
    if (animate == undefined) {
      animate = true
    }
    this.openDrawerLayout(animate)
  }
  closeDrawer = (animate?: boolean) => {
    if (animate == undefined) {
      animate = true
    }
    this.closeDrawerLayout(animate)
  }

  // *************************以上方法供外部使用 E N D****************************************

  private handleEvent(event: TouchEvent) {
    // 不支持多点触控
    if (event.touches.length > 1) {
      return
    }

    switch (event.type) {
      case TouchType.Down: {
        this.touchX = event.touches[0].x
        // this.touchY = event.touches[0].y
        break
      }
      case TouchType.Up: {
        this.touchX = event.touches[0].x
        // this.touchY = event.touches[0].y

        // 计算当前的位置，自动回弹
        if (this.offsetX > -this.drawerWidth / 2) {
          this.openDrawerLayout()
        } else {
          this.closeDrawerLayout()
        }
        break
      }
      case TouchType.Move: {
        // 计算当前的偏移量
        const distanceX = event.touches[0].x - this.touchX
        // const distanceY = event.touches[0].y - this.touchY
        // 判断是否是横向滑动
        if (this.horizontalMotion) {
          // 计算当前的偏移量
          this.offsetX += distanceX

          // 判断是否超过了最大值
          if (this.offsetX > 0) {
            this.offsetX = 0
          } else if (this.offsetX < -this.drawerWidth) {
            this.offsetX = -this.drawerWidth
          }
        }
        this.touchX = event.touches[0].x
        // this.touchY = event.touches[0].y
        break
      }
    }
  }

  /**
   * 初始化控制器
   */
  private initController() {
    if (this.controller == undefined) {
      return
    }
    this.controller.openDrawer = this.openDrawer
    this.controller.closeDrawer = this.closeDrawer
  }
}