// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"
console.log("kokokooooo")

let user_channel = socket.channel("subscription:user:1") // shouldn't be static
user_channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

user_channel.on('new_event', function (payload) { // listen to the event
  var title = payload.title || 'Null';
  var desc = payload.description || 'Null';

  console.log("title: ", title)
  console.log("desc: ", desc)
  var new_div = "<div>" + title + ": " + desc + "</div>"
  $(".events-container").append(new_div)
});
