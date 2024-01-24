<script lang="ts">
	import { ReceiveNUI } from '../utils/ReceiveNUI'
	import { SendNUI } from '../utils/SendNUI'
	import { onMount } from 'svelte'
	import { BROWSER_MODE, VISIBILITYBUYSTORE } from '../store/stores'

	let isBuyStoreVisible: boolean
	let isBrowser: boolean

	BROWSER_MODE.subscribe((browser: boolean) => {
		isBrowser = browser
	})

	VISIBILITYBUYSTORE.subscribe((buystorevisible: boolean) => {
		isBuyStoreVisible = buystorevisible
	})

	ReceiveNUI<boolean>('setVisible2', (buystorevisible: boolean) => {
		VISIBILITYBUYSTORE.set(buystorevisible)
	})
   

	onMount(() => {
		const keyHandler = (e: KeyboardEvent) => {
			if (isBuyStoreVisible && ['Escape'].includes(e.code)) {
				SendNUI('hidePurchaseUI')
				VISIBILITYBUYSTORE.set(false)
			}
			if (
				!isBuyStoreVisible &&
				['Escape'].includes(e.code) &&
				isBrowser === true
			) {
				VISIBILITYBUYSTORE.set(true)
			}
		}

		window.addEventListener('keydown', keyHandler)

		return () => window.removeEventListener('keydown', keyHandler)
	})
</script>

{#if isBuyStoreVisible}
	<main>
		<slot />
	</main>
{/if}