<template>
    <div id="dashboard">
        <h1 align="center"><i class="material-icons" style="font-size:2.9rem">dashboard</i>  Dashboard</h1>
        <hr />
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
        mounted: function () {
            //reinitailize sidebar feature when coming from a different route
            $(".button-collapse").sideNav();
            $('.button-collapse').sideNav('hide');
        },
    }
</script>
