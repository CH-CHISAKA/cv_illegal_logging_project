<template>
<FormFieldContext.Provider value={{ name: props.name }}>
      <Controller {...props} />
    </FormFieldContext.Provider>
</template>

<script setup>
// Best-effort auto-conversion from React to Vue
</script>

<style>
/* styles preserved or referenced externally */
</style>
