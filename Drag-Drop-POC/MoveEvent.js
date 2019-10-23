{
    $gallery = $(".container"),
        $trash = $(".container");

    // Let the gallery items be draggable
    //$("li", $gallery).draggable({
    //    cancel: "a.ui-icon", // clicking an icon won't initiate dragging
    //    revert: "invalid", // when not dropped, the item will revert back to its initial position
    //    containment: "document",
    //    helper: "clone",
    //    cursor: "move"
    //});

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
}