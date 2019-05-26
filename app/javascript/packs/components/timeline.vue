<template>
    <div class="container">
        <div class="row my-2">
            <div class="col-md-4 col-12 my-2" id="sidebar">
                
            </div>
            <div class="col-md-8 col-12 my-2" id="timeline">
                <div>
                    <h3>みんなのタイムライン</h3>
                </div>
                <div v-if="timelines.length">
                    <div  class='row my-2 border-bottom border-dark' v-for="(timeline) in timelines" :key="timeline.id">
                        <div class="col-2">
                            {{ timeline.user.name }}
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
export default {
    components: {
        'infinite-loading': InfiniteLoading
    },
    data: function() {
        return {
            timelines: [],
            page: 1,
            isLoading: true,
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
        }
    },
    methods: {
        infiniteHandler($state){
            var options = {
                params:{
                    auth: true,
                    page: this.page,
                }
            }
            request.get('/api/v1/post', options).then( (response) => {
                //データがある場合
                console.log(response.data)
                if(response.data.length){
                    this.page += 1;
                    this.timelines.push(...response.data);
                    $state.loaded()
                } else{
                    console.log($state)
                    $state.complete();
                }
            }, (error) => {
                console.log("取得失敗");
                $state.complete();
            })
        }
    }
}
</script>
