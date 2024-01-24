<script lang="ts">
	import {
		STORETITLE,
		STOREBALANCE,
		STORECAPACITY,
		STORESTOCK,
		STORETOTALDELIVERIES,
		STORERATING
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

		STORECAPACITY.set(storecapacity)
		STORESTOCK.set(storestock)
		STORETITLE.set(storetitle)
		STOREBALANCE.set(storebalance)
		STORETOTALDELIVERIES.set(storetotaldeliveries)
		STORERATING.set(storerating)
    })
	
	const modalStore = getModalStore();
	
	const modal: ModalSettings = {
	type: 'confirm',
	// Data
	title: 'Sell Store',
	body: 'Do you want to sell the store? If confirmed the store will immediately be removed from your ownership and placed on the market.',
	// TRUE if confirm pressed, FALSE if cancel pressed
	response: (r: boolean) => console.log('response:', r),
	};
</script>

<div class="w-[100%] h-[10%] mx-auto bg-[#141517] light:bg-[#DAFFDA] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg flex flex-col justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
    <p class="font-semibold absolute w-full text-center text-4xl text-[#6B7280]">{$STORETITLE}</p>
    <img class="object-cover h-[100%] w-[100%] rounded-lg" src="images/placeholder.png" alt="placeholer"/>
</div>

<div class="mt-[1%] w-[100%] h-[5%] mx-auto bg-[#141517] light:bg-[#DAFFDA] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg flex flex-col justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<i class="ml-[1%] text-4xl fa-solid fa-arrow-trend-up text-[#6B7280]"></i>
	<p class="font-semibold absolute w-full ml-[3.5%] mt-[0.25%] text-4xl text-[#6B7280]">Statistics</p>
</div>

<div class="flex gap-4 w-[100%] h-[85%] mt-[0%] bg-[#111112] overflow-x-auto overflow-y-auto" >
<div class="relative space-y-4 w-[100%] h-[85%] mt-[1%] bg-[#111112] overflow-x-auto overflow-y-auto" >
<div class="w-[100%] h-[22%] bg-[#141517] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<p class="absolute ml-[3%] top-[12%] text-5xl text-[#6B7280]">${$STOREBALANCE}</p>
	<p class="absolute ml-[3%] top-[35%] text-2xl font-normal text-[#6B7280]">Current Balance Of Your Store</p>
	<p class="absolute ml-[2%] bottom-[5%] text-xl font-normal text-[#6B7280]">
	<i class="fa-solid fa-circle-info text-[#6B7280]"></i>
		Tip: Keep your store out of debt, someone may come if you don't.
	</p>
	<div class="absolute right-[0%] rounded-r-xl w-[15%] h-[100%] bg-[#1A1B1E]">
	<i class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-7xl fa-solid fa-sack-dollar text-[#6B7280]" ></i>
	</div>
</div>
<div class="w-[100%] h-[22%] bg-[#141517] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<p class="absolute ml-[3%] top-[12%] text-5xl text-[#6B7280]">Store Rating:</p>
	<p class="absolute ml-[3%] top-[35%] text-2xl font-normal text-[#6B7280]">The Final Rating Of Your Store</p>
	<p class="absolute ml-[2%] bottom-[5%] text-xl font-normal text-[#6B7280]">
	<i class="fa-solid fa-circle-info text-[#6B7280]"></i>
		Tip: At this point it's just a flex.
	</p>
	<div class="absolute right-[0%] rounded-r-xl w-[15%] h-[100%] bg-[#1A1B1E]">
		<i class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-7xl fa-solid fa-star-half-stroke text-[#6B7280]" ></i>
	</div>
	<div class="absolute rounded-r-xl w-[100%] h-[20%] bottom-[20%]">
		<Ratings class="absolute bottom-[40%] w-[79.9%] -translate-x-1/2 text-[150%] left-[14%]" value={$STORERATING} max={5}>
			<svelte:fragment slot="empty"><i class="fa-regular fa-star text-primary-500/30"></i></svelte:fragment>
			<svelte:fragment slot="half"><i class="fa-solid fa-star-half-stroke text-primary-500"></i></svelte:fragment>
			<svelte:fragment slot="full"><i class="fa-solid fa-star text-primary-500"></i></svelte:fragment>
		</Ratings>
	</div>
</div>
</div>

<div class="relative space-y-4 w-[100%] h-[85%] mt-[1%] bg-[#111112] overflow-x-auto overflow-y-auto" >
<div class="w-[100%] h-[22%] bg-[#141517] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<p class="absolute ml-[3%] top-[12%] text-5xl text-[#6B7280]">Store Stock:</p>
	<p class="absolute ml-[3%] top-[35%] text-2xl font-normal text-[#6B7280]">Stock Capacity (Max: {$STORECAPACITY})</p>
	<p class="absolute ml-[2%] bottom-[5%] text-xl font-normal text-[#6B7280]">
		<i class="fa-solid fa-circle-info text-[#6B7280]"></i>
		Tip: Remember to keep your stock as high as possible at all times.
	</p>
	<div class="absolute right-[0%] rounded-r-xl w-[20%] h-[100%] bg-[#1A1B1E]">
		<ProgressRadial class="-translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2" font={90} width="w-[75%] text-[#6B7280]" stroke={100} meter="stroke-primary-500" track="stroke-primary-500/30" value={$STORESTOCK}></ProgressRadial>
		<p class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/3 text-5xl text-[#6B7280]" >{$STORESTOCK}</p>
	</div>
</div>
<div class="w-[100%] h-[22%] bg-[#141517] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<p class="absolute ml-[3%] top-[12%] text-5xl text-[#6B7280]">Deliveries:</p>
	<p class="absolute ml-[3%] top-[35%] text-2xl font-normal text-[#6B7280]">Amount Of Deliveries Completed</p>
	<p class="absolute ml-[2%] bottom-[5%] text-xl font-normal text-[#6B7280]">
	<i class="fa-solid fa-circle-info text-[#6B7280]"></i>
		Tip: Well done if it's high, if it's low then keep the grind up.
	</p>

	<div class="absolute right-[0%] rounded-r-xl w-[15%] h-[100%] bg-[#1A1B1E]">
		<p class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-5xl text-[#6B7280]">{$STORETOTALDELIVERIES}</p>
	</div>

	<div class="absolute rounded-r-xl w-[100%] h-[20%] bottom-[20%]">
		<ProgressBar meter="bg-primary-500" track="bg-primary-500/30" class="absolute bottom-[40%] w-[79.9%] -translate-x-1/2 left-[42%]" label="Progress Bar" value={$STORETOTALDELIVERIES} max={100} />
	</div>
</div>
</div>
</div>

<Modal regionBackdrop="bg-[#111112] opacity-[99%]" background="bg-[#141517] rounded-lg" spacing="space-y-[2%]" padding="p-[2%]" regionHeader="text-[150%] font-bold" rounded="rounded-md" buttonPositive="btn rounded-md text-xl w-[20%] font-semibold bg-[#2B4A28] text-[#E7FEDC]" buttonNeutral="btn rounded-md text-xl font-semibold bg-[#4A282D] text-[#FEDCDD]" />