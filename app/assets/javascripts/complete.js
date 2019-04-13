function complete_todo(){
    var completed_td_row = "";

   
    $("body").on("click","#complete-link", function(){
        completed_td_row = $(this).parent().parent()[0];
    });

    $("body").on("ajax:success","#complete-link", function(event){
        var data = event.detail[0].datas;
        var flash = event.detail[0].flash;
        //table行番号を取得
        completed_td_row.remove();
        //フラッシュメッセージの追加
        var flash_message = '<div class="alert alert-info alert-dismissible" role="alert">' + 
                            '<button type="button" class="close" data-dismiss="alert">'+
                            '<span aria-hidden="true">&times;</span>'+
                            '<span class="sr-only">close</span>'+
                            '</button>"'+
                            flash+
                            '</div>';
        //flush message
        $("#all-body").prepend(flash_message);
        //グラフのデータのみを更新
        if(myChart){
            myChart.destroy();
        }
        var context = document.getElementById('chart').getContext('2d');
        var color = [];
            for(var i=0; i < Object.keys(data).length; i++){
                var o = Math.round, r = Math.random, s = 255;
                color.push('rgba(' + o(r()*s) + ',' + o(r()*s) + ',' + o(r()*s) + ',' + r().toFixed(1) + ')');
            }
            myChart = new Chart(context, {
                type: 'pie',
                data:{
                    labels: Object.keys(data),
                    //backgroundColor: color,
                    datasets:[{
                        data: Object.values(data),
                        pointBackgroundColor: '#ffffff',
                        backgroundColor: color
                    }],
                },
                options:{
                    responsive: true,
                    maintainAsepectRatio: false,
                }
            })
    });

    $("body").on("ajax:error","#complete-link",function(){
        var error_messages = event.detail[0].errors;
        var flash = event.detail[0].flash
        //フラッシュメッセージの追加
        var flash_message = '<div class="alert alert-danger alert-dismissible" role="alert">' + 
                            '<button type="button" class="close" data-dismiss="alert">'+
                            '<span aria-hidden="true">&times;</span>'+
                            '<span class="sr-only">close</span>'+
                            '</button>"'+
                            flash+
                            '</div>';
        //flush message
        $(".content").prepend(flash_message);
    });

   
}
$(document).on('turbolinks:load', complete_todo);