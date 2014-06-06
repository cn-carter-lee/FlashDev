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
var attributes = {
    id: "Chart"
};
swfobject.embedSWF(
			"/flash/Classroom.swf",
			"altContent", "650", "400", "10.0.0",
			"/falsh/expressInstall.swf",
            { "data-file": "flash.txt" },
			flashvars, params, attributes);


function getMyVar() {
    return "/datafile/student.txt";
}

function addAward(award) {
    $('<tr>', { html: '<td>' + ($.find('.awardList tbody tr').length + 1) + ' </td><td>' + (award.TypeId ? "奖" : "惩") + '</td><td>' + award.EventTime + '</td><td>' + award.Content + '</td>' }).appendTo($('.awardList'));
}

$(document).ready(function () {
    var $form = $("#awardForm");
    $("#btnOpenAddAward").colorbox({ inline: true, href: $form, innerWidth: "400", innerHeight: "200", onComplete: function () { $('#awardForm').trigger("reset"); $('#awardForm input:first').focus(); } });
    $("#btnAddAward").click(function () {
        var award = {
            TypeId: $form.find("input[name=TypeId]:checked").val(),
            Content: $form.find("textarea[name=Content]").val()
        };
        $.ajax({
            url: "/api/HeadTeacherApi",
            data: JSON.stringify(award),
            type: "POST",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                addAward(data);
                var parentWindow = window.parent;
                parentWindow.$.colorbox.close();
                // $(window).colorbox.close();
            }
        });
    });

    $("#btnClose").click(function () {
        $(window).colorbox.close();
    });
});

