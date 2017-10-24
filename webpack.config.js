module.exports = {
  entry: "./src/index.js",
  output: {
    filename: "bundle.js",
    path: "/build",
  },
  module: {
    rules: [
      {
        test: /\.rs$/,
        use: {
          loader: "rust-wasm-loader",
          options: {path: "/build"}
        }
      }
    ]
  },
  externals: {
    fs: true,
    path: true,
  },
  devServer: {
    inline: true
  }
};
