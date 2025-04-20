/**
 * 屏幕工具类
 */
import display from '@ohos.display';
import window from '@ohos.window';
import { GlobalUtil } from './GlobalUtil';

class ScreenUtil {
  constructor() {
  }

  // /**
  //  * 获取屏幕Rect，单位Px
  //  *
  //  * @returns 返回屏幕宽度(Px)
  //  */
  // async getScreenRect() {
  //   return await display.getDefaultDisplaySync().getAvailableArea();
  // }

  /**
   * 获取屏幕宽度，单位Px
   *
   * @returns 返回屏幕宽度(Px)
   */
  getScreenWidthPx(): number {
    return display.getDefaultDisplaySync().width;
  }

  /**
   * 获取屏幕宽度，单位Vp
   *
   * @returns 返回屏幕宽度(Vp)
   */
  getScreenWidthVp(): number {
    return px2vp(this.getScreenWidthPx());
  }

  /**
   * 获取屏幕vp值大的方向，单位Vp
   *
   * @returns 返回屏幕宽度(Vp)
   */
  getScreenMaxVp() {
    return Math.max(screen.getScreenWidthVp(), screen.getScreenHeightVp())
  }

  /**
   * 获取屏幕高度，单位Px
   *
   * @returns 屏幕的高度(Px)
   */
  getScreenHeightPx(): number {
    return display.getDefaultDisplaySync().height;
  }

  /**
   * 获取屏幕高度，单位Vp
   *
   * @returns 屏幕的高度(Vp)
   */
  getScreenHeightVp(): number {
    return px2vp(this.getScreenHeightPx());
  }

  /**
   * 获取屏幕的 DPI
   * @returns 返回DPI
   */
  getDensityDPI(): number {
    return display.getDefaultDisplaySync().densityDPI
  }

  /**
   * 获取屏幕的方向
   * @returns 返回横竖屏
   */
  getScreenOrientation(): display.Orientation {
    return display.getDefaultDisplaySync().orientation
  }

  /**
   * 获取状态栏的高度
   * @param component 当前的组件
   * @returns
   */
  async getStatusBarHeightPxAsync(component?: Object): Promise<number> {
    let win = await window.getLastWindow(getContext(component))
    let area = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
    let barHeight = area.topRect.height;
    return Promise.resolve(barHeight)
  }

  /**
   * 获取状态栏的宽度
   * @param component 当前的组件
   * @returns
   */
  async getStatusBarWidthPxAsync(component?: Object): Promise<number> {
    let win = await window.getLastWindow(getContext(component))
    let area = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
    let barWidth = area.topRect.width;
    return Promise.resolve(barWidth)
  }

  /**
   * 获取底部导航栏的高度（单位像素）
   * @param component 当前的组件
   * @returns
   */
  async getBottomNavigationBarHeightPxAsync(component?: Object): Promise<number> {
    let win = await window.getLastWindow(getContext(component))
    let area = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
    let barHeight = area.bottomRect.height;
    return Promise.resolve(barHeight)
  }

  /**
   * 获取底部导航栏的宽度（单位像素）
   * @param component 当前的组件
   * @returns
   */
  async getBottomNavigationBarWidthPxAsync(component?: Object): Promise<number> {
    let win = await window.getLastWindow(getContext(component))
    let area = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
    let barWidth = area.bottomRect.width;
    return Promise.resolve(barWidth)
  }

  /**
   * 获取状态栏的高度（单位Vp）
   * @returns 获取不到返回 0
   */
  getStatusBarHeightVp(): number {
    try {
      const win = GlobalUtil.getWindowStage().getMainWindowSync();
      const area = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      const barHeight = area.topRect.height;
      return px2vp(barHeight)
    } catch (e) {
      return 0
    }
  }

  /**
   * 获取状态栏的宽度（单位Vp）
   * @returns 获取不到返回 0
   */
  getStatusBarWidthVp(): number {
    try {
      const win = GlobalUtil.getWindowStage().getMainWindowSync();
      const area = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      const barWidth = area.topRect.width;
      return px2vp(barWidth)
    } catch (e) {
      return 0
    }
  }

  /**
   * 获取底部导航栏的宽度（单位像素）
   * 获取不到返回 0
   * @returns
   */
  getBottomNavigationBarWidthPx(): number {
    const win = GlobalUtil.getWindowStage().getMainWindowSync();
    let area = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
    let barWidth = area.bottomRect.width;
    return barWidth
  }

  /**
   * 获取底部导航栏的高度（单位像素）
   * @returns 获取不到返回 90
   */
  getBottomNavigationBarHeightPx(): number {
    try {
      const win = GlobalUtil.getWindowStage().getMainWindowSync();
      let area = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      let barHeight = area.bottomRect.height;
      return barHeight
    } catch (e) {
      return 90
    }
  }

  /**
   * 获取底部导航栏的宽度度（单位Vp）
   * @returns 获取不到返回 0
   */
  getBottomNavigationBarWidthVp(): number {
    return px2vp(this.getBottomNavigationBarWidthPx())
  }

  /**
   * 获取底部导航栏的高度（单位Vp）
   * @returns 获取不到返回 0
   */
  getBottomNavigationBarHeightVp(): number {
    return px2vp(this.getBottomNavigationBarHeightPx())
  }
}

export const screen = new ScreenUtil();