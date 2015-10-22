# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#sent_email_user_email').autocomplete
    source: $('#sent_email_user_email').data('autocomplete-source')

$ ->
  $('#sent_email_prospect_email').autocomplete
    source: $('#sent_email_prospect_email').data('autocomplete-source')

$ ->
  $('#sent_email_inhouse_customer_email').autocomplete
    source: $('#sent_email_inhouse_customer_email').data('autocomplete-source')

