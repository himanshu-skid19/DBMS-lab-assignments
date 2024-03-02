import { useState } from 'react';
import './LoginPage.css';

function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log("Login Submitted", { email, password });
    // Here, you would typically integrate with your authentication service
  };

  return (
    <>
      <div className="navbar">
        <a href="#">Home</a>
        {/* Add more navigation items as needed */}
      </div>
      <div className="main-content"> {/* This div should wrap around the login container */}
        <div className="login-container">
          <h2 className='head'>Examination Portal Login</h2>
          <h2> f</h2>
          <form onSubmit={handleSubmit}>
            <div>
              <label>Email:</label>
              <input className="normaltext" type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
            </div>
            <div>
              <label>Password:</label>
              <input className='normaltext' type={showPassword ? "text" : "password"} value={password} onChange={(e) => setPassword(e.target.value)} required />
            </div>
            <button type="submit">Login</button>
          </form>
          <a href="#">Forgot Password?</a>
          <a href="#">Sign up</a>
        </div>
      </div> {/* End of main-content div */}
    </>
  );
}

export default LoginPage;
