@ComponentV2
export struct DrawerLayout {
  /**
   * 抽屉宽度,默认300vp
   */
  @Param drawerWidth: number = 300
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
  @BuilderParam drawerLayout: () => void

  build() {
    RelativeContainer() {
      this.mainContent()

      Column() {
        this.drawerLayout()
      }
      .width(this.drawerWidth)
      .onTouch((event: TouchEvent) => {
        this.handleEvent(event)
      })
    }
    .offset({
      x: -this.drawerWidth,
      y: 0
    })
    .height("100%")
    .width("100%")
  }

  private handleEvent(event: TouchEvent) {
    // 不支持多点触控
    if (event.touches.length > 1) {
      return
    }

    switch (event.type) {
      case TouchType.Down: {

        break
      }
      case TouchType.Up: {

        break
      }
      case TouchType.Move: {

        break
      }
    }
  }
}