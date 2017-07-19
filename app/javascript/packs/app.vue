<template>
  <div id="app">
    <h1>{{ route_name }}</h1>
    <table> 
      <thead>
        <tr>
          <th>First Name</th>
          <th>Last Name</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="client in clients">
          <td>{{ client.first_name }}</td>
          <td>{{ client.last_name }}</td>
        </tr>
      </tbody>
    </table> 
  </div>
</template>

<script>
export default {
  data: function() {
    return {route_name: null, clients: null};
  },
  created: function() {
    this.fetchData();
  },
  methods: {
    fetchData: function() {
      var self = this;
      $.ajax({
        url: "/api/v1/routes",
        beforeSend: function(xhr) { xhr.setRequestHeader("Authorization", "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkcml2ZXJfaWQiOjEsImV4cCI6MTUwMDQ4MDI2M30.Nnbm0mnXRdZRON25IWrfs2zuOFw7e4munWBX0PcXb7k"); },
        success: function(response) {
          console.log(response.clients);
          self.route_name = response.name;
          self.clients = response.clients;
        }
      });
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
