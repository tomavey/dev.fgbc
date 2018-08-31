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

const formatDateSpan = function(start,end) {
  let d1 = new Date(convertDateToString(start))
  let d2 = new Date(convertDateToString(end))
  let m1 = months[d1.getMonth()]
  let m2 = months[d2.getMonth()]
  let dd1 = d1.getDate()
  let dd2 = d2.getDate()
  let y = d1.getFullYear()
  if (m1 === m2) { 
    md1 = m1 + ' ' + dd1 + '-' + dd2 
  } else {
    md1 = m1 + ' ' + dd1 + '-' + m2 + '-' + dd2
  }
  return md1 + ', ' + y
}

const goTo = function(menuName) {
  this.$router.push('/' + menuName)
}

