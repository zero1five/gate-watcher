<p align="center">
  <img src="/docs/gate-watcher-logo.png" height="200" align="center"/>
</p>

> 🍓 check your javascript object is charming

## Status

<div align="center">

[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/) [![](https://img.shields.io/npm/v/gate-watcher.svg)](https://www.npmjs.com/package/gate-watcher) [![](https://img.shields.io/npm/dm/gate-watcher.svg)](https://www.npmjs.com/package/gate-watcher) [![](https://img.shields.io/npm/l/gate-watcher.svg)](https://www.npmjs.com/package/gate-watcher) [![](https://img.shields.io/badge/support%20me-donate-ff00ff.svg)](https://www.patreon.com/zero1five) [![](https://img.shields.io/badge/code_style-prettier-ff69b4.svg)](https://github.com/prettier/prettier)

</div>

## Installing

Using npm:

```bash
$ npm install gate-watcher
```
or 

```bash
$ yarn add gate-watcher
```

## Usage Example

Suppose we have a javascript object and we want to know if it is safe and has the attributes we need.

```javascript

const Watcher = require("gate-watcher");

const source = { attr: "GateWatcher" };

const Judge = Watcher
  .input(source)
  .option("attr", String)
  .parse();

if (Judge) {
  console.log("cool!");
  // The attr attribute indeed in the source object!
}

```

## API

### `input(source: Object)`
Receive objects that need to be verified.

### `option(attr: String, type: Type, defaultValue: any)`

- When there is only one parameter, Will only verify that the attribute exists.

```javascript

const source = { attr: "GateWatcher" };

const Judge = Watcher
  .input(source)
  .option("attr")
  .parse();

// Judge = true
```

- When two parameters are used, the type is also checked.

```javascript

...
  .option("attr", String)
  .parse();

// true
```

- When the parameter is complete, if the type is not correct, return false. If the property does not exist, the default value will be added to the source and return true.

```javascript

...
  .option("attr", String, "defaultValue")
  .parse();

// true
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `yarn run commit`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Author

**gate-watcher** © [zero1five](https://github.com/zero1five), Released under the [MIT](./LICENSE) License.<br>
Authored and maintained by HcySunYang.

> [github.com/zero1five](https://github.com/zero1five) · GitHub [@zero1five](https://github.com/zero1five) · Twitter [@zero1five](https://twitter.com/zero1five)

## License

MIT &copy; zero1five
