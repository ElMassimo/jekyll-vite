import { resolve } from 'path'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import ruby from 'vite-plugin-ruby'
import windicss from 'vite-plugin-windicss'
import icons from 'unplugin-icons/vite'
import IconsResolver from 'unplugin-icons/resolver'
import components from 'unplugin-vue-components/vite'

export default defineConfig({
  plugins: [
    vue(),
    icons({
      autoInstall: true,
    }),
    ruby(),
    components({
      dirs: [resolve(__dirname, '_frontend/components')],
      resolvers: [
        IconsResolver({ componentPrefix: '' }),
      ],
    }),
    windicss({
      root: __dirname,
      configFiles: [resolve(__dirname, 'windi.config.ts')],
      scan: {
        dirs: ['_layouts', '_includes', '_posts', '_frontend'],
      },
    }),
  ],
})
