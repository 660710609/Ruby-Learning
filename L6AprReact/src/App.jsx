import { Link, Routes, Route, Navigate, useNavigate } from 'react-router-dom'
import './App.css'
import { useEffect, useState } from 'react'
import axios from 'axios'
import Signin from './components/Signin'
import Register from './components/Register'

function App() {
  const [user, setUser] = useState(null)
  const [userData, setUserData] = useState(null)
  const navigate = useNavigate()
  useEffect(() => {
    const checkLogin = async () => {
      const token = localStorage.getItem('token')
      if (token) {
        try {
          const res = await axios.get("http://localhost:3000/api/v1/user/me",
            {
              headers: {
                "auth-token": `Bearer ${token}`,
                "Accept": "application/json"
              }
            }
          )
          if (res.data.success) {
            setUserData(res.data.user)
            setUser({ Signin: true })
          }
        } catch (err) {
          console.log(err)
          localStorage.removeItem('token')
        }
      }
    }
    checkLogin()
  }, [])

  const handleLogin = (data) => {
    setUserData(data)
    setUser({ Signin: true })
    navigate('/')
  }

  const handleLogout = async () => {
    const token = localStorage.getItem('token')
    if (token) {
      try {
        const res = await axios.post("http://localhost:3000/api/v1/user/sign_out",
          {},
          {
            headers: {
              "auth-token": `Bearer ${token}`,
              "Accept": "application/json"
            }
          })

        if (res.data.success) {
          setUserData({})
          setUser()
          navigate('/Signin')
        }
      } catch (err) {
        console.log(err)
      }
    }
  }

  return (
    <div className='App'>
      <nav className="bt1">
        <Link to="/"><button>Home</button></Link>
        {!user && <Link to="/Signin"><button>Sign In</button></Link>}
        {!user && <Link to="/Register"><button>Register</button></Link>}
      </nav>
      <Routes>
        <Route path="/" element={<></>}></Route>
        <Route path="/Signin" element={<Signin onLoginSuccess={handleLogin}></Signin>}></Route>
        <Route path="/Register" element={<Register></Register>}></Route>
      </Routes>
      {user &&
        <div className='profile'>
          <div className='photo'><area></area></div>
          <p>Welcome ! ! ! {userData.first_name}</p>
          <button onClick={handleLogout}>Logout</button>
        </div>}
    </div>
  )
}

export default App
