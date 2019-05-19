import Vue  from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import Index from '../components/index.vue'
import Contact from '../components/contact.vue'
import Timeline from '../components/timeline.vue'
import Signup from '../components/signup.vue'
import SignIn from '../components/signin.vue'
import UserTop from '../components/user_top.vue'
Vue.use(VueRouter)

export default new VueRouter({
    mode: 'history',
    routes:[
        { path: '/', component: Index},
        { path: '/contact', component: Contact},
        { path: '/timeline', component: Timeline},
        { path: '/signup', component:Signup},
        { path: '/signin', component:SignIn},
        { path: '/user', component:UserTop, meta:{ requireAuth: true }}
    ]
})


