const convertDateToString = function (date) {
  return date.toString().replace('{ts ', '').replace('}', '').replace(' 00:00:00', '')
}

const formatDate = function (value) {
  let oldDate = value.toString()
  oldDate = oldDate.replace('{ts ', '').replace('}', '').replace(' 00:00:00', '')
  var d = new Date(oldDate)
  console.log(months[d.getMonth()])
  return months[d.getMonth()] + d.getDate() + d.getFullYear()
}
