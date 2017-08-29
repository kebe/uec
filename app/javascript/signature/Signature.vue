<template> 
  <div id="signature-pad" class="m-signature-pad">
    <div class="m-signature-pad--body">
      <canvas></canvas>
    </div>
    <div class="m-signature-pad--footer">
      <div class="description">Sign above</div>
      <button @click="clearButton" type="button" class="button clear" data-action="clear">Clear</button>
      <button @click="saveButton" type="button" class="button save" data-action="save">Save</button>
    </div>
  </div>
</template>
<script>
    import SignaturePad from 'signature_pad';
    export default {
        name: "Signature",
        created: function(){
          this.getServiceTicket();
        },
        mounted: function () {
            var wrapper = document.getElementById("signature-pad"),
            clearButton = wrapper.querySelector("[data-action=clear]"),
            saveButton = wrapper.querySelector("[data-action=save]"),
            canvas = wrapper.querySelector("canvas"),
            signaturePad;

        // Adjust canvas coordinate space taking into account pixel ratio,
        // to make it look crisp on mobile devices.
        // This also causes canvas to be cleared.
        function resizeCanvas() {
            // When zoomed out to less than 100%, for some very strange reason,
            // some browsers report devicePixelRatio as less than 1
            // and only part of the canvas is cleared then.
            var ratio =  Math.max(window.devicePixelRatio || 1, 1);
            canvas.width = canvas.offsetWidth * ratio;
            canvas.height = canvas.offsetHeight * ratio;
            canvas.getContext("2d").scale(ratio, ratio);
        }

        window.onresize = resizeCanvas;
        resizeCanvas();

        this.signaturePad = new SignaturePad(canvas);
        },
        data: function () {
            return {
                serviceTicket: {},
                signaturePad: {}
            }
        },
        watch: {
            // call again the method if the route changes
            $serviceTickets: 'getServiceTickets'
        },
        methods: {
            getServiceTicket: function (id) {
                //$('.button-collapse').sideNav('hide');
                this.$http.get('/api/v1/service-ticket/' + this.$route.params.id )
                        .then(function (res) {
                            this.serviceTicket = res.body;
                        })
            },
            saveButton: function () {
                if (this.signaturePad.isEmpty()) {
                    alert("Please provide signature first.");
                } else {
                  var data = JSON.stringify(
                     {
                       value: this.signaturePad.toDataURL()
                     });
                  this.$http.post('/api/v1/service-ticket/'+ this.$route.params.id +'/signature', {value: this.signaturePad.toDataURL()})
                      .then(function (res) {
                        this.getServiceTicket(); 
                        this.$router.push('/service-tickets/me')
                        alertify.success("Operation added successfully!");
                      })
                }
            },
            clearButton: function() {
                this.signaturePad.clear();
            }
        }
    }
</script>