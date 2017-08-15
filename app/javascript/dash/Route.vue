<template>
    <div id="route">
        <div>
            <h1 align="center"><i class="material-icons" style="font-size:2.9rem">directions_railway</i> {{route.name}} Route</h1>
            <hr />
            <ul class="collapsible popout" data-collapsible="accordion">
                <li v-for="client in route.clients">
                  <div class="collapsible-header"><i class="material-icons"></i><h1><strong>{{ client.first_name }} {{ client.last_name }}</strong></h1> <h5><i class="material-icons adjust-loc-icon" style="font-size:2.5rem">location_on</i> <strong>{{ client.address }}</strong></h5></div>
                  <div class="collapsible-body">
                    <span style="padding-right:100px"><a :id="'pu-'+client.id" class="waves-effect waves-light btn-large" v-on:click="open_pickup_modal(client, $event)">Pickup</a></span>
                    <span><a :id="'do-'+client.id" class="waves-effect waves-light btn-large" v-on:click="open_dropoff_modal(client,$event)">Dropoff</a></span>
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

              <modal @client-status-operation="client_status( ...arguments)" v-for="client in route.clients" v-bind:key="client.id" v-bind:client="client"></modal>
              
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
        created: function () {
            this.getUser();
            // this.$on('reloadOps', function(message) {
            //     console.log('reloading');
            //     this.removeOperation();
            // })
        },
        data: function () {
            return {
                route: {}
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
                        })
            },
            open_pickup_modal: function(client) {
              //var targetId;
              //targetId = event.currentTarget.id.split('-')[1]; //expecting id with format xx-id
              //console.log(targetId); 

              //$('#pickupodal div').attr("id", 'pu-modal-'+targetId);
              $('#pickup-modal-'+client.id).modal('open');
            },
            open_dropoff_modal: function(client) {
              // var targetId;
              // targetId = event.currentTarget.id.split('-')[1]; //expecting id with format xx-id
              // console.log(targetId); 

              //$('#dropoff-modal div').attr("id", 'do-modal-'+targetId);
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
            operationTime: function (value) {
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
              
            }
        }
    }
</script>



<style scoped>
    #route img{
        max-width: 200px;
    }
</style>