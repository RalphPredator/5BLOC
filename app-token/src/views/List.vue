<template>
  <div>
    <button class="btn btn-primary float-right mt-2" @click="reloadList">Reload</button>
    <h1 class="title">User List</h1>

    <div class="clearfix"></div>

    <h2 v-show="!bcConnected">Not connect to the blockchain: please wait.</h2>

    <h2 v-show="(isLoading && bcConnected)">Loading...</h2>

    <div class="row pb-5 mb-4" id="tokens">
          
      <div class="col-lg-3 col-md-6 mb-4 mb-3" v-for="token in tokens">
        <!-- Card-->
        <div class="card rounded shadow-sm border-0">
          <div class="card-body p-4">
            <img id="image" :src="token[4]" alt="" class="img-fluid d-block mx-auto mb-3">
            <h5>
              <p>
                <span id="name">{{ token[1] }}</span>
                <span id="price">{{ token[3] }} £</span>
                </p>
            </h5>
            <h5 id="address">{{ token[2] }}</h5>
            <p class="small text-muted font-italic" id="description">{{ token[5] }}</p>
            <button type="button" class="btn btn-primary">Mettre en vente</button>
            <button type="button" class="btn btn-danger">Retirer de la vente</button>
          </div>
        </div>
      </div>

    </div>

  </div>
</template>

<script>
  // importing common function
  import mixin from '../libs/mixinViews';

  /**
   * List view component: this component shows list of the registered users
   * and their statuses.
   */
  export default {
    mixins: [mixin],

    data() {
      return {
        tokens: [], // array that stores all the registered tokens
        isLoading: true, // true when the user list is loading form the blockchain
        bcConnected: false, // blockchain is connected ()
        tmoConn: null, // contain the intervalID given by setInterval
      }
    },

    methods: {
      /**
       * Get the list of the registered tokens once the connection to the
       * blockchain is established.
       */
      getTokenList() {
        if (this.blockchainIsConnected()) {
          // it shows the loading message
          this.isLoading = true;

          // stopping the interval
          clearInterval(this.tmoConn);

          // getting all the tokens from the blockchain
          this.getAllTokens(tokeninfo => {
            this.isLoading = false;
            this.tokens.push(tokeninfo);
          })
        }
      },

      /**
       * It reloads the user list.
       */
      reloadList() {
        this.tokens = [];

        this.getTokenList();
      },

      /**
       * Get all tokens.
       */
      getAllTokens(callback) {
        // getting the total number of tokens stored in the blockchain
        // calling the method totalUsers from the smart contract
        window.bc.contract().getAllTokens((err, total) => {
          if (total.length > 0) {
            // getting the user one by one
            for (var i=0; i<=total.length; i++) {
              window.bc.contract().getTokenDetail.call(i, (error, tokeninfo) => {
                console.log(tokeninfo)
                callback(tokeninfo);
              });
            } // end for
          } // end if
        }); // end totalUsers call
      }

    }, // end methods

    created() {
      // it tries to get the user list from the blockchian once
      // the connection is established
      this.tmoConn = setInterval(() => {
        this.getTokenList();
      }, 1000);
    }
  }
</script>

<style>
</style>
