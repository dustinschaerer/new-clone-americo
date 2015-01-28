
jQuery ->
  colors = $('#upholsterycut_color_id').html();
  $('#upholsterycut_series_id').change ->
    series = $('#upholsterycut_series_id :selected').text()
    options = $(colors).filter("optgroup[label='#{series}']").html()
    if options
      $('#upholsterycut_color_id').html(options)
    else
      $('#upholsterycut_color_id').empty()