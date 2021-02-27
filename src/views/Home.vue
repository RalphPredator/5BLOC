<template>
  <div>
    <b-row>
      <b-col md="4" v-for="(token, index) in tokens" :key="index">
        <b-card :title="token.name" :img-src="token.image" img-alt="Image">
          <b-card-sub-title class="mb-2">
            Prix: {{ token.price }} <br>
            Addresse : {{ token.adresse }}
          </b-card-sub-title>
          <b-card-text>
            {{ token.description }}
          </b-card-text>
          <template #footer>
            <b-button block variant="info">Acheter</b-button>
          </template>
        </b-card>
      </b-col>
    </b-row>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Home',
  data(){
    return{
      tokens:[
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
        {
          name: "testest",
          price: "300",
          image: "https://picsum.photos/400/400/?image=20",
          adresse: "28 rue Goiklo",
          description: "lorem isdqda zdhaizdsq jfdlsqk hfqlksjef hoizaehfjdsfkqhflkjhfd qsdfkds dsf dsf df df dsfs dfs fs df s dfs f s"
        },
      ]
    }
  }
}
</script>

<style type="text/css" scoped="">
  .card-img, .card-img-bottom, .card-img-top{
    width: 100wh !important;
    max-height: 200px;
  }
  .card{
    margin-bottom: 15px;
  }
</style>