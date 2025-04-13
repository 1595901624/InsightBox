/**
 * Created on 2025/4/13
 */
package ohos_app_cangjie_entry.vo

public enum ChatMessageVORole <: Equatable<ChatMessageVORole> {
    /**
     * System: 系统消息
     */
    | System
    /**
     * User: 用户消息
     */
    | User
    /**
     * Assistant: 助手消息
     */
    | Assistant


//    public func compare(other: ChatMessageVORole): Ordering {
//        Ordering.EQ
//    }
//
//    public operator func !=(that: Ordering): Bool {
//        if (that == Ordering.EQ) {
//            return false
//        }
//        return true
//    }
    public operator func ==(that: ChatMessageVORole): Bool {
        if (that == this) {
            return true
        }
        return false
    }

    public operator func !=(that: ChatMessageVORole): Bool {
        if (that != this) {
            return true
        }
        return false
    }
//    public operator func <(that: ChatMessageVORole): Bool {
//        if (that == Ordering.LT) {
//            return true
//        }
//        return false
//    }
//    public operator func >(that: Ordering): Bool {
//        if (that == Ordering.GT) {
//            return true
//        }
//        return false
//    }
//    public operator func <=(that: Ordering): Bool {
//        if (that == Ordering.LT || that == Ordering.EQ) {
//            return true
//        }
//        return false
//    }
//
//    public operator func >=(that: Ordering): Bool {
//        if (that == Ordering.GT || that == Ordering.EQ) {
//            return true
//        }
//        return false
//    }
}
