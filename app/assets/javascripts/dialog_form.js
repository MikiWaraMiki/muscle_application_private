$(function(){
    var dialog, form,
    weight        = $("#user_todo_weight"),
    set_count     = $("#user_todo_count"),
    complete_date = $("#user_todo_complete_date"),
    allFields     = $([]).add(complete_date).add(weight).add(set_count),
    tips          = $(".validateTips"),
    date_format   = 'yy-mm-dd';

    function updateTips(t){
        tips.text(t).addClass("ui-state-higlighted");
        setTimeout(function(){
            tips.removeClass( "ui-state-highlight", 1500 );
        }, 500 );
    }

    function weight_or_count_is_more_than_zero(o,n){
        var min = 0;
        if(o.val() < 0 || o.val()==""){
            o.addClass("ui-state-error");
            updateTips(n + "は０以上を入力してください");
            return false;
        }
        else{
            return true;
        }
    }
    dialog = $('#dialog-form').dialog({
        autoOpen: false,
        height: 500,
        width: 400,
        modal: true,
        buttons:{
            "ToDoを登録": function(){
                Rails.fire(form[0],'submit');
            },
            "閉じる":function(){
                dialog.dialog("close");
            }
        },
        close: function(){
            form[0].reset();
            allFields.removeClass("ui-state-error");
        }
    });

    form = dialog.find("form");
    // フォーム表示イベント
    $("#create-todo").on('click', function(){
        $("#dialog-form")
        event.preventDefault();
        dialog.dialog("open");
    });

    //Datetime Picker
    $('.date-picker').datepicker({
        dateFormat: date_format,
        minDate: new Date(),
        buttonImageOnly: false
    });
});