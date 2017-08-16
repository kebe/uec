<template>
  <div>  
    <div :id="'pickup-modal-'+client.id" class="modal">
        <div class="modal-content">
            <h4>Pickup: {{client.first_name}} {{client.last_name}}</h4>
          <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click.prevent="$emit('client-status-operation', 'pickup', 'present', client)">Present</button></span>
          <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click.prevent="$emit('client-status-operation', 'pickup', 'not-present', client)">Not Present</button></span>
          <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click.prevent="$emit('client-status-operation', 'pickup', 'no-show', client)">No Show</button></span>
        </div>
    </div>

    <div :id="'dropoff-modal-'+client.id" class="modal">
        <div class="modal-content">
            <h4>Dropoff: {{client.first_name}} {{client.last_name}}</h4>
          <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click.prevent="$emit('client-status-operation', 'dropoff', 'present', client)">Present</button></span>
          <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click.prevent="$emit('client-status-operation', 'dropoff', 'not-present', client)">Not Present</button></span>
          <span style="padding-right:100px"><button class="waves-effect waves-light btn-large" v-on:click.prevent="$emit('client-status-operation', 'dropoff', 'no-show', client)">No Show</button></span>
        </div>
    </div>
  </div>
</template>



<script>
    export default {
        name: 'modal',
        props: ['client']
        
    }
</script>


