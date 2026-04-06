import axios from "axios"
import "./Signin.css"
import { useState } from "react"

const Signin = ({ onLoginSuccess }) => {
    const [credentials , setCredentials] = useState({email: '' , password: ''})
    const [error , setError] = useState('');

    const handleChange = (e) => {
        setCredentials({...credentials , [e.target.name]: e.target.value})
    }

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        try{
            const response = await axios.post('http://localhost:3000/api/v1/user/sign_in' , {
                user: credentials
            })

            if (response.data.success){
                localStorage.setItem('token' , response.data.user.jwt)
                const userdata = response.data.user
                onLoginSuccess(userdata)
            }
        } catch(err){
            setError(err.response?.data?.error);
        }
    }

    return (
        < div className="box" >
            <div className="subbox">
                <p> Login Page </p>
                {error && <p style={{color: 'red'}}>{error}</p>}
                <form onSubmit={handleSubmit}>
                    <div>
                        <label>Email : </label>
                        <input type="email" name='email' onChange={handleChange} required />
                    </div>
                    <div>
                        <label>Password : </label>
                        <input type="password" name='password' onChange={handleChange} required />
                    </div>
                    <button type='submit'>Sign in</button>
                </form>
            </div>
        </div >
    )
}

export default Signin