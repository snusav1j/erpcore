$(document).on 'dblclick', '#client-statuses-list tr.client-status-row', (e) ->
  client_status_id = $(this).attr('data-client-status-id')
  $.ajax 
    url: "/client_statuses/edit_modal",
    type: 'GET'
    dataType: 'script'
    data:
      id: client_status_id