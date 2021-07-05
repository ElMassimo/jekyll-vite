import 'virtual:windi.css'
import 'virtual:windi-devtools'
import '~/styles/prism.css'
import '~/styles/highlight.css'
import '~/styles/vitesse-light.css'
import '~/styles/main.scss'

import { createApp } from 'vue'
import NavBarActions from '~/components/NavBarActions.vue'

createApp(NavBarActions).mount('#nav-bar-actions')

console.log('Vite ⚡️ Ruby')
