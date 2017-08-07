<template>
    <div id="sidebar" class="text-center">
        <ul id="slide-out" class="side-nav">
            <li><div><img src="/logo_v2.jpg" class="img-circle" ></div> </li>
            <li><a href="#"><i class="material-icons">person</i>Driver: {{user.first_name + ' ' + user.last_name}}</a></li>
            <li><a href="#" @click.prevent="logout"><i class="material-icons">power_settings_new</i> Logout</a></li>
            <li><div class="divider"></div></li>
            <li><router-link :to="'/dashboard'" class="waves-effect">
                    <i class="material-icons">dashboard</i> Dashboard
                </router-link></li>
            <li><a class="subheader">My Routes</a></li>
            <ul>
              <li v-for="client_route in user.routes">
              <router-link :to="'/route/'+client_route.id" class="waves-effect">
                        <i class="material-icons">directions_railway</i> {{client_route.name}}
                    </router-link>
              </li>
            </ul>
    
        </ul>
        <a href="#" data-activates="slide-out" class="button-collapse"><i class="material-icons large" style="margin-top:20px;">menu</i></a>
    </div>
</template>

<script>
    export default {
        name: 'sidebar',
        created: function () {
            if (this.loggedIn)
                this.getUser();
        },
        data: function () {
            return {
                user: {},
                newBeep : "",
                loggedIn: this.$auth.loggedIn()
            }
        },
        methods: {
            logout: function () {
                this.$auth.destroyToken();
                this.user = {};
                this.$router.push('/auth/login');
            },
            getUser: function () {
                this.$http.get('/api/v1/drivers/me')
                        .then(function (res) {
                            this.user = res.body;
                        });
            },
        }
    }
</script>

<style scoped>
    #sidebar {
        background: #fff;
        padding: 20px;
        border-radius: 6px;
    }

    .beepNowWrap {
        background: #f0f0f0;
        margin: 20px -20px;
        padding: 20px;
    }

    .beepNowWrap textarea {
        background: transparent;
        border: transparent;
        box-shadow: none;
        resize: vertical;
    }
</style>