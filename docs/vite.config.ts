import { resolve } from 'path'
import { defineConfig } from 'vite'
import VuePlugin from '@vitejs/plugin-vue'
import RubyPlugin from 'vite-plugin-ruby'
import WindiCSS from 'vite-plugin-windicss'
import IconsPlugin, { ViteIconsResolver } from 'vite-plugin-icons'
import ComponentsPlugin from 'vite-plugin-components'

export default defineConfig({
  plugins: [
    VuePlugin(),
    IconsPlugin(),
    RubyPlugin(),
    ComponentsPlugin({
      dirs: [resolve(__dirname, '_frontend/components')],
      customComponentResolvers: ViteIconsResolver({
        componentPrefix: '',
      }),
    }),
    WindiCSS({
      root: __dirname,
      configFiles: [resolve(__dirname, 'windi.config.ts')],
      scan: {
        dirs: ['_layouts', '_includes', '_posts', '_frontend'],
      },
    }),
  ],
})
