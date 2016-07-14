//= require jquery
//= require jquery_ujs
//= require bootstrap/bootstrap
//= require angular.min
//= require jquery.ui.min
//= require bootstrap-datepicker

jQuery(document).ready ->
  
  if $('.datagrid').size() > 0
    datagrid_top = $('.datagrid').offset().top
    
    $('.datagrid thead th').each (i, el)->      
      $(el).css 'width', "#{$(el).width() + 2}px" 
    $('.datagrid tbody tr td').each (i, el)->      
      $(el).css 'width', "#{$(el).width()}px"

    $(window).scroll ->      
      if $(document).scrollTop() > datagrid_top
        $('.datagrid').addClass 'float'
      else
        $('.datagrid').removeClass 'float'
