<template>
  <div class="app-container">
    <b-navbar class="d-flex justify-content-between align-items-center mb-5" type="dark" variant="info">
      <b-navbar-brand href="#">PhotoViewer 3000</b-navbar-brand>
      <div class="input-group w-50">
        <div class="input-group-prepend">
          <div class="input-group-text">Image Size</div>
        </div>
        <select class="custom-select" v-model="relation">
          <option value="greater">larger than</option>
          <option value="lesser">smaller than</option>
        </select>
        <input type="text" class="form-control" name="columns" placeholder="height" v-model="columns">
        <input type="text" class="form-control" name="rows" placeholder="width" v-model="rows">
        <div class="input-group-append">
          <button class="input-group-text" @click.prevent="executeSearch">Search</button>
        </div>
      </div>
    </b-navbar>
    <template v-if="pageRange.length == 0">
      <h2>Sorry, looks like there is nothing here!</h2>
    </template>
    <template v-for="num in pageRange">
      <b-img thumbnail v-b-modal.focusModal class="mx-1" @click="toggleGrayscale" :src="`http://0.0.0.0:3000/images/${num}`" :alt="`Image ${num}`" data-grayscaled="false"></b-img>
    </template>
    <div class="mt-5">
      <b-button-group>
        <b-button @click="decrementOffset" v-if="this.offset !== 0">Previous</b-button>
        <b-button @click="offset += 10" v-if="pageRange.length > 0">Next</b-button>
      </b-button-group>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'PhotoViewer',
  data () {
    return {
      pageRange: [],
      grayscale: false,
      columns: '',
      rows: '',
      offset: 0,
      relation: 'greater'
    }
  },
  computed: {
    queryString () {
      return `?columns=${this.columns}` + `&rows=${this.rows}` + `&offset=${this.offset}` + `&relation=${this.relation}`
    }
  },
  watch: {
    offset: {
      handler: 'getUrls',
      immediate: true
    }
  },
  methods: {
    getUrls () {
      axios.get('http://0.0.0.0:3000/images' + this.queryString)
        .then(response => {
          this.pageRange = response.data
        })
    },
    decrementOffset (event) {
      if (this.offset - 10 < 0) {
        this.offset = 0
      } else {
        this.offset -= 10
      }
    },
    executeSearch () {
      this.offset === 0 && this.getUrls()
      this.offset = 0
    },
    toggleGrayscale (event) {
      if (event.target.getAttribute('data-grayscaled') === 'false') {
        event.target.setAttribute('data-grayscaled', true)
        event.target.src = event.target.src + '?grayscale=true' + '&' + new Date().getTime()
      } else {
        event.target.setAttribute('data-grayscaled', false)
        event.target.src = event.target.src.split('?')[0]
      }
    }
  }
}
</script>
