<template>
    <tr>
        <td>{{beep.op_type}}</td>
        <td>{{beep.status}}</td>
        <td>{{beepTime(beep.time) }}</td>
        <td>{{beep.wheelchair}}</td>
    </tr>
</template>



<script>
    import moment from 'moment';

    export default {
        name: 'beep',
        props: {
            beep: {},
            showUserInfo: {type: Boolean, default: true }
        },
        methods: {
            likeBeep: function () {
                if (!this.$auth.loggedIn()) {
                    alertify.error("You need login if you want to do that!");
                    return;
                }
                this.$http.patch('/beeps/' + this.beep.id+ '/like')
                        .then(function (res) {
                            if (this.beep.liked) {
                                this.beep.likes--;
                                this.beep.liked = false;
                            } else {
                                this.beep.likes++;
                                this.beep.liked = true;
                            }
                        })
            },
            beepDate: function (timestamp) {
                return moment(timestamp*1000).format("DD-MM-YYYY");
            },
            beepTime: function (value) {
                return moment(String(value)).format('hh:mm a');
            }
        }
    }
</script>



<style scoped>
    .beep {
        background: #f0f0f0;
        border-bottom: 1px solid #d6d6d6;
        padding: 40px 20px 0px;
    }

    .beep p {
        margin: 0;
    }

    .beep img {
        max-width: 100%;

    }

    .beep .row {
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

    .beepFooter {
        margin: 40px -20px 0;
        background: #f8f8f8;
        color: #734b6d;
        padding: 10px 20px;
    }

    .beepFooter .btn-default {
        color: #734b6d;
    }

    .beepFooter .btn-primary {
        background: #734b6d;
    }

    .beepFooter strong {
        margin-top: 7px;
    }
</style>