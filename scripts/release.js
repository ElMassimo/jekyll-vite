/* eslint-disable @typescript-eslint/no-var-requires */

/**
 * modified from https://github.com/vuejs/vue-next/blob/master/scripts/release.js
 */
const path = require('path')
const fs = require('fs')
const execa = require('execa')
const args = require('minimist')(process.argv.slice(2))
const semver = require('semver')
const chalk = require('chalk')
const { prompt } = require('enquirer')

const pkg = rubyPackage()

/**
 * @type {boolean}
 */
const isDryRun = args.dry

/**
 * @type {import('semver').ReleaseType[]}
 */
const versionIncrements = [
  'patch',
  'minor',
  'major',
  'prepatch',
  'preminor',
  'premajor',
  'prerelease',
]

/**
 * @param {import('semver').ReleaseType} i
 */
function inc (i) {
  return semver.inc(pkg.version, i)
}

/**
 * @param {string} bin
 * @param {string[]} args
 * @param {object} opts
 */
function run (bin, args, opts = {}) {
  return execa(bin, args, { stdio: 'inherit', ...opts })
}

/**
 * @param {string} bin
 * @param {string[]} args
 * @param {object} opts
 */
function dryRun (bin, args, opts = {}) {
  console.log(chalk.blue(`[dryrun] ${bin} ${args.join(' ')}`), opts)
}

/**
 * @param {string} msg
 */
function step (msg) {
  console.log(chalk.cyan(msg))
}

/**
 * @param {string} paths
 */
function resolve (paths) {
  return path.resolve(__dirname, `../${paths}`)
}

function rubyPackage () {
  const versionRegex = /VERSION = '([\d.]+)'/
  const path = resolve(`lib/jekyll/vite/version.rb`)
  const content = fs.readFileSync(path, 'utf-8')
  const versionCaptures = content.match(versionRegex)
  const version = versionCaptures && versionCaptures[1]
  if (!version) {
    console.error(chalk.red(`Could not infer version for jekyll-vite.`))
    process.exit(1)
  }
  return {
    type: 'gem',
    path,
    content,
    version,
    updateVersion (version) {
      const newContent = content.replace(versionRegex, `VERSION = '${version}'`)
      fs.writeFileSync(path, `${newContent}`)
    },
  }
}

async function main () {
  const runIfNotDry = isDryRun ? dryRun : run

  if (!targetVersion) {
    // no explicit version, offer suggestions
    /**
     * @type {{ release: string }}
     */
    const { release } = await prompt({
      type: 'select',
      name: 'release',
      message: 'Select release type',
      choices: versionIncrements
        .map(i => `${i} (${inc(i)})`)
        .concat(['custom']),
    })

    if (release === 'custom') {
      /**
       * @type {{ version: string }}
       */
      const res = await prompt({
        type: 'input',
        name: 'version',
        message: 'Input custom version',
        initial: pkg.version,
      })
      targetVersion = res.version
    }
    else {
      targetVersion = release.match(/\((.*)\)/)[1]
    }
  }

  if (!semver.valid(targetVersion))
    throw new Error(`invalid target version: ${targetVersion}`)

  const tag = `v${targetVersion}`

  /**
   * @type {{ yes: boolean }}
   */
  const { yes } = await prompt({
    type: 'confirm',
    name: 'yes',
    message: `Releasing ${tag}. Confirm?`,
  })

  if (!yes)
    return

  step(`\nUpdating ${pkg.type} version...`)
  pkg.updateVersion(targetVersion)

  step(`\nLinting ${pkg.type}...`)
  await run('bundle install && bin/rubocop -A', { shell: true })

  step('\nGenerating changelog...')
  await run('pnpm', ['changelog'])

  const { stdout } = await run('git', ['diff'], { stdio: 'pipe' })
  if (stdout) {
    step('\nCommitting changes...')
    await runIfNotDry('git', ['add', '-A'])
    await runIfNotDry('git', ['commit', '-m', `release: ${tag}`])
  }
  else {
    console.log('No changes to commit.')
  }

  step(`\nPublishing ${pkg.type}...`)
  await publishGem(targetVersion)

  step('\nPushing to GitHub...')
  await runIfNotDry('git', ['push'])

  if (isDryRun)
    console.log(`\nDry run finished - run git diff to see ${pkg.type} changes.`)

  console.log()
}

/**
 * @param {string} version
 * @param {Function} runIfNotDry
 */
async function publishGem (version) {
  try {
    const runIfNotDry = isDryRun ? dryRun : execa.commandSync
    await runIfNotDry('bundle exec rake release', {
      stdio: 'inherit',
      cwd: resolve('.'),
    })
    console.log(chalk.green(`Successfully published v${version}`))
  }
  catch (e) {
    if (e.stderr.match(/previously/))
      console.log(chalk.red(`Skipping already published: ${version}`))
    else
      throw e
  }
}

main().catch((err) => {
  console.error(err)
})
