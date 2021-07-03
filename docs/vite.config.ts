import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import WindiCSS from 'vite-plugin-windicss'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    WindiCSS({
      root: __dirname,
      scan: {
        dirs: ['_layouts', '_posts'],
      },
    }),
  ],
})
