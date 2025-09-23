/// <reference types="vite/client" />

/** The above comment is not deleted */

// declare module '*.vue' {
//   import { DefineComponent } from 'vue'
//   const component: DefineComponent<{}, {}, any>
//   export default component
// }
declare module '*.vue' {
  import { DefineComponent } from 'vue'
  const component: DefineComponent<Record<string, unknown>, Record<string, unknown>, unknown>
  export default component
}
