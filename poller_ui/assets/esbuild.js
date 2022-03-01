const esbuild = require("esbuild");
const esbuildSvelte = require("esbuild-svelte");
const sveltePreprocess = require("svelte-preprocess");

// Decide which mode to proceed with
let mode = "build";
process.argv.slice(2).forEach((arg) => {
  if (arg === "--watch") {
    mode = "watch";
  } else if (arg === "--deploy") {
    mode = "deploy";
  }
});

const plugins = [
  esbuildSvelte({
    preprocess: sveltePreprocess(),
  }),
];

esbuild
  .build({
    entryPoints: ["src/main.ts"],
    bundle: true,
    logLevel: "info",
    target: "es2020",
    // external: ["phoenix", "phoenix_live_view", "phoenix_html"],
    external: ["/images", "/fonts"],
    outdir: "../priv/static/assets",
    watch: mode === "watch",
    sourcemap: mode === "watch",
    plugins,
    minify: mode === "deploy",
  })
  .then((result) => {
    if (mode === "watch") {
      process.stdin.pipe(process.stdout);
      process.stdin.on("end", () => {
        result.stop();
      });
    }
  })
  .catch((error) => {
    process.exit(1);
  });
