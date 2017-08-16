<template>
    <div id="dashWrap">
        <div class="container">
            <div class="row">
                <img src="/logo_v2.jpg" class="img-circle" style="float:right;margin:20px;">
                <div class="col-md-3 col-md-offset-1 col-sm-5">
                    <sidebar></sidebar>
                </div>

                <div class="col-md-7 col-sm-7 mainView">
                    <transition name="fade">
                        <router-view></router-view>
                    </transition>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Sidebar from 'dash/Sidebar.vue';

    export default {
        name: 'dashboard',
        components: {
            sidebar: Sidebar
        }
    }
</script>
