
function addTag(name) {
    $('<li>', { html: '<a href="javascript:void(0)" class="name">' + name + '</a> <a href="javascript:void(0)" class="remove" title="删除"  onclick="$(this).parent().remove()"></a>' }).appendTo($('.tag_list'));
}

var uri = '/api/StudentApi/GetTags';
function formatItem(item) {
    return item.TagName;
}
$(document).ready(function () {
    // tags
    $("#txtAddTag").focus(function () {
        $(this).removeClass('txt_bg')
    });


    $("#txtAddTag").blur(function () {
        if ($.trim(this.value) == "")
            $(this).addClass('txt_bg');
    });

    $("#btnAddTag").click(function () {
        var tagValue = $("#txtAddTag").val();
        if ($.trim(tagValue) == "") return;
        var tag = {
            Name: $("#txtAddTag").val()
        };

        $.ajax({
            url: "/api/StudentApi",
            data: JSON.stringify(tag),
            type: "POST",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                addTag(data.Name);
            }
        });
    });
    var apiUrl = "/api/StudentApi/GetTags";
    $.getJSON(apiUrl)
        .done(function (data) {
            $.each(data, function (key, item) {
                // Add a list item for the product.
                // $('<li>', { text: formatItem(item) }).appendTo($('#products'));
                addTag(item.Name);
            });
        });


    $(".tag_option_list").on('click', function (event) {
        if (event.target.nodeName == "LI") {
            var allListElements = $(this).find("li");
            addTag($(event.target).text());
            event.target.remove();
        }
        event.stopPropagation();
    });

    // stars
    $(".stars li img").mouseenter(function () {
        var src3 = "/images/star-3.png";
        $(this).attr("src", src3);
        $(this).prevAll().attr("src", src3);

        var src1 = "/images/star-1.png";
        $(this).nextAll().attr("src", src1);
    })
});
