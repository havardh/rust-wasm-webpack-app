const main = require("./main.rs");

main.initialize({
  noExitRuntime: true,
}).then(module => {
  const add = module.cwrap("add", "number", ["number", "number"]);

  console.log("calling rust from javascript");
  console.log(add(1, 2));
});
