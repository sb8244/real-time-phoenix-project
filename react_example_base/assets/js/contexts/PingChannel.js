/***
 * Excerpted from "Real-Time Phoenix",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
***/
import React, { createContext, useContext, useEffect, useRef, useState } from 'react'
import { SocketContext } from './Socket'

export const PingChannelContext = createContext({})

export default function PingChannel({ topic, children }) {
  const socket = useContext(SocketContext)
  const [pingChannel, setPingChannel] = useState(null)
  const pingSubscriptions = useRef([])

  useEffect(() => {
    if (socket && !pingChannel) {
      const channel = socket.channel(topic)

      channel.on('ping', (data) => {
        pingSubscriptions.current.forEach((fn) => {
          fn(data)
        })
      })

      console.debug('Joining channel', topic)
      channel.join().receive('error', () => {
        console.error('PingChannel join failed', topic)
      })

      setPingChannel(channel)
    }

    return () => {
      if (pingChannel) {
        console.debug('Leaving channel', topic)
        pingChannel.leave()
        setPingChannel(null)
      }
    }
  }, [socket, pingChannel, pingSubscriptions])

  return (
    <PingChannelContext.Provider value={{
      onPing: onPingSubscription(pingSubscriptions),
      sendPing: sendPing(pingChannel)
    }}>
      {children}
    </PingChannelContext.Provider>
  )
}

function onPingSubscription(pingSubscriptions) {
  return (fn) => {
    pingSubscriptions.current = [fn, ...pingSubscriptions.current]

    return () => {
      const newSubs = pingSubscriptions.current.filter((pingFn) => fn !== pingFn)
      pingSubscriptions.current = newSubs
    }
  }
}

function sendPing(pingChannel) {
  return (fn) => {
    if (pingChannel) {
      pingChannel.push('ping', {})
        .receive('ok', fn)
        .receive('error', (resp) => console.error('Ping error', resp))
        .receive('timeout', () => console.error('Ping timeout'))
    } else {
      console.error('Channel not connected')
    }
  }
}
