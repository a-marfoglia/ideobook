function removeDiv(name) {
  object = $("."+name);
  object.remove();
}

$(document).ready(function(){
  $('[data-toggle="popover"]').popover();
});
