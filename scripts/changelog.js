/* eslint-disable @typescript-eslint/no-var-requires */
const path = require('path')
const fs = require('fs')
const args = require('minimist')(process.argv.slice(2))
const execa = require('execa')
const chalk = require('chalk')

/**
 * @param {string} bin
 * @param {string[]} args
 * @param {object} opts
 */
const run = (bin, args, opts = {}) =>
  execa(bin, args, { stdio: 'inherit', ...opts })

/**
 * @param {string} paths
 */
const resolve = paths => path.resolve(__dirname, `../${paths}`)

/**
 * @param {string} name
 */
function writePackageJson () {
  const versionRegex = /VERSION = '([\d.]+)'/
  const versionFile = fs.readFileSync(resolve(`lib/jekyll/vite/version.rb`), 'utf-8')
  const versionCaptures = versionFile.match(versionRegex)
  const version = versionCaptures && versionCaptures[1]
  if (!version) {
    console.error(chalk.red(`Could not infer version for jekyll-vite.`))
    process.exit(1)
  }
  const path = resolve('package.json')
  const content = fs.readFileSync(path, 'utf-8')
  const newContent = { ...JSON.parse(content), version }
  fs.writeFileSync(path, `${JSON.stringify(newContent, null, 2)}\n`)
}

async function main () {
  writePackageJson()
  await run('npx', ['conventional-changelog', `-p angular -i CHANGELOG.md -s -t v --pkg ./package.json --commit-path .`])
}

main().catch((err) => {
  console.error(err)
})
