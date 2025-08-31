<template>
<div
      data-slot="card"
      class={cn(
        "bg-card text-card-foreground flex flex-col gap-6 rounded-xl border",
        className,
      )}
      {...props}
    />
</template>

<script setup>
// Best-effort auto-conversion from React to Vue
</script>

<style>
/* styles preserved or referenced externally */
</style>
