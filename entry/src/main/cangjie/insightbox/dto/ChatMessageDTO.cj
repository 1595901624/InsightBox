/**
 * Created on 2025/4/13
 */
package ohos_app_cangjie_entry.dto

public struct ChatMessageDTO {
    var id: Option<String> = Some("")
    var content: Option<String> = Some("")

    init(id: String, content: String) {
        this.id = Some(id)
        this.content = Some(content)
    }
}
