import { writable } from "svelte/store";

export const VISIBILITY = writable<boolean>(false);
export const VISIBILITYBUYSTORE = writable<boolean>(false);
export const BROWSER_MODE = writable<boolean>(false);
export const RESOURCE_NAME = writable<string>("");
export const PLAYER_NAME = writable<string>(""); 
export const PLAYER_CASH = writable<string>("");
export const PLAYER_BANK = writable<string>("");
export const PLAYER_CRYPTO = writable<string>("");
export const PLAYER_JOB = writable<string>("");
export const PLAYER_JOB_RANK = writable<string>("");
export const PLAYER_JOB_DUTY = writable<string>("");
export const STORETITLE = writable<string>("");
export const STOREPRICE = writable<number>();
export const STOREBALANCE = writable<number>();
export const STORESTOCK = writable<number>();
export const STORECAPACITY = writable<number>();
export const STORETOTALDELIVERIES = writable<number>();
export const STORERATING = writable<number>();
export const ISJOBACTIVE = writable<boolean>(false);