$(document).on 'dblclick', '#interaction-types-list tr.interaction-type-row', (e) ->
  interaction_type_id = $(this).attr('data-interaction-type-id')
  $.ajax 
    url: "/interaction_types/edit_modal",
    type: 'GET'
    dataType: 'script'
    data:
      id: interaction_type_id