<template>
<ResizablePrimitive.PanelGroup
      data-slot="resizable-panel-group"
      class={cn(
        "flex h-full w-full data-[panel-group-direction=vertical]:flex-col",
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
