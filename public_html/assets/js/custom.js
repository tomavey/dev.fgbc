function $scrollFromTo(id=""){
  var from = "a[href$='#" + id + "']";
  var to = "section#" + id;
  var $from = $(from);
  var $to = $(to);
  $from.click(function() {
    $('html, body').animate({
      scrollTop: $to.offset().top
    }, 1000)
    return false;
  })}    

$(document).ready(function () {
    $scrollFromTo('about');
    $scrollFromTo('news');
  });