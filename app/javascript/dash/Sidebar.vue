<template>
    <div id="sidebar" class="text-center">
        <ul id="slide-out" class="side-nav">
            <li><div><img src="/logo_v2.jpg" class="img-circle" ></div> </li>
            <li><a href="#" style="font-size:1.3em;"><i class="material-icons">person</i>Driver: {{user.first_name + ' ' + user.last_name}}</a></li>
            <li><a href="#" @click.prevent="logout"><i class="material-icons">power_settings_new</i> <h5>Logout</h5></a></li>
            <li><div class="divider"></div></li>
            <li @click="close_sidebar"><router-link :to="'/dashboard'" class="waves-effect">
                    <i class="material-icons">dashboard</i> <h5>Dashboard</h5>
                </router-link></li>
            <li><a target="_blank" :href="user_worksheet"><i class="material-icons">receipt</i><h5>Worksheet</h5></a></li>
            <li><a class="subheader"><h5>Service Tickets</h5></a></li>
                <ul>
                  <li @click="close_sidebar" v-for="ticket in user.todays_service_tickets">
                  <router-link :to="'/service-tickets/me'" class="waves-effect">
                            <i class="material-icons">directions_railway</i> <h5>{{formatTime(ticket.service_time)}}</h5>
                        </router-link>
                  </li>
                </ul>
            <li><a class="subheader"><h5>My Leave Routes</h5></a></li>
                <ul>
                  <li @click="close_sidebar" v-for="client_route in user.routes">
                  <router-link :to="'/route/'+client_route.id+'/leave'" class="waves-effect">
                            <i class="material-icons">directions_railway</i> <h5>{{client_route.name}}</h5>
                        </router-link>
                  </li>
                </ul>
            <li><a class="subheader"><h5>My Return Routes</h5></a></li>
                <ul>
                  <li @click="close_sidebar" v-for="client_route in user.routes">
                  <router-link :to="'/route/'+client_route.id+'/return'" class="waves-effect">
                            <i class="material-icons">directions_railway</i> <h5>{{client_route.name}}</h5>
                        </router-link>
                  </li>
                </ul>
        
        </ul>
        <a href="#" data-activates="slide-out" class="button-collapse"><i class="material-icons large" style="margin-top:20px;">menu</i></a>
    </div>
</template>

<script>
    import moment from 'moment';
    export default {
        name: 'sidebar',
        created: function () {
            if (this.loggedIn)
                this.getUser();
        },
        data: function () {
            return {
                user: {},
                user_worksheet: {},
                newOperation : "",
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
                            this.user_worksheet = res.body.worksheet.url
                        });
            },
            formatTime: function (value) {
                return moment(String(value)).format('hh:mm a');
            },
            close_sidebar: function(){
                $('.button-collapse').sideNav('hide');
            }
        }
    }
</script>
