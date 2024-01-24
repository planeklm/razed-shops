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

	function setJob(tab) {
		if (tab == true) {
			ISJOBACTIVE.set(false)
		} else if (tab == false) {
			console.log('canceled')
		}
	}
	
	function checkJobActive() {
		if ($ISJOBACTIVE == true) {
			modalStore.trigger(canceljob)
		} else if ($ISJOBACTIVE == false) {
			console.log('job not started')
		}
	}

	const modalStore = getModalStore();
	
	const goloco: ModalSettings = {
	type: 'alert',
	// Data
	title: 'What is Go Loco Railroad?',
	body: 'The companys name is a play on the saying "Go Crazy", since Loco means crazy in Spanish, and is also a short form of the word "locomotive". They appear to be the only railroad operating in San Andreas during the events of Grand Theft Auto V. Since the companys name is of Spanish origin, this further suggests the possibility that it is a parody of Rio Grande Railroad (Denver And Rio Grande Western or D&RGW as known by most train enthusiasts). However, Rio Grande only operated track in Colorado, Utah, and New Mexico, and has been defunct since the late 1980s (specifically regarding the merger between the Southern Pacific railroad in 1988-1989, which in turn merged with the Union Pacific in 1996). Go Loco appears to operate a fleet exclusively of unique types of diesel locomotives reminiscent of various different EMD diesel locomotives (especially the GP38), and haul a wide variety of freight (mostly consisting of various intermodal traffic).',
	};

	const lst: ModalSettings = {
	type: 'alert',
	// Data
	title: 'What is Los Santos Transit?',
	body: 'Los Santos Transit operates bus services and a light rail system. It is based on the Los Angeles County Metropolitan Transportation Authority. The Arrow is the name of the light rail system while the Bullet is the name of the bus system.',
	};

	const sap: ModalSettings = {
	type: 'alert',
	// Data
	title: 'What is San Andreas Parking Counsel?',
	body: 'This organisation is responsible for maintaining the parking garages and spaces throughout San Andreas. Its signs can be seen in various parking garages throughout Los Santos, as well as the parking lot of the Dashound Bus Center.',
	};

	const canceljob: ModalSettings = {
	type: 'confirm',
	// Data
	title: 'Cancel Job',
	body: 'Are you sure you want to cancel your job?',
	// TRUE if confirm pressed, FALSE if cancel pressed
	response: (r: boolean) => setJob(r),
	};
</script>

