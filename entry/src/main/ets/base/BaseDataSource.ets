export class BasicDataSource<T> implements IDataSource {
  private listeners: DataChangeListener[] = [];
  private dataArray: T[] = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): T {
    return this.dataArray[index];
  }

  public getDataList(): T[] {
    return this.dataArray;
  }

  public addData(index: number, data: T): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public addDataList(index: number, dataList: T[]): void {
    this.dataArray.splice(index, 0, ...dataList);
    this.notifyDataAdd(index);
  }

  public delData(index: number): void {
    this.dataArray.splice(index, 1)
    this.notifyDataDelete(index);
  }

  public replace(index: number, data: T): void {
    this.dataArray[index] = data
    this.notifyDataChange(index);
  }

  // public top(index: number, data: T) {
  //   this.dataArray.splice(index, 1)
  //   this.dataArray.splice(0, 0, data);
  // }

  public pushList(list: T[]): void {
    this.dataArray.push(...list);
    this.notifyDataAdd(this.dataArray.length - list.length);
  }

  public push(data: T): void {
    this.pushData(data)
  }

  public pushData(data: T): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  public reloadData(list: T[]): void {
    this.clear()
    list.forEach(element => {
      this.dataArray.push(element)
    });
    this.notifyDataReload()
  }

  public getAllData(): T[] {
    return this.dataArray;
  }

  public clear(): void {
    this.dataArray = [];
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      // console.info('add listener');
      this.listeners.push(listener);
    }
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      // console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}