// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

var dragged;

const Hooks = {
  Disk: {
    mounted() {
      this.el.addEventListener("dragstart", function( event ) {
        // store a ref. on the dragged elem
        dragged = event.target;
        // make it half transparent
        event.target.style.opacity = .7
        const rod_no = event.target.closest(".subcontainer").getAttribute("phx-value-rodno")
        console.log(rod_no)

        this.pushEvent("mark-rod", rod_no)
      }, false)

      this.el.addEventListener("dragend", function( event ) {
        // reset the transparency
        event.target.style.opacity = ""
      }, false)

    }
  },
  DropContainer: {
    mounted() {
      /* events fired on the drop targets */
      this.el.addEventListener("dragover", function( event ) {
        // prevent default to allow drop
        event.preventDefault()
      }, false)

      this.el.addEventListener("dragenter", function( event ) {
        // highlight potential drop target when the draggable element enters it
        event.target.style.background = "lightgrey"
      }, false)

      this.el.addEventListener("dragleave", function( event ) {
        // reset background of potential drop target when the draggable element leaves it
        event.target.style.background = ""
      }, false)

      this.el.addEventListener("drop", function( event ) {
        // prevent default action (open as link for some elements)
        event.preventDefault()
        // move dragged elem to the selected drop target
        event.target.style.background = ""
        const rod_no = event.target.getAttribute("phx-value-rodno")
        console.log(rod_no)
        pushEvent("mark-rod", rod_no)
      }, false)
    }
  }
}

let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks})
liveSocket.connect()
