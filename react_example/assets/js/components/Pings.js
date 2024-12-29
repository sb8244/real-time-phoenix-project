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

export default function Pings(props) {
  const topic = props.topic || 'ping'
  const [messages, setMessages] = useState([])
  const { onPing, sendPing } = useContext(PingChannelContext) 

  const appendDataToMessages = (data) =>
    setMessages((messages) => [ 
      JSON.stringify(data),
      ...messages
    ])

  useEffect(() => {
    const teardown = onPing((data) => { 
      console.debug('Pings pingReceived', data)
      appendDataToMessages(data)
    })

    return teardown 
  }, [])

  return (
    <div>
      <h2>Pings: {topic}</h2>

      <p>
        This page displays the PING messages received from the
        server, since this page was mounted. The topic
        for this Channel is {topic}.
      </p>

      <button onClick={
        () => sendPing(appendDataToMessages)
      }>Press to send a ping</button>

      <textarea value={messages.join('\n')} readOnly />
    </div>
  )
}
