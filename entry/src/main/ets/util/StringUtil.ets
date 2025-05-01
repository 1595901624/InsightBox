class StringUtil {
  /**
   * 获取字符串
   * @param resourceStr
   * @returns
   */
  getString(resourceStr: ResourceStr): string {
    if (typeof resourceStr == "string") {
      return resourceStr
    }
    return getContext(this).resourceManager.getStringSync(resourceStr.id)
  }
}

export const stringUtil = new StringUtil()