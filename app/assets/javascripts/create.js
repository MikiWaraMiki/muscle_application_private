function set_ajax(){
    var form = $(document);
    form.on("ajax:before", function(event){
        $("#ui-button").attr("disabled", true);
    });

    form.on("ajax:success", function(event){
        var data = event.detail[0].data;
        console.log(data);
        //Table 実装
        var append_html = "<tr><th>"+ data.clear_plan + "</th><th>"
        + data.title + "</th><th>"+data.weight+"</th><th>"+data.set_count 
        + "</th><th>"+'<a href="/todos/'+ data.id +'" class="btn btn-sm btn-primary" data-method="delete" data-remote="true">完了' +'</a></th></tr>';
        $("#todo-list").append(append_html);
        $('#dialog-form').dialog("close");
    });

    form.on("ajax:error", function(event){
        console.log("Failed");
    })

    form.on("ajax:complete", function(event){
        $("#ui-button").attr("disabled", false);
    })

}

$(document).on('turbolinks:load', set_ajax);