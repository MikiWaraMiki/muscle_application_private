import Vue  from 'vue/dist/vue.esm'
import Router from './router/router'
import store from './store/store.js'
import Header from './components/header.vue'
import Index from './components/index.vue'
import Footer from './components/footer.vue'
new Vue({
    el: "#app",
    store,
    router:Router,
    components: {
        'navbar': Header,
        'index': Index,
        'navbar-footer': Footer,
    }
});