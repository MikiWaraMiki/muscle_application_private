<template>
    <div>
        <div class="col-md-12 col-sm-12 my-3">
            <h1>Welcome</h1>
        </div>
        <div id="modal-form" class="col-sm-12 col-md-12">
            <button class="btn-sm btn-primary my-2 mx-2" data-toggle="modal" data-target="#create-todo-form">登録する</button>
            <div class="modal fade" id="create-todo-form" tabindex="-1" role="dialog" aria-labelledby="label1" aria-hidden="true">
                <div class="modal-dialog" role="document" >
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="label1">タスクをShare!!</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="alert alert-danger error_mes" role="alert" v-if="errors.length">
                                <ul id="error">
                                    <li v-for="(error,index) in errors" :key='index' >{{error}}</li>
                                </ul>
                            </div>
                            <label for='title'>メニュー</label>
                            <input type='text' id='title' v-model="todo.title" placeholder="メニューを入力">
                            <label for="weight">ウェイト</label>
                            <input type="num" id='weight' v-model="todo.weight" placeholder='重さを入力'>
                            <label for="set-count">セット数</label>
                            <input type='num' id="set-count" v-model="todo.set_count" placeholeder="セット数を入力">
                            <label for="clear_plan">完了予定日</label>
                            <vuejs-datepicker id="clear_plan" :format="dateFomtter" v-model="todo.clear_plan"></vuejs-datepicker>
                            <button type="button" v-on:click="todoRegisterForm" class="btn-sm btn-primary text-center">ToDoに追加</button>
                        </div>
                        <div class="modal-footer">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="task-table" class="col-sm-12 col-md-12">
            <div class="alert alert-info" v-if="success_mes">
                <p>{{ success_mes }}</p>
            </div>
            <table class='table table-striped' id='todo-table'>
                <thead>
                    <tr>
                        <th>予定日</th>
                        <th>メニュー</th>
                        <th>重量</th>
                        <th>セット数</th>
                        <th>完了</th>
                    </tr>
                </thead>
                <tbody v-if="todos.length">
                    <tr v-for="todo in todos"  v-bind:key="todo.id" id="todo-column">
                            <th>{{todo.clear_plan | date_to_ja}}</th>
                            <th>{{todo.title}}</th>
                            <th>{{todo.weight}}</th>
                            <th>{{todo.set_count}}</th>
                            <th><button @click="showModalForm($event,todo)" :id="'todo'+todo.id" class="btn-sm btn-primary">完了</button></th>
                    </tr>
                </tbody>
            </table>
            <todocompleteform  v-bind:errors="errors" @close="closeModal" v-if="showModal">
                <template slot='complete_form'>
                    <div class="alert alert-danger" v-if="errors.length">
                        <ul>
                            <li v-for="(error,index) in errors" v-bind:key=index>
                                {{ error }}
                            </li>
                        </ul>
                    </div>
                    <h4>{{ completeTodo.title }}</h4>
                    <p>{{ completeTodo.weight }} Kg</p>
                    <p> {{ completeTodo.set_count }}セット</p>
                    <label for="clear-date">完了日</label>
                    <vuejs-datepicker id="clear_date" :format="dateFomtter" :inline="true"></vuejs-datepicker>
                    <label for='comment'>コメント</label>
                    <input type="text" name="comment">
                </template>
                <template slot='footer'>
                    <button @click="closeModal" class="btn-sm btn-primary">閉じる</button>
                    <button @click="doComplete" class="btn-sm btn-primary">投稿</button>
                </template>
            </todocompleteform>
        </div>
        <div id="graph" class="col-sm-12 col-md-12">
            <h3>実施トレーニングの内訳</h3>
            <piechart :data="chartData" :options="chartOptions"></piechart>
        </div>
    </div>
