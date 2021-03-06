jQuery ->
  replyString = '\nCustomer Response:'
  text = $("#quote_question").val()
  $("#quote_question").val($("#quote_question").val() + replyString)
  $("#quote_question").focus()

jQuery ->
  regions = $('#quote_ship_state').html()
  $('#quote_ship_country').change ->
    country = $('#quote_ship_country :selected').text()
    options = $(regions).filter("optgroup[label='#{country}']").html()
    if options
      $('#quote_ship_state').html(options)
      $('#quote_ship_state').prepend('<option selected="selected">Please select...</option>')
    else
      $('#quote_ship_state').empty()