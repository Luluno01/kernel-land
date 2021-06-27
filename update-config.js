const { writeFile, readFile } = require('fs').promises


function setConfig(config, key, value) {
  /**
   * RegExp for checking existance
   */
  const existRegExp = new RegExp(`^(\\s*${key}\\s*=)`, 'gm')
  if (!config.match(existRegExp)) {
    if (value === null) {
      console.log(key, 'unchanged')
      return config
    } else {
      console.log(key, 'added')
      return `${config}${config.endsWith('\n') ? '' : '\n'}${key}=${value}\n`
    }
  } else {
    // Already set
    if (!value) {
      // Unset
      console.log(key, 'unset')
      return config.replace(existRegExp, '# $1')
    } else {
      // Change value
      const changeValueRegExp = new RegExp(`^(\\s*${key}\\s*=)([\\s\\S]*?)$`, 'm')
      const [ _, prefix, oldVal ] = config.match(changeValueRegExp)
      if (oldVal == value) {
        console.log(key, 'unchanged')
        return config
      } else {
        console.log(key, 'changed from', oldVal, 'to', value)
        return config.replace(changeValueRegExp, `# $1$2\n${key}=${value}`)
      }
    }
  }
}

async function main() {
  let [ config, rawNewConfig ] = await Promise.all([
    (async () => (await readFile('.config')).toString())(),
    (async () => (await readFile('../new-config.txt')).toString())()
  ])
  const newConfig = rawNewConfig.trim()
    .split(/[\r\n]+/)
    .map(line => line.trim().split('='))
  for (const [ key, value ] of newConfig) {
    config = setConfig(config, key, value)
  }
  await writeFile('.config', config)
  console.log('.config updated')
}

main()
