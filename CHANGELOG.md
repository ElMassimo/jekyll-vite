## [3.0.3](https://github.com/ElMassimo/jekyll-vite/compare/v3.0.0...v3.0.3) (2021-08-16

* fix: Liquid Exception: missing keyword: :ssr (#9) ([11c10c3](https://github.com/ElMassimo/jekyll-vite/commit/11c10c3)), closes [#9](https://github.com/ElMassimo/jekyll-vite/issues/9)

# [3.0.0](https://github.com/ElMassimo/jekyll-vite/compare/v1.0.0...v3.0.0) (2021-08-16)

See ElMassimo/vite_ruby/pull/116 for features and breaking changes.

# [1.0.0](https://github.com/ElMassimo/jekyll-vite/compare/v0.0.3...v1.0.0) (2021-07-22)


### Features

* Watch layouts and partials by default ([004e8f1](https://github.com/ElMassimo/jekyll-vite/commit/004e8f1318fda3031a7ea8ebbd6b396e742b7642))



## [0.0.3](https://github.com/ElMassimo/jekyll-vite/compare/v0.0.2...v0.0.3) (2021-07-05)

### Features

- Add support for Jekyll 3.9
- Add `vite_react_refresh_tag` helper

### Bug Fixes

- Ensure non-proxied requests are served with an HTTP status
- Ensure Ruby 3.0 support


## [0.0.2](https://github.com/ElMassimo/jekyll-vite/compare/v0.0.1...v0.0.2) (2021-07-03)


### Bug Fixes

* Do not serve files with custom status in local development server ([86cf47b](https://github.com/ElMassimo/jekyll-vite/commit/86cf47b485520879c7b7e7a79c7245dc0ba92b16))



## 0.0.1 (2021-07-02)

### Features

* Build vite assets when generating site and preserve assets correctly ([0b9a138](https://github.com/ElMassimo/jekyll-vite/commit/0b9a138393a00c96119e42d5a59ac71539d00912))
* Ignore Vite dir when the dev server is active, add the last build ([548a47f](https://github.com/ElMassimo/jekyll-vite/commit/548a47f8bbb6f22820083d22d4628d445149ba46))
* Implement a WEBrick proxy servlet for Jekyll ([b5afe03](https://github.com/ElMassimo/jekyll-vite/commit/b5afe03b763235c23d9eaf940086d6ddb19399dc))
* Implement liquid tags to render script and stylesheet tags ([4cbb679](https://github.com/ElMassimo/jekyll-vite/commit/4cbb679af2625f31954c56b7cda032c896d7e127))
* Read mode from JEKYLL_ENV ([acd7181](https://github.com/ElMassimo/jekyll-vite/commit/acd7181c507cd1971f056462f240dec0071acf3b))
* Serve files from the cache when the Vite dev server is down ([d695718](https://github.com/ElMassimo/jekyll-vite/commit/d695718b1805211aa8b63c81d140b7212d2347f5))
* Track dependencies on entrypoints ([5b8c413](https://github.com/ElMassimo/jekyll-vite/commit/5b8c41336085e24568750bcbc77192f498488f46))



