import 'virtual:windi.css'
import 'virtual:windi-devtools'
import '~/styles/main.scss'

import { createApp } from 'vue'
import { setupPrefetch } from '~/logic/prefetch'
import NavBarActions from '~/components/NavBarActions.vue'

createApp(NavBarActions).mount('#nav-bar-actions')

console.log('Powered by Vite ⚡️ Jekyll')
console.log('https://github.com/ElMassimo/jekyll-vite')

document.addEventListener('DOMContentLoaded', () => {
  setupPrefetch()
})
