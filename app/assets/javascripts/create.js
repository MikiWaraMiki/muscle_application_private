function set_ajax(){

    function date_format(date_before_format){
        var year  = date_before_format.getFullYear();
        var month = date_before_format.getMonth()+1;
        var day   = date_before_format.getDate
        ();
        var format_str = year + "年" + month + "月" + day + "日";
        return format_str
    }

    function create_complete_form(target_id){
        //ajaxで動的に追加したデータ用の
        var html = ""
    }
    
    $('body').on("ajax:before",'#new-todo' ,function(event){
        $("#ui-button").attr("disabled", true);
    });

    $("body").on("ajax:success","#new-todo", function(event){
        /*
        var data = event.detail[0].data;
        console.log(data);
        //日付変換
        formatted_date = date_format(new Date(data.clear_plan));
        //Table 実装
        var append_html = "<tr class='todo-column-" + data.id + "'><th>"+ formatted_date + "</th><th>"
        + data.title + "</th><th>"+data.weight+"</th><th>"+data.set_count 
        + '<th><button type="button" class="btn btn-sm btn-primary", data-toggle="modal" data-target="#modal-timeline-form">完了</button></th></tr>';
        $("#todo-list").append(append_html);
        $('#create-todo-form').modal('hide');
        */
        // ToDo APIで返すとボタンを追加できない。暫定対処でページリロード
        location.reload();
    });

    $('body').on("ajax:error",'#new-todo' ,function(event){
        $('#form-error').removeClass('hide').show();
        message = event.detail[0].errors;
        $.each(message, function(k,v){
            $('.alert-danger').append("Todoの保存に失敗しました");
            $('#errors').append("<li>" + v + "</li>");
        });
    });

    $('body').on("ajax:complete",'#new-todo' ,function(event){
        $("#ui-button").attr("disabled", false);
    });
    $('#datepicker-create').datepicker({
        dateFormat: date_format,
        minDate: new Date(),
        buttonImageOnly: false
    });
}

$(document).on('turbolinks:load', set_ajax);