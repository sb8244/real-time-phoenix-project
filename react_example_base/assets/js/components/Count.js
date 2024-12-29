/***
 * Excerpted from "Real-Time Phoenix",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
***/
import React, { useContext, useEffect, useState } from 'react'
import { PingChannelContext } from '../contexts/PingChannel'

export default function Count() {
  const [count, setCount] = useState(0)
  const { onPing } = useContext(PingChannelContext)

  useEffect(() => {
    const teardown = onPing((data) => {
      console.debug('Count pingReceived', data)
      setCount((count) => count + 1)
    })

    return teardown
  }, [])

  return (
    <div>
      <h2>Counter</h2>

      <p>
        This page displays the number of received messages, since this page was mounted.
      </p>

      <strong>{count}</strong>
    </div>
  )
}
