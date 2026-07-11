window.addTableColumn = (entity, column) ->

  table = $("table[data-entity='#{entity}']")


  table.find('thead tr').each ->

    staticTh = $(this).find('th.static-position')

    $("<th>")
      .attr('data-column-key', column.key)
      .text(column.label)
      .insertBefore(staticTh)


  table.find('tbody tr').each ->

    row = $(this)

    id = row.data('client-id')

    cell = column.cells.find (item) ->
      item.id == id

    staticTd = row.find('td.static-position')

    $("<td>")
      .attr('data-column-key', column.key)
      .text(cell?.value || '')
      .insertBefore(staticTd)

window.updateTableColumn = (entity, column) ->

  table = $("table[data-entity='#{entity}']")


  table.find("thead th[data-column-key='#{column.key}']")
    .text(column.label)


  table.find('tbody tr').each ->

    row = $(this)

    id = row.data('client-id')

    cell = column.cells.find (item) ->
      item.id == id


    row.find("td[data-column-key='#{column.key}']")
      .text(cell?.value || '')