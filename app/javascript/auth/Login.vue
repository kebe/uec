<template>
    <div>
        <h3 class="text-center">Login</h3>

        <input type="text" class="form-control m-b-15" placeholder="Username"
               v-model="user.username">
        <input type="password" class="form-control" placeholder="Password"
               v-model="user.password">

        <hr>

        <button class="btn btn-lg btn-primary btn-block m-b-15"
            @click="login">Sign in</button>

    </div>
</template>

<script>
    export default {
        name: "login",
        data: function() {
            return {
                user: {
                    username: "ouskebe@hotmail.com",
                    password: "urbanexpress"
                }
            }
        },
        methods: {
            login: function () {
                this.$http.post("/api/v1/drivers/create", {driver_login: {email: this.user.username, password: this.user.password}})
                        .then(function (res) {
                            this.$auth.setToken(res.body.auth_token, Date.now() + 14400000 ); // + 4 hours
                            this.$router.push('/dashboard');
                        })
            }
        }
    }
</script>


<style>

</style>
