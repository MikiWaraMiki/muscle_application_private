function date_format(date_before_format){
    var year  = date_before_format.getFullYear();
    var month = date_before_format.getMonth()+1;
    var day   = date_before_format.getDate
    ();
    var format_str = year + "年" + month + "月" + day + "日";
    return format_str
}
function set_ajax(){
    var form = $(document);
    form.on("ajax:before", function(event){
        $("#ui-button").attr("disabled", true);
    });

    form.on("ajax:success", function(event){
        var data = event.detail[0].data;
        console.log(data);
        //日付変換
        formatted_date = date_format(new Date(data.clear_plan));
        //Table 実装
        var append_html = "<tr><th>"+ formatted_date + "</th><th>"
        + data.title + "</th><th>"+data.weight+"</th><th>"+data.set_count 
        + "</th><th>"+'<a href="/todos/'+ data.id +'" class="btn btn-sm btn-primary" data-method="delete" data-remote="true">完了' +'</a></th></tr>';
        $("#todo-list").append(append_html);
        $("#ui-button").attr("disabled", false);
        $("#errors").empty();
        $('#form-error').addClass('hide');
        $("#form-error").hide();
        $('#dialog-form').dialog("close");
    });

    form.on("ajax:error", function(event){
        $('#form-error').removeClass('hide').show();
        message = event.detail[0].errors;
        $.each(message, function(k,v){
            $('.alert-danger').append("Todoの保存に失敗しました");
            $('#errors').append("<li>" + v + "</li>");
        });
    });

    form.on("ajax:complete", function(event){
        
    });

}

$(document).on('turbolinks:load', set_ajax);