import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

axios.defaults.headers.common['X-CSRF-TOKEN'] = document.querySelector(
    'meta[name="csrf-token"]').getAttribute('content')

var BASE_URL = ''
if (window.environment === 'development') {
  BASE_URL = 'http://localhost:3002'
} else if (window.environment === 'production') {
  BASE_URL = 'https://www.kitboxer.com'
}

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    product: {},
    tutorial: {},
    steps: [],
  },
  actions: {
    UPLOAD_IMAGE: function({ commit }, { product, image, step }) {
      const url = `${BASE_URL}/products/${product.id}/tutorial/images`
      const formData = new FormData()
      formData.append('image[image]', image)
      formData.append('image[step_id]', step.id)
      return axios.post(url, formData)
                  .then(response => {
                    commit('SET_IMAGE',
                        { step: step, image: response.data })
                  })
                  .catch((error) => {
                    console.log(error)
                  })
    },
  },
  mutations: {
    SET_INITIAL_STATE: (state, { props }) => {
      state.product = props.product.product
      state.tutorial = props.tutorial.tutorial
    },
    SET_IMAGE: (state, { step, image }) => {
      let stepIndex = state.tutorial.steps.indexOf(step)
      state.tutorial.steps[stepIndex].images.push(image)
    },
  },

  getters: {
    product: state => state.product,
    tutorial: state => state.tutorial,
    steps: state => state.tutorial.steps,
  },
})

export default store