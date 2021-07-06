---
title: Deployment 🚀
date: 2021-07-05 19:31 -03:00
---

[hosted]: https://github.com/ElMassimo/jekyll-vite/blob/main/netlify.toml
[netlify]: https://www.netlify.com/
[RollupJS]: https://rollupjs.org

Run <kbd>jekyll build</kbd> as usual, and `jekyll-vite` will take care of running
Vite.js to compile assets.

Besides the advantages during development, you get the best out of [RollupJS] in production.

For example, asset fingerprinting enables simple caching, better performance, and ensures no users experience stale assets 😎

<!--more-->

_GitHub Pages_ does not support all Jekyll plugins, so you will need to build it in a workflow, or
host it in a different service—such as _[Netlify]_, where this site is [hosted].

Remember to install all npm packages that are necessary to build the frontend assets.
