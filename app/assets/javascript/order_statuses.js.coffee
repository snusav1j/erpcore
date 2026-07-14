$(document).on 'dblclick', '#order-statuses-list tr.order-status-row', (e) ->
  order_status_id = $(this).attr('data-order-status-id')
  $.ajax 
    url: "/order_statuses/edit_modal",
    type: 'GET'
    dataType: 'script'
    data:
      id: order_status_id