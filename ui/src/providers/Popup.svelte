<script lang="ts">
	import { VISIBILITYBUYSTORE } from '../store/stores';
	import { onMount } from 'svelte';
	import {
		STORETITLE,
		STOREPRICE
	} from '../store/stores';

	import { SendNUI } from '../utils/SendNUI';
	import { fade, fly, slide, crossfade } from 'svelte/transition';
	import { quintIn, quintOut, sineOut } from 'svelte/easing';
	import Test from './Test.svelte'

	function closePopup() {
		VISIBILITYBUYSTORE.set(false);
	  	SendNUI('hidePurchaseUI');
	}

	onMount(async () => {
		let storetitle = await SendNUI('get_store_title')
		let storeprice =  await SendNUI('get_store_price')
		STORETITLE.set(storetitle)
		STOREPRICE.set(storeprice)
    })
</script>


<div class="w-[25%] h-[55%] bg-[#111112] absolute mx-auto rounded-lg -translate-x-1/2 left-1/2 top-1/2 -translate-y-1/2 transition ease-in-out delay-150 border-[#182030]"  in:fly={{ duration: 150, delay: 200, y:50 , easing: quintOut }} out:fly={{ duration: 150, delay: 200, y:50 , easing: quintOut }}>
<button class="absolute text-[#E7FEDC] fa fa-xmark right-0 p-[2%] transition ease-in-out hover:opacity-[80%] text-[#6B7280]" on:click={() => closePopup()}></button>

<i class="absolute w-full text-center text-[350%] top-[15%] fa-solid fa-shop text-[#6B7280]"></i>
<p class="absolute font-semibold w-full text-center text-5xl top-[35%] text-[#6B7280]">Purchase {$STORETITLE}?</p>

<p class="absolute font-normal w-full text-center text-[100%] top-[41%] text-[#6B7280]">After the transaction, you will recieve full rights to this store </p>


<p class="absolute font-light w-full text-center text-3xl bottom-[20%] text-[#6B7280]">Price:</p>
<p class="absolute font-bold w-full text-center text-4xl bottom-[16%] text-[#6B7280]">${$STOREPRICE}</p>
<p class="absolute font-bold w-full text-center text-xl bottom-[13%] text-[#6B7280]">incl. tax</p>


<button type="button" class="absolute w-[75%] h-[5%] bottom-[5%] translate-x-[15%] btn rounded-md text-xl font-semibold bg-primary-500/50 text-primary-500/30"
	on:click={() => {
		SendNUI('purchaseStore')
		closePopup() 
	}}>
	<span><i class="fa fa-check"></i></span>
	<span>Purchase</span>
</button>


</div>