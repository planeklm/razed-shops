const { skeleton } = require('@skeletonlabs/tw-plugin');

module.exports = {
	darkMode: true,
	content: [
	'./src/**/*.{html,js,svelte,ts}',
    "./index.html",
		require('path').join(require.resolve(
			'@skeletonlabs/skeleton'),
			'../**/*.{html,js,svelte,ts}'
		)
	],
	theme: {
		extend: {},
	},
	plugins: [
		skeleton ({
      themes: { preset: [ "skeleton"] }
    })
	]
}
						