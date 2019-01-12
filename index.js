const GateWatcher = require("./src");
const a = { b: 12345 };

GateWatcher.input(a).parse();

const G = require("./src");

console.log(G);
