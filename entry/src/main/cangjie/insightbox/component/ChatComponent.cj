/**
 * Created on 2025/4/13
 */
package ohos_app_cangjie_entry.component

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import std.collection.*
import ohos_app_cangjie_entry.datasource.ChatDataSource
import ohos_app_cangjie_entry.vo.ChatMessageVO
import ohos_app_cangjie_entry.vo.ChatMessageVORole

@Component
public class ChatComponent {
    @State
    var chatDataSource: ChatDataSource = ChatDataSource(ArrayList<ChatMessageVO>())

    public func aboutToAppear() {
        var data = ArrayList<ChatMessageVO>()
        for (i in 0..50) {
            data.append(
                ChatMessageVO("id_${i}", "content_${i}",
                    if (i % 2 == 0) {
                        ChatMessageVORole.User
                    } else {
                        ChatMessageVORole.Assistant
                    }))
        }
        chatDataSource = ChatDataSource(data)
    }

    func build() {
        RelativeContainer {
            List() {
                LazyForEach(
                    chatDataSource,
                    itemGeneratorFunc: {
                        item: ChatMessageVO, index: Int64 => ListItem() {
                            ChatItemComponent(chatMessageVO: item)
                        }
                    },
                    keyGeneratorFunc: {
                        item: ChatMessageVO, index: Int64 => return "${item.id}"
                    }
                )
            }
        }.width(100.percent).height(100.percent)
    }
}
