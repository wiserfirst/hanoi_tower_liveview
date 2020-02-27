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
import LiveSocket from "phoenix_live_view"

const getRodNo = event => event.target.closest(".subcontainer").getAttribute("data-rodno")

const Hooks = {
  Disk: {
    mounted() {
      this.el.addEventListener("dragstart", event => {
        // make it half transparent
        event.target.style.opacity = .7
        const rod_no = getRodNo(event)
        event.dataTransfer.setData("text/plain", rod_no)
      }, false)

      this.el.addEventListener("dragend", event => {
        // reset the transparency
        event.target.style.opacity = ""
      }, false)
    }
  },
  DropContainer: {
    mounted() {
      /* events fired on the drop targets */
      this.el.addEventListener("dragover", event => {
        // prevent default to allow drop
        event.preventDefault()
      }, false)

      this.el.addEventListener("dragenter", event => {
        // highlight potential drop target when the draggable element enters it
        event.target.style.background = "lightgrey"
      }, false)

      this.el.addEventListener("dragleave", event => {
        // reset background of potential drop target when the draggable element leaves it
        event.target.style.background = ""
      }, false)

      this.el.addEventListener("drop", event => {
        // prevent default action (open as link for some elements)
        event.preventDefault()
        // move dragged elem to the selected drop target
        event.target.style.background = ""
        const from_rod_no = event.dataTransfer.getData("text/plain")
        const to_rod_no = getRodNo(event)
        this.pushEvent("move-disk", {from: from_rod_no, to: to_rod_no})
      }, false)
    }
  }
}

let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks})
liveSocket.connect()