</template>
<script>
import Vue from 'vue'
import {mapState, mapActions} from 'vuex'
import request from '../utils/request.js'
import PieChart from './PieChart.vue'
import DatePicker from 'vuejs-datepicker'
import TodoModalForm from './todocomplete.vue'
import { constants } from 'crypto';
export default {
    name: "userIndex",
    data: function(){
        return {
            completeTodo:{
                id: '',
                title:'',
                weight: '',
                set_count: '',
                clear_plan: '',
                clear_date: '',
            },
            todo: {
                title: '',
                weight: 1,
                set_count: 1,
                clear_plan: '',
            },
            todos: [],
            errors: [],
            success_mes: "",
            // chart用data
            chartData: {
                labels: [],
                datasets: [{
                    data: [],
                    backgroundColor: []
                }],
            },
            chartOptions: {
                responsive: true,
                maintainAsepecRatio: false,
            },
            showModal: false
        }
    },
    created (){
        this.getTodo()
    },
    methods: {
        getTodo: function (){
            var options = {
                auth: true
            }
            //APIへアクセス
            request.get('/api/v1/user',options).then( (response) => {
                this.todos = response.data.todos
                //グラフ描画データの作成
                this.createChartData(response.data.graphdata)
                console.log(this.chartData)
            }, (error)=>{
                console.log("取得に失敗")
            })
        },
        dateFomtter: function (date){
            var before_format_date = new Date(date);
            const y = before_format_date.getFullYear();
            const m = before_format_date.getMonth()+1;
            const d = before_format_date.getDate();
            return `${y}-${m}-${d}`;
        },
        createChartData: function(datas){
            console.log("create chart data")
            this.chartData.labels = Object.keys(datas);
            for(var value of Object.values(datas)){
                this.chartData.datasets[0].data.push(value);
                this.chartData.datasets[0].backgroundColor.push(this.createRandomColor())
            }
        },
        createRandomColor: function(){
           var o = Math.round;
           var r = Math.random;
           var s = 255;
           var color = `rgba(${o(r()*s)},${o(r()*s)},${o(r()*s)},${r().toFixed(1)})`
           return color
        },
        todoRegisterForm: function(){
            //Todoの登録
            var options = {
                params:{
                    todo:{
                        title: this.todo.title,
                        weight: this.todo.weight,
                        set_count: this.todo.set_count,
                        clear_plan: this.todo.clear_plan
                    }
                },
                auth: true
            };
            //APIからデータを取得
            request.post('/api/v1/todo',options).then( (response) => {
                // データを追加
                this.todos.push(response.data.data)
                // エラーメッセージがあれば削除
                this.errors = []
                //成功メッセージを追加
                this.success_mes = "Todoを登録しました"
            }, (error) => {
                //成功メッセージを空にする
                this.success_mes = ""
                //エラーメッセージを表示
                this.errors = error.response.data.errors
            })
        },
        showModalForm: function(event,todo){
            this.completeTodo.id         = todo.id 
            this.completeTodo.title      = todo.title
            this.completeTodo.weight     = todo.weight
            this.completeTodo.set_count  = todo.set_count
            this.completeTodo.clear_plan = todo.clear_plan
            this.showModal     = true
            console.log(this.completeTodo)
        },
        closeModal: function(){
            this.showModal = false;
        },
        doComplete: function(){
            var options = {
                params:{
                    post:{
                        todos_id: this.completeTodo.id,
                        comment: this.completeTodo.comment
                    },
                    todo:{
                        clear_date: this.completeTodo.clear_date
                    }
                },
                auth: true
            }
            // post request
            request.post('/api/v1/post',options).then( (response) => {
                // テーブルからデータを削除
                const id    = this.completeTodo.id;
                const index = this.todos.findIndex( (v) => v.id === id);
                this.todos.splice(index,1);
                this.success_mes = "投稿が完了しました";
                // modal formを閉じる
                this.closeModal()
                /* Todo*/
                /* Chartjsのデータを更新*/
                this.getTodo()
            }, (error) => {
                //成功メッセージを空にする
                this.success_mes = "";
                console.log("error");
            })
        },
    },
    filters: {
        date_to_ja: function(str_date){
            const date = new Date(str_date)
            const y = date.getFullYear()
            const m = date.getMonth()+1
            const d = date.getDate()
            return `${y}年${m}月${d}日`
        }
    },
    components: {
        'piechart': PieChart,
        'vuejs-datepicker': DatePicker,
        'todocompleteform': TodoModalForm
    }, 
}
</script>
<style>
#pie-chart {
    max-width: 500px;
    margin: 0 auto;
}
</style>