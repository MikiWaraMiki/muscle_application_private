<template>
    <div>
        <div class="row col-12 my-3" id="user-profile">
            <div class="col-3 col-lg-3 my-3 text-center">
                <img class="text-center" src="/assets/avatar.png" id="icon" alt="User Icon">
            </div>
            <div class="col-12 col-lg-9 my-3">
                <div class="border-bottom my-2 border-light">
                    <h3>{{ user }}</h3>
                </div>
                <div class="border-bottom my-2 border-light">
                    <h4>Todo:{{ calc_todo }}個</h4>
                </div> 
                <div class="my-2">
                    <router-link to="/user/edit" class="btn-sm btn-primary">ユーザ情報を編集</router-link>
                </div>
            </div>
        </div>
        <div id="modal-form" class="col-sm-12 col-md-12">
            <h3>ToDo一覧</h3>
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
                    <vuejs-datepicker v-model="completeTodo.clear_date" id="clear_date" :format="dateFomtter" :inline="true"></vuejs-datepicker>
                    <label for='comment'>コメント</label>
                    <input type="text" name="comment" v-model="completeTodo.comment">
                </template>
                <template slot='footer'>
                    <button @click="closeModal" class="btn-sm btn-primary">閉じる</button>
                    <button @click="doComplete" class="btn-sm btn-primary">投稿</button>
                </template>
            </todocompleteform>
        </div>
        <div id="graph" class="col-sm-12 col-md-12">
            <h3>実施トレーニングの内訳</h3>
            <select class="form-control" name="category" v-model="selectedCategory" @change="onChange">
                <option v-for="category in graphCategory" v-bind:value="category.id" v-bind:key="category.name">
                    {{ category.name}}
                </option>
            </select>
            <div v-if="selectedCategory==1" id="piechart">
                <piechart ref="chart" :data="chartData" :options="chartOptions"></piechart>
            </div>
            <div v-else-if="selectedCategory==2 || selectedCategory == 3" id="weight-line-chart">
                <linechart ref="linechart" :data="chartData" :options="chartOptions"></linechart>
            </div>
        </div>
    </div>
</template>
<script>
import Vue from 'vue'
import {mapState, mapActions} from 'vuex'
import request from '../utils/request.js'
import PieChart from './PieChart.vue'
import LineChart from './LineChart.vue'
import DatePicker from 'vuejs-datepicker'
import TodoModalForm from './todocomplete.vue'
import { constants } from 'crypto';
export default {
    name: "userIndex",
    data: function(){
        return {
            user: "Guest",
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
            showModal: false,
            selectedCategory: 1,
            graphCategory: [
                {id:1, name:"トレーニング内訳"},
                {id:2, name:"重さ推移"},
                {id:3, name:"セット数推移"}
            ]
        }
    },
    created (){
        this.getTodo()
    },
    computed: {
        calc_todo: function(){
            return this.todos.length;
        },
        calc_complete_todo: function(){
            return this.chartData.datasets[0].data.reduce((total, num) => total+= num, 0);
        }
    },
    methods: {
        getTodo: function (){
            var options = {
                auth: true
            }
            //APIへアクセス
            request.get('/api/v1/user',options).then( (response) => {
                this.todos = response.data.todos
                this.user  = response.data.user
                //グラフ描画データの作成
                this.createPieChartData(response.data.graphdata)
            }, (error)=>{
                console.log("取得に失敗")
            })
        },
        onChange: function(){
            console.log("change");
            console.log(this.selectedCategory)
            switch(this.selectedCategory){
                case 1:
                    //円グラフデータを取得
                    this.setPieChartData();
                    break;
                case 2:
                    //折れ線グラフを取得
                    this.setWeightLineData();
                    break;
                case 3:
                    //折れ線データを取得
                    this.setSetCountLineData();
                    break;
            }
        },
        setPieChartData: function(){
            //データを取得
            const options = {
                auth: true
            }
            request.get('/api/v1/user/graph/pie', options).then( (response) => {
                this.chartData = {
                    labels: [],
                    datasets: [{
                        data: [],
                        backgroundColor: []
                    }]
                }
                this.chartOptions = {
                    responsive: true,
                    maintainAsepecRatio: false,
                }
                this.createPieChartData(response.data.graphdata)
                this.$refs.chart.chart_update(this.chartData, this.chartOptions)
            }, (error) => {
                console.log("this access is error")
            })
        },
        setWeightLineData: function(){
            const options = {
                auth: true
            }
            request.get('/api/v1/user/graph/lineweight', options).then( (response) => {
                //chartデータ更新
                this.chartData = {
                    datasets: response.data.graphdata
                }
                this.chartOptions.scales = {
                    xAxes: [{
                        type: "time",
                        time:{
                            displayFormat: "MM/DD"
                        },
                        ticks: {
                            source: 'data'
                        },
                        distribution: "series"
                    }]
                }
                console.log("call child component methods")
                this.$refs.linechart.chart_update(this.chartData, this.chartOptions)
            }, (error) => {
                console.log("this access is error")
            })
        },
        setSetCountLineData: function(){
            const options = {
                auth: true
            }
            request.get('/api/v1/user/graph/linecount', options).then( (response) => {
                this.chartData = {
                    datasets: response.data.graphdata
                }
                this.chartOptions.scales = {
                    xAxes: [{
                        type: "time",
                        time:{
                            displayFormat: "MM/DD"
                        },
                        ticks: {
                            source: 'data'
                        },
                        distribution: "series"
                    }]
                }
                this.$refs.linechart.chart_update(this.chartData, this.chartOptions)
            }, (error) => {
                console.log("this access is error")
            })
        },
        dateFomtter: function (date){
            var before_format_date = new Date(date);
            const y = before_format_date.getFullYear();
            const m = before_format_date.getMonth()+1;
            const d = before_format_date.getDate();
            return `${y}-${m}-${d}`;
        },
        createPieChartData: function(datas){
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
                
                /* Chartjsのデータを更新*/
                const complete_todo = response.data.todo
                const exist_todo_index = this.chartData.labels.indexOf(complete_todo.title)
                if(exist_todo_index >= 0){
                    // データを加算
                    const before_count = this.chartData.data[0].data[exist_todo_index]
                    this.chartData.datasets[0].data[exist_todo_index] = before_count + 1;
                }
                //データが存在しない場合
                else{
                    this.chartData.labels.push(complete_todo.title)
                    this.chartData.datasets[0].data.push(1)
                }
                // グラフの再描画
                this.$refs.chart.chart_data_update()
                console.log(this.chartData)
            }, (error) => {
                //成功メッセージを空にする
                this.success_mes = "";
                console.log("error");
            })
        },
        changeGraph: function(){
            //
        }
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
        'linechart': LineChart,
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