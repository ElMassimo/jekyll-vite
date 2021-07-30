---
title: Development 💻
date: 2021-07-05 09:31 -03:00
---
[configuration reference]: https://vite-ruby.netlify.app/config/
[guides]: https://vite-ruby.netlify.app/guide/
[website]: https://vite-ruby.netlify.app/
[docs repo]: https://github.com/ElMassimo/jekyll-vite/tree/main/docs
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
[entrypoints]: https://vitejs.dev/guide/build.html#multi-page-app
[vite_client_tag]: https://github.com/ElMassimo/vite_ruby/blob/main/lib/vite_rails/helper.rb#L13-L17
[vite_javascript_tag]: https://github.com/ElMassimo/vite_ruby/blob/main/lib/vite_rails/helper.rb#L28-L51
[vite_typescript_tag]: https://github.com/ElMassimo/vite_ruby/blob/main/lib/vite_rails/helper.rb#L57-L59
[vite_stylesheet_tag]: https://github.com/ElMassimo/vite_ruby/blob/main/lib/vite_rails/helper.rb#L62-L64
[vite_asset_path]: https://github.com/ElMassimo/vite_ruby/blob/main/lib/vite_rails/helper.rb#L23-L25
[sourceCodeDir]: https://vite-ruby.netlify.app/config/#sourcecodedir
[entrypointsDir]: https://vite-ruby.netlify.app/config/#entrypointsdir
[watchAdditionalPaths]: https://vite-ruby.netlify.app/config/#watchadditionalpaths
[aliased]: https://github.com/rollup/plugins/tree/master/packages/alias


Run <kbd>bin/vite dev</kbd> to start the Vite development server.

It will use your [`config/vite.json`][json config] configuration, which can be
used to configure the `host` and `port`, as well as [other options][dev options].

Then, restart your Jekyll server with <kbd>bin/jekyll serve</kbd>.

Visit your Jekyll site and you should see a printed console output: `Vite ⚡️ Ruby`.

<!--more-->

## Entrypoints ⤵️

Any files inside your [<kbd>entrypointsDir</kbd>][entrypointsDir] will be
considered [entries][entrypoints] to your application.

<div class="language-">
  <pre>
<code>_frontend: <a href="/config/#sourcecodedir"><kbd>sourceCodeDir</kbd></a>
  ├── entrypoints: <a href="/config/#entrypointsdir"><kbd>entrypointsDir</kbd></a>
  │   # only Vite entry files here
  │   └── application.js
  │   └── typography.css
  └── components:
  │   └── App.jsx
  └── stylesheets:
  │   └── main.scss
  └── images:
      └── logo.svg</code>
</pre>
</div>

These files will be automatically detected and passed on to Vite, all [configuration][entrypoints] is done
for you.

You can add them to your HTML layouts or views using the provided [tag helpers].

## Import Aliases 👉

For convenience, `~/` and `@/` are [aliased] to your [<kbd>sourceCodeDir</kbd>][sourceCodeDir],
which simplifies imports:

```js
import App from '~/components/App.jsx'
import '@/stylesheets/main.scss'
```

## CLI Commands ⌨️

A CLI tool is provided, you can run it using <kbd>bundle exec vite</kbd>, or <kbd>bin/vite</kbd> after installation.

For information about the CLI options run <kbd>bin/vite --help</kbd>.
