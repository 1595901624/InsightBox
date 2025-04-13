/**
 * Created on 2025/4/13
 */
package ohos_app_cangjie_entry.util

import ohos.display.getDefaultDisplaySync
import ohos.component.px2vp
import ohos.base.Length
import ohos.base.LengthType

public class ScreenUtil {
    /*
     * 获取屏幕高度的px值
     */
    public static func getScreenWidthPx(): Length {
        let width: Int32 = getDefaultDisplaySync().width
        let widthLength = Length(Int64(width), unitType: LengthType.px)
        return widthLength
    }

    /*
     * 获取屏幕宽度的vp值
     */
    public static func getScreenWidthVp(): Length {
        return px2vp(getScreenWidthPx()) ?? Length(0, unitType: LengthType.vp)
    }
}
