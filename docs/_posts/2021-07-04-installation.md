---
title: Installation 💿
date: 2021-07-04 12:30 -03:00
---

[vite]: https://vitejs.dev/
[vite-plugin-ruby]: https://github.com/ElMassimo/vite_ruby/tree/main/vite-plugin-ruby
[commands]: /guide/development.html#cli-commands-⌨%EF%B8%8F
[json config]: /config/#shared-configuration-file-%F0%9F%93%84
[vite config]: /config/#configuring-vite-%E2%9A%A1
[custom head]: https://github.com/ElMassimo/jekyll-vite-minima
[development]: /posts/development

Add this line to your site's Gemfile:

```ruby
gem 'jekyll-vite'
```

Then, run:

```bash
bundle install
bundle exec vite install
```

<!--more-->

This will add the plugin in `_config.yml`:

```yml
plugins:
  - jekyll/vite
```

It will also generate a sample setup in `_layouts/default.html` (if it exists):

{% raw %}
```html
<head>
  <!-- meta tags, etc -->
  {% vite_client_tag %}
  {% vite_javascript_tag application %}
</head>
```
{% endraw %}

> If you are using a theme such as `minima`, you will want to provide a
[custom head] with these liquid tags. [Or use a __starter template__][custom head]

It also:

- Adds an <kbd>exe/dev</kbd> command that you can use to [start both Jekyll and Vite][development]
- Adds the <kbd>bin/vite</kbd> executable to start the dev server and run other [commands]
- Installs [<kbd>vite</kbd>][vite] and [<kbd>vite-plugin-ruby</kbd>][vite-plugin-ruby]
- Adds [`vite.config.ts`][vite config] and [`config/vite.json`][json config] configuration files
- Creates a sample `application.js` entrypoint in your Jekyll site

