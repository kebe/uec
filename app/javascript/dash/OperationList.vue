<template>
    <div>
        <div id="operationsWraper">
          <table class="striped" style="font-size: 1.5em;">
            <thead>
              <tr>
                  <th>Type</th>
                  <th>Status</th>
                  <th>Time</th>
                  <th>Wheelchair</th>
                  <th>Action</th>
              </tr>
            </thead>
            <tbody>
                <operation v-for="operation in operations" :operation="operation" v-bind:key="operation.id" :showRemoveButton="false" ></operation>
            </tbody>
          </table>
        </div>
          
        <div id="operationsLoading" class="text-center" v-show="operationsLoading">
            <i class="fa fa-spin fa-spinner"></i>
        </div>
    </div>
</template>

<script>
    import Operation from 'dash/Operation.vue';

    export default {
        name: 'OperationList',
        components: {
            operation: Operation
        },
        created: function () {
            this.operations = [];
            this.getOperations(1);
        
            window.addEventListener('scroll', this.handleScroll);
        },
        destroyed: function () {
            window.removeEventListener('scroll', this.handleScroll);
        },
        props: {
            endpoint: {type: String, default: "/api/v1/todays_operations" },
            showRemoveButton: {type: Boolean, default: true }
        },
        data: function () {
            return {
                operations: [],
                page: {},
                operationsLoading: false
            }
        },
        watch: {
            endpoint: function () {
                this.operations = [];
                this.getOperations();
            }
        },
        methods: {
            getOperations: function (page) {
                this.operationsLoading = true;
                this.$http.get(this.endpoint)
                        .then(function (res) {
                            this.operations = this.operations.concat(res.body);
                            this.operation = {current: 1, last: 1};
                            this.operationsLoading = false;
                        })
                        .catch(function () {
                            this.operationsLoading = false;
                        })
            },
            reloadOps: function(){
                console.log('reloading');
                this.getOperations();
            },
            handleScroll: function () {
                if (document.body.scrollHeight - window.innerHeight - document.body.scrollTop == 0) {
                    if (this.page.current < this.page.last)
                        this.getOperations(this.page.current+1);
                }
            }
        }
    }
</script>

