<script lang="ts">
	import { VISIBILITY } from '../store/stores';

	import { SendNUI } from '../utils/SendNUI';
	import { fade, fly, slide, crossfade } from 'svelte/transition';
	import { quintIn, quintOut, sineOut } from 'svelte/easing';
	import Test from './Test.svelte'
	import Test2 from './Test2.svelte'
	import Test3 from './Test3.svelte'
	import Test4 from './Test4.svelte'

	interface tabsinterface {
    fontawesomeicon: string;
    component: any;
	}	

	function closeMenu() {
		VISIBILITY.set(false);
	  	SendNUI('hideUI');
	}

	let tabs: tabsinterface[] = [
		{
			fontawesomeicon: 'fas fa-shop',
			component: Test,
		},
		{
			fontawesomeicon: 'fas fa-dollar',
			component: Test4,
		},
		{
			fontawesomeicon: 'fas fa-box',
			component: Test2,
		},
		{
			fontawesomeicon: 'fas fa-truck',
			component: Test3,
		}
	];

	function selectedtabs(tab) {
		selectedtab = tab;
	}

	let selectedtab: tabsinterface = tabs[0]
</script>

<div class="w-[80%] h-[85%] bg-[#111112] absolute rounded-xl -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 transition ease-in-out delay-150 flex flex-row overflow-hidden"  in:fly={{ duration: 200, delay: 500, y:50 , easing: quintOut }} out:fly={{ duration: 200, delay: 200, y:50 , easing: quintOut }}>
	<div class="w-[5%] flex flex-col justify-between px-[0.3vw] py-[1.3vw] bg-[#141517] border-r border-[#1A1B1E]">
		<div class="mx-[0.2vw] my-[0.35vw]">
			{#each tabs as tab}
				<!-- svelte-ignore a11y-click-events-have-key-events -->
				<div class="flex flex-row cursor-pointer leading-[1vw] align-middle p-[0.5vw] rounded-xl hover:opacity-[80%] transition ease-in-out {selectedtab.fontawesomeicon === tab.fontawesomeicon ? 'bg-[#111112] transition ease-in-out' : ''}" on:click={() => selectedtabs(tab)}>
					<i class="mx-auto {tab.fontawesomeicon}" />
				</div>
			{/each}
		</div>

		<div class="w-4/5 p-[1.3vw];">
			<div class="mx-[0.2vw] my-[0.35vw]">
				<!-- svelte-ignore a11y-click-events-have-key-events -->
				<div class="flex flex-row cursor-pointer p-[1vw] hover:opacity-[80%] transition ease-in-out" on:click={() => closeMenu()}>
					<i class='fa-regular fa-circle-xmark'/>
				</div>
			</div>
		</div>
	</div>

	<div class="w-[100%] h-full p-[1.3vw]">
		<svelte:component this={selectedtab.component} />
	</div>
</div>