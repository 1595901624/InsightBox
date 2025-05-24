// export function clone<T>(obj: T): T {
//   return Object.assign({}, obj);
// }

export function deepClone<T>(obj: T): T {
  return JSON.parse(JSON.stringify(obj));
}