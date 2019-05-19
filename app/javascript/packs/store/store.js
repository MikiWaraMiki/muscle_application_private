import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import request from '../utils/request.js'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        loggedIn: false
    },
    mutations: {
        login(state, token){
            localStorage.setItem('Token', token);
            state.loggedIn = true;
        },
        logout(state, token){
            localStorage.removeItem('Token', token);
            state.loggedIn = false;
        }
    },
    actions: {
        signup( {commit}, payload) {
            const options = {
                params: {
                    name: payload.payload.name,
                    email: payload.payload.email,
                    password: payload.payload.password,
                    password_confirmation: payload.payload.password_confirmation
                }
            };
            request.post('/api/v1/auth', options).then( (response) => {
                // 登録が完了したらトークンを発行
                commit('login', response.data.token)
                payload.router.push('/user')
            }, (error) => {
                console.log("登録が失敗")
            });
        },
        login( {commit}, payload) {
            const options = {
                params: {
                    email: payload.payload.email,
                    password: payload.payload.password
                }
            };
            request.post('/api/v1/auth/sign_in', options).then( (response) => {
                commit('login', response.data.token);
                //indexへ遷移
                payload.router.push('/user');
            }, (error) => {
                console.log("ログインに失敗");
            });
        },
        logout( {commit}, payalod){
            request.delete('/api/v1/auth/logout', { auth: true}).then( (response) => {
                commit('logout');
            }, (error) => {
                console.log("ログアウトに失敗");
            });
            // indexへリダイレクト
            location.href("/");
        }
    }

})