module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      {
        mytheme: {
          primary: "#5c7b64",
          "primary-content": "#ffe4e6",
          "base-100": "#fff1f2",
          "base-content": "#372f38",
          extend: {
            fontFamily: {
              'zenmaru': ['Zen Maru Gothic', 'serif'],
            },
          },
        },
      }
    ],
  },
}
