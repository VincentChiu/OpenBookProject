DESELEMENT = "h1,h2,h3,h4,ul,div.section p,div.highlight-python";

function clean_tag(st){
    return st.replace(/<[^>]+>?[^<]*>/g, '');
}
function adjust_bar(){
    $("div#gc-collapsible").height($("div.documentwrapper").height());
}
function update_cmt(){
    $("div.comment").css("left", $("div.document").offset().left+$("div.body").width()+50);
}
$(document).ready(function(){
    $("div.body > div.section").find(DESELEMENT).each(function(){
        if (!$(this).prev("div.comment").length) {
            $(this).before('<div class="comment"><a class="email_link" title="groups"><div></div></a></div>');
            if (COMMENT_POSITION==null) {
                update_cmt();
                $(window).resize(function(){
                    update_cmt();
                }); 
            } else {
                $("div.comment").css("left", $("div.document").offset().left+COMMENT_POSITION);
            }
        }
    });
    
    $("a.email_link").hover(function(){
        if ($(this).attr("href") == null||$(this).attr("href") == '') {
            var sub = $("div.documentwrapper div.body div.section:first h1").html();
            var body = $(this).parent("div.comment").next().html();
            sub = clean_tag(sub)+' version: '+DOCUMENTATION_OPTIONS.VERSION;
            body = clean_tag(body);
            if (body.length>100) {
                body = body.substring(0, 100)+"...";
            }
            //091117:Zoomq change comment dir
            //http://groups.google.com/group/openbookproject
            //http://groups.google.com/group/obp-comment
            $(this).attr("href", "http://groups.google.com/group/obp-comment/post?hl=zh-CN&subject="+encodeURIComponent(sub)+"&body="+encodeURIComponent(body));
            $(this).attr("target", "_blank");
        }
    }, function(){
    });
    
    $("div#gc-collapsible").hover(function(){
        $(this).addClass("hover");
    }, function(){
        $(this).removeClass("hover");
    });
    adjust_bar();
    $("div#gc-collapsible").toggle(function(){
        $("div.sphinxsidebar").hide();
        $("div.bodywrapper").css("margin-left", 2);
        adjust_bar();
    }, function(){
        $("div.bodywrapper").css("margin-left", 200);
        $("div.sphinxsidebar").show();
        adjust_bar();
    });
});

