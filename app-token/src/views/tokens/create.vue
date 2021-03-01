<template>
  <div>
    <h1 class="title">Ajouter un token</h1>

    <div class="container">
        <!-- Registeration Form -->
      <div class="col-md-6 mr-auto">
        <div action="#">
          <div class="row">

            <!-- First Name -->
            <div class="input-group col-lg-6 mb-4">
              <div class="input-group-prepend">
                <span class="input-group-text bg-white px-4 border-md border-right-0">
                  <i class="fa fa-user text-muted"></i>
                </span>
              </div>
              <input id="firstName" type="text" name="firstname" placeholder="Nom" v-model="name" class="form-control bg-white border-left-0 border-md">
            </div>

            <!-- Last Name -->
            <div class="input-group col-lg-6 mb-4">
              <div class="input-group-prepend">
                <span class="input-group-text bg-white px-4 border-md border-right-0">
                  <i class="fa fa-user text-muted"></i>
                </span>
              </div>
              <input id="lastName" type="number" min="0" name="lastname" placeholder="Prix" v-model="price" class="form-control bg-white border-left-0 border-md">
            </div>

            <!-- Email Address -->
            <div class="input-group col-lg-12 mb-4">
              <div class="input-group-prepend">
                <span class="input-group-text bg-white px-4 border-md border-right-0">
                  <i class="fa fa-envelope text-muted"></i>
                </span>
              </div>
              <input id="email" type="text" name="email" placeholder="addresse" v-model="addresse" class="form-control bg-white border-left-0 border-md">
            </div>

            <!-- Email Address -->
            <div class="input-group col-lg-12 mb-4">
              <div class="input-group-prepend">
                <span class="input-group-text bg-white px-4 border-md border-right-0">
                  <i class="fa fa-envelope text-muted"></i>
                </span>
              </div>
              <input id="email" type="text" name="email" placeholder="image" v-model="image" class="form-control bg-white border-left-0 border-md">
            </div>

            <!-- Email Address -->
            <div class="input-group col-lg-12 mb-4">
              <div class="input-group-prepend">
                <span class="input-group-text bg-white px-4 border-md border-right-0">
                  <i class="fa fa-envelope text-muted"></i>
                </span>
              </div>
              <textarea class="form-control bg-white border-left-0 border-md" placeholder="description" v-model="description">
                
              </textarea>
            </div>

            <!-- Submit Button -->
            <div class="form-group col-lg-12 mx-auto mb-0">
              <button type="button" @click="performSubmit" class="btn btn-primary btn-block py-2">
                <span class="font-weight-bold">Creer un token</span>
              </button>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  // importing common function
  import mixin from '@/libs/mixinViews';

  export default {
    mixins: [mixin],

    data() {
      return {
        name: '', // variable binded with the input field: name
        addresse: '', // variable binded with the input field: status
        price: 0,
        description: "",
        image: "",
        submitting: false, // true once the submit button is pressed
        successMessage: false, // true when the user has been registered successfully

        tmoConn: null, // contain the intervalID given by setInterval
        tmoReg: null, // contain the intervalID given by setInterval
        errorStr: null, // it shows the error message
      }
    },

    computed: {
      /**
       * It disables the submit button when the the name or userStatus are not filled
       * or the submit button is pressed or the connection with the blockchin is
       * not established.
       */
      // disableSubmit() {
      //     return (
      //         !this.userName.length ||
      //         !this.userStatus.length ||
      //         this.submitting ||
      //         !this.blockchainIsConnected()
      //     );
      // }
    },

    created() {
      // it checks every 500ms if the user is registered until the connection is established
      // this.redirectIfUserRegistered();
    },

    methods: {
      /**
       * Perform the registration of the user when the submit button is pressed.
       *
       * @return {void}
       */
      performSubmit() {
        this.submitting = true;
        this.errorStr = null;
        this.successMessage = false;

        window.bc.getMainAccount()
        .then(address => this.performUserRegistration(address));
      },

      /**
       * Show the form error.
       *
       * @param {object} err
       * @return {void}
       */
      showErrorMessage(err) {
        console.error(err);

        this.errorStr = null;

        if (err) this.errorStr = err.toString();

        if (! this.errorStr) this.errorStr = 'Error occurred!';
      },

      /**
       * Perform the user registration cannling the smart contract
       * function registerUser.
       *
       * @param {string} address
       * @return {void}
       */
      performUserRegistration(address) {
        window.bc.contract().createToken(
          this.name,
          this.addresse,
          this.price,
          this.image,
          this.description,
          {
            from: address,
            gas: 2000000
          },
          (err, txHash) => {
            this.submitting = false;

            if (err) {
              this.showErrorMessage(err);
            }
            else {
              this.successMessage = true;

              // it emits a global event in order to update the top menu bar
              // Event.$emit('userregistered', txHash);

              // the transaction was submitted and the user will be redirected to the
              // profile page once the block will be mined
              // this.redirectWhenBlockMined();
            }
          }
        )
      },

      /**
       * Check if the user visitng this page is registered: if the user is already
       * registered he will be redirected to the Profile page.
       *
       * @return {void}
       */
      // redirectIfUserRegistered() {
      //     this.tmoConn = setInterval(() => {
      //         // checking first the connection
      //         if (this.blockchainIsConnected()) {
      //             // stopping the interval
      //             clearInterval(this.tmoConn);

      //             // calling the smart contract
      //             this.isRegistered().then(res => {
      //                 if (res) {
      //                     // redirecting to the profile page
      //                     this.$router.push("profile");
      //                 }
      //             });
      //         }
      //     }, 500);
      // },

      /**
       * Once the user submitted his registration this funciton checks every 1000 ms
       * if the registration is successfully. Once the user is registered he will be
       * redirected to the profile page.
       *
       * NOTE: in order to check if the user has been registered successfully the
       * function has to check several time because the block can take several
       * minutes to be mined (depending on the the blockchain you are using).
       *
       * @return {void}
       */
      redirectWhenBlockMined() {
        this.tmoReg = setInterval(() => {
          if (this.blockchainIsConnected()) {
            this.isRegistered()
            .then(res => {
              if (res) {
                // stopping the setInterval
                clearInterval(this.tmoReg);

                // redirecting the user to the profile page
                this.$router.push("profile");
              }
            })
            .catch(error => this.showErrorMessage(error));
          }
        }, 1000);
      }
    }
  }
</script>
