/**
 * Created on 2025/4/13
 */
package ohos_app_cangjie_entry.component

import ohos.state_macro_manage.*
import ohos.component.*
import ohos.state_manage.*
import ohos.base.*
import ohos_app_cangjie_entry.vo.ChatMessageVO
import ohos_app_cangjie_entry.vo.ChatMessageVORole

@Component
public class ChatItemComponent {
    @Prop
    var chatMessageVO: ChatMessageVO
    func build() {
        Row {
            Text(chatMessageVO.content)
        }
        .justifyContent(if (chatMessageVO.role == ChatMessageVORole.User) {
            FlexAlign.Start
        } else {
            FlexAlign.End
        })
        .width(100.percent)
    }
}
