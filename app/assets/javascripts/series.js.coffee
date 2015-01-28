jQuery ->
  $('a.linkswapper').click (event) ->
    event.preventDefault()
    $('#bannerimage').toggleClass('hidden')
    $('#banner2').toggleClass('hidden')

