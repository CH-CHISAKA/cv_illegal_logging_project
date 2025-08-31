<template>
"use client";

import * as AspectRatioPrimitive from "@radix-ui/react-aspect-ratio@1.1.2";

function AspectRatio({
  ...props
}: React.ComponentProps<typeof AspectRatioPrimitive.Root>) {
  return <AspectRatioPrimitive.Root data-slot="aspect-ratio" {...props} />;
}

export { AspectRatio };
</template>

<script>
export default {
  name: 'aspect_ratio'
}
</script>

<style>
/* styles preserved from original files or external CSS */
</style>
