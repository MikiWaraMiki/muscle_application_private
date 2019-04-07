function show_graph(){
    $.ajax({
        type: 'GET',
        url: '/show_graph',
        dataType: 'JSON',
        success: function(data){
            console.log(data);
            var context = document.getElementById('chart').getContext('2d');
            var color = [];
            for(var i=0; i < Object.keys(data.datas).length; i++){
                var o = Math.round, r = Math.random, s = 255;
                color.push('rgba(' + o(r()*s) + ',' + o(r()*s) + ',' + o(r()*s) + ',' + r().toFixed(1) + ')');
            }
            var myChart = new Chart(context, {
                type: 'pie',
                data:{
                    labels: Object.keys(data.datas),
                    //backgroundColor: color,
                    datasets:[{
                        data: Object.values(data.datas),
                        pointBackgroundColor: '#ffffff',
                        backgroundColor: color
                    }],
                },
                options:{
                    responsive: true,
                    maintainAsepectRatio: false,
                }
            })
            console.log(myChart.data.backgroundColor);
        }

    })
}
$(document).on('turbolinks:load', show_graph);