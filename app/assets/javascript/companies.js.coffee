$(document).on 'dblclick', '#companies-list tr.company-row', (e) ->
  company_id = $(this).attr('data-company-id')
  $.ajax 
    url: "/companies/edit_modal",
    type: 'GET'
    dataType: 'script'
    data:
      id: company_id