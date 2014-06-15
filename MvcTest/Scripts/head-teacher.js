var flashvars = {
};
var params = {
    menu: "false",
    scale: "noScale",
    allowFullscreen: "true",
    allowScriptAccess: "always",
    bgcolor: "",
    wmode: "direct"
};

swfobject.embedSWF("/flash/Classroom.swf", "altContent", "650", "400", "10.0.0", "/falsh/expressInstall.swf", flashvars, params, { id: "Chart" });

function loadStudents() {
    return "/api/student";
}

function formatAwardEventTime(eventTime) {
    var arr = eventTime.split('T')[0].split('-')
    return arr[0] + '年' + arr[1] + '月' + arr[2] + '日';
}

function addAward(award) {
    $('<tr>', { html: '<td>' + ($.find('.awardList tbody tr').length + 1) + ' </td><td>' + (award.IsGood ? "奖" : "惩") + '</td><td>' + formatAwardEventTime(award.EventTime) + '</td><td>' + award.Content + '</td>' }).appendTo($('.awardList'));
}

$(document).ready(function () {
    var $form = $("#awardForm");
    $("#btnOpenAddAward").colorbox({ inline: true, href: $form, innerWidth: "400", innerHeight: "200", onComplete: function () { $('#awardForm').trigger("reset"); $('#awardForm input:first').focus(); } });
    $("#btnAddAward").click(function () {
        var award = {
            IsGood: ($form.find("input[name=IsGood]:checked").val() == "1"),
            Content: $form.find("textarea[name=Content]").val()
        };
        $.ajax({
            url: "/api/HeadTeacher",
            data: JSON.stringify(award),
            type: "POST",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                addAward(data);
                $(window).colorbox.close();
            }
        });
    });

    $("#btnClose").click(function () {
        $(window).colorbox.close();
    });
});

