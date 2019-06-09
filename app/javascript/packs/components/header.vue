<template>
        <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="header">
            <h1 class="navbar-brand">Muscle Todo!</h1>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="nav navbar-nav justify-content-end">
                    <li class="nav-item guest" v-if="isLogin">
                        <router-link to="/user" class="nav-link">User Page</router-link>
                    </li>
                    <li class="nav-item logedin" v-else>
                        <router-link to="/" class="nav-link">Home</router-link>
                    <li class="nav-item">
                        <router-link to="/timeline" class="nav-link">Timeline</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link to="/article" class="nav-link">Article</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link to="/contact" class="nav-link">Contact</router-link>
                    </li>
                    <li class="nav-item guest" v-if="isLogin">
                        <a v-on:click="logouts()" class="nav-link">Logout</a>
                    </li>
                    <li class="nav-item logedin" v-else>
                        <router-link to="/signin" class="nav-link">Login</router-link>
                    </li>
                </ul>
            </div>
        </nav>
    
</template>
<script>
import { mapState,mapActions } from 'vuex'
import store from '../store/store'
export default {
    computed: {
        ...mapState(['loggedIn']),
        isLogin: function(){
            //ページリロードされた場合も含めたログイン判定
            const token = localStorage.getItem('Token');
            if(!this.loggedIn && !token){
                return false;
            }
            return true;
        }
    },
    methods: {
        ...mapActions(['logout']),
        logouts: function(){
            this.logout({
                'router': this.$router
            })
        }
    }
}
</script>
<style lang="sass">
.fixed-top{
    background-color: #87cefa;
    .navbar-brand{
        letter-spacing: 1.1em;
        font-size: 1.2em;
        color: white !important;
    }
    ul.nav{
        width:100%;
        float: right
    }
    li.nav-item{
        margin-right: 20px;
        font-size: 1.1em;
        &:hover{
            color:white !important;
        }
        .nav-link{
            color: #ffffff;
        }
    }
}
</style>