# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  if $('#all_chart').length
    Morris.Area({
      element: 'all_chart',
      data: $('#all_chart').data('all')
      xkey: 'created_at',
      ykeys: ['orders_count', 'quotes_count', 'purchases_count'],
      labels: ['Orders', 'Quotes', 'Purchases'],
      fillOpacity: 0.6
    });

jQuery ->
  if $('#year_chart').length
    Morris.Area({
      element: 'year_chart',
      data: $('#year_chart').data('year')
      xkey: 'created_at',
      ykeys: ['orders_count', 'quotes_count', 'purchases_count'],
      labels: ['Orders', 'Quotes', 'Purchases'],
      fillOpacity: 0.6
    });

jQuery ->
  if $('#orders_chart').length
    Morris.Area({
      element: 'orders_chart',
      data: $('#orders_chart').data('orders')
      xkey: 'created_at',
      ykeys: ['orders_count'],
      labels: ['Orders']
    });

jQuery ->
  if $('#number_of_quotes_chart').length
    Morris.Area({
      element: 'number_of_quotes_chart',
      data: $('#number_of_quotes_chart').data('quotes')
      xkey: 'created_at',
      ykeys: ['quotes_count'],
      labels: ['Quotes']
    });

jQuery ->
  if $('#number_of_purchases_chart').length
    Morris.Area({
      element: 'number_of_purchases_chart',
      data: $('#number_of_purchases_chart').data('purchases')
      xkey: 'created_at',
      ykeys: ['purchases_count'],
      labels: ['Purchases']
    });

jQuery ->
  if $('#chart-order-year').length
    Morris.Area({
      element: 'chart-order-year',
      data: $('#chart-order-year').data('order-year')
      xkey: 'created_at',
      ykeys: ['orders_count'],
      labels: ['Orders']
    });

jQuery ->
  if $('#chart-quote-year').length
    Morris.Area({
      element: 'chart-quote-year',
      data: $('#chart-quote-year').data('quote-year')
      xkey: 'created_at',
      ykeys: ['quotes_count'],
      labels: ['Quotes']
    });

jQuery ->
  if $('#chart-purchase-year').length
    Morris.Area({
      element: 'chart-purchase-year',
      data: $('#chart-purchase-year').data('purchase-year')
      xkey: 'created_at',
      ykeys: ['purchases_count'],
      labels: ['Purchases']
    });

jQuery ->
  $('.alert').hide().delay(400).slideDown(300).delay(200).effect( "highlight" )
  $('#flash_notice').hide().delay(700).fadeIn(200).delay(200).effect( "bounce" )
