<template>
<CommandPrimitive
      data-slot="command"
      class={cn(
        "bg-popover text-popover-foreground flex h-full w-full flex-col overflow-hidden rounded-md",
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
