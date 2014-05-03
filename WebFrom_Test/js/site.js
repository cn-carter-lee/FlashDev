//
function selectColumn(num) {
    var o = 'table.score-analysis td:nth-child(' + (parseInt(num) + 4) + ')';
    $(o).addClass('highlight');
}
function unselectColumn(num) {
    var o = 'table.score-analysis td:nth-child(' + (parseInt(num) + 4) + ')';
    $(o).removeClass('highlight');
}

function addOverLay() {
    var over = '<div id="overlay"><img id="loading" src="/images/loading.gif"></div>';
    $(over).appendTo('body');
}
function removeOverLay() {
    $('#overlay').remove();
}

// print
function printChart(fileName) {
    removeOverLay();
    var printWindow = window.open('', '', 'height=400,width=800');
    printWindow.document.write('<html><head><title></title>');
    printWindow.document.write('</head><body >');
    printWindow.document.write('<img style="width:700px;margin-left:50px;" src="' + fileName + '" />');
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    setTimeout(function () {
        printWindow.print();
    }, 500);
    return false;
}

function printPanel() {
    var panel = document.getElementById("altContent");
    var printWindow = window.open('', '', 'height=400,width=800');
    printWindow.document.write('<html><head><title>DIV Contents</title>');
    printWindow.document.write('</head><body >');
    printWindow.document.write(panel.innerHTML);
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    setTimeout(function () {
        printWindow.print();
    }, 500);
    return false;
}


// select menu
function DropDown(el) {
    this.dd = el;
    this.initEvents();
}

DropDown.prototype = {
    initEvents: function () {
        var obj = this;
        obj.dd.on('mouseover', function (event) {
            $(this).toggleClass('active');
            $($(this).find('.select-menu')[0]).attr('class', 'select-menu-over');
            event.stopPropagation();
        });

        obj.dd.on('mouseout', function (event) {
            $('.wrapper').removeClass('active');
            $($(this).find('.select-menu-over')[0]).attr('class', 'select-menu');
            event.stopPropagation();
        });

        obj.dd.on('click', function (event) {
            if (event.target.nodeName == "LI") {
                var allListElements = $(this).find("li");
                $.each(allListElements, function (index, value) {
                    $(value).attr("class", "");
                });
                $(event.target).attr('class', "selected");
                $($(this).find("b")).text($(event.target).text());
            }
            event.stopPropagation();
        });
    }
}

$(function () {
    new DropDown($('#dd'));
    new DropDown($('#dd2'));
});

