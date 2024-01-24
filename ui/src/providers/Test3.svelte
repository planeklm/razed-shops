<script lang="ts">
	import {
		STORETITLE,
		STOREBALANCE,
		STORECAPACITY,
		STORESTOCK,
		STORETOTALDELIVERIES,
		STORERATING,
		ISJOBACTIVE,
		BROWSER_MODE
	} from '../store/stores';
	import { SendNUI } from '../utils/SendNUI';
	import { fade, fly, slide, crossfade } from 'svelte/transition';
	import { quintIn, quintOut, sineOut } from 'svelte/easing';
	import { onMount } from 'svelte';
	import { ProgressRadial, ProgressBar, LightSwitch, Modal, getModalStore, initializeStores, Ratings } from '@skeletonlabs/skeleton';
	import type { ModalSettings, ModalComponent, ModalStore } from '@skeletonlabs/skeleton';
	let name = 'Image';

	initializeStores();
	
	onMount(async () => {
		let storetitle = await SendNUI('get_store_title')
		let storebalance = await SendNUI('get_store_balance')
		let storestock = await SendNUI('get_store_stock')
		let storecapacity = await SendNUI('get_store_capacity')
		let storetotaldeliveries = await SendNUI('get_store_totaldeliveries')
		let storerating = await SendNUI('get_store_rating')
		let isjobactive = await SendNUI('is_job_active')

		STORECAPACITY.set(storecapacity)
		STORESTOCK.set(storestock)
		STORETITLE.set(storetitle)
		STOREBALANCE.set(storebalance)
		STORETOTALDELIVERIES.set(storetotaldeliveries)
		STORERATING.set(storerating)
		ISJOBACTIVE.set(isjobactive)

		ISJOBACTIVE.set(false)
    })

	function upgradeTruckLua(tab) {
		if (tab == true) {
			SendNUI('')
		} else if (tab == false) {
			console.log('canceled')
		}
	}

	const modalStore = getModalStore();
	
	const upgradeTruck: ModalSettings = {
	type: 'confirm',
	// Data
	title: 'Upgrade Truck?',
	body: 'Are you sure you wish to proceed?',
	// TRUE if confirm pressed, FALSE if cancel pressed
	response: (r: boolean) => upgradeTruckLua(r),
	};
</script>

<div class="w-[100%] h-[5%] mx-auto bg-[#141517] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg flex flex-col justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<i class="ml-[1%] text-4xl fa-solid fa-box text-[#6B7280]"></i>
	<p class="font-semibold absolute w-full ml-[3.5%] mt-[0.25%] text-4xl text-[#6B7280]">Restock</p>
</div>

<div class="flex gap-4 w-[100%] h-[85%] mt-[0.5%] bg-[#111112]" >
<div class="relative space-y-4 w-[100%] h-[108%] mt-[1%] bg-[#111112] overflow-x-auto overflow-y-auto" >
<div class="flex w-[100%] h-[32%] mx-auto bg-[#141517] font-semibold drop-shadow-lg rounded-lg flex flex-col border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<div class="w-[30%] h-[100%] bg-[#141517] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg border-r border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
		<img class="object-cover h-[100%] w-[100%] rounded-lg" src="images/247truck.png" alt="placeholer"/>
		<button class="absolute btn -translate-x-1/2 left-1/2 bottom-[0%] -translate-y-1/2 w-[80%] h-[15%] bg-primary-500/70 text-white rounded-md text-2xl font-semibold" disabled={$ISJOBACTIVE}
		on:click={() => modalStore.trigger(upgradeTruck)}>
			<p>
				<i class="ml-[1%] text-2xl fa-solid fa-check"></i>
				Upgrade Truck
			</p>
		</button>
	</div>
	<p class="absolute font-semibold ml-[31%] mt-[1%] text-3xl text-[#6B7280]">Vehicle:</p>
	<p class="absolute font-semibold ml-[31%] mt-[2.5%] text-5xl">Izoma Mk2</p>
	<p class="absolute font-semibold ml-[31%] mt-[4.5%] text-4xl text-[#6B7280]">Truck Capacity:
		<t>
			10
		</t>
	</p>
	<p class="absolute font-semibold ml-[31%] mt-[6.5%] text-4xl text-[#6B7280]">Tier:
		<t>
			2
		</t>
	</p>
</div>
</div>
</div>

<Modal regionBackdrop="bg-[#111112] opacity-[99%]" background="bg-[#141517] rounded-lg" spacing="space-y-[2%]" padding="p-[2%]" regionHeader="text-[150%] font-bold" regionBody="text-3xl" rounded="rounded-md" buttonPositive="btn rounded-md text-xl w-[20%] font-semibold bg-[#2B4A28] text-[#E7FEDC]" buttonNeutral="btn rounded-md text-xl font-semibold bg-[#4A282D] text-[#FEDCDD]" />