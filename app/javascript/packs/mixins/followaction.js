import request from '../utils/request.js'
export default{
    data: function(){
        return {
            follow_user: '',

        }
    },
    methods:{
        followUser: function(user_id){
            const options = {
                auth: true,
                params: {
                    user:{
                        user_id: user_id
                    }
                }
            };
            request.post('/api/v1/user/follow', options).then( (response) => {
                //followしたユーザ
                var follow_user = response.data.follow;
                this.user.followings.push(follow_user)
            }, (error) => {
                console.log("followに失敗しました");
            })
        },
        unFollowUser: function(user_id){
            const options = {
                auth: true,
                params: {
                    user:{
                        user_id: user_id
                    }
                }
            }
            request.delete('/api/v1/user/unfollow', options).then( (response) => {
                // followを外したユーザー
                const unfollow_user = response.data.unfollow;
                return unfollow_user
            }, (error) => {
                console.log("followから外せませんでした")
            })
        }
    }
}