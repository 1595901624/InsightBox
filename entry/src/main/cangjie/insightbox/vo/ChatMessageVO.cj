/**
 * Created on 2025/4/13
 */
package ohos_app_cangjie_entry.vo

public struct ChatMessageVO {
    public var id: String = ""
    public var content: String = ""
    public var role: Int32 = ChatMessageVORole.User

    public init(id: String, content: String, role: Int32) {
        this.id = id
        this.content = content
        this.role = role
    }
}
