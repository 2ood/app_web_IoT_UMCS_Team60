module.exports = {
  devServer: {
    disableHostCheck: true,
    proxy: {
      '/api': {
        target: 'https://militaryumcs.com',
      },
    }
  },
  publicPath: process.env.NODE_ENV === "production" ? "./" : "",
  outputDir: '../dist',
  transpileDependencies: ["vuetify"],
};
