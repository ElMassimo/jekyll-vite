const toPrefetch = new Set()

const sameDomain = (el: HTMLAnchorElement) =>
  el.hostname === location.hostname && el.protocol === location.protocol

const prefetchHref = ({ type, target: el }: Event) => {
  const { href: url } = el as HTMLAnchorElement
  if (!url || toPrefetch.has(url)) return

  toPrefetch.add(url)
  el?.removeEventListener(type, prefetchHref)

  fetch(url, { credentials: 'include' })
}

export function setupPrefetch () {
  Array.from(document.querySelectorAll<HTMLAnchorElement>('a[href]'))
    .filter(sameDomain)
    .forEach((el) => {
      ['touchstart', 'mouseenter'].forEach((eventName) => {
        el.addEventListener(eventName, prefetchHref, { passive: true })
      })
    })
}