<div class="w-[100%] h-[5%] mx-auto bg-[#141517] text-[#A6B0C3] font-semibold drop-shadow-lg rounded-lg flex flex-col justify-center border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<i class="ml-[1%] text-4xl fa-solid fa-box text-[#6B7280]"></i>
	<p class="font-semibold absolute w-full ml-[3.5%] mt-[0.25%] text-4xl text-[#6B7280]">Restock</p>
	<button class="btn absolute w-text h-[70%] right-[0.5%] text-white rounded-md text-2xl { $ISJOBACTIVE ? 'bg-[#2B4A28] transition ease-in-out' : 'bg-[#4A282D] transition ease-in-out' } transition ease-in-out"
	on:click={() => checkJobActive()}>
		<p>
			{ $ISJOBACTIVE ? 'Active' : 'Not-Active' }
		</p>
	</button>
</div>

<div class="flex gap-4 w-[100%] h-[85%] mt-[0.5%] bg-[#111112]" >
<div class="relative space-y-4 w-[100%] h-[108%] mt-[1%] bg-[#111112] overflow-x-auto overflow-y-auto" >
<div class="flex w-[100%] h-[32%] mx-auto bg-[#141517] font-semibold drop-shadow-lg rounded-lg flex flex-col border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<div class="flex flex-col w-[100%] h-[22%] mx-auto bg-[#141517] font-semibold rounded-lg justify-center border-b border-[#191A1F]">
		<i class="ml-[1%] text-3xl fa fa-train text-[#6B7280]"></i>
		<p class="font-semibold absolute w-full  ml-[3.5%] mt-[0.25%] text-4xl text-[#6B7280]">Go Loco Railroad</p>
		<button class="btn absolute w-[5%] h-[13%] ml-[21%] bg-primary-500/50 text-white rounded-md text-2xl"
		on:click={() => modalStore.trigger(goloco)}>
			<i class="fa-solid fa-circle-info text-2xl mt-[0%]"></i>
		</button>
	</div>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			Stock:
		<t class="text-white">
			+3
		</t>
	</p>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			Money:
		<t class="text-white">
			$542
		</t>
	</p>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			XP:
		<t class="text-white">
			+2
		</t>
	</p>
	<button class="fixed btn bottom-[0%] m-[0.5%] w-[84%] bg-primary-500/50 text-white rounded-md text-2xl font-semibold" disabled={$ISJOBACTIVE}
	on:click={() => ISJOBACTIVE.set(true)}>

		<i class="fa-solid fa-check text-2xl mt-[0%]"></i>
		<p>
			Confirm
		</p>
	</button>

	<div class="absolute right-[0%] rounded-r-xl w-[15%] h-[100%] bg-[#1A1B1E] border-[#191A1F]">
		<p class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-5xl text-[#6B7280]">#4</p>
	</div>

	<Ratings class="absolute bottom-[25%] w-[79.9%] -translate-x-1/2 text-[150%] ml-[8%]" value={1} max={5}>
		<svelte:fragment slot="empty"><i class="fa-regular fa-star text-primary-500/30"></i></svelte:fragment>
		<svelte:fragment slot="half"><i class="fa-solid fa-star-half-stroke text-primary-500"></i></svelte:fragment>
		<svelte:fragment slot="full"><i class="fa-solid fa-star text-primary-500"></i></svelte:fragment>
	</Ratings>
</div>

<div class="flex w-[100%] h-[32%] mt-[1%] mx-auto bg-[#141517] font-semibold drop-shadow-lg rounded-lg flex flex-col border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<div class="flex flex-col w-[100%] h-[22%] mx-auto bg-[#141517] font-semibold rounded-lg justify-center border-b border-[#191A1F]">
		<i class="ml-[1%] text-3xl fa fa-truck text-[#6B7280]"></i>
		<p class="font-semibold absolute w-full ml-[3.5%] mt-[0.25%] text-4xl text-[#6B7280]">Los Santos Transit</p>
		<button class="btn absolute w-[5%] h-[13%] ml-[21.5%] bg-primary-500/50 text-white rounded-md text-2xl"
		on:click={() => modalStore.trigger(lst)}>
			<i class="fa-solid fa-circle-info text-2xl mt-[0%]"></i>
		</button>
	</div>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			Stock:
		<t class="text-white">
			+3
		</t>
	</p>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			Money:
		<t class="text-white">
			$542
		</t>
	</p>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			XP:
		<t class="text-white">
			+2
		</t>
	</p>
	<button class="fixed btn bottom-[0%] m-[0.5%] w-[84%] bg-primary-500/50 text-white rounded-md text-2xl font-semibold" disabled={$ISJOBACTIVE}
	on:click={() => ISJOBACTIVE.set(true)}>
		<i class="fa-solid fa-check text-2xl mt-[0%]"></i>
		<p>
			Confirm
		</p>
	</button>

	<div class="absolute right-[0%] rounded-r-xl w-[15%] h-[100%] bg-[#1A1B1E]">
		<p class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-5xl text-[#6B7280]">#3</p>
	</div>

	<Ratings class="absolute bottom-[25%] w-[79.9%] -translate-x-1/2 text-[150%] ml-[8%]" value={2} max={5}>
		<svelte:fragment slot="empty"><i class="fa-regular fa-star text-primary-500/30"></i></svelte:fragment>
		<svelte:fragment slot="half"><i class="fa-solid fa-star-half-stroke text-primary-500"></i></svelte:fragment>
		<svelte:fragment slot="full"><i class="fa-solid fa-star text-primary-500"></i></svelte:fragment>
	</Ratings>
</div>

<div class="flex w-[100%] h-[32%] mt-[1%] mx-auto bg-[#141517] font-semibold drop-shadow-lg rounded-lg flex flex-col border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<div class="flex flex-col w-[100%] h-[22%] mx-auto bg-[#141517] font-semibold rounded-lg justify-center border-b border-[#191A1F]">
		<i class="ml-[1%] text-3xl fa fa-van-shuttle text-[#6B7280]"></i>
		<p class="font-semibold absolute w-full ml-[3.5%] mt-[0.25%] text-4xl text-[#6B7280]">San Andreas Parking Counsel</p>
		<button class="btn absolute w-[5%] h-[13%] ml-[33%] bg-primary-500/50 text-white rounded-md text-2xl"
		on:click={() => modalStore.trigger(sap)}>
			<i class="fa-solid fa-circle-info text-2xl mt-[0%]"></i>
		</button>
	</div>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			Stock:
		<t class="text-white">
			+3
		</t>
	</p>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			Money:
		<t class="text-white">
			$542
		</t>
	</p>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			XP:
		<t class="text-white">
			+2
		</t>
	</p>
	<button class="fixed btn bottom-[0%] m-[0.5%] w-[84%] bg-primary-500/50 text-white rounded-md text-2xl font-semibold" disabled={$ISJOBACTIVE}
	on:click={() => ISJOBACTIVE.set(true)}>
		<i class="fa-solid fa-check text-2xl mt-[0%]"></i>
		<p>
			Confirm
		</p>
	</button>

	<div class="absolute right-[0%] rounded-r-xl w-[15%] h-[100%] bg-[#1A1B1E]">
		<p class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-5xl text-[#6B7280]">#2</p>
	</div>

	<Ratings class="absolute bottom-[25%] w-[79.9%] -translate-x-1/2 text-[150%] ml-[8%]" value={3} max={5}>
		<svelte:fragment slot="empty"><i class="fa-regular fa-star text-primary-500/30"></i></svelte:fragment>
		<svelte:fragment slot="half"><i class="fa-solid fa-star-half-stroke text-primary-500"></i></svelte:fragment>
		<svelte:fragment slot="full"><i class="fa-solid fa-star text-primary-500"></i></svelte:fragment>
	</Ratings>
</div>

<div class="flex w-[100%] h-[32%] mt-[1%] mx-auto bg-[#141517] font-semibold drop-shadow-lg rounded-lg flex flex-col border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
	<div class="flex flex-col w-[100%] h-[22%] mx-auto bg-[#141517] font-semibold rounded-lg justify-center border-b border-[#191A1F]">
		<i class="ml-[1%] text-3xl fa fa-van-shuttle text-[#6B7280]"></i>
		<p class="font-semibold absolute w-full ml-[3.5%] mt-[0.25%] text-4xl text-[#6B7280]">San Andreas Parking Counsel</p>
		<button class="btn absolute w-[5%] h-[13%] ml-[33%] bg-primary-500/50 text-white rounded-md text-2xl"
		on:click={() => modalStore.trigger(sap)}>
			<i class="fa-solid fa-circle-info text-2xl mt-[0%]"></i>
		</button>
	</div>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			Stock:
		<t class="text-white">
			+3
		</t>
	</p>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			Money:
		<t class="text-white">
			$542
		</t>
	</p>
	<p class="ml-[1%] mt-[1%] bottom-[5%] text-3xl font-normal text-[#6B7280]">
			XP:
		<t class="text-white">
			+2
		</t>
	</p>
	<button class="fixed btn bottom-[0%] m-[0.5%] w-[84%] bg-primary-500/50 text-white rounded-md text-2xl font-semibold" disabled={$ISJOBACTIVE}
	on:click={() => ISJOBACTIVE.set(true)}>
		<i class="fa-solid fa-check text-2xl mt-[0%]"></i>
		<p>
			Confirm
		</p>
	</button>

	<div class="absolute right-[0%] rounded-r-xl w-[15%] h-[100%] bg-[#1A1B1E]">
		<p class="absolute -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 text-5xl text-[#6B7280]">#1</p>
	</div>

	<Ratings class="absolute bottom-[25%] w-[79.9%] -translate-x-1/2 text-[150%] ml-[8%]" value={5} max={5}>
		<svelte:fragment slot="empty"><i class="fa-regular fa-star text-primary-500/30"></i></svelte:fragment>
		<svelte:fragment slot="half"><i class="fa-solid fa-star-half-stroke text-primary-500"></i></svelte:fragment>
		<svelte:fragment slot="full"><i class="fa-solid fa-star text-primary-500"></i></svelte:fragment>
	</Ratings>
</div>
</div>

<div class="relative space-y-4 w-[30%] h-[108%] mt-[0.5%] bg-[#111112] overflow-x-auto overflow-y-auto" >
	<div class="flex w-[100%] h-[99%] mt-[2.5%] mx-auto bg-[#141517] font-semibold drop-shadow-lg rounded-lg flex flex-col border border-[#191A1F]" in:fly={{ duration: 200, y:50 , easing: quintOut }}>
		<div class="flex flex-col w-[100%] h-[6.5%] mx-auto bg-[#141517] font-semibold rounded-lg justify-center border-b border-[#191A1F]">
			<i class="ml-[5%] text-3xl fa fa-key text-[#6B7280]"></i>
			<p class="font-semibold absolute w-full ml-[14%] mt-[0.25%] text-4xl text-[#6B7280]">Vehicle Information</p>
		</div>

		<p class="ml-[5%] mt-[5%] bottom-[5%] text-3xl text-[#6B7280] font-semibold">
			<i class="fa-solid fa-box text-4xl text-[#6B7280]"></i>
				- Amount of stock you will recieve upon completion.
		</p>
		<p class="ml-[5%] mt-[5%] bottom-[5%] text-3xl text-[#6B7280] font-semibold">
			<i class="fa-solid fa-dollar text-4xl text-[#6B7280]"></i>
				- Amount of money you will need to complete the delivery.
		</p>

		<p class="ml-[5%] mt-[5%] bottom-[5%] text-3xl text-[#6B7280] font-semibold">
			<i class="fa-solid fa-turn-up text-4xl text-[#6B7280]"></i>
				- Amount of xp you will recieve upon completion.
		</p>
	</div>
</div>
</div>

<Modal regionBackdrop="bg-[#111112] opacity-[99%]" background="bg-[#141517] rounded-lg" spacing="space-y-[2%]" padding="p-[2%]" regionHeader="text-[150%] font-bold" regionBody="text-3xl" rounded="rounded-md" buttonPositive="btn rounded-md text-xl w-[20%] font-semibold bg-[#2B4A28] text-[#E7FEDC]" buttonNeutral="btn rounded-md text-xl font-semibold bg-[#4A282D] text-[#FEDCDD]" />