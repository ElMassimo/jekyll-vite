import { defineConfig } from 'vite-plugin-windicss'
import colors from 'windicss/colors'
import typography from 'windicss/plugin/typography'

export default defineConfig({
  darkMode: 'class',
  plugins: [
    typography(),
  ],
  safelist: ['prose', 'm-auto', 'text-left'],
  theme: {
    extend: {
      colors: {
        accent: colors.lightBlue,
      },
      screens: {
        print: { raw: 'print' },
      },
      typography: {
        DEFAULT: {
          css: {
            color: 'var(--fg)',
            maxWidth: '65ch',
            a: {
              color: 'var(--fg-deeper)',
            },
            b: { color: 'var(--fg-deep)' },
            code: { color: 'var(--fg-deep)' },
            strong: { color: 'var(--fg-deep)' },
            blockquote: { color: 'var(--fg-deep)' },
            em: { color: 'inherit' },
            h1: { color: 'var(--fg-deeper)' },
            h2: { color: 'var(--fg-deep)' },
            h3: { color: 'inherit' },
            h4: { color: 'inherit' },
          },
        },
      },
    },
  },
})
