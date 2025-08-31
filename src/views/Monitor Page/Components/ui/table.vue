<template>
<div
      data-slot="table-container"
      class="relative w-full overflow-x-auto"
    >
      <table
        data-slot="table"
        class={cn("w-full caption-bottom text-sm", className)}
        {...props}
      />
    </div>
</template>

<script setup>
// Best-effort auto-conversion from React to Vue
</script>

<style>
/* styles preserved or referenced externally */
</style>
