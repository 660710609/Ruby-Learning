import "./Signin.css"
function Register(){
    return (
        < div className="box" >
            <div className="subbox">
                <p> Register Page </p>
                <form>
                    <div>
                        <label>First Name : </label>
                        <input type="text" name='first_name' required/>
                    </div>
                    <div>
                        <label>Last Name : </label>
                        <input type="text" name="last_name"  required/>
                    </div>
                    <div>
                        <label>Email : </label>
                        <input type="email" name='email' required />
                    </div>
                    <div>
                        <label>Password : </label>
                        <input type="password" name='password' required />
                    </div>
                    <button type='submit'>Sign in</button>
                </form>
            </div>
        </div >
    )
}

export default Register