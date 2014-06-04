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


$(document).ready(function () {
    var $form = $("#awardForm");
    $("#btnOpenAddAward").colorbox({ inline: true, href: $form, innerWidth: "400", innerHeight: "400" });
    $("#btnAddAward").click(function () {

        // $(window).colorbox.close();


        var awardValue = $("#awardForm").val();
        if ($.trim(tagValue) == "") return;
        var award = {
            TypeId: 0,
            Content: ""
        };

        $.ajax({
            url: "/api/HeadTeacherApi",
            data: JSON.stringify(tag),
            type: "POST",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                // addTag(data.Name);
                var parentWindow = window.parent;
                parentWindow.$.colorbox.close();
            }
        });
    });

    $("#btnClose").click(function () {
        $(window).colorbox.close();
    });

});

