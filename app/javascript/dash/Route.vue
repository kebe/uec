<template>
    <div id="route">
        <div>
            <h1 align="center"><i class="material-icons" style="font-size:2.9rem">directions_railway</i> {{route.name}} Route ({{trip_type}})</h1>
            <hr />
            <ul class="collapsible popout" data-collapsible="accordion">
              <li v-for="client in clients">
                <div class="collapsible-header"><i class="material-icons"></i><h1><strong>{{ client.first_name }} {{ client.last_name }}</strong></h1> <h5><i class="material-icons adjust-loc-icon" style="font-size:2.5rem">location_on</i> <strong>{{ client.address }}</strong></h5></div>
                <div class="collapsible-body">
                  <span style="padding-right:100px"><a class="waves-effect waves-light btn-large" v-on:click="open_pickup_modal(client, $event)">Pickup</a></span>
                  <span><a class="waves-effect waves-light btn-large" v-on:click="open_dropoff_modal(client,$event)">Dropoff</a></span>
                  <span style="float:right"><a class="waves-effect  btn-large" :href="'http://maps.google.com/?q='+client.address" >{{ client.address }}</a></span>
                    <table class="striped" style="font-size: 1.5em;">
                      <thead>
                        <tr>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Time</th>
                            <th>Wheelchair</th>
                        </tr>
                      </thead>
                      <tbody>
                          <operation @remove-operation="removeOperation(operation)" v-for="operation in client.operations" :operation="operation" v-bind:key="operation.id" :showRemoveButton="true" ></operation>
                      </tbody>
                    </table>
                </div>  
              </li>
            </ul>

            <modal @client-status-operation="client_status( ...arguments)" v-for="client in clients" v-bind:key="client.id" v-bind:client="client"></modal>
              
        </div>
        <div v-if="route_status(trip_type)">
            <p>
              <div class="input-field">
                <select v-model="finished_route.assistant">
                  <option v-for="option in options" v-bind:value="option.value">
                    {{ option.text }}
                  </option>
                </select>
              </div>
              <input v-model="finished_route.lic_plate"type="text" placeholder="license plate">
              <input v-model="finished_route.starting_miles" type="text" placeholder="starting mileage">
              <input v-model="finished_route.ending_miles"type="text" placeholder="ending mileage">
            </p>
            <button @click="finish_route" class="waves-effect  btn-large">Finish Route</button>
        </div>
        <div v-else> 
            <div v-if="trip_type='leave'">
              <ul class="collection with-header">
                <li class="collection-header"><h4>Finished Route Information</h4></li>
                <li class="collection-item">Assistant Name: {{route.todays_leave_route_trips[0].assistant}}</li>
                <li class="collection-item">License Plate: {{route.todays_leave_route_trips[0].lic_plate}}</li>
                <li class="collection-item">Starting Mileage: {{route.todays_leave_route_trips[0].starting_miles}}</li>
                <li class="collection-item">Ending Mileage: {{route.todays_leave_route_trips[0].ending_miles}}</li>
                <li class="collection-item">Finish Time: {{formatTime(route.todays_leave_route_trips[0].finish_time)}}</li>
              </ul>
            </div>
            <div v-else>
                <ul class="collection with-header">
                  <li class="collection-header"><h4>Finished Route Information</h4></li>
                  <li class="collection-item">Assistant Name: {{route.todays_return_route_trips[0].assistant}}</li>
                  <li class="collection-item">License Plate: {{route.todays_return_route_trips[0].lic_plate}}</li>
                  <li class="collection-item">Starting Mileage: {{route.todays_return_route_trips[0].starting_miles}}</li>
                  <li class="collection-item">Ending Mileage: {{route.todays_return_route_trips[0].ending_miles}}</li>
                  <li class="collection-item">Finish Time: {{formatTime(route.todays_return_route_trips[0].finish_time)}}</li>
                </ul>
            </div>
        </div>  
    </div>
</template>



<script>
    import moment from 'moment';
    import Operation from 'dash/Operation.vue';
    import Modal from 'dash/Modal.vue';

    export default {
        name: 'route',
        components: {
            operation: Operation,
            modal: Modal,
        },
        mounted: function () {
            //reinitailize collapsible feature when coming from a different route
            $('.collapsible').collapsible();
        },
        updated: function(){
          $('select').material_select();
        },
        created: function () {
            this.getUser();
        },
        data: function () {
            return {
                route: {todays_leave_route_trips: [{assistant: ""}, {lic_plate: ""}, {starting_miles: ""}, {ending_miles: ""}, {finish_time: ""} ], 
                        todays_return_route_trips: [{assistant: ""}, {lic_plate: ""}, {starting_miles: ""}, {ending_miles: ""}, {finish_time: ""} ]},
                clients: {},
                trip_type: {},
                finished_route: {
                    assistant: "",
                    lic_plate: "",
                    starting_miles: "",
                    ending_miles: ""
                },
                options: [
                  { text: 'Choose one', value: '' },
                  { text: 'Melissa', value: 'Melissa' },
                  { text: 'Mike', value: 'Mike' },
                  { text: 'Emily', value: 'Emily' }
                ]
            }
        },
        watch: {
            // call again the method if the route changes
            $route: 'getUser'
        },
        methods: {
            getUser: function () {
                $('.button-collapse').sideNav('hide');
                this.$http.get('/api/v1/route/' + this.$route.params.id)
                        .then(function (res) {
                            this.route = res.body;
                            this.trip_type = this.$route.path.split('/')[3];
                            if (this.trip_type == 'leave'){
                              this.clients = this.route.todays_pickup_clients;
                            }
                            else if (this.trip_type == "return"){
                              this.clients = this.route.todays_dropoff_clients;
                            }
                            else {
                              this.clients = {};
                            }
                        })
            },
            open_pickup_modal: function(client) {
              console.log(client.id);
              $('#pickup-modal-'+client.id).modal('open');
            },
            open_dropoff_modal: function(client) {

              $('#dropoff-modal-'+client.id).modal('open');
            },
            client_status: function ( type, status, client) {
              this.$http.post('/api/v1/create_operation',{op_type: type, status: status, driver_id: this.route.driver_id, client_id: client.id, wheelchair: client.disability, helper: "mike" })
                        .then(function (res) {
                            this.getUser(); 
                            alertify.success("Operation added successfully!");
                            
                        })
              $('#'+type+'-modal-'+client.id).modal('close');  
            },
            formatTime: function (value) {
                return moment(String(value)).format('hh:mm a');
            },
            removeOperation: function(operation){
              if (confirm("Are you sure you want to delete this operation?") == true) {
                  this.$http.post('/api/v1/remove_operation/'+operation.id)
                            .then(function (res) {
                                this.getUser(); 
                                alertify.success("Operation removed successfully!");  
                            })
              } else {
                return
              }
              
            },
            finish_route: function () {
              this.$http.post('/api/v1/route/'+this.route.id+'/finish_'+ this.trip_type+'_route', this.finished_route)
                        .then(function (res) {
                            this.getUser(); 
                            alertify.success("Operation added successfully!");
                            
                        })
            },
            route_status: function(trip_type){
              
              if (trip_type == "leave"){
                if (this.route.todays_leave_route_trips === undefined){
                  return 1;
                }
                return this.route.todays_leave_route_trips.length == 0
              }
              else if (trip_type == "return"){
                if (this.route.todays_return_route_trips === undefined){
                  return 1;
                }
                return this.route.todays_return_route_trips.length == 0
              }
            } 
        }
    }
</script>

