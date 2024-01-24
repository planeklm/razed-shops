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

    let withdrawValue;

    let a = 254532;

    let b = a - withdrawValue;

</script>

<div class="w-[100%] h-[5%] mx-auto bg-[#141517] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg flex flex-col justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<i class="ml-[1%] text-4xl fa-solid fa-box text-[#6B7280]"></i>
	<p class="font-semibold absolute w-full ml-[3.5%] mt-[0.25%] text-4xl text-[#6B7280]">Bank</p>
</div>

<div class="flex gap-4 w-[100%] h-[85%] mt-[0.5%] bg-[#111112]" >
<div class="relative space-y-4 w-[100%] h-[108%] mt-[1%] bg-[#111112] overflow-x-auto overflow-y-auto" >
<div class="flex w-[100%] h-[20%] mx-auto bg-[#141517] font-semibold drop-shadow-lg rounded-lg flex flex-col border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<p class="absolute font-semibold ml-[1%] mt-[1%] text-3xl text-[#6B7280]">Withdraw:</p>
	<p class="absolute font-semibold ml-[1%] mt-[2.75%] text-6xl ">%{b}</p>

    <div class="absolute right-[0%] rounded-r-xl w-[10%] h-[100%] bg-[#1A1B1E] border-[#191A1F]">
		<p class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-7xl text-[#6B7280] fa-solid fa-dollar"></p>
	</div>

    <input type="number" placeholder="1" min="0" max="10" value={withdrawValue} class="absolute w-[20%] h-[25%] bottom-[12%] ml-[1%] text-[#6B7280] text-center rounded-lg bg-[#111112] border border-[#191A1F] transition ease-in-out delay-150"/>

    <button class="absolute btn w-[20%] h-[25%] bottom-[12%] ml-[22%] bg-primary-500/70 text-white rounded-md text-2xl font-semibold" disabled={$ISJOBACTIVE}
    >
        <p>
            <i class="ml-[1%] text-2xl fa-solid fa-dollar"></i>
            Withdraw
        </p>
    </button>
</div>
<div class="flex w-[100%] h-[20%] mx-auto bg-[#141517] font-semibold drop-shadow-lg rounded-lg flex flex-col border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<p class="absolute font-semibold ml-[1%] mt-[1%] text-3xl text-[#6B7280]">Deposit:</p>
	<p class="absolute font-semibold ml-[1%] mt-[2.75%] text-6xl ">$254532</p>

    <div class="absolute right-[0%] rounded-r-xl w-[10%] h-[100%] bg-[#1A1B1E] border-[#191A1F]">
		<p class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-7xl text-[#6B7280] fa-solid fa-dollar"></p>
	</div>

    <input type="number" min="0" max="10" class="absolute w-[20%] h-[25%] bottom-[12%] ml-[1%] text-[#6B7280] text-center rounded-lg bg-[#111112] border border-[#191A1F] transition ease-in-out delay-150"/>

    <button class="absolute btn w-[20%] h-[25%] bottom-[12%] ml-[22%] bg-primary-500/70 text-white rounded-md text-2xl font-semibold" disabled={$ISJOBACTIVE}
    >
        <p>
            <i class="ml-[1%] text-2xl fa-solid fa-dollar"></i>
            Deposit
        </p>
    </button>
</div>
</div>
</div>

<Modal regionBackdrop="bg-[#111112] opacity-[99%]" background="bg-[#141517] rounded-lg" spacing="space-y-[2%]" padding="p-[2%]" regionHeader="text-[150%] font-bold" regionBody="text-3xl" rounded="rounded-md" buttonPositive="btn rounded-md text-xl w-[20%] font-semibold bg-[#2B4A28] text-[#E7FEDC]" buttonNeutral="btn rounded-md text-xl font-semibold bg-[#4A282D] text-[#FEDCDD]" />