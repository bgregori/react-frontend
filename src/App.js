import React from 'react';
import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          API_URL: {window._env_.API_URL}
        </p>
        <a
          className="App-link"
          href="https://learn.openshift.com"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn OpenShift
        </a>
      </header>
    </div>
  );
}

export default App;
