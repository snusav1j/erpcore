$(document).on 'dblclick', '#products-list tr.product-row', (e) ->
  product_id = $(this).attr('data-product-id')
  $.ajax 
    url: "/products/edit_modal",
    type: 'GET'
    dataType: 'script'
    data:
      id: product_id