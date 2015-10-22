$ ->
  $('#inhouse_customer_name').autocomplete
    source: '/admin/inhouse_customers'
    #source: $('#inhouse_customer_email').data('autocomplete_source')

$ ->
  $('#inhouse_customer_email').autocomplete
    source: '/admin/inhouse_customers'