<script>
import { Line } from  'vue-chartjs'
import { truncate } from 'fs'

export default {
    name: 'LineChart',
    extends: Line,
    props: [ 'data', 'options'],
    methods: {
        chart_update: function(data, options){
            console.log(data, options)
            this.renderChart(data, options)
        }
    }

}
</script>