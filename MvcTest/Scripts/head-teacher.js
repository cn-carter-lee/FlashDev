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
    $("#btnAddAward").colorbox({ inline: true, href: $form, innerWidth: "400", innerHeight: "400" });
});