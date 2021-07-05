---
title: Tag Helpers 🏷
date: 2021-07-05 10:21 -03:00
---
[tag helpers]: https://vite-ruby.netlify.app/guide/rails.html#tag-helpers-%F0%9F%8F%B7
[discussions]: https://github.com/ElMassimo/vite_ruby/discussions
[rails]: https://rubyonrails.org/
[webpacker]: https://github.com/rails/webpacker
[vite rails]: https://github.com/ElMassimo/vite_ruby
[vite]: https://vitejs.dev/
[vite-templates]: https://github.com/vitejs/vite/tree/main/packages/create-app
[plugins]: https://vitejs.dev/plugins/
[configuration reference]: https://vite-ruby.netlify.app/config/
[build]: https://vite-ruby.netlify.app/config/#build-options
[dev options]: https://vite-ruby.netlify.app/config/#development-options
[json config]: https://vite-ruby.netlify.app/config/#shared-configuration-file-%F0%9F%93%84
[vite config]: https://vite-ruby.netlify.app/config/#configuring-vite-%E2%9A%A1
[sourceCodeDir]: https://vite-ruby.netlify.app/config/#sourcecodedir
[autoBuild]: https://vite-ruby.netlify.app/config/#autobuild
[entrypoints]: https://vite-ruby.netlify.app/guide/development.html#entrypoints-⤵%EF%B8%8F
[helpers]: https://github.com/ElMassimo/vite_ruby/blob/main/vite_hanami/lib/vite_hanami/tag_helpers.rb
[previous]: https://vite-ruby.netlify.app/posts/development
[vite_hanami]: https://github.com/ElMassimo/vite_ruby/tree/main/vite_hanami
[hanami]: https://hanamirb.org/
[installed example]: https://github.com/ElMassimo/vite_ruby/tree/main/examples/hanami_bookshelf
[Liquid]: https://shopify.github.io/liquid/

Use the following [Liquid] tags to link JavaScript and CSS [entrypoints] managed by Vite in your Jekyll pages or partials:

- [<kbd>vite_javascript_tag</kbd>][helpers]: Renders a `<script>` tag referencing a JavaScript file
- [<kbd>vite_typescript_tag</kbd>][helpers]: Renders a `<script>` tag referencing a TypeScript file
- [<kbd>vite_stylesheet_tag</kbd>][helpers]: Renders a `<link>` tag referencing a CSS file

<!--more-->

{% raw %}
```html
<head>
  <title>Example</title>
  {% vite_client_tag %}
  {% vite_typescript_tag application %}
  {% vite_stylesheet_tag typography.scss %}
</head>
```
{% endraw %}

For other types of assets, you can use [<kbd>vite_asset_path</kbd>][helpers] and pass the resulting URI to the appropriate tag helper.

{% raw %}
```html
<img src="{% vite_asset_path logo.svg %}" alt="Logo"/>
```
{% endraw %}

### Enabling Hot Module Reload 🔥

Use the following helpers to enable HMR in development:

- [<kbd>vite_client_tag</kbd>][helpers]: Renders the Vite client to enable Hot Module Reload
- [<kbd>vite_react_refresh_tag</kbd>][helpers]: Only when using `@vitejs/plugin-react-refresh`

They will only render if the dev server is running.

### Smart Output ✨

For convenience, [<kbd>vite_javascript_tag</kbd>][helpers] and [<kbd>vite_typescript_tag</kbd>][helpers] will automatically inject tags for styles or entries imported within a script.

{% raw %}
```haml
{% vite_typescript_tag application %}
```
{% endraw %}

Example output:

```html
<script src="/vite/assets/application.a0ba047e.js" type="module" crossorigin="anonymous"/>
<link rel="modulepreload" href="/vite/assets/example_import.8e1fddc0.js" as="script" type="text/javascript" crossorigin="anonymous">
<link rel="stylesheet" media="screen" href="/vite/assets/application.cccfef34.css">
```

When running the development server, Vite will inject imports and styles dynamically to enable HMR.

```html
<script src="/vite/assets/application.ts" type="module" crossorigin="anonymous"/>
```
