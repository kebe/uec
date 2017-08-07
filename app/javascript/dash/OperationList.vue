<template>
    <div>
        <div id="beepsWraper">
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
                <beep v-for="beep in beeps" :beep="beep" v-bind:key="beep.id" ></beep>
            </tbody>
          </table>
        </div>
          
        <div id="beepsLoading" class="text-center" v-show="beepsLoading">
            <i class="fa fa-spin fa-spinner"></i>
        </div>
    </div>
</template>

<script>
    import Beep from 'dash/Beep.vue';

    export default {
        name: 'OperationList',
        components: {
            beep: Beep,
        },
        created: function () {
            this.beeps = [];
            this.getBeeps(1);

            window.addEventListener('scroll', this.handleScroll);
        },
        destroyed: function () {
            window.removeEventListener('scroll', this.handleScroll);
        },
        props: {
            endpoint: {type: String, default: "/api/v1/todays_operations" },
            showUserInfo: {type: Boolean, default: true }
        },
        data: function () {
            return {
                beeps: [],
                page: {},
                beepsLoading: false
            }
        },
        watch: {
            endpoint: function () {
                this.beeps = [];
                this.getBeeps();
            }
        },
        methods: {
            getBeeps: function (page) {
                this.beepsLoading = true;
                this.$http.get(this.endpoint)
                        .then(function (res) {
                            this.beeps = this.beeps.concat(res.body);
                            this.page = {current: 1, last: 1};
                            this.beepsLoading = false;
                        })
                        .catch(function () {
                            this.beepsLoading = false;
                        })
            },
            handleScroll: function () {
                if (document.body.scrollHeight - window.innerHeight - document.body.scrollTop == 0) {
                    if (this.page.current < this.page.last)
                        this.getBeeps(this.page.current+1);
                }
            }
        }
    }
</script>

<style scoped>
    #beepsWraper {
        margin: 0 -20px;
    }

    #beepsLoading {
        padding: 40px;
    }

    #beepsLoading i {
        font-size: 40px;
    }
</style>