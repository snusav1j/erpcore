$(document).on 'dblclick', '#client-types-list tr.client-type-row', (e) ->
  client_type_id = $(this).attr('data-client-type-id')
  $.ajax 
    url: "/client_types/edit_modal",
    type: 'GET'
    dataType: 'script'
    data:
      id: client_type_id