$(document).ready(function () {
    var $toolTip = null;
    var events = [{ id: 1, name: "Wonderful", left: 50 }, { id: 2, name: "Wonderful", left: 150 }, { id: 3, name: "Wonderful", left: 1450}];
    function getId(str) {
        return str.substring(str.indexOf('_') + 1);
    }
    for (var i = 0; i < events.length; i++) {
        var $retHtml = $('<div id=marker_' + events[i].id + ' style="left: ' + events[i].left + 'px;" class="marker">').data('event', events[i]);
        $retHtml.mouseover(
                function (e) {
                    var $t = $(e.target);
                    $t.attr('class', "markerhover");
                    $toolTip = $('<div class="e-message" id="tooltip_' + getId(e.target.id) + '" style="left:' + $t.css('left') + '">' +
                        '<div class="message-pointer"></div>' +
                        '<div class="msg" id="msg_1">2013届初三中考一摸</div>' +
                        '</div>');
                    $('#eventline').append($toolTip);
                });
        $retHtml.mouseleave(
                function (e) {
                    var $t = $(e.target);
                    $t.attr('class', "marker");
                    if ($toolTip) $toolTip.remove();
                });
        $('#eventline').append($retHtml);
        var $markerText = '</div><div style="left:' + (events[i].left - 5) + 'px;" class="marker-tip">3月28日</div>';
        $('#eventline').append($markerText);
    }
    var data = [{ Number: "201100104", Name: "吴峻汶", Class: "一班", Level: "A", Score: 19 },
    { Number: "201100113", Name: "徐子杰", Class: "一班", Level: "A", Score: 26 },
    { Number: "201100120", Name: "叶欣莹", Class: "一班", Level: "A", Score: 30 },
    { Number: "201100108", Name: "陈俊超", Class: "一班", Level: "A", Score: 33 },
    { Number: "201100123", Name: "吴婉婷", Class: "一班", Level: "A", Score: 43 },
    { Number: "201100121", Name: "伍珮莹", Class: "一班", Level: "A", Score: 47 },
    { Number: "201100103", Name: "刘海峻", Class: "一班", Level: "A", Score: 50 },
    { Number: "201100132", Name: "居卓婷", Class: "一班", Level: "A", Score: 51 },
    { Number: "201100105", Name: "张越", Class: "一班", Level: "A", Score: 52 },
    { Number: "201100126", Name: "李诗桦", Class: "一班", Level: "A", Score: 53 },
    { Number: "201100138", Name: "郭诗琪", Class: "一班", Level: "A", Score: 54 },
    { Number: "201100136", Name: "赵艳薇", Class: "一班", Level: "A", Score: 55 },
    { Number: "201100107", Name: "邵锦泉", Class: "一班", Level: "A", Score: 56 },
    { Number: "201100106", Name: "杨子豪", Class: "一班", Level: "A", Score: 63 },
    { Number: "201100109", Name: "陈诺恒", Class: "一班", Level: "A", Score: 64 },
    { Number: "201100117", Name: "黄梓俊", Class: "一班", Level: "A", Score: 64 },
    { Number: "201100128", Name: "李颖彤", Class: "一班", Level: "A", Score: 65 },
    { Number: "201100119", Name: "戴壮壮", Class: "一班", Level: "A", Score: 68 },
    { Number: "201100115", Name: "梁梓瀚", Class: "一班", Level: "A", Score: 69 },
    { Number: "201100116", Name: "梁嘉辉", Class: "一班", Level: "A", Score: 69 },
    { Number: "201100114", Name: "梁峻轩", Class: "一班", Level: "A", Score: 71 },
    { Number: "201100139", Name: "傅琦", Class: "一班", Level: "A", Score: 74 },
    { Number: "201100125", Name: "李宇珊", Class: "一班", Level: "A", Score: 76 },
    { Number: "201100137", Name: "徐晓惠", Class: "一班", Level: "A", Score: 77 },
    { Number: "201100130", Name: "陈彦菲", Class: "一班", Level: "A", Score: 80 },
    { Number: "201100131", Name: "陈嘉琪", Class: "一班", Level: "A", Score: 80 },
    { Number: "201100135", Name: "罗羡如", Class: "一班", Level: "A", Score: 80 },
    { Number: "201100142", Name: "甄晓薇", Class: "一班", Level: "A", Score: 80 },
    { Number: "201100140", Name: "彭芷晴", Class: "一班", Level: "A", Score: 82 },
    { Number: "201100133", Name: "林晓盈", Class: "一班", Level: "A", Score: 83 },
    { Number: "201100124", Name: "张晨姝", Class: "一班", Level: "A", Score: 84 },
    { Number: "201100112", Name: "赵青", Class: "一班", Level: "A", Score: 85 },
    { Number: "201100134", Name: "欧阳芷欣", Class: "一班", Level: "A", Score: 85 },
    { Number: "201100141", Name: "曾雯倩", Class: "一班", Level: "A", Score: 85 },
    { Number: "201100102", Name: "邓卓峰", Class: "一班", Level: "A", Score: 86 },
    { Number: "201100118", Name: "廖嘉俊", Class: "一班", Level: "A", Score: 87 },
    { Number: "201100101", Name: "毛艺钧", Class: "一班", Level: "A", Score: 88 },
    { Number: "201100127", Name: "李晓怡", Class: "一班", Level: "A", Score: 90 },
    { Number: "201100129", Name: "陈泳瑶", Class: "一班", Level: "A", Score: 90 },
    { Number: "201100122", Name: "吴丹琦", Class: "一班", Level: "A", Score: 92}];

    $("#dataTable").handsontable({
        data: data,
        startRows: 6,
        startCols: 8,
        colWidths: [120, 100, 60, 50, 49],
        colHeaders: ["<b>学号</b>", "<b>姓名</b>", "<b>班别</b>", "<b>成绩</b>", "<b>等级</b>"],
        contextMenu: ['remove_row', 'row_above', 'row_below'],
        columns: [{ data: "Number" }, { data: "Name" }, { data: "Class" }, { data: "Score" }, { data: "Level"}]
    });

    // Add scores
    $(function () {
        $("#dialog-modal").dialog({
            autoOpen: false,
            height: 140,
            modal: true,
            show: {
                effect: "blind",
                duration: 1000
            },
            hide: {
                effect: "explode",
                duration: 1000
            },
            buttons: {
                "保存": function () {
                    $(this).dialog("close");
                },
                "取消": function () {
                    $(this).dialog("close");
                }
            }
        });
    });

    $("#btnAddScore").click(function () {
        $("#dialog-modal").dialog("open");
    });


    // 增加列项
    $("#dialog-form").dialog({
        autoOpen: false,
        height: 200,
        width: 350,
        modal: true,
        buttons: {
            "添加": function () {
                $(this).dialog("close");
                var o = 'table.score-analysis tr:nth-child(n)';
                $(o).append('<td><span>' + $('#columName').val() + '</span></td>');
                try {
                    document.getElementById("altContent").makeLine();
                }
                catch (err) {
                    alert(err.message);
                }
            },
            "取消": function () {
                $(this).dialog("close");
            }
        },
        close: function () {

        }
    });


    $("#addColumn").click(function () {
        $("#dialog-form").dialog("open");
    });

    $("#btnPrintChart").click(function () {
        addOverLay();
        window.setTimeout(function () {
            var url = "http://" + window.location.hostname + "/capture.aspx";
            document.getElementById("altContent").exportImage(url);
        }, 3000);
    });

    $("#btnSaveChart").click(function () {
        printPanel();
    });

});