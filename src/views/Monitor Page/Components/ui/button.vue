<template>
<Comp
      data-slot="button"
      class={cn(buttonVariants({ variant, size, className }))}
      {...props}
    />
</template>

<script setup>
// Best-effort auto-conversion from React to Vue
</script>

<style>
/* styles preserved or referenced externally */
</style>
