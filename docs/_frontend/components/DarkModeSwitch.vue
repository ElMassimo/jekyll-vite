<script setup lang='ts'>
import { isDark, toggleDark } from '~/logic/dark'
</script>

<template>
  <NavBarIcon aria-label="Toggle theme" @click="toggleDark()">
    <transition name="slide" mode="out-in">
      <bx:bx-moon v-if="isDark"/>
      <bx:bx-sun v-else/>
    </transition>
  </NavBarIcon>
</template>

<style lang="scss">
.slide-enter-active,
.slide-leave-active {
  transition: transform .15s ease;
}

.slide-enter-from {
  transform: translateY(-100%);
}

.slide-enter-to,
.slide-leave-from {
  transform: translateY(0);
}

.slide-leave-to {
  transform: translateY(100%);
}
</style>
