/***
 * Excerpted from "Real-Time Phoenix",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
***/
import React from 'react'

export default function Home() {
  return (
    <div>
      <h2>Home</h2>

      <p>
        The content on this page is static, and doesn't use the Channel connection. The Socket
        is disconnected when the Home page mounts.
      </p>
    </div>
  )
}
