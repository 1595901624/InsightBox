import { screen } from "../util/ScreenUtil";

/**
 * 安全区域布局
 */
@ComponentV2
export struct SafeAreaLayout {
  @BuilderParam childBuilder?: () => void

  build() {
    Stack() {
      this.childBuilder?.();
    }
    .padding({
      top: screen.getStatusBarHeightVp(),
      bottom: screen.getBottomNavigationBarHeightVp(),
    })
    .width('100%')
    .height('100%')
  }
}