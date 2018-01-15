function $scrollToSectionId(){
  $("a[href^='#']").click(function() {
    var id = $(this).attr('href');
    var to = "section" + id ;
    if ($(to).length) {
      $scroll(to);
  }
    else {
      window.location.href = "/" + id;
    }
})}    

function $scroll(to){
  $('html, body').animate({
    scrollTop: $(to).offset().top
  }, 1000)
  return false;
}

$(document).ready(function () {
    $scrollToSectionId();
  });