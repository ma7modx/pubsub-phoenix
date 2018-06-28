import socket from "./socket"
console.log("kokokooooo2")

let user_id = $(".user_id").val();
// alert(user_id)
let user_channel = socket.channel("subscription:user:" + user_id) // shouldn't be static
user_channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

user_channel.on('new_event', function (payload) { // listen to the event
  var title = payload.title || 'Null';
  var desc = payload.description || 'Null';

  console.log("title: ", title)
  console.log("desc: ", desc)
  var new_div = "<div>" + title + ": " + desc + "</div>"
  $(".notifications").append(new_div)
});