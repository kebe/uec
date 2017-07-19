// var state = {
//   token: "<%= JWTWrapper.encode({ driver_id: current_driver.id }) %>"
// };
// Vue.component("temperature", {
//   template: "#temperature-template",
//   data: function() {
//     return {route_name: null, clients: null};
//   },
//   created: function() {
//     this.fetchData();
//   },
//   methods: {
//     fetchData: function() {
//       var self = this;
//       $.ajax({
//         url: "/api/v1/routes",
//         beforeSend: function(xhr) { xhr.setRequestHeader("Authorization", "Bearer " + state.token); },
//         success: function(response) {
//           console.log(response.clients);
//           self.route_name = response.name;
//           self.clients = response.clients;
//         }
//       });
//     }
//   }
// });
// Vue.component("login", {
//   template: "#login-template",
//   data: function() {
//     return {
//       email: "chris@gorails.com",
//       password: "password"
//     };
//   },
//   methods: {
//     submit: function(event) {
//       event.preventDefault();
//       $.post("/api/v1/user_token", {auth: {email: this.email, password: this.password}}, function(data) {
//         localStorage.setItem("token", data.jwt);
//         state.token = data.jwt;
//       })
//     }
//   }
// })
// new Vue({
//   el: "#locations",
//   data: state
// })