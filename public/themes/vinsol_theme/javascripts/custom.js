// for showing different section of consult and project on contact form

var contact_form = {
  
  init : function(){
    $('#new_contact #radio_select input').prop('checked', false);
    
    $('.formSubmit').click(function(event){
      event.preventDefault();
    });
    
    
    $('#new_contact #radio_select input[type=radio]').each(function(){
      if ($(this).is(':checked')) {
    	  var value = $(this).val();
    		switch_consult_project(value, false);
      }
    });

    $('#new_contact #radio_select input[type=radio]').change(function() {
      var value = $(this).val();
      $('div#myModal #new_contact #radio_select input[value='+value+']').click();
      switch_consult_project(value, true);
    });


    function switch_consult_project(value, check){
      var selectedLabel = $('#new_contact #radio_select label#'+value);
      $('#new_contact #radio_select').find('label').removeClass('selected_label');
      selectedLabel.addClass('selected_label')
      $('#new_contact div.project').hide();
      $('#new_contact div.common').removeClass('f-right');
      $('.projectDiv').hide();  
      $('.consultDiv').show();
      if(value == "project") {
        $('#new_contact div.project').show();
        $('#new_contact div.common').addClass('f-right');
        $('.projectDiv').show();  
        $('.consultDiv').hide();
      }
      $('#new_contact div.common').show();
      if(check) {
        $('span#budget_errors').html("")
        $('span#comment_errors').html("")
        $('span#file_errors').html("")
      }
    }

    $('.projectDiv, .consultDiv').click(function(){
      var actLabel = $(this).siblings('label');
      var actRadio = $(this).siblings('input[type=radio]')
      actLabel.removeClass('selected_label');
      $('#new_contact div.project, #new_contact div.common').hide();
      actRadio.prop('checked', false);
      $(this).hide();
    });
  }
  
  
};