<template>
    <div id="dashboard">
        <h2 class="m-t-0 m-b-20">Today's Operations</h2>
        <operation-list></operation-list>
    </div>
</template>

<script>
    import OperationList from 'dash/OperationList.vue';

    export default {
        name: 'dashboard',
        components: {
            OperationList: OperationList,
        },
    }
</script>

<style scoped>

</style>