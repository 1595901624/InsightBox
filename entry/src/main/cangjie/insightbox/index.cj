package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.State
import ohos.state_macro_manage.r
import ohos.router.Router
import ohos_app_cangjie_entry.util.ScreenUtil

import ohos_app_cangjie_entry.component.ChatItemComponent
import ohos_app_cangjie_entry.vo.ChatMessageVO
import ohos_app_cangjie_entry.vo.ChatMessageVORole

@Entry
@Component
class EntryView {
    @State
    var message: String = "Hello Cangjie"
    func build() {
        Row {
            Column {

                Button(message)
                    .onClick {
                        evt =>
                        AppLog.info("Hello Cangjie")
                        Router.push(url: "ChatPage")
                    }
                    .fontSize(40)
                    .height(80)

            }.width(100.percent)
        }.height(100.percent)
    }

    public func aboutToAppear() {
        let x = ScreenUtil.getScreenWidthPx()
        AppLog.info("Screen width in px: ${x.value}")
    }
}
