<h1 align="center">
  <a href="https://jekyll-vite.netlify.app/">
    <img src="https://raw.githubusercontent.com/ElMassimo/vite_ruby/main/docs/public/logo.svg" width="120px"/>
  </a>

  <br>

  <a href="https://jekyll-vite.netlify.app/">
    Jekyll ➕ Vite.js
  </a>

  <br>

  <p align="center">
    <a href="https://github.com/ElMassimo/jekyll-vite/actions">
      <img alt="Build Status" src="https://github.com/ElMassimo/jekyll-vite/workflows/build/badge.svg"/>
    </a>
    <a href="https://codeclimate.com/github/ElMassimo/jekyll-vite">
      <img alt="Maintainability" src="https://codeclimate.com/github/ElMassimo/jekyll-vite/badges/gpa.svg"/>
    </a>
    <a href="https://codeclimate.com/github/ElMassimo/jekyll-vite">
      <img alt="Test Coverage" src="https://codeclimate.com/github/ElMassimo/jekyll-vite/badges/coverage.svg"/>
    </a>
    <a href="https://rubygems.org/gems/jekyll-vite">
      <img alt="Gem Version" src="https://img.shields.io/gem/v/jekyll-vite.svg?colorB=e9573f"/>
    </a>
    <a href="https://github.com/ElMassimo/jekyll-vite/blob/master/LICENSE.txt">
      <img alt="License" src="https://img.shields.io/badge/license-MIT-428F7E.svg"/>
    </a>
  </p>
</h1>

[vite ruby]: https://github.com/ElMassimo/vite_ruby
[website]: https://jekyll-vite.netlify.app/
[jekyll]: https://jekyllrb.com/
[configuration reference]: https://vite-ruby.netlify.app/config/
[features]: https://vite-ruby.netlify.app/guide/introduction.html
[guides]: https://vite-ruby.netlify.app/guide/
[config]: https://vite-ruby.netlify.app/config/
[vite.js]: http://vitejs.dev/
[Issues]: https://github.com/ElMassimo/jekyll-vite/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc
[Discussions]: https://github.com/ElMassimo/jekyll-vite/discussions
[no bundling]: https://vitejs.dev/guide/why.html#the-problems
[bundling]: https://vitejs.dev/guide/why.html#why-bundle-for-production
[rollup.js]: https://rollupjs.org
[esbuild]: https://esbuild.github.io/
[example]: https://github.com/ElMassimo/jekyll-vite/tree/main/docs

Use [Vite.js] in [Jekyll] and enjoy a modern assets pipeline! ⚡️

<small>_This integration is powered by [__Vite Ruby__][Vite Ruby]_.</small>

## Features ⚡️

- ⚡️ Blazing fast hot reload
- 📦 Zero-config builds
- 🎨 Use your favorite tools (TypeScript, Tailwind CSS, etc.)

## Why Vite? 🤔

[Jekyll] does not have an extensible asset pipeline, which limits the amount of
integrations that exist for different languages and preprocessors. By default,
assets are not fingerprinted which is problematic for caching.

[Vite.js] has an extensible architecture and is built on top of [rollup.js], and as
a result there is an active ecosystem of plugins and tooling available. In addition,
it's [no bundling] design provides a very fluid authoring experience—changes to
your assets are reflected instantly in your browser.

## Documentation 📖

The [documentation website][website] is built using `jekyll-vite`.

You can [check the source to see an example setup][example], or visit it to
[learn how to use `jekyll-vite`][website].

## Installation 💿

Add this line to your site's Gemfile:

```ruby
gem 'jekyll-vite'
```

Then, run:

```bash
bundle install
bundle exec vite install
```

Additional installation instructions are available in the [documentation website][website].

## Getting Started 💻

Run <kbd>bin/vite dev</kbd> to start the Vite development server, and then
restart your Jekyll server with <kbd>bin/jekyll serve</kbd>.

Visit your Jekyll site and you should see a printed console output: `Vite ⚡️ Ruby`.

Check the [documentation website][website] for more information.

## Contact ✉️

Please use [Issues] to report bugs you find, and [Discussions] to make feature requests or get help.

Don't hesitate to _⭐️ star the project_ if you find it useful!

Using it in your site? Always love to hear about it! 😃

## Acknowledgements

- [Jekyll] — Even after all this time, it's still a great static site generator.
- [Vite.js] — Frontend tooling with a focus on the developer experience.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

