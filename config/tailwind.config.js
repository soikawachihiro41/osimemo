const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/views/**/*.html.erb',
    './app/assets/stylesheets/**/*.css'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        'zenmaru': ['Zen Maru Gothic', 'serif'],
        'kaisei-decol': ['Kaisei Decol', 'serif'],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require("daisyui"),
    function ({ addUtilities }) {
      const newUtilities = {
        '.custom-focus:focus': {
          'border-color': '#fff1f5',
          'box-shadow': '0 0 0 3px rgba(255, 241, 245, 0.5)',
        },
      };
      addUtilities(newUtilities, ['responsive', 'hover', 'focus']);
    },
  ],
  daisyui: {
    themes: [
      {
        mytheme: {
          primary: "#5c7b64",
          "primary-content": "#ffe4e6",
          "base-100": "#fff1f2",
          "base-content": "#372f38",
        },
      }
    ],
  },
  variants: {},
};
