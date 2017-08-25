<template>
    <div id="service-tickets">
        <div>
            <h1 align="center"><i class="material-icons" style="font-size:2.9rem">directions_railway</i> Today's Service Tickets</h1>
            <hr />
            <ul class="collapsible popout" data-collapsible="accordion">
                <li v-for="ticket in serviceTickets">
                  <div class="collapsible-header">
                    <h3 style="color:green;float:right;">{{service_ticket_status(ticket.pickup_time, ticket.dropoff_time)}}</h3>
                    <router-link v-if="!(ticket.signature.url)" :to="'/service-ticket/'+ticket.id+'/signature'" class="waves-effect">
                        <h5><i class="material-icons adjust-loc-icon">border_color</i>Missing Signature</h5>
                    </router-link>
                    <div v-else><h5 style="color:green;"><i class="material-icons adjust-loc-icon">check_circle</i>Signed</h5></div>

                    <i class="material-icons"></i><h1><strong>{{ticket.client.first_name}} {{ticket.client.last_name}}</strong></h1> 
                    <h5><i class="material-icons adjust-loc-icon">location_on</i> <strong>From Address: <span class="pick_addr">{{ticket.pickup_address}}</span></strong></h5>
                    <h5><i class="material-icons adjust-loc-icon" >access_time</i> <strong>Scheduled Pickup Time: {{formatTime(ticket.service_time)}}</strong></h5>
                    <h5><i class="material-icons adjust-loc-icon">location_on</i> <strong>To Address: <span class="pick_addr">{{ticket.dropoff_address}}</span></strong></h5>
                  </div>
                  <div class="collapsible-body">
                    <span><a v-if="!(ticket.pickup_time)" class="waves-effect waves-light btn-large" v-on:click="service_ticket_operation('pickup', ticket)">Picked-up</a></span>
                    <span><a v-if="!(ticket.dropoff_time)" class="waves-effect waves-light btn-large" v-on:click="service_ticket_operation('dropoff', ticket)">Dropped-off</a></span>
                    <div style="float:right">
                      <div><a style="float:right" class="waves-effect waves-light btn-large" :href="'http://maps.google.com/?q='+ticket.dropoff_address" >{{ticket.dropoff_address}}</a></div>
                      <div><a style="float:right;margin-top:10px;" class="waves-effect waves-light btn-large" :href="'http://maps.google.com/?q='+ticket.pickup_address" >{{ticket.pickup_address}}</a></div>
                    </div>
                    <div>
                        <h5>Picked Up At: <strong>{{formatTime(ticket.pickup_time)}}</strong> </h5>
                        <h5>Dropped Off At: <strong>{{formatTime(ticket.dropoff_time)}}</strong> </h5>
                    </div>
                  </div>  
                </li>
            </ul>
              
        </div>
    </div>
</template>



<script>
    import moment from 'moment';
    //import SignaturePad from 'signature-pad';
    //import Sig from '../signature/signature.js'
    export default {
        name: 'serviceTicket',
 
        mounted: function () {
            //reinitailize collapsible feature when coming from a different route
            $('.collapsible').collapsible();
        },
        created: function () {
            this.getServiceTickets();
        },
        data: function () {
            return {
                serviceTickets: {}
            }
        },
        watch: {
            // call again the method if the route changes
            $serviceTickets: 'getServiceTickets'
        },
        methods: {
            getServiceTickets: function () {
                $('.button-collapse').sideNav('hide');
                this.$http.get('/api/v1/service-tickets/me' )
                        .then(function (res) {
                            this.serviceTickets = res.body;
                        })
            },
            formatTime: function (value) {
              if (value == ""){
                return "";
              }
              return moment(String(value)).format('hh:mm a');
            },
            service_ticket_operation: function (type, ticket) {
              this.$http.post('/api/v1/update-service-ticket/'+ ticket.id, {id: ticket.id, type: type })
                        .then(function (res) {
                            this.getServiceTickets(); 
                            alertify.success("Operation added successfully!");
                        })
            },
            service_ticket_status: function (pickup, dropoff) {
              if (pickup != "" && dropoff != ""){
                return "completed"
              }
            }
        }
    }
</script>

