const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: {
    files: [
      './public/*.html',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
      './app/views/**/*.{erb,html}',
      './app/views/**/*.html.erb',
      './app/assets/stylesheets/**/*.css'
    ],
  },
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        'zenmaru': ['Zen Maru Gothic', 'serif'],
        'kaisei-decol': ['Kaisei Decol', 'serif'],
      },
      backgroundColor: { // この部分を追加
        '5c7b64': '#5c7b64',
        'fcd8df': '#fcd8df'
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require("daisyui"),

    // New utility for focus
    function ({ addUtilities }) {
      const newUtilities = {
        '.custom-focus:focus': {
          'border-color': '#fff1f5',
          'box-shadow': '0 0 0 3px rgba(255, 241, 245, 0.5)',
        },
      };
      addUtilities(newUtilities, ['responsive', 'hover', 'focus']);
    },

    // New component for .tabs
    function ({ addComponents }) {
      const components = {
        '.tabs': {
          display: 'flex',  // For horizontal tabs
          justifyContent: 'center',  // Center the tabs horizontally
          gap: '1rem'  // Space between tabs
        },
      };
      addComponents(components);
    }
  ],
  daisyui: {
    themes: [
      {
        mytheme: {
          primary: "#5c7b64",
          "primary-content": "#ffe4e6",
          "base-100": "#fff1f2",
          "base-content": "#372f38",
          "custom-pink": "#fcd8df"
        },
      }
    ],
  },
  variants: {},
};
