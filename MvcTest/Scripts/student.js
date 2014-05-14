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
			"altContent", "550", "350", "10.0.0",
			"/falsh/expressInstall.swf",
            { "data-file": "flash.txt" },
			flashvars, params, attributes);


function getMyVar() {
    alert("AAAAA");
    return "/student.txt";
}

function getChartValues() {
    var v = '';
}
