
import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from "axios";
import vuetify from "./plugins/vuetify";
import VueDraggableResizable from "vue-draggable-resizable";
import "vue-draggable-resizable/dist/VueDraggableResizable.css";

import { io } from 'socket.io-client'
import VueSocketIO from 'vue-socket.io-extended'
const socket = io.connect('http://127.0.0.1:3010/manager', { transports : ['websocket'] });

Vue.use(VueSocketIO, socket);
Vue.config.productionTip = false;

new Vue({
  router,
  store,
  axios,
  vuetify,
  VueDraggableResizable,
  sockets: {
    connect() {
      console.log('socket connected')
    },
    doom_get_in(data) {
      console.log(data);
    }
  },

  render: (h) => h(App),
}).$mount("#app");