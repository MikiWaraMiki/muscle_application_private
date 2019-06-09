<script>
    import { Pie } from 'vue-chartjs'
    import { truncate } from 'fs';
    export default {
        name: 'PieChart',
        extends: Pie,
        props: ['data', 'options'],
        mounted: function() {
            this.renderChart(this.data,this.options)
        },
        methods: {
            chart_update: function(data, options){
                this.renderChart(data,options);
            }
        },
        // データの変更を監視
 /*       watch: {
            data: {
                handler: function(){
                    this.renderChart(this.data, this.options)
                },
                deep: true
            },
        }*/
    }
</script>