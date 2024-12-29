/***
 * Excerpted from "Real-Time Phoenix",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/sbsockets for more book information.
***/
import css from "../css/app.css"
import React from 'react'
import ReactDOM from 'react-dom'
import {
  BrowserRouter as Router,
  Link
} from 'react-router-dom'

import Routes from './Routes'

export default function App() {
  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li>
              <Link to='/'>Home</Link>
            </li>
            <li>
              <Link to='/pings'>Pings</Link>
            </li>
            <li>
              <Link to='/other'>Other Pings</Link>
            </li>
            <li>
              <Link to='/count'>Counter</Link>
            </li>
          </ul>
        </nav>

        <Routes />
      </div>
    </Router>
  )
}

ReactDOM.render(<App />, document.getElementById('root'))
