<template>
<Comp
      data-slot="badge"
      class={cn(badgeVariants({ variant }), className)}
      {...props}
    />
</template>

<script setup>
// Best-effort auto-conversion from React to Vue
</script>

<style>
/* styles preserved or referenced externally */
</style>
