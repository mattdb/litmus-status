
ready(function() {
  var timeTags = document.querySelectorAll('.timestamp time')
  Array.prototype.forEach.call(timeTags, function(timeTag, i) {
    var timestamp = timeTag.getAttribute('datetime')
    if (timestamp) {
      var localDate = new Date(timestamp)
      timeTag.setAttribute('title', localDate.toString())
    }
  })
})
