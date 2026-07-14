$(document).on 'dblclick', '#interaction-statuses-list tr.interaction-status-row', (e) ->
  interaction_status_id = $(this).attr('data-interaction-status-id')
  $.ajax 
    url: "/interaction_statuses/edit_modal",
    type: 'GET'
    dataType: 'script'
    data:
      id: interaction_status_id