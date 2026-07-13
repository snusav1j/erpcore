window.addTableColumn = (entity, column) ->

  table = $("table[data-entity='#{entity}']")


  table.find('thead tr').each ->

    th = $("<th>")
      .attr('data-column-key', column.key)
      .text(column.label)


    insertColumn(
      $(this),
      th,
      column.position
    )


  table.find('tbody tr').each ->

    row = $(this)

    id = row.data('client-id')

    cell = column.cells.find (item) ->
      item.id == id


    td = $("<td>")
      .attr('data-column-key', column.key)
      .text(cell?.value || '')


    insertColumn(
      row,
      td,
      column.position
    )



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



insertColumn = (row, element, position) ->

  staticElement = row.find('.static-position')


  columns = row.children().not('.static-position')


  # если позиции нет или она больше количества колонок
  # вставляем перед static-position как раньше

  if !position or position > columns.length

    staticElement.before(element)

    return


  target = columns.eq(position - 1)


  target.before(element)