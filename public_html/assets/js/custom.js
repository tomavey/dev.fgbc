function $scrollTo(target){
    var $ref = 'a[href$="#' + this.target + '"]';
    var $targetRef = 'section'+ '#' + this.target;
    console.log(this.$targetRef);
    $(this.$ref).click(function(){
        $('html, body').animate({
            scrollTop: $(this.$targetRef).offset().top
          }, 1000)
          return false;
          })
    }      

$(document).ready(function () {
    $('a[href$="#about"]').click(function() {
    $('html, body').animate({
      scrollTop: $("section#about").offset().top
    }, 1000)
    return false;
  }), 
    $('div.middle').click(function (){
      $('html, body').animate({
        scrollTop: $("div.bottom").offset().top
      }, 1000)
    }),
    $('div.bottom').click(function (){
      $('html, body').animate({
        scrollTop: $("div.top").offset().top
      }, 1000)
    })
  });