<script>
    import { Pie } from 'vue-chartjs'
    export default {
        name: 'PieChart',
        extends: Pie,
        props: ['data', 'options'],
        mounted: function() {
            console.log(this.data)
            this.renderChart(this.data,this.options)
        },
        methods: {
            chart_data_update: function(){
                this.renderChart(this.data,this,options);
            }
        },
        // データの変更を監視
        watch: {
            data: function(val){
                console.log("watch!!")
                this.renderChart(this.data, this.options)
            },
            options: function(val){
                this.renderChart(this.data, this.options)
            }
        }
    }
</script>