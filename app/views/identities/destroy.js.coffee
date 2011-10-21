$('#<%= dom_id(@identity) %>')
  .fadeOut ->
    $(this).remove()
