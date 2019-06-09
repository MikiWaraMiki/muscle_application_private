<template>
    <div class="container">
        <div class="row my-2">
            <div class="col-12 col-lg-4  my-2" id="sidebar">
                <div class="login-user card" id="user-info" v-if="user!==''">
                    <img class="card-img-top text-center" src="/assets/avatar.png" id="icon" alt="User Icon">
                    <div class="card-body">
                        <h5>{{ user.user.name}}</h5>
                        <div class="list-group">
                            <div>
                                <small>投稿数</small>
                                <a class="list-group-item">{{ user.post.length }}</a>
                            </div>
                            <div>
                                <small>フォロワー数</small>
                                <a class="list-group-item">{{ user.followers.length}}</a>
                            </div>
                            <div>
                                <small>フォロー数</small>
                                <a class="list-group-item">{{ user.followings.length}}</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="guest-user border border-primary py-3 px-3" id="user-info" v-if="user===''">
                    <h5>ユーザ登録すると投稿ができるようになります</h5>
                    <router-link to="/signup" class="btn btn-primary mr-3">ユーザ登録する</router-link>
                    <router-link to="/signin" class="btn btn-primary mr-3">ログインする</router-link>
                </div>
            </div>
            <div class="col-12 col-lg-8  my-2" id="timeline">
                <div>
                    <h3>みんなのタイムライン</h3>
                </div>
                <div v-if="timelines.length">
                    <div  class='row my-2 border-bottom border-dark' v-for="(timeline) in timelines" :key="timeline.id">
                        <div class="col-2">
                            {{ timeline.user.name }}
                            <div class="button-list" v-if=" isLogin && timeline.user.id !== user.user.id">
                                <button class="btn-sm btn-primary my-2" @click="followAction(timeline.user.id)" v-if="!isFollowing(timeline.user)  ">Follow</button>
                                <button class="btn-sm btn-info my-2" @click="unFollowAction(timeline.user.id)" v-else>Unfollow</button>
                            </div>
                        </div>
                        <div class="col-9">
                            <p>{{ timeFormat(timeline.created_at) }}</p>
                            <table class="table">
                                <tr>
                                    <th>Menu</th>
                                    <td>{{timeline.todo.title}}</td>
                                </tr>
                                <tr>
                                    <th>Weight</th>
                                    <td>{{ timeline.todo.weight }} </td>
                                </tr>
                                <tr>
                                    <th>Set Count</th>
                                    <td>{{ timeline.todo.set_count }} </td>
                                </tr>
                                <tr>
                                    <th>Comment</th>
                                    <td>{{ timeline.comment }} </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <infinite-loading @infinite="infiniteHandler"></infinite-loading>
    </div>
</template>
<script>
import request from '../utils/request.js'
import InfiniteLoading from 'vue-infinite-loading'
import { mapState } from 'vuex'
import store from '../store/store'
import followAction from '../mixins/followaction'
import followaction from '../mixins/followaction';
export default {
    components: {
        'infinite-loading': InfiniteLoading
    },
   
    data: function() {
        return {
            timelines: [],
            user:{
                user: '',
                post: [],
                followings: [],
                followers: [] 
            },
            page: 1,
            isLoading: true,
        }
    },
    mixins: [followAction],
    created(){
        // localStorageから取得
        const token       = localStorage.getItem('Token');
        const login_flg   = false
        // Tokenが付与されている場合
        if(token){
            this.getUserInfo()
        }
        //ユーザ情報取得の失敗もしくはtokenが付与されていない
        if(token === '' || !login_flg ){
            //Guestユーザの表示
            this.user = {
                user: {
                    id: 0,
                    name: 'Guest User',
                },
                post: 0,
                followers: [],
                followings: []
            }
        }
    },
    mounted() {
 //       this.infiniteHandler($state);
        this.$nextTick(function () {
            this.isLoading = false;
        });
    },
    computed: {
        timeFormat: function(){
            const self = this;
            return function(date_not_formated){
                const not_format_day   = new Date(date_not_formated);
                const year    = not_format_day.getFullYear();
                const month   = not_format_day.getMonth()+1;
                const day     = not_format_day.getDate();
                return `${year}/${month}/${day}`
            }
        },
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
        isFollowing(target_user){
            const following  = this.user.followings.some(user => user.id === target_user.id)
            console.log(target_user)
            console.log(following)
            return following
        },
        infiniteHandler($state){
            var options = {
                params:{
                    page: this.page,
                }
            }
            request.get('/api/v1/post', options).then( (response) => {
                //データがある場合
                if(response.data.length){
                    this.page += 1;
                    this.timelines.push(...response.data);
                    $state.loaded()
                } else{
                    $state.complete();
                }
            }, (error) => {
                console.log("取得失敗");
                $state.complete();
            })
        },
        getUserInfo: function(){
            var options = {
                auth:true,
            }
            request.get('/api/v1/user/own', options).then( (response) => {
                //データを格納
                this.user = {
                    user: response.data.user,
                    post: response.data.posts,
                    followers: response.data.follower,
                    followings: response.data.following
                }
                console.log(this.user)
            })
        },
        followAction: function(user_id){
            this.followUser(user_id)
            //if(follow_user){
                //フォロー済みユーザとし配列に登録
            //    this.user.followings.push(follow_user)
            //}
            console.log(this.user.followings)
        },
        unFollowAction: function(user_id){
            this.unFollowUser(user_id)
            this.user.followings.pop();
        }
    }
}
</script>
<style lang="scss" scoped>
    #icon{
        width: 120px;
        height: 120px;
        margin: 0 auto;
    }
</style>
