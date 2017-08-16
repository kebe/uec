<template>
    <tr>
        <td>{{operation.op_type}}</td>
        <td>{{operation.status}}</td>
        <td>{{operationTime(operation.time) }}</td>
        <td v-if="operation.wheelchair"><i class="material-icons">accessible</i></td>
        <td v-else="operation.wheelchair"></td>
        <td><a v-show="showRemoveButton" :id="'op-'+operation.id" href="#" class="waves-effect waves-light btn-small" v-on:click.prevent="$emit('remove-operation', operation)">Remove</a></td>
    </tr>
</template>



<script>
    import moment from 'moment';

    export default {
        name: 'operation',
        props: {
            operation: {},
            showRemoveButton: {type: Boolean, default: true }
        },
        methods: {
            likeOperation: function () {
                if (!this.$auth.loggedIn()) {
                    alertify.error("You need login if you want to do that!");
                    return;
                }
                this.$http.patch('/operations/' + this.operation.id+ '/like')
                        .then(function (res) {
                            if (this.operation.liked) {
                                this.operation.likes--;
                                this.operation.liked = false;
                            } else {
                                this.operation.likes++;
                                this.operation.liked = true;
                            }
                        })
            },
            operationDate: function (timestamp) {
                return moment(timestamp*1000).format("DD-MM-YYYY");
            },
            operationTime: function (value) {
                return moment(String(value)).format('hh:mm a');
            }
        }
    }
</script>


