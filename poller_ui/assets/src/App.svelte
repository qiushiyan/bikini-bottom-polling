<script lang="ts">
  import { onMount } from "svelte";

  import Button from "./components/UI/Button.svelte";
  let districts: any = [];

  onMount(async () => {
    const res = await fetch("/api/districts");
    districts = await res.json();
  });
</script>

<main>
  {#each districts as d}
    {JSON.stringify(d, null, 2)}
  {/each}
</main>
