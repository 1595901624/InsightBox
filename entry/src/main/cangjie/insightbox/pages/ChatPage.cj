/**
 * Created on 2025/4/13
 */
package ohos_app_cangjie_entry.pages

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import cj_res_entry.*
import ohos.resource_manager.*
import ohos.router.Router
import std.collection.ArrayList

@Entry
@Component
public class ChatPage {
    func build() {
        RelativeContainer {
            TextInput(placeholder: "聊点什么吧")
                .width(100.percent)
                .height(60)
                .onClick {
                    evt => AppLog.info("Hello Cangjie")
                }
                .fontSize(18)
                .alignRules(
                    AlignRuleOption(
                        left: HorizontalAnchor("__container__", HorizontalAlign.Start),
                        bottom: VerticalAnchor("__container__", VerticalAlign.Bottom),
                        right: HorizontalAnchor("__container__", HorizontalAlign.End),
                    )
                )
        }
    }
}
