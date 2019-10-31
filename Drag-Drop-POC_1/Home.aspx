﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Drag_Drop_POC.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="//jqueryui.com/jquery-wp-content/themes/jquery/css/base.css?v=1">
    <link rel="stylesheet" href="//jqueryui.com/jquery-wp-content/themes/jqueryui.com/style.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">

    <style>
        #gallery {
            float: left;
            width: 65%;
            min-height: 12em;
        }

        .gallery.custom-state-active {
            background: #eee;
        }

        .gallery li {
            float: left;
            width: 96px;
            padding: 0.4em;
            margin: 0 0.4em 0.4em 0;
            text-align: center;
        }

            .gallery li h5 {
                margin: 0 0 0.4em;
                cursor: move;
            }

            .gallery li a {
                float: right;
            }

                .gallery li a.ui-icon-zoomin {
                    float: left;
                }

            .gallery li img {
                width: 100%;
                cursor: move;
            }

        .container {
            float: right;
            width: 32%;
            min-height: 10em;
            padding: 1%;
        }

            .container h4 {
                line-height: 16px;
                margin: 0 0 0.4em;
            }

                .container h4 .ui-icon {
                    float: left;
                }

            .container .gallery h5 {
                display: none;
            }

        /* ask */
        .main-container div {
            width: 100%;
            margin: 0px 5px 0px 5px;
            background-color: #ddd;
            border-color: bisque;
            border: 1px;
            border-style: solid;
        }

        .w3-code {
            width: auto;
            background-color: #fff;
            padding: 8px 12px;
            border-left: 4px solid #4CAF50;
            word-wrap: break-word;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <table id="example" class="display" style="width: 100%">
            <thead>
                <tr>
                    <th>StudentId</th>
                    <th>Name</th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="tlist"></tbody>
        </table>


        <ul id="gallery" class="gallery ui-helper-reset ui-helper-clearfix">
            <li class="ui-widget-content ui-corner-tr">[ashish kadam]</li>
            <li class="ui-widget-content ui-corner-tr">[Mansi kadam]</li>
        </ul>

        <button id="btnAddRow" type="button">Add Row</button>
        <div class="main-container">
            <div id="trash1" class="container ui-widget-content ui-state-default">
                <h4 class="ui-widget-header">Row 1</h4>
            </div>
        </div>
    </form>
    <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    s
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(document).ready(function () {

            $gallery = $("#gallery");
            $trash = $(".container");
            var table, data, $gallery;
            //var $list = $("ul", $trash).length ?
            //    $("ul", $trash) :
            //    $("<ul class='gallery ui-helper-reset'/>").appendTo($trash);

            var content = '<ul id="gallery" class="gallery ui-helper-reset ui-helper-clearfix"> <li class="ui-widget-content ui-corner-tr"> [ashish kadam]</li></ul>';

            $.ajax({
                type: "POST",
                url: "home.aspx/GetData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var s = jQuery.parseJSON(response.d);
                    $.map(s, function (val, i) {
                        $("#tlist").append("<tr><td>" + val["StudentId"] + "</td> <td> " + val["FullName"] + "</td ><td></td></tr>")
                             
                    });

                    table = $('#example').DataTable({
                        "columnDefs": [{
                            "targets": -1,
                            "data": null,
                            "defaultContent": "<button type='button'>Click!</button>"
                        }]
                    });
                },
                failure: function (response) {
                    alert(response.d);
                }
            });


            $('#example tbody').on('click', 'button', function () {
                data = table.row($(this).parents('tr')).data();
                // alert(data[0] + "'s id is: " + data[1]);
                $('#trash1').append(content);
                $("li").draggable({
                    cancel: "a.ui-icon", // clicking an icon won't initiate dragging
                    revert: "invalid", // when not dropped, the item will revert back to its initial position
                    containment: "document",
                    helper: "clone",
                    cursor: "move"
                });
               
            });


            //
            $gallery = $("#gallery"),
                $trash = $(".container");

            // Let the gallery items be draggable
            $("li", $gallery).draggable({
                cancel: "a.ui-icon", // clicking an icon won't initiate dragging
                revert: "invalid", // when not dropped, the item will revert back to its initial position
                containment: "document",
                helper: "clone",
                cursor: "move"
            });

            // Let the trash be droppable, accepting the gallery items
            $trash.droppable({
                // accept: "#gallery > li",
                classes: {
                    "ui-droppable-active": "ui-state-highlight"
                },
                drop: function (event, ui) {
                    $trash = $(this).closest('.container');
                    deleteImage(ui.draggable);
                }
            });

            // Let the gallery be droppable as well, accepting items from the trash
            $gallery.droppable({
                accept: "#trash li",
                classes: {
                    "ui-droppable-active": "custom-state-active"
                },
                drop: function (event, ui) {
                    // recycleImage( ui.draggable );
                }
            });


            // Image deletion function
            var recycle_icon = "";//"<a href='link/to/recycle/script/when/we/have/js/off' title='Recycle this image' class='ui-icon ui-icon-refresh'>Recycle image</a>";
            function deleteImage($item) {
                $item.fadeOut(function () {
                    var $list = $("ul", $trash).length ?
                        $("ul", $trash) :
                        $("<ul class='gallery ui-helper-reset'/>").appendTo($trash);

                    $item.find("a.ui-icon-trash").remove();
                    // $item.append( recycle_icon ).appendTo( $list ).fadeIn(function() {
                    $item.appendTo($list).fadeIn(function () {
                        $item
                            .animate({ width: "48px" })
                            .find("img")
                            .animate({ height: "36px" });
                    });
                });
            }

            // Image recycle function
            var trash_icon = "<a href='link/to/trash/script/when/we/have/js/off' title='Delete this image' class='ui-icon ui-icon-trash'>Delete image</a>";
            function recycleImage($item) {
                $item.fadeOut(function () {
                    $item
                        .find("a.ui-icon-refresh")
                        .remove()
                        .end()
                        .css("width", "96px")
                        .append(trash_icon)
                        .find("img")
                        .css("height", "72px")
                        .end()
                        .appendTo($gallery)
                        .fadeIn();
                });
            }

            // Resolve the icons behavior with event delegation
            $("ul.gallery > li").on("click", function (event) {
                var $item = $(this),
                    $target = $(event.target);

                if ($target.is("a.ui-icon-trash")) {
                    deleteImage($item);
                } else if ($target.is("a.ui-icon-zoomin")) {
                    viewLargerImage($target);
                } else if ($target.is("a.ui-icon-refresh")) {
                    recycleImage($item);
                }

                return false;
            });

            $('#btnAddRow').click(function () {
                var divCount = $('.main-container > div').length + 1;
                var content = '<div id="trash' + divCount + '" class="container ui-widget-content ui-state-default"> <h4 class="ui-widget-header"> Row ' + divCount + '</h4> </div> </div>'
                $('.main-container').append(content)
                $('.container').droppable({
                    // accept: "#gallery > li",
                    classes: {
                        "ui-droppable-active": "ui-state-highlight"
                    },
                    drop: function (event, ui) {
                        $trash = $(this).closest('.container');
                        deleteImage(ui.draggable);
                    }
                });

                function deleteImage($item) {
                    $item.fadeOut(function () {
                        var $list = $("ul", $trash).length ?
                            $("ul", $trash) :
                            $("<ul class='gallery ui-helper-reset'/>").appendTo($trash);

                        $item.find("a.ui-icon-trash").remove();
                        // $item.append( recycle_icon ).appendTo( $list ).fadeIn(function() {
                        $item.appendTo($list).fadeIn(function () {
                            $item
                                .animate({ width: "48px" })
                                .find("img")
                                .animate({ height: "36px" });
                        });
                    });
                }


            })

        });


    </script>


</body>
</html>
