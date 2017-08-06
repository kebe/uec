<template>
    <div id="profile">
        <div>
            <ul class="collapsible popout" data-collapsible="accordion">
                <li v-for="client in route.clients">
                  <div class="collapsible-header"><i class="material-icons"></i><h1><strong>{{ client.first_name }} {{ client.last_name }}</strong></h1> <h5><i class="material-icons" style="font-size:2.5rem">location_on</i> <strong>{{ client.address }}</strong></h5></div>
                  <div class="collapsible-body">
                    <span style="padding-right:100px"><a :id="'pu-'+client.id" class="waves-effect waves-light btn-large" v-on:click="open_pickup_modal($event)">Pickup</a></span>
                    <span><a :id="'do-'+client.id" class="waves-effect waves-light btn-large" v-on:click="open_dropoff_modal($event)">Dropoff</a></span>
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
                          <tr v-for="operation in client.operations">
                            <td>{{operation.op_type}}</td>
                            <td>{{operation.status}}</td>
                            <td>{{beepTime(operation.time) }}</td>
                            <td>{{operation.wheelchair}}</td>
                          </tr>
                        </tbody>
                      </table>
                  </div>  
                </li>
              </ul>

              <div id="pickup-modal" class="modal">
                <div class="modal-content">
                  <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click="client_status('pickup', 'present', $event)">Present</button></span>
                  <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click="client_status('pickup', 'not-present', $event)">Not Present</button></span>
                  <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click="client_status('pickup', 'no-show', $event)">No Show</button></span>
                </div>
              </div>

              <div id="dropoff-modal" class="modal">
                <div class="modal-content">
                  <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click="client_status('dropoff', 'present', $event)">Present</button></span>
                  <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click="client_status('dropoff', 'not-present', $event)">Not Present</button></span>
                  <span><button class="waves-effect waves-light btn-large" v-on:click="client_status('dropoff', 'no-show', $event)">No Show</button></span>
                </div>
              </div>
        </div>
    </div>
</template>



<script>
    import moment from 'moment';
    import OperationList from 'dash/OperationList.vue';

    export default {
        name: 'profile',
        components: {
            operationList: OperationList,
        },
        created: function () {
            this.getUser();
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
                this.$http.get('/api/v1/route/' + this.$route.params.id)
                        .then(function (res) {
                            this.route = res.body;
                        })
            },
            open_pickup_modal: function(client_id) {
              var targetId;
              targetId = event.currentTarget.id.split('-')[1]; //expecting id with format xx-id
              console.log(targetId); 

              $('#pickup-modal div').attr("id", 'pu-modal-'+targetId);
              $('#pickup-modal').modal('open');
            },
            open_dropoff_modal: function(client_id) {
              var targetId;
              targetId = event.currentTarget.id.split('-')[1]; //expecting id with format xx-id
              console.log(targetId); 

              $('#dropoff-modal div').attr("id", 'do-modal-'+targetId);
              $('#dropoff-modal').modal('open');
            },
            client_status: function ( type, status, event) {
              var targetId;
              targetId = event.currentTarget.parentElement.parentElement.id.split('-')[2]
              //alert( type + ' Client is ' + status + '!')
              this.$http.post('/api/v1/create_operation',{op_type: type, status: status, driver_id: this.route.driver_id, client_id: targetId, wheelchair: true, helper: "mike" })
                        .then(function (res) {
                            //this.route = res.body;
                            this.getUser(); 
                            console.log("operation is a success");
                        })
              $('#'+ type + '-modal').modal('close');  
            },
            beepTime: function (value) {
                return moment(String(value)).format('hh:mm a');
            }
        }
    }
</script>



<style scoped>
    #profile img{
        max-width: 200px;
    }
</style>