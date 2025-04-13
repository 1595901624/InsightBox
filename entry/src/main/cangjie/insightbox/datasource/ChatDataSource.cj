/**
 * Created on 2025/4/13
 */
package ohos_app_cangjie_entry.datasource

import ohos.component.IDataSource
import ohos_app_cangjie_entry.vo.ChatMessageVO
import std.collection.ArrayList
import ohos.component.DataChangeListener

/**
 * 聊天消息数据源
 */
public class ChatDataSource <: IDataSource<ChatMessageVO> {
    public ChatDataSource(let data: ArrayList<ChatMessageVO>) {}
    public var listenerOp: Option<DataChangeListener> = None

    public func getData(index: Int64): ChatMessageVO {
        return data[index]
    }

    public func totalCount(): Int64 {
        return data.size
    }

    public func onRegisterDataChangeListener(listener: DataChangeListener): Unit {
        listenerOp = listener
    }

    public func onUnregisterDataChangeListener(listener: DataChangeListener): Unit {
        listenerOp = None
    }

    public func notifyChange(): Unit {
        let listener: DataChangeListener = listenerOp.getOrThrow()
        listener.onDataReloaded()
    }
}
