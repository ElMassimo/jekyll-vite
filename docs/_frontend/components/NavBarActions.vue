<script setup lang="ts">
const viteRubyUrl = 'https://vite-ruby.netlify.app'
const repoUrl = 'https://github.com/ElMassimo/jekyll-vite'
</script>

<template>
  <div class="flex items-center border-b-0 ml-3 space-x-6 ml-4">
    <ExternalLink :href="viteRubyUrl">Vite Ruby</ExternalLink>
    <ExternalLink :href="repoUrl">GitHub</ExternalLink>
    <DarkModeSwitch/>

    <slot/>
  </div>
</template>
