<template>
<ScrollAreaPrimitive.Root
      data-slot="scroll-area"
      class={cn("relative", className)}
      {...props}
    >
      <ScrollAreaPrimitive.Viewport
        data-slot="scroll-area-viewport"
        class="focus-visible:ring-ring/50 size-full rounded-[inherit] transition-[color,box-shadow] outline-none focus-visible:ring-[3px] focus-visible:outline-1"
      >
        {children}
      </ScrollAreaPrimitive.Viewport>
      <ScrollBar />
      <ScrollAreaPrimitive.Corner />
    </ScrollAreaPrimitive.Root>
</template>

<script setup>
// Best-effort auto-conversion from React to Vue
</script>

<style>
/* styles preserved or referenced externally */
</style>
