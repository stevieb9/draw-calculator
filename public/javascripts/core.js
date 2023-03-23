"use strict";

$(document).ready(function(){
    $(".needed").on("change input", function(){
        render();
    });

    render();
});

function render () {
    var render_params = {
        "monthly_draw": $('#monthly_draw').val(),
        "return_rate":  $('#return_rate').val(),
        "account_balance": $('#account_balance').val()
    };

    $.ajax({
        async: true,
        type: 'POST',
        url: '/render',
        data: JSON.stringify(render_params),
        success: function (json_data) {
            var data = $.parseJSON(json_data);

            $("#years").text(data['years']);

            $("#years_table > tbody").empty();

            jQuery.each(data["year_data"], function (index, year) {
//                $("#years_table tr:last").after(
                  $("#years_table tbody").append(
                    "<tr>" +
                    "<td>" + index + "</td>" +
                    "<td>" + year["revenue"] + "</td>" +
                    "<td>" + year["balance"] + "</td>" +
                    "</tr>"
                );
            });
        }
    });


}
