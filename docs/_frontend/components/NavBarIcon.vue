<script lang="ts">
import { h, defineComponent } from 'vue'

export default defineComponent({
  props: {
    tag: { type: String, default: 'button' },
  },
  render () {
    return h(this.tag, { class: 'nav-icon-button' }, this.$slots?.default?.({}))
  },
})
</script>

<style lang="scss">
.nav-icon-button {
  @apply inline-flex rounded-lg p-2
  text-$c-text text-1.05rem cursor-pointer
  focus:outline-none
  bg-warm-gray-100 hover:bg-warm-gray-200
  dark:(bg-dark-400 hover:bg-dark-300) overflow-hidden;
}
</style>
