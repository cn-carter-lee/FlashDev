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
			"/flash/Chart.swf",
			"altContent", "550", "350", "10.0.0",
			"falsh/expressInstall.swf",
            { "data-file": "flash.txt" },
			flashvars, params, attributes);

jQuery(document).ready(function ($) {
    $('#lineContainer').perfectScrollbar();
});

function getMyVar() {
    return "/exams.txt";
}

function getChartValues() {
    var v = '';
}

