<cfscript>

public function spotlightTag(image,text,route,controller,action,key,href){
    var link = "";
    var routeString = "";
    var thisPath = ExpandPath("*.*");
    var imageFile = GetDirectoryFromPath(thisPath) & "images\spotlight\" & image;
    var imageExists = FileExists(imageFile);
    if (isDefined("arguments.controller") && !isDefined("arguments.action")){
        action = "index";
    }
    if(!isDefined("text")){
        text = "";
    }
    if (!imageExists){
        image="missingimage.jpg"
    }
    if (isDefined("href")){
        link =  linkTo(text='#imageTag("spotlight/#image#")#<br/><h4 style="text-align:center">#text#</h4>', href=href);
    }
    else if (isDefined("route") && isDefined("key")){
        routeString = "route = route, key=key";
        link =  linkTo(text='#imageTag("spotlight/#image#")#<br/><h4 style="text-align:center">#text#</h4>', route = route, key=key);
    }
    else if (isDefined("route")){
        link =  linkTo(text='#imageTag("spotlight/#image#")#<br/><h4 style="text-align:center">#text#</h4>', route = route);
    }
    else {
        link =  linkTo(text='#imageTag("spotlight/#image#")#<br/><h4 style="text-align:center">#text#</h4>', controller = controller, action = action);
    }
    return link;
}

</cfscript>