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



<style scoped>
    .operation {
        background: #f0f0f0;
        border-bottom: 1px solid #d6d6d6;
        padding: 40px 20px 0px;
    }

    .operation p {
        margin: 0;
    }

    .operation img {
        max-width: 100%;

    }

    .operation .row {
        display: flex;
        align-items: center;
    }

    .small {
        font-size: 13px;
    }

    .medium {
        font-size: 18px
    }

    .big {
        font-size: 23px;
    }

    .operationooter {
        margin: 40px -20px 0;
        background: #f8f8f8;
        color: #734b6d;
        padding: 10px 20px;
    }

    .boperationFooter .btn-default {
        color: #734b6d;
    }

    .operationFooter .btn-primary {
        background: #734b6d;
    }

    .operationFooter strong {
        margin-top: 7px;
    }
</style>